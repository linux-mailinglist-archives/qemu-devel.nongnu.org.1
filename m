Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6187A32A0
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:43:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd2n-00055o-LL; Sat, 16 Sep 2023 17:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2j-00054V-8o
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2h-0000QO-9u
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-690471b5889so1422291b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900490; x=1695505290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CL2g+I/aYKhCYdCOqJipcnPRCNs8rgqlHMh/Z1brbrI=;
 b=PScSqbZ5qOtn45VoD1eVhb6WXLAfcsWephuqLN3xvgP2o8GWjgusVQdLHW1K8d/qy9
 PwpATw7S5vwqLDQW3auB5QQPF/n3HIu6Vy7A0VZOf2NUtT5LXBcuky0jBGZaUdLS/uZe
 O4XkZNVvsyZXmaz6b3HQHDHAdrcQsITIcYynBkGKJi9Wh91ihra45l0vB46aYItr+3k7
 iwAp8t0N0WeGN4RAS839ubIcWiilxmZlA1zRC8RCA+sXBzEMjxKkmJ+XIfevaZh6Ijgq
 XrLAs2GSDIW5N1DAc+pXVk2TIZAS9FFWthD/kA0iH1Uy/t2Iw2cA6VAhyAxLsGTrxdDe
 6NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900490; x=1695505290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CL2g+I/aYKhCYdCOqJipcnPRCNs8rgqlHMh/Z1brbrI=;
 b=sPMj19i56aAb91gEzAO8b5obcW8ou67aOTt6Ai3HjccxKOxafVcsW+u7etOZxrAOPq
 81GvbbQovZrXD55YdHkzps0bKRniNFk8aTQ4tFK6Xr9XbjeI/5/bqHa8okFujGQF6R7h
 WHXkeoQzuuZjGufbHrdZUk0JfmOQ2VaAhcC5Ii6oB+d3FQaGS2+sHSZmKWvd12OuzzZd
 /UyV79appyNDmN/KkHc7BYVjyhBoPePTyyVFsElpXTtkckPOdC444JURnrWIZEMxchFt
 umbMlZhZZYJbKSGL6OIjb0wLTERY6UlI6aiDbwKp+JQAqwdkEvCSGC3bQICUonmJJHUJ
 HMpA==
X-Gm-Message-State: AOJu0YyxV4SA8gztZHtMvWZHV1L0W8wCWtIujorOY26smpY0dOropOZM
 B/Nm/kix86km7T339tXjxDcq6W36/HP0FYEcHTg=
