Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F03745D56
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:31:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJZ3-00006L-Px; Mon, 03 Jul 2023 09:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJYv-0008TT-DJ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:25:53 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJYs-0000mM-Sk
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:25:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qvmrr2sR1z4wqZ;
 Mon,  3 Jul 2023 23:25:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qvmrn4x6bz4wZp;
 Mon,  3 Jul 2023 23:25:45 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 10/32] hw/sd: Add sd_cmd_SEND_RELATIVE_ADDR() handler
Date: Mon,  3 Jul 2023 15:24:47 +0200
Message-ID: <20230703132509.2474225-11-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703132509.2474225-1-clg@kaod.org>
References: <20230703132509.2474225-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mKPa=CV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20210624142209.1193073-11-f4bug@amsat.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/sd/sd.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 33ecff496ade..b46072424108 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1048,6 +1048,20 @@ static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
     return sd_r2_i;
 }
 
+static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_identification_state:
+    case sd_standby_state:
+        sd->state = sd_standby_state;
+        sd_set_rca(sd);
+        return sd_r6;
+
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint32_t rca = 0x0000;
@@ -1087,19 +1101,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 3:  /* CMD3:   SEND_RELATIVE_ADDR */
-        switch (sd->state) {
-        case sd_identification_state:
-        case sd_standby_state:
-            sd->state = sd_standby_state;
-            sd_set_rca(sd);
-            return sd_r6;
-
-        default:
-            break;
-        }
-        break;
-
     case 4:  /* CMD4:   SEND_DSR */
         switch (sd->state) {
         case sd_standby_state:
@@ -2149,6 +2150,7 @@ static const SDProto sd_proto_sd = {
         [0]         = sd_cmd_GO_IDLE_STATE,
         [1]         = sd_cmd_illegal,
         [2]         = sd_cmd_ALL_SEND_CID,
+        [3]         = sd_cmd_SEND_RELATIVE_ADDR,
         [5]         = sd_cmd_illegal,
         [52 ... 54] = sd_cmd_illegal,
         [58]        = sd_cmd_illegal,
-- 
2.41.0


