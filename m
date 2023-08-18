Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A738778045C
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:24:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWq4V-0007Ru-NK; Thu, 17 Aug 2023 23:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m_o_bz@163.com>) id 1qWq4T-0007QE-6w
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:22:45 -0400
Received: from m12.mail.163.com ([220.181.12.199])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <m_o_bz@163.com>) id 1qWq4O-00004x-7K
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=31qCj
 GtUi6Mud1nHsJu2fpGL0YO/zHs8tY6CmlEjMTU=; b=DOglM/fSEt68nQbnm6B9x
 /M+I1iniQ6IPFAXqLon5/r3J4w6tpZu1XMVeE18L5MuGCNZvSh8RY/fL7Tnko0tG
 Qrr6o8ODgBmGJF2IWFDKtuFdsdpDEH2ovpcWUCpjXMJndIkSz3kKtYKFa5iWFyDB
 esbNRAcqTi0k/FQR4sJl+E=
Received: from localhost.localdomain (unknown [112.5.139.96])
 by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wC3vz_n495kGwNjDQ--.7108S2; 
 Fri, 18 Aug 2023 11:22:21 +0800 (CST)
From: M_O_Bz@163.com
To: qemu-devel@nongnu.org
Cc: vr_qemu@t-online.de, kraxel@redhat.com, manos.pitsidianakis@linaro.org,
 M_O_Bz@163.com, linwei6@ruijie.com.cn
Subject: [PATCH] HDA codec: Fix wanted_r/w position overflow
Date: Fri, 18 Aug 2023 11:22:17 +0800
Message-Id: <20230818032217.31134-1-M_O_Bz@163.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3vz_n495kGwNjDQ--.7108S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFy3Xw15Zw17AF4fKFyrCrg_yoW5AFyrpr
 ZruasxCa18twnIyr4xCFn8G3W5Gw1vyw1YkrWUKFsayan5Xrs7WryqgryS9FW8AFZIqr15
 ur4jyFy7Gw42vrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE6wZnUUUUU=
X-Originating-IP: [112.5.139.96]
X-CM-SenderInfo: ppbrsur26rljoofrz/1tbiNBTP9VaED2GA3QAAs7
Received-SPF: pass client-ip=220.181.12.199; envelope-from=m_o_bz@163.com;
 helo=m12.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_BL=0.001, RCVD_IN_MSPIKE_L4=0.001,
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

From: zeroway <linwei6@ruijie.com.cn>

when the duration now - buft_start reach to some kind of value,
which will get the multiply hda_bytes_per_second(st) * (now - buft_start) overflow,
instead of calculate the wanted_r/wpos from start time to current time,
here calculate the each timer tick delta data first in wanted_r/wpos_delta,
and sum it all to wanted_r/wpos to avoid the overflow

Signed-off-by: zeroway <linwei6@ruijie.com.cn>
---
 hw/audio/hda-codec.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index c51d8ba617..747188221a 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -169,6 +169,8 @@ struct HDAAudioStream {
     uint8_t buf[8192]; /* size must be power of two */
     int64_t rpos;
     int64_t wpos;
+    int64_t wanted_rpos;
+    int64_t wanted_wpos;
     QEMUTimer *buft;
     int64_t buft_start;
 };
@@ -226,16 +228,18 @@ static void hda_audio_input_timer(void *opaque)
     int64_t wpos = st->wpos;
     int64_t rpos = st->rpos;
 
-    int64_t wanted_rpos = hda_bytes_per_second(st) * (now - buft_start)
+    int64_t wanted_rpos_delta = hda_bytes_per_second(st) * (now - buft_start)
                           / NANOSECONDS_PER_SECOND;
-    wanted_rpos &= -4; /* IMPORTANT! clip to frames */
+    st->wanted_rpos += wanted_rpos_delta;
+    st->wanted_rpos &= -4; /* IMPORTANT! clip to frames */
 
-    if (wanted_rpos <= rpos) {
+    st->buft_start = now;
+    if (st->wanted_rpos <= rpos) {
         /* we already transmitted the data */
         goto out_timer;
     }
 
-    int64_t to_transfer = MIN(wpos - rpos, wanted_rpos - rpos);
+    int64_t to_transfer = MIN(wpos - rpos, st->wanted_rpos - rpos);
     while (to_transfer) {
         uint32_t start = (rpos & B_MASK);
         uint32_t chunk = MIN(B_SIZE - start, to_transfer);
@@ -290,16 +294,18 @@ static void hda_audio_output_timer(void *opaque)
     int64_t wpos = st->wpos;
     int64_t rpos = st->rpos;
 
-    int64_t wanted_wpos = hda_bytes_per_second(st) * (now - buft_start)
+    int64_t wanted_wpos_delta = hda_bytes_per_second(st) * (now - buft_start)
                           / NANOSECONDS_PER_SECOND;
-    wanted_wpos &= -4; /* IMPORTANT! clip to frames */
+    st->wanted_wpos += wanted_wpos_delta;
+    st->wanted_wpos &= -4; /* IMPORTANT! clip to frames */
 
-    if (wanted_wpos <= wpos) {
+    st->buft_start = now;
+    if (st->wanted_wpos <= wpos) {
         /* we already received the data */
         goto out_timer;
     }
 
-    int64_t to_transfer = MIN(B_SIZE - (wpos - rpos), wanted_wpos - wpos);
+    int64_t to_transfer = MIN(B_SIZE - (wpos - rpos), st->wanted_wpos - wpos);
     while (to_transfer) {
         uint32_t start = (wpos & B_MASK);
         uint32_t chunk = MIN(B_SIZE - start, to_transfer);
@@ -420,6 +426,8 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
             int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
             st->rpos = 0;
             st->wpos = 0;
+            st->wanted_rpos = 0;
+            st->wanted_wpos = 0;
             st->buft_start = now;
             timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
         } else {
-- 
2.35.1


