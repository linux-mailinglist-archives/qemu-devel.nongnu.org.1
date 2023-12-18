Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B5D816EC9
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:55:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD8B-0002ZT-4e; Mon, 18 Dec 2023 07:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD88-0002ZB-Rw
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:53:56 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD86-0004ox-Bk
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:53:56 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d3cfb1568eso1739405ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904032; x=1703508832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlqbuNkADGSfEKM3di30rI9t6F63PTrOxuRlEv1xmF0=;
 b=ZnvdE8VroM+NV3d3DeBmaE/XWALjDFX1LSjuGs5RDPcDdCq7E1si7rCN53fS080vYD
 B75SgzSG4DzIEoE8PpN2X+6j5oK6DKyNUEAEjM/AS8erMXWkBNYzHWrqs4wsRSwQCGcG
 wk9+mAA6aig8BxJHampiB64+3i0KutSd/URzeon5HSgTp0A+9t9ughqMXtF4S0UDH93h
 ukLH1EO2sbUM+BiyTXcDVnfz0SbsVzIMbj9B+OcUFwMFO71DEWoz63DV7RaPepIG8wCm
 rGEWiZuOl/o93nHWsvhViJllUsnUz8u9jtGgr3ayyHnTQCe5fWFD+ADh2BKWbPmI6Tz7
 mFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904032; x=1703508832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlqbuNkADGSfEKM3di30rI9t6F63PTrOxuRlEv1xmF0=;
 b=YQQFfj2qUxd7AwrIVcg/pZOJ+GSlvJ5pY3ncZypwtwpc9b2e0o8W0k0mYSaA/W9Zu5
 E2kC0cOyjbyoG5Mi8GaSNsWfdPXfwGS2Cf/bTrMYUaODBh1BrEEbKe3QNsegR2KIqev1
 OUD352mvEZs56DawfpsDNSZXM1IDuatyDCRr7uJXzuzC9NFwgj1pHaGJQkvkcaD43zxh
 Ax1O1VXGEhzwmXtDkRx7oAqEdH4cnGRuoe3ANeUfR7F+GhkvmILpCpapCP7Ml7koHJgZ
 U6xxttzBKviE3l1XJvaE90r7g8w4T6ZHCoUN9f2M5cuBA2NdxQJodUTKxOI9TIWbXfho
 0nvw==
X-Gm-Message-State: AOJu0YwjNJWo0ToxBkQNQoXFRK2Ipep/PAQOtcs31pgxAT+lUbh8x1So
 n9k+fB88bX3tx96wIn/akJ2S7Qqm5u2DY4jVtP4=
X-Google-Smtp-Source: AGHT+IEZfMimuSpini23HyCOSPVXd6Sb1LBwezcIkCpKwgXbLe5gGVxqLagPqQ3KplL7TDYNqFwBuA==
X-Received: by 2002:a17:902:bd88:b0:1d0:4706:60fc with SMTP id
 q8-20020a170902bd8800b001d0470660fcmr15725662pls.17.1702904032506; 
 Mon, 18 Dec 2023 04:53:52 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:53:52 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v13 02/26] target/riscv/tcg: do not use "!generic" CPU checks
Date: Mon, 18 Dec 2023 09:53:10 -0300
Message-ID: <20231218125334.37184-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218125334.37184-1-dbarboza@ventanamicro.com>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

Our current logic in get/setters of MISA and multi-letter extensions
works because we have only 2 CPU types, generic and vendor, and by using
"!generic" we're implying that we're talking about vendor CPUs. When adding
a third CPU type this logic will break so let's handle it beforehand.

In set_misa_ext_cfg() and set_multi_ext_cfg(), check for "vendor" cpu instead
of "not generic". The "generic CPU" checks remaining are from
riscv_cpu_add_misa_properties() and cpu_add_multi_ext_prop() before
applying default values for the extensions.

This leaves us with:

- vendor CPUs will not allow extension enablement, all other CPUs will;

- generic CPUs will inherit default values for extensions, all others
  won't.

And now we can add a new, third CPU type, that will allow extensions to
be enabled and will not inherit defaults, without changing the existing
logic.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8a35683a34..7670120673 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -663,6 +663,11 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
 }
 
+static bool riscv_cpu_is_vendor(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_VENDOR_CPU) != NULL;
+}
+
 /*
  * We'll get here via the following path:
  *
@@ -731,7 +736,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
     target_ulong misa_bit = misa_ext_cfg->misa_bit;
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    bool generic_cpu = riscv_cpu_is_generic(obj);
+    bool vendor_cpu = riscv_cpu_is_vendor(obj);
     bool prev_val, value;
 
     if (!visit_type_bool(v, name, &value, errp)) {
@@ -745,7 +750,7 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
     }
 
     if (value) {
-        if (!generic_cpu) {
+        if (vendor_cpu) {
             g_autofree char *cpuname = riscv_cpu_get_name(cpu);
             error_setg(errp, "'%s' CPU does not allow enabling extensions",
                        cpuname);
@@ -850,7 +855,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
 {
     const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
     RISCVCPU *cpu = RISCV_CPU(obj);
-    bool generic_cpu = riscv_cpu_is_generic(obj);
+    bool vendor_cpu = riscv_cpu_is_vendor(obj);
     bool prev_val, value;
 
     if (!visit_type_bool(v, name, &value, errp)) {
@@ -874,7 +879,7 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value && !generic_cpu) {
+    if (value && vendor_cpu) {
         g_autofree char *cpuname = riscv_cpu_get_name(cpu);
         error_setg(errp, "'%s' CPU does not allow enabling extensions",
                    cpuname);
-- 
2.43.0


