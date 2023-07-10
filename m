Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5B974D5B4
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:36:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq6u-0001L4-4U; Mon, 10 Jul 2023 08:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6p-0000zO-HG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:35:19 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6n-0005Jx-GT
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:35:18 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b7206f106cso3585498a34.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992515; x=1691584515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWymny+SflbK0Ym6RhHcoUeMxfPC5BWDHZ4lHnpRMwo=;
 b=L77Ld7x1PEag5g8dyIPPR+dHg7e0i2xYyAzgftQfuLHi39afSl5kGz6y+Klqcjseo4
 LZi5dHb5ir6JoeEqy/pGuVVQ5C0R4FuENiT7x9orUtLUy0RDHKmzfJINmVrkyuPsZgiw
 dtyBxYbwHfIclX1L0d8iC4fbfijO348qv7I/t+OQ5hrmPzOMmllIFEzb+MIQdL28q0A8
 UMDN+euWO3qFwS/MkiaVceFjcMFt5KqrxZ5yuZIkZLYnW4n9yFA4Ej4Ftew+cwdkRcev
 4SdiQB8Gbfxn6p+XAYLPYHyPVTLp22SR+9I02IWp88vVGPGuZ9l06wjFJ+QwGQa+y7zn
 d2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992515; x=1691584515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FWymny+SflbK0Ym6RhHcoUeMxfPC5BWDHZ4lHnpRMwo=;
 b=B7mY8MrMaTTXEOKC2E54FJp5wCIcyTvrac7xccdVLKfzl3fNkAQeUtfEmpkuDvluIG
 bP15GCtSHMHzuTukZ6Db4SIxU4yuE/A0yxLA6jttEAi4FfBZxB5OXumJIo2CzvJKB9SX
 YGM8KSezwDh2LJn6UWQkPV6ZCWSAijAcrpgpBQWZCEyCaWtbCRkKfE91T8DfH20nDuVx
 JQiByLh8772fpoG9H+pzusfXLB5taMRsBeU1Rwe+Y1XiQr5wKgJnm47Bh/to83vf6unH
 20ZLovdqCx6Yl8rrZv2hXWuzAKa8rePD2n4/HtIB2qONjACUWF1RnJ7Roj2IFLsbLl7L
 ab3Q==
X-Gm-Message-State: ABy/qLZ/Duu6Wb7HPjNURYLfQRrsCeOWhfwRE3vBMUzeMuFvQc01Q88g
 g/WQjV5XC/U4cOjEv6F2GhXrZajKdcuPdg==
X-Google-Smtp-Source: APBJJlHJztAXmJZLwrBOTMjlVyMUPAFo6Zoa3hsrsyXfEVnydOOZdLqqz39jlA5o9gqDf+eBzgYndg==
X-Received: by 2002:a05:6830:2001:b0:6b9:6287:618b with SMTP id
 e1-20020a056830200100b006b96287618bmr1951006otp.24.1688992515193; 
 Mon, 10 Jul 2023 05:35:15 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:35:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 51/54] target/riscv: update multi-letter extension KVM
 properties
Date: Mon, 10 Jul 2023 22:32:02 +1000
Message-Id: <20230710123205.2441106-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We're now ready to update the multi-letter extensions status for KVM.

kvm_riscv_update_cpu_cfg_isa_ext() is called called during vcpu creation
time to verify which user options changes host defaults (via the 'user_set'
flag) and tries to write them back to KVM.

Failure to commit a change to KVM is only ignored in case KVM doesn't
know about the extension (-EINVAL error code) and the user wanted to
disable the given extension. Otherwise we're going to abort the boot
process.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230706101738.460804-19-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index bd86d8748e..4d7476cf15 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -273,6 +273,32 @@ static void kvm_cpu_set_multi_ext_cfg(Object *obj, Visitor *v,
     kvm_cpu_cfg_set(cpu, multi_ext_cfg, value);
 }
 
+static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
+{
+    CPURISCVState *env = &cpu->env;
+    uint64_t id, reg;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
+        KVMCPUConfig *multi_ext_cfg = &kvm_multi_ext_cfgs[i];
+
+        if (!multi_ext_cfg->user_set) {
+            continue;
+        }
+
+        id = kvm_riscv_reg_id(env, KVM_REG_RISCV_ISA_EXT,
+                              multi_ext_cfg->kvm_reg_id);
+        reg = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
+        ret = kvm_set_one_reg(cs, id, &reg);
+        if (ret != 0) {
+            error_report("Unable to %s extension %s in KVM, error %d",
+                         reg ? "enable" : "disable",
+                         multi_ext_cfg->name, ret);
+            exit(EXIT_FAILURE);
+        }
+    }
+}
+
 static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
     int i;
@@ -792,6 +818,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     kvm_riscv_update_cpu_misa_ext(cpu, cs);
+    kvm_riscv_update_cpu_cfg_isa_ext(cpu, cs);
 
     return ret;
 }
-- 
2.40.1


