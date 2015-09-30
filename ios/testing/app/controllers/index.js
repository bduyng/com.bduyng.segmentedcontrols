(function () {
	$.index.addEventListener('postlayout', function handlePostlayout() {
		$.index.removeEventListener('postlayout', handlePostlayout);
		setupSegmentedBar();

		// set horizontalScrollIndicator visible
		// before using it like a "pointer" bar
		$.scrollableView.horizontalScrollIndicatorVisible = true;
		setupSegmentedControls();
	});

	$.index.open();
})();

function setupSegmentedBar() {
	// Set shadow
	$.segmentedBar.viewShadowColor = 'black';
	$.segmentedBar.viewShadowRadius = 3;

	// Set location of labels
	$.following.center = {
		x : $.segmentedBar.rect.x + $.segmentedBar.rect.width / 4,
		y : $.segmentedBar.rect.y + $.segmentedBar.rect.height / 2
	};

	$.you.center = {
		x : $.segmentedBar.rect.x + $.segmentedBar.rect.width * 3 / 4,
		y : $.segmentedBar.rect.y + $.segmentedBar.rect.height / 2
	};
}

function setupSegmentedControls() {
	// relocation scrollIndicator to fake "pointer" bar
	$.scrollableView.scrollIndicatorInsets = {
		top : 0,
		left : -3,
		bottom : $.scrollableView.rect.height - 5,
		right : -3
	};

	// custom scrollIndicator ImageView
	// default size 2.5 x 2.5
	$.scrollableView.scrollHorizontalIndicatorImage = Ti.UI.createView({
		width : 2.5,
		height : 2.5,
		backgroundColor : "#125688"
	}).toImage();

	// IMPORTANT - COULD IMPROVE
	// make a cloned horizontal scroll indicator
	// to fake always show "pointer" bar effect
	// we will show cloned bar when horizontal scroll indicator is hidden
	// MUST BE AFTER CUSTOM INDICATOR
	$.scrollableView.clonedHorizontalScrollIndicatorVisible = true;


	$.scrollableView.addEventListener('scroll', function (e) {
		// when scrolling we need to hide cloned bar
		// because horizontal scroll indicator is shown this time
		$.scrollableView.clonedHorizontalScrollIndicatorVisible = false;

		// COULD IMPROVE
		if (e.currentPageAsFloat < 0.5) {
			$.following.color = "#125688";
			$.you.color = "#111111";
		}
		else {
			$.following.color = "#111111";
			$.you.color = "#125688";
		}
	});

	$.scrollableView.addEventListener('scrollend', function (e) {
		// need to set location and show clone bar
		// because horizontal scroll indicator is hidden this time
		$.scrollableView.relocationHorizontalScrollIndicator = e.currentPage;
	});
}
