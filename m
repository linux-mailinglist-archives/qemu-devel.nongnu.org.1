Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAB87DD730
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 21:41:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxvWl-0005Jx-9S; Tue, 31 Oct 2023 16:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvWj-0005Ji-1S
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:39:53 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvWh-0007WE-Bp
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:39:52 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5afa5dbc378so44777277b3.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698784789; x=1699389589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYge/p+pBT4buL5VP1PnPAo3dWrKZvARic+bW/Gu+FU=;
 b=lKpPIFTcYJ37ho4JBnltXKTEumANJzIe0QC8iR0ZbbmQOrzcQJCRqZOSx6UjkFd7Zz
 2xrqtIB2P0M7NKyLaQe24Fy+btw47spGZVXY5ISeJ4Ix2AjWcMTwsjx6vNpdc0fmUkjI
 4eOlzCmKfDgK6H5N0wYX3zoMUcFXwxQ5m8AVinwmaFTxHtDTbrOsof1zCzGLySVSG9vP
 nTT5lec3r/eDH5tNwBk1zG63Yvv+0JKj/jtv6abRNAC33typbMFtvMvIiQL45Yd25qve
 YUsI7DbyEFAWp0sXLlIo+Anc6lexe+BYlt9ebM8YX1wiJk4+WaVaAViUVATgBdXsWXnE
 SUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698784789; x=1699389589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WYge/p+pBT4buL5VP1PnPAo3dWrKZvARic+bW/Gu+FU=;
 b=oN8SM4qEY5rz6pvX0crGaQlz2EJJsaXc+LFY/SCNvZ8YnPW7rvfJuKdvnWP7MokqT/
 OFOck3S5VhnXwEEQn0M8uMDlSM8p+KJAk++lFwn/+DQdsMtmdKvMYVq5uF2ZEhvL8+Xj
 GcRDS+HL+d9ZdoJB74lgd4mf7PprVbQC0Lcn39N4WP1Sc34wzJTd6ljKHUDYOV7qpCHo
 9vCY110LUquJdqQ9OjiLZ7B+HnEEITxDq3XBQNxDfS+fY+SgwKA8ZmyiA3iyVhmUkciw
 6yGa78ZLSONHUHLkUtjl55qIdnQ+2Khj5ttETrdy3vwnVX4PkLuK6w4bYmbIJ7SIY0+t
 R81Q==
X-Gm-Message-State: AOJu0YxlDE1sSLVFvAvxzljiRqCaCR2wscDNG2hnlSJKBZPvfmqeLCwi
 07tHCqmWo2rZGtlEfXe6gkZEknUVmeVrojigb3g=
X-Google-Smtp-Source: AGHT+IFk5FPd2ZFgDkgspCetjiWrb4opCeo7B6m7JpU/fTTohfaWdWqT7w/c3zm7w+T2Uf8S5EKHGg==
X-Received: by 2002:a05:690c:101:b0:5a7:fae6:1cc6 with SMTP id
 bd1-20020a05690c010100b005a7fae61cc6mr11753345ywb.24.1698784789341; 
 Tue, 31 Oct 2023 13:39:49 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 k1-20020a81ff01000000b005add997ae53sm1272802ywn.81.2023.10.31.13.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 13:39:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 09/16] target/riscv/tcg: add user flag for profile support
Date: Tue, 31 Oct 2023 17:39:09 -0300
Message-ID: <20231031203916.197332-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031203916.197332-1-dbarboza@ventanamicro.com>
References: <20231031203916.197332-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

-cpu rv64i,rva22u64=true,g=true,c=true,s=true

Note that being an usermode/application profile we still need to
explicitly set 's=true' to enable Supervisor mode to boot Linux.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 59 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8aa17ffaa2..3e31a41859 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -788,6 +788,63 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
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
+    if (object_dynamic_cast(obj, TYPE_RISCV_VENDOR_CPU) != NULL) {
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
@@ -911,6 +968,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
 
+    riscv_cpu_add_profiles(obj);
+
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(DEVICE(obj), prop);
     }
-- 
2.41.0


