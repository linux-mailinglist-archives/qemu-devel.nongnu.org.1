Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B3579F868
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:47:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLX-0000cC-MP; Wed, 13 Sep 2023 22:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLV-0000bM-Sr
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:45 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLT-0000fg-U6
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:45 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5779055a474so373331a12.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659482; x=1695264282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYv9XvKzRTuB6mD+scN/6rAWMgJL4QdxBzI/GOTiLoQ=;
 b=TaGbyEtXy3KOPTGGjEftfXcTL8VIe4q5B0wAFRdhaZK/5brMc0+kSBh1UBX01CYTxX
 3M/7Kb++EKjBZDnV0JYHdI1qncvYSHxkFOBseGQief/pCGShJru5odnISvQqbZr5k52v
 zgsKmKjB3iSXp9MI8UIaJhZorhuUC59QjWbSdFxatcY2KsXW7rECetnh0EZe4L4b9+8h
 XyMx5yAj+0o5gjUV4h+G7auAt4vvHl4y6kOC5SKxk2/8M/iVra84ggaSSSnGd95bzVE9
 c4BjCYzJ2oyk2/r+sFkOicsBGGn8FW/eg7VX+K+KgOrrfTGrUnsKPExdp3RRH73x7z4q
 1XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659482; x=1695264282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYv9XvKzRTuB6mD+scN/6rAWMgJL4QdxBzI/GOTiLoQ=;
 b=ckrJsGdKXLa4Emik+bLrxI+zkbzlXtgze9Mq8eXhSb5yFmqXU6Xh0KKNLjQuaTgyww
 bx9pKUEpqsuTwGKXO5707qHwO5SUpilzPeJKahyPWxckdEUTkPLpbcng4of7v4344EOb
 k5FU6WWz5OjmdxciLvrzeAc+RjuWUHkwoL0ZHxDkNMBK+0V6BENPP30L8BS2E1k9f0LL
 QhhRbWac23/NuA/fo+1gQBSkMy0otLPf+wfQKal3kFlO2GWAtHdy27/rSPEaHsSa1FLS
 l8bP5W2kBbWuIl7We+zldHntb2jxwOOFHHTGdc4fcsMszaclU271mLZIKGxuV/u8iSly
 YZ3g==
X-Gm-Message-State: AOJu0Yy+5ePVmIJr4iCa5Up+eK0xqacx2AICiJwldKXI6XdhX+Op2nRv
 yt7VHmuUQBMwdFjrKXMNbjKFabL8z/s3gz13iCE=
X-Google-Smtp-Source: AGHT+IHFXCVSMNUEvAPDnepsfoJspl2iAr31gGwwrmun7kn1Vl7ZdhLhmZQhxhkxu6uXr9/V+Rm8sQ==
X-Received: by 2002:a05:6a20:54a1:b0:155:2c91:f8e5 with SMTP id
 i33-20020a056a2054a100b001552c91f8e5mr4664566pzk.14.1694659482259; 
 Wed, 13 Sep 2023 19:44:42 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 06/24] target/*: Add instance_align to all cpu base classes
Date: Wed, 13 Sep 2023 19:44:17 -0700
Message-Id: <20230914024435.1381329-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
index 24ee67b42d..9565e3d160 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8022,6 +8022,7 @@ static const TypeInfo x86_cpu_type_info = {
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


