Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A7759A41
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM9Xw-00038G-Tu; Wed, 19 Jul 2023 11:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qM9Xq-00036d-V4
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:56:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qM9Xl-0007IS-8A
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:56:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbdfda88f4so64928055e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689782205; x=1690387005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNPqefvQgMivoBtumxDAYGfl0jiPjDA6sqhpbGZ4NhE=;
 b=b/0hKs0QxDQccRusYNa5gcfxhSGWwRIFg3RS7TS0wQgh2xg/t4sOawHxqaNGQdze5u
 Y1ZS1No5vF3tbx5w5qdPbQ74gugYWY0XVGl8bOALogHaofJA5C4+8eYamZKn8poVx48A
 IFpqCc11TaMrB3JdRllZ+M1ZheG03HCZllNjiLBzGroGFcDX57QYxtQqo7vR9JqEShDO
 uxltFYAXNfBGZM9zMEk2d3pDUSzHsVcx1WS1S2yahaK1zn9UTrNwVxbvK8RwoZafVRTU
 whrKLmX53YODwWc9yc0AMp2S5DJn/J8FZjp/SIRBhKd3LwRlyDfUVyEbwiO+JZf/94rn
 Irdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689782205; x=1690387005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNPqefvQgMivoBtumxDAYGfl0jiPjDA6sqhpbGZ4NhE=;
 b=NfRWYN8rqCIBpWbMMDFZ4FFNekeEY6vgoHAL04FfTxlF66//c4Sr3q/bPFVPzsxK+P
 7vQIA7PT9yEmm+Ydup/FAR0EYiRGoqMFt4dSyDhMTnWlOepvinVGvOKJhUd9b0leYVhp
 ltV7gJlcQWVHUI4z5FVnBqrzGTZ5DAeJkuP23g7jG2X4jx9daEZWIi7Ssy1A2y9POJRt
 +LWUu99OQHO9w/jzvxeBA6UeY7gYwHonOO5zkuUNVgWXcdeU36GhFKvY5W4eX2amezTb
 8uEgMO7EENrkIryBtKSaaQoWye4CWc0CT6xY4JIdZhpPd5PmCgIo/rl3onbtUKgOJhMa
 mn6A==
X-Gm-Message-State: ABy/qLazkGmp/fwmrLQiRNVoIAuNNR5pGneeFEM/uwF+UBn8aFToM+Q4
 cyHq3VOFycU79e77AYnYWbRO5w==
X-Google-Smtp-Source: APBJJlGgWzquLKyXi8bSQ01KnUOq2NPGOneufKkjs87wk/2uABNKJmueYB5uSG+K5K7QpbkFlbc51Q==
X-Received: by 2002:a05:600c:20d1:b0:3fc:80a:993e with SMTP id
 y17-20020a05600c20d100b003fc080a993emr4651088wmm.17.1689782205641; 
 Wed, 19 Jul 2023 08:56:45 -0700 (PDT)
Received: from localhost.localdomain ([2.219.138.198])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a1c790e000000b003fc3b03caa4sm2351006wme.0.2023.07.19.08.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 08:56:45 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 1/5] target/arm/ptw: Load stage-2 tables from realm physical
 space
Date: Wed, 19 Jul 2023 16:30:15 +0100
Message-ID: <20230719153018.1456180-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719153018.1456180-2-jean-philippe@linaro.org>
References: <20230719153018.1456180-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In realm state, stage-2 translation tables are fetched from the realm
physical address space (R_PGRQD).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/ptw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d1de934702..6318e13b98 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -164,7 +164,11 @@ static ARMMMUIdx ptw_idx_for_stage_2(CPUARMState *env, ARMMMUIdx stage2idx)
      * an NS stage 1+2 lookup while the NS bit is 0.)
      */
     if (!arm_is_secure_below_el3(env) || !arm_el_is_aa64(env, 3)) {
-        return ARMMMUIdx_Phys_NS;
+        if (arm_security_space_below_el3(env) == ARMSS_Realm) {
+            return ARMMMUIdx_Phys_Realm;
+        } else {
+            return ARMMMUIdx_Phys_NS;
+        }
     }
     if (stage2idx == ARMMMUIdx_Stage2_S) {
         s2walk_secure = !(env->cp15.vstcr_el2 & VSTCR_SW);
-- 
2.41.0


