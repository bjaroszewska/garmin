import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class watchFaceRosesView extends WatchUi.WatchFace {

    var stepsLabelView;
    var batteryLabelView;
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));   
        var singleRoseView = View.findDrawableById("SingleRoseLabel");
        var rosesView = View.findDrawableById("RosesLabel");
        var batteryView = View.findDrawableById("BatteryIconLabel");
        var stepsView = View.findDrawableById("StepsIconLabel"); 
        stepsLabelView = View.findDrawableById("StepsLabel");
        batteryLabelView = View.findDrawableById("BatteryLabel");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var timeLabelView = View.findDrawableById("TimeLabel") as Text;
        timeLabelView.setText(timeString);
   
        // Get and show the current date 
        var now = Time.Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateLabelView = View.findDrawableById("DateLabel") as Text;
        dateLabelView.setText(
            Lang.format("$1$, $2$ $3$", [now.day_of_week, now.day, now.month])
        );
     
        // Steps 
		var info = ActivityMonitor.getInfo(); 
		var steps = info.steps;
		var stepsString = Lang.format ("$1$", [steps.format("%d")]);
        stepsLabelView.setText(stepsString); 

        // Battery
        var systemStats = System.getSystemStats();
		var batteryString = Lang.format ("$1$", [systemStats.battery.format("%d")]);
        batteryLabelView.setText(batteryString);

        dc.setColor(Graphics.COLOR_BLUE,Graphics.COLOR_YELLOW);
        dc.clear();
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
