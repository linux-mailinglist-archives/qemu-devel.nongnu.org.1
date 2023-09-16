Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B597A32C7
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:46:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd2s-000562-1J; Sat, 16 Sep 2023 17:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2i-000543-1y
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:32 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2g-0000Q8-JB
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:31 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68fb7fb537dso3022530b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900489; x=1695505289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCZUgNuN/cpm5AWhhskU6xG8RA6Qz33ls/52yNT5Lro=;
 b=N/cAtsL6tpwGoqv9ja2GRcjv/vEIdtbNkM2l5nFhRF4JL6za4Xbu5nt0D+TMShGuDX
 SjHf2Km8xMN9xYJ6y8gNDpM1G/tJINlbB9AUa/q/ow2OVKAaeLoeqZzSJGSGlThOolhA
 g4rXmey2a5TZPnIogA/WyTE4jZsd5E3sZvhWxF6+kfG9RmM4YPpAi+8aFEjVw2aVrkk2
 Is3PTFPaMvHH2gDeBsZQpFcKwZN6dT09kSEyFaU/WXWGhZinx+A3s9khlx4Ky4wCB6hd
 K9jBnf4YZ0f6iLrKON80qT+wNX8WXsb8ekf5B7TFFdXD9pNn+suqC76m7/lqlzgZbqh4
 0gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900489; x=1695505289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCZUgNuN/cpm5AWhhskU6xG8RA6Qz33ls/52yNT5Lro=;
 b=dOH6fIMAzSvEgyu6/EwcZTdbrPTqb8UUwHuTjiLSLvPFKGH2MhquLwg+l9cf7mxPgS
 OirWUIHxcw17HJfo99Qqwh1BxxAnLoKW+J3EhYBT6HE1TZ9AWuBVAprDdjEj+sJvikrg
 4t9o5K30zkKTjOFs618WfE203y/Mf5BFM5SBi6YwNE5mSmSxQfgJCjJyygxVL8ARDZ3Y
 j4tC5Y3tCQ9MAEEXkjBOwqAulj/ONR1l1A0+O6IzHk+rNQGwtfz08Ot4FQZ/Q9TQIk9z
 yYOCenb2//COOhreIAUx9EPclIIHm3XkWpXgvcm2hpB18tRtoshbJiadAcoYXKER1HGc
 cf+g==
X-Gm-Message-State: AOJu0Yxdwwljh+7uGb4N742WJv4NtEgK1/OGq0fiO+RG0K9iugtesJOv
 fkb17/x0ybccp5uY6oFk337jRfpxHOPfxZf4c1A=
X-Google-Smtp-Source: AGHT+IE5Ok6nbCQcYbdzeE4F531Scfgkae4hICFOdred4LaiI2c/g59BE+2MDTLFzKz1x7l0KhcGwg==
X-Received: by 2002:a05:6a00:181b:b0:68e:3def:c3cd with SMTP id
 y27-20020a056a00181b00b0068e3defc3cdmr5675389pfa.17.1694900489105; 
 Sat, 16 Sep 2023 14:41:29 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 04/39] target/arm: Remove size and alignment for cpu
 subclasses
Date: Sat, 16 Sep 2023 14:40:48 -0700
Message-Id: <20230916214123.525796-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Inherit the size and alignment from TYPE_ARM_CPU.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 3 ---
 target/arm/cpu64.c | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b9e09a702d..d48a70c039 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2423,10 +2423,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info = {
         .parent = TYPE_ARM_CPU,
-        .instance_size = sizeof(ARMCPU),
-        .instance_align = __alignof__(ARMCPU),
         .instance_init = arm_cpu_instance_init,
-        .class_size = sizeof(ARMCPUClass),
         .class_init = info->class_init ?: cpu_register_class_init,
         .class_data = (void *)info,
     };
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f3d87e001f..811f3b38c2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -822,9 +822,7 @@ void aarch64_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info = {
         .parent = TYPE_AARCH64_CPU,
-        .instance_size = sizeof(ARMCPU),
         .instance_init = aarch64_cpu_instance_init,
-        .class_size = sizeof(ARMCPUClass),
         .class_init = info->class_init ?: cpu_register_class_init,
         .class_data = (void *)info,
     };
@@ -837,10 +835,8 @@ void aarch64_cpu_register(const ARMCPUInfo *info)
 static const TypeInfo aarch64_cpu_type_info = {
     .name = TYPE_AARCH64_CPU,
     .parent = TYPE_ARM_CPU,
-    .instance_size = sizeof(ARMCPU),
     .instance_finalize = aarch64_cpu_finalizefn,
     .abstract = true,
-    .class_size = sizeof(AArch64CPUClass),
     .class_init = aarch64_cpu_class_init,
 };
 
-- 
2.34.1


