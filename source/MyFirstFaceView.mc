using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Math;

class MyFirstFaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }
    
    // Update the view
    function onUpdate(dc) {
        var clockTime = System.getClockTime();
        var screenCenterPoint = [dc.getWidth()/2, dc.getHeight()/2];
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
        
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        drawHashMarks(dc);
        
        dc.setColor(Graphics.COLOR_DK_RED, Graphics.COLOR_TRANSPARENT);
        drawNumbers(dc);
        
        var angle = (((clockTime.hour % 24) * 60) + clockTime.min);
        angle = angle / (24 * 60.0);
        angle = (angle * Math.PI * 2) - Math.PI;
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);    
        dc.fillPolygon(generateHandCoordinates(screenCenterPoint, angle, 80, 1, 2));        
    }
	function drawHashMarks(dc) {
		
        var sX, sY;
        var eX, eY;
        var outerRad = (dc.getHeight() / 2);
        var leftIndent = ((dc.getWidth() - dc.getHeight())/2);
        var innerRad = outerRad - 10;
        for (var i = Math.PI/12; i < 2 * Math.PI; i += (Math.PI/12)) {
            sY = Math.round(outerRad + innerRad * Math.sin(i));
            eY = Math.round(outerRad + outerRad * Math.sin(i));
            sX = Math.round(leftIndent + outerRad + innerRad * Math.cos(i));
            eX = Math.round(leftIndent + outerRad + outerRad * Math.cos(i));
            dc.drawLine(sX, sY, eX, eY);
        }
    }
	function drawNumbers(dc) {		
        var sX, sY;
        var eX, eY;
        var outerRad = (dc.getWidth() / 2);
        var number = 0;
        for (var i = 0; i < 2 * Math.PI; i += (Math.PI/4)) {
            sY = Math.round(outerRad + outerRad * Math.sin(i));
            sX = Math.round(outerRad + outerRad * Math.cos(i));
            if(number == 0){
            	dc.drawText(sX, sY - 28, Graphics.FONT_TINY, "18", Graphics.TEXT_JUSTIFY_RIGHT);
            }
            else if(number == 1){
            	dc.drawText(sX + 5, sY - 35, Graphics.FONT_TINY, "21", Graphics.TEXT_JUSTIFY_RIGHT);
            }
            else if(number == 2){
            		
            }
            else if(number == 3){
            	dc.drawText(sX - 5, sY - 35, Graphics.FONT_TINY, "03", Graphics.TEXT_JUSTIFY_LEFT);
            }
            else if(number == 4){
            	dc.drawText(sX, sY - 28, Graphics.FONT_TINY, "05", Graphics.TEXT_JUSTIFY_LEFT);
            }
            else if(number == 5){
            	dc.drawText(sX - 5, sY - 20, Graphics.FONT_TINY, "09", Graphics.TEXT_JUSTIFY_LEFT);
            }
            else if(number == 6){
            		
            }
            else if(number == 7){
            	dc.drawText(sX + 5, sY - 20, Graphics.FONT_TINY, "15", Graphics.TEXT_JUSTIFY_RIGHT);
            }
        	number++;
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }
    
    function generateHandCoordinates(centerPoint, angle, handLength, tailLength, width) {
        // Map out the coordinates of the watch hand
        var coords = [[-(width / 2), tailLength], [-(width / 2), -handLength], [width / 2, -handLength], [width / 2, tailLength]];
        var result = new [4];
        var cos = Math.cos(angle);
        var sin = Math.sin(angle);

        // Transform the coordinates
        for (var i = 0; i < 4; i += 1) {
            var x = (coords[i][0] * cos) - (coords[i][1] * sin) + 0.5;
            var y = (coords[i][0] * sin) + (coords[i][1] * cos) + 0.5;

            result[i] = [centerPoint[0] + x, centerPoint[1] + y];
        }

        return result;
    }
}
