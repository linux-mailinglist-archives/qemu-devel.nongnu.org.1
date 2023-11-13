Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 650387EA269
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:51:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2b5A-00039k-Un; Mon, 13 Nov 2023 12:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2b50-00033S-Ek
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:50:37 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2b4t-0003yl-Bq
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:50:34 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-28094a3b760so3750165a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699897822; x=1700502622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXk9JJuHWXIC7hCJTygEtlFoprhsENRX8ZByQS+6clk=;
 b=gKKKKCoqw0byGlul+StO4b8q9l0QOyPAadi1alS1F6t7Af10AIltsMe3KJg+qAAUif
 OKVkHTFyHXprQvRcizrbUfxJg2d5h0Yl5Wk6PY575AP3S4UzmlpmABtgGRYXFDyGzfUU
 bmkobU+ukYo8ON4bUMRlu/MsHru1KyEeQxhUsm1RSBBOp0lahRcK3Gtgf9J/KErYBI65
 yUARnl3yMv4A0BhEH0VjxCCpIqTSlh3iRACsV96CqF4i7EUI3CzjsUAEqYAZor35A9kl
 DdJG0Gz34HYJnAu9tjd46t08tEDzWIi81aneCiKeivOBBAB0Q6CxG/1+ymBS6T5LsIVU
 mfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699897822; x=1700502622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXk9JJuHWXIC7hCJTygEtlFoprhsENRX8ZByQS+6clk=;
 b=Yay2mfL+mELKQSKfcMQouyS+Vr8rt0oTK7WzS9ld/A684Gi1+F2k27kB9Xu8RiwxtV
 TpZQbeimIiWNVHqmAwRwPE6H3TYv6b2vvgbAHDtKGUk8cLwgUnkzME/d4jKSzYrbFhCb
 e9Ud+69ssNIfc+sPUUFWE5Tz0PBPAOqmdOmj58m2LBr5NLWUeBE2pwPWUw678YbOLuog
 5jFmWlu0C3B29gE8/cNRiwn1EOfGKLFtWX5toy/x/cLs4uubMa5ZRbQ7VJg2siR/l6ah
 hQmVW+cEQNLxGur8L6NKgvcZ0OvYSFZsuoA2+Pg5F0fB3rc5g09AN02WgkGZIkaLndJn
 rrLQ==
X-Gm-Message-State: AOJu0Yz47noQnMwvwmcapIFn5pHEWfga+PC43ycOFVFZTIi/huBuQaUy
 o/NALxP3BXmViqGFRu1UY+B4PjaEZWgtb2bBdrk=
X-Google-Smtp-Source: AGHT+IGTJPadGyG8fU0l3EHo/uYH9uOJ06Yro6v78v+XSOvBGFmLAfs7lnUlw8RbX7rQ8N8HMDpWTA==
X-Received: by 2002:a17:90b:3012:b0:281:df:fb2a with SMTP id
 hg18-20020a17090b301200b0028100dffb2amr5033983pjb.35.1699897822298; 
 Mon, 13 Nov 2023 09:50:22 -0800 (PST)
Received: from grind.. ([152.250.131.148]) by smtp.gmail.com with ESMTPSA id
 hg23-20020a17090b301700b00277560ecd5dsm5869329pjb.46.2023.11.13.09.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:50:21 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, mjt@tls.msk.ru, alistair.francis@wdc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH stable-8.1.3 2/2] target/riscv/kvm: support KVM_GET_REG_LIST
Date: Mon, 13 Nov 2023 14:50:11 -0300
Message-ID: <20231113175011.151022-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113175011.151022-1-dbarboza@ventanamicro.com>
References: <20231113175011.151022-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102c.google.com
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

KVM for RISC-V started supporting KVM_GET_REG_LIST in Linux 6.6. It
consists of a KVM ioctl() that retrieves a list of all available regs
for get_one_reg/set_one_reg. Regs that aren't present in the list aren't
supported in the host.

This simplifies our lives when initing the KVM regs since we don't have
to always attempt a KVM_GET_ONE_REG for all regs QEMU knows. We'll only
attempt a get_one_reg() if we're sure the reg is supported, i.e. it was
retrieved by KVM_GET_REG_LIST. Any error in get_one_reg() will then
always considered fatal, instead of having to handle special error codes
that might indicate a non-fatal failure.

