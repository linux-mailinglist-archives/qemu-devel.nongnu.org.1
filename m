Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F998587AE
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Feb 2024 22:08:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb5QT-0006BE-6S; Fri, 16 Feb 2024 16:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QR-0006AK-QD
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:15 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QQ-0005Oh-6d
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/CxDqHS9crhtz8sbTfN1gtZ311MXUlC4KQUJRPAGct8=; b=GuzhnaVs9PHMCNnwrfNnSNjuiE
 XLeIFcU0h+Xeg/6mq932h+j8uq1Aq32aBrq+hoktTwJcWAuJRan8Z9eQc7l3KEDwSoqrJSekNMF7P
 CtdIPGhv94DCxrTNdQXaRSyPMYr1vM1rljLhTTFw/2htgyUg32aBAk5XAdK5GfsGvLQEKajDHi8yX
 jj1p01ojuODBKYM8MfdyYpZNiB7USs9IV2acS9Y0UGUtNldF/wyWQsM3ITq3s4bZYwfXZE0kbRi18
 HqohkaRmnx7LfD86DtXjaMufDworBN7dlKsG0t6lxzDMAdgYUZMkMxHKNU6w6tu+WYWAAGLn4DB80
 AjI+9U6JD1Pape0CJZ9UzUbTRvzmIOQVDqtN06Z6ZO4KmLWDKkhfisbBAo2WGZEH54jouDYZrshs1
 DXfBwHQww5yubvosu5OutuUDPfWAJnGxFRM6KHmBsfh6nctngF8KDqrjH7VpYP6PBWkGlrlUwgbYd
 UfgeFmKUof7isBA6o/8Ln+DPSD4fRm6mCND4iymGczPGvGsmcIOmSe7UHB03ZLwuHLiXQQLg3AMUk
 2qt8OJZpbbs2BOfOQ5oEUh2v5N68z18RUYeWOl0l9KVKcE1D7s6pUNNgDQ3jB6insYWTGvO59BkU+
 OvPK/XHc7bWJ0Hz7tndFqFl8BBARKst6c69Vr8Psk=;
Received: from [2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Pd-0000vT-Cz; Fri, 16 Feb 2024 21:06:29 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Fri, 16 Feb 2024 21:06:26 +0000
Message-Id: <20240216210633.1376066-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
References: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 06/13] esp.c: use esp_fifo_push() instead of fifo8_push()
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

There are still a few places that use fifo8_push() instead of esp_fifo_push() in
order to push a value into the FIFO. Update those places to use esp_fifo_push()
instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 0e42ff50e7..fb2ceca36a 100644
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


