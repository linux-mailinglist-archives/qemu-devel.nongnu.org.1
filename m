Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D423C81C9DD
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 13:24:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGeYk-0001sR-CW; Fri, 22 Dec 2023 07:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYi-0001nH-5R
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:23:20 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYg-0006DI-C8
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:23:19 -0500
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7b7fdde8b56so88742339f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 04:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703247797; x=1703852597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hjpf3AGLXfHTv0VRbfE18QlHn2bcFZdBUtge7yKuVWs=;
 b=Tv0A1zFIAIMQeGcRuyb9rZBAJXWndBCOl3jzMz8Pi8hBf2W+7O3nQVq9sqhmN8/4Lq
 KI9X046zjPfKbTRRprCWDlpM4U3QplxlbY6FR6znhYc6EDH73woW0QxFULmD4drMNDQO
 UzFY2kSZ5r17+iKL55Uw7XTlv5IFdMEXRlREskzUkkEWgtX1gxN8nJ1ys8NS/tq0GSv4
 nQ5n/zjqDYa0cnZ+d0Xjf8umSmh1yEdPswHZlqS/k0ZHWjGCFnoyLy0Vy2EupN2xrDSz
 AblC3NQ3EVz6NWNoWiieeoh4NcebOimhyWwF6pgog4DHdlmISmOoQrD2L9EmIUUS3xKe
 f7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703247797; x=1703852597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hjpf3AGLXfHTv0VRbfE18QlHn2bcFZdBUtge7yKuVWs=;
 b=qXAmjT5PWKEBmFtc+551EseiqrH9od//tc0aC255vywIM4ht48dh2XZDGZfcCLG5E8
 Bqk6hYcf4XqpGWJbTvuEUbhA54YxOVeGwUwSVPV7rDnYtqrgglcHgec/WXIvLC7mYdKo
 wSyt3PHwXVFYdANOeMJT++W3ncWYolCdv9UUINLO2GgdH7CDHnld6UY9Le7d+Xc01IK0
 WtTSMlBU/ONc8rzCCYfnsTBj7rMiVOesXjjny2r3qZMk0IWrU29e0kfaWIPF1QTrmswU
 E0MemFU8D+eHsBD+Wv0HaMoZY0Xm61x1n+BUBa/hbdOS+GzzRPbd8+wehMTX+90aqAI8
 aWOw==
X-Gm-Message-State: AOJu0Yx3AH8ONH5gkOeH10Fi3CxECMXieNDBQpUqz2YyM+WTRYTvxnIi
 49z1xYcmJ8V65p4iFxYJmPVHbFNSUk+/rM7ZKjGt/fmAITNwSg==
X-Google-Smtp-Source: AGHT+IGm46nQeudZhzPk2GGwUBH/X2oPoIjV9OtEHZ/AyE1ok4i8fmbRTVTuA/vKSDlfWdinj7fIbg==
X-Received: by 2002:a6b:da08:0:b0:7ba:94d4:c342 with SMTP id
 x8-20020a6bda08000000b007ba94d4c342mr1274727iob.8.1703247796843; 
 Fri, 22 Dec 2023 04:23:16 -0800 (PST)
Received: from grind.dc1.ventanamicro.com (201-69-66-51.dial-up.telesp.net.br.
 [201.69.66.51]) by smtp.gmail.com with ESMTPSA id
 g14-20020aa7874e000000b006ce7ad8c14esm3274901pfo.164.2023.12.22.04.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:23:16 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 12/16] target/riscv: move 'cboz_blocksize' to
 riscv_cpu_properties[]
Date: Fri, 22 Dec 2023 09:22:31 -0300
Message-ID: <20231222122235.545235-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222122235.545235-1-dbarboza@ventanamicro.com>
References: <20231222122235.545235-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-io1-xd2b.google.com
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

Do the same we did with 'cbom_blocksize' in the previous patch.

Remove the now unused kvm_cpu_set_cbomz_blksize() setter.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 45 +++++++++++++++++++++++++++++++++++++-
 target/riscv/kvm/kvm-cpu.c | 28 ------------------------
 2 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 50825522b2..f30058518a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1818,8 +1818,49 @@ static const PropertyInfo prop_cbom_blksize = {
     .set_default_value = qdev_propinfo_set_default_value_uint,
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
+    /* Always allow setting a default value */
+    if (cpu->cfg.cboz_blocksize == 0) {
+        cpu->cfg.cboz_blocksize = value;
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
+    .set_default_value = qdev_propinfo_set_default_value_uint,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -1845,6 +1886,8 @@ static Property riscv_cpu_properties[] = {
 
     {.name = "cbom_blocksize", .info = &prop_cbom_blksize,
      .set_default = true, .defval.u = 64},
+    {.name = "cboz_blocksize", .info = &prop_cboz_blksize,
+     .set_default = true, .defval.u = 64},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 1866b56913..137a8ab2bb 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -343,30 +343,6 @@ static KVMCPUConfig kvm_cboz_blocksize = {
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
@@ -484,10 +460,6 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
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


