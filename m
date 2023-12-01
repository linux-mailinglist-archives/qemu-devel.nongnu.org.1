Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C288010FB
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:17:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977T-00039N-3s; Fri, 01 Dec 2023 12:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r9770-0002tU-KP
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976v-0007hG-LS
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1hOBUzznV6qwBLHdYGsGjqCYe0rh/UilHyB5ByAGcE=;
 b=e5SS0T9XPREV9SV+mVVUd3ABEXy14UAc5/9tbW+rFW7FE0HhuuoAKFYvUKfY5ZFO6w1t0c
 /0JKBKbRZtiTbxv2C8xRaHSfhOiCwUWFSnrYeRNiwaogUJf5pHhiDpE0U5Dr+gbQodfWWf
 er4GhjjXJUufAWn8N3wmlTBQ38zN/ec=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-mvO_hj0UOteIO-9pfisOkQ-1; Fri, 01 Dec 2023 12:15:27 -0500
X-MC-Unique: mvO_hj0UOteIO-9pfisOkQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40b4a837eb8so17897355e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450926; x=1702055726;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j1hOBUzznV6qwBLHdYGsGjqCYe0rh/UilHyB5ByAGcE=;
 b=c5qBxHyAm7o4uPTXisVWuB4FwUuFNHcQz0w0pUFfAgb2MTIUhNA2pJW5497QicSOB7
 WB7uMooQvLEke1veHYRNukVxUk3h92elpkkl49DnxrjniCLgExz0JhDjEuJc5Eq3Aiv4
 foU4kjI5dyxI7gQZn5/yk2k05feP0hsc/DF2PZn5gTpJimJhKCpf6glKAYDahNebS4pd
 MufdBpTjvRuL5sSvW/MGrqadPTBLMgmC+MAlVIR/6BRBRGzZHrCQF1ZFs4Fi6MRm2KBk
 0gTO4ggpH5nRZJv8QKv/lnjdpPvYNmRXY0MZJjGpoZhR+IZam6qJnSwlMAywZXhGAEsD
 xgcg==
X-Gm-Message-State: AOJu0YxHz5HDkYyCW65hPs72Q6WJ8YllO+xXSXybxrhPaYnHTwSPE04a
 /pOKtviH8lyVUWv8mEkBEhJ7eRYfMlb3SfLp009RyKp7ib/2rpmIJhZeKhQTdeNHY0PZbNCYajM
 4T6o4Qecw89xQB1PjexKz/RjZF+dMXId2yf37hJi20FRd0QrdYpujAN6gGAvKzF0wtKaD
X-Received: by 2002:a05:600c:600e:b0:40b:5e21:e271 with SMTP id
 az14-20020a05600c600e00b0040b5e21e271mr501667wmb.94.1701450925883; 
 Fri, 01 Dec 2023 09:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfa3qD8q4726y2sfBZUwbTjbmwiE7D+dW2jkioycjzd+UBSSGh5e7clpmSwQdPSYYpWTnKtw==
X-Received: by 2002:a05:600c:600e:b0:40b:5e21:e271 with SMTP id
 az14-20020a05600c600e00b0040b5e21e271mr501660wmb.94.1701450925642; 
 Fri, 01 Dec 2023 09:15:25 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a5d5101000000b003333521a1cesm678426wrt.57.2023.12.01.09.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:25 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 06/15] hw/audio/hda-codec: reenable the audio mixer
Message-ID: <25ea4d4c77a3023f10269fbf1e37339f8327c97e.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit b7639b7dd0 ("hw/audio: Simplify hda audio init") inverted
the sense of hda codec property mixer during initialization.
Change the code so that mixer=on enables the hda mixer emulation
and mixer=off disables the hda mixer emulation.

With this change audio playback and recording streams don't start
muted by default.

Fixes: b7639b7dd0 ("hw/audio: Simplify hda audio init")
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20231105172552.8405-2-vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/hda-codec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index f756e419bb..0bc20d49f6 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -868,10 +868,10 @@ static Property hda_audio_properties[] = {
 static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
-    const struct desc_codec *desc = &output_nomixemu;
+    const struct desc_codec *desc = &output_mixemu;
 
     if (!a->mixer) {
-        desc = &output_mixemu;
+        desc = &output_nomixemu;
     }
 
     hda_audio_init(hda, desc, errp);
@@ -880,10 +880,10 @@ static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)
 static void hda_audio_init_duplex(HDACodecDevice *hda, Error **errp)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
-    const struct desc_codec *desc = &duplex_nomixemu;
+    const struct desc_codec *desc = &duplex_mixemu;
 
     if (!a->mixer) {
-        desc = &duplex_mixemu;
+        desc = &duplex_nomixemu;
     }
 
     hda_audio_init(hda, desc, errp);
@@ -892,10 +892,10 @@ static void hda_audio_init_duplex(HDACodecDevice *hda, Error **errp)
 static void hda_audio_init_micro(HDACodecDevice *hda, Error **errp)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
-    const struct desc_codec *desc = &micro_nomixemu;
+    const struct desc_codec *desc = &micro_mixemu;
 
     if (!a->mixer) {
-        desc = &micro_mixemu;
+        desc = &micro_nomixemu;
     }
 
     hda_audio_init(hda, desc, errp);
-- 
MST


