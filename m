Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 463DB72ABBE
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:34:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhh-0004mZ-CZ; Sat, 10 Jun 2023 09:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhc-0004kP-T9; Sat, 10 Jun 2023 09:32:25 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhb-0007ec-AF; Sat, 10 Jun 2023 09:32:24 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-55af44f442dso1789453eaf.1; 
 Sat, 10 Jun 2023 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403941; x=1688995941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Orw+2LbKsD6HmacNy0CIx7cAvO9Sr9R07DsvrLPcJaY=;
 b=H2SviYwMnX9mvit/ctdhFKBJ0vFwVbeKEoBNTdZxNeHaXAwHBFpNpN4g8z3bhr2jxm
 JvQ3hlqw3TcWp0uwf7/E1sXxpJrGnu80Kcq5P+YOyLF4H3kVw4agYjLuYDeboBhMT3D8
 9vjnDqqvIhLpjHKvaC1YPke64KJSp2eAmpDm0WvhTMxHDOco4NMe84VmzNx83EALLM5Z
 PznBUltqsMBgxn/zSAk2AfXUcSxcnbafkYcXcmgYIjlKhn5i28GDP+9tP1kxJnqEC8AI
 5K8thcpS9nu8/hTFENFBPgp3AYdy0LOA5Ihv231wb9bGor1YfQpQ9OL3+b/y0xgAuyUG
 eIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403941; x=1688995941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Orw+2LbKsD6HmacNy0CIx7cAvO9Sr9R07DsvrLPcJaY=;
 b=lBTtZiQFL4cYY6KJ+k+MeI2XcCtwGdeolGjnUOjUtJwOEbzRGHF2HAvi6lkRw7MzBN
 NL/STFMPf7szE4NhWA/yIjEylEdMF89YR9BUU9NKw6jzFFAPhXZD2Tyuv3kzyCsfsrmJ
 sW7b0ck4CA/fVtQ/j+HB59Jluik6MNwen5xM37n7mQeHoj/GyrVkmACePBiNqLBtSMbG
 miKN2aE5D9Ta7BaZ8+t6bUGvc+Gh992T4fl18T1JLU0+FAkI6LSHEbXeXIWm+IiLKNEQ
 DknPv+s1smD7LuSpmK0rYTAIfrSCg6eqi6xasWUKRNvND6olCHeULJRwv9kocCazg3iX
 claQ==
X-Gm-Message-State: AC+VfDzFnErEXZAmNx4JdipT0p+L8K2YXa/k/Svf4W2u+iRKdWYDyNbb
 uNb32VmBPjfqFA9FEeaoEHDEVFujiGc=
X-Google-Smtp-Source: ACHHUZ4YSSNHdmWULAIS17Ub420BLyn/CCcWf2awvHAjXIMjmgVvQJ6uNg+/H1RU+tk1RQYveq3cyg==
X-Received: by 2002:a4a:4307:0:b0:555:82b7:6021 with SMTP id
 k7-20020a4a4307000000b0055582b76021mr2201346ooj.2.1686403941255; 
 Sat, 10 Jun 2023 06:32:21 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:21 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 17/29] target/ppc: Simplify ppcemb_tlb_search()
Date: Sat, 10 Jun 2023 10:31:20 -0300
Message-Id: <20230610133132.290703-18-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: BALATON Zoltan <balaton@eik.bme.hu>

No nead to store return value and break from loop when we can return
directly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <d470118c3adcbd41b1a91779f6bb7cbdb2b0d346.1685448535.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/mmu_common.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index a84bc7de88..ff7f987546 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -521,19 +521,15 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
 {
     ppcemb_tlb_t *tlb;
     hwaddr raddr;
-    int i, ret;
+    int i;
 
-    /* Default return value is no match */
-    ret = -1;
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
         if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
-            ret = i;
-            break;
+            return i;
         }
     }
-
-    return ret;
+    return -1;
 }
 
 static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-- 
2.40.1


