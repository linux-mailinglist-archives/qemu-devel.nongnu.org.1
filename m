Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C14E8010F0
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:16:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977F-0002uk-OS; Fri, 01 Dec 2023 12:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976x-0002r5-U2
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976u-0007gL-2e
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9GugxeuKjZmdXfiEgWk4EMFu1Y0D9B+SZe9yY4Z22Yk=;
 b=ZTvwtjvSSB2aud3dAZeK5cFfuMw5OTuyctmsn5EHBYbQkoVMeQm8WccZF2veplt/IFol3J
 faXv3goouPuH2incQ694KhTOBh02ki8ZavUoBB2zO9SC4JMhc1D4l0wQ0JfalEWxkOk9Zq
 JxioMOM+8wWfdgXgUSYxDUQjMkIKGrI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-PPrmQfJaOaiP9BFfheY8qQ-1; Fri, 01 Dec 2023 12:15:25 -0500
X-MC-Unique: PPrmQfJaOaiP9BFfheY8qQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33174d082b7so1631956f8f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450923; x=1702055723;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9GugxeuKjZmdXfiEgWk4EMFu1Y0D9B+SZe9yY4Z22Yk=;
 b=t+u6jd1XACt8Hq2AbjgqGCJYdUkDpIfmcQ4vQmo1Epo/kRDxBQRO49Hll0mZtbUfoV
 AVRCmb9Gcx+Sr5KdbMxgC8IymC1RjNCnOeKSY6DdTotvgJ8llXzwbGNqsCKb+lN6UdHj
 WcfHPU1k8kTAc1b/kSyhATJbX2Fj7KOBAkxilqlICkmzet2c6Saqn4LI7amRGtv73RRd
 023dOzWdHu02IZylyxxco/FBnNF/oNFtUlAmTMvNR8UbJw7WtNo6XnS/YgVnOS3Ahpxi
 RInanuuQwQg6WGWEK1kwZlTqu2IQNm8asW64wLwZbwVpVToyxx9BAzN7/aCc0WAVtzPe
 +52A==
X-Gm-Message-State: AOJu0YzCowm1mf5qSv3bWLqMe0v8u1bkky0/oaAh76lvTxxjFCgSV/E/
 xp7/BYSYjVyAfWlpUSeHR/jdYNQPe4YX1c7Y2njNf3jRyrVOzi3ccqDqukE/W3b/LU/Yjal/iFV
 jU96Gv1tFlloYEMlrQTpqZzZIUIh1tx2J+6qZ1sykOpIAgoItrsNigE10r1+rSouc829z
X-Received: by 2002:a5d:66ca:0:b0:333:2fd2:68cc with SMTP id
 k10-20020a5d66ca000000b003332fd268ccmr1190554wrw.95.1701450923648; 
 Fri, 01 Dec 2023 09:15:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6OiMO0t+Rj8FuMhTeqafqYQ2B4Hmd4MlthpN5+3ovhQ3c3pyQMD0ojCJUrILJ+pTnLTmpAg==
X-Received: by 2002:a5d:66ca:0:b0:333:2fd2:68cc with SMTP id
 k10-20020a5d66ca000000b003332fd268ccmr1190542wrw.95.1701450923392; 
 Fri, 01 Dec 2023 09:15:23 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a5d6092000000b003142e438e8csm4652777wrt.26.2023.12.01.09.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:22 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 M_O_Bz <m_o_bz@163.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 05/15] hw/audio/hda-codec: fix multiplication overflow
Message-ID: <680135687270765d987ce9d5271d072b28c39fa0.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 
-    int64_t wanted_wpos = hda_bytes_per_second(st) * (now - buft_start)
-                          / NANOSECONDS_PER_SECOND;
+    if (uptime <= 0) {
+        /* wanted_wpos <= 0 */
+        goto out_timer;
+    }
+
+    wanted_wpos = muldiv64(uptime, hda_bytes_per_second(st),
+                           NANOSECONDS_PER_SECOND);
     wanted_wpos &= -4; /* IMPORTANT! clip to frames */
 
     if (wanted_wpos <= wpos) {
-- 
MST


