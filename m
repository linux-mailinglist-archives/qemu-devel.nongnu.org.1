Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0409E7B6FF1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:37:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjF0-0008QZ-Cv; Tue, 03 Oct 2023 13:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEj-0008G7-Ip
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:17 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEh-0007T1-S8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:09 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-69101022969so916207b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354266; x=1696959066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCZUgNuN/cpm5AWhhskU6xG8RA6Qz33ls/52yNT5Lro=;
 b=SBeFhS8XDBnTAI+bDubLC0+qVbUwpta9ojpB3Hnw4C4P+hS0UpnZ7jwIcnuDwQ6SGP
 ezNh/vRiqJiPlkQYPW4gK5NVOIZvaqc61gJJTALkFpqp5GChW9IIFD3zwANYWe9aK6hX
 KD3NEuN1Qiz2IefoobGpbY7yObdFAISpT3Z+6L+jF+wSQE3afXad4FAxXlcup0wGjS0P
 kpP/ICAIptkHI2oh7XLv5T2tBv0tNHDsBTtXHechM/hy1TM/suWM3gmmoPsWSMrKTiI+
 GsfVoDb/RZYL7xofEWU6D/DTIB4pUj8kxYbjbcp255Dob/U085hgOiy9MsVKDh31rb9B
 k3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354266; x=1696959066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCZUgNuN/cpm5AWhhskU6xG8RA6Qz33ls/52yNT5Lro=;
 b=kQtar9J+n4I7ECoUBncZUk2PMEgYwEcEyGpQRFN8wWTIfwHnrHIDTV8hhiDz0MCOTZ
 TR/5c0+SlefkMZ1WmqGimKwp8BzwVfq1xkOBLTC45JXul/TfkfO6lhJQR7rZ+gsSpaLH
 klSgS6CPN6j8IRJT6gnzsOmJI6XxwtEvbGitFx+CFRg5yiZLNwgKI71EDWqRx/mvhmSh
 4yxdo7BAw5Fr/KaVcdITKmepS95nAjs0+x7UtBH/Skbuf3zDpZa3vR6kogFxrkQTc9Ul
 fp5ei3pcpdKDQUuuxy3bGIwBiaFkQ6LVMY3MZPoFD021vMirjIz0IvxG36xygBmrhO8F
 qU6g==
X-Gm-Message-State: AOJu0YxlkpE9rMDm+gF9UCm3zJlqElneUevrsLGw2peisUMpc/NJmTqB
 OZI3DdQ8kdNhvAZ/m4if9YCfj47o43XfoQFOUko=
X-Google-Smtp-Source: AGHT+IE3Fx6G4Fi9EBUJbon4tQCukkLCqdH59J2vqesvlONPmZX7Dhzf/32w4ZHnAr3mfoqPCZwHXA==
X-Received: by 2002:a05:6a00:1912:b0:690:d2b0:1b37 with SMTP id
 y18-20020a056a00191200b00690d2b01b37mr301688pfi.10.1696354266239; 
 Tue, 03 Oct 2023 10:31:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/47] target/arm: Remove size and alignment for cpu subclasses
Date: Tue,  3 Oct 2023 10:30:16 -0700
Message-Id: <20231003173052.1601813-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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


