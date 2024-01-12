Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF6182C07D
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:06:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH6Q-00068Q-EB; Fri, 12 Jan 2024 07:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6L-0005e1-Bq
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:33 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6I-00085L-NV
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c77aZQsYe7pho4cvIx5xwNADDh2K4Z7Pz/sry5fvQ+U=; b=A2XS3h9suXTtMX6R3CXVwhf6QZ
 eaYH01UbNH2fe8kStg9gEn08DKshm6ZnUGIfq8tOO7VjBmTGgrh1UacKrM9NGUmTrZdOWc4SbKvov
 4E61q/XY8JBzTESsORj9/k5TiNPqxaXYhpVOerOCD209JOc1Rczqr2d+/3cFcYy0+ApTwagKV+Zox
 NwxAMbv3VngZe3j06J674WFHMpp0ZdPEHN33B16yi5YPuwFjO2mNtcqdqNz4EzacC3zlS47uHzYvW
 uW/s9n3h4V9FMMRJO3TtgJjX8P+q4qZg7yBKDPltskWHk3XNjMgAR1F4wxdlydYTwcc6cktKmveSK
 xPsd0M/RQ4UkCVhdZ5UTfj2/8YjRescc/mhiEV0pyGeYeiyYn9qbm2BJkXpSyxyusNufo6A88E4gP
 uYgoXP1Q9KBWfVWeQj7//c2Ztc5fF+LzIhGCBueR5Emq26NF5tmXmcunEJOW9jhnRRYjrQrUxAasD
 eq8uQVvdtvZFHEWePeK7AUFDGVid3/BFoleoTPsERKbaiWqTawib9+1CVYiAhO3Yx9WJMhve18Wc6
 155dPh8PtMktpktLUdxveGIruar7QgS+41S5j3ARwb6mBleLDbdyvnE/mGg62JDvB2t3+/iB3ulqG
 sepKF78t8+K3m8UAWwiJi7amzXY8MUQKIpcAa+AE8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5U-0008jM-1f; Fri, 12 Jan 2024 12:56:44 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:40 +0000
Message-Id: <20240112125420.514425-49-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 48/88] esp.c: untangle MESSAGE OUT and COMMAND phase logic in
 esp_do_nodma()
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

This makes it clearer that ATN is asserted until the end of the next TI command
in the MESSAGE OUT phase.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 7ab195f884..81144ace83 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -801,6 +801,23 @@ static void esp_do_nodma(ESPState *s)
 
     switch (esp_get_phase(s)) {
     case STAT_MO:
+        /* Copy FIFO into cmdfifo */
+        n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+        n = MIN(fifo8_num_free(&s->cmdfifo), n);
+        fifo8_push_all(&s->cmdfifo, buf, n);
+        s->cmdfifo_cdb_offset += n;
+
+        /*
+         * Extra message out bytes received: update cmdfifo_cdb_offset
+         * and then switch to command phase
+         */
+        s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
+        esp_set_phase(s, STAT_CD);
+        s->rregs[ESP_RSEQ] = SEQ_CD;
+        s->rregs[ESP_RINTR] |= INTR_BS;
+        esp_raise_irq(s);
+        break;
+
     case STAT_CD:
         /* Copy FIFO into cmdfifo */
         n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
@@ -810,25 +827,14 @@ static void esp_do_nodma(ESPState *s)
         cmdlen = fifo8_num_used(&s->cmdfifo);
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
-        if (esp_get_phase(s) == STAT_CD) {
-            /* No command received */
-            if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
-                return;
-            }
 
-            /* Command has been received */
-            do_cmd(s);
-        } else {
-            /*
-             * Extra message out bytes received: update cmdfifo_cdb_offset
-             * and then switch to command phase
-             */
-            s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
-            esp_set_phase(s, STAT_CD);
-            s->rregs[ESP_RSEQ] = SEQ_CD;
-            s->rregs[ESP_RINTR] |= INTR_BS;
-            esp_raise_irq(s);
+        /* No command received */
+        if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
+            return;
         }
+
+        /* Command has been received */
+        do_cmd(s);
         break;
 
     case STAT_DO:
-- 
2.39.2


