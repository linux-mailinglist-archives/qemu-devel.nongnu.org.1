Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD423773AA8
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNYd-0001GW-57; Tue, 08 Aug 2023 10:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYb-0001GN-JQ
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:33 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYa-0000Ju-2O
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:33 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc63ef9959so24046015ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691504371; x=1692109171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQa/+lANshzAG+Ialc3M5x9ofhEssVixSOCCrfqyi5M=;
 b=eNRcKWI9TkhHXTvuHvMvj13NO5hhvhNwDov/xnlBCF0Ex9adDUY2hIlxUsGJ8bzq8G
 k7WTtl+6e+wQ9hqFwz/Qe1+BEF1iy0E8i3EFt/Aket6dj7D923flsDvg1v8MyyP4m7pW
 Yt/JEsWzP71g4QhSDMao32Lzk1ShOm43nTi7F3GFljdld9foHeH9JB+IXgevalk1PMx4
 zcG1ig3LIilZajeifd6Uk7tdNUQRFmP1uITkUYm2MU1y3i/RpZlRbgpPJp1MOTQxJHk+
 kVU9n9pifKRU6pIPgn5RVmebNwBmY/UZzOldvaTCqBs23hDh0REgb/SQ1HYNdpnrC1cY
 dBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504371; x=1692109171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQa/+lANshzAG+Ialc3M5x9ofhEssVixSOCCrfqyi5M=;
 b=eyDLlUEsrfK5+V0ZS6HnhLL/g1ilzJOeUKs8692cC/qF1y96c/rQ9cxYl12so1o8dE
 TMChcvl2jg5/1l2CrBxIOxijXoAfYTIoPnof3qJKkGvij3EkJJtEPe3LAm9LUdVXUw5C
 2bfIW1LnjTeKV2z1MJLALx/flDRoe/s5xF2RvLPw6nw2T5fO8R/wJnaRwWYcxUe/NoF7
 heCsdf61H9w3do1j44IBUSIsVu1w83w3FqdMQU/zmdkfy1/IDjCV1/026Z2eyRFXsmJY
 3WJWaFZHZl1eORYB3d5ZWh8DwDVKTk9/xXJC+ccZZSBPBqkFza43dKGXSwKap2i5Ar5C
 Y44Q==
X-Gm-Message-State: AOJu0YyYBW5kl0V8QT2v/kH0ak9M896KE8SFVbgKBExYo2KBQFN8IvJM
 SM9lrZFDHn3dyM7yJQuINTQ=
X-Google-Smtp-Source: AGHT+IGSsKoajrk9YL3I7O1dOJEuxnuv7pDBEX60/UkX1EfA3Lei9DHdaqVpLClTF5CerMGKHwhIeA==
X-Received: by 2002:a17:902:ea09:b0:1bb:7b6c:983a with SMTP id
 s9-20020a170902ea0900b001bb7b6c983amr14272862plg.59.1691504370936; 
 Tue, 08 Aug 2023 07:19:30 -0700 (PDT)
Received: from localhost.localdomain ([223.104.41.22])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902b68300b001bb1f0605b2sm9043985pls.214.2023.08.08.07.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 07:19:30 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [RFC v4 07/11] target/i386: Add support for native library calls
Date: Tue,  8 Aug 2023 22:17:35 +0800
Message-Id: <20230808141739.3110740-8-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x62c.google.com
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
i386 target. When special instructions reserved for native calls
are encountered, the code now performs address translation and
generates the corresponding native call.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 configs/targets/i386-linux-user.mak   |  1 +
 configs/targets/x86_64-linux-user.mak |  1 +
 target/i386/tcg/translate.c           | 27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

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
index 90c7b32f36..28bf4477fb 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -33,6 +33,7 @@
 #include "helper-tcg.h"
 
 #include "exec/log.h"
+#include "native/native.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -6810,6 +6811,32 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1d0 ... 0x1fe:
         disas_insn_new(s, cpu, b);
         break;
+    case 0x1ff:
+        if (native_bypass_enabled()) {
+            TCGv ret = tcg_temp_new();
+            TCGv arg1 = tcg_temp_new();
+            TCGv arg2 = tcg_temp_new();
+            TCGv arg3 = tcg_temp_new();
+            const char *fun_name = lookup_symbol((s->base.pc_next) & 0xfff);
+#ifdef TARGET_X86_64
+            tcg_gen_mov_tl(arg1, cpu_regs[R_EDI]);
+            tcg_gen_mov_tl(arg2, cpu_regs[R_ESI]);
+            tcg_gen_mov_tl(arg3, cpu_regs[R_EDX]);
+            gen_native_call_i64(fun_name, ret, arg1, arg2, arg3);
+#else
+            uintptr_t ra = GETPC();
+            uint32_t a1 = cpu_ldl_data_ra(env, env->regs[R_ESP] + 4, ra);
+            uint32_t a2 = cpu_ldl_data_ra(env, env->regs[R_ESP] + 8, ra);
+            uint32_t a3 = cpu_ldl_data_ra(env, env->regs[R_ESP] + 12, ra);
+            tcg_gen_movi_tl(arg1, a1);
+            tcg_gen_movi_tl(arg2, a2);
+            tcg_gen_movi_tl(arg3, a3);
+            gen_native_call_i32(fun_name, ret, arg1, arg2, arg3);
+#endif
+            tcg_gen_mov_tl(cpu_regs[R_EAX], ret);
+            break;
+        }
+        break;
     default:
         goto unknown_op;
     }
-- 
2.34.1


