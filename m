Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9998F83AB26
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Jan 2024 14:50:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSddX-00047z-LB; Wed, 24 Jan 2024 08:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSddW-00042l-4m
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:49:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSddU-0004KP-85
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:49:49 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKlcS02F2z6K93k;
 Wed, 24 Jan 2024 21:46:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id AE367140B63;
 Wed, 24 Jan 2024 21:49:44 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 13:49:44 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
 <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] hw/cxl: Update RAS Capability Definitions for version 3.
Date: Wed, 24 Jan 2024 13:48:12 +0000
Message-ID: <20240124134814.8717-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
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

Part of bringing all of CXL emulation inline with CXL r3.1.
No functional changes.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_component.h | 5 ++++-
 hw/cxl/cxl-component-utils.c   | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 2c7631bd1e..b5da72b789 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -60,8 +60,9 @@ CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
  * implements. Some of these are specific to certain types of components, but
  * this implementation leaves enough space regardless.
  */
-/* 8.2.5.9 - CXL RAS Capability Structure */
 
+/* CXL r3.1 Section 8.2.4.17: CXL RAS Capability Structure */
+#define CXL_RAS_CAPABILITY_VERSION 3
 /* Give ample space for caps before this */
 #define CXL_RAS_REGISTERS_OFFSET 0x80
 #define CXL_RAS_REGISTERS_SIZE   0x58
@@ -95,6 +96,8 @@ REG32(CXL_RAS_COR_ERR_STATUS, CXL_RAS_REGISTERS_OFFSET + 0xc)
 REG32(CXL_RAS_COR_ERR_MASK, CXL_RAS_REGISTERS_OFFSET + 0x10)
 REG32(CXL_RAS_ERR_CAP_CTRL, CXL_RAS_REGISTERS_OFFSET + 0x14)
     FIELD(CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER, 0, 6)
+    FIELD(CXL_RAS_ERR_CAP_CTRL, MULTIPLE_HEADER_RECORDING_CAP, 9, 1)
+    FIELD(CXL_RAS_ERR_POISON_ENABLED, POISON_ENABLED, 13, 1)
 REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
 #define CXL_RAS_ERR_HEADER_NUM 32
 /* Offset 0x18 - 0x58 reserved for RAS logs */
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a55cf5a036..848bfa20f1 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -325,7 +325,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
                        CXL_##reg##_REGISTERS_OFFSET);                         \
     } while (0)
 
-    init_cap_reg(RAS, 2, 2);
+    init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
     ras_init_common(reg_state, write_msk);
 
     init_cap_reg(LINK, 4, 2);
-- 
2.39.2


