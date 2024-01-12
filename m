Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B236782C076
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHAU-0003Cs-QN; Fri, 12 Jan 2024 08:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9g-0002mQ-IN
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:04 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9d-0001Wh-Bk
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AH7kvaRfyBpaN6wRUabwxD93irCPDXxz0fMJ6vNsumo=; b=NvsXR8YCVnHXKXoZ+XFtkygWEc
 tH7vk+ZLgwvBeIjrUNlogL0hsnrHN40n2Xocx+xdBMNAmacNf2y+WCZe6J5uiGROMPpEMP4ieS1+y
 3jJP5zIW2aK4SOGFmEWi8DBamcxrZNjg8ri0Fus7LZBwru40WCjiTwt/w127fZ5Wn23RJyFpGNC/6
 mdw5LN4SoCfyxFLtsWNDalLNxOyAsmt0isSraRNeq6PFkARtnoCKe7BP3eM/iMqDh0sDoKb2Q6ugg
 5Pj9ipn0O9AqL+bi9EMYDWSyQHBk6/GFqEvsROw5Cb+LnVVVfMmhJO5EkHDFgNZnSQpjJlKkS79K3
 zYkvWwXHzR9BkkT3imPWX8nX29R3PI5rGVOzjbSOm6gwnCs1R6gz7TzI9C15XC6TjeMQzaWbRToii
 EQxOQOqLmURWTshSV5Ph7POGEtXQx0NBPrmnAKbpkpE4D6kWxAvvt6NLWjxBc6+ZLE86VZ0V8fNfr
 xz60NiwiBnqQYL29gIXu0EiuQ0VGkFLqJYKZe7I/PvY6jFn88IFiK/+hwfQY8hkODVXtOkMNEqEZ1
 9AhFbt7DR2oyM4mgiRbNedhc+YTZk3YWVuxwuZw6vPalHDEs7PCF+fGNcndh947W9pmGFUehPilSR
 eRRy3lhAS6P0tIaURjw/47rXRXd3YoguVkGcY8xBI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6F-0008jM-VZ; Fri, 12 Jan 2024 12:57:32 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:56 +0000
Message-Id: <20240112125420.514425-65-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 64/88] esp.c: don't raise INTR_BS interrupt in DATA IN phase
 until TI command issued
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

In the case where a SCSI command with a DATA IN phase has been issued, the host
may preload the FIFO with unaligned bytes before issuing the main DMA transfer.

When accumulating data in the FIFO don't raise the INTR_BS interrupt until the
TI command is issued, otherwise the unexpected interrupt can confuse the host.
In particular this is needed to prevent the MacOS Disk Utility from failing
when switching non-DMA transfers to use esp_do_nodma().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index bcebd00831..dd6bf6f033 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -786,6 +786,11 @@ static void esp_do_nodma(ESPState *s)
             return;
         }
 
+        /* If preloading the FIFO, defer until TI command issued */
+        if (s->rregs[ESP_CMD] != CMD_TI) {
+            return;
+        }
+
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
         break;
-- 
2.39.2


