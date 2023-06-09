Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C34872976D
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:50:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zel-0000uM-J2; Fri, 09 Jun 2023 06:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zej-0000q1-5d
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:45 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zef-0001Co-Lb
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:44 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30e53cacc10so1110271f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307659; x=1688899659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKweUm+um7BdrfNBLJAXxXtSgHD1qY+FtAWIpdBpZZk=;
 b=rCGC2gTU/9KGtVjglyjTAQ5nPPQ8YdLm4D2P9KMDJ9H4vFAuYWLJBclc/P8BwZ1s10
 CMtsMI94BtkKlPaauJ9zHdaj0zxRpNTmLEghgJHE4ihbl+QJ3v35+ww+21PoH36Ymxk4
 LFg4vNEjeGGQrB/wxomzArAXH/W6sNu+p9vPMnnXH/T6WC8JjfnoRTCQUaBneKpCviPJ
 AqirFrIdBBSFbthkW7PC+7gT54MxSsPkApj3cSzqHyhaeKRojpnnp0OTyxDngwiJ6LAf
 F3ZovC9yjrQqwXZy1L7I+y06qg+JZlIZrduAh8hfmHylRE0bF1FYLP9FviHFB/r5vkBf
 MrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307659; x=1688899659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tKweUm+um7BdrfNBLJAXxXtSgHD1qY+FtAWIpdBpZZk=;
 b=jtMjarxoTuR+8LN7CrTwREKm7l3T3kmu2vQ4OthmFF9bNyx4ebBGgCaZTYGGOYH1Y+
 39qyjV6cMJAQYQ+etG8Qnl2yh0xzzVjuKRdJVhdRTf42mD31+nE8S0ORHETPiI+PO11M
 JfgnpytxGpsj+fyVfNfCEXYpCMcZQ4+2Y1p4tb1rqAqZRfQUPTrxwjGSJPaSzXSfXq9d
 nM23sIlCnYKypS/u/2A0JYeJ4lNToT7NAFh2iqcGcM2mRFSQ1ug9P9PEfpQshewqhpT7
 u7DC6/96YIX8GxpOsd0YFWR0OQ4U9bxwlerj8pJpPxcYjnhGfFtst6HyA3nsk51TTUzh
 lAuA==
X-Gm-Message-State: AC+VfDy72b6tE3XDg7Mz2F7pHH8VLJM855NKc+/kDKuNTIpjuPVwxgKK
 dDQAUf4Nlxw45ObsrGHgYLFOhvBxYGN9boTLmNcGvg==
X-Google-Smtp-Source: ACHHUZ5Dm5CtzsJeim+rww1MEHZk3l9DUSFHI5cI11YJemwV9qdvzqCHuK4atNT3/ZEOBgOnA1tl/w==
X-Received: by 2002:a05:6000:1941:b0:30e:3dce:c49a with SMTP id
 e1-20020a056000194100b0030e3dcec49amr636763wry.2.1686307658956; 
 Fri, 09 Jun 2023 03:47:38 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a5d6dc8000000b0030aec5e020fsm4066472wrz.86.2023.06.09.03.47.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:47:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/22] target/arm/tcg: Remove CONFIG_TCG #ifdef'ry check
Date: Fri,  9 Jun 2023 12:46:58 +0200
Message-Id: <20230609104717.95555-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

CONFIG_TCG is always defined within target/arm/tcg/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/cpu32.c    | 4 +---
 target/arm/tcg/m_helper.c | 6 ------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 47d2e8e781..0672519b89 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -13,11 +13,9 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "internals.h"
 #include "target/arm/idau.h"
+#include "cpregs.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/boards.h"
-#endif
-#include "cpregs.h"
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 #include "hw/intc/armv7m_nvic.h"
 #endif
 
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 9cef70e5c9..0891acc29c 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -15,10 +15,8 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "exec/exec-all.h"
-#ifdef CONFIG_TCG
 #include "exec/cpu_ldst.h"
 #include "semihosting/common-semi.h"
-#endif
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/intc/armv7m_nvic.h"
 #endif
@@ -2345,11 +2343,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         qemu_log_mask(CPU_LOG_INT,
                       "...handling as semihosting call 0x%x\n",
                       env->regs[0]);
-#ifdef CONFIG_TCG
         do_common_semihosting(cs);
-#else
-        g_assert_not_reached();
-#endif
         env->regs[15] += env->thumb ? 2 : 4;
         return;
     case EXCP_BKPT:
-- 
2.38.1