X-Google-Smtp-Source: AGHT+IHEXUlVrbUyptiqEwM8YkOHuSvH2KZbK27eqslF6NeSbuHc8Rm9AXamuiICn96CTM+bP6NUzg==
X-Received: by 2002:a05:6a00:2d04:b0:68f:dfe2:9f03 with SMTP id
 fa4-20020a056a002d0400b0068fdfe29f03mr4427665pfb.11.1694900489944; 
 Sat, 16 Sep 2023 14:41:29 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 05/39] target/*: Add instance_align to all cpu base classes
Date: Sat, 16 Sep 2023 14:40:49 -0700
Message-Id: <20230916214123.525796-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

The omission of alignment has technically been wrong since
269bd5d8f61, where QEMU_ALIGNED was added to CPUTLBDescFast.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.c      | 1 +
 target/avr/cpu.c        | 1 +
 target/cris/cpu.c       | 1 +
 target/hexagon/cpu.c    | 1 +
 target/hppa/cpu.c       | 1 +
 target/i386/cpu.c       | 1 +
 target/loongarch/cpu.c  | 1 +
 target/m68k/cpu.c       | 1 +
 target/microblaze/cpu.c | 1 +
 target/mips/cpu.c       | 1 +
 target/nios2/cpu.c      | 1 +
 target/openrisc/cpu.c   | 1 +
 target/riscv/cpu.c      | 2 +-
 target/rx/cpu.c         | 1 +
 target/sh4/cpu.c        | 1 +
 target/sparc/cpu.c      | 1 +
 target/tricore/cpu.c    | 1 +
 target/xtensa/cpu.c     | 1 +
 18 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 270ae787b1..e2156fcb41 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -286,6 +286,7 @@ static const TypeInfo alpha_cpu_type_infos[] = {
         .name = TYPE_ALPHA_CPU,
         .parent = TYPE_CPU,
         .instance_size = sizeof(AlphaCPU),
+        .instance_align = __alignof(AlphaCPU),
         .instance_init = alpha_cpu_initfn,
         .abstract = true,
         .class_size = sizeof(AlphaCPUClass),
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8f741f258c..c5a6436336 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -390,6 +390,7 @@ static const TypeInfo avr_cpu_type_info[] = {
         .name = TYPE_AVR_CPU,
         .parent = TYPE_CPU,
         .instance_size = sizeof(AVRCPU),
+        .instance_align = __alignof(AVRCPU),
         .instance_init = avr_cpu_initfn,
         .class_size = sizeof(AVRCPUClass),
         .class_init = avr_cpu_class_init,
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index a6a93c2359..8ab8a30b8d 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -345,6 +345,7 @@ static const TypeInfo cris_cpu_model_type_infos[] = {
         .name = TYPE_CRIS_CPU,
         .parent = TYPE_CPU,
         .instance_size = sizeof(CRISCPU),
+        .instance_align = __alignof(CRISCPU),
         .instance_init = cris_cpu_initfn,
         .abstract = true,
         .class_size = sizeof(CRISCPUClass),
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index f155936289..65f198b956 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -408,6 +408,7 @@ static const TypeInfo hexagon_cpu_type_infos[] = {
         .name = TYPE_HEXAGON_CPU,
         .parent = TYPE_CPU,
         .instance_size = sizeof(HexagonCPU),
+        .instance_align = __alignof(HexagonCPU),
         .instance_init = hexagon_cpu_init,
         .abstract = true,
         .class_size = sizeof(HexagonCPUClass),
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 11022f9c99..17fa901f6a 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -212,6 +212,7 @@ static const TypeInfo hppa_cpu_type_info = {
     .name = TYPE_HPPA_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(HPPACPU),
+    .instance_align = __alignof(HPPACPU),
     .instance_init = hppa_cpu_initfn,
     .abstract = false,
     .class_size = sizeof(HPPACPUClass),
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b2a20365e1..7f15ea4ec4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8020,6 +8020,7 @@ static const TypeInfo x86_cpu_type_info = {
     .name = TYPE_X86_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(X86CPU),
+    .instance_align = __alignof(X86CPU),
     .instance_init = x86_cpu_initfn,
     .instance_post_init = x86_cpu_post_initfn,
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 65f9320e34..56e67cea8d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -804,6 +804,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .name = TYPE_LOONGARCH_CPU,
         .parent = TYPE_CPU,
         .instance_size = sizeof(LoongArchCPU),
+        .instance_align = __alignof(LoongArchCPU),
         .instance_init = loongarch_cpu_init,
 
         .abstract = true,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 70d58471dc..d34d1b57d0 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -611,6 +611,7 @@ static const TypeInfo m68k_cpus_type_infos[] = {
         .name = TYPE_M68K_CPU,
         .parent = TYPE_CPU,
         .instance_size = sizeof(M68kCPU),
+        .instance_align = __alignof(M68kCPU),
         .instance_init = m68k_cpu_initfn,
         .abstract = true,
         .class_size = sizeof(M68kCPUClass),
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 03c2c4db1f..c53711da52 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -439,6 +439,7 @@ static const TypeInfo mb_cpu_type_info = {
     .name = TYPE_MICROBLAZE_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(MicroBlazeCPU),
+    .instance_align = __alignof(MicroBlazeCPU),
     .instance_init = mb_cpu_initfn,
     .class_size = sizeof(MicroBlazeCPUClass),
     .class_init = mb_cpu_class_init,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 63da1948fd..fee791aa44 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -600,6 +600,7 @@ static const TypeInfo mips_cpu_type_info = {
     .name = TYPE_MIPS_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(MIPSCPU),
+    .instance_align = __alignof(MIPSCPU),
     .instance_init = mips_cpu_initfn,
     .abstract = true,
     .class_size = sizeof(MIPSCPUClass),
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index bc5cbf81c2..598976305f 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -400,6 +400,7 @@ static const TypeInfo nios2_cpu_type_info = {
     .name = TYPE_NIOS2_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(Nios2CPU),
+    .instance_align = __alignof(Nios2CPU),
     .instance_init = nios2_cpu_initfn,
     .class_size = sizeof(Nios2CPUClass),
     .class_init = nios2_cpu_class_init,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 61d748cfdc..be067709b8 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -314,6 +314,7 @@ static const TypeInfo openrisc_cpus_type_infos[] = {
         .name = TYPE_OPENRISC_CPU,
         .parent = TYPE_CPU,
         .instance_size = sizeof(OpenRISCCPU),
+        .instance_align = __alignof(OpenRISCCPU),
         .instance_init = openrisc_cpu_initfn,
         .abstract = true,
         .class_size = sizeof(OpenRISCCPUClass),
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f227c7664e..8a765d5117 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2314,7 +2314,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .name = TYPE_RISCV_CPU,
         .parent = TYPE_CPU,
         .instance_size = sizeof(RISCVCPU),
-        .instance_align = __alignof__(RISCVCPU),
+        .instance_align = __alignof(RISCVCPU),
         .instance_init = riscv_cpu_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 157e57da0f..51559943fb 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -248,6 +248,7 @@ static const TypeInfo rx_cpu_info = {
     .name = TYPE_RX_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(RXCPU),
+    .instance_align = __alignof(RXCPU),
     .instance_init = rx_cpu_init,
     .abstract = true,
     .class_size = sizeof(RXCPUClass),
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 61769ffdfa..a90e41c4ec 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -315,6 +315,7 @@ static const TypeInfo superh_cpu_type_infos[] = {
         .name = TYPE_SUPERH_CPU,
         .parent = TYPE_CPU,
         .instance_size = sizeof(SuperHCPU),
+        .instance_align = __alignof(SuperHCPU),
         .instance_init = superh_cpu_initfn,
         .abstract = true,
         .class_size = sizeof(SuperHCPUClass),
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 130ab8f578..d6d3c4b031 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -930,6 +930,7 @@ static const TypeInfo sparc_cpu_type_info = {
     .name = TYPE_SPARC_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(SPARCCPU),
+    .instance_align = __alignof(SPARCCPU),
     .instance_init = sparc_cpu_initfn,
     .abstract = true,
     .class_size = sizeof(SPARCCPUClass),
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 133a9ac70e..50aec6cf10 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -230,6 +230,7 @@ static const TypeInfo tricore_cpu_type_infos[] = {
         .name = TYPE_TRICORE_CPU,
         .parent = TYPE_CPU,
         .instance_size = sizeof(TriCoreCPU),
+        .instance_align = __alignof(TriCoreCPU),
         .instance_init = tricore_cpu_initfn,
         .abstract = true,
         .class_size = sizeof(TriCoreCPUClass),
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index acaf8c905f..281872d7ca 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -273,6 +273,7 @@ static const TypeInfo xtensa_cpu_type_info = {
     .name = TYPE_XTENSA_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(XtensaCPU),
+    .instance_align = __alignof(XtensaCPU),
     .instance_init = xtensa_cpu_initfn,
     .abstract = true,
     .class_size = sizeof(XtensaCPUClass),
-- 
2.34.1


