Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DD77B6FFC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:37:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjEz-0008P8-DP; Tue, 03 Oct 2023 13:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEk-0008G8-Um
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:18 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEi-0007TB-Gu
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:10 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57babef76deso708622eaf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354267; x=1696959067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8opfSF/Y8MMlW1ojUqnG145V9XisODxmRwJIB81ufxs=;
 b=y7h7GuhluCy+TOARiJmntGfMUMXvyEXQgUdX3SSRHZC6NXuXQDfOCJEWGiiiiuliIu
 BDBrw8jNi5vOts3UdbqwhuN96DoxjX3WY84V/aBOC4GCyY+EK4CeQBc+Mg81DIOqSVsy
 byVF+mX7FO070/Cqucn3N0B+B8w08wCPiPNqGw3G0HmOLKkiPg7juPzcRXkiFbY/7bB/
 8my0zUYEEi8WJSwYGCo3gSdnofQE5Dz07QStIDR9/zBB/CQ6HnIW+hkHJXwTnLoz+tWu
 PoM8IyUfcDBFCo49lbUb1XxUlfwJIPDp0klUKPw5nugparX5iNrttT5mu7GFymdzgKDT
 w/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354267; x=1696959067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8opfSF/Y8MMlW1ojUqnG145V9XisODxmRwJIB81ufxs=;
 b=pyzo5S4BGqDCkT6GY6Avr9B6wZsof36nq5aS2Hs63Y1thn+ltv0mEHPHXQ4eb2N5O4
 XyoHvskMCqhsnseD6q7vVNMosUVJVRRy1pCDWFbfGPZue3pps34eZbbdhXhcpqb5e+V1
 PKhNui5n0szpJXB61XnbHfL242Fj+S51P8n8/Oc6M5r/Gdf3Kdm5i5SGMvB46qjhXbAc
 1nJnA08Hclf9UgiKNHXZQ+NBkAXarhBAusM9a0cEZ6I7MFk44+jutpr5dDP+FeJfQgbT
 kXQJAzcyV8dSJ2CqKoecNiP9etQ9RBDClm+3mwf7sid9bgPdyt3pYJ7chFpNjvyefzuX
 LnLQ==
X-Gm-Message-State: AOJu0YyI0e2qru/vm2YHWDQYaS3yfQVy0g9+S1kzsu55QlXZrpd57u90
 gIz9ZMfWiHW1O8Cgkg6qoLP56pqGkGxqmsMVaXE=
X-Google-Smtp-Source: AGHT+IEUJVmLTh4VtSWsJS+aY1J3EB9xv2WWhNFJKTxexaZRAxdd86BgRAxc+hKLQ+eYBxQw1y8GmA==
X-Received: by 2002:a05:6358:24aa:b0:13f:2833:bf41 with SMTP id
 m42-20020a05635824aa00b0013f2833bf41mr95874rwc.23.1696354267327; 
 Tue, 03 Oct 2023 10:31:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/47] target/*: Add instance_align to all cpu base classes
Date: Tue,  3 Oct 2023 10:30:17 -0700
Message-Id: <20231003173052.1601813-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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
index ed72883bf3..187ebb0dbc 100644
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
index fc7f70fbe5..d5e403bbb7 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -808,6 +808,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
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
index 4140899c52..d69c40d380 100644
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


