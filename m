Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92151745D29
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:26:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJYl-0008R8-PA; Mon, 03 Jul 2023 09:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJYe-0008QF-P9
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:25:36 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJYc-0000kE-LC
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:25:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QvmrX4rZGz4wxm;
 Mon,  3 Jul 2023 23:25:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvmrT6vYPz4wZp;
 Mon,  3 Jul 2023 23:25:29 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 05/32] hw/sd: Add sd_cmd_illegal() handler
Date: Mon,  3 Jul 2023 15:24:42 +0200
Message-ID: <20230703132509.2474225-6-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703132509.2474225-1-clg@kaod.org>
References: <20230703132509.2474225-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mKPa=CV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Log illegal commands as GUEST_ERROR.

Note: we are logging back the SDIO commands (CMD5, CMD52-54).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Message-Id: <20210624142209.1193073-6-f4bug@amsat.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/sd/sd.c | 62 +++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 889c44a5c07c..83a0d6825147 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1002,6 +1002,15 @@ static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown CMD%i for spec %s\n",
+                  sd_proto(sd)->name, req.cmd,
+                  sd_version_str(sd->spec_version));
+
+    return sd_illegal;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint32_t rca = 0x0000;
@@ -1054,15 +1063,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 1:  /* CMD1:   SEND_OP_CMD */
-        if (!sd->spi)
-            goto bad_cmd;
-
         sd->state = sd_transfer_state;
         return sd_r1;
 
     case 2:  /* CMD2:   ALL_SEND_CID */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_ready_state:
             sd->state = sd_identification_state;
@@ -1074,8 +1078,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 3:  /* CMD3:   SEND_RELATIVE_ADDR */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_identification_state:
         case sd_standby_state:
@@ -1089,8 +1091,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 4:  /* CMD4:   SEND_DSR */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_standby_state:
             break;
@@ -1100,9 +1100,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 5: /* CMD5: reserved for SDIO cards */
-        return sd_illegal;
-
     case 6:  /* CMD6:   SWITCH_FUNCTION */
         switch (sd->mode) {
         case sd_data_transfer_mode:
@@ -1118,8 +1115,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 7:  /* CMD7:   SELECT/DESELECT_CARD */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_standby_state:
             if (sd->rca != rca)
@@ -1249,8 +1244,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 15:  /* CMD15:  GO_INACTIVE_STATE */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->mode) {
         case sd_data_transfer_mode:
             if (sd->rca != rca)
@@ -1303,7 +1296,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     case 19:    /* CMD19: SEND_TUNING_BLOCK (SD) */
         if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
-            goto bad_cmd;
+            return sd_invalid_state_for_cmd(sd, req);
         }
         if (sd->state == sd_transfer_state) {
             sd->state = sd_sendingdata_state;
@@ -1314,7 +1307,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     case 23:    /* CMD23: SET_BLOCK_COUNT */
         if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
-            goto bad_cmd;
+            return sd_invalid_state_for_cmd(sd, req);
         }
         switch (sd->state) {
         case sd_transfer_state:
@@ -1357,8 +1350,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_transfer_state:
             sd->state = sd_receivingdata_state;
@@ -1508,15 +1499,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 52 ... 54:
-        /* CMD52, CMD53, CMD54: reserved for SDIO cards
-         * (see the SDIO Simplified Specification V2.0)
-         * Handle as illegal command but do not complain
-         * on stderr, as some OSes may use these in their
-         * probing for presence of an SDIO card.
-         */
-        return sd_illegal;
-
     /* Application specific commands (Class 8) */
     case 55:  /* CMD55:  APP_CMD */
         switch (sd->state) {
@@ -1557,19 +1539,12 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 58:    /* CMD58:   READ_OCR (SPI) */
-        if (!sd->spi) {
-            goto bad_cmd;
-        }
         return sd_r3;
 
     case 59:    /* CMD59:   CRC_ON_OFF (SPI) */
-        if (!sd->spi) {
-            goto bad_cmd;
-        }
         return sd_r1;
 
     default:
-    bad_cmd:
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
         return sd_illegal;
     }
@@ -2156,10 +2131,25 @@ void sd_enable(SDState *sd, bool enable)
 
 static const SDProto sd_proto_spi = {
     .name = "SPI",
+    .cmd = {
+        [2 ... 4]   = sd_cmd_illegal,
+        [5]         = sd_cmd_illegal,
+        [7]         = sd_cmd_illegal,
+        [15]        = sd_cmd_illegal,
+        [26]        = sd_cmd_illegal,
+        [52 ... 54] = sd_cmd_illegal,
+    },
 };
 
 static const SDProto sd_proto_sd = {
     .name = "SD",
+    .cmd = {
+        [1]         = sd_cmd_illegal,
+        [5]         = sd_cmd_illegal,
+        [52 ... 54] = sd_cmd_illegal,
+        [58]        = sd_cmd_illegal,
+        [59]        = sd_cmd_illegal,
+    },
 };
 
 static void sd_instance_init(Object *obj)
-- 
2.41.0


