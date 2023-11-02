Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9070D7DFCA0
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 23:48:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qygRh-00078G-P4; Thu, 02 Nov 2023 18:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygRU-0006bN-2P
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:45:36 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygRS-0003Tf-IK
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:45:35 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5ac376d311aso17627267b3.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 15:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698965132; x=1699569932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iq09wEBnj5MBxK2jShJBW1wyja+6rjSspWegzP5u65c=;
 b=exYJPyVFieDusHjNuUtazzdUa8GfiyKMHCo3R9m1Mfy21TbMHqm009sCkkM5Oz8PZn
 08CDW3PkF+Z5Z8o9/OWRKNjwblyvpBxyre7CEOTdyau1DfjtoEnj9ERXJJJUugyMUEmr
 oge079bbzXgQAm+igD5vA0AJgt51dGtXZH96CQRVzMwnxZdvR7oVUEYIRriSurmG7S6S
 hXn3YiyxGnQWAJGyqiA90Zqihc8+QQNu7mxvtVOEJMIcWS1Eie5wCWIICZlICcK5kkhu
 8U92FZ+ImlhshpYOqRPIo7jF6IqhmOrIV7xN8T0YE91EjIoDaxqJCM1CIdLPtQp90q9e
 geJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965132; x=1699569932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iq09wEBnj5MBxK2jShJBW1wyja+6rjSspWegzP5u65c=;
 b=t84GxyVYcGgq7y+cdp6dmTRSf7Es85U1RjOJmb5SDtOn0+jzQwf9KHKWZGZAz1Jl1V
 h1WWmjnmWwARLnvQF/wwHQSsUgLeM3poNtJExKiv2yOf1BnQqB3nBvll7jL35CTLAdN7
 kJxyj5Z2iAgQ0ZJ9avW8gc3fa7FOsqQORArhzDQz40AqNFrs3aQbnDB/1IGqdjZZKox0
 O4uEUEC8KpszNWJqklDIWcrRaa91UJFKhLj4z18ooCuMwza+SxxHeJDhDpUkJ6IbrdPg
 62Z8iz1uc0mLWuDA2xRe5GWyDnHl/jNYVDoyUQu5qxR2V4uyEMU9DIbD7b2sYoUoHobA
 DiCA==
X-Gm-Message-State: AOJu0YyI4g/3o3EzZOP1CcAhil+zz2mgkovFwLYiDm8jNa+PfUY6kjxL
 e1vvo9yrSOa38se9tcsM+0ZOjthtHjI5SYy5muo=
X-Google-Smtp-Source: AGHT+IHgY640pJLqsK5AF+Sc9Gp2Hri4+44h+ICBZE1LV5+xlR7OCAf959fNUnKGZsBJfEtGH9P4eA==
X-Received: by 2002:a0d:eb8b:0:b0:5a7:e3f9:a1fb with SMTP id
 u133-20020a0deb8b000000b005a7e3f9a1fbmr1267899ywe.42.1698965131837; 
 Thu, 02 Nov 2023 15:45:31 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 ce10-20020a05690c098a00b0059b24bd4f2asm259523ywb.57.2023.11.02.15.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 15:45:31 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 16/19] target/riscv/tcg: validate profiles during finalize
Date: Thu,  2 Nov 2023 19:44:42 -0300
Message-ID: <20231102224445.527355-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102224445.527355-1-dbarboza@ventanamicro.com>
References: <20231102224445.527355-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1129.google.com
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

Enabling a profile and then disabling some of its mandatory extensions
is a valid use. It can be useful for debugging and testing. But the
common expected use of enabling a profile is to enable all its mandatory
extensions.

Add an user warning when mandatory extensions from an enabled profile
are disabled in the command line. We're also going to disable the
profile flag in this case since the profile must include all the
mandatory extensions. This flag can be exposed by QMP to indicate the
actual profile state after the CPU is realized.

After this patch, this will throw warnings:

-cpu rv64,rva22u64=true,zihintpause=false,zicbom=false,zicboz=false

qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zihintpause
qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zicbom
qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zicboz

Note that the following will NOT throw warnings because the profile is
being enabled last, hence all its mandatory extensions will be enabled:

-cpu rv64,zihintpause=false,zicbom=false,zicboz=false,rva22u64=true

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 0ac94fa142..ef43264cb3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -147,6 +147,26 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
     g_assert_not_reached();
 }
 
+static const char *cpu_cfg_ext_get_name(uint32_t ext_offset)
+{
+    const RISCVCPUMultiExtConfig *feat;
+    const RISCVIsaExtData *edata;
+
+    for (edata = isa_edata_arr; edata->name != NULL; edata++) {
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
 static bool cpu_cfg_offset_is_named_feat(uint32_t ext_offset)
 {
     const RISCVCPUMultiExtConfig *feat;
@@ -706,6 +726,54 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     riscv_cpu_disable_priv_spec_isa_exts(cpu);
 }
 
+static void riscv_cpu_validate_profile(RISCVCPU *cpu,
+                                       RISCVCPUProfile *profile)
+{
+    const char *warn_msg = "Profile %s mandates disabled extension %s";
+    bool send_warn = profile->user_set && profile->enabled;
+    bool profile_impl = true;
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
+            profile_impl = false;
+
+            if (send_warn) {
+                warn_report(warn_msg, profile->name,
+                            riscv_get_misa_ext_name(bit));
+            }
+        }
+    }
+
+    for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
+        int ext_offset = profile->ext_offsets[i];
+
+        if (!isa_ext_is_enabled(cpu, ext_offset)) {
+            profile_impl = false;
+
+            if (send_warn) {
+                warn_report(warn_msg, profile->name,
+                            cpu_cfg_ext_get_name(ext_offset));
+            }
+        }
+    }
+
+    profile->enabled = profile_impl;
+}
+
+static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
+{
+    for (int i = 0; riscv_profiles[i] != NULL; i++) {
+        riscv_cpu_validate_profile(cpu, riscv_profiles[i]);
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -724,6 +792,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 
     riscv_cpu_validate_named_features(cpu);
+    riscv_cpu_validate_profiles(cpu);
 
     if (cpu->cfg.ext_smepmp && !cpu->cfg.pmp) {
         /*
-- 
2.41.0


