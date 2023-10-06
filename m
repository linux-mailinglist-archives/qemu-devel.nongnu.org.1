Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35D7BB63A
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:17:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinV-0000AL-FJ; Fri, 06 Oct 2023 07:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinL-0008Kg-Hg
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinJ-0000MP-Db
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6OAsxA5U/Cvno5qxaUaVEnzr/FfY4M6hU6vewG0xKvA=;
 b=FA6Sbo3VI94yzVvGvUwP9PYcjcO8Sr4KefMXW8NIa86aJgEe7itMHGkx9xaEnktIiTDtzs
 88PeD27GTv1cO7x12winBl6BXInlibCNpKBab+ApnOfe2cNSkwoRGDrbe/M72jfWU0Qo4L
 QQ6pXHu7OANghV50ja4E/Mu362sKs1o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-DRH-HsoZNrS6SPnS4a4QAg-1; Fri, 06 Oct 2023 07:14:53 -0400
X-MC-Unique: DRH-HsoZNrS6SPnS4a4QAg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae686dafedso181660066b.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590892; x=1697195692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OAsxA5U/Cvno5qxaUaVEnzr/FfY4M6hU6vewG0xKvA=;
 b=gu6SW/CmNHYIilsliSEGjZht9JIKkuEZOeFzRJ6Y1EV3rwzDoR7ToPCDkz0oTUIoBP
 QXkqiglR5ViTDE4dILH6WMjfcgUs7biComgIsTmaMaMJqw2oRPBDJh4gJSwyJ0aDOUs6
 osTRhjoi6LC+1FK9yfuDFag+VuuqEN1ITOOWQR3lIm+wpMFjnhVBEjsyS25fzN/f49h6
 RiYH9PFCxfbZypJQ3Qcao2AOOMi8u46S0Ddsl3yAfsNGHrvlT0Ph/qn9Fypj17V74nhS
 r5vpm/CTkF/KCvWhomQyIBYdaO4neO03bJoudsdR0/7NjxT/66dscXfCEZvqVRW6bNbx
 VihA==
X-Gm-Message-State: AOJu0Yw+8OS8X10IVSjL4obdsUh9GNnWsq3ybHeSoqF0H4/qgdUn8TV6
 dyp2skay/EPlQFlo3rCYNqo54PVfbXG2hMYVwtisKk1Z11r0tjNI3o1aiVQW8v1HMQi/tyqh7fF
 8poyPQrtqAAZwHjmQ8vAsQIDXcGq2noFtrl5AJLuWYDHdb0+GLlavQ4zzeKSwSk1vDeyx2wTyTK
 E=
X-Received: by 2002:a17:906:8443:b0:9ae:6632:a8c0 with SMTP id
 e3-20020a170906844300b009ae6632a8c0mr6388940ejy.10.1696590892368; 
 Fri, 06 Oct 2023 04:14:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMdOs1CqiYsX92+tyoXh2UL9m8OIoQMieiNA93xKedppTe9Ivhzv/HSI/pEtKlL0IUbwkoLw==
X-Received: by 2002:a17:906:8443:b0:9ae:6632:a8c0 with SMTP id
 e3-20020a170906844300b009ae6632a8c0mr6388931ejy.10.1696590892038; 
 Fri, 06 Oct 2023 04:14:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 lz11-20020a170906fb0b00b009b97521b58bsm2716767ejb.39.2023.10.06.04.14.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/26] audio: disable default backends if -audio/-audiodev is
 used
Date: Fri,  6 Oct 2023 13:14:07 +0200
Message-ID: <20231006111412.13130-22-pbonzini@redhat.com>
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

Match what is done for other options, for example -monitor, and also
the behavior of QEMU 8.1 (see the "legacy_config" variable).  Require
the user to specify a backend if one is specified on the command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c                   | 9 +--------
 audio/audio.h                   | 1 +
 docs/about/removed-features.rst | 3 +++
 system/vl.c                     | 7 +++++++
 4 files changed, 12 insertions(+), 8 deletions(-)

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
index e83ed087f6b..8a0a8fe0765 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -442,6 +442,9 @@ line using a ``secret`` object instance.
 The ``-audiodev`` and ``-audio`` command line options are now the only
 way to specify audio backend settings.
 
+Note that the default audio backend must be configured on the command
+line if the ``-nodefaults`` options is used.
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


