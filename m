Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6080C773AB0
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:21:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNYo-0001Hp-RW; Tue, 08 Aug 2023 10:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYm-0001HP-Ta; Tue, 08 Aug 2023 10:19:44 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYl-0000Oz-8Z; Tue, 08 Aug 2023 10:19:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bc83a96067so4075485ad.0; 
 Tue, 08 Aug 2023 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691504381; x=1692109181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mf2N6SezX4W3DKkhSHLdtBmZLWd1QdX4LdESVzPnYbo=;
 b=QIrgOx3QmetwrI/AsEqyVSIGu3U5LKvGC0y/4Ots6XzUyKv6ugBd6jz/IEvP03knRZ
 Yzw9TrXirpQEy0itWF5lleJN9Og+bg1FTD0uxi76mDYY8ccmnsmpTdS5Q6G8bmPEjgzr
 r4LKIYgCuxG3c1eY/bnBLWxWMG1mvALCxK1zwfqU9ZRFp4P96oAHbR+KrR/mBSJcsUCU
 ZJAiEQb7YwPjaXAI4r1P2NYVg8o/uR0j/3yVsqACYR4fEZftpVlqldSgCg0mG+ur7E/9
 6stk47FGwNSVCQ+BeTDYx38FpRcJwvHPQ9S2YYOIQRJNcpO2YZUlE5+ancvWKbjmwSyZ
 EuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504381; x=1692109181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mf2N6SezX4W3DKkhSHLdtBmZLWd1QdX4LdESVzPnYbo=;
 b=HDoTa9ieFz9zK9vj/99LDKjmbl4MeV1DF6t38W6TTWaS0OUu2TPLbocWmLd+hSW/sN
 D57YOAHjNbd/YkpQ8URCQPjoaZDq4uQu0lfQEajhMQpMQN2EajEzf9Pln3IEm14DTUbv
 ddWTeW7Cgq2U3uxmzNl0MPAKc5sCe9HWzvOi4rQ6DJMC+xvKUYUBa0fZdbRYnA2A7aYp
 lixm4R3ObBdSJLDktP0diXqydurItlHMDUAVXztXyiFua8/7h+r3osw6ornDpso71GK2
 aCseflxst54Fgs0Ep9ixlpyP33Nqq3ZT435Y0rVvI0990YUxtANqsOmoqfNHANyMm5Ag
 A+Iw==
X-Gm-Message-State: AOJu0YyJ4UqqdgzVb0C3axiwWsf8COMjcBHZtsz2ZuN2YBHtyYkonPxs
 Nv54ZANq5bfFnnxykRBh33j3q1zwXv3Qc6sT
X-Google-Smtp-Source: AGHT+IF5r0w7UHfokoRrcnZ3Ohll5jr5lhOigingkY1h78bNSaGTyYwKqJR/OaVGyhPqycbUaI4dmQ==
X-Received: by 2002:a17:903:22c6:b0:1bc:6707:f451 with SMTP id
 y6-20020a17090322c600b001bc6707f451mr6712771plg.42.1691504381474; 
 Tue, 08 Aug 2023 07:19:41 -0700 (PDT)
Received: from localhost.localdomain ([223.104.41.22])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902b68300b001bb1f0605b2sm9043985pls.214.2023.08.08.07.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 07:19:41 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC v4 09/11] target/arm: Add support for native library calls
Date: Tue,  8 Aug 2023 22:17:37 +0800
Message-Id: <20230808141739.3110740-10-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit introduces support for native library calls on the
arm target. When special instructions reserved for native calls
are encountered, the code now performs address translation and
generates the corresponding native call.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 configs/targets/aarch64-linux-user.mak |  1 +
 configs/targets/arm-linux-user.mak     |  1 +
 target/arm/tcg/translate-a64.c         | 14 ++++++++++++++
 target/arm/tcg/translate.c             | 11 +++++++++++
 4 files changed, 27 insertions(+)

diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aarch64-linux-user.mak
index ba8bc5fe3f..5a8fd98cd9 100644
--- a/configs/targets/aarch64-linux-user.mak
+++ b/configs/targets/aarch64-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
+CONFIG_NATIVE_CALL=y
diff --git a/configs/targets/arm-linux-user.mak b/configs/targets/arm-linux-user.mak
index 7f5d65794c..f934fb82da 100644
--- a/configs/targets/arm-linux-user.mak
+++ b/configs/targets/arm-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
+CONFIG_NATIVE_CALL=y
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3baab6aa60..422d943f92 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -25,6 +25,7 @@
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
+#include "native/native.h"
 
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
@@ -2400,6 +2401,19 @@ static bool trans_HLT(DisasContext *s, arg_i *a)
      * it is required for halting debug disabled: it will UNDEF.
      * Secondly, "HLT 0xf000" is the A64 semihosting syscall instruction.
      */
+    if (native_bypass_enabled() && (a->imm == 0xffff)) {
+        TCGv_i64 arg1 = tcg_temp_new_i64();
+        TCGv_i64 arg2 = tcg_temp_new_i64();
+        TCGv_i64 arg3 = tcg_temp_new_i64();
+        TCGv_i64 ret = tcg_temp_new_i64();
+        const char *fun_name = lookup_symbol((s->base.pc_next) & 0xfff);
+        tcg_gen_mov_i64(arg1, cpu_reg(s, 0));
+        tcg_gen_mov_i64(arg2, cpu_reg(s, 1));
+        tcg_gen_mov_i64(arg3, cpu_reg(s, 2));
+        gen_native_call_i64(fun_name, ret, arg1, arg2, arg3);
+        tcg_gen_mov_i64(cpu_reg(s, 0), ret);
+        return true;
+    }
     if (semihosting_enabled(s->current_el == 0) && a->imm == 0xf000) {
         gen_exception_internal_insn(s, EXCP_SEMIHOST);
     } else {
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 13c88ba1b9..a095ebcea6 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -27,6 +27,7 @@
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
+#include "native/native.h"
 #include "exec/helper-proto.h"
 
 #define HELPER_H "helper.h"
@@ -1139,6 +1140,16 @@ static inline void gen_hlt(DisasContext *s, int imm)
      * semihosting, to provide some semblance of security
      * (and for consistency with our 32-bit semihosting).
      */
+    if (native_bypass_enabled() && (imm == 0xffff)) {
+        TCGv_i32 arg1 = load_reg(s, 0);
+        TCGv_i32 arg2 = load_reg(s, 1);
+        TCGv_i32 arg3 = load_reg(s, 2);
+        TCGv_i32 ret = tcg_temp_new_i32();
+        const char *fun_name = lookup_symbol((s->base.pc_next) & 0xfff);
+        gen_native_call_i32(fun_name, ret, arg1, arg2, arg3);
+        store_reg(s, 0, ret);
+        return;
+    }
     if (semihosting_enabled(s->current_el == 0) &&
         (imm == (s->thumb ? 0x3c : 0xf000))) {
         gen_exception_internal_insn(s, EXCP_SEMIHOST);
-- 
2.34.1


