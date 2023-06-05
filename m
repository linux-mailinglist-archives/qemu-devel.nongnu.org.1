Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B257230F0
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:17:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gcn-0001vr-PL; Mon, 05 Jun 2023 16:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gch-0001uL-AE
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:15 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcf-0003qB-J2
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:15 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-652328c18d5so2567814b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996172; x=1688588172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t25Lwror6gMHE9REWAtcEk6T/FuH34tcWxvUnV0Sx38=;
 b=wzkd9mb6C6/ynyjnTtFU9lrOyQ53RV0UbyMYVYPbPQHGZIdFzklw/h9ehBaqLEjKFc
 jZ0VQUG/zEDS8/FZ3MCHT76XVKNUISX2MhY5w8eeGMBzWeAdZKKwN537vO74CwYbxFUt
 AsrNn1ya/DMfxDwAZ7C6naTFf5pNpf9RSlHKXVciFvPjC4ANnljlajmU3/nM7MLsEC3p
 RGqJmCpOEtEv1yvjcRhV89ZJLVjbCAcgie4XVHT9WZYP79Y9AwKtpS82Z1B1ZeimNOvK
 gMveJ767FrEBu/z59Jj1lCCJvPsowYxyEX4U6JBjCdJOvY1Zd+FhnKKT4c3F2sj8NUs4
 qMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996172; x=1688588172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t25Lwror6gMHE9REWAtcEk6T/FuH34tcWxvUnV0Sx38=;
 b=SuZMl3rD53WBGetiubifjAeuglnn59QdPnmc9O7suxpEh/LQ1mmkeQ4bF0I7Y1N3eG
 fgXJtDOTpjHnbgeQTc5SUnbXltOpNq1xZRIQCe/obDT/FwcdnHKwkjEoH5Kft/tyqlX2
 YDRtwnp99+lXvj/OypItAUnM3n84uarrOYWR8v3YdlCjHbQ1Crdxq++eR9AOM+uvbbTG
 j6kq+2k6OkKYWXpisiOc6nOzGumKoUkCz5umK9Fq187gAi6nA1G7aSOatJr0xwAfV4rr
 /NClBbWFPZV1Rrnq5BhueUtEmYzOzYRh77oD0A3QAcKFKjVTpRHSK9iNI4DIQkI8DiS+
 9I4Q==
X-Gm-Message-State: AC+VfDxktVDmWKWkL9ss71GvowqBN1sMeTqR76NaZvWDpwpDGlTxRdrm
 9TBKKgFAo1nf0Rw1eC3cemlRtsNod5vIMJVC1L8=
X-Google-Smtp-Source: ACHHUZ60lJ1wgTxU8EOGvkIv8IX7LO8/GJkYmdWa6NVGiWVDMFRy1ccDPqz/9oyb2Zx1gy0AE8dZMg==
X-Received: by 2002:a05:6a20:12d6:b0:10b:9dc1:c5e5 with SMTP id
 v22-20020a056a2012d600b0010b9dc1c5e5mr93465pzg.34.1685996171742; 
 Mon, 05 Jun 2023 13:16:11 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/52] target/sh4: Emit insn_start for each insn in gUSA region
Date: Mon,  5 Jun 2023 13:15:21 -0700
Message-Id: <20230605201548.1596865-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Fixes an assert in tcg_gen_code that we don't accidentally
eliminate an insn_start during optimization.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 9d2c7a3337..76f46d268b 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2146,9 +2146,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
 
     /* The entire region has been translated.  */
     ctx->envflags &= ~TB_FLAG_GUSA_MASK;
-    ctx->base.pc_next = pc_end;
-    ctx->base.num_insns += max_insns - 1;
-    return;
+    goto done;
 
  fail:
     qemu_log_mask(LOG_UNIMP, "Unrecognized gUSA sequence %08x-%08x\n",
@@ -2165,8 +2163,19 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
        purposes of accounting within the TB.  We might as well report the
        entire region consumed via ctx->base.pc_next so that it's immediately
        available in the disassembly dump.  */
+
+ done:
     ctx->base.pc_next = pc_end;
     ctx->base.num_insns += max_insns - 1;
+
+    /*
+     * Emit insn_start to cover each of the insns in the region.
+     * This matches an assert in tcg.c making sure that we have
+     * tb->icount * insn_start.
+     */
+    for (i = 1; i < max_insns; ++i) {
+        tcg_gen_insn_start(pc + i * 2, ctx->envflags);
+    }
 }
 #endif
 
-- 
2.34.1


