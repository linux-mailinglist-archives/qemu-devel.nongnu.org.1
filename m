Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D51E791822
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9fE-00018A-0J; Mon, 04 Sep 2023 09:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qd9el-0000ko-DK
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:30:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qd9ed-0001M7-Ax
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:30:14 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfTxJ1vs1z6D957;
 Mon,  4 Sep 2023 21:28:52 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 14:30:09 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC: Li Zhijian <lizhijian@cn.fujitsu.com>, Dave Jiang <dave.jiang@intel.com>, 
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <linuxarm@huawei.com>
Subject: [PATCH 4/4] docs/cxl: Change to lowercase as others
Date: Mon, 4 Sep 2023 14:28:06 +0100
Message-ID: <20230904132806.6094-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Li Zhijian <lizhijian@cn.fujitsu.com>

Using the same style as elsewhere for topology / topo

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Link: https://lore.kernel.org/r/20230519085802.2106900-2-lizhijian@cn.fujitsu.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 docs/system/devices/cxl.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index f12011e230..b742120657 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -157,7 +157,7 @@ responsible for allocating appropriate ranges from within the CFMWs
 and exposing those via normal memory configurations as would be done
 for system RAM.
 
-Example system Topology. x marks the match in each decoder level::
+Example system topology. x marks the match in each decoder level::
 
   |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
   |    __________   __________________________________   __________    |
@@ -187,8 +187,8 @@ Example system Topology. x marks the match in each decoder level::
        ___________|___   __________|__   __|_________   ___|_________
    (3)|  Root Port 0  | | Root Port 1 | | Root Port 2| | Root Port 3 |
       |  Appears in   | | Appears in  | | Appears in | | Appear in   |
-      |  PCI topology | | PCI Topology| | PCI Topo   | | PCI Topo    |
-      |  As 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0  |
+      |  PCI topology | | PCI topology| | PCI topo   | | PCI topo    |
+      |  as 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0  |
       |_______________| |_____________| |____________| |_____________|
             |                  |               |              |
             |                  |               |              |
@@ -272,7 +272,7 @@ Example topology involving a switch::
       |  Root Port 0  |
       |  Appears in   |
       |  PCI topology |
-      |  As 0c:00.0   |
+      |  as 0c:00.0   |
       |___________x___|
                   |
                   |
-- 
2.39.2


