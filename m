Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAC474900B
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 23:43:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAF7-0005Hp-6o; Wed, 05 Jul 2023 17:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAEw-00052z-Nf
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:40:47 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAEu-0001mx-U2
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:40:46 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5636426c1b3so4911056eaf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688593243; x=1691185243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LaoXRj5GeVqv8FWfywQJXC4kH9xEnXXPplACV+RhCw=;
 b=IQx4w13WTi1mcaV7Rgud0kv26cskrP58p2HAFvFT4KSg/vKt27MLJ7+MT2G+ETfVTq
 96g/Nxb+OqRdLIWHOvNN7eotk3R4CEtk32liNOwzbQC3DcpteYoYCEyiOlRL2mQPJzHt
 LqHIiBTr9SStiA25PDq85Jzb0hZVArhMXdn/eafK0ryCxVQdJdK7ZkXA/CsuoA6V7Vjb
 /gi0Bvc06IkUjkc7B4ZSFi6r3SIfg0lt3t9QtfC6R8TvSt/GUv5i7vgzjUstZCHADOOW
 0PRKfPtf7zxRzkC7E+7O7lDnogfk/K4WCYYc3E05fkTfWYJnIsj6I36Kpsn6oFqlijbf
 ePcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688593243; x=1691185243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LaoXRj5GeVqv8FWfywQJXC4kH9xEnXXPplACV+RhCw=;
 b=Bi4Y7jm+d9TMyHRkVdRRpTBgG+N1fSs90xXEUCB92+ykyBf+MRQ9rMDwbfxIoYpAJT
 ZFSJoQ87usy9Ml3kGJ7g9lWJ81/ecxXNXuy8ASu72TpvuQkWxbxQLBAJ3CBjnBejBBTY
 PINElKmAnGhBDf+pC8K24XymgkGaKmDEpNYpb60ElUPc60IvXJqmohpZKqZFhj4fXqn6
 261o1NrAfTnPZ3QOwJVT2VAK3XW9smau0Ol8DYfSjhhvexHYEjFdNOR9dAtMmIbk6SRg
 qknratWLt3eZisSh0jS2QOP5PSR0pThYGRnuxUOw8fDSht2xvpPCs/vZ+X4ILFUxYYVr
 nd0A==
X-Gm-Message-State: ABy/qLYrHmRjls9TY2+bJiDl2VRrSWY7nw8Lp7iMXLzRPjReOgpfNkg0
 90CsBxbw3iykPIk0p4EVnQbL277sQe5qVaiEUI8=
X-Google-Smtp-Source: APBJJlH8cMNQxNN1CwktVPxsf2SErsuBqd0cwKKHr8YqJIBYW94/DIsE+er16w2bRmDDRwrbRVDtSQ==
X-Received: by 2002:a4a:e83c:0:b0:563:60b4:db82 with SMTP id
 d28-20020a4ae83c000000b0056360b4db82mr57203ood.2.1688593243496; 
 Wed, 05 Jul 2023 14:40:43 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a4add01000000b0056665a16536sm70764oou.30.2023.07.05.14.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 14:40:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 13/20] target/riscv/kvm.c: update KVM MISA bits
Date: Wed,  5 Jul 2023 18:39:48 -0300
Message-ID: <20230705213955.429895-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705213955.429895-1-dbarboza@ventanamicro.com>
References: <20230705213955.429895-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc33.google.com
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

Our design philosophy with KVM properties can be resumed in two main
decisions based on KVM interface availability and what the user wants to
do:

- if the user disables an extension that the host KVM module doesn't
know about (i.e. it doesn't implement the kvm_get_one_reg() interface),
keep booting the CPU. This will avoid users having to deal with issues
with older KVM versions while disabling features they don't care;

- for any other case we're going to error out immediately. If the user
wants to enable a feature that KVM doesn't know about this a problem that
is worth aborting - the user must know that the feature wasn't enabled
in the hart. Likewise, if KVM knows about the extension, the user wants
to enable/disable it, and we fail to do it so, that's also a problem we
can't shrug it off.

In the case of MISA bits we won't even try enabling bits that aren't
already available in the host. The ioctl() is so likely to fail that
it's not worth trying. This check is already done in the previous patch,
in kvm_cpu_set_misa_ext_cfg(), thus we don't need to worry about it now.

In kvm_riscv_update_cpu_misa_ext() we'll go through every potential user
option and do as follows:

- if the user didn't set the property or set to the same value of the
host, do nothing;

- Disable the given extension in KVM. Error out if anything goes wrong.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index c55d0ec7ab..7afd6024e6 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -162,6 +162,41 @@ static void kvm_cpu_set_misa_ext_cfg(Object *obj, Visitor *v,
                "enabled in the host", misa_ext_cfg->name);
 }
 
+static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
+{
+    CPURISCVState *env = &cpu->env;
+    uint64_t id, reg;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_misa_ext_cfgs); i++) {
+        KVMCPUConfig *misa_cfg = &kvm_misa_ext_cfgs[i];
+        target_ulong misa_bit = misa_cfg->offset;
+
+        if (!misa_cfg->user_set) {
+            continue;
+        }
+
+        /* If we're here we're going to disable the MISA bit */
+        reg = 0;
+        id = kvm_riscv_reg_id(env, KVM_REG_RISCV_ISA_EXT,
+                              misa_cfg->kvm_reg_id);
+        ret = kvm_set_one_reg(cs, id, &reg);
+        if (ret != 0) {
+            /*
+             * We're not checking for -EINVAL because if the bit is about
+             * to be disabled, it means that it was already enabled by
+             * KVM. We determined that by fetching the 'isa' register
+             * during init() time. Any error at this point is worth
+             * aborting.
+             */
+            error_report("Unable to set KVM reg %s, error %d",
+                         misa_cfg->name, ret);
+            exit(EXIT_FAILURE);
+        }
+        env->misa_ext &= ~misa_bit;
+    }
+}
+
 static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
     int i;
@@ -632,8 +667,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     if (!object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
         ret = kvm_vcpu_set_machine_ids(cpu, cs);
+        if (ret != 0) {
+            return ret;
+        }
     }
 
+    kvm_riscv_update_cpu_misa_ext(cpu, cs);
+
     return ret;
 }
 
-- 
2.41.0


