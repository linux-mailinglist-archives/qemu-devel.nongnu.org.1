Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD57F8528
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 21:25:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6cit-0001pQ-5Z; Fri, 24 Nov 2023 15:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6cii-0001p2-4q
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:13 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6cig-0005C4-IE
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:11 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so1549062a12.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 12:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700857448; x=1701462248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8Z8wJmbxe8GqrZMSuETlZ1jRJvjF/0/Y4v1dc9cYe0=;
 b=i3rm6K7M6Q4eexM05DW3W8LwEq/tPAlp4EzAHIUva+WdC3UM/6bzm+OaQeWhD1l4tH
 bFDe7Hb9JsvmIu06ClAnVcNQ5M+LZrafqpN4VgkNcPBoXtAIsLt44OJFVdSlfaZ9eST8
 Uo34dOcpoWQE7HUkpJWWQVPH0iLsvL0TWvXfz/CSqpzCcwegMu8+Atlj8tTUIZGBvuhs
 JAtAleYwQKSJsFlG3FJk04IvqWn3mF3RLzjc9K6iIprZbtleF/sh3KwpdAH+XUvbmaH6
 9+sqlLO8pcAteuyL+8iYc5cgGGtDmMynI0dn+sga3KCRihk0XPPB+XSXI0e7dMhnm8yR
 /BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700857448; x=1701462248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8Z8wJmbxe8GqrZMSuETlZ1jRJvjF/0/Y4v1dc9cYe0=;
 b=p5IzeRNj0W+MQ6H8FcSaqOIQtWUOv4JfmM5On8HQ5nXwRs1ADc0tYQwzgfmuMSh0M1
 rwA7s9rDjinJBgdhbYucxZ8O+x7BKregy5eYR7h0cq3WJD0/nBB7cQtbwAP3k51RTPmq
 1RgpCgu4x490khAGK+WB7iqVKyGI+yOiW0duMolddH28LSgHX+WCmlaP4gXQ6JuIZzl8
 H93M2ngKFaouaW9k5DDc8+ByFUQwP29jLKUBiMdNS4IrN8HP+3J7u1HQLk0cswtWPE3H
 GoUUQUPzSA5h4317yfZ1HJNhhBLXE0c9/UfsIl8JUWYG+Lfb6Qmk/qmkzpuEB+EVXaBW
 eEuA==
X-Gm-Message-State: AOJu0Yzml/1jqTCm+CvykvaF2/IuWfQN+NDxo1RkTxkErVPfEkFVb1W/
 WsDnL9oMgQEcU+fgt/FIBzRj1EuoNc0zeUJpNAs=
X-Google-Smtp-Source: AGHT+IGZgpoPQtKkQhSrVoDkfQ2n4gUFXx322Vo9I71xSRUWKSaBcn2dG3pdi/CZ0GBjqctA+2oz8w==
X-Received: by 2002:a17:902:ced2:b0:1cc:4a84:27cd with SMTP id
 d18-20020a170902ced200b001cc4a8427cdmr3956833plg.31.1700857448461; 
 Fri, 24 Nov 2023 12:24:08 -0800 (PST)
Received: from grind.. ([152.250.131.119]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1709028c9800b001c59f23a3fesm3548267plo.251.2023.11.24.12.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 12:24:08 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v12 02/18] target/riscv/tcg: do not use "!generic" CPU
 checks
Date: Fri, 24 Nov 2023 17:23:37 -0300
Message-ID: <20231124202353.1187814-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124202353.1187814-1-dbarboza@ventanamicro.com>
References: <20231124202353.1187814-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52f.google.com
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
2.41.0


