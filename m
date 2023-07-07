Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BDA74AFDF
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjh9-0002Gb-LM; Fri, 07 Jul 2023 07:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjh4-0002CZ-1Q; Fri, 07 Jul 2023 07:32:10 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjh1-0006cc-L5; Fri, 07 Jul 2023 07:32:09 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b87d505e28so1675835a34.2; 
 Fri, 07 Jul 2023 04:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729526; x=1691321526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSjPJtnoWhizrDzsFo8/GcvWdyU/SbLxPtCP7GKNH4k=;
 b=VwCZ2tb6Ux2dOASlOEi4YLD0ulpHD/KQZLNr+FsYLBFgZHYOLiBy3zQ5Re6jiJx9Oe
 BPhC5idaSX9dX/MXYMMM0BHiPDj6sKpCxQrvxlMQOKAJ/bptU3zmfrQsGONBm5KQil/E
 wMSZcrrAEiTxF6JXt02Q+O0Wpuzqn10f8cp19nQEqk28+AplXoQzgyJfZrbDlNaEXYSO
 fKjkEoMUQ99OtMlyDqDNy9HVgpqTXVtmWkTnLUGIKNfwU99w12/moHRNVPqjRWBQ2STN
 LlKgrY5TsnAVlJaWUUGT413Ye5JACCquwYzRTVP6dN1t1EgtJu+2VLqKGZmsk+Cr4TRA
 E/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729526; x=1691321526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSjPJtnoWhizrDzsFo8/GcvWdyU/SbLxPtCP7GKNH4k=;
 b=YvLror6QQ4YDTHGKQJAEqTBKrJ9YmMFtc+/Txc32fptYlPH6PZEGKwOoF31DX/wKNy
 66WaoGjYH7XYiL9VYAVcAPkS8KVOkJzfTaZRL12u4yh+Uaxr7SX9SAVqPO3pZS6vcH+v
 dBqnHt6KdfJOdXpRPG9Swb3gEmriqsYjemM1npwkPiA6sGTw9fWF8DRkXrMNgl9ijrjU
 sARd3GqYrrYP9FChCdJSE7fDO4pokggUC53IWzBw9Ec5ZDNkCyLBs0OcjjrFp34JvKOB
 l5oI1W4u0R7oSMMWo2a9yEe89JkM9CrPBu4f9u8tcpPkUc9sYrtMwrr2GJqEZksnS25a
 bC4Q==
X-Gm-Message-State: ABy/qLbu+IIrgxrecUdOhvz+FJejIgGbFpw42J2vN8mOc+JHI2ZsVDmy
 adLAKZ6wf4FdRyJcViZQdwqLw307jiI=
X-Google-Smtp-Source: APBJJlH3m2eXebV135srYcPGsiuKnbr40de4VAESMJv6mKDbMPK5bSKgWlGKJ3ariwOG/3nLvjHw8A==
X-Received: by 2002:a9d:7391:0:b0:6b7:4c0a:5de7 with SMTP id
 j17-20020a9d7391000000b006b74c0a5de7mr4600856otk.33.1688729526204; 
 Fri, 07 Jul 2023 04:32:06 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:06 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 17/60] target/ppc: Get CPUState in one step
Date: Fri,  7 Jul 2023 08:30:25 -0300
Message-ID: <20230707113108.7145-18-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32f.google.com
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

We can get CPUState from env with env_cpu without going through
PowerPCCPU and casting that.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <28424220f37f51ce97f24cadc7538a9c0d16cb45.1686868895.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/excp_helper.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index b2cff4e7eb..354392668e 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1770,8 +1770,8 @@ static int p7_interrupt_powersave(CPUPPCState *env)
 
 static int p7_next_unmasked_interrupt(CPUPPCState *env)
 {
-    PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
@@ -1860,8 +1860,8 @@ static int p8_interrupt_powersave(CPUPPCState *env)
 
 static int p8_next_unmasked_interrupt(CPUPPCState *env)
 {
-    PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
@@ -1981,8 +1981,8 @@ static int p9_interrupt_powersave(CPUPPCState *env)
 
 static int p9_next_unmasked_interrupt(CPUPPCState *env)
 {
-    PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
@@ -2675,9 +2675,8 @@ void helper_scv(CPUPPCState *env, uint32_t lev)
 
 void helper_pminsn(CPUPPCState *env, uint32_t insn)
 {
-    CPUState *cs;
+    CPUState *cs = env_cpu(env);
 
-    cs = env_cpu(env);
     cs->halted = 1;
 
     /* Condition for waking up at 0x100 */
-- 
2.41.0


