Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C941C82C147
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 15:03:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOI7C-00041L-OE; Fri, 12 Jan 2024 09:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOI78-00040C-4y
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:02:26 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOI76-0005qo-Fa
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:02:25 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d3eae5c1d7so36704005ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 06:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705068143; x=1705672943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUjZzYJ5AXvpsVQ3nGeKnk+ExcciChRIgPNJ0TDDNuA=;
 b=JlntuWQJ5IaHG5ZvNawjjfbRQyLtWIB7BtH+1sFG89BOm5C6ioDYS5V+8UzgB3pCzH
 zsNuIk+gFfhErMqbhMR9d50ho32fRrEMX3SO0WUQ8jJ778yWHMhgJYuE7s//wHTdymc6
 UZOQOz7dvAJ9lGlwEKGmLkWjxU7fzNGca+V6T4wcJHtZbdXOakpzB4shCDyOUUfjxcAB
 V13y2STB/wumvmgHCHznk2l/90FwZd+ofH4fzri+PaAAsvk3tTGCe2S+B2nLwwp1B1Ho
 sFytyOUuPLtqhx6MpD0Sz6Qbt6WoJnfOZx9H+HuD+ui0K8HE8ul/DAI7dIHGljEe/+XZ
 qFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705068143; x=1705672943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUjZzYJ5AXvpsVQ3nGeKnk+ExcciChRIgPNJ0TDDNuA=;
 b=iwC+ji0P5vYUFWTW6HNzVmbL8poRfHDAKBYiYqVfhO+DZlDdKnh5aDXcBrnxYKWWdz
 Phi+RCU6Mj7N3dcrij2sxNCRf/qfMdcTguMpLT4+ytGkFHOj3jI510MR2pKHlpIaxLPA
 7WK7THGnjS4wsep1LTEKKdLMxKe7CQG/6KcUeQi6riY2Vop0QpGLmufxuJN6TDYmGxjv
 +8JmcrDjMFQZya9pK8NbgIzh9n541pqGG4TUM6MzDZmu9dVdHNMfKw734kLf2wQaTeBW
 K3nPtemBfm0XkrGLDP5muXG+V9OBkyOD367kQUdiC2rFr+SR3mTHbli9UpzGT/TEgo7w
 /Eng==
X-Gm-Message-State: AOJu0YzeoB5hLAXAkzoY8PM2uTMwe4NKrpwVUBp0b1MnwNWSovAVlvVi
 UeAHjm30RuwqVOg+KS13+bp6xnGmglqlh/ffkZ28uIy01BudGw==
X-Google-Smtp-Source: AGHT+IF47w1OyY/JCkDPJpxyCKSoA+RFRGO69K9sgn2g8gdwKEEZ9ea9TE2lMY6wa73i6D2j+4RikA==
X-Received: by 2002:a17:902:e541:b0:1d4:11a8:a2a8 with SMTP id
 n1-20020a170902e54100b001d411a8a2a8mr1043571plf.57.1705068142740; 
 Fri, 12 Jan 2024 06:02:22 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a1709028c8500b001cf6453b237sm3116927plo.236.2024.01.12.06.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 06:02:22 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PATCH v5 4/8] target/riscv: move 'cboz_blocksize' to
 riscv_cpu_properties[]
Date: Fri, 12 Jan 2024 11:01:57 -0300
Message-ID: <20240112140201.127083-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112140201.127083-1-dbarboza@ventanamicro.com>
References: <20240112140201.127083-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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

And remove the now unused kvm_cpu_set_cbomz_blksize() setter.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
---
 target/riscv/cpu.c         | 38 +++++++++++++++++++++++++++++++++++++-
 target/riscv/kvm/kvm-cpu.c | 28 ----------------------------
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8976dc26a3..ce4fdfaf0e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1323,6 +1323,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.elen = 64;
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cbop_blocksize = 64;
+    cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1944,8 +1945,42 @@ static const PropertyInfo prop_cbop_blksize = {
     .set = prop_cbop_blksize_set,
 };
 
+static void prop_cboz_blksize_set(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value != cpu->cfg.cboz_blocksize && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.cboz_blocksize);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.cboz_blocksize = value;
+}
+
+static void prop_cboz_blksize_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.cboz_blocksize;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_cboz_blksize = {
+    .name = "cboz_blocksize",
+    .get = prop_cboz_blksize_get,
+    .set = prop_cboz_blksize_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -2034,6 +2069,7 @@ static Property riscv_cpu_properties[] = {
 
     {.name = "cbom_blocksize", .info = &prop_cbom_blksize},
     {.name = "cbop_blocksize", .info = &prop_cbop_blksize},
+    {.name = "cboz_blocksize", .info = &prop_cboz_blksize},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 094bc5f47c..748a690b73 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -352,30 +352,6 @@ static KVMCPUConfig kvm_cboz_blocksize = {
     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
 };
 
-static void kvm_cpu_set_cbomz_blksize(Object *obj, Visitor *v,
-                                      const char *name,
-                                      void *opaque, Error **errp)
-{
-    KVMCPUConfig *cbomz_cfg = opaque;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    uint16_t value, *host_val;
-
-    if (!visit_type_uint16(v, name, &value, errp)) {
-        return;
-    }
-
-    host_val = kvmconfig_get_cfg_addr(cpu, cbomz_cfg);
-
-    if (value != *host_val) {
-        error_report("Unable to set %s to a different value than "
-                     "the host (%u)",
-                     cbomz_cfg->name, *host_val);
-        exit(EXIT_FAILURE);
-    }
-
-    cbomz_cfg->user_set = true;
-}
-
 static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
 {
     CPURISCVState *env = &cpu->env;
@@ -493,10 +469,6 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
                             NULL, multi_cfg);
     }
 
-    object_property_add(cpu_obj, "cboz_blocksize", "uint16",
-                        NULL, kvm_cpu_set_cbomz_blksize,
-                        NULL, &kvm_cboz_blocksize);
-
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_extensions);
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_vendor_exts);
     riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_experimental_exts);
-- 
2.43.0


