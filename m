Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DFA73E3CA
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKc-0000x1-W9; Mon, 26 Jun 2023 11:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJq-0000Ih-PU
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJm-0002qW-Ao
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:58 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31272fcedf6so3089533f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793992; x=1690385992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D5gCGUwlOFGdwfouX0s3t3cVRatFD3jwnMU9iqEUDZU=;
 b=mgwwmfnjJf4P6Tv5k0w5OC+N+x7k7rQJfkyWAKLReucNrEUGpEm/lbUZ4EQPSIrOm2
 W1IsjFNuFQgK4xPhHde1nCDqZJH36W6LAvZtZxX16OZmKuds6CqWA1rkn5DZNjzwRjZr
 EY5YqaZzsji101Fzv2/chFfJM/1/UWz8+eEigZyALo06AczxHlpcYCnd7ci50j53yt0S
 2d93dBTwvIfNSP4sdVpe35ufNR2m6JCA2ZtDeOkeYQsflihJFgzBiVhEloM3er4schlw
 rPRS2tPRxB78P2uiqa0kiqeqccZG00yO2pyTsXn2/EvH9julXQyF2aTZoyO+EvfvLxRo
 UqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793992; x=1690385992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5gCGUwlOFGdwfouX0s3t3cVRatFD3jwnMU9iqEUDZU=;
 b=E1zE5tkVJ8wEVsEoHwtJrxleaMW7mOlAhjiMBhruPLKXZJiKa+ihWtiUMI575GsHOO
 BRqrouExsBMA3wwymp0PTxLRsdHtrVOd3lyurwekdloOGgusAug1eISR02/TNSgOlpHL
 hOaZEFhx2RSLpL7xCKt/Xif8qUicp+MZEaeOMzUhLUsC/dS7XQF6Fvj3FIbFeyqdOcHa
 avM1ba3bGXrBmHMRZVP3PCHLhcdGFOWaAE9ke2WO+mJmHNCWFOPI0rykhtDE3+zONEvU
 Fc5sm1ylXUihs11H9CId5cfCOHgEMpNb60ZzHjtbJ8gzuvaaKknn9xLjvq2MZGkcUMyS
 g3jg==
X-Gm-Message-State: AC+VfDxOolZvfcKxifuG+I63K8hxhqXQsuPXFLzRFGhuCSTD6+SZjn6d
 QNQYamSP5fgys1UBueOpjhAshaNsiMAFQWU+DL8H+9XP
X-Google-Smtp-Source: ACHHUZ40slkW82pVm54m64eG+QfKibaEDlxFeYWR/RG6WsEWjRXgXgRjf31/ks01f9K5fEYSHpEvWg==
X-Received: by 2002:a05:6000:8d:b0:311:db0:8aff with SMTP id
 m13-20020a056000008d00b003110db08affmr8544716wrx.70.1687793992609; 
 Mon, 26 Jun 2023 08:39:52 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 10/22] accel/tcg: Replace target_ulong with vaddr in
 translator_*()
Date: Mon, 26 Jun 2023 17:39:33 +0200
Message-Id: <20230626153945.76180-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

From: Anton Johansson <anjo@rev.ng>

Use vaddr for guest virtual address in translator_use_goto_tb() and
translator_loop().

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621135633.1649-11-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h |  6 +++---
 accel/tcg/translator.c    | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 224ae14aa7..a53d3243d4 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -142,8 +142,8 @@ typedef struct TranslatorOps {
  * - When too many instructions have been translated.
  */
 void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                     target_ulong pc, void *host_pc,
-                     const TranslatorOps *ops, DisasContextBase *db);
+                     vaddr pc, void *host_pc, const TranslatorOps *ops,
+                     DisasContextBase *db);
 
 /**
  * translator_use_goto_tb
@@ -153,7 +153,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
  * Return true if goto_tb is allowed between the current TB
  * and the destination PC.
  */
-bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest);
+bool translator_use_goto_tb(DisasContextBase *db, vaddr dest);
 
 /**
  * translator_io_start
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 918a455e73..0fd9efceba 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -117,7 +117,7 @@ static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
     }
 }
 
-bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
+bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
 {
     /* Suppress goto_tb if requested. */
     if (tb_cflags(db->tb) & CF_NO_GOTO_TB) {
@@ -129,8 +129,8 @@ bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
 }
 
 void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                     target_ulong pc, void *host_pc,
-                     const TranslatorOps *ops, DisasContextBase *db)
+                     vaddr pc, void *host_pc, const TranslatorOps *ops,
+                     DisasContextBase *db)
 {
     uint32_t cflags = tb_cflags(tb);
     TCGOp *icount_start_insn;
@@ -235,10 +235,10 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 }
 
 static void *translator_access(CPUArchState *env, DisasContextBase *db,
-                               target_ulong pc, size_t len)
+                               vaddr pc, size_t len)
 {
     void *host;
-    target_ulong base, end;
+    vaddr base, end;
     TranslationBlock *tb;
 
     tb = db->tb;
-- 
2.34.1


