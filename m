Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F50B796DB8
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 01:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe2Fw-0006D0-O3; Wed, 06 Sep 2023 19:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Fp-0006CX-7W
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:13 -0400
Received: from mail-yw1-x1142.google.com ([2607:f8b0:4864:20::1142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Ff-0006ad-5m
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:05 -0400
Received: by mail-yw1-x1142.google.com with SMTP id
 00721157ae682-58caaedb20bso4146307b3.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694044082; x=1694648882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgAxgcyqhu59qzleb8BoU1mSJXsud8avyAYb65wFNbg=;
 b=HOz1iFPF7cG8pyYeHk9yG6rleTU1r982oVwutLJ9I1/U1rDXZswAkyuFN7hptVNxGU
 CIJDC2C0+CDJUOK8EqYG130LT361F6Eeef7f++AqTfWdQsQVyKHhyw2JrGyU6lWw0BwE
 vxxxYDY9GS2tZH1o0HXZ06Wvp3S392OE8FNSTZ6HzzuA+QN0FdqAxTdejPCTrd6lAfd2
 aBfJJJegamKdwXnjxLR2dxQI//xhJ4QGpqDzkDHmLSJ11XUImthx5jNpgzYadatvyGHg
 cb5TdXzuXlpiKWwrs3VSOOTplmaCifI2NS5IITEYfYs0ttbk+jbpac9zQXZT+Zps8Ddh
 4uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694044082; x=1694648882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgAxgcyqhu59qzleb8BoU1mSJXsud8avyAYb65wFNbg=;
 b=HKloWWwRq4FkUKD+Ucb1tydR2F7BF6kJSBdnoLuwl4rYtw517O1tP50Avk9QHdrlT5
 SMgPSyfXdBJl+pqCHuRylImpt2rDDiQQtNpm3ZE7FEdTKG3oVW5zKITehIQ4BC/8kL65
 35SzbArXy+cbgFzoTML3v1aheamjst8ZaxZTnRNlj8tBCvFsd9nrG8GLTQ1Qowcit3R4
 P7cdRnMiSVHFudDtX2PaxI2xBR3T2dlY/gbHOtsD6v3w5aMlK/d65V+LarCsBHNnUbFq
 udM9SVdaTCkeACAtcYq8QRBcN6dNaq+KfaQehEuJEJSa1+CDnrroFjkY+PLarUMZMBa2
 i0qw==
X-Gm-Message-State: AOJu0YyBg/F0wCjabD3MgM/NEc9KogmkD3fIKfMtx1MVeMplyenW7Tz2
 PrE+yJD/Gi9QoVlYkmuGu5cqUD3tXyKG
X-Google-Smtp-Source: AGHT+IG7TM90ao+H0jLLHLoLY2F8QLdO3dNzNL314exMSR7c96TkW346HHyt7WL7ljuPYg3r1oEH6Q==
X-Received: by 2002:a81:8287:0:b0:57a:2e83:4daf with SMTP id
 s129-20020a818287000000b0057a2e834dafmr20616492ywf.32.1694044080372; 
 Wed, 06 Sep 2023 16:48:00 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 16:48:00 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 1/6] cxl/mailbox: move mailbox effect definitions to a
 header
Date: Tue,  5 Sep 2023 20:15:12 -0400
Message-Id: <20230906001517.324380-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230906001517.324380-1-gregory.price@memverge.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1142;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1142.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 hw/cxl/cxl-mailbox-utils.c   | 30 +++++++++++++-----------------
 include/hw/cxl/cxl_mailbox.h | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+), 17 deletions(-)
 create mode 100644 include/hw/cxl/cxl_mailbox.h

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4e8651ebe2..b64bbdf45d 100644
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
@@ -1561,28 +1562,21 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-#define IMMEDIATE_CONFIG_CHANGE (1 << 1)
-#define IMMEDIATE_DATA_CHANGE (1 << 2)
-#define IMMEDIATE_POLICY_CHANGE (1 << 3)
-#define IMMEDIATE_LOG_CHANGE (1 << 4)
-#define SECURITY_STATE_CHANGE (1 << 5)
-#define BACKGROUND_OPERATION (1 << 6)
-
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
@@ -1591,9 +1585,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
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
@@ -1612,10 +1608,10 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
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
@@ -1628,7 +1624,7 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
      */
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
-                         IMMEDIATE_POLICY_CHANGE },
+                         CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
@@ -1670,7 +1666,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     /* Only one bg command at a time */
-    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+    if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
         cci->bg.runtime > 0) {
         return CXL_MBOX_BUSY;
     }
@@ -1691,7 +1687,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
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


