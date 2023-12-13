Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BF581127D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:06:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDOtP-00010E-It; Wed, 13 Dec 2023 08:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOsA-0008LC-7Y; Wed, 13 Dec 2023 08:01:59 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOs6-00075v-D0; Wed, 13 Dec 2023 08:01:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DB2003B443;
 Wed, 13 Dec 2023 16:01:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7C2693C8D4;
 Wed, 13 Dec 2023 16:00:42 +0300 (MSK)
Received: (nullmailer pid 1024742 invoked by uid 1000);
 Wed, 13 Dec 2023 13:00:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 M_O_Bz <m_o_bz@163.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.8 16/24] hw/audio/hda-codec: fix multiplication overflow
Date: Wed, 13 Dec 2023 16:00:25 +0300
Message-Id: <20231213130041.1024630-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
References: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20231105172552.8405-1-vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 74e8593e7e51d6b11ae9c56a3f4e7bb714bac4ec)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index feb8f9e2bb..0f66754b6a 100644
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
@@ -190,9 +191,9 @@ struct HDAAudioState {
     bool     use_timer;
 };
 
-static inline int64_t hda_bytes_per_second(HDAAudioStream *st)
+static inline uint32_t hda_bytes_per_second(HDAAudioStream *st)
 {
-    return 2LL * st->as.nchannels * st->as.freq;
+    return 2 * (uint32_t)st->as.nchannels * (uint32_t)st->as.freq;
 }
 
 static inline void hda_timer_sync_adjust(HDAAudioStream *st, int64_t target_pos)
@@ -223,12 +224,18 @@ static void hda_audio_input_timer(void *opaque)
 
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
@@ -287,12 +294,18 @@ static void hda_audio_output_timer(void *opaque)
 
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
2.39.2


