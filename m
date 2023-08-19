Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29704781638
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:04:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMK-0008Rh-7t; Fri, 18 Aug 2023 21:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMI-0008QV-F8
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMG-0007LS-5K
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:30 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bddac1b7bfso10763355ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406946; x=1693011746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZh7KEWKFGt6A4dyVK13WHinjbZLYVQb3GflKbX48PQ=;
 b=nHSf3lhu49Z5FSGNDBnw6e94UBjSAzSjIS5SOkXLdo9wknKm4VR+2GUcMsCUmj99z7
 FXHp2/FN7gzeM3cZ3Nybkj8vcBRktmL6knVPrLujnfgUtmLjvkeTfj053FfaY2ussB1a
 0iSW1ydYc5Uv/iWrQIOMEknhrTJZBph5YV5k7cDf4GQyIqzKgzaaQbkdWIk49mt3xx4Z
 uWAWdswlGicEQLSPdPJiXgb6SEMrTnOkvsYlT83Qmgas/G80cTcfYZodjQGQa9fZFBgF
 xugCMhQ/Ox2SYXD3GdxvWBn315sZxc1w5YtTssgEHiKlzfXO1KUV+RrcmLRKfpLRRWIO
 lUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406946; x=1693011746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZh7KEWKFGt6A4dyVK13WHinjbZLYVQb3GflKbX48PQ=;
 b=Hv9VEYrBAf9jNvPBHNTQ//WKl5G+bJWuD8Zv+QrNIQt0ayZ0ktzhThjLKQNw4FdVg5
 hwwJyQ8ZJtq6oLnNp9J3du8qxkV11nTcDas/7GfAOLkmAK9KGJJBYWsuozZNz9BURPmP
 759Juo9Fma2cQ6o6O1Te7DyDHyDuUThAMIIc59yrGjGRaDB0g4dzg6jZ7TrGFQuMkDYg
 OPMrh0hX4VqcU7fs9N61FoGCp4uHfl/So8VgOn1xEt4Glr5fF8Rpfce7dFmxdZaxsf6V
 wehJcyR2HSHzttzQIP8SXvqEsasQQ0xheJGSUx6u0opytyc//kC6cMFtGbO8BynRfZCL
 dNFg==
X-Gm-Message-State: AOJu0YwL0tYFQo6rA/mAsvOmMpHNNqzVm3kNviy1gVBToZB5edStul8E
 49Xm3TahYF+VGOCmBhkCXbgx3n3/SI4g4NxqJnY=
X-Google-Smtp-Source: AGHT+IGvQHvmWbHuOFGG3mjYrRbrZ9AcoMO/tiE8RTnhqBlszrcb3TYfda/C7TpFdGfHU8DQUKwz6Q==
X-Received: by 2002:a17:903:44e:b0:1bf:3fe5:5e71 with SMTP id
 iw14-20020a170903044e00b001bf3fe55e71mr1040104plb.6.1692406945784; 
 Fri, 18 Aug 2023 18:02:25 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 06/18] target/arm: Use clmul_16* routines
Date: Fri, 18 Aug 2023 18:02:06 -0700
Message-Id: <20230819010218.192706-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Use generic routines for 16-bit carry-less multiply.
Remove our local version of pmull_w.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h |  6 ------
 target/arm/tcg/mve_helper.c   |  8 ++------
 target/arm/tcg/vec_helper.c   | 13 -------------
 3 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index c4afba6d9f..3ca1b94ccf 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -219,12 +219,6 @@ int16_t do_sqrdmlah_h(int16_t, int16_t, int16_t, bool, bool, uint32_t *);
 int32_t do_sqrdmlah_s(int32_t, int32_t, int32_t, bool, bool, uint32_t *);
 int64_t do_sqrdmlah_d(int64_t, int64_t, int64_t, bool, bool);
 
-/*
- * 16 x 16 -> 32 vector polynomial multiply where the inputs are
- * in the low 16 bits of each 32-bit element
- */
-uint64_t pmull_w(uint64_t op1, uint64_t op2);
-
 /**
  * bfdotadd:
  * @sum: addend
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 96ddfb4b3a..c666a96ba1 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -985,14 +985,10 @@ DO_2OP_L(vmulltuw, 1, 4, uint32_t, 8, uint64_t, DO_MUL)
  * Polynomial multiply. We can always do this generating 64 bits
  * of the result at a time, so we don't need to use DO_2OP_L.
  */
-#define VMULLPW_MASK 0x0000ffff0000ffffULL
-#define DO_VMULLPBW(N, M) pmull_w((N) & VMULLPW_MASK, (M) & VMULLPW_MASK)
-#define DO_VMULLPTW(N, M) DO_VMULLPBW((N) >> 16, (M) >> 16)
-
 DO_2OP(vmullpbh, 8, uint64_t, clmul_8x4_even)
 DO_2OP(vmullpth, 8, uint64_t, clmul_8x4_odd)
-DO_2OP(vmullpbw, 8, uint64_t, DO_VMULLPBW)
-DO_2OP(vmullptw, 8, uint64_t, DO_VMULLPTW)
+DO_2OP(vmullpbw, 8, uint64_t, clmul_16x2_even)
+DO_2OP(vmullptw, 8, uint64_t, clmul_16x2_odd)
 
 /*
  * Because the computation type is at least twice as large as required,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index cd630ff905..5def86b573 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2029,19 +2029,6 @@ void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-uint64_t pmull_w(uint64_t op1, uint64_t op2)
-{
-    uint64_t result = 0;
-    int i;
-    for (i = 0; i < 16; ++i) {
-        uint64_t mask = (op1 & 0x0000000100000001ull) * 0xffffffff;
-        result ^= op2 & mask;
-        op1 >>= 1;
-        op2 <<= 1;
-    }
-    return result;
-}
-
 void HELPER(neon_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     int hi = simd_data(desc);
-- 
2.34.1


