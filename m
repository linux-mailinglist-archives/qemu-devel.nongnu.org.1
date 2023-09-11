Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA03179A864
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:55:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfhMW-0005qp-9f; Mon, 11 Sep 2023 09:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMS-0005kC-CF
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:56 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMJ-0003Af-Em
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:56 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31f7638be6eso3706259f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694440426; x=1695045226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ELrRVF0tIk1TLgBNd5bg7VAVQK5daGM7tIeCJh5jEMU=;
 b=LTLU7aUnq2AuqEJe0QjTzCJwvXz80xLixsWleczvAvCgRxOFwR1hwezK7vjSxA8ump
 o+y5C3QHOZardEBVMciNtYDdyZFv3drFq6CGt0uXhQwjglAD+j+W+kusHtH7R/Sr1wu0
 G0dRcT7FnifGewY6Oy99OSavUjZ0MnPEPchIQ3L2MjrTuFvKPUQ1NrREZPjhVh53WHQ7
 +ysStX6mBbkMisUllcKCzWf1wi4Exb++5oAEjcttJdkhkmphAhp0rQd2PVKt5lQch2I1
 6pVQdmWtnzvWNjKbiyaPoHUxavcUP3t508pv7Nm0gHWoxdDOiBDtm9sx50XcCm0uqtqo
 RS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694440426; x=1695045226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELrRVF0tIk1TLgBNd5bg7VAVQK5daGM7tIeCJh5jEMU=;
 b=dR/wCrr7wbjvk7qd4omks3emapnXAQhQ1tcl6JsUBIEpjVeSvSLoFP49NNn78AML1/
 cVV5IhD8vRq2zIocjkvSb4A6vNOY4V7nriTXIi4o9OO4HhJncgLnU+avauqiTKzcPshT
 DjxjDNDqLPkJSnPIkgxFVqYzbIKQcj+0KPFk5PAhiJjz+ZVUDqFBXUb5+WauWgLmDh+n
 J7uBb75Dlc3J9iZUmyZq74rCpa7o24yrclewkvtr3mnQcQdVGCU7aH1O2921oTOO4UCH
 mliTnmeYGv0Xj4HIy94iHg9uL689aPRem8HG6oN8C9ZtAn5yUxxb2rGVdgF/p58UGqeo
 /yYA==
X-Gm-Message-State: AOJu0YzDhvu12ZVuUBPkgVsmFuN2mvm1gAK+A5tXOipGXSjb3pk//vnR
 P2GhhRFUWEonW1t0WTRZZWo1SlPpNIoUFKkl6Qs=
X-Google-Smtp-Source: AGHT+IHYt8eGDXXWuhguUFtq0Yb2mPzUcXa5IBDVKdgIrhzd1FnYde1PVPuMH2pzU7ZSe9+Sl+A4vQ==
X-Received: by 2002:adf:fdc2:0:b0:317:5d1c:9719 with SMTP id
 i2-20020adffdc2000000b003175d1c9719mr8571670wrs.9.1694440425944; 
 Mon, 11 Sep 2023 06:53:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm10079758wrq.49.2023.09.11.06.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 06:53:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 6/7] target/arm: Update user-mode ID reg mask values
Date: Mon, 11 Sep 2023 14:53:39 +0100
Message-Id: <20230911135340.1139553-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911135340.1139553-1-peter.maydell@linaro.org>
References: <20230911135340.1139553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

For user-only mode we reveal a subset of the AArch64 ID registers
to the guest, to emulate the kernel's trap-and-emulate-ID-regs
handling. Update the feature bit masks to match upstream kernel
commit a48fa7efaf1161c1c.

None of these features are yet implemented by QEMU, so this
doesn't yet have a behavioural change, but implementation of
FEAT_MOPS and FEAT_HBC is imminent.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f9f7c3c39e9..ad84fcf041d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8621,11 +8621,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64ZFR0_F64MM_MASK },
             { .name = "ID_AA64SMFR0_EL1",
               .exported_bits = R_ID_AA64SMFR0_F32F32_MASK |
+                               R_ID_AA64SMFR0_BI32I32_MASK |
                                R_ID_AA64SMFR0_B16F32_MASK |
                                R_ID_AA64SMFR0_F16F32_MASK |
                                R_ID_AA64SMFR0_I8I32_MASK |
+                               R_ID_AA64SMFR0_F16F16_MASK |
+                               R_ID_AA64SMFR0_B16B16_MASK |
+                               R_ID_AA64SMFR0_I16I32_MASK |
                                R_ID_AA64SMFR0_F64F64_MASK |
                                R_ID_AA64SMFR0_I16I64_MASK |
+                               R_ID_AA64SMFR0_SMEVER_MASK |
                                R_ID_AA64SMFR0_FA64_MASK },
             { .name = "ID_AA64MMFR0_EL1",
               .exported_bits = R_ID_AA64MMFR0_ECV_MASK,
@@ -8676,7 +8681,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .exported_bits = R_ID_AA64ISAR2_WFXT_MASK |
                                R_ID_AA64ISAR2_RPRES_MASK |
                                R_ID_AA64ISAR2_GPA3_MASK |
-                               R_ID_AA64ISAR2_APA3_MASK },
+                               R_ID_AA64ISAR2_APA3_MASK |
+                               R_ID_AA64ISAR2_MOPS_MASK |
+                               R_ID_AA64ISAR2_BC_MASK |
+                               R_ID_AA64ISAR2_RPRFM_MASK |
+                               R_ID_AA64ISAR2_CSSC_MASK },
             { .name = "ID_AA64ISAR*_EL1_RESERVED",
               .is_glob = true },
         };
-- 
2.34.1


