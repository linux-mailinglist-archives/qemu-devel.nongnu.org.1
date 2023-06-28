Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2367415F4
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXX2-0003NK-EJ; Wed, 28 Jun 2023 11:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWU-0002oq-7o
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:56:05 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWJ-0001qN-88
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:52 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f8735ac3e3so8741037e87.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967749; x=1690559749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+ZDEfi36SOkHrG1dMSIzURkkU/Whlh5zESiI+Pn1BQ=;
 b=wzjYdzPq6+z5udYXUpbJYmf/NQStNtIBa+s6s9DI1921PUZ++SH8/UHQ4uO8FBTKWz
 fkQBv5FTRDRFUtWFUMRkSc1m0k2+uUid4SUN3f8qgPtEgmH9nDSKiFEWZUjmbsheFplN
 y/knchuSCel/kLdLsNz56nTbI1hc+Zik7USnqGXv86JLG3Do5IgNS1aQmNHLrztWQboQ
 OXmi4ERd3FpD0fmdWArRVhXzGmIyEfYRwXH9bZAttRQaDRMbNOvOg4ewhhOYRUbn3nwD
 zpnwCs+mOEg/doA9nWHXT0vJ7jVqugFkiHqkPrY7k2vgF3bBfXd7u0vvAgG410Q2OVMw
 aSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967749; x=1690559749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+ZDEfi36SOkHrG1dMSIzURkkU/Whlh5zESiI+Pn1BQ=;
 b=bu0QIzWIL8WCUHtb9Qw+vR9RVo596GRmZmeHT9O936QXmkZln1KzXP3jcGaj2lcIlD
 jaiKE8QHGRpCzzuCdOmBEZLs5ZoGK4VpEKfrWC2/Z/l/37lIZ/x7EumG3BbVrPCW64dN
 ta17cp3MPlK2wCCzFzVX7SZqPcQ6JMLaBVhiiW+h9PUYUt4kNMIGkKoK1TM/J4t5mPlb
 xAuYC+gpBl66hyOT4osNZnnyr/qXk8PreRydJaxTT43siDT5QRv6SElo6qhq3UEKtmZW
 AYxoQexXMzano1WvVFV19K1lF+qNp6mMMJVX4YFCt6nfhcEkGLfpPYNQ0KVzFXamGly7
 ssdQ==
X-Gm-Message-State: AC+VfDzxs26tcQNJ4g5LDg7Cv4y1wmD3F2UrVGbvHdJ3HI+RQITRqfhz
 VhWg5DKYXBBmACdyR30OQwn5rhLUPSNj4Zj6zJU=
X-Google-Smtp-Source: ACHHUZ6vlk1hKSNlw3g2LO9xTnXjwoxEKPiIbk5AMYXY6Ap/d2C/NSO+hYkDP1/O2cueKuq+4nBzig==
X-Received: by 2002:a05:6512:684:b0:4f9:b649:23d2 with SMTP id
 t4-20020a056512068400b004f9b64923d2mr9248064lfe.42.1687967749349; 
 Wed, 28 Jun 2023 08:55:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a05600c21c900b003fb41491670sm6755700wmj.24.2023.06.28.08.55.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:55:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 26/30] target/riscv: Restrict KVM-specific fields from ArchCPU
Date: Wed, 28 Jun 2023 17:53:09 +0200
Message-Id: <20230628155313.71594-27-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

These fields shouldn't be accessed when KVM is not available.

Restrict the KVM timer migration state. Rename the KVM timer
post_load() handler accordingly, because cpu_post_load() is
too generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230626232007.8933-3-philmd@linaro.org>
---
 target/riscv/cpu.h     | 2 ++
 target/riscv/cpu.c     | 2 +-
 target/riscv/machine.c | 8 ++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7bff1d47f6..7adb8706ac 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -363,12 +363,14 @@ struct CPUArchState {
     hwaddr kernel_addr;
     hwaddr fdt_addr;
 
+#ifdef CONFIG_KVM
     /* kvm timer */
     bool kvm_timer_dirty;
     uint64_t kvm_timer_time;
     uint64_t kvm_timer_compare;
     uint64_t kvm_timer_state;
     uint64_t kvm_timer_frequency;
+#endif /* CONFIG_KVM */
 };
 
 /*
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 881bddf393..4035fe0e62 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -584,7 +584,7 @@ static void riscv_host_cpu_init(Object *obj)
 #endif
     riscv_cpu_add_user_properties(obj);
 }
-#endif
+#endif /* CONFIG_KVM */
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 3ce2970785..c7c862cdd3 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -194,12 +194,13 @@ static const VMStateDescription vmstate_rv128 = {
     }
 };
 
+#ifdef CONFIG_KVM
 static bool kvmtimer_needed(void *opaque)
 {
     return kvm_enabled();
 }
 
-static int cpu_post_load(void *opaque, int version_id)
+static int cpu_kvmtimer_post_load(void *opaque, int version_id)
 {
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
@@ -213,7 +214,7 @@ static const VMStateDescription vmstate_kvmtimer = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = kvmtimer_needed,
-    .post_load = cpu_post_load,
+    .post_load = cpu_kvmtimer_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(env.kvm_timer_time, RISCVCPU),
         VMSTATE_UINT64(env.kvm_timer_compare, RISCVCPU),
@@ -221,6 +222,7 @@ static const VMStateDescription vmstate_kvmtimer = {
         VMSTATE_END_OF_LIST()
     }
 };
+#endif
 
 static bool debug_needed(void *opaque)
 {
@@ -409,7 +411,9 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_vector,
         &vmstate_pointermasking,
         &vmstate_rv128,
+#ifdef CONFIG_KVM
         &vmstate_kvmtimer,
+#endif
         &vmstate_envcfg,
         &vmstate_debug,
         &vmstate_smstateen,
-- 
2.38.1


