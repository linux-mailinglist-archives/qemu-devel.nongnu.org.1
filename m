Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3C97F0844
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 19:21:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4mPQ-0005J9-A3; Sun, 19 Nov 2023 13:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r4mPK-0005EA-5D; Sun, 19 Nov 2023 13:20:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r4mPG-00086m-8O; Sun, 19 Nov 2023 13:20:33 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E4DF434904;
 Sun, 19 Nov 2023 21:20:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 492D936243;
 Sun, 19 Nov 2023 21:20:07 +0300 (MSK)
Received: (nullmailer pid 3314147 invoked by uid 1000);
 Sun, 19 Nov 2023 18:20:06 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 56/59] target/riscv/kvm: support KVM_GET_REG_LIST
Date: Sun, 19 Nov 2023 21:19:52 +0300
Message-Id: <20231119182006.3314111-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231119211540@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231119211540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
(cherry picked from commit 608bdebb6075b757e5505f6bbc60c45a54a1390b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: trivial context tweak in target/riscv/kvm.c)

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
2.39.2


