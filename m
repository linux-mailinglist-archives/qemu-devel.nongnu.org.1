Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8990C82C07B
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:06:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHCU-0003bX-5T; Fri, 12 Jan 2024 08:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCK-0002za-0t
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:44 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCI-0002fr-Cm
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Kh8ctsP6aKA0lMz/rYJ3sO368U+kPgcGR1gxhjIZa4=; b=iL8bcbpsBi22qqtNyUxej9u9BD
 yL7Qarz2jN8q001ODLqEpyFvFJLetOZ9+ilNExiAhSRKDOwlY1dKUqraFeQqN76VeHtnlV6ROnOiv
 STM2BJHgzq+VTJfIxjU50hpba/FteXB9pVbtD6MJwfo/3WJ53kW4laC92zfodcp9wU+QYY7BSdK7x
 3YiEDRmYoji88Urnu/Of3iyTW+9qmozp1L7nxQIoxanoMPPzVyDDnZT0yin98LtkiLOhah76BAWqj
 iYSsYQaXzhwfzPf68VrjBZ7KPtM6XTUakRPZSj3NHLvuohQRQLw1NGzhwmFRhXd8rPekDij5qcM0h
 IPareXhEp73jgurKKnFU4gbJstjo5iRr/u/GTlvKVP8QcXLexmXXsuLlYtaT2Kb2cR8QMcUfsnfxY
 lvB6bVmL7ZzKXgbWgRVZnzXrDHwqeB6/S3nwRzZF/9VVgfEXw8Nn8EJJyknsdvMc87aTPn0k2Mkp4
 Sp3dvchotNcTo0x+/EOLLSVgfaWWEUzJKh4TTGeFM7wDre62XGJRZsGffZM1dAXD9FxTzaUxtjRRq
 fZQXFR7uoOwXIN29ZmBD4eUJVlsKZ0chtAKVSu2w5M6rE1awaPWXk7xeJLrtfUbgsQJBuev3sxgk5
 thivtMgAE8km7Dz22g5UWLRsFv2zywVtABrgrFq3Q=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH67-0008jM-C7; Fri, 12 Jan 2024 12:57:23 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:54 +0000
Message-Id: <20240112125420.514425-63-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 62/88] esp.c: zero command register when TI command terminates
 due to phase change
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

This is the behaviour documented in the datasheet and allows the state machine
to correctly process multiple consecutive TI commands.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 4c1ca63a57..ccb8ad4bae 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -519,6 +519,7 @@ static void esp_do_dma(ESPState *s)
             /* ATN remains asserted until TC == 0 */
             if (esp_get_tc(s) == 0) {
                 esp_set_phase(s, STAT_CD);
+                s->rregs[ESP_CMD] = 0;
                 s->rregs[ESP_RSEQ] = SEQ_CD;
                 s->rregs[ESP_RINTR] |= INTR_BS;
                 esp_raise_irq(s);
@@ -717,6 +718,7 @@ static void esp_do_nodma(ESPState *s)
          */
         s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
         esp_set_phase(s, STAT_CD);
+        s->rregs[ESP_CMD] = 0;
         s->rregs[ESP_RSEQ] = SEQ_CD;
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
@@ -831,6 +833,11 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
          */
         s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
         break;
+
+    case CMD_TI | CMD_DMA:
+    case CMD_TI:
+        s->rregs[ESP_CMD] = 0;
+        break;
     }
 
     /* Raise bus service interrupt to indicate change to STATUS phase */
@@ -885,6 +892,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              * Bus service interrupt raised because of initial change to
              * DATA phase
              */
+            s->rregs[ESP_CMD] = 0;
             s->rregs[ESP_RINTR] |= INTR_BS;
             break;
         }
-- 
2.39.2


