Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7761B745D4C
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:29:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJZ4-00008t-MK; Mon, 03 Jul 2023 09:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJYx-0008UA-S1
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:25:56 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJYw-0000mr-0v
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:25:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qvmrv4npNz4wxm;
 Mon,  3 Jul 2023 23:25:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qvmrr6hCJz4wZp;
 Mon,  3 Jul 2023 23:25:48 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 11/32] hw/sd: Add sd_cmd_SEND_TUNING_BLOCK() handler
Date: Mon,  3 Jul 2023 15:24:48 +0200
Message-ID: <20230703132509.2474225-12-clg@kaod.org>
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

From: Joel Stanley <joel@jms.id.au>

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
[PMD: Rebased]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/sd/sd.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b46072424108..00a59450b726 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1062,6 +1062,22 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
+{
+        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
+            return sd_cmd_illegal(sd, req);
+        }
+
+        if (sd->state != sd_transfer_state) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
+
+        sd->state = sd_sendingdata_state;
+        sd->data_offset = 0;
+
+        return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint32_t rca = 0x0000;
@@ -1305,17 +1321,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 19:    /* CMD19: SEND_TUNING_BLOCK (SD) */
-        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
-            return sd_invalid_state_for_cmd(sd, req);
-        }
-        if (sd->state == sd_transfer_state) {
-            sd->state = sd_sendingdata_state;
-            sd->data_offset = 0;
-            return sd_r1;
-        }
-        break;
-
     case 23:    /* CMD23: SET_BLOCK_COUNT */
         if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
             return sd_invalid_state_for_cmd(sd, req);
@@ -2152,6 +2157,7 @@ static const SDProto sd_proto_sd = {
         [2]         = sd_cmd_ALL_SEND_CID,
         [3]         = sd_cmd_SEND_RELATIVE_ADDR,
         [5]         = sd_cmd_illegal,
+        [19]        = sd_cmd_SEND_TUNING_BLOCK,
         [52 ... 54] = sd_cmd_illegal,
         [58]        = sd_cmd_illegal,
         [59]        = sd_cmd_illegal,
-- 
2.41.0


