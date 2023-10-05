Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA287B9D1F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:59:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNwB-0007un-Jc; Thu, 05 Oct 2023 08:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNw7-0007sA-1n
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNw5-0007lS-CB
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y74XaLKPNvZ4tiIsqb/xX6c+OAaFPUBziGb5PsVpi0k=;
 b=CIhpZT9AWmTUHABgOOkdov3Hscd9K2BS2cURn1ogc4vM6fHSEZspSS3cBtt4ZrbU/nNe5R
 zxvlhi9zPWmT7hD1cG8loi6/tiKv0cELn/pWSZbNHqb47eYg9i2l5j6hD4HUZ2cisbWGgT
 t1xQaXi63p1IeINaOI5rkT5mazuQQAY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-3tjjWtMJNXikaW2HC38nfg-1; Thu, 05 Oct 2023 08:58:24 -0400
X-MC-Unique: 3tjjWtMJNXikaW2HC38nfg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b2cf504e3aso82194066b.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696510702; x=1697115502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y74XaLKPNvZ4tiIsqb/xX6c+OAaFPUBziGb5PsVpi0k=;
 b=ebL2fgJioJyIAbUDtuwxPMA5HAGXoEr+eAb6Nt9xQYrS/37uv01DWbC1vtr920Yldn
 eEIVQr8BHDe/W4+2VAxP1fepG+NpbfpbzFZVp2cxeQ3ZOcz/MuM1c+3Bb/sLWG++Sw7P
 ARhvGafzLr2NwODhtbMiQyFCCHVQTExTOPPkxtOOO9pDlHHcE4E9kwh356BJ54JrDABC
 ytzEkB6uugnkjr6hHXhrw8oDLJ01Xvqt342vcyIaPyaCGbS2f0D2pFXOez6TXa6k/xJ2
 K1zoHt/Lk7RO8FgIsXV6dM4rrGR9wtwg+bFZYDvs3xTyq+qiRFM7cRdwWNUZxAxq6gXE
 zfyA==
X-Gm-Message-State: AOJu0YwRV5woPqh91RpvfAqRHdo5RZvkwGdUJU2lwDqgbJMA9yL1h3oA
 3IcoIFTYeRzVv8H4bmRWqjh2lZcUPmzq4J89JkIXaEkTfaZ+jtMLAvMxGF6Obz9lKVU9HVCuu3m
 vEkibdrQKqLQCgOM/6LdznR3x2mT+a7azxtDFJ1tPIQKaZAgpoL00IOpH1Ra3eHMD6M8qYtsXLS
 s=
X-Received: by 2002:a17:907:7797:b0:9a3:faf:7aaa with SMTP id
 ky23-20020a170907779700b009a30faf7aaamr4637266ejc.15.1696510702658; 
 Thu, 05 Oct 2023 05:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaSszJ5EP4rBgpMz7JMmohFm8+EqbsVJqQXFMX5RJ4COWrEAA+brWcBMQWyDAVW8nxSAAR/A==
X-Received: by 2002:a17:907:7797:b0:9a3:faf:7aaa with SMTP id
 ky23-20020a170907779700b009a30faf7aaamr4637244ejc.15.1696510702203; 
 Thu, 05 Oct 2023 05:58:22 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 qq16-20020a17090720d000b0099bd046170fsm1137436ejb.104.2023.10.05.05.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:58:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	berrange@redhat.com
Subject: [PATCH 3/7] audio: extract audio_define_default
Date: Thu,  5 Oct 2023 14:58:11 +0200
Message-ID: <20231005125815.66082-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005125815.66082-1-pbonzini@redhat.com>
References: <20231005125815.66082-1-pbonzini@redhat.com>
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

It will be used soon to define a default audio device from the
command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 19 ++++++++++++-------
 audio/audio.h |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 67a7e25254d..186cc4d336e 100644
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


