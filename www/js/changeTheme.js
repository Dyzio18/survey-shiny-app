(function() {

    const themeRadioBtn = document.getElementById('skinThemeRadio');
    themeRadioBtn.addEventListener('change', () => {
        let theme = document.querySelector('input[name="skinThemeRadio"]:checked').value
        if( !theme ){
            theme = "blue";
        }
        console.log(theme);
        changeBodySkin(theme);
    })
 

    const changeBodySkin = (themeColor) => {
        //Todo: Add cookies
        document.body.classList = `skin-${themeColor}`;
    }


 })();

