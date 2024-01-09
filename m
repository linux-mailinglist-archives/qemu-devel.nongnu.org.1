Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A8E828C3A
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:13:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZL-0004dL-Tl; Tue, 09 Jan 2024 13:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYt-00034u-Vr
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:53 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYp-0004Rr-MT
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:50 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e5521db08so125035e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823844; x=1705428644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKXURkFhsCy0V0ubg/nJYR4pTGn8xQxbtylatTgX1X4=;
 b=jyKL/EmkJBfcvnSk2PlAVIRimiezjSgltVr4D4EaSb3l8Kr9EboA1kir9CBRR+CCik
 uCz127rGl50WbWPnyLodN8I4M2mzAvAoGjUBrTxC8EEGpiy6ri9YwQkC8ib1r6erIFZ4
 wj70R6daC+0cM0d3TlMmIXSeYU2DTrpqRM49IiSU6jWM7oOGUvYyNUqGnGwTdT1FyRPr
 9OSdQ8lwSJyOW3ZHEgqSoTqI3qKjilnitAh++qwGV0SKMZtUGMr9j/kZ6TbScrBAeSg6
 YmEvaqV1+ev84lpnjf8RDyDdYHP8f1xrfE9B0Y9zgCr1v29cKoSfYgDR5xKEx+AIULJD
 Dwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823844; x=1705428644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKXURkFhsCy0V0ubg/nJYR4pTGn8xQxbtylatTgX1X4=;
 b=IHwsnuuCVzSRrv5RzryQNOuuSI3dd7GLvcTuqBdhRcux9MK7tkWPAU6IoHR3eslDJx
 6CWgRLakwfcHfK6Fw7RVP4hUycfH7zUXxeUpRB6RYHrE4m56zwqVd5xj7o9XpM3m+/Vi
 Y8vnBnBhK2tnAmyNpCeTqitnueK+0deQwpAzT5ryMpyM9J7hoh3AJDUD/gchz97xmOr3
 AsInkcjS8S2plX8aT4FHwB9aZGj7ju08flR41s0eFlNcYq5RMRmtziC8udIN5CPeUMbv
 QFqP6w1PtIsahZ9QKW8it9py+I29GosLxLYMe4ZIisb+VvCV5E+Ahd53LnbFjd6AJSxM
 9ZUg==
X-Gm-Message-State: AOJu0YwLtQrkqc/UjSQLbaM24GK/EdP9LwSmpbC/BKk9KEMyV+A5w8SI
 Ypmb65fTNtgYBrLV05uoKpKBDfKklV8pVV7fQ/C5FxM0QEbAiA==
X-Google-Smtp-Source: AGHT+IHjV0TvmBLA9WFnSsyWWHMR3APuO4MZjZIF0jPXU/Ws3vRpGE54iQvFItP+9NQO3t8cNQKgAQ==
X-Received: by 2002:a05:600c:154d:b0:40e:3dad:efe8 with SMTP id
 f13-20020a05600c154d00b0040e3dadefe8mr3265076wmg.87.1704823844642; 
 Tue, 09 Jan 2024 10:10:44 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 p11-20020a5d59ab000000b00336ebf93416sm3047825wrr.17.2024.01.09.10.10.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:10:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/14] hw/arm: Prefer arm_feature(CBAR*) over
 object_property_find(reset-cbar)
Date: Tue,  9 Jan 2024 19:09:26 +0100
Message-ID: <20240109180930.90793-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


