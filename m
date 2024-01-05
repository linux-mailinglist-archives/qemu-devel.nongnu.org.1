Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB96825D08
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 00:09:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLtGk-0002N0-Gv; Fri, 05 Jan 2024 18:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGi-0002Mn-Mw
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:24 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGg-0002K7-Ul
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:24 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9af1f12d5so91054b3a.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 15:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704495981; x=1705100781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pGr1EP+fEyoZUHeQ+u4fiRTSDtlxW5h+22J/QBOhfY=;
 b=knwU896XvSd90WJRKZE0v6YzV5sV37SAdlwLXMqNZQiMS0+kpds8QJcYFZYfKsLMPY
 1dQoR1cMi9HDgxi37lTgP5e15FCCfF8n+OOzuIPwKuhT90xAozfbvkJp2bYdfc3agLul
 VDYsAzoXdErNw0RAUlEmsXgNYiYyIvo8MR8omcc1rIhbvCYRUHjXszfSgDXeRdj5rzLA
 q6uoB/MxQHDRf37ZESPhIoM9NyHCaM8JoGGshzOEYMWqTnJDMs2dNWGwj2wKE4+PodCZ
 sxNObDEi4qsmxX/VJjYEMzbAlmFWj5y2OH25RB2Gv1DnzbNyXzhYXPDlzvuqtiOq/2eS
 w0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704495981; x=1705100781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pGr1EP+fEyoZUHeQ+u4fiRTSDtlxW5h+22J/QBOhfY=;
 b=tE6Ocg6uGv0hkywmdk5DTqb2lZyPIOMaycrCTAldWVEgdQDxWjI02CL+ykcT2AL2TC
 dKaPn9v1MGqCoKvspRAVOL9xphtfOrvubEVm63qYNHxs7xUCI3nCmQpecplijAYg8i19
 bn8M4WRuCi0H6F7UhTFQ55G6xI2ZnNsai/sLdkWhqB9SG9UYXypRr0fKAaf75fSlKHQ+
 b7YPAy4V8kpz4le4dbD+B/VjErjLQpCQHsT2fzMCasz60O2FiOIz8TpzciV3hCyVDB9a
 o3bpG7L9FCzqy9YKgB/eOm56ME5rGoMFrS/oamD+o/fy/qAOQrBy9pfteJShP3DZOs7H
 9lcQ==
X-Gm-Message-State: AOJu0Ywdz75QqC8Xdy0oh6Q5ADvVcrpXngoqQYaVNC/x/SU3k00JalfO
 Snin8I5Dy7RDJC2G4ierZglIDxm061YL5DihHz/VxDU9SyU3Gg==
X-Google-Smtp-Source: AGHT+IE4Bq5qliJgxUQwK2VKh4prjPoJiDKRSCcZi8s2vBqlts5fc1HwS4qP8Qasy39Ffjksfklvzg==
X-Received: by 2002:a05:6a00:1885:b0:6da:e246:5c2 with SMTP id
 x5-20020a056a00188500b006dae24605c2mr14420pfh.55.1704495981109; 
 Fri, 05 Jan 2024 15:06:21 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.127.254])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006dacfab07b6sm1849249pfd.121.2024.01.05.15.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 15:06:20 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 09/17] target/riscv: move 'elen' to riscv_cpu_properties[]
Date: Fri,  5 Jan 2024 20:05:38 -0300
Message-ID: <20240105230546.265053-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105230546.265053-1-dbarboza@ventanamicro.com>
References: <20240105230546.265053-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
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

Do the same thing we did with 'vlen' in the previous patch with 'elen'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 44 ++++++++++++++++++++++++++++++++++++--
 target/riscv/tcg/tcg-cpu.c |  5 -----
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fd55064c3b..2bb4828324 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1309,6 +1309,7 @@ static void riscv_cpu_init(Object *obj)
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
     cpu->cfg.vlen = 128;
+    cpu->cfg.elen = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1819,9 +1820,47 @@ static const PropertyInfo prop_vlen = {
     .set = prop_vlen_set,
 };
 
-Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
+static void prop_elen_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!is_power_of_2(value)) {
+        error_setg(errp, "Vector extension ELEN must be power of 2");
+        return;
+    }
+
+    if (value != cpu->cfg.elen && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.elen);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.elen = value;
+}
 
+static void prop_elen_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.elen;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_elen = {
+    .name = "elen",
+    .get = prop_elen_get,
+    .set = prop_elen_set,
+};
+
+Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_UINT16("cbop_blocksize", RISCVCPU, cfg.cbop_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
@@ -1909,6 +1948,7 @@ static Property riscv_cpu_properties[] = {
     {.name = "vext_spec", .info = &prop_vext_spec},
 
     {.name = "vlen", .info = &prop_vlen},
+    {.name = "elen", .info = &prop_elen},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 71a364453e..c7c2a28f10 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -305,11 +305,6 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
         return;
     }
 
-    if (!is_power_of_2(cfg->elen)) {
-        error_setg(errp, "Vector extension ELEN must be power of 2");
-        return;
-    }
-
     if (cfg->elen > 64 || cfg->elen < 8) {
         error_setg(errp,
                    "Vector extension implementation only supports ELEN "
-- 
2.43.0


