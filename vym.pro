TARGET	    = vym
TEMPLATE    = app
LANGUAGE    = C++

CONFIG	+= qt warn_on x86_64 



QT += network 
QT += xml 
QT += script 
QT += svg 
QT += printsupport
QT += widgets

#  include(tmp/modeltest/modeltest.pri)

RESOURCES = vym.qrc

unix:!macx:isEmpty(NO_DBUS) {
    message("Compiling with DBUS")
    DEFINES += VYM_DBUS
    QT      += dbus 
    HEADERS += adaptormodel.h adaptorvym.h 
    SOURCES += adaptormodel.cpp adaptorvym.cpp 
}

win32 {
    HEADERS += mkdtemp.h
    SOURCES += mkdtemp.cpp
    RC_FILE = vym.rc
    # Manifest embedding was suggested by Qt docs somewhere...
    win32: CONFIG += embed_manifest_exe

    # Without this, M_PI, and M_PI_2 won`t be defined.
    win32:DEFINES *= _USE_MATH_DEFINES

    QT_QPA_PLATFORM_PLUGIN_PATH=%QTDIR%\plugins\platforms\
}


TRANSLATIONS += lang/vym.de_DE.ts
TRANSLATIONS += lang/vym.el.ts
TRANSLATIONS += lang/vym.en.ts
TRANSLATIONS += lang/vym.es.ts
TRANSLATIONS += lang/vym.fr.ts
TRANSLATIONS += lang/vym.hr_HR.ts
TRANSLATIONS += lang/vym.ia.ts
TRANSLATIONS += lang/vym.it.ts
TRANSLATIONS += lang/vym.ja.ts
TRANSLATIONS += lang/vym.pt_BR.ts
TRANSLATIONS += lang/vym.ru.ts
TRANSLATIONS += lang/vym.sv.ts
TRANSLATIONS += lang/vym.zh_CN.ts
TRANSLATIONS += lang/vym.zh_TW.ts
TRANSLATIONS += lang/vym.cs_CZ.ts

ICON =icons/vym.icns


HEADERS	+= \
    aboutdialog.h \
    codeeditor.h \
    taskfiltermodel.h \
    animpoint.h \
    arrowobj.h \
    attribute.h \
    attributeitem.h \
#   attributedelegate.h\
#   attributedialog.h \
#   attributewidget.h \
    branchitem.h \
    branchobj.h \
    branchpropeditor.h\
    bug-agent.h \
    command.h \
    confluence-agent.h \
    dockeditor.h \
    download-agent.h \
    editxlinkdialog.h \
    exportoofiledialog.h \
    export-html-dialog.h\
    export-confluence-dialog.h\
    export-ao.h \
    export-ascii.h \
    export-base.h \
    export-csv.h \
    export-confluence.h \
    export-html.h \
    export-impress.h \
    export-latex.h \
    export-markdown.h \
    export-orgmode.h \
    export-taskjuggler.h \
    extrainfodialog.h \
    file.h \
    findwidget.h \
    findresultwidget.h \
    findresultitem.h \
    findresultmodel.h \
    flag.h \
    flagobj.h \
    flagrowobj.h \
    flagrow.h \
    floatimageobj.h \
    floatobj.h \
    frameobj.h \
    geometry.h \
    heading.h \
    headingeditor.h \
    headingobj.h \
    highlighter.h \
    historywindow.h \
    imageitem.h \
    imageobj.h \
    imports.h \
    jira-agent.h \
    lineeditdialog.h \
    linkablemapobj.h \
    lockedfiledialog.h \
    macros.h \
    mainwindow.h \
    mapeditor.h \
    mapitem.h \
    mapobj.h \
    misc.h \
    mysortfilterproxymodel.h \
    noteeditor.h \
    options.h \
    ornamentedobj.h \
    scripteditor.h\
    scripting.h \
    scriptoutput.h \
    settings.h \
    shortcuts.h\
    showtextdialog.h\
    slidecontrolwidget.h\
    slideeditor.h\
    slideitem.h\
    slidemodel.h\
    task.h\
    taskeditor.h\
    taskmodel.h\
    treedelegate.h \
    treeeditor.h \
    treeitem.h \
    treemodel.h \
    texteditor.h \
    userdialog.h \
    version.h \
    vymlock.h \
    vymmodel.h \
    vymmodelwrapper.h \
    vymnote.h \
    vymprocess.h \
    vymtext.h \
    vymview.h \
    winter.h \
    warningdialog.h \
    xlink.h \
    xlinkitem.h \
    xlinkobj.h \
    xml-base.h \
    xml-vym.h \
    xml-freemind.h \
    xmlobj.h\
    xsltproc.h \
    zip-settings-dialog.h

