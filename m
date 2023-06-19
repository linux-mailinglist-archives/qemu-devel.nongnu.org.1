Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D9735B51
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBH2W-0002KT-1S; Mon, 19 Jun 2023 11:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH2T-0002IC-J3
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:43:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH2R-00011P-4V
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:43:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-311167ba376so3345837f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687189409; x=1689781409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mp+80uEQkt8/jSa2bwpDOFe4dhC6+cPTb9ADdk/0oE=;
 b=A5Ol5hrvszPQcwYBiIexbrSjN6hrfe8g5dZMa7rudjhOjqIqVs3oph7L56ul+PPqpU
 pHr+J4swS1Mn8DFbyVyJ5/ZB2BpZqciCTRVI1hvOQ+jf9XJjK00f6KXGh9IRqIEfMrFs
 IRck3/IU9Vld9qENJqRh41We70beNJN2oYETfEOvUetJP15W0TpIItTbZWmMg2qFDdkl
 wnPfaXsHGy9wtXUhPMcMyE3u+oYXXPim9NnD+QcM/4wJHW1CRCabzJhein+IQXsYhxG5
 wJL31u8DXoyvw10/i9wU1xWj8xfgx1jMnMQWO99E2z9qUyf+wFmcvACF/1FrjUst2shC
 DIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687189409; x=1689781409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mp+80uEQkt8/jSa2bwpDOFe4dhC6+cPTb9ADdk/0oE=;
 b=XBWpj2uRPnFA89q07a6UEMkCYBi0bytICHyWPWcdOX1rsyJDJ8JMnzyY+8x+T5jqzd
 qQcjL/T+jLP6nW0cmrlZ+Cbz3kxx3k1aZpSklVIy7tH4BqL/JoAtaGxh9gh/WlWh/906
 C7tYM674Mxl/E2x69VJ3gCLFOOMKuAXQ+3fK6I+vZqmBQRFusTgkIjoXFlJ9zKCJR+U6
 NzsQACJ19IAqIvdzC9Bvphe5YSRxPhroIKNEPNiRFFqZ6dOFZPp+HjDZcUG5onAFH6bR
 u47JLqRe1rhFE7JB09GhnRbZMqCptmsQzKc5Wx8TrB7iNwde47IOvQkhNuHDHx2cUCt3
 kwLw==
X-Gm-Message-State: AC+VfDx7/n46Ugy6OnS+U+XK9YhwiAaQhk2xAsmeoYTPxLFFbWpItCiA
 H5dv4XDOurwzalLCS0eLSI10sLCgNRib2zvcc3w6Jg==
X-Google-Smtp-Source: ACHHUZ6bkZp9UhHHO1qxbh26C/cpy2QZAjN/8zsqpV9XnHftLeVJi/U8xAuHFEdOdKGeodnL6iNP9A==
X-Received: by 2002:a5d:664d:0:b0:30f:cc22:d832 with SMTP id
 f13-20020a5d664d000000b0030fcc22d832mr8216193wrw.11.1687189409343; 
 Mon, 19 Jun 2023 08:43:29 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 s1-20020adfea81000000b003111a9a8dbfsm11417924wrm.44.2023.06.19.08.43.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:43:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/34] target/arm/tcg: Remove CONFIG_TCG #ifdef'ry check
Date: Mon, 19 Jun 2023 17:42:29 +0200
Message-Id: <20230619154302.80350-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619154302.80350-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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


