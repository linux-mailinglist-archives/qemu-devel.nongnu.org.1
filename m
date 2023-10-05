Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFD57B9D20
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:59:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNw7-0007ph-Dl; Thu, 05 Oct 2023 08:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNw4-0007l0-8o
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNw2-0007ku-N0
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=56gD9LiJ9JhIxV8idQkrgm/6AWds9v7CIJGV5JGQgHc=;
 b=TvOV+XXDzQQebwEzCoPXFpPn2N7eKjHPVspVCE9fQdNvvHR4j20rJCPftFH/xq4bZX/cvS
 0X5BSxSs8aTfHWZF6chWeHRtNKGbnsteKHAtTVABgiZLx+f7gi8/EJms4UQBKYmeftYFx5
 vYO5bS5W/oVn6i7PXgKM7TnG3ZXzAsw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-ejfdqXqOPWekL43shOmSqQ-1; Thu, 05 Oct 2023 08:58:22 -0400
X-MC-Unique: ejfdqXqOPWekL43shOmSqQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b2e3f315d5so115570566b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696510700; x=1697115500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=56gD9LiJ9JhIxV8idQkrgm/6AWds9v7CIJGV5JGQgHc=;
 b=ZxCxeNI149iH2v8HDL+CgR25AcTN0GLg9Glm8KK+hlydhG35BIzbMP429Rd3CCIC+v
 S4bZjvvdmg1pfio2Yb75G299kRQ420s0+8U/xEiEwGQ4rU1e5XWWiJBOfwpSIVvc+/7G
 IGh2kFFbcbikMkQbzYqwjFH2IDiJ0BO121wtCEIRDF302mRLxhZvkleCXpA4W5JDCDQS
 nVuFle4bSvooLMpTHuHXYPuwiYUksxrZPfJj4b6pMJPb/LUQgmpyQ2UQrDTCFpHh3TJg
 XPkFi/qNxc2nZ2pfqR2kuAsCtOAClEPP28D3v4tuzr+GvEy47gRu37uyWy2YOSHMYh8R
 9U2Q==
X-Gm-Message-State: AOJu0Yxnl+dZLOjMBQ2klDHw6xddh9e/XbWKBBlpXacy8s6HNOCzoocB
 W0PFwuONx0Y9A2qtWpNWA3GvGF+6emhMTFMu5VsoLcxShixn5bRBmWOfwEZWrvktTY4tKf6Ul59
 5+v040iD/GFHduXLfatAMd1zM7PUP6F74xWFdRMPfDn9CnbwhRZ2ZXKYFSmfQOy/5AuaIXYRmgH
 8=
X-Received: by 2002:a17:906:3158:b0:9ae:5df2:2291 with SMTP id
 e24-20020a170906315800b009ae5df22291mr2238969eje.1.1696510700672; 
 Thu, 05 Oct 2023 05:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCSML6oqxPpqceQXNMQ8hZwc8FN5iLh0duYMm2kjCIdeTxVblPOv2tT4FYsfr6xXi4wtaDsw==
X-Received: by 2002:a17:906:3158:b0:9ae:5df2:2291 with SMTP id
 e24-20020a170906315800b009ae5df22291mr2238955eje.1.1696510700316; 
 Thu, 05 Oct 2023 05:58:20 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 fi10-20020a170906da0a00b009ad8796a6aesm1169277ejb.56.2023.10.05.05.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:58:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	berrange@redhat.com
Subject: [PATCH 2/7] audio: disable default backends if -audio/-audiodev is
 used
Date: Thu,  5 Oct 2023 14:58:10 +0200
Message-ID: <20231005125815.66082-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005125815.66082-1-pbonzini@redhat.com>
References: <20231005125815.66082-1-pbonzini@redhat.com>
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

Match what is done for other options, for example -monitor.  Require
the user to specify a backend if one is specified on the command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c                   | 9 +--------
 audio/audio.h                   | 1 +
 docs/about/removed-features.rst | 4 ++++
 system/vl.c                     | 7 +++++++
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 98621576d95..67a7e25254d 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1688,14 +1688,10 @@ static const VMStateDescription vmstate_audio = {
 
 static void audio_validate_opts(Audiodev *dev, Error **errp);
 
-static void audio_create_default_audiodevs(void)
+void audio_create_default_audiodevs(void)
 {
     const char *drvname = getenv("QEMU_AUDIO_DRV");
 
-    if (!defaults_enabled()) {
-        return;
-    }
-
     /* QEMU_AUDIO_DRV=none is used by libqtest.  */
     if (drvname && !g_str_equal(drvname, "none")) {
         error_report("Please use -audiodev instead of QEMU_AUDIO_*");
@@ -1827,9 +1823,6 @@ bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
             }
             card->state = QTAILQ_FIRST(&audio_states);
         } else {
-            if (QSIMPLEQ_EMPTY(&default_audiodevs)) {
-                audio_create_default_audiodevs();
-            }
             card->state = audio_init(NULL, errp);
             if (!card->state) {
                 if (!QSIMPLEQ_EMPTY(&audiodevs)) {
diff --git a/audio/audio.h b/audio/audio.h
index 80f3f92124d..53b1d7e6227 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -170,6 +170,7 @@ void audio_sample_from_uint64(void *samples, int pos,
 
 void audio_define(Audiodev *audio);
 void audio_parse_option(const char *opt);
+void audio_create_default_audiodevs(void);
 void audio_init_audiodevs(void);
 void audio_help(void);
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index e83ed087f6b..58c94392c65 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -442,6 +442,10 @@ line using a ``secret`` object instance.
 The ``-audiodev`` and ``-audio`` command line options are now the only
 way to specify audio backend settings.
 
+QEMU does not create default audio backends anymore if any of the
+``-audiodev``, ``-audio`` or ``-nodefaults`` options are used on the
+command line.
+
 Creating vnc without ``audiodev=`` property (removed in 8.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/system/vl.c b/system/vl.c
index 98e071e63bb..7ca92d4490d 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -184,6 +184,7 @@ static const char *qtest_log;
 static bool opt_one_insn_per_tb;
 
 static int has_defaults = 1;
+static int default_audio = 1;
 static int default_serial = 1;
 static int default_parallel = 1;
 static int default_monitor = 1;
@@ -1327,6 +1328,7 @@ static void qemu_disable_default_devices(void)
         default_sdcard = 0;
     }
     if (!has_defaults) {
+        default_audio = 0;
         default_monitor = 0;
         default_net = 0;
         default_vga = 0;
@@ -1963,6 +1965,9 @@ static void qemu_create_early_backends(void)
      */
     configure_blockdev(&bdo_queue, machine_class, snapshot);
     audio_init_audiodevs();
+    if (default_audio) {
+        audio_create_default_audiodevs();
+    }
 }
 
 
@@ -2925,6 +2930,7 @@ void qemu_init(int argc, char **argv)
                 break;
 #endif
             case QEMU_OPTION_audiodev:
+                default_audio = 0;
                 audio_parse_option(optarg);
                 break;
             case QEMU_OPTION_audio: {
@@ -2933,6 +2939,7 @@ void qemu_init(int argc, char **argv)
                 Audiodev *dev = NULL;
                 Visitor *v;
                 QDict *dict = keyval_parse(optarg, "driver", &help, &error_fatal);
+                default_audio = 0;
                 if (help || (qdict_haskey(dict, "driver") &&
                              is_help_option(qdict_get_str(dict, "driver")))) {
                     audio_help();
-- 
2.41.0


