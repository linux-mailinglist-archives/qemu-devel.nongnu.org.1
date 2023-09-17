Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B47A3404
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 08:59:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhljl-0006uw-TC; Sun, 17 Sep 2023 02:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljj-0006uF-DX
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:31 -0400
Received: from mailout05.t-online.de ([194.25.134.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljg-00052Q-UY
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:31 -0400
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
 by mailout05.t-online.de (Postfix) with SMTP id EFC9C143F8;
 Sun, 17 Sep 2023 08:58:26 +0200 (CEST)
Received: from linpower.localnet ([79.208.31.89]) by fwd86.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qhljd-4E4Qt70; Sun, 17 Sep 2023 08:58:26 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id A32B7200207; Sun, 17 Sep 2023 08:58:13 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 6/8] hw/audio/es1370: block structure coding style fixes
Date: Sun, 17 Sep 2023 08:58:11 +0200
Message-Id: <20230917065813.6692-6-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
References: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694933906-F77E4EBC-299B1698/0/0 CLEAN NORMAL
X-TOI-MSGID: bb812899-75bc-4e23-afbf-8b72bd9506bd
Received-SPF: none client-ip=194.25.134.82;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout05.t-online.de
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

Change the block structure according to the QEMU Coding Style
documentation.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/es1370.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index e1ca6a4cd5..86a869d4da 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -309,8 +309,7 @@ static void es1370_update_status (ES1370State *s, uint32_t new_status)
 
     if (level) {
         s->status = new_status | STAT_INTR;
-    }
-    else {
+    } else {
         s->status = new_status & ~STAT_INTR;
     }
     pci_set_irq(&s->dev, !!level);
@@ -333,8 +332,7 @@ static void es1370_reset (ES1370State *s)
         if (i == ADC_CHANNEL) {
             AUD_close_in (&s->card, s->adc_voice);
             s->adc_voice = NULL;
-        }
-        else {
+        } else {
             AUD_close_out (&s->card, s->dac_voice[i]);
             s->dac_voice[i] = NULL;
         }
@@ -421,8 +419,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
                             es1370_adc_callback,
                             &as
                             );
-                }
-                else {
+                } else {
                     s->dac_voice[i] =
                         AUD_open_out (
                             &s->card,
@@ -442,8 +439,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
 
             if (i == ADC_CHANNEL) {
                 AUD_set_active_in (s->adc_voice, on);
-            }
-            else {
+            } else {
                 AUD_set_active_out (s->dac_voice[i], on);
             }
         }
@@ -456,8 +452,9 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
 static inline uint32_t es1370_fixup (ES1370State *s, uint32_t addr)
 {
     addr &= 0xff;
-    if (addr >= 0x30 && addr <= 0x3f)
+    if (addr >= 0x30 && addr <= 0x3f) {
         addr |= s->mempage << 8;
+    }
     return addr;
 }
 
@@ -630,8 +627,9 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
 
             to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
             acquired = AUD_read (s->adc_voice, tmpbuf, to_copy);
-            if (!acquired)
+            if (!acquired) {
                 break;
+            }
 
             pci_dma_write (&s->dev, addr, tmpbuf, acquired);
 
@@ -639,8 +637,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
             addr += acquired;
             transferred += acquired;
         }
-    }
-    else {
+    } else {
         SWVoiceOut *voice = s->dac_voice[index];
 
         while (temp > 0) {
@@ -649,8 +646,9 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
             to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
             pci_dma_read (&s->dev, addr, tmpbuf, to_copy);
             copied = AUD_write (voice, tmpbuf, to_copy);
-            if (!copied)
+            if (!copied) {
                 break;
+            }
             temp -= copied;
             addr += copied;
             transferred += copied;
@@ -660,8 +658,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     if (csc_bytes == transferred) {
         *irq = 1;
         d->scount = sc | (sc << 16);
-    }
-    else {
+    } else {
         *irq = 0;
         d->scount = sc | (((csc_bytes - transferred - 1) >> d->shift) << 16);
     }
@@ -672,12 +669,12 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
         /* Bah, how stupid is that having a 0 represent true value?
            i just spent few hours on this shit */
         AUD_log ("es1370: warning", "non looping mode\n");
-    }
-    else {
+    } else {
         d->frame_cnt = size;
 
-        if ((uint32_t) cnt <= d->frame_cnt)
+        if ((uint32_t) cnt <= d->frame_cnt) {
             d->frame_cnt |= cnt << 16;
+        }
     }
 
     d->leftover = (transferred + d->leftover) & 3;
@@ -778,8 +775,7 @@ static int es1370_post_load (void *opaque, int version_id)
                 AUD_close_in (&s->card, s->adc_voice);
                 s->adc_voice = NULL;
             }
-        }
-        else {
+        } else {
             if (s->dac_voice[i]) {
                 AUD_close_out (&s->card, s->dac_voice[i]);
                 s->dac_voice[i] = NULL;
-- 
2.35.3


