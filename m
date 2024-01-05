Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C36BE825CFD
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 00:07:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLtGV-0002GO-9A; Fri, 05 Jan 2024 18:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGS-0002Fv-ME
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:08 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGQ-0002HL-Tm
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:08 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-593f7a1afd7so44692eaf.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 15:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704495965; x=1705100765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4+KptxtKdGjf6dcMaa6D2vbjQcQk7yb8PDgP9Jrtew=;
 b=HB33roeoIuqgxoxtql7S5A2NFDriOTdyxaTE3PhY9+PmZHEccGbsidbx43eBBRsQyr
 pkmGbx5eEk4sNdDdA888N3RxFmQDNVhvfEh7i3HBTwmtQsXqYjeJd54QKV7RpYjvwVN1
 0BJ/9hCcdGNIG/7Io9vsWTp3hPcNJLCIpL9ydQ2UIEdjn6NptKXx6hsiy8M6neUpNrMI
 6eT3H6kMLJs931TSosik8traBz3c9EOo1aQ0YUUktPRUsK/+R2fb+7s1gKDvbZSmJRJc
 DS8kDAPOjpT4jdTvZpskDPFrYrjlvzQ0ZdtzYTTD+FMugUHIlZkUK3aTT03HsLiDQ+U+
 6jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704495965; x=1705100765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4+KptxtKdGjf6dcMaa6D2vbjQcQk7yb8PDgP9Jrtew=;
 b=M6vllO/jec7UNHXJbFbQZP+S//Fv1xoH4ZIw0J320tHvqB5ON7Q7NCLARyPTDtiFcn
 42IwFprt7Bx+zs+KiFLubON78CVCdGOqO3mcX6nHa+NpES+oXQk/Myl2CeCnxHW8DM8m
 CKwBJQEq4wYD2DPV4kcUQ7HftfxkepkHmGEfYRLUjm/CgbjR5Z6x2jWj69XtQ65m6quD
 EIhNIIwqmRVqwehVqmWi/4UZCZxMpL3aiacoJ3UKg7j9ePpWj1Av2Faa9kF4cIX3MSlJ
 6RSYRJmQdAAwE3uaHHSVkNLJ6xgBfg1mbyg5k4PMOnl4aUloImimZQVbuXrFyzbrTpcL
 uvyQ==
X-Gm-Message-State: AOJu0Yw6+Pw0ejKETYgQeTL6oHci5RrVXX0A4UIQ7QoUtXziNvg5YUpl
 aSJzBjXgx7b8A8kWsppvuSbDetQy3u6gacUJTn1D4WOlL9VooQ==
X-Google-Smtp-Source: AGHT+IFzFi7ZpeNFFwgeMDSBFJeXeHNkQ9C4uf5cml+/4BCKSn6piWAFC5rN+dP+LXZZzpGGU7yaKg==
X-Received: by 2002:a05:6358:3388:b0:174:fce5:6b87 with SMTP id
 i8-20020a056358338800b00174fce56b87mr334412rwd.23.1704495965441; 
 Fri, 05 Jan 2024 15:06:05 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.127.254])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006dacfab07b6sm1849249pfd.121.2024.01.05.15.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 15:06:05 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 04/17] target/riscv: move 'mmu' to riscv_cpu_properties[]
Date: Fri,  5 Jan 2024 20:05:33 -0300
Message-ID: <20240105230546.265053-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105230546.265053-1-dbarboza@ventanamicro.com>
References: <20240105230546.265053-1-dbarboza@ventanamicro.com>
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

Commit 7f0bdfb5bfc ("target/riscv/cpu.c: remove cfg setup from
riscv_cpu_init()") already did some of the work by making some
cpu_init() functions to explictly enable their own 'mmu' default.

The generic CPUs didn't get update by that commit, so they are still
relying on the defaults set by the 'mmu' option. But having 'mmu' and
'pmp' being default=true will force CPUs that doesn't implement these
options to set them to 'false' in their cpu_init(), which isn't ideal.

We'll move 'mmu' to riscv_cpu_properties[] without any defaults, i.e.
the default will be 'false'. Compensate it by manually setting 'mmu =
true' to the generic CPUs that requires it.

Implement a setter for it to forbid the 'mmu' setting to be changed for
vendor CPUs. This will allow the option to exist for all CPUs and, at
the same time, protect vendor CPUs from undesired changes:

$ ./build/qemu-system-riscv64 -M virt -cpu sifive-e51,mmu=true
qemu-system-riscv64: can't apply global sifive-e51-riscv-cpu.mmu=true:
   CPU 'sifive-e51' does not allow changing the value of 'mmu'

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 55 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e5885e0dfb..891a3b630b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -437,6 +437,8 @@ static void riscv_max_cpu_init(Object *obj)
     CPURISCVState *env = &cpu->env;
     RISCVMXL mlx = MXL_RV64;
 
+    cpu->cfg.mmu = true;
+
 #ifdef TARGET_RISCV32
     mlx = MXL_RV32;
 #endif
@@ -451,7 +453,11 @@ static void riscv_max_cpu_init(Object *obj)
 #if defined(TARGET_RISCV64)
 static void rv64_base_cpu_init(Object *obj)
 {
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+
+    cpu->cfg.mmu = true;
+
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV64, 0);
     /* Set latest version of privileged specification */
@@ -569,13 +575,18 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 
 static void rv128_base_cpu_init(Object *obj)
 {
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+
     if (qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_report("128-bit RISC-V currently does not work with Multi "
                      "Threaded TCG. Please use: -accel tcg,thread=single");
         exit(EXIT_FAILURE);
     }
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
+
+    cpu->cfg.mmu = true;
+
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV128, 0);
     /* Set latest version of privileged specification */
@@ -609,7 +620,11 @@ static void rv64i_bare_cpu_init(Object *obj)
 #else
 static void rv32_base_cpu_init(Object *obj)
 {
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+
+    cpu->cfg.mmu = true;
+
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV32, 0);
     /* Set latest version of privileged specification */
@@ -1594,8 +1609,38 @@ static const PropertyInfo prop_pmu_mask = {
     .set = prop_pmu_mask_set,
 };
 
+static void prop_mmu_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value;
+
+    visit_type_bool(v, name, &value, errp);
+
+    if (cpu->cfg.mmu != value && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, "mmu", errp);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.mmu = value;
+}
+
+static void prop_mmu_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    bool value = RISCV_CPU(obj)->cfg.mmu;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_mmu = {
+    .name = "mmu",
+    .get = prop_mmu_get,
+    .set = prop_mmu_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
 
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
@@ -1684,6 +1729,8 @@ static Property riscv_cpu_properties[] = {
     {.name = "pmu-mask", .info = &prop_pmu_mask},
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
 
+    {.name = "mmu", .info = &prop_mmu},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
-- 
2.43.0


