Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A41825D05
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 00:08:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLtGh-0002MH-QV; Fri, 05 Jan 2024 18:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGf-0002Lb-Ip
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:21 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGd-0002Ji-S0
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:21 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so93351b3a.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 15:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704495978; x=1705100778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDOwSw23JfN9En8duFVq8r7vK0qpnP5eiC6B3doXRi0=;
 b=a+XEgMiHBo5fM3jGoM7GDvbditdjV0QYN4Z/6L3mN1LEMYSoy9Bt9t5x4SMiJ7zo1h
 Jsf5heS/0nP8/FisrXA7cNL4IPKaG6uzqw9rjFfXR0BJL9szGwloCddrHmI+FaGHQa7V
 DFXtEguMIiIUfHvFP2vaKkdMLhXntfyxSEYmdEYoWcbJXiNcNmukXqchU53l7AN0EmS2
 EzrJhMDCReNrK/s/aFF2CrSjsAEs4JMpr7Uoo5fSlD8kf9IWa+W0pVSJGCOabKFp9NSZ
 WrtJizjT4CXlUivtSxCYHF2Doa9eR2K2J8AooZjFhLXqHaw+5a5QRVRtAzMPmMK1wiqi
 dExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704495978; x=1705100778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDOwSw23JfN9En8duFVq8r7vK0qpnP5eiC6B3doXRi0=;
 b=CPaiFBPxuYMFGBxKvwFMDiy8WdmoXBhTZW7phX662TfZ4qpFtKwWyCphRMcgw7KeUE
 oME3/+04VAAdFanYrUo6l3/9C9boeHwEG48ZogON1BMUe/ZMzMrwF326lRlUx4rLVsM5
 kua1MOmTU4ipk729LHYldXKP2HA/RSABPxQOG/yYOPvAwCvDtkFNXL16tMWy80SLQTKE
 Zf6Qe0mmHTbMtI3KBWg2t6ELJfJrK4SR3mbxKJHw+kvuH3SUbCWfPEb1O8ihi+fdxMnj
 kFcSHZJp3x+kmL5c5hgTexYkojM1GeEtiIZvk1K3cDX+QLBrTzgz+0Xbb5P4HoI69r98
 OF3Q==
X-Gm-Message-State: AOJu0YynkBf0IpgxKUMEOFDhkqQiNPT9F4ejUR4H+Jjv6QEfGQLtmcJn
 rmlw2k1BpyhoIaYwJex+LwRZ34p08fI66daztxsYawImMBLTHA==
X-Google-Smtp-Source: AGHT+IHfob1dZk/iKoCnNXTmtBIA16Qlume7557J4dIghdu2QxRYJtIZP+9iSVUW6DiNG14uI7OTZw==
X-Received: by 2002:a05:6a20:1a86:b0:197:15b3:63eb with SMTP id
 ci6-20020a056a201a8600b0019715b363ebmr58161pzb.115.1704495977803; 
 Fri, 05 Jan 2024 15:06:17 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.127.254])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006dacfab07b6sm1849249pfd.121.2024.01.05.15.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 15:06:17 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 08/17] target/riscv: move 'vlen' to riscv_cpu_properties[]
Date: Fri,  5 Jan 2024 20:05:37 -0300
Message-ID: <20240105230546.265053-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105230546.265053-1-dbarboza@ventanamicro.com>
References: <20240105230546.265053-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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

Turning 'vlen' into a class property will allow its default value to be
overwritten by cpu_init() later on, solving the issue we have now where
CPU specific settings are getting overwritten by the default.

Common validation bits are moved from riscv_cpu_validate_v() to
prop_vlen_set() to be shared with KVM.

And, as done with every option we migrated to riscv_cpu_properties[],
vendor CPUs can't have their 'vlen' value changed.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 45 +++++++++++++++++++++++++++++++++++++-
 target/riscv/tcg/tcg-cpu.c |  5 -----
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a4e5863de7..fd55064c3b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -29,6 +29,7 @@
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "hw/qdev-properties.h"
+#include "hw/core/qdev-prop-internal.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
 #include "sysemu/kvm.h"
@@ -1307,6 +1308,7 @@ static void riscv_cpu_init(Object *obj)
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
+    cpu->cfg.vlen = 128;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1777,8 +1779,47 @@ static const PropertyInfo prop_vext_spec = {
     .set = prop_vext_spec_set,
 };
 
+static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!is_power_of_2(value)) {
+        error_setg(errp, "Vector extension VLEN must be power of 2");
+        return;
+    }
+
+    if (value != cpu->cfg.vlen && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.vlen);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.vlen = value;
+}
+
+static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.vlen;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_vlen = {
+    .name = "vlen",
+    .get = prop_vlen_get,
+    .set = prop_vlen_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
     DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
 
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
@@ -1867,6 +1908,8 @@ static Property riscv_cpu_properties[] = {
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
 
+    {.name = "vlen", .info = &prop_vlen},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 0fb054b20e..71a364453e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -298,11 +298,6 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
-    if (!is_power_of_2(cfg->vlen)) {
-        error_setg(errp, "Vector extension VLEN must be power of 2");
-        return;
-    }
-
     if (cfg->vlen > RV_VLEN_MAX || cfg->vlen < 128) {
         error_setg(errp,
                    "Vector extension implementation only supports VLEN "
-- 
2.43.0


