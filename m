Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4517073EF29
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 01:22:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDvVX-0004bF-Ru; Mon, 26 Jun 2023 19:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvVV-0004aT-Dd
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:20:29 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvVR-0008JA-NF
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:20:29 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-98df69cacd1so210807666b.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687821623; x=1690413623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D471PgeWyqak7jZe+2YA9NfSbgvi1QNeIRcTGaIHIiA=;
 b=FFQ+0bJRiM6EtllOnOWpubNIysujnBXbaUn8M4DJYLtY6Plx9e34XTXayY7SpvtHTX
 zXJTJ5fnqwYfGzagd34CnnoJv1z8c4QhMbMj0iYeOczvY2O23RHl5/OGxHuqBMGs0wO2
 tzmFS+KenLMFeXUEGU9nolTy44T8Vyz0Z4RBdGrAgI9NKhzdaUMGpmh2O7u9vD9pRhOv
 E0/boCpyaq1zwgd5RITM38aMg2OoGHDMBUTmMYqC5+qTf+fbAdwIEJhYu0ZPrwUhTGpb
 1HGOfPuHNi+WHnTTx8BaOtI7/agW4SvF0Ei+tMOa+uEY0z0PbWraGUAvxqQz7KaoDEaJ
 JM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687821623; x=1690413623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D471PgeWyqak7jZe+2YA9NfSbgvi1QNeIRcTGaIHIiA=;
 b=DxPpVsaE24byq8BnRT2kGA24VX6l0Rm9bg+mjNvrmdvZCYvsqGDNB2ipE++wTnforC
 +GykkaGDsVh4jzGoBpAoBXqsGe9TEnja1QsFbOOMtjN75a6wXW7QaEFjj6mXzFhO6S8T
 Tdgm8G9zIEWlLs8uDxFXb3K2O//ZSYcsF6mbVNcYwSxon6nl2W0S5D+8qpfkw6/lkv9y
 +ZflwMSOX/ycHoU66wOaLQF8lltHGtXyfocfcQFPZR5czwc1q/1NdPDDUg9lIGdv6076
 16iX+1kB+nCpzSxlFkI3IHHjSXG5hSVUAPQguHlCCTBHo7yDCEtLxgYWCm6PEWd814QT
 KRug==
X-Gm-Message-State: AC+VfDxWK1tWuvwTNd3sG/ZemqhEV1NpCZ98oW7ypEbAFxJ8TnciCOmG
 hhtLH59Xf+loQFkVcVHOfreXwVV2O9+JUiuVwEg=
X-Google-Smtp-Source: ACHHUZ7zAfOcbNWS/cWEujal4/ftdq3/Jh5Vs8pgcif9Da1R9qFX2z0rk7mgJ48Ju2red1wzx7UN5A==
X-Received: by 2002:a17:906:b844:b0:991:b554:e64b with SMTP id
 ga4-20020a170906b84400b00991b554e64bmr3140320ejb.54.1687821623261; 
 Mon, 26 Jun 2023 16:20:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.226])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b6d05f33sm3749382ejg.223.2023.06.26.16.20.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jun 2023 16:20:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org
Subject: [PATCH 02/16] target/riscv: Restrict KVM-specific fields from ArchCPU
Date: Tue, 27 Jun 2023 01:19:53 +0200
Message-Id: <20230626232007.8933-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230626232007.8933-1-philmd@linaro.org>
References: <20230626232007.8933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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
---
 target/riscv/cpu.h     | 2 ++
 target/riscv/cpu.c     | 2 +-
 target/riscv/machine.c | 8 ++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e3e08d315f..b1b56aa29e 100644
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


