Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1972B7D6DAC
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveHO-0001dT-5s; Wed, 25 Oct 2023 09:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveH8-0001Jk-8f
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:24 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveH6-0002ws-Bu
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:22 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso48544725ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698241819; x=1698846619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p61FHvmmepU2o4kEvQUmyLrOtbj+UtdBul2o9kwBryU=;
 b=aXwBEX/UWq5wZXZTGXZRx1sKDDFHTns/FlyNp6XDyVZonnOJBHxa10lQtDhWZF6cDo
 lcUC2gEOJmPyuCHtaeutbOjzduzWFdIDKWyrkqdXe4GoV9Mh62GhWHM2XE8jJhaY9Waj
 1XUBK5ivKaY/j3wcdJw/cXzUrV5e+i96zqXFmceS5h9dhb3V4U37tI0e2AfsdHR295wo
 uK+p9kkkHjO2IYVK43tPgKgQZHEQYuwq3I5sc/FAjoHlqu0VwqvtIIHLJ6s8pvblEl4M
 b17JvFP2DnFQGDWWPfPg6DFLemBEQyIn6zLZcqjJVca6MGdo8yKHIkLWqS+dbci5ItRN
 YAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241819; x=1698846619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p61FHvmmepU2o4kEvQUmyLrOtbj+UtdBul2o9kwBryU=;
 b=n+IFhke358Rkq9Qaavv9Z/kQxEDG2grr75I0ECEUyti672t4itDLoxdKn1f2bjwqQo
 zJorpey8KhOq08F1/Li9uyUF40K8iID0oYJ/DsVnkR2W6jS2UNrsRhuQNhunbB1BFM9i
 E78MTl7SjdBzzTwKaLmr1rsAOUr32x3YzD58Av4HLtbhS2tHtmJo576Qfhl9GXmi2OwH
 NpeJAz6Fbhk/YA4BZc2Sij2fOBYQDx9lLymBIcwpvpEcPX2RSJXaAB92PDknA2JdnLsm
 bI0wlVmbmwyusWITTSbE1x5TirqNPZ8RRvG+5/XJBjMHTp7r8PVIcxHHFUgGUpmj+psN
 DqVw==
X-Gm-Message-State: AOJu0Yz1b7s8ScRLJ+8Y0cvvsBQhWnRUx/yzMELIB4Vb+3hL/VByj/ZL
 pTEGJq3SPhE0rpgBNycjP5JdYPK1LA8CvyMWDzE=
X-Google-Smtp-Source: AGHT+IEIMKs7MpZg2i40GkHP+n88b0xTVqHnKqBnl7ltqEdP+nrsw57FWt4x+9kVvEZIhKBN4MnGpA==
X-Received: by 2002:a17:903:1112:b0:1c6:117b:7086 with SMTP id
 n18-20020a170903111200b001c6117b7086mr16676360plh.5.1698241818735; 
 Wed, 25 Oct 2023 06:50:18 -0700 (PDT)
Received: from grind.. ([191.255.2.33]) by smtp.gmail.com with ESMTPSA id
 jw4-20020a170903278400b001ca485b8515sm9252548plb.91.2023.10.25.06.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 06:50:18 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 3/9] target/riscv/tcg: add user flag for profile support
Date: Wed, 25 Oct 2023 10:49:55 -0300
Message-ID: <20231025135001.531224-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025135001.531224-1-dbarboza@ventanamicro.com>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
this profile, setting it to 'false' means disabling all its mandatory
extensions. Regular left-to-right option order will determine the
resulting CPU configuration, i.e. the following QEMU command line:

-cpu rv64,zicbom=false,zifencei=false,rva22u64=true

Enables all rva22u64 mandatory extensions, including 'zicbom' and
'zifencei', while this other command line:

-cpu rv64,rva22u64=true,zicbom=false,zifencei=false

Enables all mandatory rva22u64 extensions, and then disable both zicbom
and zifencei.

For now we'll handle multi-letter extensions only. MISA extensions need
additional steps that we'll take care later.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 093bda2e75..572ae9c902 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -769,6 +769,57 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
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
@@ -892,6 +943,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
 
+    riscv_cpu_add_profiles(obj);
+
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(DEVICE(obj), prop);
     }
-- 
2.41.0


