Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA4F78F6C1
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 03:30:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbsyU-0002qe-UM; Thu, 31 Aug 2023 21:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qbsyT-0002qN-C8
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 21:29:25 -0400
Received: from mail-yw1-x1142.google.com ([2607:f8b0:4864:20::1142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qbsyQ-0007WB-VA
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 21:29:25 -0400
Received: by mail-yw1-x1142.google.com with SMTP id
 00721157ae682-58ca499456dso15517947b3.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 18:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693531762; x=1694136562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQlDC7xQKtcr8MKPJQclDMnhMXYknCWURW4x9XXFigw=;
 b=fuyvoTBIWGgfYah8MAlVuMAgkvBXrnKtH15izYVwM9poFPecsHhIKxKTur9kdQ04Of
 tOe2Xyd90ILbAZBle6hfigGbnLs6SBK0IM9aiRStVgwbhMQxVPKYECWI31XhgfofiPea
 rdoc4zyJJhhQZf9+k0JT+HzuPgcNqrxdFec3cbyXi0FHmNAguwlUvY0ZfdzoWdCgENO4
 2kMNfYDy6gwbWjwvN32hTDu5ycD3bZqn7TIL321vGV5TCt24bFMJ/laukbhy3d5dTbPt
 Cvz742cyunL8bWGqIrP4QDaH5r0OuioGhuvK90nlhTJHSIcxNqlUGHDbYtRN0U8DJLgE
 xukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693531762; x=1694136562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQlDC7xQKtcr8MKPJQclDMnhMXYknCWURW4x9XXFigw=;
 b=lZdQssQ0KMkOfF3gzJYAq/+1v1X73IfE3Yg16lav9HzIujq+lAB0cgguN31TTNfJ3o
 6sAaMQUaDP5W8e8EZpS7+pz1fzHPCIXHTJqEaCKsyIL3aR39tIjqBfl11ZR5+smjcdY7
 miCY1h1U7IFzmMSfoRo9j/C68A8UEcbPpYSNifQ8xVdT471TWF03/5sfox0nkU+65zWj
 77YF+HBbcnIQuWAKZQV1/oFNMWvYPXQUzN8+5Y/kXYbb31ifyLqxnmVeriSMRl5q+qBA
 S9l/GdyQOQvZgNNh63ugEh5ZmCusJ38CZVdwc8x2To6P2LVH39BQNY/wq0sFvn1vJXju
 b+Gg==
X-Gm-Message-State: AOJu0YzmG34vqkBsKSDWtN58/t5mbFJWzujAdiipMhmGgmMK3mHgaDed
 VnSUNbfA8QtOfcjTOrczZyM3t1A6XnYo
X-Google-Smtp-Source: AGHT+IFO/m2eBPCDxfBuNLMQImuzehkXXmKU9hip/MJQ3qzbmUlRdW+ymMcEB46b1P3qt6og0eitXw==
X-Received: by 2002:a0d:c341:0:b0:591:fb31:3edd with SMTP id
 f62-20020a0dc341000000b00591fb313eddmr1319929ywd.30.1693531761739; 
 Thu, 31 Aug 2023 18:29:21 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 g186-20020a0df6c3000000b00559fb950d9fsm810447ywf.45.2023.08.31.18.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:29:21 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 1/5] cxl/mailbox: move mailbox effect definitions to a header
Date: Thu, 31 Aug 2023 21:29:10 -0400
Message-Id: <20230901012914.226527-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230901012914.226527-1-gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1142;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1142.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Preparation for allowing devices to define their own CCI commands

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 35 +++++++++++++++++++----------------
 include/hw/cxl/cxl_mailbox.h | 18 ++++++++++++++++++
 2 files changed, 37 insertions(+), 16 deletions(-)
 create mode 100644 include/hw/cxl/cxl_mailbox.h

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4e8651ebe2..edf39a3efb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -12,6 +12,7 @@
 #include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
+#include "hw/cxl/cxl_mailbox.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
@@ -1561,28 +1562,28 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-#define IMMEDIATE_CONFIG_CHANGE (1 << 1)
-#define IMMEDIATE_DATA_CHANGE (1 << 2)
-#define IMMEDIATE_POLICY_CHANGE (1 << 3)
-#define IMMEDIATE_LOG_CHANGE (1 << 4)
-#define SECURITY_STATE_CHANGE (1 << 5)
-#define BACKGROUND_OPERATION (1 << 6)
+#define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
+#define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
+#define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
+#define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
+#define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
+#define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
 
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
         cmd_events_get_records, 1, 0 },
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
-        cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
+        cmd_events_clear_records, ~0, CXL_MBOX_IMMEDIATE_LOG_CHANGE },
     [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
                                       cmd_events_get_interrupt_policy, 0, 0 },
     [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
                                       cmd_events_set_interrupt_policy,
-                                      ~0, IMMEDIATE_CONFIG_CHANGE },
+                                      ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
-                         IMMEDIATE_POLICY_CHANGE },
+                         CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
@@ -1591,9 +1592,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_ccls_get_partition_info, 0, 0 },
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
-        ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
-        IMMEDIATE_DATA_CHANGE | SECURITY_STATE_CHANGE | BACKGROUND_OPERATION },
+        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_SECURITY_STATE_CHANGE |
+         CXL_MBOX_BACKGROUND_OPERATION)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
@@ -1612,10 +1615,10 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
         8, 0 },
     [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
         "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
-        ~0, IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_DATA_CHANGE },
     [DCD_CONFIG][RELEASE_DYN_CAP] = {
         "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
-        ~0, IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_DATA_CHANGE },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
@@ -1628,7 +1631,7 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
      */
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
-                         IMMEDIATE_POLICY_CHANGE },
+                         CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
@@ -1670,7 +1673,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     /* Only one bg command at a time */
-    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+    if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
         cci->bg.runtime > 0) {
         return CXL_MBOX_BUSY;
     }
@@ -1691,7 +1694,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     ret = (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
-    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+    if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
         ret == CXL_MBOX_BG_STARTED) {
         *bg_started = true;
     } else {
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
new file mode 100644
index 0000000000..beb048052e
--- /dev/null
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU CXL Mailbox
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef CXL_MAILBOX_H
+#define CXL_MAILBOX_H
+
+#define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
+#define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
+#define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
+#define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
+#define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
+#define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
+
+#endif
-- 
2.39.1


