Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3367728AA
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:08:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT1oP-0004kI-Hd; Mon, 07 Aug 2023 11:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT1oN-0004k4-Nd
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:06:23 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT1oM-0008E3-4O
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:06:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe2ba3e260so45726425e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691420780; x=1692025580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I/XlbSUuVjxTo5fYM7wDmHC5xUx1Fy/nOofMufEYAZM=;
 b=GjIe7gGerm5jZol7qI3ykm2ooiJrctFLfgZYmhzRgfklW+AlEVRbyFesQ5njAhoduX
 e+UZmELVeg+MEE2aQ4U2Y2O8FM6V3hZo+0QdbDPfsWrZD5uwNaToEe+Eb2r301psCEx5
 tiW+rQoQp3wyso7BrxkNEsZcCYGa5vkIrJLHEtU2/zOYCKuExjTzdt8ebKD91uc96GRK
 4sNgFMx/XRz1yaKD8TJnbZ6eq3DdzRPdHIgmySpKOTwQRNoqEdaYNxD0Ig8Nc+bvKZim
 sC4iE4DcRQk22cK3BU+MgNkkD1N0eNfe70TkZ0KZNr6kQHQY3gT4GQFy+jYxFHi1yGLr
 Bx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691420780; x=1692025580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I/XlbSUuVjxTo5fYM7wDmHC5xUx1Fy/nOofMufEYAZM=;
 b=FmbDgBvTuXUbUbkcINBnSpZFwfTyEe8VcTxyK2GkXNkOGEp8NGrkw9102yygs1XWIP
 kyJSwJ8OURAGJ9PPBObDs7ymIkjhlD7cvye5iylXHmyR+LxISnhBmElTG5aRDwLXgF/5
 16kNLGBk+4tyY3j00N4JV+hYoC+YTVHEZkxiA//fThTWSP4cykUwRnJZKNetxWjVrLLG
 3wmRfmwTtXTqqS/P0E3ft1nX+2aM2OpXmIwhH0+BnmWiFm6QNOSxi0CjsuC7le+b90hn
 1Htm0oW5sQITTqNiA3v0qwWYGK2WlWikQGbQ++PoyBHcXnZYtPyoVedXphzTjMpmkNrT
 u1aQ==
X-Gm-Message-State: AOJu0Yx9iYDQrtNlD2sGnTyGUz4HrtfhLbzvluHZykdqDAR/NOezoMcL
 9Vm/f5RUbYBH54Nydms2+9RDHA==
X-Google-Smtp-Source: AGHT+IFKQfoSMeq3/vQ3Z0ITaHBPIqv/l7wgxrj/8U56psT1uC58+Ny1XtFU813r89iB2PL8zJtTxg==
X-Received: by 2002:a7b:cb99:0:b0:3fe:5501:d284 with SMTP id
 m25-20020a7bcb99000000b003fe5501d284mr4110692wmi.11.1691420780171; 
 Mon, 07 Aug 2023 08:06:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c248400b003fbb5506e54sm10980442wms.29.2023.08.07.08.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 08:06:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] target/arm: Catch illegal-exception-return from EL3 with bad
 NSE/NS
Date: Mon,  7 Aug 2023 16:06:18 +0100
Message-Id: <20230807150618.101357-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The architecture requires (R_TYTWB) that an attempt to return from EL3
when SCR_EL3.{NSE,NS} are {1,0} is an illegal exception return. (This
enforces that the CPU can't ever be executing below EL3 with the
NSE,NS bits indicating an invalid security state.)

We were missing this check; add it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 1c9370f07bd..0cf56f6dc44 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -780,6 +780,15 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         spsr &= ~PSTATE_SS;
     }
 
+    /*
+     * FEAT_RME forbids return from EL3 with an invalid security state.
+     * We don't need an explicit check for FEAT_RME here because we enforce
+     * in scr_write() that you can't set the NSE bit without it.
+     */
+    if (cur_el == 3 && (env->cp15.scr_el3 & (SCR_NS | SCR_NSE)) == SCR_NSE) {
+        goto illegal_return;
+    }
+
     new_el = el_from_spsr(spsr);
     if (new_el == -1) {
         goto illegal_return;
-- 
2.34.1


