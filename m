Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E402C7ABEFC
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 10:56:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjyQB-0002oi-0x; Sat, 23 Sep 2023 04:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQ9-0002nY-8q
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQ7-0000Wu-Pt
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695459323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/Se0iJLKPwuxIx8NOnYihWcL7xSavek2aBsvZGR54U=;
 b=CZKZNNtFXxx2YHoULC7Ycq2DpGemaZeF8iX5xwgJX4IrCjaRB4IbTMKwwgG4XIQpOm7AwX
 m3AnqY4Jii8sYsGa7GtwAYKyC1oe5UX7KJeYcymVI3VwFUJvK+Nnncol6tJkmrvb4ul3Vn
 DYbvEQx4T593/lWBtgGDAmBvXbCPTFg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-WkKw5uHJMWyjekyotTmmhw-1; Sat, 23 Sep 2023 04:55:21 -0400
X-MC-Unique: WkKw5uHJMWyjekyotTmmhw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-405629826ccso2998305e9.0
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 01:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695459319; x=1696064119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q/Se0iJLKPwuxIx8NOnYihWcL7xSavek2aBsvZGR54U=;
 b=DiPlLM5D/YhS4RTLCD9Cb3zxG+N6/bO30BvGwq4Zk2kyykqNvAujBaqbDO7cQmg0ib
 cLmYHQayuB5yz4CywvheZQrlTkWGjtOjRYy+Ow2UAC+XZdXTJGcHJBQSnGVix9V4/82v
 5h33Jj17oUxusfb9RWE0mT1eYIYDhoXp+ynsPgHuz7JQTfnZYHQ6w7ga6egsNJYtPO2C
 0J5diRLHKM5ooOavseRz0DUsZylkRSOmXWx8YMIi//pTcT6v56BdhenNSQ/YXXC/l2Jt
 HU6F9Q+I+5hjlniaRX75ROOI6hBkwTgjK707dQ1DjqN9+HyC52+Pe3/k4ytN1eMMyrtr
 TL/g==
X-Gm-Message-State: AOJu0YzepDabZBGIA0WpAtWGxPynHn3QZlFRX8Vha7AgEN2xlCJvHkJA
 b63R1V81Lj+tt11mDROU1cbUzt6UZmUPucN6l9MH+tm7vf87o7iu6IhUxXyjGTYblR0WsYEJz/U
 rIW75+TMk7FG4JTRJIt/Eos7PEo2ZI/iMOJC/UnzjxTM3nveXQeGWTSV4SjXaaXUslVqPYOeHTF
 0=
X-Received: by 2002:a5d:6682:0:b0:31f:9838:dfc4 with SMTP id
 l2-20020a5d6682000000b0031f9838dfc4mr1584899wru.33.1695459319630; 
 Sat, 23 Sep 2023 01:55:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt6Vp1I8+3e1lPdE9sns9HXv9lbdLsx08bdYN8OHnlu4ZweoYauTy4UmAIUnPW+6wjyfcSbA==
X-Received: by 2002:a5d:6682:0:b0:31f:9838:dfc4 with SMTP id
 l2-20020a5d6682000000b0031f9838dfc4mr1584888wru.33.1695459319339; 
 Sat, 23 Sep 2023 01:55:19 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 r10-20020adff10a000000b0031c7682607asm6412780wro.111.2023.09.23.01.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 01:55:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com,
	vr_qemu@t-online.de,
	balaton@eik.bme.hu
Subject: [PATCH 05/13] audio: commonize voice initialization
Date: Sat, 23 Sep 2023 10:54:58 +0200
Message-ID: <20230923085507.399260-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230923085507.399260-1-pbonzini@redhat.com>
References: <20230923085507.399260-1-pbonzini@redhat.com>
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
index d0444babeb4..70835a9ef28 100644
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


