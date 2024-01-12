Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9EA82C06C
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHC7-0002A7-56; Fri, 12 Jan 2024 08:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBx-0001eH-3o
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:22 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBs-0002OS-Sj
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZO5PmPAUOowGailjrSg7vG1qJlLEPqgqkC2eSQUBz3s=; b=RseBXJjRprC6QN1XmYXUsU4m6M
 D0xqswkjCxkEIkK554mnMqDyhSTR2jOpfz9OHSTP7aRXOmoBRdIuUiwsJhtrM/rj+Y4KRwsdX5lU1
 x9gmeMCI+1njY4g5iVdZ4vPLwWdTL7eeKnMvsnkHOqDtCEq6ymW1kppY9fZEMmj8j+aKdTmr8Lx8n
 QxqmDTqZLd7PodwtTdDaW2gDSWaWuL+hsve2qSzwlFggxFaymmYMU2936UrolLefsIhw2OSkQgsDT
 aIyfLhr62EneyFw/UISvXd9D15PV9tqzFWQy6wmDLN1F28QQ7DWf1gfqbLgbXmMwm1+gR/4kqETed
 irrIUW0ZeK1GPMk+uzDQEmiKDHprcCCW9mTbZINt+WD44Agp+v477jEGde5doetiyGOe0rIgbPoHQ
 +BrSHhyfGosNGKONkNzMYdTUzWjaD8C+mYXR4DVsrC0ZWH1BFOjftKLRe8tbM1KHGOxRt4l9RqLr8
 wPplaVVIPPnJRmuVz9QxnRpqMxFXFCWyXCd/GwAdy9s3NoTB/arRXrDK3/Sg9WFXBVo/CSfSrljp3
 KNo0Z+oumWGiT9ZMKyLfRQGeCyCPO0Knu4TOSECs+vsxauvINNyi64ez7mr/z8qMDkiDkVXeAWB/U
 +x5/J6pg2aRCE+JvkaSoxQifJtNeiAHpORNimsHdA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5v-0008jM-Pu; Fri, 12 Jan 2024 12:57:11 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:50 +0000
Message-Id: <20240112125420.514425-59-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 58/88] esp.c: separate logic based upon ESP command in
 esp_command_complete()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The handling of the INTR_FC and INTR_BS bits is different depending upon the
last command executed by the ESP. Note that currently INTR_FC is managed
elsewhere, but that will change soon.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 73c723afcc..75538f5859 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -823,25 +823,27 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
      * Switch to status phase. For non-DMA transfers from the target the last
      * byte is still in the FIFO
      */
-    esp_set_phase(s, STAT_ST);
-    if (s->ti_size == 0) {
-        /*
-         * Transfer complete: force TC to zero just in case a TI command was
-         * requested for more data than the command returns (Solaris 8 does
-         * this)
-         */
-        esp_set_tc(s, 0);
-        esp_dma_ti_check(s);
-    } else {
+    s->ti_size = 0;
+
+    switch (s->rregs[ESP_CMD]) {
+    case CMD_SEL | CMD_DMA:
+    case CMD_SEL:
+    case CMD_SELATN | CMD_DMA:
+    case CMD_SELATN:
         /*
-         * Transfer truncated: raise INTR_BS to indicate early change of
-         * phase
+         * No data phase for sequencer command so raise deferred bus service
+         * interrupt
          */
         s->rregs[ESP_RINTR] |= INTR_BS;
-        esp_raise_irq(s);
-        s->ti_size = 0;
+        break;
     }
 
+    /* Raise bus service interrupt to indicate change to STATUS phase */
+    esp_set_phase(s, STAT_ST);
+    s->rregs[ESP_RINTR] |= INTR_BS;
+    esp_raise_irq(s);
+    esp_lower_drq(s);
+
     if (s->current_req) {
         scsi_req_unref(s->current_req);
         s->current_req = NULL;
-- 
2.39.2


