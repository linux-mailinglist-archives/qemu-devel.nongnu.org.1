Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 534317C6404
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn5I-0000cR-8H; Thu, 12 Oct 2023 00:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn5F-0000Wp-Ub
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:14:01 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn5C-0002ra-5L
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:14:01 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5859b1c92a0so426312a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084036; x=1697688836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbcAwgqyVZgE5vnTG2vb1GrD+tPHAjnhcgedbTgw9WM=;
 b=HvNVDWxCHXm3DcGlLd06JNS0YKFNOTW5B3PuRbgjEYWlsr/b2UThSVdn2wm/gqxs57
 FPsehjqjz6k3Nq4ywFbUSLwVhd4MOXHzmZnYdu53P20tAX1obH1dvOjBfl2u9P/TAO6b
 Sjnki54CV4liXypZ8Kr7yGUbahNh01oiLJCfWAifRi9iDA5RK9im6KI2pGzSZVg1+rG1
 d3uM28UEMscr4X9G5dPNkN+ta3RSxfR0FPbryQ/DqSG4jwryDMjVPHVAIHLU8/opWQLL
 v1a2IcYpW/cwtwVChHHI2nPbkOt/gHdQn9NEDP8ZlqhVIG7ze6N+88b7BZgsvrYvjeIR
 lLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084036; x=1697688836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbcAwgqyVZgE5vnTG2vb1GrD+tPHAjnhcgedbTgw9WM=;
 b=F9dpn7fkn2fOxVu7ZLwxIRbesdSfnieCPCLQiWFle3gFfvJ1yKfzlvP8jGL+MQeCTj
 5GhgCVPb3pdqnoHAlp2CzWyqi6yomo6YJH7WW+w5Rj1Ed10smNMqPd1uh9nkNYQBT4/k
 Gfu4tZwzlkMgotc7VBEDtMEtBKoBIyqmqUuGTxqpVn63RWkpiNJ+RkZ8F70s4nr4Od0t
 FWvjYUamqPCXiX8N0VpjSju+pnyYQ6YIqX6d+rmUwbG5aesdZxOOWQrkm81KefNNob9/
 KOg3mKROOinmQCMhLyU4fs2QhYvb6B+ESjHwf6I+O8JvOqTuOQDI1fqUxuicDd4+6BHt
 0RoA==
X-Gm-Message-State: AOJu0YyR+fytGfaicQhROnJAQwWWssXf452FKKqgih6LoXCLB1Tidifq
 8pTFbhzU+QdIKKjzU0eI/7hC8BKg6la2wA==
X-Google-Smtp-Source: AGHT+IHsLMY3v9UmUvfcDUXeJkJTGw5waDfDsenESyiHyWSeqzx/SyfOusv/ozBMnS7kKsPg2mI/fg==
X-Received: by 2002:a05:6a21:7892:b0:12c:2dc7:74bc with SMTP id
 bf18-20020a056a21789200b0012c2dc774bcmr27326646pzc.46.1697084036252; 
 Wed, 11 Oct 2023 21:13:56 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 50/54] target/riscv/kvm: support KVM_GET_REG_LIST
Date: Thu, 12 Oct 2023 14:10:47 +1000
Message-ID: <20231012041051.2572507-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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


