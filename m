Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E91BC745D2B
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:26:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJYw-0008Sa-Ur; Mon, 03 Jul 2023 09:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJYl-0008Rh-8q
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:25:43 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJYj-0000lA-Kd
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:25:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qvmrf6X1nz4wb1;
 Mon,  3 Jul 2023 23:25:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qvmrc1S9cz4wZp;
 Mon,  3 Jul 2023 23:25:35 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 07/32] hw/sd: Add sd_cmd_GO_IDLE_STATE() handler
Date: Mon,  3 Jul 2023 15:24:44 +0200
Message-ID: <20230703132509.2474225-8-clg@kaod.org>
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Message-Id: <20210624142209.1193073-8-f4bug@amsat.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/sd/sd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e88bfcb8c802..535b72ff5c2a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1020,6 +1020,16 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_inactive_state) {
+        sd->state = sd_idle_state;
+        sd_reset(DEVICE(sd));
+    }
+
+    return sd->spi ? sd_r1 : sd_r0;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint32_t rca = 0x0000;
@@ -1059,18 +1069,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 0:  /* CMD0:   GO_IDLE_STATE */
-        switch (sd->state) {
-        case sd_inactive_state:
-            return sd->spi ? sd_r1 : sd_r0;
-
-        default:
-            sd->state = sd_idle_state;
-            sd_reset(DEVICE(sd));
-            return sd->spi ? sd_r1 : sd_r0;
-        }
-        break;
-
     case 1:  /* CMD1:   SEND_OP_CMD */
         sd->state = sd_transfer_state;
         return sd_r1;
@@ -2132,6 +2130,7 @@ void sd_enable(SDState *sd, bool enable)
 static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
+        [0]         = sd_cmd_GO_IDLE_STATE,
         [2 ... 4]   = sd_cmd_illegal,
         [5]         = sd_cmd_illegal,
         [7]         = sd_cmd_illegal,
@@ -2147,6 +2146,7 @@ static const SDProto sd_proto_spi = {
 static const SDProto sd_proto_sd = {
     .name = "SD",
     .cmd = {
+        [0]         = sd_cmd_GO_IDLE_STATE,
         [1]         = sd_cmd_illegal,
         [5]         = sd_cmd_illegal,
         [52 ... 54] = sd_cmd_illegal,
-- 
2.41.0


