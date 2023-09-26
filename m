Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB07AF472
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:51:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlE4n-0003wO-TF; Tue, 26 Sep 2023 15:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlE4Z-0003t8-2l
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:50:26 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlE4W-0001Xl-TP
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:50:18 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so67773515ad.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 12:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695757812; x=1696362612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sy9DWvnGfhIdovSiPtVQ7Y2mU8p0z4ZBY7chUUangFo=;
 b=KDd+PHwJlYtsGI2CAdcrRdRSqTCro0VefT4h7z59vQD59NYlgab9iDgtlupivPCaa5
 CLy7xIiTW+WcrxsPb9vBSTfIHS+Qf8QQGTWc74zqtMshXuUaD8ESNids1TFa3AS+Pd24
 7QXBxRYZCg4ebIM8pCKtWgX+fvcyFRNTttw4vnQRUZL7dDOXK07ZS6u2AWjm6WQRdSIP
 TsMOKUgb//88Y8HAUlhiPwS6bCANPbke6NmES7Ix2EY2FurZMOHp2Gwnc4nWKKphqkqb
 ihE/48B2q0r7fbrM009Ql0AcDbZie5XBduih57AYOJsDbYehQPwajT26ZpwmYA1n3rE2
 mp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695757812; x=1696362612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sy9DWvnGfhIdovSiPtVQ7Y2mU8p0z4ZBY7chUUangFo=;
 b=UAwk0ZlibwGlboeK9ygllD2QFyXH0myJVGl3ihBjELfG0ubKtIgqXXeIYG89TosRhX
 oMB/99EAawBHz7aYBP63LVC+IJyy0k2BcYxmR2dfqss+a6l5RbGfsPTP5OaL9NYUWSNH
 P3E/2Ng+bgOBgS7qanzw+UCyJccwL7gwNTc1ahytEDovTy5EghuCo5bEsCbMQgs+xE74
 FTjH8MT2vjaYEkEP7GxB3helC1hIvlgnjnjtWGKwAUzDeEK55SUtdrdPejkr4wY3XcUt
 awdXOkyYXFErnZROE4QVJEEEcYaqmREDHpaSwm7TCpBfjtLurxBti291VgSRo2edcd10
 pB3w==
X-Gm-Message-State: AOJu0Yz5fFnUlzkXpnCTPs89J3rOBIdDUhYV2XZf1leJmA4mFRfX9NtG
 xwh7/3R1TPjNtMhReS8/U5seOFwaAS1Gu/mPzng=
X-Google-Smtp-Source: AGHT+IE3fdPSIpykoVG5dkti1SxHtMNh2Mb8Z2g5AD1xPqSbfXzVX9xnN3NWqyFgQZzatsAhWAZgvg==
X-Received: by 2002:a17:903:2452:b0:1c6:2780:3adc with SMTP id
 l18-20020a170903245200b001c627803adcmr4650431pls.24.1695757812140; 
 Tue, 26 Sep 2023 12:50:12 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902f68600b001c41e1e9ca7sm11386010plg.215.2023.09.26.12.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 12:50:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 5/6] target/riscv/tcg-cpu.c: enable profile support for vendor
 CPUs
Date: Tue, 26 Sep 2023 16:49:49 -0300
Message-ID: <20230926194951.183767-6-dbarboza@ventanamicro.com>
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

Vendor CPUs can implement any profile they want as long as all required
extensions are being set in their respective cpu_init().

We do not enable extensions for vendor CPUs and that will still be true
with profile support. The idea then is to enable the profile option for
vendor CPUs and  let users try to enable it. In case the vendor CPU
do not implement all mandatory extensions of the profile, error out.
Proceed as usual otherwise.

Here's an example of what happens if we try to enable the rva22u64
profile with the veyron-v1 CPU:

./qemu-system-riscv64 -M virt -cpu veyron-v1,rva22u64=true

qemu-system-riscv64: can't apply global veyron-v1-riscv-cpu.rva22u64=true:
  Setting profile 'rva22u64' failed: CPU veyron-v1 does not support extension 'Zihintpause'

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 43 ++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 03435521c9..c8f688292e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -99,6 +99,31 @@ static const struct TCGCPUOps riscv_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
+static const char *cpu_get_multi_ext_cfg_name(uint32_t ext_offset)
+{
+    const RISCVCPUMultiExtConfig *prop;
+
+    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
+        if (prop->offset == ext_offset) {
+            return prop->name;
+        }
+    }
+
+    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
+        if (prop->offset == ext_offset) {
+            return prop->name;
+        }
+    }
+
+    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
+        if (prop->offset == ext_offset) {
+            return prop->name;
+        }
+    }
+
+    return NULL;
+}
+
 static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
 {
     const RISCVIsaExtData *edata;
@@ -747,7 +772,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
     int i = 0;
-    bool value;
+    bool value, generic_cpu;
 
     if (!visit_type_bool(v, name, &value, errp)) {
         return;
@@ -758,16 +783,28 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    generic_cpu = object_dynamic_cast(obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
+
     env->misa_ext |= profile->misa_ext;
     env->misa_ext_mask |= profile->misa_ext;
 
     for (i = 0;; i++) {
         int ext_offset = profile->ext_offsets[i];
+        bool prev_val = isa_ext_is_enabled(cpu, ext_offset);
 
         if (ext_offset == RISCV_PROFILE_EXT_LIST_END) {
             break;
         }
 
+        if (!prev_val && !generic_cpu) {
+            const char *ext_name = cpu_get_multi_ext_cfg_name(ext_offset);
+            const char *cpu_name = riscv_cpu_get_name(cpu);
+
+            error_setg(errp, "Setting profile '%s' failed: CPU %s does not "
+                       "support extension '%s'", name, cpu_name, ext_name);
+            return;
+        }
+
         isa_ext_update_enabled(cpu, ext_offset, true);
         g_hash_table_insert(multi_ext_user_opts,
                             GUINT_TO_POINTER(ext_offset),
@@ -885,9 +922,7 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
 
-    if (object_dynamic_cast(obj, TYPE_RISCV_DYNAMIC_CPU) != NULL) {
-        riscv_cpu_add_profile_prop(obj, &RVA22U64);
-    }
+    riscv_cpu_add_profile_prop(obj, &RVA22U64);
 
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(DEVICE(obj), prop);
-- 
2.41.0


