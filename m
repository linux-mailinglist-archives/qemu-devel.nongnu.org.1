Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 921717B1526
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllaQ-0004kW-OT; Thu, 28 Sep 2023 03:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaN-0004fi-Ef
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaL-00065g-RM
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695886641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1OSaJs85133jklsiphyQG3sce5Sy+DRxmQ7c6brP6U=;
 b=PLTbQoDrM/BrqQKyYzbi2fLHFBG1bi8dxXmDZPAbM5ieR9zx7eptU7zvJUdVGaiSH/IBfs
 tk/3Uva/jCxknXsrYasjpOcFJvQN+p1z0EVaVCZEgS0RBcZ7YmpcbJZxeCeUeL+Act/ZO2
 wx7SYemkVTKSn79QnGL8vvERbQafdwA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-rNCZCR6MOKqW72xm5sVCTQ-1; Thu, 28 Sep 2023 03:37:19 -0400
X-MC-Unique: rNCZCR6MOKqW72xm5sVCTQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso1034145766b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695886637; x=1696491437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n1OSaJs85133jklsiphyQG3sce5Sy+DRxmQ7c6brP6U=;
 b=wg6bReZYdSygXvuxR6cR/s/Kl4YDWdMUMdzvvr9qrtHcMPx3Currvck5lDiaFp8Dls
 BdoR6R53ry3ynIPL5mxhmomCjQC4DSMCwv9fzwykUBI7vJarKtm97muzxksY2rAsldcj
 sqfk6K3CDpC0q/w9+IvTVuKqw0Nlsom4F2zuTsEc0doayATeLE01bjH88YZ17VH7n5SJ
 SULKYFLZpMF53Zrn/JVWgVNVvuElNl0URHbyahzSP+JenriQfleFIjJxY4Wr2j4diYij
 x72A3H48l6+I9G4aFfOqD0bw1o2hZZz4+YtF7hZ2QSrfJS8YnJQpixcW/cD6/DL29N0k
 kMQQ==
X-Gm-Message-State: AOJu0Ywp5DhkAntoq7iIF2vwFuB5WQftoXcgxFC1fHTQJEB1g6PHsn6i
 ZtBkLd10oA/Ozan++17JJ0nREjCkmUyByXH+Ph/8L9AZhjY/c9pmav5YbfaJexpjoP+iW/xmwGK
 gi5LiKxyTx60Tp+4eNUIAdHW23dO84rP3J4bP7/7WMPsbfZ/gn5oSR31gua/e9hsmGs9dmhRzHh
 I=
X-Received: by 2002:a17:906:9c1:b0:9ae:6ff4:9f15 with SMTP id
 r1-20020a17090609c100b009ae6ff49f15mr462379eje.11.1695886637670; 
 Thu, 28 Sep 2023 00:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoAkRgWQMeK13TrfuAdCU+E3P9KJTIxjSQRqN/dcsuXk8fRMM377D5zGfMtuj+bup8hcCW8g==
X-Received: by 2002:a17:906:9c1:b0:9ae:6ff4:9f15 with SMTP id
 r1-20020a17090609c100b009ae6ff49f15mr462367eje.11.1695886637446; 
 Thu, 28 Sep 2023 00:37:17 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a170906089100b0099ccee57ac2sm10358670eje.194.2023.09.28.00.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:37:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH 05/13] audio: commonize voice initialization
Date: Thu, 28 Sep 2023 09:36:49 +0200
Message-ID: <20230928073705.871327-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928073705.871327-1-pbonzini@redhat.com>
References: <20230928073705.871327-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Move some mostly irrelevant code out of audio_init.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c          | 19 ++-----------------
 audio/audio_template.h |  9 ++++++++-
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 0a1dba21340..e1456ad55d2 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1570,8 +1570,8 @@ static int audio_driver_init(AudioState *s, struct audio_driver *drv,
             drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
         }
 
-        audio_init_nb_voices_out(s, drv);
-        audio_init_nb_voices_in(s, drv);
+        audio_init_nb_voices_out(s, drv, 1);
+        audio_init_nb_voices_in(s, drv, 0);
         s->drv = drv;
         return 0;
     } else {
@@ -1774,21 +1774,6 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
 
     s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
 
-    s->nb_hw_voices_out = audio_get_pdo_out(dev)->voices;
-    s->nb_hw_voices_in = audio_get_pdo_in(dev)->voices;
-
-    if (s->nb_hw_voices_out < 1) {
-        dolog ("Bogus number of playback voices %d, setting to 1\n",
-               s->nb_hw_voices_out);
-        s->nb_hw_voices_out = 1;
-    }
-
-    if (s->nb_hw_voices_in < 0) {
-        dolog ("Bogus number of capture voices %d, setting to 0\n",
-               s->nb_hw_voices_in);
-        s->nb_hw_voices_in = 0;
-    }
-
     if (drvname) {
         driver = audio_driver_lookup(drvname);
         if (driver) {
diff --git a/audio/audio_template.h b/audio/audio_template.h
index dc0c74aa746..7ccfec01168 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -37,11 +37,12 @@
 #endif
 
 static void glue(audio_init_nb_voices_, TYPE)(AudioState *s,
-                                              struct audio_driver *drv)
+                                              struct audio_driver *drv, int min_voices)
 {
     int max_voices = glue (drv->max_voices_, TYPE);
     size_t voice_size = glue(drv->voice_size_, TYPE);
 
+    glue (s->nb_hw_voices_, TYPE) = glue(audio_get_pdo_, TYPE)(s->dev)->voices;
     if (glue (s->nb_hw_voices_, TYPE) > max_voices) {
         if (!max_voices) {
 #ifdef DAC
@@ -56,6 +57,12 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioState *s,
         glue (s->nb_hw_voices_, TYPE) = max_voices;
     }
 
+    if (glue (s->nb_hw_voices_, TYPE) < min_voices) {
+        dolog ("Bogus number of " NAME " voices %d, setting to %d\n",
+               glue (s->nb_hw_voices_, TYPE),
+               min_voices);
+    }
+
     if (audio_bug(__func__, !voice_size && max_voices)) {
         dolog ("drv=`%s' voice_size=0 max_voices=%d\n",
                drv->name, max_voices);
-- 
2.41.0


