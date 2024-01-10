Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD6A829594
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:01:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUSW-0002bj-3C; Wed, 10 Jan 2024 04:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSR-0002OO-2c
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:07 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSO-0005JE-Sb
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:06 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bc4f49a3b6so4329472b6e.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877263; x=1705482063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AuwbvXoXpkp8xXa3JRbnEESPuSBVsvJlTH7G2Pi1/o4=;
 b=civtQnjIlKPHoe5/9K6ulcxJjfouGmpIbEbGAHuAY6dk9FTVpTawliWB4bD9jcy6ke
 z/4dLpl/vf7RXnTFaPHKnnWrJSVso8erTEbO52FrFpscz3A2s0VG+HvdVTlCPV+jwY5K
 Qi5JsNcMM/cTmtdcY+35Gg5ScutGWpcwixlAjqGb93r8Zwq9atorjJnAz74gMvtIz//v
 XWp4jI+gLOxI3IfGMomudvjkhE/HIUltJqLS98mxRyoMAaO+p828S93ebl0Ekmgr7wZM
 jvAsWtd4BMcUBVvkU1WNDOZzlm0Wqroou1/9vd6HEa2rO/xAQkiwa6jOE4BhrCWea6w3
 u/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877263; x=1705482063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AuwbvXoXpkp8xXa3JRbnEESPuSBVsvJlTH7G2Pi1/o4=;
 b=Lm0cYzgPaxjt8ZFJXB24jUQtJIDhqZOQnUTyt+8mTCtmtK29VrYON1eRbvMAltaenP
 9ZlST1Kl8RDu3tQdVzGkfC00DytOOGUG0yy2RW0n8vdU1GrYiaRBQfefMZ9wU2f4ZFI+
 a0Z+FJ/Ge2ulYO6590/9alBVfLnfN08yGed++vjl/FE3DNufneAEprHzTMRRwWPzxkh/
 rMXX/UvjY9VFLyFtvL7xfN/xwEvSCuwccnEFwUGD5Xo4bbAsof9pN3trU7AkW8ji4Qbe
 PgvMES5EMANc9fcYvZatr3DYLhDXjrYXJhw2Gc73yyuOjLnfVbzmN22XamS9vJeJkpnj
 M1cA==
X-Gm-Message-State: AOJu0YyLtzVYNT4Ao49K+deZ9l2d5ytu6qpJwXvhWWfddz8oE+h+y9tA
 r08YA/qoVrQ+NYSRUBWcx1obeExGnUiUtJaW
X-Google-Smtp-Source: AGHT+IGAepqjiTxBpbK+GzaFXDMIJJLKy8aWdM0eAmw92vyPcT4S6GXPkmSB159zUeCOatlJnZ0z8A==
X-Received: by 2002:a05:6808:1489:b0:3bc:641f:c7f7 with SMTP id
 e9-20020a056808148900b003bc641fc7f7mr1024720oiw.8.1704877263030; 
 Wed, 10 Jan 2024 01:01:03 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:02 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 52/65] target/riscv: add 'parent' in profile description
Date: Wed, 10 Jan 2024 18:57:20 +1000
Message-ID: <20240110085733.1607526-53-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Certain S-mode profiles, like RVA22S64 and RVA23S64, mandate all the
mandatory extensions of their respective U-mode profiles. RVA22S64
includes all mandatory extensions of RVA22U64, and the same happens with
RVA23 profiles.

Add a 'parent' field to allow profiles to enable other profiles. This
will allow us to describe S-mode profiles by specifying their parent
U-mode profile, then adding just the S-mode specific extensions.

We're naming the field 'parent' to consider the possibility of other
uses (e.g. a s-mode profile including a previous s-mode profile) in the
future.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-25-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/cpu.c         |  1 +
 target/riscv/tcg/tcg-cpu.c | 14 +++++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 136030434e..5f3955c38d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -77,6 +77,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit);
 #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
 
 typedef struct riscv_cpu_profile {
+    struct riscv_cpu_profile *parent;
     const char *name;
     uint32_t misa_ext;
     bool enabled;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1aeb0fee1b..616b091303 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1539,6 +1539,7 @@ Property riscv_cpu_options[] = {
  * having a cfg offset) at this moment.
  */
 static RISCVCPUProfile RVA22U64 = {
+    .parent = NULL,
     .name = "rva22u64",
     .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
     .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a0a3350e3e..14133ff665 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -802,7 +802,7 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
     CPURISCVState *env = &cpu->env;
     const char *warn_msg = "Profile %s mandates disabled extension %s";
     bool send_warn = profile->user_set && profile->enabled;
-    bool profile_impl = true;
+    bool parent_enabled, profile_impl = true;
     int i;
 
 #ifndef CONFIG_USER_ONLY
@@ -855,6 +855,13 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
     }
 
     profile->enabled = profile_impl;
+
+    if (profile->parent != NULL) {
+        parent_enabled = object_property_get_bool(OBJECT(cpu),
+                                                  profile->parent->name,
+                                                  NULL);
+        profile->enabled = profile->enabled && parent_enabled;
+    }
 }
 
 static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
@@ -1112,6 +1119,11 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
     profile->user_set = true;
     profile->enabled = value;
 
+    if (profile->parent != NULL) {
+        object_property_set_bool(obj, profile->parent->name,
+                                 profile->enabled, NULL);
+    }
+
     if (profile->enabled) {
         cpu->env.priv_ver = profile->priv_spec;
     }
-- 
2.43.0


