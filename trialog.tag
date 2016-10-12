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
                XX YY
                ZZ
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
	repaintLog() {
    	this.days = opts.getDays();
		this.currentDate = opts.getMoment();
	}
	this.repaintLog();

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

	opts.on('momentChanged', function() {
		top.console.log("moment changed");
		self.repaintLog();
	} );

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

  </script>

</trialog>
