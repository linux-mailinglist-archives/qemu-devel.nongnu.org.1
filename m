Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D747F73CC94
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 21:30:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD8xU-00006I-2I; Sat, 24 Jun 2023 15:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD8xR-00005d-NV
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 15:30:05 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD8xP-0007uP-RK
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 15:30:05 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313e09a5b19so595420f8f.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687635001; x=1690227001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wU88BtO0sTwE3bYofWLDGzDhy2I29H1Da5E42WxgmXI=;
 b=FRff/0NCKZq+Z+2kV+0yF60lILVHK3p6xNMENqSiuC+XSj+o+OaJ//xMeJjOgupfUf
 XdGQ8di7r+YY861H9buAUAbkuDwEraz58wee4p/XpF47b0clCiz2JWB+/xNfB2TraexA
 UaPQAcpbdE5HqRzU9RB89W8yq26MX6hHcKYoDq0jt7/HsuXXACMd5O8IyVCTR69XJeIO
 ayMiiScxzzcHLfgR3mrkA0niZ7OAhzjgb6/qKSWZEmw2ltgzNNJ/i3Lr+ySfckF6I27f
 uSNpd5PwQYTC7lPR/OOlF1YBr55MSroJfAezjvpxarcxLGIgQ9hFdOW+o4+ZUzlm51EV
 abNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687635001; x=1690227001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wU88BtO0sTwE3bYofWLDGzDhy2I29H1Da5E42WxgmXI=;
 b=Dm6yJl/hm7Q0HF7YLid/NlLyJ7Yqnes4+kRCjWR0eX47/gOjAz0hScClGWRa8dnhJN
 8rjarKRjgSnvc8ft5hsRFW4FzbeEg8ErxS231MeWSGDMB2MTHBf5yU+8w09wn7VEfBMQ
 tbkG+HSt67xp4lumZYQJqfE2rPfGss6CuzUEebQdSRZ1lUJ/y6FC7VqYbJQah/7Ce58C
 gq+/Xd4QKVYjlzV1UY2/4YVyOgENoIpApWhbZzuaii5LDIfXHPxdDhG3SiwjDxpRlHZg
 drON4BAR/ucrVMw5lDwby5+d0AAePBbOt1m3YpcBppL0eN4inFsPa1UjC+QqCZTyd4C3
 BOGQ==
X-Gm-Message-State: AC+VfDxoGisRh7qOsR7YD3Enx+TTOJisD0RFQzLx48TAeg3Ukah2IMw4
 HWmzbwJpxf4S1EHF2Tm/3YO2DapxFDSkz77phN8=
X-Google-Smtp-Source: ACHHUZ6nTOStIMehl3095EdhW2XoDDKDqOqIsM4OMFev4nU90sDjQreqrq0mopjSUIizknus+sr6wQ==
X-Received: by 2002:a5d:4e86:0:b0:30a:e589:68a5 with SMTP id
 e6-20020a5d4e86000000b0030ae58968a5mr21340362wru.29.1687635000750; 
 Sat, 24 Jun 2023 12:30:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d590a000000b0030631a599a0sm2795897wrd.24.2023.06.24.12.29.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 12:30:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liweiwei@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] target/riscv: Restrict KVM-specific fields from ArchCPU
Date: Sat, 24 Jun 2023 21:29:57 +0200
Message-Id: <20230624192957.14067-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
---
Since v1 https://lore.kernel.org/qemu-devel/20230405160454.97436-10-philmd@linaro.org/:
- Restrict whole vmstate_kvmtimer (thus drop Daniel's R-b)
---
 target/riscv/cpu.h     | 2 ++
 target/riscv/machine.c | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

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
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 3ce2970785..d27f8a2a3a 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -199,7 +199,8 @@ static bool kvmtimer_needed(void *opaque)
     return kvm_enabled();
 }
 
-static int cpu_post_load(void *opaque, int version_id)
+#ifdef CONFIG_KVM
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


