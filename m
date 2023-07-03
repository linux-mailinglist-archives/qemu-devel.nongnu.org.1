Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1FB745D36
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJZW-0000yW-9c; Mon, 03 Jul 2023 09:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZI-0000Wr-Nw
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:16 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJZG-0000pW-JJ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QvmsK6Ymfz4wb1;
 Mon,  3 Jul 2023 23:26:13 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvmsH5HRhz4wqZ;
 Mon,  3 Jul 2023 23:26:11 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 19/32] hw/sd: add emmc_cmd_SEND_TUNING_BLOCK() handler
Date: Mon,  3 Jul 2023 15:24:56 +0200
Message-ID: <20230703132509.2474225-20-clg@kaod.org>
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

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/sd/sd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 95cb46b87519..4b4a4cda2e68 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2212,6 +2212,17 @@ static sd_rsp_type_t emmc_cmd_APP_CMD(SDState *sd, SDRequest req)
     return sd_r0;
 }
 
+static sd_rsp_type_t emmc_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd->state = sd_sendingdata_state;
+    sd->data_offset = 0;
+    return sd_r1;
+}
+
 static const SDProto sd_proto_emmc = {
     .name = "eMMC",
     .cmd = {
@@ -2222,6 +2233,7 @@ static const SDProto sd_proto_emmc = {
         [5]         = sd_cmd_illegal,
         [19]        = sd_cmd_SEND_TUNING_BLOCK,
         [23]        = sd_cmd_SET_BLOCK_COUNT,
+        [21]        = emmc_cmd_SEND_TUNING_BLOCK,
         [41]        = sd_cmd_illegal,
         [52 ... 54] = sd_cmd_illegal,
         [55]        = emmc_cmd_APP_CMD,
-- 
2.41.0


