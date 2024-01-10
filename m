Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 394698295BD
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:07:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURy-0007nR-2x; Wed, 10 Jan 2024 04:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURY-0005iv-Ua
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:15 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURW-0004l4-WB
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:12 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bbbf5a59b7so3534733b6e.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877209; x=1705482009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMHclOSf6qVt4kU3bDRKPZmEtxqORxYsuLvB7CuuViM=;
 b=AiC+aMMR6NgklOrEB1dmvstCP6DREICFCDotg1dd3TWvrsme8njWGykbXHCNwA/kl5
 954Pjfa+hWGyGbzH8M4AVhwFvcrigpRWdGHSvxjvyuV862GVuYNJZPlNuumV0dKmfNKN
 imlPzi1rsxaZyR7Ex3dPBTEpSXsPy7opIUmlqwzjeBCnTCwY4ESyqgG4MYuMllcR3gJf
 7MZDefZKw23BGLs03D6gej1E8CQxT8owIoStA/4zFmuXjkgOf+mI3bs0VXJOIKwo5V7f
 1++NBpMCrbCeyfcHf3uSTssIo5dGBxBqIo8xNrbb3bdbTICqyUaosp1Z0r10zHj6VlR/
 tAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877209; x=1705482009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMHclOSf6qVt4kU3bDRKPZmEtxqORxYsuLvB7CuuViM=;
 b=c0UtE+1U7aK0zpYlCvevfqd3JZtBBfacGnSgyF6pD7wd37V3lYQ5jsD8wuyg6I/gVh
 bUtdFMP3mHy3jRwzq2fvCcaDOov+u8DRqTvwGwrTr79pxxoUxsWbx2TFdE8xaldDkeqb
 2Kgj0iYty/1ur/Ezr/xKNlv6fv4vByUB28KEpO1XqzisLCZecS3w3ieKfptMGnPREPpa
 8mFfcPi3BC0IMuSCVogE0b8mH+h9URaY/ExQ/MyEKAQwqqNW7rDETRtDry8HvsDCXELx
 hPZbnDwHNcA+xI6L1M3j0v5yOBYbGi02a5vCecvSKpNeQh1+xlwCn/A+e4ilxdErlr95
 jXAQ==
X-Gm-Message-State: AOJu0Yw49SxQGB3mn6zcm3x4C/++TJZ7oYTfJIvv1LMg4nthNqRYeoY0
 g9GA6qAdOndc53+euDnEtkLlPdwBG43n1IRD
X-Google-Smtp-Source: AGHT+IGexGvJUSwmhcmNHy7WPwMuykeMJ7LnA/JWPf8W42WwGi3dOr5f7fnuUIhh46bC0qxk/nnHbA==
X-Received: by 2002:a05:6358:98a7:b0:175:745e:dbef with SMTP id
 q39-20020a05635898a700b00175745edbefmr729876rwa.61.1704877209210; 
 Wed, 10 Jan 2024 01:00:09 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:08 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/65] target/riscv/tcg: add user flag for profile support
Date: Wed, 10 Jan 2024 18:57:06 +1000
Message-ID: <20240110085733.1607526-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-11-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 80 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f12e0620e5..9234254772 100644
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
@@ -890,6 +903,71 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
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
@@ -1017,6 +1095,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
 
+    riscv_cpu_add_profiles(obj);
+
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(DEVICE(obj), prop);
     }
-- 
2.43.0


