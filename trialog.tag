<trialog>

    <!--
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
    -->

    <div class="ui eight doubling cards">

            <div class="card" each={ days }>
                <div class="content">
                    <div class="header">{ moment.format("dd DD MMM") } </div>
                    <div class="description">
                        <a class="ui label blue" each={ sessions.filter(showSwim) } href="#sessions/{ id }"> { txt }</a>
                        <a class="ui label black" each={ sessions.filter(showBike) } href="#sessions/{ id }"> { txt }</a>
                        <a class="ui label green" each={ sessions.filter(showRun) } href="#sessions/{ id }"> { txt }</a>
                        <a class="ui label red" each={ sessions.filter(showOther) } href="#sessions/{ id }"> { txt }</a>
                    </div>
                </div>
            </div>

            <div class="card raised black">
                <div class="content">
                    <div class="header">{ durationAsString(totals.global.totalTime) }</div>
                    <div class="meta">{ durationAsString(totals.global.plannedTime) }</div>
                    <div class="description">
                        <a class="ui tag label blue " data-content={ durationAsString(totals.swim.plannedTime) }>{ durationAsString(totals.swim.totalTime) }</a>
                        <a class="ui tag label black" data-content={ durationAsString(totals.bike.plannedTime) }>{ durationAsString(totals.bike.totalTime) }</a>
                        <a class="ui tag label green" data-content={ durationAsString(totals.run.plannedTime) }>{ durationAsString(totals.run.totalTime) }</a>
                    </div>
                </div>
            </div>
    </div>
    <!--
        </div>
    </div>

  <form onsubmit={ add }>
    <input name="input" onkeyup={ edit }>
    <button disabled={ !text }>Add #{ items.filter(whatShow).length + 1 }</button>

    <button disabled={ items.filter(onlyDone).length == 0 } onclick={ removeAllDone }>
    X{ items.filter(onlyDone).length } </button>
  </form>
    -->

  <!-- this script tag is optional -->
  <script>

	var self = this;

    var r = riot.route.create()

    r('/home', home);
    r('/sessions/*', popupDetail);


    function lookupSession(days, id) {
        for (var i = 0; i < days.length; i++) {
            for( var j = 0; j < days[i].sessions.length; j++ ) {
                if (days[i].sessions[j].id == id) return days[i].sessions[j];
            }
        }
        return {}
    }

	function home() {
	}	

    function popupDetail( item ) {
        var selected = lookupSession(self.days, item);
        /**
        top.console.log("DETAIL");
        
        top.console.log(item);
        top.console.log(selected);
        **/
		
		detailTag.update(selected);
        $('.ui.modal').modal({
    		onHide: function() {
      			document.location='#';
    		}
  		}).modal('show');
    }

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
        top.console.log("Repainting... ");
    	this.days = opts.getDays();
        top.console.log(this.days);
		this.currentDate = opts.getMoment();
        this.totals = opts.getWeeklyTotals();
        this.update();
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
