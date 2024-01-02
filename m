Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1E0821F35
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 17:06:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKhGo-0006NG-Nq; Tue, 02 Jan 2024 11:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGc-0006HB-GJ
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:24 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGa-0002dS-4T
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:22 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3367632ce7bso8283814f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704211518; x=1704816318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J38P+ankfUbUztT5GJCTo6FfwFdn7YoTpHgRI5fDY8Q=;
 b=Kh0/g3pWmtcjNrg2GA+ugfeewPTLorGSMcQtucfc0dK86ejPhvL8cAAgZTqvDKUVl5
 p/uXgdMDSrEY85KGPdwoQECS0/qG98VIrE9x3kObWu29mSleCdUOM7+8AvapXPT9xeVn
 kjPLi5E1zm3CsFxYozi4kK73PGXvBbNoKEOZB/fECvArh7KciYy4UAAJnhPE04OOKWE+
 CdZfJPy7CcHp8L3cElNUFwRXf1E6gN9CzFbvlGlY2xIQUYpY1xDPBQEPVjIhb1y4ce5t
 96ji0Ip9YsSR/G83ZJ/Q/3JAQi6nMBjZ5Xsz88GGnevAgGt+DVxOPKChrE5olH198mga
 0FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704211518; x=1704816318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J38P+ankfUbUztT5GJCTo6FfwFdn7YoTpHgRI5fDY8Q=;
 b=GYg6uweQpgAc7/UUjly63AX3TiBtBl12dnvM1fvP/cFES/NsJZQ1dRRCstdoJoTn6N
 JtyLhecOKSqhqMToa+QKmxB58friS9a5LG9Om1bvFi4FC7K4f4A9qwXkxNryTWf1Zh83
 qKW9F3rQoFg7HA499JgFJHC7YgAWhVNq84kORN3/Uhk0/aeBh1v8MOCUwZNn/UyhavsA
 2QgqYS1Nql9fGReS/wh2YqjsR6Bk2HpCmD8KwfBwPZfMAwnHuLRMVQ+8pcqbKoaXoTA1
 Pl4eoauRFL5cKCz+PjznS1ZMEXMGDhvmMgQHnKOYm0bztM+zGz+d/ggGv7aCG4SBiAAK
 46Cg==
X-Gm-Message-State: AOJu0Yxg18DrG8SeZ+wlG/wH+twAr9YsvhT+quUfnfTsIeGmFB4s7akA
 c2FYIoX7pBOTuzvkE5SH/nMhN+PsPI6gGDkBlSG8W4mq9qg=
X-Google-Smtp-Source: AGHT+IGK81sSXeAZVigy9QHy8W3v7E9N09SlmUg/+/UeieW3S9EWG4i4DkIxryo3kfAalZFebgBIRA==
X-Received: by 2002:adf:ec82:0:b0:337:37c2:fc57 with SMTP id
 z2-20020adfec82000000b0033737c2fc57mr2610183wrn.106.1704211518286; 
 Tue, 02 Jan 2024 08:05:18 -0800 (PST)
Received: from m1x-phil.lan (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 b16-20020a056000055000b003372dcd739csm9582956wrf.86.2024.01.02.08.05.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jan 2024 08:05:17 -0800 (PST)
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
Subject: [RFC PATCH 3/5] hw/arm/armv7m: Convert ARMv7MState::vfp from bool to
 OptionalBool
Date: Tue,  2 Jan 2024 17:04:52 +0100
Message-ID: <20240102160455.68612-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102160455.68612-1-philmd@linaro.org>
References: <20240102160455.68612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

We want to know if the 'vfp' property has been initialized.
Convert it from boolean to OptionalBool (which contain the
'unset' enum).

Note the monitor output is changed as:

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
-     vfp = false
+     vfp = "false"
      dsp = false
      mpu-ns-regions = 8 (0x8)
      mpu-s-regions = 8 (0x8)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/armv7m.h | 2 +-
 hw/arm/armsse.c         | 2 +-
 hw/arm/armv7m.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index e2cebbd15c..6c9e65b644 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -105,7 +105,7 @@ struct ARMv7MState {
     uint32_t mpu_s_regions;
     bool enable_bitband;
     bool start_powered_off;
-    bool vfp;
+    OptionalBool vfp;
     bool dsp;
 };
 
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 31acbf7347..472b16fc30 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1028,7 +1028,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             }
         }
         if (!s->cpu_fpu[i]) {
-            if (!object_property_set_bool(cpuobj, "vfp", false, errp)) {
+            if (!object_property_set_str(cpuobj, "vfp", "false", errp)) {
                 return;
             }
         }
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index d10abb36a8..3610f6f4a1 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -548,7 +548,7 @@ static Property armv7m_properties[] = {
     DEFINE_PROP_BOOL("enable-bitband", ARMv7MState, enable_bitband, false),
     DEFINE_PROP_BOOL("start-powered-off", ARMv7MState, start_powered_off,
                      false),
-    DEFINE_PROP_BOOL("vfp", ARMv7MState, vfp, true),
+    DEFINE_PROP_BOOL_NODEFAULT("vfp", ARMv7MState, vfp),
     DEFINE_PROP_BOOL("dsp", ARMv7MState, dsp, true),
     DEFINE_PROP_UINT32("mpu-ns-regions", ARMv7MState, mpu_ns_regions, UINT_MAX),
     DEFINE_PROP_UINT32("mpu-s-regions", ARMv7MState, mpu_s_regions, UINT_MAX),
-- 
2.41.0


