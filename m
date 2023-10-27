Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 314717D9BC5
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:42:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO06-0007BL-Ll; Fri, 27 Oct 2023 10:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO03-0007B4-RU
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO02-00086T-05
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:47 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso1389249f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417584; x=1699022384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3xRTp/BRadA7ZN58Un+Px0Mehec0HXObngq8aZKQDU8=;
 b=PzJAnLdvntFYHU6zE5HHnu12yQ5+52PKFrqYuWVC5/4xCKZ6L96BclGNk7XIajPc76
 MXmSc8HkDktgMMzY/yXChEVbO1UHD5yi5lh9cb9A+Xlx3vUMIDTs6RapU7BUJLinFTRV
 nPs/Ov2zrI18V2oxY7Dp5YHr1jgMtnCTVl/hlhTSbGvsrrh2jX8H6HXVBetI0Ojo6Rbw
 MpV4Ph0dSrkbJDIVnsyUQJKNVFGGRPtW80lIR3SRmxH4R+HxMrfccXNtA+IKT1bOQx35
 LNtbfE28rbxmXU4n5TBLRP+HsMXmxrMiAFurmIQQb70lb865rqtgcSUu4aAMjglI0lyh
 ET4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417584; x=1699022384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xRTp/BRadA7ZN58Un+Px0Mehec0HXObngq8aZKQDU8=;
 b=bvzT9+sFDK9YccfdMQxfGEr/ywJjr4HzrMLFWwNv93cEarLUsw4YupTK04jCvuMFwb
 H6GFhyMmdaQrezMdycGLnSxG0vVV4Ra+TDfSy+xDlrkbICOKv31LIdqUhTi5XtiNiK/A
 5IODmW7qw16TD4UrlXxLLE8PG0GIFuWVMGMrgbs8oA4e0wAbED1o1+nOKUmQ5X63a8+O
 XyoFvKGw0UzPlzfRoUu8HudJClWmyTcKmsr7UbMIfd+T0ToPxNeMJT7of8uNKYEZlCeK
 +ryl+qakAC2IUJV6DZXfbpCj9dzDfCIxnMJmM1IPA6Lo7iUjmdwmFZmPRnzogbKCGeow
 7rag==
X-Gm-Message-State: AOJu0Yxj14RWCC+uGjjSwbaMgwnnxJQlvVadQ3PWzFuvLR+IEzr+cxuf
 Y7323svlOUgi3FPTheRIhboItVBstEpTNZcLwbQ=
X-Google-Smtp-Source: AGHT+IHTBqEud57WhQd9jidMP4tHr02SII/43v60BJPrHE1lgxGwbE1mfXICHZkqcFnc4tcgCJenyg==
X-Received: by 2002:a5d:5381:0:b0:32d:939d:c7cf with SMTP id
 d1-20020a5d5381000000b0032d939dc7cfmr1868786wrv.52.1698417584170; 
 Fri, 27 Oct 2023 07:39:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/41] target/arm: Correct minor errors in Cortex-A710
 definition
Date: Fri, 27 Oct 2023 15:39:02 +0100
Message-Id: <20231027143942.3413881-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Correct a couple of minor errors in the Cortex-A710 definition:
 * ID_AA64DFR0_EL1.DebugVer is 9 (indicating Armv8.4 debug architecture)
 * ID_AA64ISAR1_EL1.APA is 5 (indicating more PAuth support)
 * there is an IMPDEF CPUCFR_EL1, like that on the Neoverse-N1

Fixes: e3d45c0a89576 ("target/arm: Implement cortex-a710")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230915185453.1871167-2-peter.maydell@linaro.org
---
 target/arm/tcg/cpu64.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index d978aa5f7ad..e2bcac48549 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -840,6 +840,13 @@ static const ARMCPRegInfo cortex_a710_cp_reginfo[] = {
     { .name = "CPUPFR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 8, .opc2 = 6,
       .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    /*
+     * Report CPUCFR_EL1.SCU as 1, as we do not implement the DSU
+     * (and in particular its system registers).
+     */
+    { .name = "CPUCFR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 0, .opc2 = 0,
+      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 4 },
 
     /*
      * Stub RAMINDEX, as we don't actually implement caches, BTB,
@@ -909,12 +916,12 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->isar.id_aa64pfr0  = 0x1201111120111112ull; /* GIC filled in later */
     cpu->isar.id_aa64pfr1  = 0x0000000000000221ull;
     cpu->isar.id_aa64zfr0  = 0x0000110100110021ull; /* with Crypto */
-    cpu->isar.id_aa64dfr0  = 0x000011f010305611ull;
+    cpu->isar.id_aa64dfr0  = 0x000011f010305619ull;
     cpu->isar.id_aa64dfr1  = 0;
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
     cpu->isar.id_aa64isar0 = 0x0221111110212120ull; /* with Crypto */
-    cpu->isar.id_aa64isar1 = 0x0010111101211032ull;
+    cpu->isar.id_aa64isar1 = 0x0010111101211052ull;
     cpu->isar.id_aa64mmfr0 = 0x0000022200101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x1221011110101011ull;
-- 
2.34.1


