Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA757B2E7D
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9EL-0006Le-62; Fri, 29 Sep 2023 04:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9EB-0005iM-K0
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9Dg-0005lV-OS
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/cjiD8zcK3q6uQaQzwkdfO4D5tuO2wkAY58seJFlMA=;
 b=YhawEy9/BorQi9ctnntUKwhKdgLnlQ/D0JoDxc7JxG3mgOeeQC8d+CibKJzmVFiycY8nY2
 ZHNf7zLngzP52ArcwrRrt43HCJXQOjr0gOQ/jrkY0G7av4fGDR9B37QVwpdQZOXPYqpGIZ
 jwZFW07k2bkGSeGb1JoY7bRmw/2UreU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-QHypU5UhNnC7l41XNmAf_g-1; Fri, 29 Sep 2023 04:51:27 -0400
X-MC-Unique: QHypU5UhNnC7l41XNmAf_g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-534695ab33eso5300773a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977485; x=1696582285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q/cjiD8zcK3q6uQaQzwkdfO4D5tuO2wkAY58seJFlMA=;
 b=CwruvrnLvzL+2jroCkzinPyaHoYpOwI+ZAb7ChBHdbAc5nDbwrn+TrZ7d7cLroH/V0
 x5Y9IRLNuy43rIw158GjS62vkMN/GLZjeOntHigDUQvWEmulJ9bxde19VAw7IZYG69g1
 qu46/VdmweIbP8p8fY67jRskWihwcxBnSMeeNIUrnQGHV+1FbSHUQxMFW9vzmsnp6otu
 DfEE3Uqh/lZLE4fD2Fs+zMjrCgdPgUxCb8ebwK065IrQYlYJyLk2dnmLfD8dwaZ87bQV
 Yvnm240kCyli7x/Dp3jw0DGGSF2xAhGpOiU5qe24rOAQUQHLK+xDk2uj6Vas3CUh4gqO
 PZ7w==
X-Gm-Message-State: AOJu0YwDbGXpMLzjgWcMq4B1ozOc9UETeuGY+YO0Mj2PmxfMSELyLcFp
 80zeV5Go6X7wKrnymAwIt2+2YiNEcphe8kRwGFKgl4k20LXImSY94Uzk+UN/Srv187G4KMEOtLw
 IUv47P3LfwzibC7sK/5JRGnV8YoCq0ek/Jd1RLn9kQ+9T94oGLX79wj41goMzBkPmMX7MWOJSMu
 Y=
X-Received: by 2002:a05:6402:1846:b0:523:bfec:4915 with SMTP id
 v6-20020a056402184600b00523bfec4915mr3741541edy.0.1695977485164; 
 Fri, 29 Sep 2023 01:51:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzfDZvcu1eaGnU+DXnJfc2piIvjm93oir8fiYCUzAaScLIp5hAa2YfUPA/ou6sI94vkwdD+Q==
X-Received: by 2002:a05:6402:1846:b0:523:bfec:4915 with SMTP id
 v6-20020a056402184600b00523bfec4915mr3741525edy.0.1695977484847; 
 Fri, 29 Sep 2023 01:51:24 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 l14-20020aa7cace000000b0053331f9094dsm10843915edt.52.2023.09.29.01.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 05/14] audio: commonize voice initialization
Date: Fri, 29 Sep 2023 10:50:58 +0200
Message-ID: <20230929085112.983957-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929085112.983957-1-pbonzini@redhat.com>
References: <20230929085112.983957-1-pbonzini@redhat.com>
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
index d4263976a5b..2014a2904e8 100644
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


