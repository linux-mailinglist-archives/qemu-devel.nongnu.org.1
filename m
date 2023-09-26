Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C7F7AF475
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:51:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlE4l-0003v9-Jy; Tue, 26 Sep 2023 15:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlE4V-0003sW-Ue
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:50:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlE4R-0001XY-C8
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:50:15 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c3bd829b86so74625765ad.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695757809; x=1696362609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frKyKkLJWTboqrEyvuRxJQp1H49QzfXcl7WjQnnl36Y=;
 b=ojvBEWwd5OPEeVuaq4K/EMWiQNwj0rBzDiuwYRnRM3cVoq9i43uGRnhNV9Fgxb3X4Y
 IYZRnn9UsvN4NvfKuOHi08ywJyY/wluKM0Cve5ZZjCBLLI+t/Zuf4n3QwocJ9EIbEi/P
 8uAPzco/OIO2taqLLkIEr1upyljF03BIcFrev+kyM3GNfmCsBZBec3RZufzuKxcUaik+
 rrLMgBTCUowBvYQzQFtKko9/wg4+Qi5l9DEzWDUhGF/34vgaBFxfGVkzPp0yQscMWtUl
 hioBtQu1rIYbrXWqv3EVmGG6yzEqkhU1LtVoBRS1xutRw7ntBNAwPaIWXUr7Bez7V5+O
 C3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695757809; x=1696362609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=frKyKkLJWTboqrEyvuRxJQp1H49QzfXcl7WjQnnl36Y=;
 b=kH8nrUhGWA3cihB5mimE+n85P2CVpFGzkWwWlMeotJFlJ4UqU8wjogCHozH20yz1US
 69fAZd8VVPiQnP4Vr3K2AXjz72ygYU7hoARS8jq3yMVRfNowOfGWn4k0R+Heu2yMo/ah
 zN6DUeszl6SPFMr4yDKNlw25Vll1rQpU1gR9qdZS6/Hjy3ygjkHpehRV1Or/0gRbKuwM
 DJG/dOhx37wUb+DMRWZ1TsqW0NdEyw/j/i0W6QJ9xA13gDjCMMqHExAFNGciqs7scyhv
 0JibXjXrBken3MZ3y0zjmeh3zYMKRO9IFyd1i/Ogf/reHvTpa2LDTZ/FDxeVF11JGm0M
 FoWQ==
X-Gm-Message-State: AOJu0YzB1uNs1fvS7hsdEBSz0CrlODuCtZPU7fQ68MSSWSKF7OMyOOQG
 jLDIIN3KXS7XIT6STbIeYrVB4qbxzZc2I7fHfmQ=
X-Google-Smtp-Source: AGHT+IEN3BGqtCP5pW0wBZKSdIs42o3hZQ0P2aSJBsb42yw+K3bJoverSjmzo7wdGHfsKmv6sExHnQ==
X-Received: by 2002:a17:903:124e:b0:1bc:69d0:a024 with SMTP id
 u14-20020a170903124e00b001bc69d0a024mr9457600plh.33.1695757809330; 
 Tue, 26 Sep 2023 12:50:09 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902f68600b001c41e1e9ca7sm11386010plg.215.2023.09.26.12.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 12:50:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 4/6] target/riscv/tcg: implement rva22u64 profile
Date: Tue, 26 Sep 2023 16:49:48 -0300
Message-ID: <20230926194951.183767-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926194951.183767-1-dbarboza@ventanamicro.com>
References: <20230926194951.183767-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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
need some wiring first. 'cpu_set_profile', our set() callback for the
profile user flag that we'll expose, will do the heavy lifting. We'll
assign misa_ext and misa_ext_mask based on the profile .misa_ext, and
enable all extensions from .ext_offsets[].

We'll also update the user choice hash 'multi_ext_user_opts' for each
extension. The idea is to reflect that setting a profile is the same as
setting all extensions of the profile in the command line. This will
prevent us from mishandling those by accident during realize() time, in
particular in validate_set_extensions(), when we might enable/disable
extensions based on certain criterias.

After cpu_set_profile() is figured out then it's a matter of exposing
the user flag for the profile using the profile name (in this case,
'rva22u64') during riscv_cpu_add_user_properties().

We will expose the profile option for vendor CPUs in the next patch
since it requires special handling. Expose it to generic CPUs only for
now.

Here's an example with the 'rv64' CPU:

 $ qemu-system-riscv64 -M virt -cpu rv64,rva22u64=true (...)

 # cat /proc/cpuinfo
processor	: 0
hart		: 0
isa		: rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zawrs_zfa_zfhmin_zca_zcd_zba_zbb_zbc_zbs_zkt_sstc_svadu

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 11e34782b9..03435521c9 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -740,6 +740,57 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
     }
 }
 
+static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    const RISCVCPUProfile *profile = opaque;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+    int i = 0;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    /* We won't disable extensions if the user disables the profile */
+    if (!value) {
+        return;
+    }
+
+    env->misa_ext |= profile->misa_ext;
+    env->misa_ext_mask |= profile->misa_ext;
+
+    for (i = 0;; i++) {
+        int ext_offset = profile->ext_offsets[i];
+
+        if (ext_offset == RISCV_PROFILE_EXT_LIST_END) {
+            break;
+        }
+
+        isa_ext_update_enabled(cpu, ext_offset, true);
+        g_hash_table_insert(multi_ext_user_opts,
+                            GUINT_TO_POINTER(ext_offset),
+                            (gpointer)true);
+    }
+}
+
+static void cpu_get_profile(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    bool value;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void riscv_cpu_add_profile_prop(Object *cpu_obj,
+                                       const RISCVCPUProfile *profile)
+{
+    object_property_add(cpu_obj, profile->name, "bool",
+                        cpu_get_profile, cpu_set_profile,
+                        NULL, (void *)profile);
+}
+
 static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
@@ -834,6 +885,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
 
+    if (object_dynamic_cast(obj, TYPE_RISCV_DYNAMIC_CPU) != NULL) {
+        riscv_cpu_add_profile_prop(obj, &RVA22U64);
+    }
+
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(DEVICE(obj), prop);
     }
-- 
2.41.0