SOURCES	+= \
    aboutdialog.cpp \
    codeeditor.cpp \
    taskfiltermodel.cpp \
    animpoint.cpp \
    arrowobj.cpp \
    attribute.cpp \
    attributeitem.cpp \
#   attributedelegate.cpp \
#   attributedialog.cpp \
#   attributewidget.cpp \
    branchitem.cpp \
    branchobj.cpp \
    branchpropeditor.cpp \
    bug-agent.cpp \
    command.cpp \
    confluence-agent.cpp \
    dockeditor.cpp \
    download-agent.cpp \
    editxlinkdialog.cpp \
    export-html-dialog.cpp \
    export-confluence-dialog.cpp \
    exportoofiledialog.cpp \
    export-ao.cpp \
    export-ascii.cpp \
    export-base.cpp \
    export-confluence.cpp \
    export-csv.cpp \
    export-html.cpp \
    export-impress.cpp \
    export-latex.cpp \
    export-markdown.cpp \
    export-orgmode.cpp \
    export-taskjuggler.cpp \
    extrainfodialog.cpp \
    file.cpp \
    findwidget.cpp \
    findresultwidget.cpp \
    findresultitem.cpp \
    findresultmodel.cpp \
    flag.cpp \
    flagobj.cpp \
    flagrow.cpp \
    flagrowobj.cpp \
    floatimageobj.cpp \
    floatobj.cpp \
    frameobj.cpp \
    geometry.cpp \
    heading.cpp \
    headingeditor.cpp \
    headingobj.cpp \
    highlighter.cpp \
    historywindow.cpp \
    imageitem.cpp \
    imageobj.cpp \
    imports.cpp \
    jira-agent.cpp \
    lineeditdialog.cpp \
    linkablemapobj.cpp \
    lockedfiledialog.cpp \
    macros.cpp \
    main.cpp \
    mainwindow.cpp \
    mapeditor.cpp \
    mapitem.cpp \
    mapobj.cpp \
    misc.cpp \
    mysortfilterproxymodel.cpp \
    noteeditor.cpp \
    options.cpp \
    ornamentedobj.cpp \
    scripteditor.cpp \
    scripting.cpp \
    scriptoutput.cpp \
    settings.cpp \
    shortcuts.cpp\
    showtextdialog.cpp \
    slidecontrolwidget.cpp \
    slideeditor.cpp \
    slideitem.cpp \
    slidemodel.cpp \
    task.cpp \
    taskeditor.cpp \
    taskmodel.cpp \
    texteditor.cpp \
    treedelegate.cpp \
    treeeditor.cpp \
    treeitem.cpp \
    treemodel.cpp \
    userdialog.cpp \
    version.cpp \
    vymlock.cpp \
    vymmodel.cpp \
    vymmodelwrapper.cpp \
    vymnote.cpp \
    vymprocess.cpp \
    vymtext.cpp \
    vymview.cpp \
    warningdialog.cpp \
    winter.cpp \
    xlink.cpp \
    xlinkitem.cpp \
    xlinkobj.cpp \
    xml-base.cpp \
    xml-vym.cpp \
    xml-freemind.cpp \
    xmlobj.cpp \
    xsltproc.cpp \
    zip-settings-dialog.cpp

FORMS = \
    attributewidget.ui \
    branchpropeditor.ui \
    export-html-dialog.ui \
    export-confluence-dialog.ui \
    extrainfodialog.ui \
    editxlinkdialog.ui \
    historywindow.ui \
    lineeditdialog.ui \
    lockedfiledialog.ui \
    scripteditor.ui \
    showtextdialog.ui \
    userdialog.ui \
    warningdialog.ui \
    zip-settings-dialog.ui

isEmpty( PREFIX ) {
    PREFIX = /usr/local
    count( INSTALLDIR, 1 ) {
	PREFIX = $${INSTALLDIR}
	message( "Please use PREFIX instead of INSTALLDIR" )
    }
}
isEmpty( BINDIR ) {
    BINDIR = $${PREFIX}/bin
}
isEmpty( DATADIR ) {
    DATADIR = $${PREFIX}
}

message( "Installation directory" )
message( $$PREFIX )


target.path = $${BINDIR}
INSTALLS += target

language.files = lang/*.qm
language.path = $${DATADIR}/vym/lang
INSTALLS += language

support.files = demos \
    exports/  \
    flags/ \
    icons/ \
    macros/ \
    scripts/ \
    styles/ 

support.path = $${DATADIR}/vym
INSTALLS += support 

# doc.files = doc/vym.pdf
# doc.files += LICENSE.txt
# doc.path = $${DOCDIR}
# INSTALLS += doc
# DEFINES += VYM_DOCDIR=\\\"$${DOCDIR}\\\"
