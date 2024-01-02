Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B72821F36
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 17:06:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKhHG-0006Xz-Gs; Tue, 02 Jan 2024 11:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGp-0006Ot-FT
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:35 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGm-0002el-LB
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d5b89e2bfso56739265e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704211531; x=1704816331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwq5yDKl13Ts01PyVa9GJG2AkfcsezIrZC8dB60lDmQ=;
 b=dZ+S+nwxV3iOZ9wwFf0r1YiyjxD9X6YhqmAIzZj7qhc8hc1/EvTZ48C2nQN6NvVa7B
 5vl7lcewVRU0f4BftFxQNB5CWWNO0QuYwFVNR9QPnSHMvBzSlVx41XK7Fi+zKVM2D7ge
 SMLikimAJeRhPu4dnvBELYmBb67aZM5jNKpdSYgUKrwKD5ryTvuGxQJsmlOT4xEPow1z
 i8O2r2JVn5LYjSt+uEo7gnJ4uFde+VRvpehhC/6E4ltvymGfH0viOPDnbZjJ0GYVBypA
 bhVIl6wNdWKJ73hze9swZRiyOsbg+hj78hJkOqLZ4kDAHG2fhEHxBHuT6C9tHJgoSOlf
 1ajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704211531; x=1704816331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwq5yDKl13Ts01PyVa9GJG2AkfcsezIrZC8dB60lDmQ=;
 b=Vbq1Vri1eKqAe+KgHyuoj37kO2x9VlLWSTCzROhNLZb0pV2gdTlbXDI3ZYsf8iuIc4
 1MKh/ZTIHLEtiC7zzatxrVkLNekjyvvwE4R85r1azINWcGKSOumPwYZ6n0VxoXin06iE
 tYWh10pFQ7qO0RexZuuAlLayxPxd1veq3MKsql3AnQVJCqNcRYNPwa947gNyoX7+sOts
 PBo6TMty9qyes+Tp8hS7r1pshLR5TCEkNlv/GW+QJSulU9RHrolGucYJ8SgJV5ChUAE2
 x8IUEgHpf/UKYM1iIX7uyXdeCCgBdFKQh0QjXZsYnye35bffEDYIP+RT+x5BZ32FQ6jk
 o22A==
X-Gm-Message-State: AOJu0YyPNzk+0hkVlOz2Wxk9dzQM0PXW+V7MCXjTSTtF8NknJJllSJJX
 XeAE1zesOkDPza0tKQfHI/EYf5mnM8tjn4uTHNCc3NT1uZY=
X-Google-Smtp-Source: AGHT+IGb2XwyfuJx+sJgvN6SQmHHWUE9hIyqtWKh40xTmHinEm+AMoYcSkMlyySffPm9LMizi+tmsA==
X-Received: by 2002:a05:600c:ca:b0:40d:3a32:7d51 with SMTP id
 u10-20020a05600c00ca00b0040d3a327d51mr8132657wmm.119.1704211531140; 
 Tue, 02 Jan 2024 08:05:31 -0800 (PST)
Received: from m1x-phil.lan (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 c18-20020a05600c0a5200b0040c6d559490sm45764022wmq.3.2024.01.02.08.05.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jan 2024 08:05:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Frederic Konrad <fkonrad@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 5/5] hw/arm/armv7m: Do not expose 'vfp' property if ARM
 CPU doesn't have it
Date: Tue,  2 Jan 2024 17:04:54 +0100
Message-ID: <20240102160455.68612-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102160455.68612-1-philmd@linaro.org>
References: <20240102160455.68612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since the TYPE_ARMV7M object doesn't know its CPU type at the
time armv7m_instance_init() is called, we need to prepare to
forward any CPU properties there, then we can forward them in
armv7m_realize().

But then when introspecting at runtime, in the case the requested
CPU doesn't expose such properties, we can still see them exposed
in the container.

It is possible to remove an unmeaningful property with
qdev_property_del_static(). As an example, remove the 'vfp'
property when not relevant.

When running the musca-a board, the monitor output changes as:

  (qemu) info qtree
    ...
    dev: armv7m, id ""
      gpio-in "NMI" 1
      gpio-out "SYSRESETREQ" 1
      gpio-in "" 96
      clock-in "cpuclk" freq_hz=40 MHz
      clock-in "refclk" freq_hz=0 Hz
      cpu-type = "cortex-m33-arm-cpu"
      init-svtor = 270532608 (0x10200000)
      init-nsvtor = 0 (0x0)
      enable-bitband = false
      start-powered-off = false
-     vfp = "false"
      dsp = false
      mpu-ns-regions = 8 (0x8)
      mpu-s-regions = 8 (0x8)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 12cdad09f9..f1f40353cb 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -244,6 +244,9 @@ static const MemoryRegionOps ppb_default_ops = {
     .valid.max_access_size = 8,
 };
 
+static Property optional_arm_cpu_vfp_property =
+    DEFINE_PROP_BOOL_NODEFAULT("vfp", ARMv7MState, vfp);
+
 static void armv7m_instance_init(Object *obj)
 {
     ARMv7MState *s = ARMV7M(obj);
@@ -271,6 +274,9 @@ static void armv7m_instance_init(Object *obj)
 
     s->refclk = qdev_init_clock_in(DEVICE(obj), "refclk", NULL, NULL, 0);
     s->cpuclk = qdev_init_clock_in(DEVICE(obj), "cpuclk", NULL, NULL, 0);
+
+    qdev_property_add_static(DEVICE(obj),
+                             &optional_arm_cpu_vfp_property);
 }
 
 static void armv7m_realize(DeviceState *dev, Error **errp)
@@ -331,6 +337,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     } else if (s->vfp == OPTIONAL_BOOL_TRUE) {
         error_setg(errp, "'%s' does not support VFP", s->cpu_type);
         return;
+    } else {
+        qdev_property_del_static(dev, &optional_arm_cpu_vfp_property);
     }
     if (object_property_find(OBJECT(s->cpu), "dsp")) {
         if (!object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, errp)) {
@@ -551,7 +559,6 @@ static Property armv7m_properties[] = {
     DEFINE_PROP_BOOL("enable-bitband", ARMv7MState, enable_bitband, false),
     DEFINE_PROP_BOOL("start-powered-off", ARMv7MState, start_powered_off,
                      false),
-    DEFINE_PROP_BOOL_NODEFAULT("vfp", ARMv7MState, vfp),
     DEFINE_PROP_BOOL("dsp", ARMv7MState, dsp, true),
     DEFINE_PROP_UINT32("mpu-ns-regions", ARMv7MState, mpu_ns_regions, UINT_MAX),
     DEFINE_PROP_UINT32("mpu-s-regions", ARMv7MState, mpu_s_regions, UINT_MAX),
-- 
2.41.0


