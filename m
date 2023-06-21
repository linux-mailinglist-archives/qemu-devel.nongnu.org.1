Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 406507383A2
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:23:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwoH-0006sL-Lx; Wed, 21 Jun 2023 08:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnn-0006dW-Tf
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:18 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnl-0000Gv-8D
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:11 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f766777605so7771048e87.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687349947; x=1689941947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgK1EIUfPfmDl3mDe16euilTLpZ88cE9U2pqwrFaRA8=;
 b=lacepKTW1gnxSO9oNe0llyWMElfFPc2lQImfAyDAsFjhjEtGfHxaiMNULpZAO3YUbx
 LWtyMsA3mbqn599AoWQ7pkqzt9H1xRY30uOtsbY6hZNl4Q3K3nrZ9U14X5zBjO5IM2a3
 mYGaXE822QGcq+4PYF/Ha5wva8998mkPoL9Rktwj6LQA3A9ASIjgevJZHw2ndICW+7Fd
 m6SBR2827gbRCKoHCozAXFa46vjTingLGjMjm076GQgHhnOVmpVdmryVgJjLLFtYSSbH
 WK3+uZtpp7mrb9VMLIQok5YkOdsw6jl1uX914dZjD0K/Gkc/XMF4CUFFVX9R41gmdY72
 J2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687349947; x=1689941947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgK1EIUfPfmDl3mDe16euilTLpZ88cE9U2pqwrFaRA8=;
 b=QQrv08PugwYXUExB8CuoYjzllukD3myMEn9g21j7vEnZqIjW/4jAizEum9Bkj8KwEM
 crgXPvOWJMYNlYPrwGB6dlHeDKTBqUxwXQ86iIj1Zs0cdlkFhUiMS6+I880avQ6gP0lR
 ipHzCrSpc9cMH1tVR0Ocxf3Mjpg2DpyerKPt9K2XYSp3qGhWstYHy8Ze0uRZjk1V2VXf
 zlv1ocvqV4Y/WylHwZP/TWw/qQlsBQH4rl4iE0FU8Oq0rhL27eFwyiVRFsHZ6H95drug
 0xFlB4aBTTAf72qoqXE5TKT4MKhkqlmaOOBm5ZdcNF6n26YaKK2r2fqLixo2Wh8ea1nK
 ZTXA==
X-Gm-Message-State: AC+VfDz8bC0vzOVlRbNRvMSQq251Knn5NLWuQFZmSHbpZ80V6r1Aehru
 E6aEIBQD71aFw0DPiH4odL4DAa1YUyyldz2Zgxz1iAtW
X-Google-Smtp-Source: ACHHUZ4mfXVnCdN02nGPulo6fTJcgOuyRNpy7ZP2xhowzextZuHTRr8EZIpU9shDBk9yzCzUuNpMGw==
X-Received: by 2002:a05:6512:449:b0:4f8:674c:415b with SMTP id
 y9-20020a056512044900b004f8674c415bmr6083742lfk.42.1687349947415; 
 Wed, 21 Jun 2023 05:19:07 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 s6-20020a056402014600b0051bdf152295sm543176edu.76.2023.06.21.05.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 05:19:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 3/9] accel/tcg: Renumber TLB_DISCARD_WRITE
Date: Wed, 21 Jun 2023 14:18:56 +0200
Message-Id: <20230621121902.1392277-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621121902.1392277-1-richard.henderson@linaro.org>
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Move to fill a hole in the set of bits.
Reduce the total number of tlb bits by 1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 4 ++--
 tcg/tcg-op-ldst.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b5618613cc..8018ce783e 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -325,10 +325,10 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
 /* Set if TLB entry is an IO callback.  */
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
+/* Set if TLB entry writes ignored.  */
+#define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 4))
 /* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
 #define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
-/* Set if TLB entry writes ignored.  */
-#define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 6))
 
 /*
  * Use this mask to check interception with an alignment mask
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index a4f51bfb6e..0fcc1618e5 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -39,7 +39,7 @@ static void check_max_alignment(unsigned a_bits)
      * The requested alignment cannot overlap the TLB flags.
      * FIXME: Must keep the count up-to-date with "exec/cpu-all.h".
      */
-    tcg_debug_assert(a_bits + 6 <= tcg_ctx->page_bits);
+    tcg_debug_assert(a_bits + 5 <= tcg_ctx->page_bits);
 #endif
 }
 
-- 
2.34.1


