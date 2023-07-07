Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAE974AFE0
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgu-000288-KS; Fri, 07 Jul 2023 07:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgs-00026x-Uc; Fri, 07 Jul 2023 07:31:58 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgr-0006aH-Dm; Fri, 07 Jul 2023 07:31:58 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b8baa72c71so1619577a34.2; 
 Fri, 07 Jul 2023 04:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729516; x=1691321516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXZYuV0S5l7xojy1QQFTF3No802/3qhj6TGWuKt19hU=;
 b=ItykRhhguuHij/D85IaFA3Q/z+djn/bmWehCkqq8hAX79O36ayXFEFv9INwZus4vcG
 Gif0UET8zSB4244lWMagGPGofYG2T+U1pwB4x/oy0XeRgHAHnAbijZ0erg+hSbZm39ZG
 usKZEqUp6OfsMkroygDDgM7rGNY3eFiWRgzO/Rg2YJfAFOZmk+l5F5fUPGRypab2UF1T
 4eqESFCEWRYVyswGAbNknoD5iTa5Uh6RzQMmxfJF9PzA3rDqysPxqN71+yzLyvqGVjjS
 IHePjLYVrD1MIniPZpgih0mdI2CMVY9ehg5ZD6KWu4X04LOQ3o5qFqTIkgxGwBbbDDs3
 m9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729516; x=1691321516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXZYuV0S5l7xojy1QQFTF3No802/3qhj6TGWuKt19hU=;
 b=X2HGdd8cc/ofP8sPGnr8Xzg3gjZ5jx+C2Rx75NVw7hlvPgaYsF6y0qJcMB1Q5Eokpb
 0dba2jVbWoQIOJ0PTD43c4W6uu5MBRWsuKd1bg+CpWRNRWdSKGSCg30lsA8PeHfWjGVF
 Co0N6sn/cxAxvJQj4ifUTFzE0IroYk4zUYkKf4JLeTkejdfoCHi8fqLip9ATrZEpl+NG
 02XnGiH8GFO1bNB2nTO7B6pXrzIaHvwcwd/z7YoVREweiU1ZeZgoURD78+pfVZmFUJMN
 Ti3uS1j5kq1sFLtQhkUdSjsjHZQpqCwTF8ulZw2CbB2ENpOR5TbrsWP3+YvjCzTIEqpW
 i6kQ==
X-Gm-Message-State: ABy/qLbHZ24EC0/Cdkc86csPhknS5ShWRABGji0+oYGrVZ2TQix9LJhZ
 D/SrfPiF2Fx55xIaTgR+hjtitokzgM8=
X-Google-Smtp-Source: APBJJlEirhXRdlXrCGPd2BV5sZ1pFY923hV/5nx7mL/OroO2lU3pWTU+nctrcJO6tTkoD/82uKvDpg==
X-Received: by 2002:a9d:62ce:0:b0:6b9:1ee7:5289 with SMTP id
 z14-20020a9d62ce000000b006b91ee75289mr533621otk.10.1688729515877; 
 Fri, 07 Jul 2023 04:31:55 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:55 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 13/60] target/ppc: Remove unneeded parameter from
 powerpc_reset_wakeup()
Date: Fri,  7 Jul 2023 08:30:21 -0300
Message-ID: <20230707113108.7145-14-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x334.google.com
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

CPUState is rarely needed by this function (only for logging a fatal
error) and it's easy to get from the env parameter so passing it
separately is not necessary.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <f42761401c708fd6e02f7523d9f709b1972e5863.1686868895.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/excp_helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index f51a8db075..3ddec06f65 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -187,8 +187,7 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
 }
 
 #if defined(TARGET_PPC64)
-static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
-                                target_ulong *msr)
+static int powerpc_reset_wakeup(CPUPPCState *env, int excp, target_ulong *msr)
 {
     /* We no longer are in a PM state */
     env->resume_as_sreset = false;
@@ -223,8 +222,8 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
         *msr |= SRR1_WAKEHVI;
         break;
     default:
-        cpu_abort(cs, "Unsupported exception %d in Power Save mode\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Unsupported exception %d in Power Save mode\n", excp);
     }
     return POWERPC_EXCP_RESET;
 }
@@ -1440,7 +1439,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
      * P7/P8/P9
      */
     if (env->resume_as_sreset) {
-        excp = powerpc_reset_wakeup(cs, env, excp, &msr);
+        excp = powerpc_reset_wakeup(env, excp, &msr);
     }
 
     /*
-- 
2.41.0


