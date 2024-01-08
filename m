Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 485018274ED
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 17:20:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMsLZ-0003j7-2q; Mon, 08 Jan 2024 11:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rMsLP-0003hG-M9
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:19:20 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rMsLN-0007ni-TI
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:19:19 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso1331867b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 08:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704730755; x=1705335555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLPH1DIupXefRHQi91RqbfZhVZ2wL+cnWWF+4DKYFBg=;
 b=M0f4nYrDE7ToQskMr9F0xNLzMWB7IWuXwb1b0mqC1W2gG8GnjQgNJWHtYQuMPIW7xv
 9yQ9+x+fy4CPSDcC8NPCwvyfnAildg0dr8jRIbVIgCeL3Zc7KtjkD8UEf1mOc/nQ6ECX
 UOzXyAQMt3D2k6sc4KGR99dTntppoop7JAmd+a1LOjK9CCf99+ecPWIE3Ztw4aqjWQIy
 nChuGb8lAtsdvaMgY+fFNec9hvVTBYqLq9Xxr/N4AgFeFZl3Z7zRXhWvpwZBGweB6Uxb
 e44u0NapCulWdShN2Rb1sk8hofrMoSIKKjE/lp9G1qaSFHDwzaJS+rhTq5Krdyu5nDMi
 I9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704730755; x=1705335555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLPH1DIupXefRHQi91RqbfZhVZ2wL+cnWWF+4DKYFBg=;
 b=r3c26PGBCpc7SRfQZJW8Xq6cszDi9t4H7zZFWqw8o632vezGY7thDbo17ta/x0SU6Y
 NMZY/WAt5VVeLCJUlL3McWFKc83RYp16BMejCiormBpddBxI7ZnXEeI+Tbap2iWpMFBa
 ALX2RU3P28CZQU4HPpCS+KjuQWKgaPVw2gUnaSyF0AHOrUDFeym0qzrOhGj+u8diD+e9
 daX5AhuU3Nk7cw1MXrHy6jaYXv3tSnx1fFrmLohj6AQjej4DuWPPCQHsw83vHX+7xzdj
 rGuB+/a1fgOCoP3w9SU2KO5D7EUlDMmsuE8wQI765NS7EVI4+aDUGBMeYa+ko3anY3J5
 O8Qg==
X-Gm-Message-State: AOJu0YyFxZMxB7PW9ue1FjRhgeFxINhS0Z4lBj190gjQJoEBdPHWUhzz
 iP9v7iRHCjE+vvj11+aHCTkakfSaHlbCjPL0uWse9ILSBUO96w==
X-Google-Smtp-Source: AGHT+IF/okwnQXV1VVVJUw8oWx6hvawKZgi3g+jvgq+WIsZz+znbPsslVQclOQoSxdPRMU6M14qBkA==
X-Received: by 2002:a05:6a00:1d1c:b0:6da:caf9:5e4c with SMTP id
 a28-20020a056a001d1c00b006dacaf95e4cmr7960966pfx.9.1704730755420; 
 Mon, 08 Jan 2024 08:19:15 -0800 (PST)
Received: from grind.. ([189.79.22.11]) by smtp.gmail.com with ESMTPSA id
 b29-20020aa78edd000000b006db056542e6sm49151pfr.190.2024.01.08.08.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 08:19:15 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/2] target/riscv/cpu.c: add riscv_bare_cpu_init()
Date: Mon,  8 Jan 2024 13:19:02 -0300
Message-ID: <20240108161903.353648-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108161903.353648-1-dbarboza@ventanamicro.com>
References: <20240108161903.353648-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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

Next patch will add more bare CPUs. Their cpu_init() functions would be
glorified copy/pastes of rv64i_bare_cpu_init(), differing only by a
riscv_cpu_set_misa() call.

Add a new .instance_init for the TYPE_RISCV_BARE_CPU typ to avoid this
code repetition. While we're at it, add a better explanation on why
we're disabling the timing extensions for bare CPUs.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b32681f7f3..1202ec3e57 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -575,22 +575,6 @@ static void rv64i_bare_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     riscv_cpu_set_misa(env, MXL_RV64, RVI);
-
-    /* Remove the defaults from the parent class */
-    RISCV_CPU(obj)->cfg.ext_zicntr = false;
-    RISCV_CPU(obj)->cfg.ext_zihpm = false;
-
-    /* Set to QEMU's first supported priv version */
-    env->priv_ver = PRIV_VERSION_1_10_0;
-
-    /*
-     * Support all available satp_mode settings. The default
-     * value will be set to MBARE if the user doesn't set
-     * satp_mode manually (see set_satp_mode_default()).
-     */
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV64);
-#endif
 }
 #else
 static void rv32_base_cpu_init(Object *obj)
@@ -1266,6 +1250,34 @@ static void riscv_cpu_init(Object *obj)
     RISCV_CPU(obj)->cfg.ext_zihpm = true;
 }
 
+static void riscv_bare_cpu_init(Object *obj)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+
+    /*
+     * Bare CPUs do not inherit the timer and performance
+     * counters from the parent class (see riscv_cpu_init()
+     * for info on why the parent enables them).
+     *
+     * Users have to explicitly enable these counters for
+     * bare CPUs.
+     */
+    cpu->cfg.ext_zicntr = false;
+    cpu->cfg.ext_zihpm = false;
+
+    /* Set to QEMU's first supported priv version */
+    cpu->env.priv_ver = PRIV_VERSION_1_10_0;
+
+    /*
+     * Support all available satp_mode settings. The default
+     * value will be set to MBARE if the user doesn't set
+     * satp_mode manually (see set_satp_mode_default()).
+     */
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(cpu, VM_1_10_SV64);
+#endif
+}
+
 typedef struct misa_ext_info {
     const char *name;
     const char *description;
@@ -1925,6 +1937,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_BARE_CPU,
         .parent = TYPE_RISCV_CPU,
+        .instance_init = riscv_bare_cpu_init,
         .abstract = true,
     },
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,      riscv_any_cpu_init),
-- 
2.43.0


