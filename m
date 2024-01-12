Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9192482C031
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:57:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5c-00032v-GV; Fri, 12 Jan 2024 07:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5W-0002hm-IG
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5N-0007St-8R
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=apWjp60OGDbXskhoqhQ7L2Unt4rYkRzNC6E6Qr8eL5I=; b=V+NoSuqZEl325GMRL82bXJoKU6
 0+kPuGmtystglOOR/wkSroDzp6al4f3in+gJJxt1t20UL1K+LAUqxtBA5u+DdHIENhHwaiD5B7c1C
 vP95DKs/xxj4Wb08KkCUNI1sfzcuvKt6S/ig2Ry1ZY+CrWPdKVO1gpiVWVy2q65d8XNbkFNDC7tCG
 IUiYGAb93dn0/LFYmSsan7cHEgtepdAXnWHMg1OFOM2f1ModOVTa+yc7Ij/gEHRMfzi4wyayrNzdJ
 3ZglXFcQA9hPzzAhyLg4u75A9/lH8PLSBZ9JpMplZnz0so1SE1t+7PK/LWtz4R5NPQScu/4HMiH/y
 xFIE71sUWeVaZWbHgryIS2mspSik0XUU3FdkcE3PiuH7egefAUdeS9hEodhD9lUTOniNyYZ0sha0D
 VLCfTvUZJIRhnOV5n4NX82EOsYrgdDjTMRMDbpN8INaraJDq/0PoX8hsH7laJ2bGaHJP0sm/L9vta
 Kj9WncVvyhyPebymzr6C9oLnlhpUs28ngfgGS69VWrGPtjlAeCY89G5A6hYyOxGXXPz1Hy1heRe7H
 rhXzsDtgibe/xXpTWTgdakUv6G7zMRI9gOXqNPVvyaMfTwkG47kDcMCQRHNgDyOh2voJ8BIGAw49T
 0DZzM1w7fo3Qag0U+FEVwMpgT2R3YZK9a+Wc35f5o=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4Z-0008jM-71; Fri, 12 Jan 2024 12:55:47 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:21 +0000
Message-Id: <20240112125420.514425-30-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 29/88] esp.c: fix premature end of phase logic
 esp_command_complete
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

There are two cases here: the first is when the TI command underflows, in which
case we raise INTR_BS to indicate an early change of phase, and the second is
when the TI command overflows because the host requested a transfer for more
data than is available. In the latter case force TC to zero so that the TI
completion logic executes correctly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f20026c3dc..c6151d306e 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -887,7 +887,6 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
         if (s->ti_size != 0) {
             trace_esp_command_complete_unexpected();
         }
-        s->ti_size = 0;
     }
 
     s->async_len = 0;
@@ -897,13 +896,26 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
     s->status = req->status;
 
     /*
-     * If the transfer is finished, switch to status phase. For non-DMA
-     * transfers from the target the last byte is still in the FIFO
+     * Switch to status phase. For non-DMA transfers from the target the last
+     * byte is still in the FIFO
      */
+    esp_set_phase(s, STAT_ST);
     if (s->ti_size == 0) {
-        esp_set_phase(s, STAT_ST);
+        /*
+         * Transfer complete: force TC to zero just in case a TI command was
+         * requested for more data than the command returns (Solaris 8 does
+         * this)
+         */
+        esp_set_tc(s, 0);
         esp_dma_done(s);
-        esp_lower_drq(s);
+    } else {
+        /*
+         * Transfer truncated: raise INTR_BS to indicate early change of
+         * phase
+         */
+        s->rregs[ESP_RINTR] |= INTR_BS;
+        esp_raise_irq(s);
+        s->ti_size = 0;
     }
 
     if (s->current_req) {
-- 
2.39.2


