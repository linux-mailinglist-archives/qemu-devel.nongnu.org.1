Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4781743918
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFB4l-0006TR-4G; Fri, 30 Jun 2023 06:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB4h-0006FK-UY
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:10:00 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB45-0000uE-CB
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:09:22 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1b056276889so1463575fac.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688119760; x=1690711760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDHEFAfpjpK2ITOE0vYfaZ+Icp8OPeGAZfTCC09meyU=;
 b=Si+T0TWn+xY9yWboKay905Q+RxNTa+XhibKfI8UBfh251BHYw+MqkbV/NlE5s1qszJ
 EcCiXgZmNJdw3Q1F1OI9vWB5T1YucnyKkqbMkZ/oXiT9tAgNjF8mytktCnTB+MnpR9i6
 pOtEynsOxVCxYUyCH1HLoYqwRFyP8JI1f8r6js8IEXJERPT+HutwUP8KJts7Tze6s7Jp
 oYo+HhQFhLklLTOxHPILfC8TGMrVlLlXXkjVI1tWMOdpkUcuyVZ4I34NEChJhgvr1ztM
 ggzBA5uPG36vyyelI3Qnl5++XjKL8kVL4KKmwhLEdD4OA8BKNdXGAMOGbQ7QGZCpo/zz
 cxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119760; x=1690711760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HDHEFAfpjpK2ITOE0vYfaZ+Icp8OPeGAZfTCC09meyU=;
 b=djx+94BCi0hJAziTcDEiA8Dl8v2akB7tWqhOq6zIlKWvnv6ebuuqrieYUAiMtk8E7A
 +52au77QgmfaxOfb+JqMfl4nyCjdEaugNWcRuf+62DXv4jwgypsbFyoXOOvzhY9QigRH
 6tiwoWrZiFh3GoGjbNWrh7BAaQR0BbtwleHVdEOHFcK+3Si8nP5aOBFCABbPjcHYho0r
 EQwwWOz33Iy3tLOIoVZMV+zn9gw4Nam1XqJnQtwWgPRIiobwdPesHUbkpx33lQra2ca7
 CQSwjq6kJ0maqSr8o0ivJjf64WmEWo9M4eKulaf2ueQwecqRoIFo/XF2fvPg0N6ssFt7
 yLwQ==
X-Gm-Message-State: ABy/qLbQF1LDJ9CDkLXCX9qb1AFbO4mdIXV2BJ/WRWTG1IpZ/4f7dW3u
 ilSuEL7f3+AkWgKMGefQtV/tcr8okraqEnHm3i0=
X-Google-Smtp-Source: APBJJlHygNSQVjrn9G+zqIzzR8RSKr0hxBNWYv0fCQhiB94Fjre521HzCesx2oCIObcYDZINrtZU1w==
X-Received: by 2002:a05:6870:5492:b0:1b0:79c4:de15 with SMTP id
 f18-20020a056870549200b001b079c4de15mr2682720oan.27.1688119760061; 
 Fri, 30 Jun 2023 03:09:20 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 eh18-20020a056870f59200b001a663e49523sm8707467oab.36.2023.06.30.03.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 03:09:19 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 18/20] target/riscv: update multi-letter extension KVM
 properties
Date: Fri, 30 Jun 2023 07:08:09 -0300
Message-ID: <20230630100811.287315-19-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630100811.287315-1-dbarboza@ventanamicro.com>
References: <20230630100811.287315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x32.google.com
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
index 6ef81a6825..2edf0270e3 100644
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


