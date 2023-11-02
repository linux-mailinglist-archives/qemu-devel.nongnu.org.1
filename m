Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 668217DEA06
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:31:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYK-0005qK-Vg; Wed, 01 Nov 2023 21:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXf-0005f3-Tr
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:40 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXc-0001YE-1T
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:39 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b2df2fb611so299494b6e.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888633; x=1699493433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8V0B4qGaX44SCne6/GgXw2vrmkaH/ySdpZ5z2aNKfw=;
 b=skqsTeK+mlne45DhxWQv1A18XpO25pScBJnTh9sD54UZTnX1gLeba1VQZDdcstaYtF
 NNQayOvtCxgpWiGX7S8FxxPvspRCo3G0ulIjQt550gLXYtMMuBoj1lquS+uUHDTtsBfs
 Jeb/YHYaxIcw4fdooQLB4sAq6/goc3NKN8n6caJe8wxWoNNNE94LWE7iPwH3MzDKrMiH
 qrmbCRaOD3W+MrE972ccsWJJ7//NCBN9nT/wW/z8weKkqN+mmqQKpRcvSf5FlnoYJPlg
 w+vf0Tb3aX/lGZrzBvTHlzY4qs2YZb57lBMikaLcFTkdE8OAJetELSlc/GzOhEgvd6+o
 e4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888633; x=1699493433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8V0B4qGaX44SCne6/GgXw2vrmkaH/ySdpZ5z2aNKfw=;
 b=k9b4vEz/TY1g65BqabvxeL4xESrJsdqVu2jYS8f7Le/3lzwr9qjHKfSeyaG0EHGM1T
 QPE8PjzcX+67+2Q5x683E8So64EH/XnLgVk7OcQeXqxZIEI1fkdT2UXwlYb4Z3rd4Wt/
 vW06MHcNU0pHpyBeyAZ2Lv9hheSCkFRgPEQOATtgcUC4RbwonzSgDRPglr9pPWLFmPis
 cPI1gZo07r8/4OBtRjvXkipuGpXgR+TdgJ/NEU7ZmjKmbv+N4MXIMN+6/MXHmLHxWDMk
 uM5pcH/4Z+xgPtcMIX3vE8f4sKjXxi4GdYy8esRnCrSjhpQUe8MMci3hxzQdmMy07kp3
 4KJA==
X-Gm-Message-State: AOJu0Yxuhkq/MHxtGmxdqDK26TRXC03YyG8eYxn3l24A6IvmZ0+BiioV
 0fl7WKuWjLTCoryU1UfVnCdNp72xwGabN8yK2M4=
X-Google-Smtp-Source: AGHT+IHnBt353wZFf7cA9estXKy5lYG6ecor7Y63GHIbuHa+FHb0S1BMYUhsTuHfU1c6cRtNNUJFIg==
X-Received: by 2002:aca:d16:0:b0:3a6:fbe3:45cf with SMTP id
 22-20020aca0d16000000b003a6fbe345cfmr19045412oin.35.1698888633444; 
 Wed, 01 Nov 2023 18:30:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 19/88] target/hppa: Introduce TYPE_HPPA64_CPU
Date: Wed,  1 Nov 2023 18:29:07 -0700
Message-Id: <20231102013016.369010-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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


