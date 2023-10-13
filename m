Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C77C8F17
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:31:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiO-0006Cf-Ay; Fri, 13 Oct 2023 17:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiL-0006BG-OK
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiJ-0000Pt-59
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:56 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso646959b3a.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232534; x=1697837334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNIL4pN5JeJ3Z5YvYXuXP0cO4Np1EpKLwd4Cf3DmRtw=;
 b=HrEO8QD4AbGnqEZtfwEVS8mHeLYKbOvrPLXs06e+EThQ6g3z4v50rG0Pb8OHPOqbh5
 tLfIizAkfwpFaD7WJ3g/j+KdGzVrHyTFfL69nVC0j2KV4J6vogtsfhdPts4SjMwZeakT
 pQj8hN3K4QGFPgt7m7+riIi2n86zCA1/5nfdpka34EMozg7+Mbm7moU6ZSQG5puse5gs
 YFfYTq5iAnbhRdHzS4inVUads6BDDTqenjHTJu4AZhKdPzOn67orZCReGKtmuXJIejoM
 FQ9SJqlIPWx41p8CViRfBz4ZYwNrsfr/thWPa7rMh2M1njQbLjzHwMMuzYnM895PKnSz
 QHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232534; x=1697837334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PNIL4pN5JeJ3Z5YvYXuXP0cO4Np1EpKLwd4Cf3DmRtw=;
 b=CcX555feHQGCZPJeQ0OrDLVxCK59/B+DLtK+AIUZ3FG/2Km6bvtFtxaqcZNXC61rSr
 S4ZuiBCIPR3I7Ka/Ktc9bYHViH2aX5TMAmNXUSPl9Lt0cDG1fSyoFLbF+f21zyPY7RA0
 vFmIO9wlzOSPn78PNLiMT+mLxq7o7Qj460kKk4d1w4gwPWH2RDABg/gu/pG7cLhBBgEf
 L7TyZZ63wGuhYI/9mNgm1ZiKpcfsAiVsyJ9vjvDBbF4ndeUYjnTKb8eL6VsEVh8gyG94
 /F0ZBT5bZrQBCVXuz0+9BSBhN4xm8xD59WIRc6mjDDrkOcVl9xepNgS5c+teofKwBJsk
 9Ldg==
X-Gm-Message-State: AOJu0YzC62AqsOJcNIrvQeC/KjPYCpHUn6q14JgXLvYKY1B+CifvjTLo
 TgZzKdFWOy46WsZAroFPT6YYvwbYFdL87ueAs+I=
X-Google-Smtp-Source: AGHT+IEYoheXlnAAOEL0GCLRwIZ0htmXcUQK2vo4vQJjVpLV2HWQM39lsNcYVYWER76UFgiN2Kuc2Q==
X-Received: by 2002:a05:6a20:5490:b0:13d:8876:4c97 with SMTP id
 i16-20020a056a20549000b0013d88764c97mr31049740pzk.16.1697232533927; 
 Fri, 13 Oct 2023 14:28:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 06/85] target/sparc: Move CALL to decodetree
Date: Fri, 13 Oct 2023 14:27:27 -0700
Message-Id: <20231013212846.165724-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 33 ++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5811a679db..a5f5d2681e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -3,3 +3,4 @@
 # Sparc instruction decode definitions.
 # Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
 
+CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index da6503e101..bc1033231f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3002,6 +3002,20 @@ static bool advance_pc(DisasContext *dc)
     return true;
 }
 
+static bool trans_CALL(DisasContext *dc, arg_CALL *a)
+{
+    target_long target = dc->pc + a->i * 4;
+
+    gen_store_gpr(dc, 15, tcg_constant_tl(dc->pc));
+    gen_mov_pc_npc(dc);
+
+    if (unlikely(AM_CHECK(dc))) {
+        target &= 0xffffffffULL;
+    }
+    dc->npc = target;
+    return true;
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3107,23 +3121,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             break;
         }
         break;
-    case 1:                     /*CALL*/
-        {
-            target_long target = GET_FIELDs(insn, 2, 31) << 2;
-            TCGv o7 = gen_dest_gpr(dc, 15);
-
-            tcg_gen_movi_tl(o7, dc->pc);
-            gen_store_gpr(dc, 15, o7);
-            target += dc->pc;
-            gen_mov_pc_npc(dc);
-#ifdef TARGET_SPARC64
-            if (unlikely(AM_CHECK(dc))) {
-                target &= 0xffffffffULL;
-            }
-#endif
-            dc->npc = target;
-        }
-        goto jmp_insn;
+    case 1:
+        g_assert_not_reached(); /* in decodetree */
     case 2:                     /* FPU & Logical Operations */
         {
             unsigned int xop = GET_FIELD(insn, 7, 12);
-- 
2.34.1


