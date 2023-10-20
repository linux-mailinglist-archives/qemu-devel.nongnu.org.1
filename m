Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C9E7D1794
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLt-0007pd-VD; Fri, 20 Oct 2023 16:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLW-0007jR-GE
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:54 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLS-0008AP-Mz
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso1217919b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834625; x=1698439425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+gAls5QIov6whAU2ymHpvhxd4z68DFwK7+v+pcFR8U=;
 b=UC1E1T0QoBTZaYUaS/aVXB1qWv4b6R559A+euFUfEW1Ukygv+BpAxtlgjfc0QmV7oS
 4ZenXhxFLs2bw/7NhNcMFQJboU+xirzc943ZkJJOhuLYK9UwPhefWMkfxxHsmvPIzWpg
 H95HCBYx9Pouh5K9QDFere82+g2tvXUyhPvovPzFDS034JnPEzjlDN/WUwfuezuyrqNg
 4ttYpZEPAuhCKH9aIMj6IuYAss3Q6GSrnBsymOC1P6v7VH/NWZtLk29d+99wcRagwn/T
 HlP3cEC/BBE8MM0M3Qa4piFWK55IeLlY/WGItkWRpWjJr8xucjnZHb/UKb32mMezjU6V
 OpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834625; x=1698439425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+gAls5QIov6whAU2ymHpvhxd4z68DFwK7+v+pcFR8U=;
 b=JbTJtJyLhcO9zxfl43jNxuyk6b2N39NRAd5KE92wTDG3Hs/9g/X3HWaJtpHV5mMnP+
 61g6m69ySQf2dpeRKd4lMJ/UosLDQt4nRHrm89ppaHDaGI8sNKZRv5K5LsCER8P/u1AL
 KHjFxAGYOSvztogSbBkeLSqbZhZA8Dc15u7RCjv5X/3iy3dUqbQPm4iFS7X9YwQiXV5b
 skEOPJ8V1efppo0FSsTuMYwXwdOuIoM4784F1y1TDzHfMs5VnqOVUfTWZsSbp83PInjr
 zCD+DEMsCxVViad6jde3aO4I0ILa5MImRd6bC/CjdKIRSH/7PgQ8Lq8BKvy16Det2+z6
 /AUg==
X-Gm-Message-State: AOJu0YxI24rOnuA8Pw+dtRVKmuXIwzapTGqKl2kUL8FSOpX07Y5uqV4b
 MnAGvhuQhcR9ntQth9cML96tKj9KA3M88nd0vbE=
X-Google-Smtp-Source: AGHT+IE01Q9dMV3mRB2iqWgjHRyHUerWOS5i7FmtpEE73CEgg/wnWe3rZEozr/q7gAeGVi7C6dHk7A==
X-Received: by 2002:a05:6a20:3950:b0:17c:d4f0:87e0 with SMTP id
 r16-20020a056a20395000b0017cd4f087e0mr733413pzg.53.1697834625141; 
 Fri, 20 Oct 2023 13:43:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 13/65] target/hppa: Introduce TYPE_HPPA64_CPU
Date: Fri, 20 Oct 2023 13:42:39 -0700
Message-Id: <20231020204331.139847-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Prepare for the qemu binary supporting both pa10 and pa20
at the same time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu-qom.h   |  1 +
 target/hppa/cpu.h       |  5 +++++
 target/hppa/cpu.c       | 34 +++++++++++++++++++---------------
 target/hppa/translate.c |  2 ++
 4 files changed, 27 insertions(+), 15 deletions(-)

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
index 798d0c26d7..6995eb69ef 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -243,6 +243,11 @@ struct ArchCPU {
 
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
index 1644297bf8..192aae268d 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -207,20 +207,24 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
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
+        .instance_init = hppa64_cpu_initfn,
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
index f86ea9b9ca..83115c944b 100644
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


