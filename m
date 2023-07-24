Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3892875EE73
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrK2-00027k-JJ; Mon, 24 Jul 2023 04:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJz-00026S-UB
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:39 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJu-0000eK-I1
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:39 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fb761efa7aso6133422e87.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690188812; x=1690793612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kx8DX46zDkvv/0NYLawLSaPgKsBMt29LaRgzXxGcPGg=;
 b=VJE8bUXXzaJDG06QLiLpqzguQc5+8z6r4khREXBoArNTUdmRHD+xDmV7oqNk00TCjx
 +N1GvQ17YNblLhwLjNaESgbaqqbxhrppHZq62Mbgr8a5gxVBEiMUvzwmgiypNjA/FHCd
 aUdIRdXiP3cykzp9wyt3sI0nD0HsX4cc1GhtatJqNWn6W3JKdVRjK0opmg0MGXWlPmHE
 Z9z2e+p5KmkotbQ2EaJ0FloyrjuhLRDkh9SlyA96VDgMVPcMpn6cL/cFjNy/OdJQ4HXk
 DinHe7b6gekVO5LbYommCNtWHvsuAgs9DD265Yyvs4p7nacYbiqpQ4YE25TMb0LyAcWG
 npEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690188812; x=1690793612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kx8DX46zDkvv/0NYLawLSaPgKsBMt29LaRgzXxGcPGg=;
 b=H/1ycwMZpCvnzErkdi10KMhqEIdThFtiagtjRKD8Uka3ZvxIjd5szji+mdCrG/qhy8
 28JUHrFQQguYkCJumyZcuPZtyMyG02IcOfOWEP/DSUjLkSo2Ijf4iLqY5wFPtk14glmb
 xCGWEHuyqW1xs7FBVK3WTkJu0n0F0FW4iH/llU4hN0Taa+rxxCgeIq86Ms3QMBqhP/kg
 9m8LbUVKF0pEMd7NSc9uqJAFdXAmlDFNwg6aN+mRypZnGXYdUJzwOFG7rO25+n5eyARq
 S2enuLKTF3ZJNZ3D2imCC3ycXP9GzAbfIrJ9EvanmI/5E8+zdVgU9tKVVZRVlcDF0u/W
 w3KA==
X-Gm-Message-State: ABy/qLYyezK8vYEVgCNR/zcXID26555+vUBF3SJqtBOT8Cr1Umh/waIp
 oK15rOPnkbVtYTlrdtvYIdKnMRtlywX5XmiZcmbwXQ==
X-Google-Smtp-Source: APBJJlFTKy1KD/f8cL9zmgFIvGcWSep6qfNT14+MSzntnb/uy4trmHQrWjdIphsMYbSTmQ1AnybZjw==
X-Received: by 2002:a05:6512:e8c:b0:4fd:fabf:b923 with SMTP id
 bi12-20020a0565120e8c00b004fdfabfb923mr578471lfb.14.1690188812140; 
 Mon, 24 Jul 2023 01:53:32 -0700 (PDT)
Received: from stoup.. ([62.252.144.58]) by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003fa74bff02asm9570994wmi.26.2023.07.24.01.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 01:53:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 3/7] accel/tcg: Fix sense of read-only probes in ldst_atomicity
Date: Mon, 24 Jul 2023 09:53:24 +0100
Message-Id: <20230724085328.4936-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724085328.4936-1-richard.henderson@linaro.org>
References: <20230724085328.4936-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

In the initial commit, cdfac37be0d, the sense of the test is incorrect,
as the -1/0 return was confusing.  In bef6f008b981, we mechanically
invert all callers while changing to false/true return, preserving the
incorrectness of the test.

Now that the return sense is sane, it's easy to see that if !write,
then the page is not modifiable (i.e. most likely read-only, with
PROT_NONE handled via SIGSEGV).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/ldst_atomicity.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 4de0a80492..de70531a7a 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -159,7 +159,7 @@ static uint64_t load_atomic8_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
      */
-    if (page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
+    if (!page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
         uint64_t *p = __builtin_assume_aligned(pv, 8);
         return *p;
     }
@@ -194,7 +194,7 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
      */
-    if (page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
+    if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
         return *p;
     }
 #endif
-- 
2.34.1


