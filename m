Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C416B74AFF7
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:38:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgz-0002B9-Ss; Fri, 07 Jul 2023 07:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgx-0002AH-PS; Fri, 07 Jul 2023 07:32:03 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgw-0006bS-9o; Fri, 07 Jul 2023 07:32:03 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b723aedd3dso1399170a34.3; 
 Fri, 07 Jul 2023 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729521; x=1691321521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/XXRh6yu6qA8JEiDaWBBRsRkud1KT/oUbY2MdWOG+2U=;
 b=EJgvHmff4B578TLSMgpR0pF6FBbDx4w5bSumJpi9NCOf2jQaLWFLEAPIvfrm1Ci+mC
 tJ4FTrpPtoXanK93k+dpEdw15B4ZYQtXoBsgs+jps6TYJ6Ps4rnlxecyDAexzu4GaV0X
 NEggUd0XOC+/YpJD54HvSQwtsy4rs9gEH22QiSfr2yblNNGm3HsovN92ALuQ1AinpPD/
 eWKOqnO7j5RFJFzDt2tFqlnkEgLqTcZaXZvHYbwI/pB3FxW+FKX+E+M9R7sGX8YclpIN
 xMGBFMu2DTRIcF/g7bjVBOxzTgEPOCFR9Ao1A3k05hkIXys6e3Ux25ZXGWJbIl/Awlw5
 07gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729521; x=1691321521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/XXRh6yu6qA8JEiDaWBBRsRkud1KT/oUbY2MdWOG+2U=;
 b=jQ/QP8SiSpJKQx01k5TDsYBUYbkr3lOubtq5BqndFGiOoZ0UpKQf/6B2pmPMG/E0bP
 0XPjPyKVWsJm8nh68vMPasZmEUBtKR/Sjs6rZQ2ndNcEVIngvvzvPNHHvm3uUUBY/7a+
 eA83tnw2VW05n68Ir3PglPHwLT4PO5s1HWcHijDuEm8OJfVCcjrc9CkYGj467of8bz8s
 cMff5XskJmvLA7WgZQYdP0GxyM2XR93EMkVTp4ZJl6m06GWhqoyt6MfjNbi2kG+uEa6e
 2vGfNLYj7TkM4FE96qGzMFPHTjd1KTkb3Xr5j1Fd3LiBfNFuh5cXgS5UHTBzNuYGgbSy
 RYzw==
X-Gm-Message-State: ABy/qLaVbyH2crm8SYnht0biKdCsD/SFwH7Cttbd801RUTxYWRtJXXOD
 Ru2Sv6cXrRVtvxi1Y5/RFlIlk6AQvR4=
X-Google-Smtp-Source: APBJJlG2kktTtLrirHGZhsgk5Zn+JIvk7PNDMiGjmH/FTB22LF6nPXQ2QIAftrmfYELzWdguKb2lWA==
X-Received: by 2002:a05:6830:2007:b0:6b7:4a5a:2711 with SMTP id
 e7-20020a056830200700b006b74a5a2711mr4072145otp.36.1688729520783; 
 Fri, 07 Jul 2023 04:32:00 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:00 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 15/60] target/ppc: Remove some more local CPUState variables
 only used once
Date: Fri,  7 Jul 2023 08:30:23 -0300
Message-ID: <20230707113108.7145-16-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Some helpers only have a CPUState local to call cpu_interrupt_exittb()
but we can use env_cpu for that and remove the local.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <aa34e449552c6ab52d48938ccbe762fc06adac01.1686868895.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/excp_helper.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index d1d3d089a6..b2cff4e7eb 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2653,8 +2653,7 @@ void helper_store_msr(CPUPPCState *env, target_ulong val)
     uint32_t excp = hreg_store_msr(env, val, 0);
 
     if (excp != 0) {
-        CPUState *cs = env_cpu(env);
-        cpu_interrupt_exittb(cs);
+        cpu_interrupt_exittb(env_cpu(env));
         raise_exception(env, excp);
     }
 }
@@ -2691,8 +2690,6 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
 
 static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
 {
-    CPUState *cs = env_cpu(env);
-
     /* MSR:POW cannot be set by any form of rfi */
     msr &= ~(1ULL << MSR_POW);
 
@@ -2716,7 +2713,7 @@ static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
      * No need to raise an exception here, as rfi is always the last
      * insn of a TB
      */
-    cpu_interrupt_exittb(cs);
+    cpu_interrupt_exittb(env_cpu(env));
     /* Reset the reservation */
     env->reserve_addr = -1;
 
-- 
2.41.0


