Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1528779EC1E
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRSQ-00024M-8m; Wed, 13 Sep 2023 11:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgRSG-0001t8-VY
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:07:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgRSD-0005b1-3m
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:07:00 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm3Zt5CMgz6J7Yr;
 Wed, 13 Sep 2023 23:02:14 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 13 Sep 2023 16:06:54 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH 3/4] hw/cxl: CXLDVSECPortExtensions renamed to CXLDVSECPortExt
Date: Wed, 13 Sep 2023 16:05:20 +0100
Message-ID: <20230913150521.30035-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913150521.30035-1-Jonathan.Cameron@huawei.com>
References: <20230913150521.30035-1-Jonathan.Cameron@huawei.com>
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

Done to reduce line lengths where this is used.
Ext seems sufficiently obvious that it need not be spelt out
fully.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_pci.h       |  6 ++---
 hw/cxl/cxl-component-utils.c   | 49 ++++++++++++++++++++--------------
 hw/pci-bridge/cxl_downstream.c |  2 +-
 hw/pci-bridge/cxl_root_port.c  |  2 +-
 hw/pci-bridge/cxl_upstream.c   |  2 +-
 5 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index 407be95b9e..ddf01a543b 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -86,7 +86,7 @@ typedef struct CXLDVSECDevice {
 QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x38);
 
 /* CXL 2.0 - 8.1.5 (ID 0003) */
-typedef struct CXLDVSECPortExtensions {
+typedef struct CXLDVSECPortExt {
     DVSECHeader hdr;
     uint16_t status;
     uint16_t control;
@@ -100,8 +100,8 @@ typedef struct CXLDVSECPortExtensions {
     uint32_t alt_prefetch_limit_high;
     uint32_t rcrb_base;
     uint32_t rcrb_base_high;
-} CXLDVSECPortExtensions;
-QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortExtensions) != 0x28);
+} CXLDVSECPortExt;
+QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortExt) != 0x28);
 
 #define PORT_CONTROL_OFFSET          0xc
 #define PORT_CONTROL_UNMASK_SBR      1
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 089e10b232..2288e681ff 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -373,26 +373,35 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     case NON_CXL_FUNCTION_MAP_DVSEC:
         break; /* Not yet implemented */
     case EXTENSIONS_PORT_DVSEC:
-        wmask[offset + offsetof(CXLDVSECPortExtensions, control)] = 0x0F;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, control) + 1] = 0x40;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_bus_base)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_bus_limit)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_base)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_base) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_limit)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_limit) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high) + 2] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high) + 3] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high) + 2] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high) + 3] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, control)] = 0x0F;
+        wmask[offset + offsetof(CXLDVSECPortExt, control) + 1] = 0x40;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_base)] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_limit)] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_base)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_base) + 1] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_limit)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_limit) + 1] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base) + 1] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit) + 1] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high)] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high) + 1] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high) + 2] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high) + 3] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high)] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high) + 1] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high) + 2] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high) + 3] =
+            0xFF;
         break;
     case GPF_PORT_DVSEC:
         wmask[offset + offsetof(CXLDVSECPortGPF, phase1_ctrl)] = 0x0F;
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 54f507318f..cdd79ea1c0 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -98,7 +98,7 @@ static void build_dvsecs(CXLComponentState *cxl)
 {
     uint8_t *dvsec;
 
-    dvsec = (uint8_t *)&(CXLDVSECPortExtensions){ 0 };
+    dvsec = (uint8_t *)&(CXLDVSECPortExt){ 0 };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
                                EXTENSIONS_PORT_DVSEC_LENGTH,
                                EXTENSIONS_PORT_DVSEC,
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 7dfd20aa67..8f97697631 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -107,7 +107,7 @@ static void build_dvsecs(CXLComponentState *cxl)
 {
     uint8_t *dvsec;
 
-    dvsec = (uint8_t *)&(CXLDVSECPortExtensions){ 0 };
+    dvsec = (uint8_t *)&(CXLDVSECPortExt){ 0 };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
                                EXTENSIONS_PORT_DVSEC_LENGTH,
                                EXTENSIONS_PORT_DVSEC,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index a57806fb31..b81bb5fec9 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -116,7 +116,7 @@ static void build_dvsecs(CXLComponentState *cxl)
 {
     uint8_t *dvsec;
 
-    dvsec = (uint8_t *)&(CXLDVSECPortExtensions){
+    dvsec = (uint8_t *)&(CXLDVSECPortExt){
         .status = 0x1, /* Port Power Management Init Complete */
     };
     cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
-- 
2.39.2


