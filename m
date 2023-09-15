Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA327A26A4
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 20:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhDyU-0000ai-UI; Fri, 15 Sep 2023 14:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qhDy9-0000Op-Qv
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:55:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qhDy1-00063Q-TI
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:55:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso28627775e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694804096; x=1695408896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/yMeSDg17r131vfOqc2aALDyiRjWqoBE8K57WDmj+U=;
 b=YiQaZDRL7Z8nLtujY1VOR8omCj03jlWBDK5ZVmbTWBH5pjhBavlSgUCIvufFa6pbVp
 4YnPjIXlS1MqyXvA4iZJXAXh4W3/qF8hQpS15WApint6lWX69rHIkqzZMmmaxdt3CIV4
 60FtSSMea5IL6HS9xryc7a16/2m9LAKV2tEOtPWc+9By/SM8TnLGIlYyk6vRc35JgTXF
 KeVlmz3GK/sh+Cgr58ULXQ0l992gkpIK7TJvsUPXtfdeRB4GVCqJG2QF+NZxAJOd/k6i
 7i79Az0vTSi2F1RW/zd290F8MJeaDRE2nk0vkt1QjhZ6O/rCkCVMYgUDODxElU9qHUwa
 FZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694804096; x=1695408896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/yMeSDg17r131vfOqc2aALDyiRjWqoBE8K57WDmj+U=;
 b=iyB/VcHYgFQDWRAS4NTao8H1cUT3w7Osn/fsfLT8oNCnIA3ZfCIOXpdlYvbLhJF6NA
 sYF/YwZWTMEQNzUUazBjbq7BT3lem3HfIHAY64+ycKQwyLa/tNOitOWlDx16Pc+2cFVA
 S7HIm4DDDbHygDvwXkex0wW2cZ0avvcPUwvCslu60StJkPjh1/adfEBcqnsC+YzMwuN8
 7mK2HQVXR+remNzYWKVej+yUcjAvStVeutTt1FJretddB3Y3UAOKuPUHriOZxeVyFC6c
 dRqsDP5BspAHbZIcpjdFZFIpxl0WhIZX6mFRn7YB34d8huofZn2pymdR6uVLL8mYQ6tG
 mpMw==
X-Gm-Message-State: AOJu0YzMnGjdQ0XZtgRLIxjqj346IEYACZSazE4ccDvPbn4hOhBoj34S
 ac+kG72dCKWb/QBLSM19hM5C40aQtSoLlETTvVA=
X-Google-Smtp-Source: AGHT+IEaHxXPKq96p3IbrS/zOUrNr2A0n2i767iOjur+CujkmtsTuTXsbNW0iYXds7F0FCNQR/nNAg==
X-Received: by 2002:a05:600c:2201:b0:3fe:f667:4e4c with SMTP id
 z1-20020a05600c220100b003fef6674e4cmr2417519wml.12.1694804095936; 
 Fri, 15 Sep 2023 11:54:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a05600c294c00b003fee777fd84sm5298849wmd.41.2023.09.15.11.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 11:54:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 1/2] target/arm: Correct minor errors in Cortex-A710 definition
Date: Fri, 15 Sep 2023 19:54:52 +0100
Message-Id: <20230915185453.1871167-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915185453.1871167-1-peter.maydell@linaro.org>
References: <20230915185453.1871167-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/arm/tcg/cpu64.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 7264ab5ead1..ea43cf3c1ee 100644
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


