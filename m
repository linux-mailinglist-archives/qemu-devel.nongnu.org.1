Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BC478853B
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZULu-00069q-W6; Fri, 25 Aug 2023 06:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZULp-00069Y-Sl
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:47:39 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZULm-0001dP-Bm
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:47:36 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso6317855ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692960453; x=1693565253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gFESm4clOOCmIkRsTJpqyt9vnqYbEE19YeHQqcBSOs=;
 b=oahFf4/fneb7j5lsKoxu8pu7Nm4oKXkDi8NpkJ0HkRc/xAcTH8U2BdexUO13gR7SWg
 RjQRurNIY/3AF7PcEdC5gtXcwfqy8mi2k+81VOB6J7/6jgq19AeS5Q47/h7US270B/8G
 Utfihx/X1/05K/fDSO7GOfM88rc7fZBy+Q/fKVy6Hpdf+K1i+XtLa2XoScvBEH5J2ztO
 NAuNyGb1EQ4jfaesdzALeFDtThT3BN4lL3Q5OnAGaE0Qw8LWMzzsTcQjcTwSx2IjTdhN
 HwM3QvVn8ObvA+wfwL+jzcFobw4x9ObpUC3VmV9XSJcBxtjS40pyjY80R+SM0b7q8OA0
 L/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692960453; x=1693565253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8gFESm4clOOCmIkRsTJpqyt9vnqYbEE19YeHQqcBSOs=;
 b=b6yiW3gXqDe9B4Idh3zn7HyZR2lQan4D9sCuxM63tosZ6KE598VsouXqBJC2L2/sSv
 A/um3EhmFW3qGAwJxmt3VXkd8oNRBz7bopLDiOxZCnsa/VVAUGteuSbqPiSuGCx0N4i/
 aqK3x9zIzcUbnuWQsm+zn+mDCBXL+VrjNH9Vr5ELkDLcSut/VHCdmciVnwN9JXfMb3IY
 mwCA5UvlG97rJ0pipUtjani6uFvjX9OVDcqls3ZZ5O/VhAucxeEjjzJmrsAe5o+YZ5g6
 Z4+ubjJJvKgYp/d3W6bf9KbuvwF4s8Rc+lZLaxpuaAVz+trPkyMIQIIdlHIWBelSG+Gy
 +J9w==
X-Gm-Message-State: AOJu0YxXMt4cHA26RnL8pn9gcGhDkKlOUsuxxJsWq03c7KauxvsYHO4Q
 YtxuQmYeIIZdBGEghHSO7ak=
X-Google-Smtp-Source: AGHT+IGItGXsAxyWVH3sHFgO2oqb9KpaK+dAu7rsvD6KQVn1y3UtvfjUFc+hyL3Rf+JZv24XMhFnCA==
X-Received: by 2002:a17:903:244e:b0:1bf:557c:5a2c with SMTP id
 l14-20020a170903244e00b001bf557c5a2cmr19809461pls.44.1692960452692; 
 Fri, 25 Aug 2023 03:47:32 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.15])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170902ce8500b001b89891bfc4sm1346985plg.199.2023.08.25.03.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:47:32 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [RFC v5 06/10] target/i386: Add support for native library calls
Date: Fri, 25 Aug 2023 18:45:22 +0800
Message-Id: <20230825104526.1754950-7-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
References: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x634.google.com
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
i386 target. When encountering special instructions reserved
for native calls, this commit extracts the function name and
generates the corresponding native call.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 configs/targets/i386-linux-user.mak   |  1 +
 configs/targets/x86_64-linux-user.mak |  1 +
 target/i386/tcg/translate.c           | 37 +++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-linux-user.mak
index 5b2546a430..2d8bca8f93 100644
--- a/configs/targets/i386-linux-user.mak
+++ b/configs/targets/i386-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=i386
 TARGET_SYSTBL_ABI=i386
 TARGET_SYSTBL=syscall_32.tbl
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
+CONFIG_NATIVE_CALL=y
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index 9ceefbb615..a53b017454 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
+CONFIG_NATIVE_CALL=y
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 90c7b32f36..a9e37977e7 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -33,6 +33,7 @@
 #include "helper-tcg.h"
 
 #include "exec/log.h"
+#include "native/native.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -3075,6 +3076,36 @@ static void gen_cmpxchg16b(DisasContext *s, CPUX86State *env, int modrm)
 }
 #endif
 
+static void gen_native_call(CPUState *cpu, DisasContext *s, CPUX86State *env)
+{
+#ifdef CONFIG_USER_ONLY
+    char *func_name;
+    TCGv ret = tcg_temp_new();
+    TCGv arg1 = tcg_temp_new();
+    TCGv arg2 = tcg_temp_new();
+    TCGv arg3 = tcg_temp_new();
+#ifdef TARGET_X86_64
+    uint64_t func_tmp = x86_ldq_code(env, s);
+    func_name = g2h(cpu, func_tmp);
+    tcg_gen_mov_tl(arg1, cpu_regs[R_EDI]);
+    tcg_gen_mov_tl(arg2, cpu_regs[R_ESI]);
+    tcg_gen_mov_tl(arg3, cpu_regs[R_EDX]);
+    gen_native_call_i64(func_name, ret, arg1, arg2, arg3);
+#else
+    uint32_t func_tmp = x86_ldl_code(env, s);
+    func_name = g2h(cpu, func_tmp);
+    tcg_gen_addi_tl(arg1, cpu_regs[R_ESP], 4);
+    gen_op_ld_v(s, MO_UL, arg1, arg1);
+    tcg_gen_addi_tl(arg2, cpu_regs[R_ESP], 8);
+    gen_op_ld_v(s, MO_UL, arg2, arg2);
+    tcg_gen_addi_tl(arg3, cpu_regs[R_ESP], 12);
+    gen_op_ld_v(s, MO_UL, arg3, arg3);
+    gen_native_call_i32(func_name, ret, arg1, arg2, arg3);
+#endif
+    tcg_gen_mov_tl(cpu_regs[R_EAX], ret);
+#endif
+}
+
 /* convert one instruction. s->base.is_jmp is set if the translation must
    be stopped. Return the next pc value */
 static bool disas_insn(DisasContext *s, CPUState *cpu)
@@ -6810,6 +6841,12 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1d0 ... 0x1fe:
         disas_insn_new(s, cpu, b);
         break;
+    case 0x1ff:
+        if (native_bypass_enabled()) {
+            gen_native_call(cpu, s, env);
+            break;
+        }
+        break;
     default:
         goto unknown_op;
     }
-- 
2.34.1


