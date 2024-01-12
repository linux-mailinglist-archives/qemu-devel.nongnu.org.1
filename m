Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C27D82C083
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:07:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHDi-00053Z-Jc; Fri, 12 Jan 2024 08:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCm-0004My-DK
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:04:15 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCk-00032q-Am
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3qX0hv0RhPB8tC6ZQexYbL35eZAx1aD0Ti58keQafw8=; b=lGEW8RnY5wJjylhY91EUEkdd3d
 qysDdOYAfp31l1eO+WgpJvP2M5PbxwlbL/YozH7vSLWMKJjot1Ikv0PCPNk+RO85jIP+wYZbSAvQo
 L3DdihhbRmYnNEyjYQdMjcwjbnoDusAgpViD43BsvFjHppuxaNYkZ1spAoxCH3GMSZxwFwfy9ssyP
 uSepbbaNHU45hkUGThWRoPLbuo7fpmVFsLmXrjHElyA5RYCfIYUhQ9UHz40M68Ftru0uErh+68Y5S
 QA7EZCls6mZVVfq0ANftPFHqKbWbUoRLg4AvbbzOkJeIFxXbqilhQBay7dFgm4ImsUUr3EN9vKvvR
 prB0RNG/CwA+KJXt0d4/YpeXcOBYdLFn8yBg/cN+jMhfZWZZpcmjlL4F0FYVFpKKPx8jfOhYauSP7
 HlOldn7U5AXfobnFCh6D98ZVxMzjydoprV50HbaRxhD5aZnK4O9W81Xp5/Qna4EDQCNWvXOI//yFq
 HiUgtt1AJzTv1Hgwo4enwkidTbc1yveQhuaoReQjsiY75cbrYXNg90u7imEzeLCiDRoT9H1edfE9/
 MWh0Oz1yzidLTotB0bqfZy8i6kjOFlzi08pHrlb9ZuyUgzRXtoCD+DSvRX8vf+jZugX3eUBIw7sUl
 K9JbVlqKIh49pJbPHZeha/K9g0WJ4w2MgtwtUBgNg=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6Q-0008jM-RD; Fri, 12 Jan 2024 12:57:42 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:01 +0000
Message-Id: <20240112125420.514425-70-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 69/88] esp.c: consolidate end of command sequence after ICCS
 command
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

The end of command sequences for the ICCS command are currently different
between the DMA and non-DMA versions, and also different from the description
in the datasheet.

Update the sequence so that only INTR_FC is asserted in both cases, and keep
all the logic in esp_do_dma() and esp_do_nodma() rather than having some of
it within esp_run_cmd().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 824ebe9ff0..6c62417985 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -650,8 +650,7 @@ static void esp_do_dma(ESPState *s)
                 }
 
                 /* Raise end of command interrupt */
-                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-                s->rregs[ESP_RSEQ] = SEQ_CD;
+                s->rregs[ESP_RINTR] |= INTR_FC;
                 esp_raise_irq(s);
             }
             break;
@@ -825,6 +824,8 @@ static void esp_do_nodma(ESPState *s)
         case CMD_ICCS:
             fifo8_push(&s->fifo, 0);
 
+            /* Raise end of command interrupt */
+            s->rregs[ESP_RINTR] |= INTR_FC;
             esp_raise_irq(s);
             break;
         }
@@ -1056,8 +1057,6 @@ static void esp_run_cmd(ESPState *s)
     case CMD_ICCS:
         trace_esp_mem_writeb_cmd_iccs(cmd);
         write_response(s);
-        s->rregs[ESP_RINTR] |= INTR_FC;
-        esp_set_phase(s, STAT_MI);
         break;
     case CMD_MSGACC:
         trace_esp_mem_writeb_cmd_msgacc(cmd);
-- 
2.39.2


