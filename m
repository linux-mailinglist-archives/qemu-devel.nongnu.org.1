Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E24267C4AA2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 08:32:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqSlO-00022C-M2; Wed, 11 Oct 2023 02:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSl4-0001uy-1Y
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSl1-0006vv-Be
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697005904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tWqwVQF3157amZZ5ksaSk/rCTrrBE0eeyc4Y+fPAp80=;
 b=haghCBCbjx/y3maO/ZBNpyCE8QaSqeJtyQ3K2F3gh5iHTPVkj47Z9pIyf46w7RBmGkM/3e
 V7LnwIfE1fFoGX7TaJsZqzAWzliAjKANJ8EKiRsQZYtNebXp/Q4WNfT2QgaKRfZPQ1Rf88
 E1OHpOH1UMP80IbiDkICeP99tIneZsE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-ijDaAIM4OYyieC_3tIpkCw-1; Wed, 11 Oct 2023 02:31:33 -0400
X-MC-Unique: ijDaAIM4OYyieC_3tIpkCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB986185A790;
 Wed, 11 Oct 2023 06:31:32 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A38861C060DF;
 Wed, 11 Oct 2023 06:31:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	stefanha@redhat.com,
	vr_qemu@t-online.de
Subject: [PULL 6/8] hw/audio/es1370: block structure coding style fixes
Date: Wed, 11 Oct 2023 10:30:59 +0400
Message-ID: <20231011063101.258955-7-marcandre.lureau@redhat.com>
In-Reply-To: <20231011063101.258955-1-marcandre.lureau@redhat.com>
References: <20231011063101.258955-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Volker Rümelin <vr_qemu@t-online.de>

Change the block structure according to the QEMU Coding Style
documentation.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230917065813.6692-6-vr_qemu@t-online.de>
---
 hw/audio/es1370.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 7c58337076..b4c00df189 100644
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
2.41.0


