Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED1072B0F0
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:01:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Guf-0000ym-PP; Sun, 11 Jun 2023 04:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gue-0000yQ-B7
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:59:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Guc-0003Z7-QX
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:59:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f7378a74faso23262855e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686473941; x=1689065941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mp+80uEQkt8/jSa2bwpDOFe4dhC6+cPTb9ADdk/0oE=;
 b=Lntpl/tLzwChIdrOT2922M1h4tmPmJZV1cT8TRyvzNukM0+uhmGpwoZ2gacfHy1dNx
 4Qicjss9uEAchFDNmuru2VCqaECt6NnDDLNHOLIDmQ+DGAhZ+wu5/5M0j1O8/BCX6Wey
 SY1c1oa9kPVI4zr6RGh93rqoW+oF3Gff9hihZI/DqDa619SBlKQ81CDwPaC7LFlCrxnC
 lcZY2obeJU9ZZFx08nEOaorGi6BrAOhjsu4LdrQpie8gEKfHLdvc7cikR1Dd+1T3L/NG
 eX8klQ7zwMgBstw0S2t39ZEyooGR5SDyVqv3UXkCW/gTx/xE0pK4YFwmdsgU/NrEuhpn
 AaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686473941; x=1689065941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mp+80uEQkt8/jSa2bwpDOFe4dhC6+cPTb9ADdk/0oE=;
 b=S1srw3Vaw8L70rqB1ddRYMYwuLgXivJueEA3S4fyHCm0bl7vL/M+Y/qwBrPhR6qNPO
 JMErrnmPwKA+C9eBd5RHXngSJAg2WYZ4FiNpwegBpMhzQt8FHeZYSFx4yY0PqG7Vi5HO
 sRO0T/S1t87Kfps1/EsQqE4ZwZU06YZDDw2n4PkA5R2nztOKkl4+Z8khMyJkYdIPRVS6
 fV5/LFCTgq33izwjSMu28Qa7beub3qEyT5mCKvnz0xMFahqVp0s6C7hIH1PJ6gAtUcs/
 WNrL6RwedeQNn0n5LWWKCrCMtTXEuyyRSP2W7EV+1c4qrOWv9KUkmhOMyJM8U62MEiva
 2h8Q==
X-Gm-Message-State: AC+VfDwW3r9mkKn6/VvRg030KhRFFxLvYzJF9dFBGguR4j8TUCZlrMZm
 o7Lu2iT6oYNJvZ4Q2blGW3UR7ImMn/k7SarepU4=
X-Google-Smtp-Source: ACHHUZ6V1eUMyTy1/gr8TvXgt25o5O567Ye5QYeDsJj3B1dVFCILz5pb9SQrrrqnw8EP4HjU9BkXBw==
X-Received: by 2002:a7b:c397:0:b0:3f6:688:f658 with SMTP id
 s23-20020a7bc397000000b003f60688f658mr3739595wmj.20.1686473941257; 
 Sun, 11 Jun 2023 01:59:01 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 f3-20020a7bc8c3000000b003f1958eeadcsm7734318wml.17.2023.06.11.01.59.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 01:59:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/26] target/arm/tcg: Remove CONFIG_TCG #ifdef'ry check
Date: Sun, 11 Jun 2023 10:58:23 +0200
Message-Id: <20230611085846.21415-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


