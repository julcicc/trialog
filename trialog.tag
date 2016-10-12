<trialog>

    <div class="row">
        <div class="col-md-12">
        <input type="date" value={ opts.getMoment().format("YYYY-MM-DD") } onChange={changeDate}>
            <button class="btn btn-default btn-md" onclick={prevWeek}>
                <span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>
            </button>
            <button class="btn btn-default btn-md" onclick={nextWeek}>
                <span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span>
            </button>
        </div>>
    </div>
    <div class="row">
        <div class="col-md-2">
                <h4>Total</h4>
                <table class="table table-condensed">
                <tr>
                    <td><strong>{ durationAsString(totals.global.totalTime) }</strong></td>
                    <td><span class="text-muted">{ durationAsString(totals.global.plannedTime) }</span></td>
                </tr>
                <tr>
                    <td><strong>{ distanceAsString(totals.global.totalDistance) }</strong></td>
                    <td><span class="text-muted">{ distanceAsString(totals.global.plannedDistance)}</span></td>
                </tr>
                <tr>
                    <td><small class="swim_txt">{ durationAsString(totals.swim.totalTime) }</small></td>
                    <td><small><span class="text-muted">{ durationAsString(totals.swim.plannedTime) }</span></small></td>
                </tr>
                <tr>
                    <td><small class="swim_txt">{ totals.swim.totalDistance }m </small></td>
                    <td><small><span class="text-muted">{ distanceAsString(totals.swim.plannedDistance ) }</span></small></td>
                </tr>
                <tr>
                    <td><small class="bike_txt">{ durationAsString(totals.bike.totalTime) }</small></td>
                    <td><small><span class="text-muted">{ durationAsString(totals.bike.plannedTime) }</span></small></td>
                </tr>
                <tr>
                    <td><small class="bike_txt">{ distanceAsString(totals.bike.totalDistance) }</small></td>
                    <td><small><span class="text-muted">{ distanceAsString(totals.bike.plannedDistance ) }</span></small></td>
                </tr>
                <tr>
                    <td><small class="run_txt">{ durationAsString(totals.run.totalTime) }</small></td>
                    <td><small><span class="text-muted">{ durationAsString(totals.run.plannedTime) }</span></small></td>
                </tr>
                <tr>
                    <td><small class="run_txt">{ distanceAsString(totals.run.totalDistance) }</small></td>
                    <td><small><span class="text-muted">{ distanceAsString(totals.run.plannedDistance ) }</span></small></td>
                </tr>
                </table>
         </div>
        <div class="col-md-10">
        <div class="row seven-cols">
            <div class="col-md-1" each={ days }>
            <h5> { moment.format("dd DD MMM") } </h5>
                <div class="swim_d" each={ sessions.filter(showSwim) }>
                <img src="img/swim_ico.png" class="swim_icon">
                { txt }
                </div>
                <div class="bike_d" each={ sessions.filter(showBike) }>
                <img src="img/bike_ico.png" class="bike_icon">
                { txt }
                </div>
                <div class="run_d" each={ sessions.filter(showRun) }>
                <img src="img/run_ico.png" class="run_icon">
                { txt }
                </div>
                <div class="other_d" each={ sessions.filter(showOther) } >
                { txt }
                </div>
            </div>
        </div>

        </div>
    </div>

  <form onsubmit={ add }>
    <input name="input" onkeyup={ edit }>
    <button disabled={ !text }>Add #{ items.filter(whatShow).length + 1 }</button>

    <button disabled={ items.filter(onlyDone).length == 0 } onclick={ removeAllDone }>
    X{ items.filter(onlyDone).length } </button>
  </form>

  <!-- this script tag is optional -->
  <script>

	var self = this;

    distanceAsString(meters) {
        return "" + (meters/1000).toFixed(2) + "km";
    }

    durationAsString(seconds) {
        var d = moment.duration(seconds*1000);
        var hrs = d.asHours();
        var str = "" + Math.floor(hrs) + "h";
        str += " " + Math.round((hrs-Math.floor(hrs))*60) + "m";
        return str;
    }

	repaintLog() {
    	this.days = opts.getDays();
		this.currentDate = opts.getMoment();
        this.totals = opts.getWeeklyTotals();
	}

    nextWeek(e) {
        opts.setMoment(opts.getMoment().add(1,'week'));
        this.days = opts.getDays();

    }

    prevWeek(e) {
        opts.setMoment(opts.getMoment().subtract(1,'week'));
    }

	changeDate(e) {
		if (e.target.value!="") opts.setMoment( moment(e.target.value) );
	}

    showSwim( item ) {
        return item.type == "swim";
    }
    showBike( item ) {
        return item.type == "bike";
    }
    showRun( item ) {
        return item.type == "run";
    }
    showOther( item ) {
        return item.type != "swim" 
        && item.type != "bike"
        && item.type != "run";
    }

    /*
    edit(e) {
      this.text = e.target.value
    }

    add(e) {
      if (this.text) {
        this.items.push({ title: this.text })
        this.text = this.input.value = ''
      }
    }

    removeAllDone(e) {
      this.items = this.items.filter(function(item) {
        return !item.done
      })
    }

    // an two example how to filter items on the list
    whatShow(item) {
      return !item.hidden
    }

    onlyDone(item) {
      return item.done
    }

    toggle(e) {
      var item = e.item
      item.done = !item.done
      return true
    }
    */

	opts.on('momentChanged', function() {
		top.console.log("moment changed");
		self.repaintLog();
	} );

	this.repaintLog();

  </script>

</trialog>
