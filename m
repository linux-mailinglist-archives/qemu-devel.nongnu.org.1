Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B8F73D484
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXGn-0005Yz-8H; Sun, 25 Jun 2023 17:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGl-0005Yo-Fe
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:39 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGj-0003Uh-5m
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:38 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b5018cb4dcso10926705ad.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687728455; x=1690320455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuwM7zeHGUvJwu2BcTqfY7ibdv6STwS22FgIYvtddB8=;
 b=R3UFsDnHzsj9+bS6EqZV+89CZt0sINE9ETDqSkgGsxIm7meyXZEK7H3R3MKluRaOJB
 MEJGqkjEF/WwTIPK0TkemsPhTcGAVTJ50HuUNlfdRAVLtYTtq6okpG6ECA9lmFvdPkT5
 WNSz7VlsaHX1H7vToz8jHQ57XMfBpbmHqJGl0ArsRXfpqMBk3H92cQLP/wNtcJt/T4h9
 1fXENRF5IQ2z96hLubO+r48DFjk/VPK8Q5BpaDLHPYGFDtLT0OHB2NZKQfmTlJydvj1d
 7uNYAOHiSNQBl5ZETY1O5AcXvwz6+MKGgRoI1VJMd0EfHv0JaVZ2990CDYXZE/khuHoI
 NFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687728455; x=1690320455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YuwM7zeHGUvJwu2BcTqfY7ibdv6STwS22FgIYvtddB8=;
 b=hZFPWXyCWLPaiAiYEvtCHewe44654E8byIecBkVRLVf8XbXggj3A7NQ9q3Iy5ayp8/
 aVBHKKJf7LXA/xrfLOZAU1wRBsMrzmOHa84+b5udB+l3TVIF9iczL/IQIXDFfUK2McAD
 5ULozH7jxaIaVF4QF2Y6Y7sv5eMPpL66NKUiS7JF2oETWgm3vk3Tdr9QonZ/dh4swpo3
 eBzuohCb2Sr+suikVT4uH+WkPAynIBsZds2Rcj3mR4/CCz7iwhRu2R5j5fTaZWNe2GJJ
 QpbIxRs5wGR5e13dVtSFfDSbCfjq8Xb48KqiyKXclL3T4bZ67LR7LEljIOIBTisIFu0v
 i77A==
X-Gm-Message-State: AC+VfDyDW04eXsGQLMpUvzGqQhhSspLaxsMjWLhm15oWdEScqkdSiXJp
 Ib/ezZe9II4fB6gLVOxRo64=
X-Google-Smtp-Source: ACHHUZ4Lnj8bq7PvOzN8AcccEg1THM1rq6GIOs82a85InhHvPiIT8oWki6X2yfMqCmMB9kvzsNb4HQ==
X-Received: by 2002:a17:903:41c1:b0:1a9:40d5:b0ae with SMTP id
 u1-20020a17090341c100b001a940d5b0aemr2911371ple.12.1687728455268; 
 Sun, 25 Jun 2023 14:27:35 -0700 (PDT)
Received: from q1iq-virtual-machine.localdomain ([111.201.135.80])
 by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001b8004ff609sm761343plb.270.2023.06.25.14.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:27:34 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [RFC v3 07/10] target/i386: Add support for native library calls
Date: Mon, 26 Jun 2023 05:27:04 +0800
Message-Id: <20230625212707.1078951-8-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Upon encountering specialized instructions reserved for native calls,
store the function id and argument types, then invoke helper.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 target/i386/tcg/translate.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 91c9c0c478..27d5d2231b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -33,6 +33,7 @@
 #include "helper-tcg.h"
 
 #include "exec/log.h"
+#include "native/native-defs.h"
 
 #define PREFIX_REPZ   0x01
 #define PREFIX_REPNZ  0x02
@@ -6806,6 +6807,38 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1d0 ... 0x1fe:
         disas_insn_new(s, cpu, b);
         break;
+    case 0x1ff:
+        if (native_call_enabled()) {
+            uint16_t sig;
+            sig = x86_lduw_code(env, s);
+            TCGv_i32 func_id = tcg_constant_i32(sig);
+            sig = x86_lduw_code(env, s);
+            TCGv_i32 abi_map = tcg_constant_i32(sig);
+            TCGv arg1 = tcg_temp_new();
+            TCGv arg2 = tcg_temp_new();
+            TCGv arg3 = tcg_temp_new();
+#ifdef TARGET_X86_64
+            tcg_gen_mov_tl(arg1, cpu_regs[R_EDI]);
+            tcg_gen_mov_tl(arg2, cpu_regs[R_ESI]);
+            tcg_gen_mov_tl(arg3, cpu_regs[R_EDX]);
+#else
+            uintptr_t ra = GETPC();
+            uint32_t a1 = cpu_ldl_data_ra(env, env->regs[R_ESP] + 4, ra);
+            uint32_t a2 = cpu_ldl_data_ra(env, env->regs[R_ESP] + 8, ra);
+            uint32_t a3 = cpu_ldl_data_ra(env, env->regs[R_ESP] + 12, ra);
+            tcg_gen_movi_tl(arg1, a1);
+            tcg_gen_movi_tl(arg2, a2);
+            tcg_gen_movi_tl(arg3, a3);
+#endif
+            TCGv res = tcg_temp_new();
+            TCGv_i32 mmu_idx = tcg_constant_i32(MMU_USER_IDX);
+            gen_helper_native_call(res, cpu_env, arg1, arg2, arg3,
+                                    abi_map, func_id, mmu_idx);
+
+            tcg_gen_mov_tl(cpu_regs[R_EAX], res);
+            break;
+        }
+        break;
     default:
         goto unknown_op;
     }
-- 
2.34.1


