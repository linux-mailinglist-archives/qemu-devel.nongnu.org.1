Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4860A752BF1
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:17:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eO-0000Ju-8U; Thu, 13 Jul 2023 17:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eI-0000Ib-U9
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eH-00017Y-9c
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so9863475e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282892; x=1691874892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fnmyc9DudD/G12QVt/hdI4bqnT7KT3GDxNaZP+FHbB4=;
 b=ROlyrFZuJgP+QGcoz0Wqn0TvnKcKqg4P2HwOCGvUzbpwlwS+VAIhC0sH8CJyeSw2MH
 EW4W7P6iFwgVadlbtoL+o2GSrLs7XSep3PQPRwAxtyS7f4Xyv/+w3BrNpbB29DTWqLMJ
 2sCzWtAyVcNkgHZTcs8uTCPUDvc9taur65X/o/Xz3sSte5R3f8qXTjbGFga9251n/y6l
 hgOyUKE7NuPJeaZpNRw7m/RhUhS6R/P5JbrywP97QOgpZCJPWh4yPHNbE/zniuN8ss/i
 Ro5zjycV6Vudwld7BT/7JA9lPylDxkqvaxEYSpX/kwE4KhEVWcS/iRKnQ+CDSD4jxZw+
 UGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282892; x=1691874892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fnmyc9DudD/G12QVt/hdI4bqnT7KT3GDxNaZP+FHbB4=;
 b=MhrXTeJoje/HjmVA3kSR2Z4TXF9T5Ywc7G1zKfT1bCRZDnMHogJ2MWXYnxLkwrpbXM
 zlIzKU+4X7PheuSztEkSzxyqcRwCioBODbC02/TTPO4tyb/6GZfLn6/ETK6f4fBo2wni
 Tv2g3Ietr9pHhU7Cs8T4bEklBjG7CWQhjVWzp/YRPAN+SVqq/B6mFkw1EPSQ9nu3kGRx
 pIjxcw+JdSWdRy3EDWfYTEbcYCdQcC0+4M/1bP2EXgnlnzv6iGH24pza9J/mWvnJ5rWM
 hEzy+84wWXcIX2fpoBJMmqQY/Bil16eMpcJd8VHxvDidY6F6mXRMVisBIt/G9kOFqytZ
 zSZA==
X-Gm-Message-State: ABy/qLYNYdrNsQU2oG79A7gQrLnZEejtbEVjdR4CxITAh7MTPyN2YFQL
 IRkuIjbRJNtdUnOmJ5K3k0p4E80AYnnXj+QtKBPqxmtu
X-Google-Smtp-Source: APBJJlG2U3Mldu2DVl9Zw400lCdchxL7QdXbl+wwOnLN8+cLNQMzccR87CL/lFdEpMBj7BaaV+4Iqg==
X-Received: by 2002:a7b:ce0f:0:b0:3fa:964e:e85 with SMTP id
 m15-20020a7bce0f000000b003fa964e0e85mr2810554wmc.5.1689282891832; 
 Thu, 13 Jul 2023 14:14:51 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 10/18] target/arm: Use clmul_32* routines
Date: Thu, 13 Jul 2023 22:14:27 +0100
Message-Id: <20230713211435.13505-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

Use generic routines for 32-bit carry-less multiply.
Remove our local version of pmull_d.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 1b1d5fccbc..c81447e674 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2057,18 +2057,6 @@ void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
     }
 }
 
-static uint64_t pmull_d(uint64_t op1, uint64_t op2)
-{
-    uint64_t result = 0;
-    int i;
-
-    for (i = 0; i < 32; ++i) {
-        uint64_t mask = -((op1 >> i) & 1);
-        result ^= (op2 << i) & mask;
-    }
-    return result;
-}
-
 void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t sel = H4(simd_data(desc));
@@ -2077,7 +2065,7 @@ void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
     uint64_t *d = vd;
 
     for (i = 0; i < opr_sz / 8; ++i) {
-        d[i] = pmull_d(n[2 * i + sel], m[2 * i + sel]);
+        d[i] = clmul_32(n[2 * i + sel], m[2 * i + sel]);
     }
 }
 #endif
-- 
2.34.1


