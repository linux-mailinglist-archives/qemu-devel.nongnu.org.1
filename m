Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C0682C032
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:57:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH69-0005E2-2c; Fri, 12 Jan 2024 07:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH61-0004wM-Fi
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:13 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5x-0007vD-E9
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dWCao+pH3JlS1wOi5u68nSmhJ+bHGx6WXb1iP8+2Sdc=; b=TsYuvBUaI7exEj7/dcQLlxhFds
 1JhYCWWUZiGdwPq9MvCfv1Sa/PPtyH3XE5JTJcWJJZzp6qkoZ1TB80d/hQ/Zur+EjIQnlqfOEcfku
 3E1HDhWaHMm6htDWExEuH3HB72kyOzgGrKa5sGcK1giZUTy5yT4rGCGc+R66YSKY+1T5oOyDz3gY4
 P6zDQCOhFu57R2iMeOHtVSxA7jTmAfRMC2ViuyeYfA1oYFQ0++YD9o+2R5RM5U2JSs/OaE0uH6e6n
 9eLsPgPO35McRVeePBREXRVQMu/uhtO0QPl/QCKDFDHOtLT/gG7s3XhzPw0pdh+k1fPnb0yZvQHzM
 j3Z4g7ZOzRNdhV3ZgziLLC0N5oL+Mv1MWP3DuY/zlpnzgqcSfK6qXD5bSViowy339sgUohGAzeNbs
 EmOI5sfV31VV/Jh8RQaZfR+ZSlmXoydbpzxD7LW+rjo9k7gpV+quEw6LlaAuSgjrYtVGlkkdITUcZ
 jZY0+aLhIycE4GBuWLgBl+tBMXwdRgHwN6amFzJwdYNCw1vkhoiqJ9yy5L+PKetkVxUHbIQbgShz6
 LGrRztD1SzhMVsYh/HxqfjJpxg71ryZwZ6oa2qx+SJcNvQVAuags83Ze1OL7S7oNLEAG2IaeAfUIN
 zUL6EGQ7Eu1x23o5lAXawD3XeH0Jtsptkp5FG7Duk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5A-0008jM-G1; Fri, 12 Jan 2024 12:56:24 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:35 +0000
Message-Id: <20240112125420.514425-44-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 43/88] esp.c: convert esp_do_nodma() do_cmd path to check for
 SCSI phase instead
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

Currently do_cmd is used to determine whether MESSAGE OUT and COMMAND phase data
is being accumulated in cmdfifo. Update esp_do_dma() to check directly for these
two SCSI phases instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index b48e020689..14759ada78 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -787,7 +787,9 @@ static void esp_do_nodma(ESPState *s)
     uint32_t cmdlen;
     int len, n;
 
-    if (s->do_cmd) {
+    switch (esp_get_phase(s)) {
+    case STAT_MO:
+    case STAT_CD:
         /* Copy FIFO into cmdfifo */
         n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
         n = MIN(fifo8_num_free(&s->cmdfifo), n);
@@ -816,10 +818,8 @@ static void esp_do_nodma(ESPState *s)
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
         }
-        return;
-    }
+        break;
 
-    switch (esp_get_phase(s)) {
     case STAT_DO:
         if (!s->current_req) {
             return;
-- 
2.39.2


