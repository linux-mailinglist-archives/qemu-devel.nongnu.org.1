Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF282C0AC
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:16:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBL-0005UM-O7; Fri, 12 Jan 2024 08:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAl-00047G-9N
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:11 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHAi-0001ze-5i
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YmsipulYnKdj65V4XC+FS4+WOnQRd8u61l/CYJ7Pnpo=; b=hwKRx6eXB0hQ33apniBrmwjwvf
 Uqn3mWQlmcR7ItMYqb/4XFmBx0+ZxxF3VBdickik/kkYOELeWnRM0bwnktuJL+Tewrr8vPI4trBXC
 14nzZSpjsgazeR9snvWPLTvXqUgxmw8bewDZqV0CGbEgKT5oi7GMY06wtxhtVQIdSbB6hHZSGAqQO
 iiXpQCcXYtMJrv1TjqR0UvipXOJ2ZiHNedF5EN3IsBZ+Jqx2N/Y8KQhlLA6mVDrrQ3P05nmaMISzv
 FkU2cRLqMT/dzrxxd3Z6vdUKQrWi9gh1lOPlhraO8gRWSlxhqoRzcfA9nkjiU3G4kuzth+W0wUfce
 lPnjoLSqd5VL1A7MNF8aO9IkBfMwOYmxZ2xJkdm4uOFyc1b1763We4WZ3UmKh1I0MyZUX/fek1yvg
 90rO5AFyEP25LpOM6KwMXfX9pyBFAjvoJGaPKz+gaddKRQJrdZT3oFDurvzHYDICfTGbXkf0lRSfu
 OzvhttMlvRJIHC2f6cp4lIZSLLG7Xj1oW2aUrJrhZuOAmSHqcd7lvmc8gjJKp2cS4NK7FNzQWnfib
 lIDAgkkY3FHnyWqF2v9J7U4jr91KjkmvwhsWGbT1fGhLOWXjYyXCGeihyLI8U7oRr09BRizxwdus/
 p+bJCgo/ab2wFUQUyAGiTx/xbO9t/vo/pW376yaTA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6i-0008jM-O9; Fri, 12 Jan 2024 12:58:00 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:07 +0000
Message-Id: <20240112125420.514425-76-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 75/88] esp.c: improve ESP_RSEQ logic consolidation
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

The ESP_RSEQ logic is scattered in a few places throughout the ESP state machine
which is mainly because the ESP_RSEQ register isn't always reset when executing
an ESP select command. Once this is done, the ESP_RSEQ register only needs to be
updated at the point where the sequencer command completes.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index aa7dec71e3..ca26415d5f 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -230,6 +230,7 @@ static int esp_select(ESPState *s)
     target = s->wregs[ESP_WBUSID] & BUSID_DID;
 
     s->ti_size = 0;
+    s->rregs[ESP_RSEQ] = SEQ_0;
 
     if (s->current_req) {
         /* Started a new command before the old one finished. Cancel it. */
@@ -241,7 +242,6 @@ static int esp_select(ESPState *s)
         /* No such drive */
         s->rregs[ESP_RSTAT] = 0;
         s->rregs[ESP_RINTR] = INTR_DC;
-        s->rregs[ESP_RSEQ] = SEQ_0;
         esp_raise_irq(s);
         return -1;
     }
@@ -250,7 +250,6 @@ static int esp_select(ESPState *s)
      * Note that we deliberately don't raise the IRQ here: this will be done
      * either in esp_transfer_data() or esp_command_complete()
      */
-    s->rregs[ESP_RSEQ] = SEQ_CD;
     return 0;
 }
 
@@ -358,7 +357,6 @@ static void handle_s_without_atn(ESPState *s)
     }
 
     esp_set_phase(s, STAT_CD);
-    s->rregs[ESP_RSEQ] = SEQ_CD;
     s->cmdfifo_cdb_offset = 0;
 
     if (s->dma) {
@@ -380,7 +378,6 @@ static void handle_satn_stop(ESPState *s)
     }
 
     esp_set_phase(s, STAT_MO);
-    s->rregs[ESP_RSEQ] = SEQ_MO;
     s->cmdfifo_cdb_offset = 0;
 
     if (s->dma) {
@@ -456,6 +453,7 @@ static void esp_do_dma(ESPState *s)
             if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, switch to command phase */
                 esp_set_phase(s, STAT_CD);
+                s->rregs[ESP_RSEQ] = SEQ_CD;
                 s->cmdfifo_cdb_offset = 1;
 
                 if (fifo8_num_used(&s->cmdfifo) > 1) {
@@ -468,11 +466,11 @@ static void esp_do_dma(ESPState *s)
         case CMD_SELATNS | CMD_DMA:
             if (fifo8_num_used(&s->cmdfifo) == 1) {
                 /* First byte received, stop in message out phase */
+                s->rregs[ESP_RSEQ] = SEQ_MO;
                 s->cmdfifo_cdb_offset = 1;
 
                 /* Raise command completion interrupt */
                 s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-                s->rregs[ESP_RSEQ] = SEQ_CD;
                 esp_raise_irq(s);
             }
             break;
@@ -482,7 +480,6 @@ static void esp_do_dma(ESPState *s)
             if (esp_get_tc(s) == 0) {
                 esp_set_phase(s, STAT_CD);
                 s->rregs[ESP_CMD] = 0;
-                s->rregs[ESP_RSEQ] = SEQ_CD;
                 s->rregs[ESP_RINTR] |= INTR_BS;
                 esp_raise_irq(s);
             }
@@ -726,6 +723,7 @@ static void esp_do_nodma(ESPState *s)
             if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, switch to command phase */
                 esp_set_phase(s, STAT_CD);
+                s->rregs[ESP_RSEQ] = SEQ_CD;
                 s->cmdfifo_cdb_offset = 1;
 
                 if (fifo8_num_used(&s->cmdfifo) > 1) {
@@ -738,6 +736,7 @@ static void esp_do_nodma(ESPState *s)
         case CMD_SELATNS:
             if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, stop in message out phase */
+                s->rregs[ESP_RSEQ] = SEQ_MO;
                 s->cmdfifo_cdb_offset = 1;
 
                 /* Raise command completion interrupt */
@@ -903,6 +902,7 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
          * and function complete interrupt
          */
         s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
+        s->rregs[ESP_RSEQ] = SEQ_CD;
         break;
 
     case CMD_TI | CMD_DMA:
@@ -948,6 +948,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              * so raise deferred bus service and function complete interrupt
              */
              s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
+             s->rregs[ESP_RSEQ] = SEQ_CD;
              break;
 
         case CMD_SELATNS | CMD_DMA:
@@ -957,6 +958,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              * completion interrupt
              */
              s->rregs[ESP_RINTR] |= INTR_BS;
+             s->rregs[ESP_RSEQ] = SEQ_MO;
              break;
 
         case CMD_TI | CMD_DMA:
-- 
2.39.2


