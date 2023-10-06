Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 887FB7BB62B
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinW-0000F4-Iu; Fri, 06 Oct 2023 07:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinM-0008Mm-A7
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinJ-0000Mj-RC
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxClbUpyEzaOhzjOLMt2mI013puUd8aozGogBdkxNu8=;
 b=KPfAnFnq1tvNbRcLTZvwyBq/QFMUcvFaAzagnyPpSLi+Ozw3Mi5MHSulhnp56K/enx16jf
 GT268rSqvT+gVH+1ikZVERJY1lbt/Gak4fNBO9PA+KndGURhPRhiDoj513OdaGPXsJO6b6
 10D6WmJzJJkXs9Cwzs0wec2kGnU6YBU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-qRa8o3mSNfCC8t1mG35tkA-1; Fri, 06 Oct 2023 07:14:55 -0400
X-MC-Unique: qRa8o3mSNfCC8t1mG35tkA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b274cc9636so178634166b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590894; x=1697195694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxClbUpyEzaOhzjOLMt2mI013puUd8aozGogBdkxNu8=;
 b=d0liJ/WjzUKAy74TVKSs4p8oCgIzQB51QWzrs7Zs0qRNmBoU6fKA1Y5iSAq3/5OlYP
 uckTxZwSKqAQV2FVFMATr8wvZYNHRuh+sHA7pws6yoDGJOMBL2RDvFZrIXJfmUJWPgRi
 8x6NYrj/fP7HX6enHKHsLEXVJdnUIaKElt/rUho6AqsR7uINvhNdbUxACY25GfrvmUJZ
 NQVBkW79oy9LtScP8sj82wMy9I5agjA20pyWr1HerkcVYZGzCEqxsny1FDfCDTLyYLFo
 3sI1p9zWOD3OmnkdSqaxhX3+FDoVE9TxyDx0iWboCMFkl/jmvAohOhKqdnPDxuSgc9F3
 McGg==
X-Gm-Message-State: AOJu0Yy9Q91qcxADzp4rOqFinxA0tAiFdL09qvK7V7+QS2Xm2oiKXqLl
 ANmqbFP9A9lTyURH0rk1cz+1jG7bOFp4imkM5U1fKhTTjScTYMu0swuSzdrkICFDZsjiEbWXwVG
 u8VqRIbTz365Fz5MrOOED2QRgCbh8NN08ynGtPBUg+PRg4SUOi7Rsr40XlBDdNzRQItPM35X73i
 M=
X-Received: by 2002:a17:906:3ca1:b0:9b6:5b56:bbe3 with SMTP id
 b1-20020a1709063ca100b009b65b56bbe3mr5875851ejh.72.1696590894131; 
 Fri, 06 Oct 2023 04:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtcjtThh5zFAvF9SnN6iPmFZDDSKUteEtv39CwffqddltnLFQOsK+oOqWeOyfG8BphsoYtZQ==
X-Received: by 2002:a17:906:3ca1:b0:9b6:5b56:bbe3 with SMTP id
 b1-20020a1709063ca100b009b65b56bbe3mr5875836ejh.72.1696590893752; 
 Fri, 06 Oct 2023 04:14:53 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a170906378c00b009ade1a4f795sm2670049ejc.168.2023.10.06.04.14.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/26] audio: extract audio_define_default
Date: Fri,  6 Oct 2023 13:14:08 +0200
Message-ID: <20231006111412.13130-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
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

It will be used soon to define a default audio device from the
command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 19 ++++++++++++-------
 audio/audio.h |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 67a7e25254d..887219e0ce4 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1686,8 +1686,6 @@ static const VMStateDescription vmstate_audio = {
     }
 };
 
-static void audio_validate_opts(Audiodev *dev, Error **errp);
-
 void audio_create_default_audiodevs(void)
 {
     const char *drvname = getenv("QEMU_AUDIO_DRV");
@@ -1706,7 +1704,6 @@ void audio_create_default_audiodevs(void)
         if (audio_driver_lookup(audio_prio_list[i])) {
             QDict *dict = qdict_new();
             Audiodev *dev = NULL;
-            AudiodevListEntry *e;
             Visitor *v;
 
             qdict_put_str(dict, "driver", audio_prio_list[i]);
@@ -1717,10 +1714,7 @@ void audio_create_default_audiodevs(void)
             visit_type_Audiodev(v, NULL, &dev, &error_fatal);
             visit_free(v);
 
-            audio_validate_opts(dev, &error_abort);
-            e = g_new0(AudiodevListEntry, 1);
-            e->dev = dev;
-            QSIMPLEQ_INSERT_TAIL(&default_audiodevs, e, next);
+            audio_define_default(dev, &error_abort);
         }
     }
 }
@@ -2165,6 +2159,17 @@ void audio_define(Audiodev *dev)
     QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
 }
 
+void audio_define_default(Audiodev *dev, Error **errp)
+{
+    AudiodevListEntry *e;
+
+    audio_validate_opts(dev, errp);
+
+    e = g_new0(AudiodevListEntry, 1);
+    e->dev = dev;
+    QSIMPLEQ_INSERT_TAIL(&default_audiodevs, e, next);
+}
+
 void audio_init_audiodevs(void)
 {
     AudiodevListEntry *e;
diff --git a/audio/audio.h b/audio/audio.h
index 53b1d7e6227..6da5e8f6f0f 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -169,6 +169,7 @@ void audio_sample_from_uint64(void *samples, int pos,
                             uint64_t left, uint64_t right);
 
 void audio_define(Audiodev *audio);
+void audio_define_default(Audiodev *dev, Error **errp);
 void audio_parse_option(const char *opt);
 void audio_create_default_audiodevs(void);
 void audio_init_audiodevs(void);
-- 
2.41.0


