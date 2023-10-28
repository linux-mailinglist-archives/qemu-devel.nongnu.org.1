Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E87DA605
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 10:56:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwf5y-0000OO-IE; Sat, 28 Oct 2023 04:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf5x-0000O1-GK
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:55:01 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf5w-0004Ad-2N
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:55:01 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a822f96aedso23138567b3.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698483297; x=1699088097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NI20rM6nM2dO3qAwOXEKQk9SU7yig3RRVjtt6eagMZ4=;
 b=Qvn3knfDCVfThje9i/MAZsrSM1HZpTZKLWgkBBTLdj/LJZMgxyIBluSsqh/8dvNe/K
 sEnUu7E71qWGSwlB/y4B+w19H3e+I9LR4ZzWgeuAlh3UwsJ4cJEq/Tatx0b1BDPO0Qr9
 1CogQlwuCtMXmgxYIRYFfzvZiNO9kdu60QaGY1dh463gUipLx3QSW8itucHiE7VDpGhV
 veLLK6+WQU8X/22d3C/lO9pPt8CGn/UjeP/T4i5swqqADOMtg97Co62uC6/RPoV6a7xM
 YiqPmFz38FjzN2cyJM1vDdvlEE4CVEsDx86es/n79AjaFeaAS2xyvU6NSEjIXzVwQ3uo
 fTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698483297; x=1699088097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NI20rM6nM2dO3qAwOXEKQk9SU7yig3RRVjtt6eagMZ4=;
 b=bh+CRpuI1ID1JTfsK9xbSQOZyNc6b4Gd742SoPyUg7hi5FNwU9Wh/L5NSjNK4rY6JS
 YclqnDIRANWDGIuPidSgAogNfxOHEiLXjj1FmhnRNghXQozei8XL9rco1NJaeqyPAweT
 7/rJq/qqS3COKr9dVzZ+rceV9SB6CfhimgU5iv/RwyZsIdZ2Y3Uqkq6z190AbrOiLmYV
 YgV2fvLfgCQjRR0i8z9x0dbb3xK5BvcDC0DBWt6e8fR5jp+wynC8NSeK9kVfzOk5HSXR
 /eYxgSsd/LoaGB+hy6Uqgbow6lDYsySo9pZUJ9JYhJ74cNF//aaQoFLQdC9seukilTim
 QtVw==
X-Gm-Message-State: AOJu0YxmI3N4vsHu+c9kGwizWzWnAXXUHJZljiH2KfxsmkMb97tOZg2d
 6yu6m3Qsc/1jH53zuNswwK/5hVgeBa1ZPbBCqCY=
X-Google-Smtp-Source: AGHT+IGyIyV/HI21zGdn6fkK/AZXSahu54Ef6yl4p6eDuq8+4de903Be5hxZ7B1Zz8ruAXF8K/cv9g==
X-Received: by 2002:a81:b606:0:b0:5ac:d1c1:bd8d with SMTP id
 u6-20020a81b606000000b005acd1c1bd8dmr4698443ywh.39.1698483297391; 
 Sat, 28 Oct 2023 01:54:57 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.255.2.33])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a81830f000000b00594fff48796sm1604325ywf.75.2023.10.28.01.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 01:54:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 08/12] target/riscv/tcg: add riscv_cpu_write_misa_bit()
Date: Sat, 28 Oct 2023 05:54:23 -0300
Message-ID: <20231028085427.707060-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231028085427.707060-1-dbarboza@ventanamicro.com>
References: <20231028085427.707060-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112b.google.com
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

We have two instances of the setting/clearing a MISA bit from
env->misa_ext and env->misa_ext_mask pattern. And the next patch will
end up adding one more.

Create a helper to avoid code repetition.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 44 ++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e98953aabf..910360ce37 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -42,6 +42,20 @@ static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
                                  GUINT_TO_POINTER(ext_offset));
 }
 
+static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
+                                     bool enabled)
+{
+    CPURISCVState *env = &cpu->env;
+
+    if (enabled) {
+        env->misa_ext |= bit;
+        env->misa_ext_mask |= bit;
+    } else {
+        env->misa_ext &= ~bit;
+        env->misa_ext_mask &= ~bit;
+    }
+}
+
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -706,20 +720,14 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value) {
-        if (!generic_cpu) {
-            g_autofree char *cpuname = riscv_cpu_get_name(cpu);
-            error_setg(errp, "'%s' CPU does not allow enabling extensions",
-                       cpuname);
-            return;
-        }
-
-        env->misa_ext |= misa_bit;
-        env->misa_ext_mask |= misa_bit;
-    } else {
-        env->misa_ext &= ~misa_bit;
-        env->misa_ext_mask &= ~misa_bit;
+    if (value && !generic_cpu) {
+        g_autofree char *cpuname = riscv_cpu_get_name(cpu);
+        error_setg(errp, "'%s' CPU does not allow enabling extensions",
+                   cpuname);
+        return;
     }
+
+    riscv_cpu_write_misa_bit(cpu, misa_bit, value);
 }
 
 static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
@@ -763,7 +771,6 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
-    CPURISCVState *env = &RISCV_CPU(cpu_obj)->env;
     bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
@@ -784,13 +791,8 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
                             NULL, (void *)misa_cfg);
         object_property_set_description(cpu_obj, name, desc);
         if (use_def_vals) {
-            if (misa_cfg->enabled) {
-                env->misa_ext |= bit;
-                env->misa_ext_mask |= bit;
-            } else {
-                env->misa_ext &= ~bit;
-                env->misa_ext_mask &= ~bit;
-            }
+            riscv_cpu_write_misa_bit(RISCV_CPU(cpu_obj), bit,
+                                     misa_cfg->enabled);
         }
     }
 }
-- 
2.41.0


