Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F20887EA2
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Mar 2024 20:19:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTLs-0007Q8-8w; Sun, 24 Mar 2024 15:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLp-0007PK-ST
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:49 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLo-0005Ky-J2
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZImesGrYTVTEbQaTCEC+yRfyFm8yDyZ54209wpINORg=; b=nVkbpAQULKMHuc27JO7IatpoQ0
 vsGwExZnWsdCOZolWfX6Girty8h+Vs+IvZlXboG99pdlrABpqNnFtLzdKd05K7aALbAxOi+KaxLhR
 3QFX/n4Z8USyBAgB7S2mrRXjdRx1Pvz2gObyB/m+cK8iHrlO3wN/89kCF6jXfFWOmLhwe8S3/7Ytk
 J8LS99GNQdgDqaLd0Dw/F3YTY5gQCNt4Yer81/+PZR0o5Igg2QzhZHsKGioPT0Er1xxCLNL8h8bmv
 zeX32+5gW1bjFcECbzvQrSjoCMZjngYYZhcddxWeEG6lxLlfW7KJP9g5zstOKnvS0+JtIQ/ruqSwt
 YI0JSaXMJgYTnQ7IilyGJmPs2YOrG5eizi9yKPC/FoEuZQEd7SCukS/03DRaZTnK3tOi8/XeR5qs3
 wQFMo5W4MZCZ7Q6s2jDc9Vz94YYOcppir4waSkmuB+2/GzVpNQmb91Wlda+o/Sttnxv8zmsfmEB0n
 6R4GZvHmhh3vUXaBVbH508kWiKS/bH1SqUiJX/LawlI/KWotYE4tYoS1PASS40WQbsXSM7+lGr11e
 hXVDF8WavyKdbdq0zjvhSA2g3ItVtXkuxPuOKIBT3Bi4O8P+vQRgIyaiGf6eITiAO166/G1Q6JI1X
 SFT5f6sZOS/DeqrAdvWgj/J5QrbYpPS8qlPlEA0XQ=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTKp-0000dj-Bb; Sun, 24 Mar 2024 19:16:51 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:16:56 +0000
Message-Id: <20240324191707.623175-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 07/17] esp.c: use esp_fifo_push() instead of fifo8_push()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are still a few places that use fifo8_push() instead of esp_fifo_push() in
order to push a value into the FIFO. Update those places to use esp_fifo_push()
instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index d474268438..8d2d36d56c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -858,7 +858,7 @@ static void esp_do_nodma(ESPState *s)
             return;
         }
         if (fifo8_is_empty(&s->fifo)) {
-            fifo8_push(&s->fifo, s->async_buf[0]);
+            esp_fifo_push(s, s->async_buf[0]);
             s->async_buf++;
             s->async_len--;
             s->ti_size--;
@@ -881,7 +881,7 @@ static void esp_do_nodma(ESPState *s)
     case STAT_ST:
         switch (s->rregs[ESP_CMD]) {
         case CMD_ICCS:
-            fifo8_push(&s->fifo, s->status);
+            esp_fifo_push(s, s->status);
             esp_set_phase(s, STAT_MI);
 
             /* Process any message in phase data */
@@ -893,7 +893,7 @@ static void esp_do_nodma(ESPState *s)
     case STAT_MI:
         switch (s->rregs[ESP_CMD]) {
         case CMD_ICCS:
-            fifo8_push(&s->fifo, 0);
+            esp_fifo_push(s, 0);
 
             /* Raise end of command interrupt */
             s->rregs[ESP_RINTR] |= INTR_FC;
-- 
2.39.2


