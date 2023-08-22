Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1DF783AC4
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLhq-0008Sb-CX; Tue, 22 Aug 2023 03:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLhR-0008Hm-Cs
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:21:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLhL-0004vI-KL
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:21:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fee8b78097so22832705e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688856; x=1693293656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whZhTEDPMBELkFvMwjXWXlrIichDByDyvyD7joRcNmA=;
 b=pu0t1jQgh7SGDf97nWrMoezLrknqeQzfIuFj0qufwXJjLT4wOaO19V7FDy+WitoPiT
 aN56btRnn8kVQhtR5/xC8MhvP2E2PnNWY5ZiGsYg7+B73S5xZJKsrDFeofvunIrmQ283
 utma7MAxJe6wAuLUxrZFftPu9RCMK31xh+T81l1Vc/0jJpm1GvgSsWkilZJdgeOxhe7w
 Tle8PoT2U093OWGoVYxR568c0DyMgYiBDwhpWQxYasDBzau2jhLxAUv6aLh9Svr4XoZu
 Ww5GKxELu76Jn6/QSHb684bcWclT8p+JjAmi07V2VLbXMS68Px3ronV4C88Oy6lsQ/h+
 9V6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688856; x=1693293656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whZhTEDPMBELkFvMwjXWXlrIichDByDyvyD7joRcNmA=;
 b=jt+VzfmEbno2L7J+KT0pHkFCMEg4kK/8vvmNABMkPKtrFzkaNzLvBd7zdSUwDmRlF3
 Fhv3xS4xoQGlnpspkC2CpWLCdwxrWCP768I34tGwyythgaS+UXJFvDSQAhf/EOVOSlCD
 7HhnzEKUw2Dff/Tgj9xsPesisAhRmGIf76mq5Z6PXX++UnI0v9uViesYkVirS5txuD3/
 kbHzLM1MXjTbcvx88utV8UMZHaDujcunWLJ4KP/6BymvZM2cKBf9bGDfcCVJnEwu6ZVv
 62FxI+/Q+8Kpm5a3QXi/dvmGh+e73RGTRt9cdSoJvLbJHzlQprKxvwRWDvlOs9WtnhSo
 gwKQ==
X-Gm-Message-State: AOJu0YyxVPTpkPY73pRxm10Mf1oInV/fcqLDbGceA7mJDXXhfo7Z+5ii
 pAmE+OuSXZz/oA+h/TuRyaISUbq0G19g9fZa1vrqPg==
X-Google-Smtp-Source: AGHT+IGD3zQKYEskr4//JCEo8EqfJxQESzU/w2+2HjP1/8rSDJXJjK0CNFaADULuTnDWafSZmD1o1A==
X-Received: by 2002:a05:600c:d8:b0:3fe:e812:4709 with SMTP id
 u24-20020a05600c00d800b003fee8124709mr5585408wmm.12.1692688855889; 
 Tue, 22 Aug 2023 00:20:55 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a5d4573000000b003143add4396sm14855820wrc.22.2023.08.22.00.20.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:20:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH RESEND v5 16/19] target/loongarch: Add avail_LSPW to check
 LSPW instructions
Date: Tue, 22 Aug 2023 09:19:56 +0200
Message-ID: <20230822071959.35620-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Song Gao <gaosong@loongson.cn>

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230822032724.1353391-13-gaosong@loongson.cn>
---
 target/loongarch/translate.h                       | 1 +
 target/loongarch/insn_trans/trans_privileged.c.inc | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 0f244cd83b..f0d7b82932 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -20,6 +20,7 @@
 #define avail_FP(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP))
 #define avail_FP_SP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
 #define avail_FP_DP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
+#define avail_LSPW(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/insn_trans/trans_privileged.c.inc
index 684ff547a7..099cd871f0 100644
--- a/target/loongarch/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/insn_trans/trans_privileged.c.inc
@@ -437,6 +437,10 @@ static bool trans_ldpte(DisasContext *ctx, arg_ldpte *a)
     TCGv_i32 mem_idx = tcg_constant_i32(ctx->mem_idx);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
 
+    if (!avail_LSPW(ctx)) {
+        return true;
+    }
+
     if (check_plv(ctx)) {
         return false;
     }
@@ -450,6 +454,10 @@ static bool trans_lddir(DisasContext *ctx, arg_lddir *a)
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
 
+    if (!avail_LSPW(ctx)) {
+        return true;
+    }
+
     if (check_plv(ctx)) {
         return false;
     }
-- 
2.41.0


