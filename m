Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB072ABB6
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhY-0004fs-G4; Sat, 10 Jun 2023 09:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhU-0004e8-SU; Sat, 10 Jun 2023 09:32:17 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhR-0007d6-V9; Sat, 10 Jun 2023 09:32:15 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-39ca120c103so700617b6e.2; 
 Sat, 10 Jun 2023 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403932; x=1688995932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SU3cVAlEC5V+AeaChUUtygS0wbuAbiA+fnpYCqFmsbo=;
 b=dLOW/rtRNCHEif60jq1rZRJ9+Zb3dczMk9xJQbI90jJv3wrtG8aeY9FuNH8SmRHKg9
 Nb6wj7A/KSJK+pcTovgFt1w0a1Wu+sa4P3uqGhpBohqOeaXvpmASZ48mD4MEielmoo0n
 ttyhNLlX8J00c2AtG9F/QexcWC13U6RFsj2rXsS8nZRgfOOK6vqBE1SKEvfEOOZ8GWbL
 2PFT2V5q8X2lBkT72iGodFMZADEqiPLibnPWIlf1fxZv1g/D5w0Dq0UimhlZXYdCx9kU
 FzHf+rLQY3PIUfz6m7cL8f81l9/ROFJRuj3btEyTnVGr8UmdP0F4X5JmhDEy37GG0Qe9
 lXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403932; x=1688995932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SU3cVAlEC5V+AeaChUUtygS0wbuAbiA+fnpYCqFmsbo=;
 b=Xa97AxTkOqo9UkXjPYkyF7oR/OM7rI5j2pyhTImrUqWFiVKSyXbHkIugwpWfdHF+VA
 iq6AEnHJNHNATFvhJocIm4DnCuhaBUaP++nP2pFYLLW23oXgXpgRqAT15A1YKLk5OtRr
 wEb8IFrdhvAIPuj8k4SWI9wb8sBcJoHAvrEDlme+zu1Y4AV/LkS9k6pIQlm8LZrFZwVB
 Z0RcHng4oQahNk9lrTjtnYgaLWuLRtGhx0c6i9PaMtgTKb2AaZ8DxpH4BnS51f+IGJMy
 s/pJbYC7cjXk/hDVmQqUfAQyht/cBbWNIkJos64ovRXJm+LRZ14ZCfILE7fTPCu6ve7E
 m07g==
X-Gm-Message-State: AC+VfDw0W/TlS9sBcJaaDcHqZ72JgOPXmxOwYY7i115okbXy5xwn9Hm7
 zl/hFAsHRjczIEdYIKXBvY6A4E39Dmc=
X-Google-Smtp-Source: ACHHUZ4tx6jNlMzyiq5U2nX/333TkEhfP1g9p3ueg1IOS9MCU4aAfNIarYFZdxD32csw05re4L3Qfg==
X-Received: by 2002:a05:6808:1155:b0:383:e7c8:4000 with SMTP id
 u21-20020a056808115500b00383e7c84000mr1206181oiu.13.1686403932054; 
 Sat, 10 Jun 2023 06:32:12 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:11 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 13/29] target/ppc: Remove single use function
Date: Sat, 10 Jun 2023 10:31:16 -0300
Message-Id: <20230610133132.290703-14-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x233.google.com
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

The get_physical_address() function is a trivial wrapper of
get_physical_address_wtlb() that is only used once. Remove it and call
get_physical_address_wtlb() directly instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <302697d63d26caebefaeee1e45352145ebd0318a.1685448535.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/mmu_helper.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 64e30435f5..c0c71a68ff 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -168,15 +168,6 @@ static void booke206_flush_tlb(CPUPPCState *env, int flags,
     tlb_flush(env_cpu(env));
 }
 
-static int get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                target_ulong eaddr, MMUAccessType access_type,
-                                int type)
-{
-    return get_physical_address_wtlb(env, ctx, eaddr, access_type, type, 0);
-}
-
-
-
 /*****************************************************************************/
 /* BATs management */
 #if !defined(FLUSH_ALL_TLBS)
@@ -643,7 +634,7 @@ target_ulong helper_rac(CPUPPCState *env, target_ulong addr)
      */
     nb_BATs = env->nb_BATs;
     env->nb_BATs = 0;
-    if (get_physical_address(env, &ctx, addr, 0, ACCESS_INT) == 0) {
+    if (get_physical_address_wtlb(env, &ctx, addr, 0, ACCESS_INT, 0) == 0) {
         ret = ctx.raddr;
     }
     env->nb_BATs = nb_BATs;
-- 
2.40.1


