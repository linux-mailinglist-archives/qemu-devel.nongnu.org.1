Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8289B7A4269
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 09:31:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi8iW-0000Fj-17; Mon, 18 Sep 2023 03:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qi8iI-0000F7-2o
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 03:30:35 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qi8iG-0002JG-7N
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 03:30:33 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-502a4f33440so6691541e87.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 00:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695022229; x=1695627029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lYkFl4hu5xxzYbXzFyCQ98u9LA4b+p9yjiVM5Qs1h4s=;
 b=DiFZ+TTPiufhiyCCe4WFy70JgT9AaMittYmEv0CTXfRlmI0JsQ5abHZKqAF9FZrZeh
 VYV/v0JMg0o8fxGUc6x1a4l9MmGG1nQaY4ZQ/LFISUnUzzmjNUS3AN89kxajJCy2yxjA
 popk0nEW5N7NhRS22QaTY3BujkEqxX4rsl56ElYn1cZ32IEApoRb/+gdUwN/UXZ1rY9p
 oe8nN6QhPoTNBfWNYj/57A/nu6XwthagkT5hm2SkB4ywHQtn/TViiJI3LgI17XCiBe2Y
 QySL0b6b5EBbAicK3uohCMbTmuvvObhm96JdXpGvbUB6IrVjihqiYoNxilX/63IgPGho
 Lgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695022229; x=1695627029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYkFl4hu5xxzYbXzFyCQ98u9LA4b+p9yjiVM5Qs1h4s=;
 b=vKgesymJ5uu4lzqDik/oj+iAv6cVplZvEffESWijx2EM+iScvls31W9JNceTqETQCO
 ywDLJQiMmZPsNi+ZOKg4pCgNT7WjSnB98aYsRpQpBXI05Pst1V8xTNB0QIuWu+UyITbk
 0A3z1IOhiLCuTO8/P0/5IIjryhB+rAQ9NTRO8fnKYHRkf3yZygYKDgJpRGuYWN5+YAZx
 q4GBpBUIgECaXB0s5e662rVPQGGh1tIH2bqTgeTrvPpdAv+DNpwCTOkxxtMRMXa261tS
 mM/L5GDFsZtD4IXv7xlU3nXmTCl6KufqYNxOWMM1eKPC/qW/ilCh2bk3k1h9Y8wjyq8z
 mymQ==
X-Gm-Message-State: AOJu0YxH6VsnF5jJFEvSxYqu9BN0QSjeHtZJxUS3WK5K1aYPufifOBNB
 C2pX6K5Pykt7tT8bVti+0V6oy/0mMUwJuuMpkGaExA==
X-Google-Smtp-Source: AGHT+IF/jmnBAmzqzr+JnDq6CZWQ6aryMelO0Os0dniUuWithM+qP+vgHuSEWLNmDWvsaURJFWKMdw==
X-Received: by 2002:a05:6512:39ca:b0:503:1c07:f7f6 with SMTP id
 k10-20020a05651239ca00b005031c07f7f6mr1200136lfu.17.1695022228193; 
 Mon, 18 Sep 2023 00:30:28 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.17]) by smtp.gmail.com with ESMTPSA id
 u25-20020a05600c00d900b003feff926fc5sm11546008wmm.17.2023.09.18.00.30.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 00:30:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alessandro Di Federico <ale@rev.ng>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH] hw/misc/mips_itu: Make MIPSITUState target agnostic
Date: Mon, 18 Sep 2023 09:30:23 +0200
Message-ID: <20230918073023.3846-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When prototyping a heterogenous machine including the ITU,
we get:

  include/hw/misc/mips_itu.h:76:5: error: unknown type name 'MIPSCPU'
      MIPSCPU *cpu0;
      ^

MIPSCPU is declared in the target specific "cpu.h" header,
but we don't want to include it, because "cpu.h" is target
specific and its inclusion taints all files including
"mips_itu.h", which become target specific too.

Avoid that by using the common CPUState structure. Add an
extra QOM check to ensure the CPU is of type MIPS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC:
ITU isn't relevant for the heterogeneous machines we are
interested to model, but I wanted something relatively easy
to start the discussion.

I'm not really happy about this because we lose the QOM type
check on the linked ArchCPU (thus I had to add it manually in
the device realize() handler). But I guess this is the compromise
we have to accept to include headers declaring target-specific
devices in a heterogeneous container.
---
 include/hw/misc/mips_itu.h | 2 +-
 hw/misc/mips_itu.c         | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 35218b2d14..7917524987 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -73,7 +73,7 @@ struct MIPSITUState {
 
     /* SAAR */
     uint64_t *saar;
-    MIPSCPU *cpu0;
+    CPUState *cpu0;
 };
 
 /* Get ITC Configuration Tag memory region. */
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 0eda302db4..2b46b132fb 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -530,9 +530,12 @@ static void mips_itu_realize(DeviceState *dev, Error **errp)
     if (!s->cpu0) {
         error_setg(errp, "Missing 'cpu[0]' property");
         return;
+    } else if (!object_dynamic_cast(OBJECT(s->cpu0), TYPE_MIPS_CPU)) {
+        error_setg(errp, "MIPS ITU expects a MIPS CPU");
+        return;
     }
 
-    env = &s->cpu0->env;
+    env = &MIPS_CPU(s->cpu0)->env;
     if (env->saarp) {
         s->saar = env->CP0_SAAR;
     }
@@ -563,7 +566,7 @@ static Property mips_itu_properties[] = {
                       ITC_FIFO_NUM_MAX),
     DEFINE_PROP_UINT32("num-semaphores", MIPSITUState, num_semaphores,
                       ITC_SEMAPH_NUM_MAX),
-    DEFINE_PROP_LINK("cpu[0]", MIPSITUState, cpu0, TYPE_MIPS_CPU, MIPSCPU *),
+    DEFINE_PROP_LINK("cpu[0]", MIPSITUState, cpu0, TYPE_CPU, CPUState *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


