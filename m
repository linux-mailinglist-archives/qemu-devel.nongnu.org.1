Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 443C7786C10
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6es-000886-QX; Thu, 24 Aug 2023 05:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eC-0004Cy-53
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:00 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e8-00051T-Tc
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4ff8a1746e0so10054032e87.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869330; x=1693474130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y+S+NVN8xC+7Bg8xrjvp8JbWeFqO2fn6xwxI6G3BukE=;
 b=Qpc5HgxdmAWTTSkGDzTQQDpePKwEtRYqwuQwszVaqODWasaUEpZOT8y6aWK6h8D8Hz
 yNKacslVhZCbnW1fC9rz1aGnxkUagrERViBmpQO+AAxWMsoHr8k+bWu8sr0DzAkUdfXx
 WT1eSqGRLXUsieeEdoYVlCMEBlK3QjndPZgbKDQTnOOJd5p4us4dDKnefORGzUzDfd3e
 EArFvtyHDByWPFf7eU60ODVQpSSww3Qt795vHg1wH73ICMc7GzMrdEc6wjUZgb787QKP
 /3Imiujta3Kr4ZEFepDY4Tu87lF/67SePqqxbov7yXd4Sx9YqQFnd+hkw6EF0HZaR8r/
 jj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869330; x=1693474130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+S+NVN8xC+7Bg8xrjvp8JbWeFqO2fn6xwxI6G3BukE=;
 b=Mme62SEdXXyY60JJLYE+TzNzIcZ4gIQg1yzTIiD4Sde8Qpx4IftWY3v/edwg3qOsjd
 8qq+Yk4ke+wzXCZDqqvcf3eLpgdons1CR+tjD8wxsFUmQSqF+XPBvbTWBP4MG4OTETrT
 2YBRyTY7hbWE/0dEmo/20nP7dK/BTL3t8cXybdDT+UFVzDy3Nj5pJz6k0e0xgm3BqGhs
 kWOu4tXlyPeY1Epu08h7egCbLz5zlwMLdvfiAZHpc1VylLQwzEWaPF0TRsBARdZsu/jp
 wzbUzXcCYtW6DOLQ7kHG5xExiSYZw37zaSPH8aPyAy3TWo+kTG17MJizIyK3hgqqKoM9
 jzaw==
X-Gm-Message-State: AOJu0Yw+zzsTvSYsUBGK6JpRdSWeSfMe4to4jgc7b+nFGKpzi7FH+pJX
 uDamdLnulDDyWE5PunUZzb1ZXERgLLoJdWd2tlI=
X-Google-Smtp-Source: AGHT+IHz2Z4l7LBA39jLhLNBFQcaT/RzJSPM8OV5CPoQcwp4khEsbRRNoui43kP6/B8NNjBN9Vb0jw==
X-Received: by 2002:a05:6512:e94:b0:500:9d4a:89fa with SMTP id
 bi20-20020a0565120e9400b005009d4a89famr1559821lfb.22.1692869330432; 
 Thu, 24 Aug 2023 02:28:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/35] target/arm/ptw: Report stage 2 fault level for stage 2
 faults on stage 1 ptw
Date: Thu, 24 Aug 2023 10:28:27 +0100
Message-Id: <20230824092836.2239644-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

When we report faults due to stage 2 faults during a stage 1
page table walk, the 'level' parameter should be the level
of the walk in stage 2 that faulted, not the level of the
walk in stage 1. Correct the reporting of these faults.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-15-peter.maydell@linaro.org
---
 target/arm/ptw.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index fbb0f8a0bf2..07832eb8f76 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2048,9 +2048,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
  do_translation_fault:
     fi->type = ARMFault_Translation;
  do_fault:
-    fi->level = level;
-    /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
-    fi->stage2 = fi->s1ptw || regime_is_stage2(mmu_idx);
+    if (fi->s1ptw) {
+        /* Retain the existing stage 2 fi->level */
+        assert(fi->stage2);
+    } else {
+        fi->level = level;
+        fi->stage2 = regime_is_stage2(mmu_idx);
+    }
     fi->s1ns = fault_s1ns(ptw->in_space, mmu_idx);
     return true;
 }
-- 
2.34.1


