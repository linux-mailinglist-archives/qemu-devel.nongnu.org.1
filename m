Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0084F7BB626
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinV-0000Cn-QO; Fri, 06 Oct 2023 07:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinN-0008Oi-8g
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinL-0000N7-Hm
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbrCmPB68Z8c52mvckXXYYd42GA9Z2PO/AQo6w0dlUs=;
 b=Wroxr8l6NBX/7UQmHNgkk55XqZSzRoHxvvdRQnSPjGpNHyv7TQCuhnzolUIo5VCGw+N6xB
 YHsQtkHCx9SNCs5KEGVhqGjP9o87sy/9u3o8PN9B+O7+XKFipkiTwEzA2gV4bjvXdJkPYX
 Agb1OrIWFbMyQObcMWfbxfqi3okL2mQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-U52aKxY3PfeIzphG8Nkzjg-1; Fri, 06 Oct 2023 07:14:57 -0400
X-MC-Unique: U52aKxY3PfeIzphG8Nkzjg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a9e3f703dfso160355266b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590896; x=1697195696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbrCmPB68Z8c52mvckXXYYd42GA9Z2PO/AQo6w0dlUs=;
 b=YoemC0amdIifB+nVFzyBqYLZ1Ruc7ydtNh2EUOWk//FCTC9kOz+/ivrmQGy9SxHOZh
 a+qBmLPdFyUFNQK4LUoKIW4NbvrAFsKalzLS7mCxnpRXd2958Am8p/WnOLzB8yaoxt3B
 0aiqTOJhlFbpXKgpR+2IfuXY/pJOSlv6UPsFxcRmacRjbgJ05zz1ugpLCOIfxyKOZhe9
 3XUg3LM4KKEYt5OKXQGAvxQmHByg/q8RgKWQ+AZUV4pVpSw/sbakxV86MSnDCz4LpnxJ
 BnqtZN+u7hm+Eus8q7OTBIfKE1EAQVi8ADy+UR9b4WHOR82s396F5zs74EuFAoC2StHS
 nAhw==
X-Gm-Message-State: AOJu0YxT3qICZuBwbVpl6aOHDbhAWpW5DpyRbhmU+Z6lV7gcn0qOkqcM
 EO0S76c/P8YaMI4VlfSLW/lTDWOdtAPVGkpfnGMJ8UuYNXaN0TgzYQlDOlEaAdjkBp0JqbpzI7A
 PWRBPHHuwsA+hQPRHKUvWizbl2IX1eS+tg7mEEBkEL34yNj9+HDkiPlMkTkpC981mou4o96hf0f
 c=
X-Received: by 2002:a17:907:270a:b0:9b2:b749:ff93 with SMTP id
 w10-20020a170907270a00b009b2b749ff93mr7490124ejk.24.1696590895767; 
 Fri, 06 Oct 2023 04:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWwSabwCwsHUXOxbrYmUtDtLyT5hZYhiacdHoHjTTrHLywEPbjQDvTdvXsYBhUb4L5bjJr9Q==
X-Received: by 2002:a17:907:270a:b0:9b2:b749:ff93 with SMTP id
 w10-20020a170907270a00b009b2b749ff93mr7490105ejk.24.1696590895343; 
 Fri, 06 Oct 2023 04:14:55 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 qh9-20020a170906eca900b009add084a00csm2705584ejb.36.2023.10.06.04.14.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/26] audio: extend -audio to allow creating a default backend
Date: Fri,  6 Oct 2023 13:14:09 +0200
Message-ID: <20231006111412.13130-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
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

