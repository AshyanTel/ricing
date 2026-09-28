import QtQuick

Item {
    id: clockContainer

    property string currentTime: Qt.formatDateTime(new Date(), "hh:mm:ss")

    width: label.width
    height: Constants.dotSize

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clockContainer.currentTime = Qt.formatDateTime(new Date(), "hh:mm:ss")
    }

    AlignedText {
        id: label
        color: Colors.teal
        anchors.centerIn: parent
        text: clockContainer.currentTime
    }
}
