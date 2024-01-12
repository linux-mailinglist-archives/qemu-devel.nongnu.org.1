Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1743C82C02A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:56:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH4S-00084w-8E; Fri, 12 Jan 2024 07:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4O-0007yq-Ua
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:32 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4M-0006uM-Pl
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AfcHn9JhGFR8cnvbyQwF08ZVB2JJDc2qmWLxIwV/uug=; b=r9I6jJVqmMT7maosB2JY0KyITT
 rYSeox3Bp5wT1BGxCi4Pw0hF114AY/FqjqFi/wHJZJygR6FLNmq/HrS0wJ3O/fnxN+n8+gmHnoCvw
 g7x3ywDuTpqm7l+OED2q7widBPVpQ+8g59R0xfvDowBxf2vNv12VVbtQKpKgiDgHkruvScSz1DPjY
 o/Sx/euGeK0/5+/Ijb2TwCy+ezriah7Mhoj0hhL2Qrxs5RiahPjggjN321+Qfnv/a5uvc01AWoCRt
 sw+8M3L/HjP06OfkGAn4+QQwTLLzU9S8zfQZHp6/wvrbCSRNlQbgn7suhJh4JRlCJyYF2zre5K3K+
 OGdsTc3iGVvvu89TRth0M/fDvwWwMwAz/iavnt1Vu0kgVB3uvRHJG5JwdC0knCDTsJAhcuxhBQMNY
 Elr4oQRT1ZOajFxGWXNJG7A7E2a5HdqrbDtM8prSc5y2Q+o/lsgC9Eb6ba31eWWJUyF3kuqvGXV9J
 s0cDt7c29lC75Mz1xweSTonsaFvFU2GKxTbBIblDNh8KXNbL0Z/A2yNOySSPt/f6IxkE0H4C5KHt8
 5aFKs9QtPc8gMxPpomSq2/cN/nzFXzZjOVjr8ypWV0r5kb7bDuVdO+m/xQbNd2K/4qYG0b1kGo1yR
 jwxr7xpVQprs4nC4a9MUZToFUaVatim+uaKbmuBVA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3i-0008jM-MF; Fri, 12 Jan 2024 12:54:54 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:06 +0000
Message-Id: <20240112125420.514425-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 14/88] esp.c: introduce esp_set_phase() helper function
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

This function is used to set the current SCSI bus phase in the ESP_RSTAT register
without affecting any of flag bits.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c        | 51 ++++++++++++++++++++++++++++++--------------
 hw/scsi/trace-events |  1 +
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f08b816aba..3fc7417d7c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -183,6 +183,19 @@ static uint32_t esp_get_stc(ESPState *s)
     return dmalen;
 }
 
+static const char *esp_phase_names[8] = {
+    "DATA OUT", "DATA IN", "COMMAND", "STATUS",
+    "(reserved)", "(reserved)", "MESSAGE OUT", "MESSAGE IN"
+};
+
+static void esp_set_phase(ESPState *s, uint8_t phase)
+{
+    s->rregs[ESP_RSTAT] &= ~7;
+    s->rregs[ESP_RSTAT] |= phase;
+
+    trace_esp_set_phase(esp_phase_names[phase]);
+}
+
 static uint8_t esp_pdma_read(ESPState *s)
 {
     uint8_t val;
@@ -316,9 +329,9 @@ static void do_command_phase(ESPState *s)
              * complete before raising the command completion interrupt
              */
             s->data_in_ready = false;
-            s->rregs[ESP_RSTAT] |= STAT_DI;
+            esp_set_phase(s, STAT_DI);
         } else {
-            s->rregs[ESP_RSTAT] |= STAT_DO;
+            esp_set_phase(s, STAT_DO);
             s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
             esp_raise_irq(s);
             esp_lower_drq(s);
@@ -394,7 +407,7 @@ static void handle_satn(ESPState *s)
         s->do_cmd = 1;
         /* Target present, but no cmd yet - switch to command phase */
         s->rregs[ESP_RSEQ] = SEQ_CD;
-        s->rregs[ESP_RSTAT] = STAT_CD;
+        esp_set_phase(s, STAT_CD);
     }
 }
 
@@ -439,7 +452,7 @@ static void handle_s_without_atn(ESPState *s)
         s->do_cmd = 1;
         /* Target present, but no cmd yet - switch to command phase */
         s->rregs[ESP_RSEQ] = SEQ_CD;
