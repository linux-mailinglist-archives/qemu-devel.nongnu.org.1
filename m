Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 222E07DA604
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 10:56:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwf5u-0000N4-NR; Sat, 28 Oct 2023 04:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf5r-0000Ma-HF
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:54:55 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf5p-00049x-PO
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:54:55 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7b3d33663so24389367b3.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698483291; x=1699088091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9FYveCkTx86b9xZfDyMLAkEFvQmOPAHoBnkFlBm9D0=;
 b=IauJ1DP+UauIZWmcbgmNb5QYCOvDbq9ni41lXE/cpzPMIIRNFxksaURT6uGIUpLpA6
 AsanRSxc2c49drPGLotl7MJNfat8V2AvJvsnezankccTCIWETvNiUimRyVSS9gaydLJZ
 p4IQBrwPzCvcbIWLxyr5HM0fEV1YO6tAyvo7xTDE5WRbOd4rhkWevzOrlnSx0CvWxlau
 Y+sxcYUKJ0iNf40BGCSjrxnD1iaqMWmt8tkHkfgeZpxbFNAslHts7OqB+EtPYGen7kkU
 kG9dV2aYnEhGp27DYzh4Gi3XeMgbY1O8qxCi881BAXEPOSTOw/lBug4uZvuYz/b6MTD3
 aY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698483291; x=1699088091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9FYveCkTx86b9xZfDyMLAkEFvQmOPAHoBnkFlBm9D0=;
 b=jCAVwWR4Q6bdLRWPzymJYQhj4cS3Oyuag63r2/FyVPYrKFRQDAu8jSSM1l2+m36eVH
 VtuUD43JNluA5GAs0hUmdZbsE8ONUmqFWCAD7OsmwQ0Z6T6CuihCh1FgKnhHPzQo3uyL
 N3LRU8nXiTKYCUh5Sa5vMIV9EdcVrZ28wizAVw3FN32mtJn3M4oU8QCIfvlnGtcp6/iP
 5/tTN/jDoIl/cDBhnzI7mYdO4H0DH29XJa5zV0Ia2PqgKR49DGBBxepugo2MXMfEhom+
 icE+U4hB1uYXxDxev7/lHHiL1duDwABCXL0vasigZJLElAXHeGWiMXNqvpun2hQCGRK5
 zonA==
X-Gm-Message-State: AOJu0Ywf5tnXdSLQwQdfly7+WUEAcIAsVoV/49kosXEN2jygZ6C0fsGu
 rOg5Dt4SfaFQB2itRhdr1f2qvtCLOfV2IHaX0gM=
X-Google-Smtp-Source: AGHT+IEHkhvu8u2I5dXPvWPbFRgSNci+s9YbPfwh3iPk8HtMKDzbKTPgrllzHIu2Vq9KKRAGLIjSgA==
X-Received: by 2002:a81:ed0b:0:b0:5a7:ccf3:7163 with SMTP id
 k11-20020a81ed0b000000b005a7ccf37163mr4489833ywm.15.1698483291674; 
 Sat, 28 Oct 2023 01:54:51 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.255.2.33])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a81830f000000b00594fff48796sm1604325ywf.75.2023.10.28.01.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 01:54:51 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 06/12] target/riscv/tcg: add user flag for profile support
Date: Sat, 28 Oct 2023 05:54:21 -0300
Message-ID: <20231028085427.707060-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231028085427.707060-1-dbarboza@ventanamicro.com>
References: <20231028085427.707060-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
will still be exposed but users won't be able to change them. The idea
is that vendor CPUs in the future can enable profiles internally in
their cpu_init() functions, showing to the external world that the CPU
supports a certain profile. But users won't be able to enable/disable
it;

- Setting a profile to 'true' means 'enable all mandatory extensions of
this profile, setting it to 'false' means 'do not enable all mandatory
extensions for this profile'. This is the same semantics used by RVG.
Regular left-to-right option order will determine the resulting CPU
configuration, i.e. the following QEMU command line:

-cpu rv64,zicbom=false,zifencei=false,rva22u64=true

Enables all rva22u64 mandatory extensions, including 'zicbom' and
'zifencei', while this other command line:

-cpu rv64,rva22u64=true,zicbom=false,zifencei=false

Enables all mandatory rva22u64 extensions, and then disable both zicbom
and zifencei.

For now we'll handle multi-letter extensions only. MISA extensions need
additional steps that we'll take care later.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 63 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 65d59bc984..5fdec8f04e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -783,6 +783,67 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
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
+    if (object_dynamic_cast(obj, TYPE_RISCV_DYNAMIC_CPU) == NULL) {
+        error_setg(errp, "Profile %s only available for generic CPUs",
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
+    if (!profile->enabled) {
+        return;
+    }
+
+    for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
+        ext_offset = profile->ext_offsets[i];
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
@@ -906,6 +967,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
 
+    riscv_cpu_add_profiles(obj);
+
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(DEVICE(obj), prop);
     }
-- 
2.41.0


