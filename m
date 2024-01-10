Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0511382A19F
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNef4-0001E0-AH; Wed, 10 Jan 2024 14:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNef2-00010u-6T
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:48 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeez-0002ZI-4O
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:47 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e4d515cdeso26628765e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916483; x=1705521283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKXURkFhsCy0V0ubg/nJYR4pTGn8xQxbtylatTgX1X4=;
 b=eqPtW453j3KOCZxwasGOPX/zuvvSEhGP40gTW/p54zDVF0uStvojcOPDVtHza4nu/9
 jA9VCFSYtSMciBq8aAO6vs9djC2RmWB34cqSsYKY+5dzVb5u6WMeWrvAVg8HJXGZNxqO
 RbijqU1OihUvKdsy00R1urIWB4QXom9IbIt48CMNFeh0qJ63EHCtXOg0nN+G7kQzMS7X
 KU7rifRokBtjJ1qAN/be/OKRP+W8evEL4RFKzUV2ZK3r0r6RpbIrpBCvNB8Ybj9zClS3
 yBWwMNAHvHuzCPAHbobYmlm6CKfQUqShCalemaimHH836c7ECQzrsWjpYvgz1NAg1rXu
 Wa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916483; x=1705521283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKXURkFhsCy0V0ubg/nJYR4pTGn8xQxbtylatTgX1X4=;
 b=qWeQ+QRqrUmQRzVw4vEbApiJPHpStYP34zMjspbE/o5mGaNYOOzonoD2ie9/qgTBvp
 KYmN1N1agTKHDRV21xBGYnfVTb4i6vV1leE15BRvj4sUtKMGqxt4LPI1M6X/59oi6p/J
 WhhKf+T+Aq7IRU3+uiYsUDfIa++KOfSOasaiOHLmDfmNrjVlZOV2UTe6vtDbGFOZ3FdY
 Gpavs4s3xf59jhAoPdY5wN5Ph3XndZS5qzT54hO7ReIwswiIgDgpnqSHdyQpg30MSe2J
 MZgLtmeQbuD4U8bXiezV6OiD8zr5wYO0nBFheeA8CgsgbAUCmn7H/Jbh5MfHh76b2UhQ
 nZNw==
X-Gm-Message-State: AOJu0YzmLV2fN9Iba8in7wPXy/TOGA6UXqjcFf3NywZhWp+NnfbGPDdG
 Pu2tf/jKcIRwNnnkJIPcsh+jeHIm2wJDjiKGUNpWuTdh9RU=
X-Google-Smtp-Source: AGHT+IFow5aH/cxXlfW34HD3g8cDhzSgk52saCbfY8RrKlXKt9CSLCukyjZ6ZAJolaf+X5S5w2rFiA==
X-Received: by 2002:a05:600c:1908:b0:40e:44b5:511e with SMTP id
 j8-20020a05600c190800b0040e44b5511emr830051wmq.99.1704916483457; 
 Wed, 10 Jan 2024 11:54:43 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 m22-20020a05600c4f5600b0040e4561e231sm3234605wmq.17.2024.01.10.11.54.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:54:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/14] hw/arm: Prefer arm_feature(CBAR*) over
 object_property_find(reset-cbar)
Date: Wed, 10 Jan 2024 20:53:24 +0100
Message-ID: <20240110195329.3995-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The "reset-cbar" property is added to ARMCPU when the
ARM_FEATURE_CBAR[_RO] features are available. Rather than
checking whether the QOM property is present, directly
check the features.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/highbank.c | 3 ++-
 hw/arm/sbsa-ref.c | 3 ++-
 hw/arm/vexpress.c | 3 ++-
 hw/arm/virt.c     | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index c21e18d08f..b06a727c06 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -211,7 +211,8 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         object_property_set_int(cpuobj, "psci-conduit", QEMU_PSCI_CONDUIT_SMC,
                                 &error_abort);
 
-        if (object_property_find(cpuobj, "reset-cbar")) {
+        if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
+            arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
             object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
                                     &error_abort);
         }
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 477dca0637..c073c462c7 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -770,7 +770,8 @@ static void sbsa_ref_init(MachineState *machine)
         numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
                           &error_fatal);
 
-        if (object_property_find(cpuobj, "reset-cbar")) {
+        if (arm_feature(cpu_env(cs), ARM_FEATURE_CBAR) ||
+            arm_feature(cpu_env(cs), ARM_FEATURE_CBAR_RO)) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     sbsa_ref_memmap[SBSA_CPUPERIPHS].base,
                                     &error_abort);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 753a645c05..ea3c76f3e1 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -229,7 +229,8 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
             }
         }
 
-        if (object_property_find(cpuobj, "reset-cbar")) {
+        if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
+            arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
             object_property_set_int(cpuobj, "reset-cbar", periphbase,
                                     &error_abort);
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 35eb01a3dc..7e7350fec2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2168,7 +2168,8 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "lpa2", false, NULL);
         }
 
-        if (object_property_find(cpuobj, "reset-cbar")) {
+        if (arm_feature(cpu_env(cs), ARM_FEATURE_CBAR) ||
+            arm_feature(cpu_env(cs), ARM_FEATURE_CBAR_RO)) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     vms->memmap[VIRT_CPUPERIPHS].base,
                                     &error_abort);
-- 
2.41.0


