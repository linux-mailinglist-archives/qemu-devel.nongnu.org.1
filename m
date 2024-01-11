Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F182AD0E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:12:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssa-0001Rz-V2; Thu, 11 Jan 2024 06:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssA-0001Mc-5J
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:19 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss8-0004RB-7H
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:17 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2cd5c55d6b8so44181831fa.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971114; x=1705575914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ht2SfbwBAKAnjagPGJMRAPfEfW3fn0agSes/TIkhhrw=;
 b=HWfkWD4mfsJUYpz6KUZkuVHWtrWVKB9lzW68dUFhWMsjOvtwmf6UZg4iknN7LRZsNL
 NUtJCFYmq0YZqbYBlTmu11ognZV5JVw+AulQcEZtUQOTOpL1LG72o5k2EyjMrUxUy198
 S1KDfdrHFx42up5Ifh72gSGalye7DBlhqJ+Jx/XJHVUhMisLI3EoJBd95nzvfV4QpUXN
 3X+4nlJZV3JG+HLkjMKUnHjmyZMbSZBLhN4peZi+JL3CYhx4qMiK2WhGY5PJmnG9hB92
 d99cUKzJoD8jBkSvmUd/l/ngXIcY+TWHLxmdTeaCg8kb2B4JTP4jEGDGjdCLsMxbii3Y
 BMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971114; x=1705575914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ht2SfbwBAKAnjagPGJMRAPfEfW3fn0agSes/TIkhhrw=;
 b=ljftqOFM7bFrmnbUFm4pCeDHRhHFTx3hfzzXQLsv42MlEJhbUgc1Nz19a5SyzMjnvX
 bpnKQLO8L6vdu8ReRO2nLF3MYz6XiIIdZCAW+Bw0/I7g25zpjUGnxwA6V/HGYNRMI25r
 Et3A56Ypz5+8tnc7XI7FPrKk/Awz8P29/ulG3d4UFtT9w+RzhP47xrde3oTVl3rmg5pO
 yNr+2HpAwhv5mSHID2LIaA6RNjYJCxZiwg6A8DxmsE5cAi4Qn4ZQ8SKmxEeZZCDvAhOw
 A8fmrh9dcuC01FgeRoDw910wpru/dQygmsJUe1FQWobaJWdR/cA1Plb7mnKY7gwV6SuL
 ynPQ==
X-Gm-Message-State: AOJu0YzkGuId86u/amd29i9AdGXUcFAs6yTP70Z1eCow7vTv4sA4WiT1
 wFT27u73JeNjzarx/cGDzVP0rpINd8BTlr7ctETYIuqD/c4=
X-Google-Smtp-Source: AGHT+IHja9/ptcLModQXlPT0+ZYdJ/ZP0AEnzq6buFaH19vyX5RtEavC7/8/OLABGZ+WanvljMkhwA==
X-Received: by 2002:a05:651c:317:b0:2cc:72e9:520 with SMTP id
 a23-20020a05651c031700b002cc72e90520mr189311ljp.44.1704971114574; 
 Thu, 11 Jan 2024 03:05:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/41] target/arm: Move FPU/SVE/SME access checks up above
 ARM_CP_SPECIAL_MASK check
Date: Thu, 11 Jan 2024 11:04:42 +0000
Message-Id: <20240111110505.1563291-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

In handle_sys() we don't do the check for whether the register is
marked as needing an FPU/SVE/SME access check until after we've
handled the special cases covered by ARM_CP_SPECIAL_MASK.  This is
conceptually the wrong way around, because if for example we happen
to implement an FPU-access-checked register as ARM_CP_NOP, we should
do the access check first.

Move the access checks up so they are with all the other access
checks, not sandwiched between the special-case read/write handling
and the normal-case read/write handling. This doesn't change
behaviour at the moment, because we happen not to define any
cpregs with both ARM_CPU_{FPU,SVE,SME} and one of the cases
dealt with by ARM_CP_SPECIAL_MASK.

Moving this code also means we have the correct place to put the
FEAT_NV/FEAT_NV2 access handling, which should come after the access
checks and before we try to do any read/write action.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/tcg/translate-a64.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0f30e71f9bd..5975fc47930 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2190,6 +2190,14 @@ static void handle_sys(DisasContext *s, bool isread,
         gen_a64_update_pc(s, 0);
     }
 
+    if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
+        return;
+    } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
+        return;
+    } else if ((ri->type & ARM_CP_SME) && !sme_access_check(s)) {
+        return;
+    }
+
     /* Handle special cases first */
     switch (ri->type & ARM_CP_SPECIAL_MASK) {
     case 0:
@@ -2268,13 +2276,6 @@ static void handle_sys(DisasContext *s, bool isread,
     default:
         g_assert_not_reached();
     }
-    if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
-        return;
-    } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
-        return;
-    } else if ((ri->type & ARM_CP_SME) && !sme_access_check(s)) {
-        return;
-    }
 
     if (ri->type & ARM_CP_IO) {
         /* I/O operations must end the TB here (whether read or write) */
-- 
2.34.1


