Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C97B67F5
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:33:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qndeY-0006EQ-Mt; Tue, 03 Oct 2023 07:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qndeT-0006De-R2
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 07:33:21 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qndeO-0003cO-Kw
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 07:33:21 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-578b4981526so494482a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 04:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696332795; x=1696937595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZBRPCwV1eqkJZCkaxgIVZPnxaps6chr3AJZy3D7g9g=;
 b=Z2ZNBoFD++v0eeVa25vnve8ECPMXy2A0TImPD8EtdKkRXx6rXZ7IDIwneppdJdK2cU
 NflferaEtk0W2kfB53sADvgkqvJU+k1FrKN7hnqZvlduOlXoE3018LxRsdjX+mk/aqnJ
 sMuoQb/nPcaSAP27BxKOacF64uxRv2DCB/jWBpf7dai3Bc5AgiA8d6ZmyHM3y3L5VC+y
 Dj6x6ksLb7F4mlU9NbPaemReOsV8TbTU2FZb6p5WClYDt+t4y2srSjDCJ7wVksNBGwC+
 A2E7AunFbXJdOF5V8YpV1W0agDK2SogQyPi2bLXZHjtl8o+zsu8Wol1caEW7qji5MzUe
 bX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696332795; x=1696937595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZBRPCwV1eqkJZCkaxgIVZPnxaps6chr3AJZy3D7g9g=;
 b=K5UPbLiI5pcRbe3LMGYQPBQWOhaNeOmwqH48LY4Hd7c8/Z0FQlCu0CLz16j6rj+LSA
 MsBO2l1CoWZV+9jVQZRoaSbCtc4dijlTkD5aUFM/ugzwVlM6V9cXsbpLazBvxJY+fF7P
 AGjv2sCcMgWjmFJsGsx9xThEeKxlRP5s2hZjPvA2Kk03r8fv8QdCE6BA/fOkOeC71O3n
 b2j7EsAf1Mhv/1oKk0/r87bhZwiedPoS9DRV6ZGptDpk2xz2G8+vmqZY/yXi0PvwjkE2
 oo8JhbOYj/lOiMEzwlmShIPwC78drr44HqnSfDKGiQlWQLTO93VUxUlUDmCWPmXr8V5r
 6Evw==
X-Gm-Message-State: AOJu0Yzm0L3juYeQS1haO6bAPApL7w0jKzBfwxtidZRQ9hZhXJcsUJfB
 s5bOfEQ/HdYrggPS7dmcAbwYYxN2ss3lQOTZGnU=
X-Google-Smtp-Source: AGHT+IEDGjzJOiD9EGjpDg+C4jOGQjm46vFt1UaSM2e81v0jqW4EdIe6NY0eYceHkiov38D2yPuDlQ==
X-Received: by 2002:a05:6a21:3d8d:b0:140:a25:1c1d with SMTP id
 bj13-20020a056a213d8d00b001400a251c1dmr12360975pzc.51.1696332794692; 
 Tue, 03 Oct 2023 04:33:14 -0700 (PDT)
Received: from grind.. ([177.94.15.124]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170902b60c00b001b850c9d7b3sm1285506pls.249.2023.10.03.04.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 04:33:14 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/2] target/riscv/kvm: support KVM_GET_REG_LIST
Date: Tue,  3 Oct 2023 08:32:59 -0300
Message-ID: <20231003113259.771539-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003113259.771539-1-dbarboza@ventanamicro.com>
References: <20231003113259.771539-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
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
 target/riscv/kvm/kvm-cpu.c | 93 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 847cb2876a..bef6610e1a 100644
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
@@ -811,6 +812,96 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
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
+        error_setg(&error_fatal, "Error when accessing get-reg-list, "
+                   "code: %s", strerrorname_np(errno));
+    }
+
+    reglist = g_malloc(sizeof(struct kvm_reg_list) +
+                       rl_struct.n * sizeof(uint64_t));
+    reglist->n = rl_struct.n;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_REG_LIST, reglist);
+    if (ret) {
+        error_setg(&error_fatal, "Error when reading KVM_GET_REG_LIST, "
+                   "code %s ", strerrorname_np(errno));
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
+            error_setg(&error_fatal, "Unable to read ISA_EXT "
+                       "KVM register %s, error code: %s",
+                       multi_ext_cfg->name, strerrorname_np(errno));
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


