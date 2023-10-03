Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD037B643A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:32:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaob-0002ys-Bp; Tue, 03 Oct 2023 04:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoM-0002NB-5S
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoK-0000KI-6m
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rj1HXspE/zOGUd94i7jDR1pjjXabvJvCmfMOVXSmfDY=;
 b=WzfvrQ2Blt+as8NcMPTTrKG8X6yw37OCzZrMP5CLLbrdPZH2NAke96zzNxhOtwmnY66wF7
 quFjDh67o6dic0oDEMyDWSYQJ+D/Beh9R4ytp9xnuAALPeoD0AYlnyo1Ji2a2FnwnPPPWU
 2Zz65rTpMF32qiuyCQ3bLlYpghYI+Cs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-371UMGJgN8Wv9ycDjsrYHA-1; Tue, 03 Oct 2023 04:31:18 -0400
X-MC-Unique: 371UMGJgN8Wv9ycDjsrYHA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae42088b4bso49466066b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321877; x=1696926677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rj1HXspE/zOGUd94i7jDR1pjjXabvJvCmfMOVXSmfDY=;
 b=a8sGtTIaHt+TWXwUAbDY7lJTpxVZqfUL5pXuAM+rq3ao1geTUG8UqaTebJJbcpzzC4
 pDHHkaiT1voU765XlvPvlU67u/eg4jyZonUuEgQZL42O59oohasxw2wIAPgswmkSt9t4
 2KFrrMF0xySj4mSPR8bxpupwDvZQRe4qK2P7idRz5CSgemoKzZR/yv1wBQW0TIItBD6U
 lMzdehSG2Tt+HDWeIRK5bPnonyBt8/NW0CxuUEg5H/mroRZZCx3Fbm1hh/NvUDGtbTNP
 4mfbUx4ZwLxC0qWXYhMAQenDfp0NhOQ2ppgVcpyrSQDGE7rF3/aahBFJ1DBlLnBkwPXu
 JGgw==
X-Gm-Message-State: AOJu0Yy6nsgweIvWBcf3DgDGmiwwjP7uJbHMwt4UQNNv/AsFFIJO4kBy
 y94l+aYQ7pYsquUn8gWfQ+G+8i0WQg4pgCiFz2bIXo9+FgKK64f2QSthMfRsR6iXBzqriiAA1Ff
 0cWKzcNqEGuUCrX07xPnko8hj8eEMHKQJlsQhNL+bzWtxVR4Dx7zxgtzf4PKNwchhldI0FxTme8
 k=
X-Received: by 2002:a17:906:150:b0:9ae:7081:4018 with SMTP id
 16-20020a170906015000b009ae70814018mr12632209ejh.33.1696321876774; 
 Tue, 03 Oct 2023 01:31:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnI937F4aLi8AVxX7YM5OYZFQsIGMFDJDV07qIgt55PVm/PN5n7SyMChT46SAHlwuy3RS/hQ==
X-Received: by 2002:a17:906:150:b0:9ae:7081:4018 with SMTP id
 16-20020a170906015000b009ae70814018mr12632194ejh.33.1696321876405; 
 Tue, 03 Oct 2023 01:31:16 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 b25-20020a170906195900b0099cc3c7ace2sm670105eje.140.2023.10.03.01.31.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/24] audio: commonize voice initialization
Date: Tue,  3 Oct 2023 10:30:33 +0200
Message-ID: <20231003083042.110065-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
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
index 874a4c3c412..bb1734a95d3 100644
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


