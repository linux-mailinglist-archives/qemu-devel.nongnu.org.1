Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5917CE851
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtCfD-0003sO-I6; Wed, 18 Oct 2023 15:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtCf9-0003s7-GG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:57:03 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtCf7-0001dM-Ro
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:57:03 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5ab94fc098cso3326134a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 12:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697659020; x=1698263820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goSM+plzgjI6cpvIrsL3gQcrpcnNxW3GYfnrMcJsUz0=;
 b=kAg7HUqGptswJakkLSOw7stXt1AfH7BhYT2E1PsUZjxlQkhv4Ic1Hv20aURQBng2vb
 dTogTkl2HMMedleLXKwXte2JYyHVzSGdBbIdonTNW4oDyjwzbMgrcyUwxXTAnCEagYMe
 xfAVbSwOqn9G7cc0kxZbevydqKO/tY+MHzfM7a+/T4xJTk5BT5f3mZqrgKvlmqzGTyaF
 /6gt7+rg0dClnw1guQSoThvkbTD09BiEdU6mZurHZInNPl4rflIyR335gUlgIfOf/Yuv
 5ssMvcu1bs7fJyh+7EqHRAzVaEBUn2IeI/PAuR+1bchNi1n6w1Tgj8cDxbNuLosTiRja
 PsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697659020; x=1698263820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goSM+plzgjI6cpvIrsL3gQcrpcnNxW3GYfnrMcJsUz0=;
 b=GjZXB0QOJz6ylRFh8OzzCpbI/tVKuXWUqjUOPJKhvDn20S59Cu02Kycp507O/5R2LU
 N5KzU4zE1G8nHK1mrvIvDO7fsR27h1sPs/nfC8r7TZ4lhOy+Mvxdija7Sva2fj6KctLu
 SQ3MNR/LufYNSAcgxuPs965GfckMnN3mNHnLCSV/lIdjnGqVg0hiCW7b3xMEfO9GTRg1
 7iFIxEsdJolMjWSQyAfhDiD3aG9cIUtAyU9mwjztv5gJYwc+61ikpOGBGeFekIq7RsqT
 sDYQK2X522VPJRI5wMixjtiPwi1lzvg4wo9QAxkL8LFHm2R1F1VwpsZrgyf7n0SNq8oL
 qIWQ==
X-Gm-Message-State: AOJu0YxenrPNLNYoJNbRlj0SOHiRKoPloSzBQH1+ddkwSSZxwl8jeWvp
 UrbH5qwLai+xsaAuh6xa67mIK/AaAynqmf92RHw=
X-Google-Smtp-Source: AGHT+IFyfYRuzTlB8SSBkUB1B/AROG625A/LjDrNNGdzsFVvTnjqr7m/6nrykted8jylI0O8QiUM+Q==
X-Received: by 2002:a17:90a:5886:b0:27c:ed8e:1840 with SMTP id
 j6-20020a17090a588600b0027ced8e1840mr198371pji.10.1697659020159; 
 Wed, 18 Oct 2023 12:57:00 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.45.186.249])
 by smtp.gmail.com with ESMTPSA id
 ku12-20020a17090b218c00b00268b439a0cbsm256359pjb.23.2023.10.18.12.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 12:56:59 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 5/6] target/riscv: add riscv_cpu_accelerator_compatible()
Date: Wed, 18 Oct 2023 16:56:37 -0300
Message-ID: <20231018195638.211151-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018195638.211151-1-dbarboza@ventanamicro.com>
References: <20231018195638.211151-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52e.google.com
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

Add an API to check if a given CPU is compatible with the current
accelerator.

This will allow query-cpu-model-expansion to work properly in conditions
where QEMU supports both accelerators (TCG and KVM), QEMU is then
launched using TCG, and the API requests information about a KVM only
CPU (e.g. 'host' CPU).

KVM doesn't have such restrictions and, at least in theory, all CPUs
models should work with KVM. We will revisit this API in case we decide
to restrict the amount of KVM CPUs we support.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 9 +++++++++
 target/riscv/cpu.h         | 1 +
 target/riscv/tcg/tcg-cpu.c | 7 ++++++-
 target/riscv/tcg/tcg-cpu.h | 1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 02db0834dd..8e0abe33d3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1063,6 +1063,15 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
+bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu)
+{
+    if (tcg_enabled()) {
+        return riscv_cpu_tcg_compatible(cpu);
+    }
+
+    return true;
+}
+
 #ifndef CONFIG_USER_ONLY
 static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c9ec59d82..8efc4d83ec 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -758,6 +758,7 @@ char *riscv_cpu_get_name(RISCVCPU *cpu);
 
 void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
+bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 21a46f2a0e..6771617226 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -581,6 +581,11 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 }
 
+bool riscv_cpu_tcg_compatible(RISCVCPU *cpu)
+{
+    return object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST) == NULL;
+}
+
 static bool riscv_cpu_is_generic(Object *cpu_obj)
 {
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
@@ -598,7 +603,7 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
     RISCVCPU *cpu = RISCV_CPU(cs);
     Error *local_err = NULL;
 
-    if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
+    if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
         error_setg(errp, "'%s' CPU is not compatible with TCG acceleration",
                    name);
diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
index aa00fbc253..f7b32417f8 100644
--- a/target/riscv/tcg/tcg-cpu.h
+++ b/target/riscv/tcg/tcg-cpu.h
@@ -24,5 +24,6 @@
 
 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
+bool riscv_cpu_tcg_compatible(RISCVCPU *cpu);
 
 #endif
-- 
2.41.0


