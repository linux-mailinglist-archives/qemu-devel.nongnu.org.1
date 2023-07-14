Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A37753F3D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0j-0007N1-Rp; Fri, 14 Jul 2023 11:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0d-0007Lj-AE
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0U-00077h-Vi
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-307d20548adso2119401f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349617; x=1691941617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MCCxEvnOoEn5P3Xa8BG9DaZmOIjYscf+/hErEQPjuEY=;
 b=bVKjxHGjIpP1w+t7vzEtqfJ1o6HgEgP2gN/rGsnUY8dD0cvEANTv8WDTXs05iNPM0I
 q2xzu+qZRqHziqUBGPPQ3EuuSayZozHOZCwGmr/lOXYynCiMvGqFhwcRusAG2Y0TCyK1
 kjUNX2lyk9Kh3+8LW+TR8rdsiHHEz3j+VBP74yUEZWjNeOdIP1gjRwbVknZtYCb9CPi0
 OHFJWyhdSgGjD6nJ+k8kIsOfzvHBPDkY2MI7T/wwWJpkbocYzbKqtMuY5HdHoSZaBuww
 NAyOaEpsJ4PqlwsG3x2/lVlWt5Ihddduui+GxyLbqH28EMYSiHxZBAuFRyGC08H9r44j
 +fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349617; x=1691941617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCCxEvnOoEn5P3Xa8BG9DaZmOIjYscf+/hErEQPjuEY=;
 b=RsftwtU2BX2Rs57KAkiy8ED+iQsJXh2DhqKVTKNs2x9/i1DWZTuY3S3sVNLnABpFnv
 NnNJi1wdBwpbfKOhipclEbYjG3Ch2iTLN9y6yP2OUIpqolMXsxeZ2ae5etsQSK2p/o7t
 mQDIbjfh7FzsyUFqSBbH8KZXBrYyhBS1AudV2TKlcxnBFOdk8fbX4jp9C5pEvN8ZN9Lr
 badwEZ2ecPuW4nxAvp73gU5YFw3jfn5IQXP+xwbelliuzl5BMHGDtfx86uH8JJs2BgZq
 x+I30tm9yOYZT/4RZmJ8srhx65ddeP4Ek84hfq30uIwFRO5jmj/rsL4zMt8GHSCa0WP2
 ciGg==
X-Gm-Message-State: ABy/qLbqbwkl74ueo9JPA4m0ZQgoeUrLIVXQAdn57hqofd8r6KUF1YAg
 8b2jmCD4wOMGD7Pv/8GhDeho8g==
X-Google-Smtp-Source: APBJJlEWze+o3s+lyFXjXTEixPDmIiPboF1hTcfB/RA7QBFZ1C4eVg69phlBK6HqgohSbc4NXSl3xA==
X-Received: by 2002:a05:6000:1081:b0:30f:c5b1:23ef with SMTP id
 y1-20020a056000108100b0030fc5b123efmr4186750wrw.41.1689349617371; 
 Fri, 14 Jul 2023 08:46:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/14] target/arm/ptw: Report stage 2 fault level for stage 2
 faults on stage 1 ptw
Date: Fri, 14 Jul 2023 16:46:47 +0100
Message-Id: <20230714154648.327466-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714154648.327466-1-peter.maydell@linaro.org>
References: <20230714154648.327466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/arm/ptw.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ed46bb82a75..d1de934702d 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2046,9 +2046,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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


