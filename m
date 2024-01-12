Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C12EC82C029
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:56:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH4H-0007kS-Tr; Fri, 12 Jan 2024 07:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4G-0007kG-3z
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:24 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4E-0006qA-Et
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qwygGo0CcBS3qdJUdX8c4HByuf6EAaxnYb+eq38j2qo=; b=wfmjNwZQvJK4Vjwp2+IVSH7bEh
 Z7QqDS77Y8ax9TaorTAyNfdqN2RXUaLB7nC6Errve+vT1fkW8QPkkhlkM/1JiJ+tdKzFQ/nAUZEBG
 W1eCaudIP2K2HzVor3+4EntXlRgFRvH6uAj0svHvxReizpl3imE4Lw+yohd+nvGDZ6gmjila8cCja
 kFcY1EQ/sjN6vcY4AcE5t/lZJEIoKxiCHG23bwRrtNo8YCN03zYqsgaR/t72vGwJT9MTedRRSSMC/
 UZqu10cn35SV1gErZ/MfLvYje/hILK7Zn8SYQNVcZJVf1C3rpz51wcvG03wZMkyfyW+3R5ZQF07Z7
 G+odaVMJlNPVspljYBty4Opp4MFYjj5mB/UQqQkDn2X6XBJzw2HrNPO5r2Bsd5o5EnjXhr95Y7AG8
 Bvrp6MiawSuxF8T5+OQ/VBm1O3AQPNwO3VDyE2E1f3xa2JKF1A2Kejp60+mb9WkbSmnqv1eDqj3i8
 iBjZXBfApOo0yTA1IvZ5X2+WksHEyK5trzeeKW7rtTuRN6KqpiE6CoNSCKstcAXup8EDphVVQyGmC
 yikSv4e8BdztbIglE4HME/YCIDTI1twrxabkjOF17L1gBtWj0G6CeviY/v4cd+RYJN8QQV24BKLa5
 0rFUi1ZdMwZ89FLWvBQLPXryUPYo2OBjYpkKFlsxA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3a-0008jM-2s; Fri, 12 Jan 2024 12:54:46 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:04 +0000
Message-Id: <20240112125420.514425-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 12/88] esp.c: don't accumulate directly into cmdfifo
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

Instead accumulate in the real FIFO as done in real hardware, and then transfer
to cmdfifo when we're ready to process the MESSAGE OUT and COMMAND phase data.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 6191c17f10..9e9bbe8431 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -199,11 +199,7 @@ static void esp_pdma_write(ESPState *s, uint8_t val)
         return;
     }
 
-    if (s->do_cmd) {
-        esp_fifo_push(&s->cmdfifo, val);
-    } else {
-        esp_fifo_push(&s->fifo, val);
-    }
+    esp_fifo_push(&s->fifo, val);
 
     dmalen--;
     esp_set_tc(s, dmalen);
@@ -358,6 +354,14 @@ static void do_cmd(ESPState *s)
 
 static void satn_pdma_cb(ESPState *s)
 {
+    uint8_t buf[ESP_FIFO_SZ];
+    int n;
+
+    /* Copy FIFO into cmdfifo */
+    n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+    n = MIN(fifo8_num_free(&s->cmdfifo), n);
+    fifo8_push_all(&s->cmdfifo, buf, n);
+
     if (!esp_get_tc(s) && !fifo8_is_empty(&s->cmdfifo)) {
         s->cmdfifo_cdb_offset = 1;
         s->do_cmd = 0;
@@ -395,6 +399,14 @@ static void handle_satn(ESPState *s)
 
 static void s_without_satn_pdma_cb(ESPState *s)
 {
+    uint8_t buf[ESP_FIFO_SZ];
+    int n;
+
+    /* Copy FIFO into cmdfifo */
+    n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+    n = MIN(fifo8_num_free(&s->cmdfifo), n);
+    fifo8_push_all(&s->cmdfifo, buf, n);
+
     if (!esp_get_tc(s) && !fifo8_is_empty(&s->cmdfifo)) {
         s->cmdfifo_cdb_offset = 0;
         s->do_cmd = 0;
@@ -432,6 +444,14 @@ static void handle_s_without_atn(ESPState *s)
 
 static void satn_stop_pdma_cb(ESPState *s)
 {
+    uint8_t buf[ESP_FIFO_SZ];
+    int n;
+
+    /* Copy FIFO into cmdfifo */
+    n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+    n = MIN(fifo8_num_free(&s->cmdfifo), n);
+    fifo8_push_all(&s->cmdfifo, buf, n);
+
     if (!esp_get_tc(s) && !fifo8_is_empty(&s->cmdfifo)) {
         trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
         s->do_cmd = 1;
@@ -523,10 +543,16 @@ static void esp_dma_done(ESPState *s)
 static void do_dma_pdma_cb(ESPState *s)
 {
     int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    uint8_t buf[ESP_CMDFIFO_SZ];
     int len;
     uint32_t n;
 
     if (s->do_cmd) {
+        /* Copy FIFO into cmdfifo */
+        n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+        n = MIN(fifo8_num_free(&s->cmdfifo), n);
+        fifo8_push_all(&s->cmdfifo, buf, n);
+
         /* Ensure we have received complete command after SATN and stop */
         if (esp_get_tc(s) || fifo8_is_empty(&s->cmdfifo)) {
             return;
@@ -754,10 +780,16 @@ static void esp_do_dma(ESPState *s)
 static void esp_do_nodma(ESPState *s)
 {
     int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    uint8_t buf[ESP_FIFO_SZ];
     uint32_t cmdlen;
-    int len;
+    int len, n;
 
     if (s->do_cmd) {
+        /* Copy FIFO into cmdfifo */
+        n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+        n = MIN(fifo8_num_free(&s->cmdfifo), n);
+        fifo8_push_all(&s->cmdfifo, buf, n);
+
         cmdlen = fifo8_num_used(&s->cmdfifo);
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
@@ -1159,7 +1191,10 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
         break;
     case ESP_FIFO:
         if (s->do_cmd) {
-            esp_fifo_push(&s->cmdfifo, val);
+            if (!fifo8_is_full(&s->fifo)) {
+                esp_fifo_push(&s->fifo, val);
+                esp_fifo_push(&s->cmdfifo, fifo8_pop(&s->fifo));
+            }
 
             /*
              * If any unexpected message out/command phase data is
-- 
2.39.2


