Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F4816ECA
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:55:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD8X-0002jO-E0; Mon, 18 Dec 2023 07:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8W-0002jE-3B
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:20 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD8U-0004v0-DL
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:19 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d3b81d9719so3831095ad.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904056; x=1703508856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HuvEsgxWwwqF2LC0TgYcAhkQ8MMJ6brabKMOQ5WOKKE=;
 b=bIfqRZwkmJcOP08lMn9RL+LLvuiRPPeauf1Ab07L07dtljizoMrg5blvUH2Tcj7c22
 3nRi/m5nwGa6uvOA03YVqFw0iX2jfFR7SN4PQ/sMFnpjwYHwLXrYau11vOJ1/3A9JG9O
 p1Pqz60vLnEk7/P//9zGwThQyy74ZAXuaFBotknO/xI0jUWyEMI4hnIWkuZxBF9CEt75
 xLVP6AMFKyvEKQSqP5UCxLYnkBzFopTVgn0fUTAd0OGH7Ras/RyxveV3dcxmH6rAkyyW
 uu0ICB7svJx/vzDGmEtKiE7ztuu3qs7wm4OknMgHVHFVGbt+ERm0sCn6dp96R1IJcG4E
 /8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904056; x=1703508856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HuvEsgxWwwqF2LC0TgYcAhkQ8MMJ6brabKMOQ5WOKKE=;
 b=bhnYi1Lg8JOB22taHlap+OwZSbEdNRHTZHkHBruNJS7U+3cRCsn+aMZJkXU7RxMtbH
 r9B3+u0X3J9syHmvS4p6egudTE7tt4FabohlHp62Ni+Ps7obCsYqYVMs8JPZvs1XT10b
 qntrMFuaG2WvilwPwggDfOlYR2sInBpyFXQ3FP0+HuNZgwwxzrMZ9A6IjLU2MXe2tYle
 KEGP2rtVni7kUa1qPoBL9mDLmFq4miQv2a6SWGFgeL5ixo7HwTmZY16TwMdRWsY41uvg
 i67vf1BHgl7353u4v2IHjG155GsVSywb7uitTXVgVdiVO1R7akv5X/Yju9dBqHdtWfOf
 1LdA==
X-Gm-Message-State: AOJu0YzGfesufavW7ld/dByOFWbOsoCqjhl1zDuqtRjerKLpctTUDF5e
 5lTBanN9SpKZEcO9NUQT9E9PL1tXIK74zQZwV58=
X-Google-Smtp-Source: AGHT+IH91qrM2HMZCmAHpaFsE1O7+28WEPBmN3torYhmeiy9WPXb0VtwBF9oLIAjZeA4e56aAHiowg==
X-Received: by 2002:a17:903:1250:b0:1d3:3854:2e with SMTP id
 u16-20020a170903125000b001d33854002emr5979649plh.3.1702904056607; 
 Mon, 18 Dec 2023 04:54:16 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:54:16 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v13 10/26] target/riscv/tcg: add user flag for profile support
Date: Mon, 18 Dec 2023 09:53:18 -0300
Message-ID: <20231218125334.37184-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218125334.37184-1-dbarboza@ventanamicro.com>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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

The TCG emulation implements all the extensions described in the
RVA22U64 profile, both mandatory and optional. The mandatory extensions
will be enabled via the profile flag. We'll leave the optional
extensions to be enabled by hand.

Given that this is the first profile we're implementing in TCG we'll
need some ground work first:

- all profiles declared in riscv_profiles[] will be exposed to users.
TCG is the main accelerator we're considering when adding profile
support in QEMU, so for now it's safe to assume that all profiles in
riscv_profiles[] will be relevant to TCG;

- we'll not support user profile settings for vendor CPUs. The flags
will still be exposed but users won't be able to change them;

- profile support, albeit available for all non-vendor CPUs, will be
based on top of the new 'rv64i' CPU. Setting a profile to 'true' means
enable all mandatory extensions of this profile, setting it to 'false'
will disable all mandatory profile extensions of the CPU, which will
obliterate preset defaults. This is not a problem for a bare CPU like
rv64i but it can allow for silly scenarios when using other CPUs. E.g.
an user can do "-cpu rv64,rva22u64=false" and have a bunch of default
rv64 extensions disabled. The recommended way of using profiles is the
rv64i CPU, but users are free to experiment.

For now we'll handle multi-letter extensions only. MISA extensions need
additional steps that we'll take care later. At this point we can boot a
Linux buildroot using rva22u64 using the following options:

-cpu rv64i,rva22u64=true,sv39=true,g=true,c=true,s=true

Note that being an usermode/application profile we still need to
explicitly set 's=true' to enable Supervisor mode to boot Linux.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 80 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3319ba8e4e..83d4dd00cf 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -127,6 +127,19 @@ static bool cpu_cfg_offset_is_named_feat(uint32_t ext_offset)
     return false;
 }
 
+static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
+{
+    switch (feat_offset) {
+    case CPU_CFG_OFFSET(zic64b):
+        cpu->cfg.cbom_blocksize = 64;
+        cpu->cfg.cbop_blocksize = 64;
+        cpu->cfg.cboz_blocksize = 64;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void cpu_bump_multi_ext_priv_ver(CPURISCVState *env,
                                         uint32_t ext_offset)
 {
@@ -885,6 +898,71 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
     }
 }
 
+static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    RISCVCPUProfile *profile = opaque;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value;
+    int i, ext_offset;
+
+    if (riscv_cpu_is_vendor(obj)) {
+        error_setg(errp, "Profile %s is not available for vendor CPUs",
+                   profile->name);
+        return;
+    }
+
+    if (cpu->env.misa_mxl != MXL_RV64) {
+        error_setg(errp, "Profile %s only available for 64 bit CPUs",
+                   profile->name);
+        return;
+    }
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    profile->user_set = true;
+    profile->enabled = value;
+
+    for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
+        ext_offset = profile->ext_offsets[i];
+
+        if (profile->enabled) {
+            if (cpu_cfg_offset_is_named_feat(ext_offset)) {
+                riscv_cpu_enable_named_feat(cpu, ext_offset);
+            }
+
+            cpu_bump_multi_ext_priv_ver(&cpu->env, ext_offset);
+        }
+
+        g_hash_table_insert(multi_ext_user_opts,
+                            GUINT_TO_POINTER(ext_offset),
+                            (gpointer)profile->enabled);
+        isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
+    }
+}
+
+static void cpu_get_profile(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    RISCVCPUProfile *profile = opaque;
+    bool value = profile->enabled;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void riscv_cpu_add_profiles(Object *cpu_obj)
+{
+    for (int i = 0; riscv_profiles[i] != NULL; i++) {
+        const RISCVCPUProfile *profile = riscv_profiles[i];
+
+        object_property_add(cpu_obj, profile->name, "bool",
+                            cpu_get_profile, cpu_set_profile,
+                            NULL, (void *)profile);
+    }
+}
+
 static bool cpu_ext_is_deprecated(const char *ext_name)
 {
     return isupper(ext_name[0]);
@@ -1012,6 +1090,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
 
+    riscv_cpu_add_profiles(obj);
+
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(DEVICE(obj), prop);
     }
-- 
2.43.0


