Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA0F765FE6
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 00:49:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP9BK-0001Oo-Sl; Thu, 27 Jul 2023 18:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9BJ-0001Od-9z
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:10:01 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9BH-0004we-LC
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:10:01 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-565f8e359b8so1023274eaf.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690495798; x=1691100598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ggsx4MiKNFlzSbhiIdfiNyI940n+7CVZmyY4XDG05O8=;
 b=CcG6NRcUdPRmrmXD/Q7eqMoubwA/5aYDeKYdNK3Co3t7TpO7AUzYnhPglM3PdATh2D
 jM/fR/4LluJLf+XqgikuBFWVoBSjaEotk9c2H8PAerq+To5KeHp4MfV9adEVyGTuTiva
 0n8ZstYbnTGWCH4D+MsMAqdnPKRWrpLxPTAB0cLMiCn0CxfdBxk4utvdQQPSNqv/aSmd
 7ECTVDlRVutr+GvnBVuX/CVZY/aCUw71gVfccNtoMy6odfiGswR4/4NakQdd3DNWlub2
 sDZPK0y1n0YJX61vHDHxwuXFnnbWtO5wcXbhBDClX2aIJuovAkoCXeD8koEjIhuX9i4Q
 bbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690495798; x=1691100598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ggsx4MiKNFlzSbhiIdfiNyI940n+7CVZmyY4XDG05O8=;
 b=P+2D/b93a7czu2rTcGPTRIvda8K06VZ+SVTczI6XqcfoJ1/7IAtPOIs7jvq680z9lJ
 3Urzua2SDK9GywSjwfMTFn2EXkDlJ9A3JutJqd2s5Yeg81yAPUbyJ0/2GGEpqkcUqAhW
 7qyo8CNaeUF95WuQKEPGCRN3D2cf6BvV7uDeHmfL69H/qiGu2fnA76Zi0mQIv/y2actw
 /5C//WBeU6Frvw2PN/ik8leMEOAI4dbjFcbkueAGHBlhRFXTJVJirp3W80xCt98BE8Ww
 NBuEBUfEHQc+783KK/4cb8qpAm4JeC1QvTzxrW/tL6ePlfOT2bg6xxfJCFcpkzkE+7+7
 FnGw==
X-Gm-Message-State: ABy/qLa7Q25bsz+BQdCBbPBpSCC6Buv8zqsQ1T6HI2ZFHxO5Zy72sBBg
 h4KoxSTqa4cy/GhhHDJdTR1Y6lQIB8pHgTn0ts64Rg==
X-Google-Smtp-Source: APBJJlHAratV+eqmltBa1fH8V/2N7H3YnDvkFHu6gMLzd/SPQSkhlPRSASUL2tkzjuVcxXhvZVzbZA==
X-Received: by 2002:a4a:6c5b:0:b0:567:d:c8 with SMTP id
 u27-20020a4a6c5b000000b00567000d00c8mr727665oof.9.1690495798311; 
 Thu, 27 Jul 2023 15:09:58 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 y136-20020a4a458e000000b0051134f333d3sm1070471ooa.16.2023.07.27.15.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 15:09:58 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 10/12] target/riscv: add 'max' CPU type
Date: Thu, 27 Jul 2023 19:09:25 -0300
Message-ID: <20230727220927.62950-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727220927.62950-1-dbarboza@ventanamicro.com>
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc31.google.com
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

The 'max' CPU type is used by tooling to determine what's the most
capable CPU a current QEMU version implements. Other archs such as ARM
implements this type. Let's add it to RISC-V.

What we consider "most capable CPU" in this context are related to
ratified, non-vendor extensions. This means that we want the 'max' CPU
to enable all (possible) ratified extensions by default. The reasoning
behind this design is (1) vendor extensions can conflict with each other
and we won't play favorities deciding which one is default or not and
(2) non-ratified extensions are always prone to changes, not being
stable enough to be enabled by default.

