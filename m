Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DD47E1649
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:14:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjUB-0003Qu-2i; Sun, 05 Nov 2023 15:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU9-0003PS-3y
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:41 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU7-0002AU-MG
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:40 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1ef370c2e1aso2353653fac.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215157; x=1699819957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/veF9kIVEae0GlpFh27Byc+ihsa92GV+L/1WPN7Szs=;
 b=cHEwTVF5cmJ690lmkpolzTYKO1BnlD4HzGOoGnySyXVy4hqy/FgJQbsDdhmv4tSKmJ
 11zt8BaLMUmQleBcDkRtq5symkRJzpv6c4jSDp3d1TfBjr5cjLGsx9wU8ZKYrByatw5N
 XEBPqoPnMVBGDgosrsLfFSPcXqv+PRC/MctDHnPV3PqVYaIT/cvZblpuI1hoOv4Tz5w1
 6yskb6WJRHOATlO/c29H8wuPjpYLxX2x+D6LdtGVbBvdRTQuG68mldSR91nWZaGuAkiN
 rQv8Wrt8EPV1BQtf28iYAU+t2+DRCV7mE/c6KjxAFLGthVxooqCojjwGOHyTBrMjN1lK
 LI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215157; x=1699819957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g/veF9kIVEae0GlpFh27Byc+ihsa92GV+L/1WPN7Szs=;
 b=StPRiGMe/3vqVsR6dFLQbH+NVLl7OSYFejml4TlZAdN9ND8XgDb95SiGYrTH8wmfum
 zS2oUdxIIipoqrvc5kDFXTRMezPVMn6tIa4eUEmoCycOI6+RhJX3C6Lm/2sEp49PxdBT
 DlODAfRtmMxKWx+rr1kOm4bFjqdz1ySJt88ymMfE/mLWi+tZ/Lzjk4gC4yMiKR3vbynY
 a2ao5ip48f5YsmdCOzU/9oR0iPObq2lKo4hNYBGQJStaSqtSUbnBjdC94bA08kz9k8wT
 iH4cf8MUN9927qMI6QmHLneiDHY8eWDqY9wZ5BfAsH5JPB6Hf/XKCATZ+2q63rg64oJT
 +ppA==
X-Gm-Message-State: AOJu0Yy1hjBBeCXdreZhVLwIszLn4pympSmaxwbjxrJGf4XM3gAslP2O
 r93rVVHYkpUKz55niTLNgZ12QXufREFgkM6ilXU=
X-Google-Smtp-Source: AGHT+IHYuYdomSJN7jA2WRqaMIrdvu8nwhaqesjXIRpkM3IBNOv8ggWHcJVYwPF3hCiA/OnuReiQ1Q==
X-Received: by 2002:a05:6870:ac87:b0:1d6:3d31:fb4b with SMTP id
 ns7-20020a056870ac8700b001d63d31fb4bmr34645116oab.24.1699215157632; 
 Sun, 05 Nov 2023 12:12:37 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 16/21] target/sparc: Merge gen_op_next_insn into only caller
Date: Sun,  5 Nov 2023 12:12:17 -0800
Message-Id: <20231105201222.202395-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1233911b69..0bbe4cff3b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1015,12 +1015,6 @@ static void gen_mov_pc_npc(DisasContext *dc)
     }
 }
 
-static void gen_op_next_insn(void)
-{
-    tcg_gen_mov_tl(cpu_pc, cpu_npc);
-    tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
-}
-
 static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
                         DisasContext *dc)
 {
@@ -2346,7 +2340,8 @@ static bool advance_pc(DisasContext *dc)
         case DYNAMIC_PC:
         case DYNAMIC_PC_LOOKUP:
             dc->pc = dc->npc;
-            gen_op_next_insn();
+            tcg_gen_mov_tl(cpu_pc, cpu_npc);
+            tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
             break;
 
         case JUMP_PC:
-- 
2.34.1


