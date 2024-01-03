Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9113D8233B2
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:46:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5Ep-000547-4q; Wed, 03 Jan 2024 12:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5Eb-0003Yp-Vq
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:40:54 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5Ea-0001gq-4O
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:40:53 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9bec20980so2787927b3a.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704303650; x=1704908450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lf45moVsB1V70aKXjn6Z7X3nShbqPvle7BNNm9DCtHg=;
 b=o7uRFLJuwmA6xPussQvKXvl5DoCJ8zqZkh3E5hcYVdzFYv2NMR6ktR/8orucvlj2yU
 Curs8ouC/Gdi/2BVED5vrX7AioFSCEJgCmZwGR7YKGygs8qCBWKswihILTZQ5E4sBiIL
 V+DCSst6dUQbl7V4Qo2alNTJ15Xbt9RQCWH7Vh/r7FYfw/60pwHRZ0+tVypB33pGhtNW
 5uH9N96KIbVXx6wEFbP39JhMDiJul7BFoPGoeeRCFehmvv7SN8Ph9GyrhsyLUKm6F7zP
 AX6VJpLk/XSJWQcJauSjBoDnaLEEW5Zj7cGNveHidmVN21ijaRDZHg1YdgeegzXgxGw5
 f25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303650; x=1704908450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf45moVsB1V70aKXjn6Z7X3nShbqPvle7BNNm9DCtHg=;
 b=o0j7DhH8E0Dg7+1QD0AMFo740vzfXLhy6Iw3u6+/ZdhK2iSFoSIG7U0P73Crfysgrd
 Hhavhs+LlShJ+ru4SvM6OdzXOrXq2xyTigfwDyhfkAxxhwIcN5sYGOyXZMzEHQaX6W1C
 isqNRd4O7nrZuf+TE/J/R7OLO5VgNNUymnH0hUAS+dLZChUBxpHByMFDdwV1ThIf0G25
 DXFfSPEvCQFSQvNFLxqY5Rqpe6y1Gm7T3M1EGE5EX/mBa3Vfxl4iwhhp+F/52zPgMN4p
 lDuszlxwajpbP333hRveE4oHEmnzK9eSIRYAy+68C9nDSdVGAgGsOBjHm5OVxl/rHw/f
 F00Q==
X-Gm-Message-State: AOJu0Yz89OXR2nTABBFtqQhuf6PpviCgYrTA2ScuwVn3xIo1V9mzNffj
 qhHcX9K/nIKKjIiQuyZkOllBuCFsblnisCAUUeV0PKdJsjI6BA==
X-Google-Smtp-Source: AGHT+IFCMVDzevNCf3ERFrj0IupnV83wOk+utnq2Tr9ry5eB+7TTwLTkwdsUZ9kyFt8RabE1QaLYJg==
X-Received: by 2002:a05:6a00:26e3:b0:6d9:9edd:60a0 with SMTP id
 p35-20020a056a0026e300b006d99edd60a0mr6252093pfw.46.1704303649915; 
 Wed, 03 Jan 2024 09:40:49 -0800 (PST)
Received: from grind.. ([189.79.21.107]) by smtp.gmail.com with ESMTPSA id
 v3-20020aa78503000000b006d7f1ae421csm24042050pfn.145.2024.01.03.09.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:40:49 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, vladimir.isaev@syntacore.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 08/16] target/riscv: move 'vlen' to riscv_cpu_properties[]
Date: Wed,  3 Jan 2024 14:40:05 -0300
Message-ID: <20240103174013.147279-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103174013.147279-1-dbarboza@ventanamicro.com>
References: <20240103174013.147279-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
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
---
 target/riscv/cpu.c         | 45 +++++++++++++++++++++++++++++++++++++-
 target/riscv/tcg/tcg-cpu.c |  5 -----
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c39da44f51..557874a017 100644
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
@@ -1267,6 +1268,7 @@ static void riscv_cpu_init(Object *obj)
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
+    cpu->cfg.vlen = 128;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1733,8 +1735,47 @@ static const PropertyInfo prop_vext_spec = {
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
@@ -1755,6 +1796,8 @@ static Property riscv_cpu_properties[] = {
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
 
+    {.name = "vlen", .info = &prop_vlen},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 6501c29d8e..8ec858e096 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -178,11 +178,6 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
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