Start by moving the current kvm_riscv_init_multiext_cfg() logic into a
new kvm_riscv_read_multiext_legacy() helper. We'll prioritize using
KVM_GET_REG_LIST, so check if we have it available and, in case we
don't, use the legacy() logic.

Otherwise, retrieve the available reg list and use it to check if the
host supports our known KVM regs, doing the usual get_one_reg() for
the supported regs and setting cpu->cfg accordingly.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231003132148.797921-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 608bdebb6075b757e5505f6bbc60c45a54a1390b)
---
 target/riscv/kvm.c | 96 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index c8e1bb9087..3fb29299d9 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -706,7 +706,8 @@ static void kvm_riscv_read_cbomz_blksize(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
     }
 }
 
-static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
+                                           KVMScratchCPU *kvmcpu)
 {
     CPURISCVState *env = &cpu->env;
     uint64_t val;
@@ -747,6 +748,99 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     }
 }
 
+static int uint64_cmp(const void *a, const void *b)
+{
+    uint64_t val1 = *(const uint64_t *)a;
+    uint64_t val2 = *(const uint64_t *)b;
+
+    if (val1 < val2) {
+        return -1;
+    }
+
+    if (val1 > val2) {
+        return 1;
+    }
+
+    return 0;
+}
+
+static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+{
+    KVMCPUConfig *multi_ext_cfg;
+    struct kvm_one_reg reg;
+    struct kvm_reg_list rl_struct;
+    struct kvm_reg_list *reglist;
+    uint64_t val, reg_id, *reg_search;
+    int i, ret;
+
+    rl_struct.n = 0;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_REG_LIST, &rl_struct);
+
+    /*
+     * If KVM_GET_REG_LIST isn't supported we'll get errno 22
+     * (EINVAL). Use read_legacy() in this case.
+     */
+    if (errno == EINVAL) {
+        return kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
+    } else if (errno != E2BIG) {
+        /*
+         * E2BIG is an expected error message for the API since we
+         * don't know the number of registers. The right amount will
+         * be written in rl_struct.n.
+         *
+         * Error out if we get any other errno.
+         */
+        error_report("Error when accessing get-reg-list, code: %s",
+                     strerrorname_np(errno));
+        exit(EXIT_FAILURE);
+    }
+
+    reglist = g_malloc(sizeof(struct kvm_reg_list) +
+                       rl_struct.n * sizeof(uint64_t));
+    reglist->n = rl_struct.n;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_REG_LIST, reglist);
+    if (ret) {
+        error_report("Error when reading KVM_GET_REG_LIST, code %s ",
+                     strerrorname_np(errno));
+        exit(EXIT_FAILURE);
+    }
+
+    /* sort reglist to use bsearch() */
+    qsort(&reglist->reg, reglist->n, sizeof(uint64_t), uint64_cmp);
+
+    for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
+        multi_ext_cfg = &kvm_multi_ext_cfgs[i];
+        reg_id = kvm_riscv_reg_id(&cpu->env, KVM_REG_RISCV_ISA_EXT,
+                                  multi_ext_cfg->kvm_reg_id);
+        reg_search = bsearch(&reg_id, reglist->reg, reglist->n,
+                             sizeof(uint64_t), uint64_cmp);
+        if (!reg_search) {
+            continue;
+        }
+
+        reg.id = reg_id;
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            error_report("Unable to read ISA_EXT KVM register %s, "
+                         "error code: %s", multi_ext_cfg->name,
+                         strerrorname_np(errno));
+            exit(EXIT_FAILURE);
+        }
+
+        multi_ext_cfg->supported = true;
+        kvm_cpu_cfg_set(cpu, multi_ext_cfg, val);
+    }
+
+    if (cpu->cfg.ext_icbom) {
+        kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbom_blocksize);
+    }
+
+    if (cpu->cfg.ext_icboz) {
+        kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cboz_blocksize);
+    }
+}
+
 void kvm_riscv_init_user_properties(Object *cpu_obj)
 {
     RISCVCPU *cpu = RISCV_CPU(cpu_obj);
-- 
2.41.0


