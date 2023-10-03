Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD577B6A60
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 15:22:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnfLx-0001xj-Ih; Tue, 03 Oct 2023 09:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qnfLt-0001tb-Vw
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:22:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qnfLj-0002ep-9l
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:22:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-692c70bc440so673082b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696339324; x=1696944124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzlZXFlmrklwSn/+uC5Mi9MdymXGVusYVm5vMvkTEJs=;
 b=nmXLI944vwAPZ71Phw52wXE83k6PBeeY3mIiEJXsICls9WUzxy3ndCwDsmjlyxHHhq
 Thfhy80WTABYRk1B/NP/3rOjzfSBu1Lhq47LGUxldK6fcsVtGNvgo10GYicSAmHig6R1
 oXnHlFrrG0Kk1BKVd44GOJfhX04a3fPjEg+R2Oa/Ep6ZuJE0rIZ1H70MbiWlHxdha+Eo
 JH2/LQaDmBQWPhtVEe/Gy65bTnYWrIBXsSWJVcP1nI9ZxaNb5HcSg6MJnX3ZQ5XOUr3W
 N3Y2OOzciKmCq0WYFxxoDUt4Obo/+WInn3pDpAGd9SW9NF1t89pQ8Bnt4Cka+Qlf+2h1
 hqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696339324; x=1696944124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nzlZXFlmrklwSn/+uC5Mi9MdymXGVusYVm5vMvkTEJs=;
 b=OQtGFyLI0tlTEtfD1eVtRLYln38mi4t3sXLMmfUC0aIZnRjCAviDrQgmsKGpl1b2pM
 gzz6hY6pKZ0FgopgPMMkNo8rM46NrnQKNCjFM2BZxXaRZ+/KRyaOYyLP/l6sSXOscPhl
 zRpDskfb8dcGsnicnQSB4F7mp+BhYyvhJCpDivsM3UzV4fJJg8+jbdWaGP9fC1odUX12
 GAPPWfy6/5QZB+KvR7XD6q2/M/d2Rdr3QdVKnQ210d2U/qow3fDelF5kNSP57Cs+M+6Q
 v6dmN8taUSS/FIOTNkOPRfgaRqaoX+c4rZDdYTHXTjk7O1HTCcDnHAfnL9uUbLal46bv
 8X2A==
X-Gm-Message-State: AOJu0YzDcHUvvG+xOQPHYu7ZjJShi4lkSaJ4srZVLPNA4tqbWCUB+7l/
 p/nV4jOrZ8Pc3GNwJNwYps0BsDyq01m48NF+wYI=
X-Google-Smtp-Source: AGHT+IGy97riSrkQtFLtBGDBviyNTvNwXOLl5pEQ9wyGuhVbpjKKAx0JWFij8ft91rYeyD2yA+QN+g==
X-Received: by 2002:a05:6a20:9750:b0:153:353e:5e39 with SMTP id
 hs16-20020a056a20975000b00153353e5e39mr11708438pzc.51.1696339324189; 
 Tue, 03 Oct 2023 06:22:04 -0700 (PDT)
Received: from grind.. ([177.94.15.124]) by smtp.gmail.com with ESMTPSA id
 u11-20020a17090282cb00b001bf11cf2e21sm1491777plz.210.2023.10.03.06.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 06:22:03 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/2] target/riscv/kvm: support KVM_GET_REG_LIST
Date: Tue,  3 Oct 2023 10:21:48 -0300
Message-ID: <20231003132148.797921-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003132148.797921-1-dbarboza@ventanamicro.com>
References: <20231003132148.797921-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/kvm/kvm-cpu.c | 96 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c3daf74fe9..090d617627 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -771,7 +771,8 @@ static void kvm_riscv_read_cbomz_blksize(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
     }
 }
 
-static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
+                                           KVMScratchCPU *kvmcpu)
 {
     CPURISCVState *env = &cpu->env;
     uint64_t val;
@@ -812,6 +813,99 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
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
 static void riscv_init_kvm_registers(Object *cpu_obj)
 {
     RISCVCPU *cpu = RISCV_CPU(cpu_obj);
-- 
2.41.0