All this said, we're still not able to enable all ratified extensions
due to conflicts between them. Zfinx and all its dependencies aren't
enabled because of a conflict with RVF. zce, zcmp and zcmt are also
disabled due to RVD conflicts. When running with 64 bits we're also
disabling zcf.

MISA bits RVG, RVJ and RVV are also being set manually since they're
default disabled.

This is the resulting 'riscv,isa' DT for this new CPU:

rv64imafdcvh_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zfa_
zfh_zfhmin_zca_zcb_zcd_zba_zbb_zbc_zbkb_zbkc_zbkx_zbs_zk_zkn_zknd_
zkne_zknh_zkr_zks_zksed_zksh_zkt_zve32f_zve64f_zve64d_
smstateen_sscofpmf_sstc_svadu_svinval_svnapot_svpbmt

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 56 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 04af50983e..f3fbe37a2c 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -30,6 +30,7 @@
 #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
 
 #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
+#define TYPE_RISCV_CPU_MAX              RISCV_CPU_TYPE_NAME("max")
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 01b0d228f5..3e840f1a20 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -250,6 +250,7 @@ static const char * const riscv_intr_names[] = {
 };
 
 static void riscv_cpu_add_user_properties(Object *obj);
+static void riscv_init_max_cpu_extensions(Object *obj);
 
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
 {
@@ -376,6 +377,25 @@ static void riscv_any_cpu_init(Object *obj)
     cpu->cfg.pmp = true;
 }
 
+static void riscv_max_cpu_init(Object *obj)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+    RISCVMXL mlx = MXL_RV64;
+
+#ifdef TARGET_RISCV32
+    mlx = MXL_RV32;
+#endif
+    set_misa(env, mlx, 0);
+    riscv_cpu_add_user_properties(obj);
+    riscv_init_max_cpu_extensions(obj);
+    env->priv_ver = PRIV_VERSION_LATEST;
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(RISCV_CPU(obj), mlx == MXL_RV32 ?
+                                VM_1_10_SV32 : VM_1_10_SV57);
+#endif
+}
+
 #if defined(TARGET_RISCV64)
 static void rv64_base_cpu_init(Object *obj)
 {
@@ -1961,6 +1981,41 @@ static void riscv_cpu_add_user_properties(Object *obj)
     ADD_CPU_QDEV_PROPERTIES_ARRAY(dev, riscv_cpu_experimental_exts);
 }
 
+/*
+ * The 'max' type CPU will have all possible ratified
+ * non-vendor extensions enabled.
+ */
+static void riscv_init_max_cpu_extensions(Object *obj)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+
+    /* Enable RVG, RVJ and RVV that are disabled by default */
+    set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
+
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_extensions); i++) {
+        object_property_set_bool(obj, riscv_cpu_extensions[i].name,
+                                 true, NULL);
+    }
+
+    /* set vector version */
+    env->vext_ver = VEXT_VERSION_1_00_0;
+
+    /* Zfinx is not compatible with F. Disable it */
+    object_property_set_bool(obj, "zfinx", false, NULL);
+    object_property_set_bool(obj, "zdinx", false, NULL);
+    object_property_set_bool(obj, "zhinx", false, NULL);
+    object_property_set_bool(obj, "zhinxmin", false, NULL);
+
+    object_property_set_bool(obj, "zce", false, NULL);
+    object_property_set_bool(obj, "zcmp", false, NULL);
+    object_property_set_bool(obj, "zcmt", false, NULL);
+
+    if (env->misa_mxl != MXL_RV32) {
+        object_property_set_bool(obj, "zcf", false, NULL);
+    }
+}
+
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
@@ -2299,6 +2354,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .abstract = true,
     },
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,      riscv_any_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,      riscv_max_cpu_init),
 #if defined(CONFIG_KVM)
     DEFINE_CPU(TYPE_RISCV_CPU_HOST,             riscv_host_cpu_init),
 #endif
-- 
2.41.0


