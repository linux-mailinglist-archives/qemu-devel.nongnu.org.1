Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EAF72ABB8
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhN-0004XQ-AU; Sat, 10 Jun 2023 09:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhJ-0004US-Se; Sat, 10 Jun 2023 09:32:05 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhI-0007bo-8w; Sat, 10 Jun 2023 09:32:05 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-558c8a109bdso2384982eaf.1; 
 Sat, 10 Jun 2023 06:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403922; x=1688995922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Sl2e5J2P7CzzTWV/I2GqoPnpdspAWC5r5JbZ8SpEyc=;
 b=GGqyjDpetbxEeK/vivmcGrNU5L+tfDocrc4T+vJ4WpApfNfzHOkG/ZInB8+QpZHQnd
 bMvqWBW4RahB0bvdE0BqzkCy/JONr/iO1LjfoQrKGJOIv8xvvH1Smvs3wzJb9D2gJqrV
 sc1Z1fziLvSF/J9tgQxScSa2XRm2X7J2tWBm5Y6gIZ18pVKyIsvDwcjmNPcgXgOILu9B
 XUoVBhsucoI2eNqThOihANTJ9Sy0CK5I/UzhS3HrL1eLBxTMOS/q46GrnmY+VKorsF4p
 tfZRJ+s8KqDA4DJk0zOrf9ktflAt1ONNAUa+ShMuxhHWispHBexOovcQorXVyE7yovzz
 mk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403922; x=1688995922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Sl2e5J2P7CzzTWV/I2GqoPnpdspAWC5r5JbZ8SpEyc=;
 b=TpwifWTtdkgy4FZKBmayOeLUbuItZdzgoxYJsr2Lix7Up5TqNZi4eteF2HZwmHHKEw
 mevMHxKLtmW0Eagasx/TGq9/RLBAN8s1J6+up6npv4QbpQOcAOk1B0v0dJ9PEdPb8L5m
 SW0jC9uJ/kp+SiB1OfxN89TgWLSh3JBE5l4E8BMQ/QVseA3H9DifxTOLLso8o5mPWCU8
 VfNlHGKeccIcl7QAWapUtWvR4I+7NgmgP0579tykse4q6b+JPnYYfnDhZ/WZSK9uKhUq
 kexFr95n4Y/H6XFt3XRqgC5xdRu7lCKx+MNZaNB3Mk/0viMr9nm/DAzTxKTVjzgVF5tp
 cu9Q==
X-Gm-Message-State: AC+VfDyz8d/9QgmfMXTa4NCDFF2StZr53MPj8zMzFq35iSwlUy8Jq9QU
 7l9THt0/I8xPgagNMeThtBH7xwX/WFY=
X-Google-Smtp-Source: ACHHUZ52cLmSs/LdFv3BKYwDk7AYx4TyP88ZpUE8U6hZOzOIiInSf9eEn0MQ3Z7VXQF8eu3brIVMcg==
X-Received: by 2002:a05:6808:1287:b0:397:ee9d:7d42 with SMTP id
 a7-20020a056808128700b00397ee9d7d42mr794377oiw.22.1686403922624; 
 Sat, 10 Jun 2023 06:32:02 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:02 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 09/29] target/ppc: PMU do not clear MMCR0[FCECE] on performance
 monitor alert
Date: Sat, 10 Jun 2023 10:31:12 -0300
Message-Id: <20230610133132.290703-10-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc29.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

FCECE does not get cleared according to the ISA v3.1B.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230530134313.387252-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/power8-pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index c4c331c6b5..af065115f2 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -289,7 +289,6 @@ static void fire_PMC_interrupt(PowerPCCPU *cpu)
     pmu_update_cycles(env);
 
     if (env->spr[SPR_POWER_MMCR0] & MMCR0_FCECE) {
-        env->spr[SPR_POWER_MMCR0] &= ~MMCR0_FCECE;
         env->spr[SPR_POWER_MMCR0] |= MMCR0_FC;
 
         /* Changing MMCR0_FC requires summaries and hflags update */
-- 
2.40.1


