Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA957264E3
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vHT-0001Wd-Ar; Wed, 07 Jun 2023 11:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHR-0001WI-E2
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:41:01 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHP-0001zb-Rg
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:41:01 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2564dc37c3eso585050a91.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686152458; x=1688744458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZZ7g1EQ57AiF5AHjTiAcP696FM9VhkE/s4SqVobKrY=;
 b=oxhAaeg+UEn9MZztaWoV1zcFpw0aA2ISAps6Ue/xze2ELtIDXNTE2ZpyuJiKNjtK2Z
 sYdFGI6TIM0Yl3+fIgdtcXleEvsf7UqmwlZtbIEwErB5xz5Mtb/mycjjeg3H+s+f0hYi
 PZW3w7ymTYZrI5QLPIw/fzWd8R6FIh6zs0c2aIRUUweMNSwcMjMJNUCzZqucpFR7CLMc
 WcXvA9derWcNDEM/GI/mcmrlQP8is6ImelQfN3L8KbHI2I8UFaaKPQdfKOuzWXfn3/GW
 cg/XdcHfbdvfE8woatZv5sFZtWUOTl96lut0eKUFdsQ86haiPBVaqDzBZ50UJs8xz8ef
 pp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686152458; x=1688744458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ZZ7g1EQ57AiF5AHjTiAcP696FM9VhkE/s4SqVobKrY=;
 b=RCW11BFUcXaShV0Dd00vXH1kgtUyzSz6xtgKmh7VXtoUMMRtFTL9WkhmEt5LDbSuYX
 UOGatS02KrqVEn/0e/3KxFfjRsphN9VZPnBJAShxL2+tAUB6gho+ksgZ3VNEzSEE/GcK
 6tG3qhRAjDCfeN4raEKPxrkOCGYtpR4ZtYy1W9AxXyQGyCEoOyQX9J8DclcCA7vRe1yE
 Qh6c91aznjKMjkmcGgDcGik+PvOhhfUN2Pxl1Ywet/svLBydzWCwEpxDoh8+qcL1uNN4
 9qEkI3FZTDHa91WRfEknWk1+cfTxRrXhWogU3Mv/xvVGONI/Ir1Es8pcpvFb079R9XJr
 Hlog==
X-Gm-Message-State: AC+VfDzRv8n+3hT5LnQU+ehkoFS8zmOtdEmtukCdTMLHqVHf0O9v0/Lo
 0Lc85glvWgUJY/KLcNlXz21DU79CHYsvVOylSC4=
X-Google-Smtp-Source: ACHHUZ4xebvCBFDP5UrdXJ0jNCfGUQEui1hLM6AbU6PFgo1p8W5mvfQT9K1TctRvULieQfo3KKAuww==
X-Received: by 2002:a17:90b:8d7:b0:256:7866:8c06 with SMTP id
 ds23-20020a17090b08d700b0025678668c06mr16806499pjb.19.1686152458540; 
 Wed, 07 Jun 2023 08:40:58 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:f25d:ffb3:64e4:8ded])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a17090a420b00b002591b957641sm1518066pjg.41.2023.06.07.08.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:40:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/5] target/arm: Only include tcg/oversized-guest.h if
 CONFIG_TCG
Date: Wed,  7 Jun 2023 08:40:52 -0700
Message-Id: <20230607154054.625513-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607154054.625513-1-richard.henderson@linaro.org>
References: <20230607154054.625513-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Fixes the build for --disable-tcg.

This header is only needed for cross-hosting.  Without CONFIG_TCG,
we know this is an AArch64 host, CONFIG_ATOMIC64 will be set, and
the TCG_OVERSIZED_GUEST block will never be compiled.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index b2dc223525..37bcb17a9e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -14,8 +14,9 @@
 #include "cpu.h"
 #include "internals.h"
 #include "idau.h"
-#include "tcg/oversized-guest.h"
-
+#ifdef CONFIG_TCG
+# include "tcg/oversized-guest.h"
+#endif
 
 typedef struct S1Translate {
     ARMMMUIdx in_mmu_idx;
-- 
2.34.1