If "-audio BACKEND" is used without a model, the resulting backend
will be used whenever the audiodev property is not specified.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c   |  2 +-
 qemu-options.hx | 29 +++++++++++++++++++++--------
 system/vl.c     | 27 +++++++++++++++------------
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 887219e0ce4..a5e6eb4952e 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1820,7 +1820,7 @@ bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
             card->state = audio_init(NULL, errp);
             if (!card->state) {
                 if (!QSIMPLEQ_EMPTY(&audiodevs)) {
-                    error_append_hint(errp, "Perhaps you wanted to set audiodev=%s?\n",
+                    error_append_hint(errp, "Perhaps you wanted to use -audio or set audiodev=%s?\n",
                                       QSIMPLEQ_FIRST(&audiodevs)->dev->id);
                 }
                 return false;
diff --git a/qemu-options.hx b/qemu-options.hx
index 9ce8a5b9578..5f4c240a1e2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -728,20 +728,22 @@ ERST
 
 
 DEF("audio", HAS_ARG, QEMU_OPTION_audio,
+    "-audio [driver=]driver[,prop[=value][,...]]\n"
+    "                specifies default audio backend when `audiodev` is not\n"
+    "                used to create a machine or sound device;"
+    "                options are the same as for -audiodev\n"
     "-audio [driver=]driver,model=value[,prop[=value][,...]]\n"
     "                specifies the audio backend and device to use;\n"
     "                apart from 'model', options are the same as for -audiodev.\n"
     "                use '-audio model=help' to show possible devices.\n",
     QEMU_ARCH_ALL)
 SRST
-``-audio [driver=]driver,model=value[,prop[=value][,...]]``
-    This option is a shortcut for configuring both the guest audio
-    hardware and the host audio backend in one go.
-    The driver option is the same as with the corresponding ``-audiodev`` option below.
-    The guest hardware model can be set with ``model=modelname``.
-
-    Use ``driver=help`` to list the available drivers,
-    and ``model=help`` to list the available device types.
+``-audio [driver=]driver[,model=value][,prop[=value][,...]]``
+    If the ``model`` option is specified, ``-audio`` is a shortcut
+    for configuring both the guest audio hardware and the host audio
+    backend in one go. The guest hardware model can be set with
+    ``model=modelname``.  Use ``model=help`` to list the available
+    device types.
 
     The following two example do exactly the same, to show how ``-audio``
     can be used to shorten the command line length:
@@ -750,6 +752,17 @@ SRST
 
         |qemu_system| -audiodev pa,id=pa -device sb16,audiodev=pa
         |qemu_system| -audio pa,model=sb16
+
+    If the ``model`` option is not specified, ``-audio`` is used to
+    configure a default audio backend that will be used whenever the
+    ``audiodev`` property is not set on a device or machine.  In
+    particular, ``-audio none`` ensures that no audio is produced even
+    for machines that have embedded sound hardware.
+
+    In both cases, the driver option is the same as with the corresponding
+    ``-audiodev`` option below.  Use ``driver=help`` to list the available
+    drivers.
+
 ERST
 
 DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
diff --git a/system/vl.c b/system/vl.c
index 7ca92d4490d..72be5a49764 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2935,7 +2935,7 @@ void qemu_init(int argc, char **argv)
                 break;
             case QEMU_OPTION_audio: {
                 bool help;
-                char *model;
+                char *model = NULL;
                 Audiodev *dev = NULL;
                 Visitor *v;
                 QDict *dict = keyval_parse(optarg, "driver", &help, &error_fatal);
@@ -2948,22 +2948,25 @@ void qemu_init(int argc, char **argv)
                 if (!qdict_haskey(dict, "id")) {
                     qdict_put_str(dict, "id", "audiodev0");
                 }
-                if (!qdict_haskey(dict, "model")) {
-                    error_setg(&error_fatal, "Parameter 'model' is missing");
-                }
-                model = g_strdup(qdict_get_str(dict, "model"));
-                qdict_del(dict, "model");
-                if (is_help_option(model)) {
-                    show_valid_soundhw();
-                    exit(0);
+                if (qdict_haskey(dict, "model")) {
+                    model = g_strdup(qdict_get_str(dict, "model"));
+                    qdict_del(dict, "model");
+                    if (is_help_option(model)) {
+                        show_valid_soundhw();
+                        exit(0);
+                    }
                 }
                 v = qobject_input_visitor_new_keyval(QOBJECT(dict));
                 qobject_unref(dict);
                 visit_type_Audiodev(v, NULL, &dev, &error_fatal);
                 visit_free(v);
-                audio_define(dev);
-                select_soundhw(model, dev->id);
-                g_free(model);
+                if (model) {
+                    audio_define(dev);
+                    select_soundhw(model, dev->id);
+                    g_free(model);
+                } else {
+                    audio_define_default(dev, &error_fatal);
+                }
                 break;
             }
             case QEMU_OPTION_h:
-- 
2.41.0


