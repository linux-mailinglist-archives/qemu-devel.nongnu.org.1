Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4037A3407
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 08:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhljr-0006w0-2y; Sun, 17 Sep 2023 02:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljo-0006vG-QH
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:36 -0400
Received: from mailout02.t-online.de ([194.25.134.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljn-000556-1B
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:36 -0400
Received: from fwd72.aul.t-online.de (fwd72.aul.t-online.de [10.223.144.98])
 by mailout02.t-online.de (Postfix) with SMTP id 0CBDA3ADF;
 Sun, 17 Sep 2023 08:58:33 +0200 (CEST)
Received: from linpower.localnet ([79.208.31.89]) by fwd72.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qhljg-0lLi8P0; Sun, 17 Sep 2023 08:58:28 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id A6431200208; Sun, 17 Sep 2023 08:58:13 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 7/8] hw/audio/es1370: change variable type and name
Date: Sun, 17 Sep 2023 08:58:12 +0200
Message-Id: <20230917065813.6692-7-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
References: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694933908-737FD980-9081658E/0/0 CLEAN NORMAL
X-TOI-MSGID: 1a6b1dad-2f6c-4764-bcb0-06b4c47d892f
Received-SPF: none client-ip=194.25.134.17;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout02.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Change the type of the variable temp to size_t to avoid a type
cast. While at it, rename the variable name to to_transfer. This
improves the readability of the code.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/es1370.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 86a869d4da..6d2aff57f2 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -605,6 +605,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
                                    int max, int *irq)
 {
     uint8_t tmpbuf[4096];
+    size_t to_transfer;
     uint32_t addr = d->frame_addr;
     int sc = d->scount & 0xffff;
     int csc = d->scount >> 16;
@@ -616,16 +617,16 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     }
     int left = ((size - cnt + 1) << 2) + d->leftover;
     int transferred = 0;
-    int temp = MIN (max, MIN (left, csc_bytes));
     int index = d - &s->chan[0];
 
+    to_transfer = MIN(max, MIN(left, csc_bytes));
     addr += (cnt << 2) + d->leftover;
 
     if (index == ADC_CHANNEL) {
-        while (temp > 0) {
+        while (to_transfer > 0) {
             int acquired, to_copy;
 
-            to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
+            to_copy = MIN(to_transfer, sizeof(tmpbuf));
             acquired = AUD_read (s->adc_voice, tmpbuf, to_copy);
             if (!acquired) {
                 break;
@@ -633,23 +634,23 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
 
             pci_dma_write (&s->dev, addr, tmpbuf, acquired);
 
-            temp -= acquired;
+            to_transfer -= acquired;
             addr += acquired;
             transferred += acquired;
         }
     } else {
         SWVoiceOut *voice = s->dac_voice[index];
 
-        while (temp > 0) {
+        while (to_transfer > 0) {
             int copied, to_copy;
 
-            to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
+            to_copy = MIN(to_transfer, sizeof(tmpbuf));
             pci_dma_read (&s->dev, addr, tmpbuf, to_copy);
             copied = AUD_write (voice, tmpbuf, to_copy);
             if (!copied) {
                 break;
             }
-            temp -= copied;
+            to_transfer -= copied;
             addr += copied;
             transferred += copied;
         }
-- 
2.35.3


