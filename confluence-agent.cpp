#include "confluence-agent.h"

#include "branchitem.h"
#include "mainwindow.h"
#include "misc.h"
#include "vymmodel.h"


extern Main *mainWindow;
extern QDir vymBaseDir;
extern bool debug;

ConfluenceAgent::ConfluenceAgent ()
{
    killTimer = NULL;

    confluenceScript = vymBaseDir.path() + "/scripts/confluence.rb";

    killTimer = new QTimer(this); 
    killTimer->setInterval(10000); 
    killTimer->setSingleShot(true); 

    vymProcess = NULL;  // Only one process may be active at any time in this agent

    QObject::connect(killTimer, SIGNAL(timeout()), this, SLOT(timeout()));

    succ = false;
}

ConfluenceAgent::~ConfluenceAgent ()
{
    if (killTimer) delete killTimer;
}

void ConfluenceAgent::test()
{
    QStringList args;

    args << "-h";

    qWarning() << "ConfluenceAgent::test() called";

    vymProcess->start (confluenceScript, args);

    if (!vymProcess->waitForStarted())
    {
	qWarning() << "ConfluenceAgent::test()  couldn't start " << confluenceScript;
	return; 
    }

    killTimer->start();
}

bool ConfluenceAgent::getPageDetails(const QString &url)
{
    QStringList args;

    args << "-d";
    args << url;

    if (debug) 
        qDebug().noquote() << QString("ConfluenceAgent::getPageDetails\n%1 %2").arg(confluenceScript).arg(args.join(" "));

    vymProcess = new VymProcess;

    connect (vymProcess, SIGNAL (finished(int, QProcess::ExitStatus) ), 
	this, SLOT (dataReceived(int, QProcess::ExitStatus) ));

    vymProcess->start (confluenceScript, args);

    if (!vymProcess->waitForStarted())
    {
	qWarning() << "ConfluenceAgent::getPageDetails  couldn't start " << confluenceScript;
	return false; 
    } 

    return true;
}

bool ConfluenceAgent::uploadContent(const QString &url, const QString &title, const QString &fpath, const bool &newPage)
{
    QStringList args;

    if (newPage)
        args << "-c";
    else
        args << "-u";
    args << url;
    args << "-f";
    args << fpath;
    if (!title.isEmpty())
    {
        args << "-t";
        args << title;
    }

        qDebug().noquote() << QString("ConfluenceAgent::uploadContent\n%1 %2").arg(confluenceScript).arg(args.join(" "));

    if (debug)  qDebug() << "  newPage: " << newPage;  

    vymProcess = new VymProcess;

    connect (vymProcess, SIGNAL (finished(int, QProcess::ExitStatus) ), 
	this, SLOT (dataReceived(int, QProcess::ExitStatus) ));

    vymProcess->start (confluenceScript, args);

    if (!vymProcess->waitForStarted())
    {
	qWarning() << "ConfluenceAgent::uploadContent  couldn't start " << confluenceScript;
	return false; 
    } 

    return true;
}

bool ConfluenceAgent::updatePage(const QString &url, const QString &title, const QString &fpath)
{
    return uploadContent (url, title, fpath, false);
}

bool ConfluenceAgent::createPage(const QString &url, const QString &title, const QString &fpath)
{
    return uploadContent (url, title, fpath, true);
}

bool ConfluenceAgent::getUsers(const QString &name)
{
    QStringList args;   // FIXME-0 refactor so that args are passed to one function starting the process

    args << "-s";
    args << name;

    if (debug)  
        qDebug().noquote() << QString("ConfluenceAgent::getUsers\n%1 %2").arg(confluenceScript).arg(args.join(" "));

    vymProcess = new VymProcess;

    connect (vymProcess, SIGNAL (finished(int, QProcess::ExitStatus) ), 
	this, SLOT (dataReceived(int, QProcess::ExitStatus) ));

    vymProcess->start (confluenceScript, args);

    if (!vymProcess->waitForStarted())
    {
	qWarning() << "ConfluenceAgent::getUsers  couldn't start " << confluenceScript;
	return false; 
    } 

    return true;
}

void ConfluenceAgent::waitForResult()   
{
    if (!vymProcess) 
    {
        qWarning() << "ConfluenceAgent: No running vymProces";
        return;
    }
    if (!vymProcess->waitForFinished( 10000 ) )
    {
        qWarning() << "ConfluenceAgent: Timeout.";
        return;
    }
}

bool ConfluenceAgent::success()
{
    return succ;
}

QString ConfluenceAgent::getResult()
{
    return result;
}


bool ConfluenceAgent::dataReceived(int exitCode, QProcess::ExitStatus exitStatus)    // FIXME-0  return value???   // FIXME-0  name correct? used by all functions...
{
    if (exitStatus == QProcess::NormalExit)
    {
	result = vymProcess->getStdout();

	QString err = vymProcess->getErrout();
	if (!err.isEmpty())
        {
	    qWarning() << "ConfluenceAgent process error: \n" << err;
        } else 
        {
            if (!result.startsWith("Error")) succ = true;
        }
            
    } else	
	qWarning() << "ConfluenceAgent: Process finished with exitCode=" << exitCode;
    vymProcess = NULL;

    return succ;
}

void ConfluenceAgent::timeout()
{
    qWarning() << "ConfluenceAgent timeout!";
    // delete (vymProcess);  // FIXME-0  crashes...
    vymProcess = NULL;
}
    
