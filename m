Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6C74900A
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 23:43:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAFI-0005VS-Sc; Wed, 05 Jul 2023 17:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAFB-0005Q6-NV
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:41:01 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAFA-0001qL-1z
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:41:01 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-55e1ae72dceso4927684eaf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688593258; x=1691185258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0zOWUAl3eD+tvdE7KLOr+hD9ROUcAvfa5REw44Jn20=;
 b=GP9cydCuUy3cHmTmg4SQ1YWs4KRvyDSNVBp6aWDKBkomuugcjXhfemtI/ZgrIlqTJe
 JMduI/s+Xmn4DCxHVJTmeaCWWteAzs+Nry1E8bK7ivn4+97QVD25sFFRWciUyQYQsuhB
 zaULBadpGIUfKHrdM7JoICjLGjRQa8O6TKuJHf9kwawovq2r8UQ331/m/cCA1NkTFI5h
 N2yX7nY6UogaVXamjSCybHeDTk1RHbhTR0Vu5YbN0iHmg+Vc2Su6dpadhAoGny0eBp0q
 2gUOYOzoVj07j7G1j2JPfD6ERk/97yWqWA246ILxwfwti/LaciGlUSuSimbUBOwmBfpO
 9kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688593258; x=1691185258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0zOWUAl3eD+tvdE7KLOr+hD9ROUcAvfa5REw44Jn20=;
 b=U4RepvcZEHnOOrUMjOTjAYhoU2Q9Jxu9Nd6KN2md1rPz8QTDsmCRXyriWjFPVSjvVo
 n2yh1oaUzgG7XeQZermilb9zreF8Q2MM0ScfdL3PgHtuAvAGVKv7iJLc2dqMIdPd89sQ
 09/k47uWYp1oGQOzy8+aNz7mJRQarznhsOZZyzn+EHnmxQeVTE4XYkDPKSEJc2g3oHPN
 Q6rpEtZtLS2yJYvWoQ02dKJbOy6BpRRHAH2f7PNDmJAe7vHECQdFo3KhcMmUVe2ZxkxS
 +L5wUt/EwN1jXNJZ3SdPieRtgRu2NUQ0yEG6uBY/IJ92/FlfouI7mQqFnyMhHQlY6i3F
 uuCQ==
X-Gm-Message-State: ABy/qLalFWb+2S+HfmCZc2OmqN4NU8U7rAYbb33B7h5jIlXtWNPyHQCr
 jumyFHTwcfPV615HT5u25yq1b3mOAdaZsCT/OSM=
X-Google-Smtp-Source: APBJJlEIGyMCIjt2G+9k1AaCquCatGuM5GyznPepGT5oZHd8MHkjcRovk2ZhQUv5UGSli37+e4PnNA==
X-Received: by 2002:a4a:4514:0:b0:565:bf28:ee72 with SMTP id
 y20-20020a4a4514000000b00565bf28ee72mr73337ooa.0.1688593258628; 
 Wed, 05 Jul 2023 14:40:58 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a4add01000000b0056665a16536sm70764oou.30.2023.07.05.14.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 14:40:58 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 18/20] target/riscv: update multi-letter extension KVM
 properties
Date: Wed,  5 Jul 2023 18:39:53 -0300
Message-ID: <20230705213955.429895-19-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705213955.429895-1-dbarboza@ventanamicro.com>
References: <20230705213955.429895-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2f.google.com
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
---
 target/riscv/kvm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index f2545bd560..55ea189520 100644
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
2.41.0


