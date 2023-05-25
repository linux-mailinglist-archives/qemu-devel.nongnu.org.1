Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D804A711085
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 18:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2DX5-0001RW-UF; Thu, 25 May 2023 12:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q2DX4-0001QQ-19
 for qemu-devel@nongnu.org; Thu, 25 May 2023 12:09:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q2DWu-0003WC-6o
 for qemu-devel@nongnu.org; Thu, 25 May 2023 12:09:41 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRtDL5gJBz6J7BX;
 Fri, 26 May 2023 00:04:50 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 17:09:29 +0100
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>
CC: Niyas Sait <niyas.sait@linaro.org>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Michael S .
 Tsirkin" <mst@redhat.com>, Jeremy Kerr <jk@codeconstruct.com.au>, Matt
 Johnston <matt@codeconstruct.com.au>, Shesha Bhushan Sreenivasamurthy
 <sheshas@marvell.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
 "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: [RFC PATCH 1/6] hw/acpi/aml-build: add function for i2c slave device
 serial bus description
Date: Thu, 25 May 2023 17:08:54 +0100
Message-ID: <20230525160859.32517-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525160859.32517-1-Jonathan.Cameron@huawei.com>
References: <20230525160859.32517-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/acpi/aml-build.h |  1 +
 hw/acpi/aml-build.c         | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index fc2b949fb5..28db028b17 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -382,6 +382,7 @@ Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
              uint8_t channel);
 Aml *aml_sleep(uint64_t msec);
 Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
+Aml *aml_i2c_slv_serial_bus_device(uint16_t address, const char *resource_source);
 
 /* Block AML object primitives */
 Aml *aml_scope(const char *name_format, ...) G_GNUC_PRINTF(1, 2);
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 918cbb5b9d..22d7ecd753 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2478,3 +2478,20 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
 
     return var;
 }
+
+/* ACPI 5.0: 6.4.3.8.2.1 I2C Serial Bus Connection Resource Descriptor */
+Aml *aml_i2c_slv_serial_bus_device(uint16_t address, const char *resource_source)
+{
+    uint16_t resource_source_len = strlen(resource_source) + 1;
+    Aml *var = aml_serial_bus_device(AML_SERIAL_BUS_TYPE_I2C, 1, 0, 1,
+                                     6, resource_source_len);
+
+    /* Connection Speed.  Just set to 100K for now, it doesn't really matter. */
+    build_append_int_noprefix(var->buf, 100000, 4);
+    build_append_int_noprefix(var->buf, address, sizeof(address));
+
+    /* This is a string, not a name, so just copy it directly in. */
+    g_array_append_vals(var->buf, resource_source, resource_source_len);
+
+    return var;
+}
-- 
2.39.2


