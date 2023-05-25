Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9A9711AA4
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:28:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLj-0005yx-GL; Thu, 25 May 2023 19:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLc-0005uU-KK
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:20 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLX-0005q9-Cr
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:20 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ae851f2a7dso12106935ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057174; x=1687649174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jZpc4ui8pytrAOHBcN47e2TS8aNKppKYujWBst2xkI=;
 b=a3VNenc59ZwfkPdbQlygo1lA3JV7RStXarxjq1Ev7kG684eT2geLvMt3sFkPjct1uJ
 M6C22JdR957+IM9U5p8xuYvppADAxuMJrBH5B5So4OIrQgsz5XuTN3YOByKsWFB1UOEY
 3pop/LsJqfcI9e6Nuz7N27blfei3Qde6gsmVOP8bguhnj+yvkt0Ao2ZdUmHq3J2nkist
 KsxgNFglI3vAfljj580x9bPwGDMv6ii33sdux/ubji6lV0HFKDs3QoMspUPNjBEzx3Wp
 HVORmL6LlDgXkXcLzKkEA5Mx2fRQW8eAetL9YxtL12pVvIkaCY5nSuM9O+Iv76oNIquK
 0NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057174; x=1687649174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jZpc4ui8pytrAOHBcN47e2TS8aNKppKYujWBst2xkI=;
 b=KCL8FuS2UvDNv8NjtFicklZ8rej0rUSq8fnH98OS4xogiAvDX0MBqrTrx/EtyR5mz6
 JdOFTMjYSqkwIOTXVcvRGgEOxEZVKyhPsFwRUigPL9UnV8wXbRM+IhV2yQrZFS6Y2quh
 Yi9qELB/6/JPyHGfQEAGb4hHjcw4xwFjmwEJkW3z4E1j3s7mPASnHY22v14R5vWaTB8c
 BzUo27N4LctOVs88bK7jY++l2IaLpDjrtZuDbrGuXH+PGIkw+r8Rno9L81nIPlStu+MV
 pOfSY5i1jgKv2YqFs6bmcBGS6IiymYfnGqBIJUCHAN+apspq1zDjbeg+JBa7hM9PFr03
 0UjA==
X-Gm-Message-State: AC+VfDxFivDZxwZf4LQov0UwJHEg7GaOmCHzZvByVFWirfKsxTnRXdoF
 u3bgJYvYpQw4vRs/y4IT/kLTRRGnY74i44TLPjs=
X-Google-Smtp-Source: ACHHUZ5dfVtdJRFjOcm7wNodERKlMnsViuEiwosS4m04C80CnVH9WfNL+UWl1+qD3KFs33CMpeCkDQ==
X-Received: by 2002:a17:902:7289:b0:1af:bfb0:e80b with SMTP id
 d9-20020a170902728900b001afbfb0e80bmr2945900pll.31.1685057174029; 
 Thu, 25 May 2023 16:26:14 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 18/20] tests/tcg/aarch64: Use stz2g in mte-7.c
Date: Thu, 25 May 2023 16:25:56 -0700
Message-Id: <20230525232558.1758967-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

We have many other instances of stg in the testsuite;
change these to provide an instance of stz2g.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/mte-7.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/tcg/aarch64/mte-7.c b/tests/tcg/aarch64/mte-7.c
index a981de62d4..04974f9ebb 100644
--- a/tests/tcg/aarch64/mte-7.c
+++ b/tests/tcg/aarch64/mte-7.c
@@ -19,8 +19,7 @@ int main(int ac, char **av)
     p = (void *)((unsigned long)p | (1ul << 56));
 
     /* Store tag in sequential granules. */
-    asm("stg %0, [%0]" : : "r"(p + 0x0ff0));
-    asm("stg %0, [%0]" : : "r"(p + 0x1000));
+    asm("stz2g %0, [%0]" : : "r"(p + 0x0ff0));
 
     /*
      * Perform an unaligned store with tag 1 crossing the pages.
-- 
2.34.1


