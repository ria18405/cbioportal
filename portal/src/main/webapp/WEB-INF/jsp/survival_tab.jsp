<%@ page import="org.json.simple.JSONObject"%>

<style>
    #survival .survival_stats_table {
        margin-top: 10px;
        margin-bottom: 30px;
        margin-left: 95px;
        width: 620px;
        background-color: #FEFFC5;
        height: 80px;
        width: 720px;
    }
    #survival td{
        width: 140px;
        font-size: 13px;
        font-family: Arial, Helvetica, sans-serif;
        text-align: center;
        border: 1px solid #D8D8D8;
    }
    #survival h4{
        margin-left: 60px;
        margin-top: 20px;
        font-size: 150%;
        height: 30px;
    }
    #survival .img_buttons{
        font-size: 13px;
        display: inline;
        padding-left: 5px;
    }
</style>

<script>
    var cancer_study_id = "<%out.print(cancer_study_id);%>";
    var patient_set_id = "<%out.print(patient_set_id);%>";
    var patient_ids_key = "";
    if (patient_set_id === "-1") {
        patient_ids_key = "<%out.print(patientIdsKey);%>";
    }
</script>

<script type="text/javascript" src="js/src/survival_tab.js"></script>
<script type="text/javascript" src="js/src/survival-curve/survivalCurveView.js"></script>
<script type="text/javascript" src="js/src/survival-curve/survivalCurveProxy.js"></script>
<script type="text/javascript" src="js/src/survival-curve/component/survivalCurve.js"></script>
<script type="text/javascript" src="js/src/survival-curve/component/kmEstimator.js"></script>
<script type="text/javascript" src="js/src/survival-curve/component/logRankTest.js"></script>
<script type="text/javascript" src="js/src/survival-curve/component/boilerPlate.js"></script>

<div class="section" id="survival">
    <h4 id='os_header'>Overall Survival Kaplan-Meier Estimate</h4>
    <div id="os_survival_curve"></div>
    <div class="survival_stats_table" id="os_stat_table"></div>
    <h4 id='dfs_header'>Disease Free Survival Kaplan-Meier Estimate</h4>
    <div id="dfs_survival_curve"></div>
    <div class="survival_stats_table" id="dfs_stat_table"></div>
</div>

<script>
    function getSurvivalPlotsCaseList() {
        <%
            JSONObject result = new JSONObject();
            String delims = "[ ]+";
            String[] patientIds = patients.split(delims);
            for (int i = 0; i < patientIds.length; i++) {
                if (dataSummary.isCaseAltered(patientIds[i])) {
                    result.put(patientIds[i], "altered");
                } else {
                    result.put(patientIds[i], "unaltered");
                }
            }
        %>
        //console.log('<%=patientIds%>');
        var obj = jQuery.parseJSON('<%=result%>');
        return obj;
    }

    $(document).ready(function() {
        SurvivalTab.init(getSurvivalPlotsCaseList());
    });
</script>