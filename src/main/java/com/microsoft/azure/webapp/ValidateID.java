package com.microsoft.azure.webapp;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
//引入Azure Application Insight SDK库
import com.microsoft.applicationinsights.TelemetryClient;

//生成ValidateID servlet，访问路径为/ValidateID，实现方法doPost