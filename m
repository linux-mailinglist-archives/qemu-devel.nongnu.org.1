Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793647E1572
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 18:26:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzgt1-0001OO-3v; Sun, 05 Nov 2023 12:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qzgsy-0001OC-UH
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 12:26:08 -0500
Received: from mailout06.t-online.de ([194.25.134.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qzgsw-0006va-QB
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 12:26:08 -0500
Received: from fwd70.aul.t-online.de (fwd70.aul.t-online.de [10.223.144.96])
 by mailout06.t-online.de (Postfix) with SMTP id 611F84973;
 Sun,  5 Nov 2023 18:26:02 +0100 (CET)
Received: from linpower.localnet ([93.236.156.187]) by fwd70.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qzgsj-0PFCNd0; Sun, 5 Nov 2023 18:25:53 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id BEFFC2002D8; Sun,  5 Nov 2023 18:25:52 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, M_O_Bz <M_O_Bz@163.com>, linwei6@ruijie.com.cn
Subject: [PATCH 1/2] hw/audio/hda-codec: fix multiplication overflow
Date: Sun,  5 Nov 2023 18:25:51 +0100
Message-Id: <20231105172552.8405-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <6f8b1f96-4520-49d5-8a09-b2935ab4bd9d@t-online.de>
References: <6f8b1f96-4520-49d5-8a09-b2935ab4bd9d@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1699205153-F894633D-2A38B07D/0/0 CLEAN NORMAL
X-TOI-MSGID: 4b476fa0-738d-419c-8907-c4eb5fe76348
Received-SPF: pass client-ip=194.25.134.19;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout06.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

After a relatively short time, there is an multiplication overflow
when multiplying (now - buft_start) with hda_bytes_per_second().
While the uptime now - buft_start only overflows after 2**63 ns
= 292.27 years, this happens hda_bytes_per_second() times faster
with the multiplication. At 44100 samples/s * 2 channels
* 2 bytes/channel = 176400 bytes/s that is 14.52 hours. After the
multiplication overflow the affected audio stream stalls.

Replace the multiplication and following division with muldiv64()
to prevent a multiplication overflow.

Fixes: 280c1e1cdb ("audio/hda: create millisecond timers that handle IO")
Reported-by: M_O_Bz <m_o_bz@163.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/hda-codec.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index b9ad1f4c39..f756e419bb 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -22,6 +22,7 @@
 #include "hw/qdev-properties.h"
 #include "intel-hda.h"
 #include "migration/vmstate.h"
+#include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "intel-hda-defs.h"
 #include "audio/audio.h"
@@ -189,9 +190,9 @@ struct HDAAudioState {
     bool     use_timer;
 };
 
-static inline int64_t hda_bytes_per_second(HDAAudioStream *st)
+static inline uint32_t hda_bytes_per_second(HDAAudioStream *st)
 {
-    return 2LL * st->as.nchannels * st->as.freq;
+    return 2 * (uint32_t)st->as.nchannels * (uint32_t)st->as.freq;
 }
 
 static inline void hda_timer_sync_adjust(HDAAudioStream *st, int64_t target_pos)
@@ -222,12 +223,18 @@ static void hda_audio_input_timer(void *opaque)
 
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-    int64_t buft_start = st->buft_start;
+    int64_t uptime = now - st->buft_start;
     int64_t wpos = st->wpos;
     int64_t rpos = st->rpos;
+    int64_t wanted_rpos;
 
-    int64_t wanted_rpos = hda_bytes_per_second(st) * (now - buft_start)
-                          / NANOSECONDS_PER_SECOND;
+    if (uptime <= 0) {
+        /* wanted_rpos <= 0 */
+        goto out_timer;
+    }
+
+    wanted_rpos = muldiv64(uptime, hda_bytes_per_second(st),
+                           NANOSECONDS_PER_SECOND);
     wanted_rpos &= -4; /* IMPORTANT! clip to frames */
 
     if (wanted_rpos <= rpos) {
@@ -286,12 +293,18 @@ static void hda_audio_output_timer(void *opaque)
 
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-    int64_t buft_start = st->buft_start;
+    int64_t uptime = now - st->buft_start;
     int64_t wpos = st->wpos;
     int64_t rpos = st->rpos;
+    int64_t wanted_wpos;
+
+    if (uptime <= 0) {
+        /* wanted_wpos <= 0 */
+        goto out_timer;
+    }
 
-    int64_t wanted_wpos = hda_bytes_per_second(st) * (now - buft_start)
-                          / NANOSECONDS_PER_SECOND;
+    wanted_wpos = muldiv64(uptime, hda_bytes_per_second(st),
+                           NANOSECONDS_PER_SECOND);
     wanted_wpos &= -4; /* IMPORTANT! clip to frames */
 
     if (wanted_wpos <= wpos) {
-- 
2.35.3


