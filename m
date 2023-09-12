Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C8979DAD7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAww-0000Y8-KA; Tue, 12 Sep 2023 17:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwk-0000Oe-0o
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:24 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwg-0007WZ-K0
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:20 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-573f722b86eso4326961a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694554157; x=1695158957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwpMj7tp0FULMrReOws/DjaiBlzPphwQ/oUU2Dcj5vk=;
 b=O7FSWASA8DnmwcQbg6RzFb1uRUQeMbuEXj5OnrQySAkdWg9Oujdw61k25EGGvm6pMa
 N+nLS9EoV+LQ0Z/TtlpaHJQ5wUTVBFH6gnOvdUepnMi5sVexZG9gLPftITA7Gpvz2NZy
 J2Sy79SyLYMsyKTeAeFNr9eRXJokfDoP0VRtEjGd4yiaY/s0xbttri0UaxD2qkPDYyZU
 Qa40kTROazLQtQSNog7FDCYpJhALWKbHkaO9f51yjPReP9ZlpBBBhoYkmEAMn1/MIicH
 FNtoJYnhFwokZUGPAnFLV4cWdVAs3eTZU3nfwenAGsgwegz/5F75hhYFcQzvwwCsXoWo
 asqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694554157; x=1695158957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwpMj7tp0FULMrReOws/DjaiBlzPphwQ/oUU2Dcj5vk=;
 b=QKQBm5pwjPiVJji6oqgeJ0LnjZeG4anfbDzuagXev6dGfwqE6hShy47gPUESLfYfCU
 xRPY3zveNsCs+PmYSTnMQw86co2yfjr+k7ypFkvW6Y66rMlWK3Xn0jp2mCob/t9JTpSG
 GaIxN20nMqDV90aCtLT1tJCBUTptfSLNDQHSe2p6KzaIXaW9G9MbmV6Hhx+MuzsRW0LT
 t8/zFjOdQLNbbqgO9nGO8HfE6noUEjRt3nYn7IgyCeYCnpLfqdm16HXgENyGUPTZVPWt
 sXTK4HdA09xUiskc0DVBiK77COOkNElwO+nNozYADHSXKUmFchdnoubgrSmw8zXbl9bU
 74wA==
X-Gm-Message-State: AOJu0YxH0lfrlHXg/cgsXSd3/QwXVSDe5T6mvVLzBXxVay3dZM4N5/Ea
 apBZWKi7QDqFFSlQcY5Mc5M=
X-Google-Smtp-Source: AGHT+IHTuW8mjWHKJVLFpkAP0u2V+7EY2kln/DbdwzH1jQLWrQKrexe6SXm+fLg+DRzvv9YQh9P7bA==
X-Received: by 2002:a05:6a20:8f12:b0:13d:1d14:6693 with SMTP id
 b18-20020a056a208f1200b0013d1d146693mr695360pzk.45.1694554157036; 
 Tue, 12 Sep 2023 14:29:17 -0700 (PDT)
Received: from q1iq-virtual-machine.. ([114.249.236.97])
 by smtp.gmail.com with ESMTPSA id
 u20-20020aa78394000000b0068be4ce33easm7930436pfm.96.2023.09.12.14.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 14:29:16 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [RFC v6 5/9] target/i386: Add support for native library calls
Date: Wed, 13 Sep 2023 05:28:38 +0800
Message-Id: <20230912212842.658374-6-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
References: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pg1-x52c.google.com
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
 target/i386/tcg/translate.c           | 38 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

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
index 90c7b32f36..a7a8377832 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -33,6 +33,7 @@
 #include "helper-tcg.h"
 
 #include "exec/log.h"
+#include "native/native.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -3075,6 +3076,37 @@ static void gen_cmpxchg16b(DisasContext *s, CPUX86State *env, int modrm)
 }
 #endif
 
+static void gen_native_call(CPUState *cpu, DisasContext *s, CPUX86State *env)
+{
+#ifdef CONFIG_USER_ONLY
+    uint32_t func_tmp;
+    char *func_name;
+    TCGv ret = tcg_temp_new();
+    TCGv arg1 = tcg_temp_new();
+    TCGv arg2 = tcg_temp_new();
+    TCGv arg3 = tcg_temp_new();
+    x86_ldub_code(env, s);
+    func_tmp = x86_ldl_code(env, s);
+    func_name = g2h(cpu, s->pc + func_tmp);
+#ifdef TARGET_X86_64
+    tcg_gen_mov_tl(arg1, cpu_regs[R_EDI]);
+    tcg_gen_mov_tl(arg2, cpu_regs[R_ESI]);
+    tcg_gen_mov_tl(arg3, cpu_regs[R_EDX]);
+#else
+    tcg_gen_addi_tl(arg1, cpu_regs[R_ESP], 4);
+    gen_op_ld_v(s, MO_UL, arg1, arg1);
+    tcg_gen_addi_tl(arg2, cpu_regs[R_ESP], 8);
+    gen_op_ld_v(s, MO_UL, arg2, arg2);
+    tcg_gen_addi_tl(arg3, cpu_regs[R_ESP], 12);
+    gen_op_ld_v(s, MO_UL, arg3, arg3);
+#endif
+    if (!gen_native_call_tl(func_name, ret, arg1, arg2, arg3)) {
+        gen_illegal_opcode(s);
+    }
+    tcg_gen_mov_tl(cpu_regs[R_EAX], ret);
+#endif
+}
+
 /* convert one instruction. s->base.is_jmp is set if the translation must
    be stopped. Return the next pc value */
 static bool disas_insn(DisasContext *s, CPUState *cpu)
@@ -6810,6 +6842,12 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1d0 ... 0x1fe:
         disas_insn_new(s, cpu, b);
         break;
+    case 0x1ff:
+        if (native_bypass_enabled()) {
+            gen_native_call(cpu, s, env);
+            break;
+        }
+        goto unknown_op;
     default:
         goto unknown_op;
     }
-- 
2.34.1


