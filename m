Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D199F9D190E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Nov 2024 20:37:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD7Xc-0006sB-W0; Mon, 18 Nov 2024 14:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD7XQ-0006fg-2n; Mon, 18 Nov 2024 14:35:56 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD7XN-0002ii-ED; Mon, 18 Nov 2024 14:35:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA831A54E9;
 Mon, 18 Nov 2024 22:35:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 69FA31735A6;
 Mon, 18 Nov 2024 22:35:21 +0300 (MSK)
Received: (nullmailer pid 2312705 invoked by uid 1000);
 Mon, 18 Nov 2024 19:35:20 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [Stable-8.2.8 60/61] hw/audio/hda: fix memory leak on audio setup
Date: Mon, 18 Nov 2024 22:35:15 +0300
Message-Id: <20241118193520.2312620-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.8-20241118211929@cover.tls.msk.ru>
References: <qemu-stable-8.2.8-20241118211929@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

When SET_STREAM_FORMAT is called, the st->buft timer is overwritten, thus
causing a memory leak.  This was originally fixed in commit 816139ae6a5
("hw/audio/hda: fix memory leak on audio setup", 2024-11-14) but that
caused the audio to break in SPICE.

Fortunately, a simpler fix is possible.  The timer only needs to be
reset, because the callback is always the same (st->output is set at
realize time in hda_audio_init); call to timer_new_ns overkill.  Replace
it with timer_del and only initialize the timer once; for simplicity,
do it even if use_timer is false.

An even simpler fix would be to free the old time in hda_audio_setup().
However, it seems better to place the initialization of the timer close
to that of st->ouput.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20241114125318.1707590-3-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 626b39006d2f9b1378a04cb88a2187bb852cb055)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 19f401cabe..ac908e56c6 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -487,8 +487,7 @@ static void hda_audio_setup(HDAAudioStream *st)
     if (st->output) {
         if (use_timer) {
             cb = hda_audio_output_cb;
-            st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                    hda_audio_output_timer, st);
+            timer_del(st->buft);
         } else {
             cb = hda_audio_compat_output_cb;
         }
@@ -497,8 +496,7 @@ static void hda_audio_setup(HDAAudioStream *st)
     } else {
         if (use_timer) {
             cb = hda_audio_input_cb;
-            st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                    hda_audio_input_timer, st);
+            timer_del(st->buft);
         } else {
             cb = hda_audio_compat_input_cb;
         }
@@ -726,8 +724,12 @@ static void hda_audio_init(HDACodecDevice *hda,
                 st->gain_right = QEMU_HDA_AMP_STEPS;
                 st->compat_bpos = sizeof(st->compat_buf);
                 st->output = true;
+                st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                        hda_audio_output_timer, st);
             } else {
                 st->output = false;
+                st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                        hda_audio_input_timer, st);
             }
             st->format = AC_FMT_TYPE_PCM | AC_FMT_BITS_16 |
                 (1 << AC_FMT_CHAN_SHIFT);
@@ -750,9 +752,7 @@ static void hda_audio_exit(HDACodecDevice *hda)
         if (st->node == NULL) {
             continue;
         }
-        if (a->use_timer) {
-            timer_free(st->buft);
-        }
+        timer_free(st->buft);
         if (st->output) {
             AUD_close_out(&a->card, st->voice.out);
         } else {
-- 
2.39.5


