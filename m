Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD888233A6
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:42:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5Ef-0003iW-1k; Wed, 03 Jan 2024 12:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5EZ-0003BM-3j
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:40:51 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5EW-0001fQ-V7
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:40:50 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so1498068b3a.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704303647; x=1704908447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndaYpmSWzGIFvdIyrDqqU7e6OzktvOjY47Ac1Mpi4+U=;
 b=kmHdBXceGVuy7SteiFfJUvwmIv/khPsSgQ8/n5wz6AIh3NAOddcYK2txWPWp+dluvk
 erKSIG/lhFSLXCvMygOSi4bNkFBALvbhN27IUglylQqIPflj/Me7acdV0wJQ952pssC6
 H52jEMVCncJx8HQVZOGDK71ANzul5pdOQRUV2DnJrkl4yztezVpgVCP+YSaskBNS+Dwl
 0AxPL0QdxMHszkuiXHwueH4KBDoyikDeRBXB0Y8AzQBH4zdniYlKbJZAYVLwNpuy3Mnd
 MjSG9Uc8tLBNxm59MH0mlct1xwiNpNRLknF2XwyXTEV7DOji3bO835wq3rRjUlseDIqd
 MdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303647; x=1704908447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndaYpmSWzGIFvdIyrDqqU7e6OzktvOjY47Ac1Mpi4+U=;
 b=YzYGyT2CR1Y+/5AsjWve98gaMbZQ6zPQ/1iiCfZBDoYFLzsib/4VNgvrqnTx0vObqR
 +AuAio2m7KaEXyNUcoZZS9/XmKvjbDKTuGQVXaAKMpBxxnYVuagiYSxycwU97x6RqNgI
 0xxtKZHiVuEAlu7F6f8al5prgmawTDbosuU6pcp0fDv6i43BubWzT9kiW55u2YYmKesV
 3g84GkNF+W9A2Yuz7yj2w2pAmia15L+3aMg2LQKGs916NZ2F6DdlEISOQeUYQIIGDYAq
 ZLfrQEub5l5LeWwJRLj256u7B50P1RN9QUQ70N5OHJ65+EXW1PBzOf+qfeMXhdoqPc9p
 yuMQ==
X-Gm-Message-State: AOJu0YwkPGhXK/EzCPXApX1mcDikY1oP0vk8cmhFUoUwmDpaKNYdD+Kq
 PtA3pCnu14erqsCdoKaB0Aw3vlEKuS1qVPreAJUjHoa1PofwDQ==
X-Google-Smtp-Source: AGHT+IFFWjlQeOIIBgMEZZLSMWNtWuE3ioK0q6ej3luiZr/+INT29yGdOIIUYwMWyzFCmV+sYyAgMw==
X-Received: by 2002:aa7:9828:0:b0:6d9:9793:37c6 with SMTP id
 q8-20020aa79828000000b006d9979337c6mr22662562pfl.8.1704303646718; 
 Wed, 03 Jan 2024 09:40:46 -0800 (PST)
Received: from grind.. ([189.79.21.107]) by smtp.gmail.com with ESMTPSA id
 v3-20020aa78503000000b006d7f1ae421csm24042050pfn.145.2024.01.03.09.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:40:46 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, vladimir.isaev@syntacore.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 07/16] target/riscv: rework 'vext_spec'
Date: Wed,  3 Jan 2024 14:40:04 -0300
Message-ID: <20240103174013.147279-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103174013.147279-1-dbarboza@ventanamicro.com>
References: <20240103174013.147279-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

The same rework did in 'priv_spec' is done for 'vext_spec'. This time is
simpler, since we only accept one value ("v1.0") and we'll always have
env->vext_ver set to VEXT_VERSION_1_00_0, thus we don't need helpers to
convert string to 'vext_ver' back and forth like we needed for
'priv_spec'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 35 +++++++++++++++++++++++++++++++++--
 target/riscv/cpu.h         |  1 +
 target/riscv/cpu_cfg.h     |  1 -
 target/riscv/tcg/tcg-cpu.c | 15 ---------------
 4 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 657569d8a6..c39da44f51 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1267,6 +1267,7 @@ static void riscv_cpu_init(Object *obj)
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
+    cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
 typedef struct misa_ext_info {
@@ -1701,9 +1702,38 @@ static const PropertyInfo prop_priv_spec = {
     .set = prop_priv_spec_set,
 };
 
-Property riscv_cpu_options[] = {
-    DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
+static void prop_vext_spec_set(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    g_autofree char *value = NULL;
 
+    visit_type_str(v, name, &value, errp);
+
+    if (g_strcmp0(value, VEXT_VER_1_00_0_STR) != 0) {
+        error_setg(errp, "Unsupported vector spec version '%s'", value);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, VEXT_VERSION_1_00_0);
+    cpu->env.vext_ver = VEXT_VERSION_1_00_0;
+}
+
+static void prop_vext_spec_get(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    const char *value = VEXT_VER_1_00_0_STR;
+
+    visit_type_str(v, name, (char **)&value, errp);
+}
+
+static const PropertyInfo prop_vext_spec = {
+    .name = "vext_spec",
+    .get = prop_vext_spec_get,
+    .set = prop_vext_spec_set,
+};
+
+Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
     DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
 
@@ -1723,6 +1753,7 @@ static Property riscv_cpu_properties[] = {
     {.name = "pmp", .info = &prop_pmp},
 
     {.name = "priv_spec", .info = &prop_priv_spec},
+    {.name = "vext_spec", .info = &prop_vext_spec},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index aa3d3372e3..f1715d9d31 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -89,6 +89,7 @@ enum {
 };
 
 #define VEXT_VERSION_1_00_0 0x00010000
+#define VEXT_VER_1_00_0_STR "v1.0"
 
 enum {
     TRANSLATE_SUCCESS,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2dba1f0007..7112af6c4c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -135,7 +135,6 @@ struct RISCVCPUConfig {
     bool ext_XVentanaCondOps;
 
     uint32_t pmu_mask;
-    char *vext_spec;
     uint16_t vlen;
     uint16_t elen;
     uint16_t cbom_blocksize;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4d67b72d9e..6501c29d8e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -201,21 +201,6 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                    "in the range [8, 64]");
         return;
     }
-
-    if (cfg->vext_spec) {
-        if (!g_strcmp0(cfg->vext_spec, "v1.0")) {
-            env->vext_ver = VEXT_VERSION_1_00_0;
-        } else {
-            error_setg(errp, "Unsupported vector spec version '%s'",
-                       cfg->vext_spec);
-            return;
-        }
-    } else if (env->vext_ver == 0) {
-        qemu_log("vector version is not specified, "
-                 "use the default value v1.0\n");
-
-        env->vext_ver = VEXT_VERSION_1_00_0;
-    }
 }
 
 static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
-- 
2.43.0


