Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7617E3371
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:05:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COj-0007Zu-Ta; Mon, 06 Nov 2023 22:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0006fV-97
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:38 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO6-0000fM-V5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:24 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5aa481d53e5so3499534a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326261; x=1699931061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8V0B4qGaX44SCne6/GgXw2vrmkaH/ySdpZ5z2aNKfw=;
 b=EPALSYUQsUPoThWrjPnnDxlpgXy1VOEJTBAclESaL1dw9c7y1w7+0QbEVC73slWQlQ
 4/3PaGzB4W9GJ+TRVWI21MZaWCpsBN+LTGcgWNpxWFjAi51dUXi4I5jb5uUjTauypYl4
 tEmhWATUIyVtkwGjO1q8Ejrhm3duBcy0UhZ4itAa7vIt7e8gOFlXJ8C95YL+/XbIjFX2
 9bpQlShfg9H6Hy1G82l/buLTm2JWwjdi2jDpMxpNApaACpltL4FhGBwQzZi49bcd0TKi
 5uxV/byjxQP6tpq71dkBKgnvshHox7oK1o7SonUzVFy+oI9UZrTPYQ7agwApwGHJyos+
 9UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326261; x=1699931061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8V0B4qGaX44SCne6/GgXw2vrmkaH/ySdpZ5z2aNKfw=;
 b=N0AZoJotpSuwIoiqk6YjFHzeD/EHt91SZMXX5LO3ayMxhCibCWFJ3CPX52okqjit3G
 p4TP+ZrTBIDhmCIo1JshzoBPXEoZnHlrPYAgay4hA9UeByQy5DwCeOtkKOc56aKaPaHq
 2bX0koZKuGKRoHZWXblzx1QO5dY8lIKjSc2V6IaAjjBsFTFIAvgNRAI/bMK+EESW/a25
 rIowzLZ40T45UqCQpjVDbEgaoN7fVG39TrZj4FrC/yZpjwxQCCRQ9IjGqiSAhVqY4gAw
 2JBiMTajLtdMx6GHJIGavpyzLgAFtCypTcozR6CSZKQMg5X2H6veCmcy4fndenW1JYZg
 nmmA==
X-Gm-Message-State: AOJu0YxaGQl4gombM6KGngJsCIXCEBCv9zg9o46CmXWAMT4fQkO5MpVx
 mCqO8oocBfFoR1IRaEbzwmXjHKMOvHJMX6mtZnU=
X-Google-Smtp-Source: AGHT+IGeiI3eIHmNEkx9uPJpH85Z7cfN2n3KMue8Ppnk/KyAdjWUHlAO3LLx8cAUlXP4ibJTL3Q2cw==
X-Received: by 2002:a05:6a20:7da1:b0:15c:fa48:2c09 with SMTP id
 v33-20020a056a207da100b0015cfa482c09mr31743427pzj.15.1699326261553; 
 Mon, 06 Nov 2023 19:04:21 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/85] target/hppa: Introduce TYPE_HPPA64_CPU
Date: Mon,  6 Nov 2023 19:02:59 -0800
Message-Id: <20231107030407.8979-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Prepare for the qemu binary supporting both pa10 and pa20
at the same time.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu-qom.h   |  1 +
 target/hppa/cpu.h       |  5 +++++
 target/hppa/cpu.c       | 33 ++++++++++++++++++---------------
 target/hppa/translate.c |  2 ++
 4 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
index b96e0318c7..4a85ebf5e0 100644
--- a/target/hppa/cpu-qom.h
+++ b/target/hppa/cpu-qom.h
@@ -24,6 +24,7 @@
 #include "qom/object.h"
 
 #define TYPE_HPPA_CPU "hppa-cpu"
+#define TYPE_HPPA64_CPU "hppa64-cpu"
 
 OBJECT_DECLARE_CPU_TYPE(HPPACPU, HPPACPUClass, HPPA_CPU)
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 08de894393..0ac307e0e9 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -272,6 +272,11 @@ struct ArchCPU {
 
 #include "exec/cpu-all.h"
 
+static inline bool hppa_is_pa20(CPUHPPAState *env)
+{
+    return object_dynamic_cast(OBJECT(env_cpu(env)), TYPE_HPPA64_CPU) != NULL;
+}
+
 static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 5e1240c631..07fae42bb8 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -209,20 +209,23 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     cc->tcg_ops = &hppa_tcg_ops;
 }
 
-static const TypeInfo hppa_cpu_type_info = {
-    .name = TYPE_HPPA_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(HPPACPU),
-    .instance_align = __alignof(HPPACPU),
-    .instance_init = hppa_cpu_initfn,
-    .abstract = false,
-    .class_size = sizeof(HPPACPUClass),
-    .class_init = hppa_cpu_class_init,
+static const TypeInfo hppa_cpu_type_infos[] = {
+    {
+        .name = TYPE_HPPA_CPU,
+        .parent = TYPE_CPU,
+        .instance_size = sizeof(HPPACPU),
+        .instance_align = __alignof(HPPACPU),
+        .instance_init = hppa_cpu_initfn,
+        .abstract = false,
+        .class_size = sizeof(HPPACPUClass),
+        .class_init = hppa_cpu_class_init,
+    },
+#ifdef TARGET_HPPA64
+    {
+        .name = TYPE_HPPA64_CPU,
+        .parent = TYPE_HPPA_CPU,
+    },
+#endif
 };
 
-static void hppa_cpu_register_types(void)
-{
-    type_register_static(&hppa_cpu_type_info);
-}
-
-type_init(hppa_cpu_register_types)
+DEFINE_TYPES(hppa_cpu_type_infos)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ed88f724ce..44c9911720 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -262,6 +262,7 @@ typedef struct DisasContext {
     int mmu_idx;
     int privilege;
     bool psw_n_nonzero;
+    bool is_pa20;
 
 #ifdef CONFIG_USER_ONLY
     MemOp unalign;
@@ -4091,6 +4092,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     ctx->cs = cs;
     ctx->tb_flags = ctx->base.tb->flags;
+    ctx->is_pa20 = hppa_is_pa20(cpu_env(cs));
 
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = MMU_IDX_TO_PRIV(MMU_USER_IDX);
-- 
2.34.1


