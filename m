Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 043797B9D23
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:59:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNwl-0000AM-5c; Thu, 05 Oct 2023 08:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNwL-0008K8-RE
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNwC-0007m9-24
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UN/2lHlsKjyWdODn3no2MX1PZjTG24Zr1xY9Gvy6c0=;
 b=MEjEIujan8WNARpv6MJ3bm/LPQlgsm4g60ezwxfqjpFWsypOrVj+95EdnKLDTKeqS3FyyL
 lFW+YAu2E9YDBnU9KTUCdzmz1S8ZD376i8sB/JRRF/+MLQXjp6vM07eUZTYmlXIztlp1w3
 GvbdfjblG4LqmsFEmI4oOZUpe88yL/k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-_YVPUlBbM-SCEoQp2fbD0w-1; Thu, 05 Oct 2023 08:58:26 -0400
X-MC-Unique: _YVPUlBbM-SCEoQp2fbD0w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b274cc9636so87712766b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696510704; x=1697115504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UN/2lHlsKjyWdODn3no2MX1PZjTG24Zr1xY9Gvy6c0=;
 b=i4GxSqnA3elcJVHpJrlHXA6GJkev+eAMoMCJmySywD2XBFwNL0i8veMWEErh/xni4k
 KsDc2Ffx3mHabbBCpdIG4fgvAhbblVbCiPFQPDSHqZEo7wDzkCTgWJ9Ztc9zVskBG62o
 nPmaymdFFbT4YULEH0ia3PNFPrIWlO6kXCHSmMn3p3o7M7JpaBmUIs2U3NAs40NEFmgo
 gJUpNIkEpYD0ShHotEZCDUZ255q40b7dwPeK3Ga43iJLhdZVoxu2KLb4YHYLV9CG1o4g
 LiNxIu6f3eTZvj9aycLEVVzfMmo5UG77SlLQp120pxudJUYj68MHuMFWdA+suS1Ub4hx
 qcyw==
X-Gm-Message-State: AOJu0YxzGTDoIUTHtrOJ0Sqw4Vut/xPae74yPTbUMge7qRxlemsGtJYe
 C17J4g49zPJUxNp/Rdv/qzB74EOhIFeSU60fEVVLFqvM+c9tWk4bsx58FcCfMRtOVOVNYOuRTU8
 jejUgJBrc/ZZx4mvObyOGHGviOf55KqzcbiFogQpRfCkIMxZqYphq1s4/6BX28oM32RUxHyduC8
 Y=
X-Received: by 2002:a17:906:100e:b0:9b3:47f:1c05 with SMTP id
 14-20020a170906100e00b009b3047f1c05mr4125878ejm.64.1696510704472; 
 Thu, 05 Oct 2023 05:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi5UjYnfBhF4whb5VPv8Bo4zvw4BHKefSFmcl0MZUMlX3uggQVSnNkVjFEMxIOIj0/PTnugQ==
X-Received: by 2002:a17:906:100e:b0:9b3:47f:1c05 with SMTP id
 14-20020a170906100e00b009b3047f1c05mr4125870ejm.64.1696510704184; 
 Thu, 05 Oct 2023 05:58:24 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a17090619cd00b009ae587ce135sm1151954ejd.223.2023.10.05.05.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:58:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	berrange@redhat.com
Subject: [PATCH 4/7] audio: extend -audio to allow creating a default backend
Date: Thu,  5 Oct 2023 14:58:12 +0200
Message-ID: <20231005125815.66082-5-pbonzini@redhat.com>
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

If "-audio BACKEND" is used without a model, the resulting backend
will be used whenever the audiodev property is not specified.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 29 +++++++++++++++++++++--------
 system/vl.c     | 27 +++++++++++++++------------
 2 files changed, 36 insertions(+), 20 deletions(-)

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


