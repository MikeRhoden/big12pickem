<%
    Class cDeadline
        Public Function GetDeadlineForWeek2017(week)
            Dim rv
            if week = 1 then
                rv = cdate("9/9/2017 9:00:00 AM")
            elseif week = 2 then
                rv = cdate("9/10/2017 10:59:59 AM")
            elseif week = 3 then
                rv = cdate("9/23/2017 9:00:00 AM")
            elseif week = 4 then
                rv = cdate("9/30/2017 9:00:00 AM")
            elseif week = 5 then
                rv = cdate("10/7/2017 9:00:00 AM")
            elseif week = 6 then
                rv = cdate("10/14/2017 9:00:00 AM")
            elseif week = 7 then
                rv = cdate("10/21/2017 9:00:00 AM")
            elseif week = 8 then
                rv = cdate("10/28/2017 9:00:00 AM")
            elseif week = 9 then
                rv = cdate("11/4/2017 9:00:00 AM")
            elseif week = 10 then
                rv = cdate("11/11/2017 9:00:00 AM")
            elseif week = 11 then
                rv = cdate("11/18/2017 9:00:00 AM")
            elseif week = 12 then
                rv = cdate("11/25/2017 9:00:00 AM")
            elseif week = 13 then
                rv = cdate("12/2/2017 9:00:00 AM")
            elseif week = 14 then
                rv = cdate("12/9/2017 9:00:00 AM")
            end if
            GetDeadlineForWeek2017 = rv
        End Function
    End Class
%>
<%for i = 1 to 14%>
<%=(new cDeadline).GetDeadlineForWeek2017(i)%><br><%next%>

