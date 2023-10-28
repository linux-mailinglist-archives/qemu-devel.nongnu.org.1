Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E19A97DA60A
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 10:57:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwf6A-0000wO-Qt; Sat, 28 Oct 2023 04:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf68-0000oA-SF
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:55:12 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf65-0004NL-Vu
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:55:11 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5af6c445e9eso16192137b3.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698483308; x=1699088108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfHSJgiPT4gXrrmHkN7q2LvOanzGuSOKc+PaMjOaSwQ=;
 b=Xaq9sb4czebewoy0Argywf7pT1zzxWSKpQmmFVNzz4u6VtRJqwzXhj2nkJJCtDsgpE
 bo9JLlw25Ix8M5VWWoGrmXmuhBzdQ7V/huSCGanYhEB2aisMKkY04EGnHSZZt4rCr5fC
 K6OM7E3ry4y+5LjAHP5xWeMHW4W11bkAvt5O+e8QzoqKrDnBcnR7RTZB5y5auYoz0QNq
 5cEX6eIYk5Iy1YWjwnOcvLdRdGI7c2E+Sot+rHJjxuLwI4fEY8FROyUJGMA4hBXJi98E
 GOyCyqztQw8CorZDjOnayvkxpW9mWqxKpBsTuaYlqGiq/7OEu9r89bKo93H4EIS4zXuB
 UQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698483308; x=1699088108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfHSJgiPT4gXrrmHkN7q2LvOanzGuSOKc+PaMjOaSwQ=;
 b=IrmmJwhooEngUAPrxXyz47AtL/+RTZRMzvWjw+JuB+6PD1HKwe+my/g4mtdblZswHu
 jvmJqr9KuNH4U2tucTkTPuSZROPXJxrpiM3CRZLiBnWXe8ijZVnxDlrucH7t5a6O3K9T
 c/QG56370m0vJ0dej3u21qiLxO/YZaUlDIUedrtUC2ApgAL+U+Jfcl6TmbgDzP+pf0Ty
 fkS6nn61t25dvE0iajKOwcjBKqDCLyPO0GioEwL5poPMATaGH1DVZ+A809fTn2eBLpI9
 pZXR4OwlR1wFosUm6Tm0rLmnhUlvcSjVAy2FcPHcFPLSJPRbboKoa/ytfyS7x0A+QWS8
 9bHg==
X-Gm-Message-State: AOJu0YxWtIzz7C6C65WHV8VYHJc20ExpfsfvAl2kZiSkvj/rl7/MlvwV
 cyXWMZqjo+82w/xeVPG+xedC7xh+K6+qyOqhqco=
X-Google-Smtp-Source: AGHT+IEkCXQA5kHfgdLqOLnVc768k3V4Vd3iXz74W+nONw73UHQSZEya8ube2mBjJc4Mo2ta0VCLnQ==
X-Received: by 2002:a81:764b:0:b0:5a8:204c:5c9b with SMTP id
 j11-20020a81764b000000b005a8204c5c9bmr4517398ywk.18.1698483308371; 
 Sat, 28 Oct 2023 01:55:08 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.255.2.33])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a81830f000000b00594fff48796sm1604325ywf.75.2023.10.28.01.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 01:55:08 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 12/12] target/riscv/tcg: warn if profile exts are disabled
Date: Sat, 28 Oct 2023 05:54:27 -0300
Message-ID: <20231028085427.707060-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231028085427.707060-1-dbarboza@ventanamicro.com>
References: <20231028085427.707060-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Enabling a profile and then disabling some of its mandatory extensions
is a valid use. It can be useful for debugging and testing. But the
common expected use of enabling a profile is to enable all its mandatory
extensions.

Add an user warning when mandatory extensions from an enabled profile
are disabled in the command line, like we're already doing with RVG.

After this patch, this will throw warnings:

-cpu rv64,rva22u64=true,zihintpause=false,zicbom=false,zicboz=false

qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zihintpause
qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zicbom
qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zicboz

Note that the following  will NOT throw warnings because the profile is
being enabled last, hence all its mandatory extensions will be enabled:

-cpu rv64,zihintpause=false,zicbom=false,zicboz=false,rva22u64=true

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 61 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 953e8432d6..5e7855b41b 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -147,6 +147,27 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
     g_assert_not_reached();
 }
 
+static const char *cpu_cfg_ext_get_name(uint32_t ext_offset)
+{
+    const RISCVCPUMultiExtConfig *feat;
+    const RISCVIsaExtData *edata;
+
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->ext_enable_offset == ext_offset) {
+            return edata->name;
+        }
+    }
+
+    for (feat = riscv_cpu_named_features; feat->name != NULL; feat++) {
+        if (feat->offset == ext_offset) {
+            return feat->name;
+        }
+    }
+
+    g_assert_not_reached();
+}
+
+
 static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
                                     bool value)
 {
@@ -631,6 +652,45 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     riscv_cpu_disable_priv_spec_isa_exts(cpu);
 }
 
+static void riscv_cpu_validate_profile(RISCVCPU *cpu,
+                                       RISCVCPUProfile *profile)
+{
+    const char *warn_msg = "Profile %s mandates disabled extension %s";
+    int i;
+
+    for (i = 0; misa_bits[i] != 0; i++) {
+        uint32_t bit = misa_bits[i];
+
+        if (!(profile->misa_ext & bit)) {
+            continue;
+        }
+
+        if (!riscv_has_ext(&cpu->env, bit)) {
+            warn_report(warn_msg, profile->name, riscv_get_misa_ext_name(bit));
+        }
+    }
+
+    for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
+        int ext_offset = profile->ext_offsets[i];
+
+        if (!isa_ext_is_enabled(cpu, ext_offset)) {
+            warn_report(warn_msg, profile->name,
+                        cpu_cfg_ext_get_name(ext_offset));
+        }
+    }
+}
+
+static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
+{
+    for (int i = 0; riscv_profiles[i] != NULL; i++) {
+        RISCVCPUProfile *profile = riscv_profiles[i];
+
+        if (profile->user_set && profile->enabled) {
+            riscv_cpu_validate_profile(cpu, profile);
+        }
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -649,6 +709,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 
     riscv_cpu_validate_named_features(cpu);
+    riscv_cpu_validate_profiles(cpu);
 
     if (cpu->cfg.ext_smepmp && !cpu->cfg.pmp) {
         /*
-- 
2.41.0


