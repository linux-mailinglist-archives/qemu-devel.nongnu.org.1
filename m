Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD00875867A
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:06:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLrrt-0002qk-57; Tue, 18 Jul 2023 17:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrk-0002eJ-UJ
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:04:18 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrW-0007Ot-3F
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:04:15 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6b9daf5953aso75155a34.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689714240; x=1692306240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Be6fV+LPw5+YTMBnxF1h1z2RNTNDe8bLPNZ+M4xvt4=;
 b=cbYrZcgOyngutqWHjNePKcbHJ/Pbhirlm/QQKpTigVblcGuEJCchmE+6Cq3vprSCrS
 Hawbh4TuYFsAqp9kFoZU0jeYB+umpdZemXqO/5wVHHqRjoRlrt2zKYtbazT0F/a6Jx5r
 HPEfwEzBgzU1yaD6G9osaCr9JdjX8JPcicpWMqNI1n4VLBeWird1R7MJKIdhXtxZoM/t
 vEWlOJmWTLZdDz8AJzBstkaAuv3RmcseoL1R7MNRIf1VuIe28ZTbHTR021tOcrlT9y0n
 NHLwgtzNLlfu9eIgm1Tdf/lKsmrQWs7lHHJzFOK/eImzZF5MaD8Zd7wzq/8KnMR56vPM
 TdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689714240; x=1692306240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Be6fV+LPw5+YTMBnxF1h1z2RNTNDe8bLPNZ+M4xvt4=;
 b=TkSfE3RRJMeIcHXPHmpwUtYuL5nbnuBl8/B/DptUj8yMhH0U9rXbc9WwsP8tU8yhKj
 bS1olM7oXjVo7v52ewnJKv6S7zvCCsJ3OlgAam9HhwqD/apKETGuG/CN9aiOBmelLUBL
 rDWT3djyn8GAbffHGW7x42iAoYfHw9EDP64Qu3wKUZXVamRRQ0hm4DRhjKEFLl+sRNCL
 Paay48iIGgFyYztaLpDATveVjvqhGaj4Rc22kyr/qosLhpN6z4rtc7XsSCYVKpgJU1m4
 IS/n9KnRmClWxY9L+e9cRyyxRDaJfhhZR1w73EkH1EoB6cgucdQKPRs1TmNvTrojuTMj
 F1ZQ==
X-Gm-Message-State: ABy/qLbyx7O8KxRdzmd2J/cfhRV7in5TMTOC8Cx+27U6dhwAGE2I+CfB
 9LwJJItEMK5AnX47N8XFjMCrtbP9/deDlyl0lboGoQ==
X-Google-Smtp-Source: APBJJlH1l15Mt28kX+ZFejDkPO7yGctt+Ez1ZllpsxjAPyOLFE5gCTZgG0U6uuZC+e0ahEaXQtoxIw==
X-Received: by 2002:a05:6870:a10d:b0:1b4:3b03:6653 with SMTP id
 m13-20020a056870a10d00b001b43b036653mr219427oae.9.1689714240206; 
 Tue, 18 Jul 2023 14:04:00 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a056830140200b006b96384ba1csm1160657otp.77.2023.07.18.14.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 14:03:59 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v4 09/11] target/riscv: add 'max' CPU type
Date: Tue, 18 Jul 2023 18:03:27 -0300
Message-ID: <20230718210329.200404-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718210329.200404-1-dbarboza@ventanamicro.com>
References: <20230718210329.200404-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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
 target/riscv/cpu.c     | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

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
index 7f79585bd1..7fdde68dee 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -248,6 +248,7 @@ static const char * const riscv_intr_names[] = {
 };
 
 static void riscv_cpu_add_user_properties(Object *obj);
+static void riscv_init_max_cpu_extensions(Object *obj);
 
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
 {
@@ -374,6 +375,25 @@ static void riscv_any_cpu_init(Object *obj)
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
@@ -1953,6 +1973,38 @@ static void riscv_cpu_add_user_properties(Object *obj)
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
+    Property *prop;
+
+    /* Enable RVG, RVJ and RVV that are disabled by default */
+    set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
+
+    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
+        object_property_set_bool(obj, prop->name, true, NULL);
+    }
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
 
@@ -2291,6 +2343,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .abstract = true,
     },
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,      riscv_any_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,      riscv_max_cpu_init),
 #if defined(CONFIG_KVM)
     DEFINE_CPU(TYPE_RISCV_CPU_HOST,             riscv_host_cpu_init),
 #endif
-- 
2.41.0


