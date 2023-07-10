Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE774D5BB
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:37:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq6S-00061P-PP; Mon, 10 Jul 2023 08:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6K-0005fM-B4
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:49 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6I-00050T-By
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:48 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b708b97418so3985932a34.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992485; x=1691584485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXre6ILPTx/jK2JatYfDIRe0LkHnUCs7bJutQe+dofo=;
 b=KNJ0LbsiGw2gFPNJAI3cr4FlJDwtaSj03cHm6Bsq+M0Fxhqbk6s2mTlDpDT2tY62Yo
 EGoJlZzjMrdqbOB8W4PjU4Jatv6omILyHrh5bungWyMhLSBX3XOr+GN98IyR9E22OjB2
 iu/nDuBUGHgfM6ZFQiiPsf+UIe7ManucbahfcwIGNWZJmHq/lEZTTloYti2DHUK86Dgs
 tD7amlgZtu2uaCimL5mRhaSlbWVTi+GyqFnbfmylSJngDl9NQmjRvdXkGMZXBMsd8RcC
 5LBmIn+C7e2q+meV86QZ4NNk5pioX+svpmZ01j9n/wDvrp/2d3IXO96gPDx5qnR+zyuc
 HXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992485; x=1691584485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXre6ILPTx/jK2JatYfDIRe0LkHnUCs7bJutQe+dofo=;
 b=eovt7v1if4Ioor8OouRoHpTsarPRU4gon4kT5o5a+oPdGN01+bjcFJ8WstekW2W3cB
 f9OG9O00E1zom9dqUA3N6dMChdBNtwTsOhhduFglzu7evcUEiylmNJKhCPbB5jHO/Jkd
 GeVN+8Cy3uyr1hliJ0RQCVsJhHtJjM7pPkEEDjKSTLdTnh5PN8cY6HGefAHEg3omTkkg
 EHBAYVHx9bkWFDwtJQaMd2w20fyyQF5rBMorK1pvMpOVuZw1Zn35RKaCHqnvj34aSjmk
 bIg2oCEAogjjklDqSEgU9LYrkbyBxMYCJG4bV2uBN2bQE5RjEeQtYSKWGy8eji2uP889
 B+/w==
X-Gm-Message-State: ABy/qLYgVYQMdqRUtjpOuBE1oiV3U20wj1QrUC4gxfkqeiyDgh6CTmk8
 wtWMfyCAxqG3aqqGWYS0Zs5YxWL9DUwLnw==
X-Google-Smtp-Source: APBJJlE5gTxWBl57KHgrF0KFgIG3x9oAD58VWdCAUC4SzPxweHTfuXlq+kzl3brlrK+E02BMJGiECA==
X-Received: by 2002:a05:6870:82a0:b0:1b0:3e84:1dc5 with SMTP id
 q32-20020a05687082a000b001b03e841dc5mr13153017oae.54.1688992484963; 
 Mon, 10 Jul 2023 05:34:44 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:44 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 42/54] target/riscv: handle mvendorid/marchid/mimpid for KVM
 CPUs
Date: Mon, 10 Jul 2023 22:31:53 +1000
Message-Id: <20230710123205.2441106-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x329.google.com
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

After changing user validation for mvendorid/marchid/mimpid to guarantee
that the value is validated on user input time, coupled with the work in
fetching KVM default values for them by using a scratch CPU, we're
certain that the values in cpu->cfg.(mvendorid|marchid|mimpid) are
already good to be written back to KVM.

There's no need to write the values back for 'host' type CPUs since the
values can't be changed, so let's do that just for generic CPUs.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230706101738.460804-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index d8c1423b54..f264286d51 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -495,6 +495,33 @@ void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
 
+static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
+{
+    CPURISCVState *env = &cpu->env;
+    uint64_t id;
+    int ret;
+
+    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                          KVM_REG_RISCV_CONFIG_REG(mvendorid));
+    ret = kvm_set_one_reg(cs, id, &cpu->cfg.mvendorid);
+    if (ret != 0) {
+        return ret;
+    }
+
+    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                          KVM_REG_RISCV_CONFIG_REG(marchid));
+    ret = kvm_set_one_reg(cs, id, &cpu->cfg.marchid);
+    if (ret != 0) {
+        return ret;
+    }
+
+    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                          KVM_REG_RISCV_CONFIG_REG(mimpid));
+    ret = kvm_set_one_reg(cs, id, &cpu->cfg.mimpid);
+
+    return ret;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret = 0;
@@ -513,6 +540,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
     env->misa_ext = isa;
 
+    if (!object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
+        ret = kvm_vcpu_set_machine_ids(cpu, cs);
+    }
+
     return ret;
 }
 
-- 
2.40.1


