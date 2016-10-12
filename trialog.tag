<trialog>

    <div class="row">
        <div class="col-sm-1">
            <button class="btn btn-default" onclick={prevWeek}>
                <span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>
            </button>
        </div>
        <div class="col-sm-1 panel panel-default " each={ days }>
        <h5> { moment.format("dd DD/YY") } </h5>
            <div class="swim_d" each={ sessions.filter(showSwim) }>
            Swim:
            { txt }
            </div>
            <div class="bike_d" each={ sessions.filter(showBike) }>
            Bike:
            { txt }
            </div>
            <div class="run_d" each={ sessions.filter(showRun) }>
            Run:
            { txt }
            </div>
            <div class="other_d" each={ sessions.filter(showOther) } >
            Other:
            { txt }
            </div>
        </div>
        <div class="col-sm-3">
        <h4>Total</h4>
        </div>
        <div class="col-sm-1">
            <button class="btn btn-default" onclick={nextWeek}>
                <span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span>
            </button>
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
    this.days = opts.getDays();

    nextWeek(e) {
        opts.setMoment(opts.getMoment().add(1,'week'));
        this.days = opts.getDays();

    }

    prevWeek(e) {
        opts.setMoment(opts.getMoment().subtract(1,'week'));
        this.days = opts.getDays();
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