-        s->rregs[ESP_RSTAT] = STAT_CD;
+        esp_set_phase(s, STAT_CD);
     }
 }
 
@@ -457,7 +470,8 @@ static void satn_stop_pdma_cb(ESPState *s)
         trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
         s->do_cmd = 1;
         s->cmdfifo_cdb_offset = 1;
-        s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
+        esp_set_phase(s, STAT_CD);
+        s->rregs[ESP_RSTAT] |= STAT_TC;
         s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
         s->rregs[ESP_RSEQ] = SEQ_CD;
         esp_raise_irq(s);
@@ -481,7 +495,7 @@ static void handle_satn_stop(ESPState *s)
         trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
         s->do_cmd = 1;
         s->cmdfifo_cdb_offset = 1;
-        s->rregs[ESP_RSTAT] = STAT_MO;
+        esp_set_phase(s, STAT_MO);
         s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
         s->rregs[ESP_RSEQ] = SEQ_MO;
         esp_raise_irq(s);
@@ -492,13 +506,14 @@ static void handle_satn_stop(ESPState *s)
         s->do_cmd = 1;
         /* Target present, switch to message out phase */
         s->rregs[ESP_RSEQ] = SEQ_MO;
-        s->rregs[ESP_RSTAT] = STAT_MO;
+        esp_set_phase(s, STAT_MO);
     }
 }
 
 static void write_response_pdma_cb(ESPState *s)
 {
-    s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+    esp_set_phase(s, STAT_ST);
+    s->rregs[ESP_RSTAT] |= STAT_TC;
     s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
     s->rregs[ESP_RSEQ] = SEQ_CD;
     esp_raise_irq(s);
@@ -516,7 +531,8 @@ static void write_response(ESPState *s)
     if (s->dma) {
         if (s->dma_memory_write) {
             s->dma_memory_write(s->dma_opaque, buf, 2);
-            s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+            esp_set_phase(s, STAT_ST);
+            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
         } else {
@@ -575,7 +591,8 @@ static void do_dma_pdma_cb(ESPState *s)
              * and then switch to command phase
              */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
-            s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
+            esp_set_phase(s, STAT_CD);
+            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
@@ -681,7 +698,8 @@ static void esp_do_dma(ESPState *s)
              * and then switch to command phase
              */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
-            s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
+            esp_set_phase(s, STAT_CD);
+            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
@@ -810,7 +828,8 @@ static void esp_do_nodma(ESPState *s)
              * and then switch to command phase
              */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
-            s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
+            esp_set_phase(s, STAT_CD);
+            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
@@ -904,8 +923,7 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
      * transfers from the target the last byte is still in the FIFO
      */
     if (s->ti_size == 0) {
-        s->rregs[ESP_RSTAT] &= ~7;
-        s->rregs[ESP_RSTAT] |= STAT_ST;
+        esp_set_phase(s, STAT_ST);
         esp_dma_done(s);
         esp_lower_drq(s);
     }
@@ -1065,7 +1083,7 @@ static void esp_run_cmd(ESPState *s)
         trace_esp_mem_writeb_cmd_iccs(cmd);
         write_response(s);
         s->rregs[ESP_RINTR] |= INTR_FC;
-        s->rregs[ESP_RSTAT] |= STAT_MI;
+        esp_set_phase(s, STAT_MI);
         break;
     case CMD_MSGACC:
         trace_esp_mem_writeb_cmd_msgacc(cmd);
@@ -1133,7 +1151,8 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
                      * The last byte of a non-DMA transfer has been read out
                      * of the FIFO so switch to status phase
                      */
-                    s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+                    esp_set_phase(s, STAT_ST);
+                    s->rregs[ESP_RSTAT] |= STAT_TC;
                 }
             }
             s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index bdd4e2c7c7..d72f741ed8 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -197,6 +197,7 @@ esp_mem_writeb_cmd_selatns(uint32_t val) "Select with ATN & stop (0x%2.2x)"
 esp_mem_writeb_cmd_ensel(uint32_t val) "Enable selection (0x%2.2x)"
 esp_mem_writeb_cmd_dissel(uint32_t val) "Disable selection (0x%2.2x)"
 esp_mem_writeb_cmd_ti(uint32_t val) "Transfer Information (0x%2.2x)"
+esp_set_phase(const char *phase) "setting bus phase to %s"
 
 # esp-pci.c
 esp_pci_error_invalid_dma_direction(void) "invalid DMA transfer direction"
-- 
2.39.2


