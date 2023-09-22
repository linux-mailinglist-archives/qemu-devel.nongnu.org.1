Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3CB7AB4FC
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:43:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiIp-00007D-M2; Fri, 22 Sep 2023 11:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIo-00006g-ME
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIn-0002om-2B
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCqi2uuZUZBw1/6wR9LkzHBSEz7KGdquiO19QA3ceY4=;
 b=Vtn1cuc6ReX4A1I7HcsH0wIUYUkV8Lz45rLQAvNRNQ5Pc+Gg6ZTTPSeV3yR2b9Riqon4fe
 jz15buINRVUIXXkGRw248g0QHn+qfjjFRRKg3G2NLISHmtIa1sTdVlA0Hc9oTRDRVlGKji
 eHsK0EvU09GjMI+rAgdqt52r33fcFuk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-Ukr09GLQOvG77zjQpbhQKA-1; Fri, 22 Sep 2023 11:42:43 -0400
X-MC-Unique: Ukr09GLQOvG77zjQpbhQKA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4005f0a53c5so17870595e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397361; x=1696002161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCqi2uuZUZBw1/6wR9LkzHBSEz7KGdquiO19QA3ceY4=;
 b=aX4wp6+vJS6CF5FwP89qcKPsM4IkM2pPqyAjwPzH4ksUsLKSvzZhhGtfYwBzhF038k
 KNtDCJj5wmHlb/YBm+SYL9Z8b9dzr/BWVCdfqm9wk4O5YstAiv6YllGjVfuGaLFPzQGm
 Bw0jRJ0zNWG2blpAFLcw8aPZ0+N89eAf94tS/wYb0KMZRT0uXkJERssFqDoS67HAj7gt
 mSn8gUgr31qxypMh+bZQCflvwlUEBss33+3zyAefbZvrRY3lxHCIXsITTNNus0CxleYg
 V4xLvzS4dZlREYO0esb/1vUNPXVBwuCvPAnc30WbBtkYYOPf2S+6k8WB3IGiq5gPGGWd
 bnHg==
X-Gm-Message-State: AOJu0YzO2v0ZEaR6MDh7pHwvxGdua7yrwbMubrLADk6TmlRHCuc61PdC
 0z68DQD6CtZHRtyzlNpRRzC8oER19oUph4cEaoJWR0wYv0GZnhN3bFZep/49dcFBRUKfDnCNMSG
 dPoEn2Vr2+bsZOuDuQwca74HUUs525HKU+gqSUuEZUpxXhutc9JOJYDMFjXxOcm4I30iUzCM107
 s=
X-Received: by 2002:a05:600c:5123:b0:401:dc7e:b688 with SMTP id
 o35-20020a05600c512300b00401dc7eb688mr8221423wms.6.1695397361574; 
 Fri, 22 Sep 2023 08:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE4FAGHRg2J+2eGHP9zGzuwwyUijfkw5G0T3ErAjJhv21Na8fQliEXR45jsE681BHodQx3Zg==
X-Received: by 2002:a05:600c:5123:b0:401:dc7e:b688 with SMTP id
 o35-20020a05600c512300b00401dc7eb688mr8221411wms.6.1695397361283; 
 Fri, 22 Sep 2023 08:42:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a1c7507000000b004051f8d6207sm5019498wmc.6.2023.09.22.08.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:42:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/9] hw/audio: Simplify hda audio init
Date: Fri, 22 Sep 2023 17:42:24 +0200
Message-ID: <20230922154228.304933-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922154228.304933-1-pbonzini@redhat.com>
References: <20230922154228.304933-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


