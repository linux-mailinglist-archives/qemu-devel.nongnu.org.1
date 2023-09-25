Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A237ADCE0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:15:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkoFB-0000Be-Ud; Mon, 25 Sep 2023 12:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkoF9-0008SG-Df
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:15:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkoF7-0000qj-7v
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:15:31 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvSbB0zKVz6DBCq;
 Tue, 26 Sep 2023 00:13:10 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 17:15:27 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Gregory Price <gregory.price@memverge.com>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>, Klaus Jensen
 <k.jensen@samsung.com>
Subject: [PATCH 08/19] docs: cxl: Add example commandline for MCTP CXL CCIs
Date: Mon, 25 Sep 2023 17:11:13 +0100
Message-ID: <20230925161124.18940-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add initial documentation for the MCTP over I2C management device. At
current time this can only be used with the Aspeed I2C controller which
is only available in aspeed SoCs, though can be added to other
emulated boards.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 docs/system/devices/cxl.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 6ab5f72473..dfe5577599 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -406,6 +406,33 @@ OS management of CXL memory devices as described here.
 * CONFIG_CXL_PORT
 * CONFIG_CXL_REGION
 
+
+CCI access via MCTP over I2C
+----------------------------
+
+In order to make use of this device, an I2C controller that supports MCTP
+is required.  The aspeed-i2c controller is an example of such a controller.
+
+Both CXL switches and CXL Type 3 devices support configuration via
+MCTP access to Component Command Interfaces (CCIs) on the devices.
+
+Example configuration:
+
+ -device cxl-upstream,port=33,bus=root_port0,id=us0,multifunction=on,addr=0.0,sn=12345678 \
+ -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
+ -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
+ -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
+ -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem1,id=cxl-pmem0,lsa=cxl-lsa1,sn=3 \
+ -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem2,id=cxl-pmem1,lsa=cxl-lsa2,sn=4 \
+ -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem3,id=cxl-pmem2,lsa=cxl-lsa3,sn=5 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem0 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem1 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=7,target=cxl-pmem2
+
+Guest OS communication with the MCTP CCI can then be established using standard
+MCTP configuration tools.
+
 References
 ----------
 
-- 
2.39.2


