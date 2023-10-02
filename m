Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1037B5593
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:00:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKOV-0003u7-QN; Mon, 02 Oct 2023 10:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKO9-0003SI-DD
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKO6-0003nY-T5
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696258750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rj1HXspE/zOGUd94i7jDR1pjjXabvJvCmfMOVXSmfDY=;
 b=MTONHZ/Zk4H7AHjuRUf33EGUUCSD9htFD476NIi074vVtp30Epw3at6Lqi2X3mmRfb48VO
 4sxbi8ky8IGV+dnsvHqcLFPYd1uxzl8xPKMpKtr0r4Q/oWDJM7jEGggvvK6mD+AsAc1Yd3
 agXTDWOSpK9N8u7uwcqHZ94vd5zDYtg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-n4WifaPJOuK23i3iJXkX_A-1; Mon, 02 Oct 2023 10:57:56 -0400
X-MC-Unique: n4WifaPJOuK23i3iJXkX_A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso133477466b.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258661; x=1696863461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rj1HXspE/zOGUd94i7jDR1pjjXabvJvCmfMOVXSmfDY=;
 b=A2mXGuIjTKr8vDulA+doNtAFk9kSyyRRN10O9EfGaC6pnlMvSJvLknGxPYEHBpc+0H
 ORE5mO7/Sk99oEVnmYoC65xQlY5/tJSPiaRN7p23IQNw+WzYCzOEQq4E794Iqyl0BR/Z
 KwLVLAriK+gp8e+iQ8xTP/noS+QS4WJZYpkOxuuIXd6QtaHvqynH+LBEZSIk/3ZPAhUp
 d6drBlqk9rLD20WfkUyxKuAz7FBPPE9sdhKZIhAO6Ke2hZRXnycmcNWDVfxg5Mn1jLdZ
 F2J8ns77iLed3sFdfmI5AKDO6R7LaSncLZygOUsh3inmenvXsGbUItjPPQ6js0FaGyNT
 0NqQ==
X-Gm-Message-State: AOJu0YyrmQnfd78jlLNGCUZIuS/FbVFOSiT2uSzM9FEqlXqS5HZ9mtX8
 CISEIN5fKBvxHw4MIeH4mGSTEznJ1zTdfreb4WW7Bsjixzv6vLjRbv8OnWOl9hVRNMrR8NAVfOV
 S4lCRME3CCuIwmR3J02mTolpWMILWc6fY08ZoeC0fuMwm0HMmdOR2eKgD4Fko/tHaf10RwZ0u1g
 U=
X-Received: by 2002:a17:906:8442:b0:9ae:5370:81df with SMTP id
 e2-20020a170906844200b009ae537081dfmr10144199ejy.19.1696258660895; 
 Mon, 02 Oct 2023 07:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5c62of9dD7x/nXunv9qyQEn+1b64sa+aOiXuyh7MO56TbjL0SJzMMC5jqrgaiRRv5XNg6CQ==
X-Received: by 2002:a17:906:8442:b0:9ae:5370:81df with SMTP id
 e2-20020a170906844200b009ae537081dfmr10144178ejy.19.1696258660407; 
 Mon, 02 Oct 2023 07:57:40 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a170906374800b009920e9a3a73sm17157743ejc.115.2023.10.02.07.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:57:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
Subject: [PATCH 05/13] audio: commonize voice initialization
Date: Mon,  2 Oct 2023 16:57:19 +0200
Message-ID: <20231002145728.87958-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002145728.87958-1-pbonzini@redhat.com>
References: <20231002145728.87958-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


