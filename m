Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F747CFB62
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:40:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCs-00041u-QU; Thu, 19 Oct 2023 09:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBq-0001rh-Lo
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:57 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBg-0001Cy-OG
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:49 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32d81864e3fso6132392f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722543; x=1698327343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=43lpcz9vl3gP1eW9caBPH21GU6XgpA6looK2xil7svA=;
 b=WV2D/6kQYXh6803Ds1QXr9pk1X0Y6mYE4yE64eaeDxmKSWpgSWpZgmzi/Ew+OyyajH
 2ZE8RYdqB8UM64Kz1V1eb2l/kaCyn8+MUJuQtP3uFt+WbEwLysNgEzoZCX5QjNq695Bw
 OVhLwpeweNREhFnyUXyJpW8Vd2W9KWQhxWkc/bM4zDnNjESydmcB8QtjYZbYDRjjEb2A
 T5qti7d2Pa9cn0r5nrBMdf4hIj+///3wyyZpva9JYIbz4FNXlKiqWw8C3Ul4uR+/WGox
 jYY9Qd0EjERF7vd1vRDPAmkl8w3C8FfDJMsTP9ZFz/P1QtoX/cWOJMhdBHBcw8nvs5vv
 1SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722543; x=1698327343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43lpcz9vl3gP1eW9caBPH21GU6XgpA6looK2xil7svA=;
 b=VbfxWhK7JMh/D79b0+FdSa3z2qVhts+R7xLhZ2uqcsSGFAYglzM74vfURNJCv21soL
 ILFuU4gW71sF573LPcZt/XSkfmD6rVUyevH1BQ9Ffn8QSjMwPEuFcGE6QYcYAjCRX54i
 l/3d2fJK+uXFf1dJ3t5m8zNKrgMZ2WEXVzYj8RTCer+fvLVSuYGg7VhtUu/rDn0lgJHX
 QjYykJeggUzZdlqGJUVxMIGe0jFYLg+vf/5uC2csMzuAuo75iUAfD9QZ9f9nymT9AjYC
 /1Nku+LLjYNCtMTPdA16kjImx+4AwbLZEzEUcjJSejK/Z44ZtSv4vEx+0PwVVAQgcrvX
 4rWQ==
X-Gm-Message-State: AOJu0YzAFuMLpqmhQKbTfaEoWJxxnImsHdQ00xLKOVxfDbQ7oEjgyGOu
 VdTdVRKT+tFF/XWCs96UafbnZFRqm5pgTYQqCLY=
X-Google-Smtp-Source: AGHT+IF2x95JcqLLU88hITJiwgKSE5imJyQAxpN8+NH/yOFeoNV/t7oW4oxNJxvZ992dnA2mLQuOSw==
X-Received: by 2002:a5d:4391:0:b0:32d:d2ef:b0c1 with SMTP id
 i17-20020a5d4391000000b0032dd2efb0c1mr1313369wrq.33.1697722543157; 
 Thu, 19 Oct 2023 06:35:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/24] target/arm: Fix CNTPCT_EL0 trapping from EL0 when
 HCR_EL2.E2H is 0
Date: Thu, 19 Oct 2023 14:35:22 +0100
Message-Id: <20231019133537.2114929-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Michal Orzel <michal.orzel@amd.com>

On an attempt to access CNTPCT_EL0 from EL0 using a guest running on top
of Xen, a trap from EL2 was observed which is something not reproducible
on HW (also, Xen does not trap accesses to physical counter).

This is because gt_counter_access() checks for an incorrect bit (1
instead of 0) of CNTHCTL_EL2 if HCR_EL2.E2H is 0 and access is made to
physical counter. Refer ARM ARM DDI 0487J.a, D19.12.2:
When HCR_EL2.E2H is 0:
 - EL1PCTEN, bit [0]: refers to physical counter
 - EL1PCEN, bit [1]: refers to physical timer registers

Drop entire block "if (hcr & HCR_E2H) {...} else {...}" from EL0 case
and fall through to EL1 case, given that after fixing checking for the
correct bit, the handling is the same.

Fixes: 5bc8437136fb ("target/arm: Update timer access for VHE")
Signed-off-by: Michal Orzel <michal.orzel@amd.com>
Tested-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Message-id: 20230928094404.20802-1-michal.orzel@amd.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 74fbb6e1d78..01cd1474565 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2475,22 +2475,7 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
         if (!extract32(env->cp15.c14_cntkctl, timeridx, 1)) {
             return CP_ACCESS_TRAP;
         }
-
-        /* If HCR_EL2.<E2H,TGE> == '10': check CNTHCTL_EL2.EL1PCTEN. */
-        if (hcr & HCR_E2H) {
-            if (timeridx == GTIMER_PHYS &&
-                !extract32(env->cp15.cnthctl_el2, 10, 1)) {
-                return CP_ACCESS_TRAP_EL2;
-            }
-        } else {
-            /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
-            if (has_el2 && timeridx == GTIMER_PHYS &&
-                !extract32(env->cp15.cnthctl_el2, 1, 1)) {
-                return CP_ACCESS_TRAP_EL2;
-            }
-        }
-        break;
-
+        /* fall through */
     case 1:
         /* Check CNTHCTL_EL2.EL1PCTEN, which changes location based on E2H. */
         if (has_el2 && timeridx == GTIMER_PHYS &&
-- 
2.34.1


