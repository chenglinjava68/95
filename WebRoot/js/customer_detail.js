$(function() {

    // 修改客户
    if (!!customerId) $("#saveCustomer").text('更新');

    // 添加客户
    $.ajax({
            url: basePath + 'customer_config/query_all_device_summary.action',
            type: 'POST',
            dataType: 'json',
            data: { "customer.customerId": customerId },
            beforeSend: function(jqXHR, settings) {
                var tmpl = $("#overlayTmpl").html(),
                    result = ejs.render(tmpl);
                $("#customerBox").append(result);
            }
        })
        .done(function(data) {
            $("#deviceSummaryTable").data("deviceSummary", data).triggerHandler("dataTables.render");
        })
        .fail(function() {
            console.log("error");
        })
        .always(function() {
            $("#customerBox").children(".overlay").remove();
        });

    getCustomerSummary();
    // 客户的端口占用数量
    function getCustomerSummary() {
        $.ajax({
                url: basePath + 'customer_config/query_customer_summary_for_this_customer.action',
                type: 'POST',
                dataType: 'json',
                data: { "customer.customerId": customerId }
            })
            .done(function(data) {
                $(".port-count-label").text(data.portCount);
            })
            .fail(function() {
                console.log("error");
            })
            .always(function() {
                console.log("complete");
            });
    }

    /*
        解绑客户占用的端口
     */
    $(".unbound-customer").click(function(event) {

        if (!!!customerId) return;
        $.ajax({
                url: basePath + 'customer_config/unbound_all_interface_for_this_customer.action',
                type: 'POST',
                dataType: 'json',
                data: { "customer.customerId": customerId },
            })
            .done(function() {
                location.reload();
            })
            .fail(function() {
                console.log("error");
            })
            .always(function() {
                console.log("complete");
            });

    });

    $("#deviceSummaryTable").on("dataTables.render", function(event) {

            var template = $("#unboundDeviceTmpl").html();

            $(this).DataTable({
                processing: true,
                serverSide: false,
                data: $(this).data("deviceSummary"),

                autoWidth: false,
                "language": {
                    "url": basePath + "/lang/dataTables.chinese.lang"
                },
                columns: [{
                    data: null,
                    title: "序号",
                    render: function(data, type, row, meta) {
                        return meta.row + 1;
                    }
                }, {
                    data: "host.ipAddress",
                    title: "IP"
                }, {
                    data: "portCount",
                    title: "当前用户所占端口数"
                }, {
                    data: null,
                    title: "操作",
                    render: function(data, type, row, meta) {

                        return ejs.render(template, {
                            host: row
                        });
                    }
                }]
            });
        })
        //解绑此客户在设备上占用的端口
        .on("click", "button", function(event) {
            var ip = $(this).attr('data-ip'),
                portCount = parseInt($(this).attr('data-port-count'));

            $.ajax({
                    url: basePath + 'customer_config/unbound_device_interface_for_this_customer.action',
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        "host.ipAddress": ip,
                        "customer.customerId": customerId
                    },
                })
                .done(function() {
                    location.reload();
                })
                .fail(function() {
                    console.log("error");
                })
                .always(function() {
                    console.log("complete");
                });

        });

    // 保存客户名
    $("#saveCustomer").click(function(event) {
        var $customerBtn = $(this),
            $customerName = $customerBtn.parents(".input-group").children('input'),
            customerName = $customerName.val();

        if (customerName === "") {
            $customerName.tooltip("show");
            return;
        }

        var data = {
            "customer.customerName": customerName
        };
        if (!!customerId) data["customer.customerId"] = customerId;
        // 添加新客户或者修改客户名称
        $.ajax({
                url: basePath + 'customer_config/save_customer.action',
                type: 'POST',
                dataType: 'json',
                data: data,
                beforeSend: function(jqXHR, settings) {
                    $customerBtn.prop({
                        "disabled": true
                    });
                }
            })
            .done(function(data) {
                customerId = data.customerId,
                    customerName = data.customerName;

                $customerBtn.text('更新');
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                var message;
                if (textStatus == "error") {
                    if (jqXHR.status == 0) {
                        message = "网络连接错误";
                    } else if (jqXHR.status == 500) {
                        message = "服务器内部错误，无法获取数据";
                    }
                } else if (textStatus == "timeout") {
                    message = "浏览器等待数据超时";
                } else if (textStatus == "parsererror") {
                    message = "数据解析异常";
                }

                $("#alertModal").data("message", message).modal("show");
            })
            .always(function(jqXHR, textStatus) {
                $customerBtn.prop('disabled', false);
            });

    }).parents(".input-group").children('input').tooltip({
        placement: "bottom",
        trigger: "manual",
        title: function() {
            return "用户名不能空"
        }
    }).focus(function(event) {
        $(this).tooltip("hide");
    });

    // 查询过滤出来所输入IP的设备Panel
    $("#queryDeviceBtn").click(function(event) {
        var $ip = $(this).parents(".input-group").children('input'),
            ip = $ip.val();

        if (ip === "") { //所有设备Panel
            getPagingDeviceDetail({
                countPerPage: 10,
                currentPageNumber: 0
            });
        } else if (validator.isIP(ip)) {
            $.ajax({
                    url: basePath + 'customer_config/query_some_device_detail.action',
                    type: 'POST',
                    contentType: "application/json",
                    dataType: 'json',
                    data: JSON.stringify({
                        "hostList": [{
                            ipAddress: ip
                        }]
                    }),
                })
                .done(function(data) {

                    //格式化数据
                    var devices = [];
                    for (var i = 0, list = data, size = list.length; i < size; i++) {
                        var device = list[i],
                            interfaces = device.interfaces,
                            ports = [];

                        for (var j = 0, jSize = interfaces.length; j < jSize; j++) {
                            var interf = interfaces[j];

                            ports.push({
                                id: interf.ifIndex,
                                name: interf.ifDesc,
                                customerId: interf.customerId
                            });
                        }
                        devices.push({
                            ip: device.device.ipAddress,
                            ports: ports
                        });
                    }

                    $("#deviceAccordion").data("deviceDetail", devices).triggerHandler("render.bs.collapse");


                    $("#info").text('');

                    $(".panel-list ul.pagination").html('<li class="disabled"><a href="#">上页</a></li><li class="disabled"><a href="#">下页</a></li>');
                })
                .fail(function() {
                    console.log("error");
                })
                .always(function() {
                    console.log("complete");
                });

        } else {
            $ip.tooltip("show");
        }
    }).parents(".input-group").children('input').tooltip({
        placement: "bottom",
        trigger: "manual",
        title: function() {
            return "请输入合法的IP"
        }
    }).focus(function(event) {
        $(this).tooltip("hide");
    });

    getPagingDeviceDetail({
        countPerPage: 10,
        currentPageNumber: 0
    });

    function getPagingDeviceDetail(data) {
        /*
        获取设备
     */
        $.ajax({
                url: basePath + 'customer_config/query_paging_device_detail.action',
                type: 'POST',
                dataType: 'json',
                data: data,
                beforeSend: function(jqXHR, settings) {
                    var tmpl = $("#overlayTmpl").html(),
                        result = ejs.render(tmpl);
                    $("#deviceBox").append(result);
                }
            })
            .done(function(data, textStatus, jqXHR) {

                if (data && data.totalCount > 0) {

                    //格式化数据
                    var devices = [];
                    for (var i = 0, list = data.list, size = list.length; i < size; i++) {
                        var device = list[i],
                            interfaces = device.interfaces,
                            ports = [];

                        for (var j = 0, jSize = interfaces.length; j < jSize; j++) {
                            var interf = interfaces[j];

                            ports.push({
                                id: interf.ifIndex,
                                name: interf.ifDesc,
                                customerId: interf.customerId
                            });
                        }
                        devices.push({
                            ip: device.device.ipAddress,
                            ports: ports
                        });
                    }

                    $("#info").triggerHandler("render.bs.info", {
                        currentPageStart: data.currentPageStart,
                        currentPageEnd: data.currentPageEnd,
                        totalCount: data.totalCount
                    });

                    $(".panel-list ul.pagination").triggerHandler('render.bs.pagination', {
                        totalPageCount: data.totalPageCount,
                        currentPageNumber: data.currentPageNumber
                    });

                    $("#deviceAccordion").data("deviceDetail", devices)
                        .triggerHandler("render.bs.collapse");
                }
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.log("error");
            })
            .always(function(jqXHR, textStatus) {
                $("#deviceBox").children(".overlay").remove();
            });
    }


    /*
        所有设备的端口点击处理
     */
    $("#deviceAccordion").on("click", "button", function(event) {

        if (!!!customerId) return;
        var url = basePath + 'customer_config/unbound_port.action',
            currentCustomerId = customerId,
            $button = $(this),
            ip = $button.parent().attr("data-ip").trim(),
            portId = $button.attr("data-port-id"),
            portName = $button.text().trim(),
            increment = -1;

        var data = {
            "topoInterface.nodeId": ip,
            "topoInterface.ifIndex": portId,
            "topoInterface.ifDesc": portName
        };

        if (!$button.hasClass('active')) {
            url = basePath + 'customer_config/bound_port.action',
                data["topoInterface.customerId"] = currentCustomerId;

            increment = 1;
        }

        $.ajax({
                url: url,
                type: 'POST',
                dataType: 'json',
                data: data
            })
            .done(function(data) {
                $button.toggleClass('active');
                var counts = $('a[href="#ip_' + ip.replace(/\./g, "_") + '"]').next().children('i');

                counts.each(function(index, el) {

                    var $el = $(el);
                    $el.text(parseInt($el.text()) + increment);
                });

                $(".port-count-label").trigger('render.bs.label', increment);
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.log("error");
            })
            .always(function() {
                console.log("complete");
            });

    }).on("render.bs.collapse", function(event) {
        var devices = $(this).data('deviceDetail'),
            template = $("#deviceTmpl").html(),
            result = ejs.render(template, {
                devices: devices,
                customerId: customerId
            });

        $(this).html(result);
    });

    $(".port-count-label").on("render.bs.label", function(event, increment) {
        var $this = $(this);
        $this.text(parseInt($this.text()) + increment);
    });

    // 设备Panel分页
    $(".panel-list ul.pagination").on("click", "li", function(event) {

        var currentPageNumber = $(this).attr("data-page");

        if (isNaN(parseInt(currentPageNumber))) {

            if (currentPageNumber === 'prev') {
                currentPageNumber = parseInt($(event.delegateTarget).children('li.active').attr("data-page"));
                currentPageNumber = currentPageNumber - 1 < 1 ? 1 : (currentPageNumber - 1);
            } else {
                currentPageNumber = parseInt($(event.delegateTarget).children('li.active').attr("data-page"));
                var totalPageCount = parseInt($(this).prev().attr("data-page"));
                currentPageNumber = currentPageNumber + 1 > totalPageCount ? totalPageCount : (currentPageNumber + 1);
            }
        }

        currentPageNumber = parseInt(currentPageNumber);
        currentPageNumber -= 1;

        getPagingDeviceDetail({
            countPerPage: 10,
            currentPageNumber: currentPageNumber
        });
    }).on("render.bs.pagination", function(event, data) {
        var template = $("#devicePaginationTmpl").html(),
            result = ejs.render(template, data);

        $(this).html(result);
    });

    $("#info").on("render.bs.info", function(event, data) {
        data.currentPageEnd = data.currentPageEnd < data.totalCount ? data.currentPageEnd : data.totalCount;
        $(this).text('显示第' + (data.currentPageStart + 1) + '至第' + data.currentPageEnd + '项结果，共' + data.totalCount + '项');
    });

    /*
        展示不同的告警信息
     */
    $("#alertModal").on("show.bs.modal", function(event) {
        var modal = $(this);
        modal.find(".modal-body").text(modal.data("message"));
    });
});
