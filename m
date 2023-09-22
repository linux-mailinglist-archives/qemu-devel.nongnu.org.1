Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E49B7AAE26
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:33:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcVy-0004n5-6o; Fri, 22 Sep 2023 05:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVk-0004j9-Mp
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVj-0003NL-40
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCqi2uuZUZBw1/6wR9LkzHBSEz7KGdquiO19QA3ceY4=;
 b=Av1MLUI1GHSFVzQoJ/xjsg3fwjcXz0Xv1iws0+eansYkucsLztoeFUGB6xq2Q/lRRzeOSW
 VRrMs2ckfnGd2MF81YgmXc+9FmS07JrCJ0lPDI198oJkdGUtP5hQY1p5tBAx//GX0jNEjf
 FK024AjvyfyeTJd45uCBwN6EOti4EIU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-RC_G-nciO5a968FdfXRGiw-1; Fri, 22 Sep 2023 05:31:40 -0400
X-MC-Unique: RC_G-nciO5a968FdfXRGiw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50335ee6011so2459811e87.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375098; x=1695979898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCqi2uuZUZBw1/6wR9LkzHBSEz7KGdquiO19QA3ceY4=;
 b=ln/d/I1QUG7mCgibFBpaNYLZqbc9BAcap2f4e+iSxmyDbRcJKEiJcOiMXjh3wMqwzU
 5vpqKaQpCtt20B0fQ9l4CEHmArs7ymKeIvXaBNfpVEZe8qy2FxYeJZrMZn4ogVgFjWnl
 NJimm0eE1PA6AlwoJpcX7+BNwrNzsYb2ywl6Lqb60EPAe0rCk8BFE9tzie/5JEGRj1pS
 JixOtF5J4aW02HObDrWSO8s1iR22DGUt2RpjkAdyZ+vzCFkgieKQT2/RlW8sqVuVEdwV
 vWkTY5ts3maNo9hYrJsTSeCWhGcRnK/gdvxmQGFf/cTuozpz7QOqrvFwPogJmdK78ZkW
 9ycQ==
X-Gm-Message-State: AOJu0YxTegZQSRecxrCBDFJ2H90koWcQ7Q+XDvXyduj+QWZOOgUy18vw
 5I7VbBU6xfHT6xaAWvu9AJ6Mkfu2UsvyFhTIOfLRcMAmVOIDkczWn1e+ISqE302NLV4wQNqQckF
 iZm6HpPfXDmIg51b3dwHgsuWVWhKqtkO8WOTKHUeFk4X/ONcqulOWfUcBR3o90ns/XSpEZJhaPB
 M=
X-Received: by 2002:a19:7009:0:b0:503:264b:efc9 with SMTP id
 h9-20020a197009000000b00503264befc9mr6844876lfc.18.1695375098326; 
 Fri, 22 Sep 2023 02:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS6i44BYmyiaCRl1AKme9uQoW8Y4AVvBIednpB1OnC4J7WLmz3HZexozFQHkTWue/AkaFrmA==
X-Received: by 2002:a19:7009:0:b0:503:264b:efc9 with SMTP id
 h9-20020a197009000000b00503264befc9mr6844856lfc.18.1695375097823; 
 Fri, 22 Sep 2023 02:31:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a05600c3b8300b004053a6b8c41sm2296672wms.12.2023.09.22.02.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/12] hw/audio: Simplify hda audio init
Date: Fri, 22 Sep 2023 11:31:19 +0200
Message-ID: <20230922093126.264016-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Martin Kletzander <mkletzan@redhat.com>

No return values are used anywhere, so switch the functions to be void
and add support for error reporting using errp for use in next patches.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <cd1df4ad2a6fae969c4a02a77955c4a8c0d430b6.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/hda-codec.c | 32 ++++++++++++++++++--------------
 hw/audio/intel-hda.c |  4 +---
 hw/audio/intel-hda.h |  2 +-
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index c51d8ba6177..a26048cf15e 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -675,7 +675,9 @@ static void hda_audio_stream(HDACodecDevice *hda, uint32_t stnr, bool running, b
     }
 }
 
-static int hda_audio_init(HDACodecDevice *hda, const struct desc_codec *desc)
+static void hda_audio_init(HDACodecDevice *hda,
+                           const struct desc_codec *desc,
+                           Error **errp)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
     HDAAudioStream *st;
@@ -718,7 +720,6 @@ static int hda_audio_init(HDACodecDevice *hda, const struct desc_codec *desc)
             break;
         }
     }
-    return 0;
 }
 
 static void hda_audio_exit(HDACodecDevice *hda)
@@ -848,37 +849,40 @@ static Property hda_audio_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static int hda_audio_init_output(HDACodecDevice *hda)
+static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
+    const struct desc_codec *desc = &output_nomixemu;
 
     if (!a->mixer) {
-        return hda_audio_init(hda, &output_nomixemu);
-    } else {
-        return hda_audio_init(hda, &output_mixemu);
+        desc = &output_mixemu;
     }
+
+    hda_audio_init(hda, desc, errp);
 }
 
-static int hda_audio_init_duplex(HDACodecDevice *hda)
+static void hda_audio_init_duplex(HDACodecDevice *hda, Error **errp)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
+    const struct desc_codec *desc = &duplex_nomixemu;
 
     if (!a->mixer) {
-        return hda_audio_init(hda, &duplex_nomixemu);
-    } else {
-        return hda_audio_init(hda, &duplex_mixemu);
+        desc = &duplex_mixemu;
     }
+
+    hda_audio_init(hda, desc, errp);
 }
 
-static int hda_audio_init_micro(HDACodecDevice *hda)
+static void hda_audio_init_micro(HDACodecDevice *hda, Error **errp)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
+    const struct desc_codec *desc = &micro_nomixemu;
 
     if (!a->mixer) {
-        return hda_audio_init(hda, &micro_nomixemu);
-    } else {
-        return hda_audio_init(hda, &micro_mixemu);
+        desc = &micro_mixemu;
     }
+
+    hda_audio_init(hda, desc, errp);
 }
 
 static void hda_audio_base_class_init(ObjectClass *klass, void *data)
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index b9ed231fe84..78ff9f9a680 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -71,9 +71,7 @@ static void hda_codec_dev_realize(DeviceState *qdev, Error **errp)
         return;
     }
     bus->next_cad = dev->cad + 1;
-    if (cdc->init(dev) != 0) {
-        error_setg(errp, "HDA audio init failed");
-    }
+    cdc->init(dev, errp);
 }
 
 static void hda_codec_dev_unrealize(DeviceState *qdev)
diff --git a/hw/audio/intel-hda.h b/hw/audio/intel-hda.h
index f78c1833e34..8d710eee5d6 100644
--- a/hw/audio/intel-hda.h
+++ b/hw/audio/intel-hda.h
@@ -31,7 +31,7 @@ struct HDACodecBus {
 struct HDACodecDeviceClass {
     DeviceClass parent_class;
 
-    int (*init)(HDACodecDevice *dev);
+    void (*init)(HDACodecDevice *dev, Error **errp);
     void (*exit)(HDACodecDevice *dev);
     void (*command)(HDACodecDevice *dev, uint32_t nid, uint32_t data);
     void (*stream)(HDACodecDevice *dev, uint32_t stnr, bool running, bool output);
-- 
2.41.0


