Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 760BB736C4B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:49:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaix-0001gH-QP; Tue, 20 Jun 2023 08:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaiu-0001cR-1r
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:40 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBais-00023w-AW
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:39 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51a2661614cso6201841a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265077; x=1689857077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5AwidcO4tfQ++xn12IPRLJwHDY5LLSrHnZYAWEeDsc=;
 b=oHA1ewzoXz7Y5z4TTe7NiK1UdbgDTcmyTx0gUwcFk4XhPb3M/rwwZy5/3zKBpS1Qrr
 NO1ixT9nr14S8DGm5Z8nBpCkzs9JcKZAce+6DpxQqiTiqB5pHY9+lNVqZsDw8J+/dxmX
 ckdcD3nkpDpMIJwpiYydp96aLaWIThNjoHjLZc2UDVoU8+dfZSgNmUFKCg6PSCa9WOE/
 k2eu42zaldgLqP2a7RCytLfwZ+yV02tBVBrTvirY1mTk6WuEqDADMoX4nLB7etZ+nu/o
 XQtfmGs+JhOXAOGXtr93661BpmcLJYyyCzxWQhokTgsF67o69VVzhqi8HAKXnwye+HnS
 gwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265077; x=1689857077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c5AwidcO4tfQ++xn12IPRLJwHDY5LLSrHnZYAWEeDsc=;
 b=XHDrjkEClaQaAmZN/Fra0KMGe54TUgNN6JUeP9xMeQmsyZNFfHwxa2WgNBazZj25pi
 b2/0ymYNptE3kFg3DzEDTsM2chFoxAsJqKoxOzhVXLVUgXL8wkRLH4OANetCyts3wMGV
 FappfgZIHC2eBE7QqMzB9Hde0/iz3scQKgQi2ZYIRlGQodKcJmd1GNbNS7qB3f6ui1Xk
 7pVMyaBjVbDmhHoEZALlXnyvxMSRWnELfPIzMM9h4HZImlBQzSINpbtavykN9BiF9P1O
 g1H+SjR8WXwDv1Esp9N3kgQa0Gg5TV6RhpBWEtDr77cMwL6JZvLx7STEkdeF0xNqAZaR
 D9ig==
X-Gm-Message-State: AC+VfDwhrGUCD90Uf4btjH+MMSB0xeUzwn2CZoVpZQAPGjP7mxWO6wKJ
 cyhAKFrLr4aX4UZ6Obl45AKT+5EskkM4CuVUhKmgtOC3
X-Google-Smtp-Source: ACHHUZ59Xws9/BpM0va5EjWPnf8i2pKgULY5vDJf6nwXwb/mAgF9LoC/G5+xfm+4+Fx7NHlnL9bq5Q==
X-Received: by 2002:aa7:cf19:0:b0:51a:313c:4407 with SMTP id
 a25-20020aa7cf19000000b0051a313c4407mr8210666edy.6.1687265077016; 
 Tue, 20 Jun 2023 05:44:37 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 16/20] target/arm: Use get_phys_addr_with_struct for stage2
Date: Tue, 20 Jun 2023 14:44:14 +0200
Message-Id: <20230620124418.805717-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x531.google.com
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

This fixes a bug in which we failed to initialize
the result attributes properly after the memset.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 558b4b731b..7c4526e2da 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -39,10 +39,6 @@ typedef struct S1Translate {
     void *out_host;
 } S1Translate;
 
-static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
-                               uint64_t address, MMUAccessType access_type,
-                               GetPhysAddrResult *result, ARMMMUFaultInfo *fi);
-
 static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
                                       target_ulong address,
                                       MMUAccessType access_type,
@@ -2886,12 +2882,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     cacheattrs1 = result->cacheattrs;
     memset(result, 0, sizeof(*result));
 
-    if (arm_feature(env, ARM_FEATURE_PMSA)) {
-        ret = get_phys_addr_pmsav8(env, ipa, access_type,
-                                   ptw->in_mmu_idx, is_secure, result, fi);
-    } else {
-        ret = get_phys_addr_lpae(env, ptw, ipa, access_type, result, fi);
-    }
+    ret = get_phys_addr_with_struct(env, ptw, ipa, access_type, result, fi);
     fi->s2addr = ipa;
 
     /* Combine the S1 and S2 perms.  */
-- 
2.34.1


