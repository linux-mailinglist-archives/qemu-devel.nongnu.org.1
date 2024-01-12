Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F270582C051
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:01:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH3r-0007fO-3D; Fri, 12 Jan 2024 07:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3m-0007eS-Ub
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:54 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3k-0006Rs-SU
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Z7t6nFfDDvi+pCFGJVq7Tjpp5/DfqHou+6ng4VXJgs=; b=q5Vc8FrxbzrL6PDqZvsDYBcc1y
 kaxPjSBk4NwaKgqWL8/CYnZNxBdi3AyOlqniklVm+BvzYPSfOvWY4y4Z2TlxextOCl8z2owwZycaO
 tkauEdMR/85y7gny7G1bayDpGgL0Qp3qtx0bQSJpJgP6Rl6AiKtM54xGSdT9zEtuhVMPRjwJ7sl9V
 Qvh7oYDTc9WdhSVZqEkeXutVZ+2F7c3txAYod/2QglliEjraepMh1JZr+nW527AsZ1thwGd46WdRo
 VGdNQRE522Bo8nfXiPc6TQLh+Kkt0T0gObRWPfiZFFaaw8BB9jeh6srqS82roZMaW9KAtVrhCglBh
 qqgGRsARCWhXdpLJvU/F/2ajx1fJ7kUlKurHeDht4TRGYNKfs2bRCIOGI9Cqk1us9e4QEGzB2+QI7
 oL/TqBCMI9i0AQALrWkda5E8suBVJbTB34gktk+kPL/5rY349lFcNtw/WTvY7Opu70QxEagrQMYnM
 ZjeMDicECq1dQI343OJCL7nKXXaeJ+MDcXq1iXTpcjeiGUb8kDmpClcmfVUs0OrcqSfnXK0e44qab
 rc8XE7GXNNpMiykj/qUxEdH2JEU27NMJRgYt6mXEKSYHXuTnKj9k2iUE2k25TKO0YXAR2AuOerLes
 7PLCPxjLD4oVTVnXT3Kj1FFyLYHiM6xJy23l5TSFY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH39-0008jM-Ow; Fri, 12 Jan 2024 12:54:15 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:52:57 +0000
Message-Id: <20240112125420.514425-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 05/88] esp: move esp_select() to ESP selection commands from
 get_cmd()
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

Since the DREQ value depends upon the result of the selection process, add a
workaround to each esp_select() to manually assert DREQ durring the MESSAGE OUT
and COMMAND phases.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 89fce05e58..8c1c6bfc1c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -263,10 +263,6 @@ static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
             dmalen = MIN(fifo8_num_free(&s->cmdfifo), dmalen);
             fifo8_push_all(&s->cmdfifo, buf, dmalen);
         } else {
-            if (esp_select(s) < 0) {
-                return -1;
-            }
-            esp_raise_drq(s);
             return 0;
         }
     } else {
@@ -280,9 +276,6 @@ static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
     }
     trace_esp_get_cmd(dmalen, target);
 
-    if (esp_select(s) < 0) {
-        return -1;
-    }
     return dmalen;
 }
 
@@ -380,12 +373,18 @@ static void handle_satn(ESPState *s)
         return;
     }
     esp_set_pdma_cb(s, SATN_PDMA_CB);
+    if (esp_select(s) < 0) {
+        return;
+    }
     cmdlen = get_cmd(s, ESP_CMDFIFO_SZ);
     if (cmdlen > 0) {
         s->cmdfifo_cdb_offset = 1;
         s->do_cmd = 0;
         do_cmd(s);
     } else if (cmdlen == 0) {
+        if (s->dma) {
+            esp_raise_drq(s);
+        }
         s->do_cmd = 1;
         /* Target present, but no cmd yet - switch to command phase */
         s->rregs[ESP_RSEQ] = SEQ_CD;
@@ -411,12 +410,18 @@ static void handle_s_without_atn(ESPState *s)
         return;
     }
     esp_set_pdma_cb(s, S_WITHOUT_SATN_PDMA_CB);
+    if (esp_select(s) < 0) {
+        return;
+    }
     cmdlen = get_cmd(s, ESP_CMDFIFO_SZ);
     if (cmdlen > 0) {
         s->cmdfifo_cdb_offset = 0;
         s->do_cmd = 0;
         do_cmd(s);
     } else if (cmdlen == 0) {
+        if (s->dma) {
+            esp_raise_drq(s);
+        }
         s->do_cmd = 1;
         /* Target present, but no cmd yet - switch to command phase */
         s->rregs[ESP_RSEQ] = SEQ_CD;
@@ -446,6 +451,9 @@ static void handle_satn_stop(ESPState *s)
         return;
     }
     esp_set_pdma_cb(s, SATN_STOP_PDMA_CB);
+    if (esp_select(s) < 0) {
+        return;
+    }
     cmdlen = get_cmd(s, 1);
     if (cmdlen > 0) {
         trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
@@ -456,6 +464,9 @@ static void handle_satn_stop(ESPState *s)
         s->rregs[ESP_RSEQ] = SEQ_MO;
         esp_raise_irq(s);
     } else if (cmdlen == 0) {
+        if (s->dma) {
+            esp_raise_drq(s);
+        }
         s->do_cmd = 1;
         /* Target present, switch to message out phase */
         s->rregs[ESP_RSEQ] = SEQ_MO;
-- 
2.39.2


