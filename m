Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 466C17D1B3A
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:49:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4au-0007A4-Ea; Sat, 21 Oct 2023 01:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4as-000797-Aw
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:14 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ao-0008Mi-M1
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:14 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso1172059b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866329; x=1698471129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kh4UR/x6NVS8OMj/epOA+pEm4qe7LB7jB8T5mbBYeEw=;
 b=zyb2EHc2K7iEOhmkOk8EcYOeATrvVgYuSWlTpP00Iz8yfqDgiK6Jw1Hn5FOlBkjiza
 PJYw4e0VKxA2xkXYxE61U4HUsiPjE6hz+H8XsG5z/j/GlRC4XvPs5XlwZffiCWyysvVK
 /eWuaxLABsmvoIK5vDfxtwQfmqblUKaMIs1o7SJyn9qm4+Mqru4FUtN9XbCfj0Y0Z2rK
 lfwScfHHbxdm2ocSSi6Nsw0N4Gko21UjVkXN/Pq5Sq/KgGdjMNkvqKgJ6w43RZBtg8pK
 2+2G2FyUJBrWEHXVJKjt+ZCTQnYN5qDH6y2MG6mwRvZjPpQyNA3/8tRlFkTN5ozYalPP
 OtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866329; x=1698471129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kh4UR/x6NVS8OMj/epOA+pEm4qe7LB7jB8T5mbBYeEw=;
 b=FELoJuekyKm3QDcOmkIWEyYaKbujh00Et3Dd1jy3h0WzwssF2/zybxtoTHR0pHiz4U
 tyvi2f5oInPT6omnUEWIedb9Dd4IVeftYlpq2g4mTTJMi34asC0rQ8Qr3ipeNx+4wvdZ
 svB7JOcJo2ffaUG1OKxZwWkQt9QWG+UGza8cMdgq1G8SgtbL7G0E7tVECvpBaty5B9z9
 XeFYY9BNEXtQhdtMSjZvoPzcqUlmdBdvpoKtrHirC2rKdiLjGiU9kigIfmQf2SzPliBm
 rwclpRWwjHoWHBQvtJC1lHzRlbz9VDnvTqCoDXTfrwPb5P5Z6pLKTH+rMm3atCxqXyit
 WySQ==
X-Gm-Message-State: AOJu0YxJxaFuyhK6dZYyFl7LzM6eGtflBZq6x6J61c2rs2YhzooRJ2UU
 8zdeSdz35JLd4ldOc1c8LRkTwdHkHuy2xDOWQbE=
X-Google-Smtp-Source: AGHT+IHGLNvML6jEQqiE3LneoSBZqdVgMWl8qIkVLFaIJNkHX7vDhJxovHf/P/F1OiAf3l4S7MC/Nw==
X-Received: by 2002:a05:6a00:1817:b0:68e:3616:604a with SMTP id
 y23-20020a056a00181700b0068e3616604amr5699524pfa.8.1697866329088; 
 Fri, 20 Oct 2023 22:32:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 11/90] target/sparc: Move CALL to decodetree
Date: Fri, 20 Oct 2023 22:30:39 -0700
Message-Id: <20231021053158.278135-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
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
 target/sparc/translate.c  | 34 +++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5811a679db..a5f5d2681e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -3,3 +3,4 @@
 # Sparc instruction decode definitions.
 # Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
 
+CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9eb2b7e52f..7ef4c6d4f7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -285,6 +285,11 @@ static void gen_address_mask(DisasContext *dc, TCGv addr)
     }
 }
 
+static target_ulong address_mask_i(DisasContext *dc, target_ulong addr)
+{
+    return AM_CHECK(dc) ? (uint32_t)addr : addr;
+}
+
 static TCGv gen_load_gpr(DisasContext *dc, int reg)
 {
     if (reg > 0) {
@@ -3041,6 +3046,16 @@ static bool advance_pc(DisasContext *dc)
     return true;
 }
 
+static bool trans_CALL(DisasContext *dc, arg_CALL *a)
+{
+    target_long target = address_mask_i(dc, dc->pc + a->i * 4);
+
+    gen_store_gpr(dc, 15, tcg_constant_tl(dc->pc));
+    gen_mov_pc_npc(dc);
+    dc->npc = target;
+    return true;
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3146,23 +3161,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


