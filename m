Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44998752C06
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eI-0000I4-T8; Thu, 13 Jul 2023 17:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eG-0000He-M9
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eE-00016g-9g
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:52 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3094910b150so1342729f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282888; x=1691874888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joE7iM6kvkwj0QEtXA447MLGCwlorW8Lqpd1o16zxAo=;
 b=FrdDIhdqXHSAtYxZK82P+sbDZXBm9z4pOPiExBL1CvvkBu15dy7uqGfyMAHvznqnSW
 WPUXf+HZq9P0iOiiVcIjmv2Ew13PyyU4NCTyvEyjiwy1b29hFoYJcuq47/zJiscyVbgW
 HmpIve4kpL28wHY0qQHnj9OXpTA0irmSK/4UHIiFR90tY2EWUFohrEy+lbbRwAjObLOR
 ZufIYxp2D4RWINF3X4/PMjkp0XBwgmCKY7CDyd/P2dZWkBTqEy1noSYl7gF+HgFvptGg
 etEBoIsAI2QUU/c3+16oXFTHMG7zgXNd5wGYhOJ+6sE8Iz7ICSSRRvP/kJQzLEwE6901
 CBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282888; x=1691874888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=joE7iM6kvkwj0QEtXA447MLGCwlorW8Lqpd1o16zxAo=;
 b=YLCWC+LMbo9p2Dv2BnUzJbOihczUz+Y93npa6CUWt+L60IRRt7tK6RUcjRxJCEAkru
 bNUIMFA6g/wl7xsSAbysuACSTof+PvCOiiM629byRCn0KQ8xWy+e4JHSUyRgh/QY7COd
 LLpd3KdHphD4neRVlUMWUSY5eL6rUMLSFUMOUCNYKpx3os8r2u4qFqx95/GJat8qa/6B
 J0/yeQl/smul5OcXWyEC7mteXtXTQWF9WGYlZoq+OIFWPn3TaPszEYsFKiKDTRcfO5IW
 cVy5yc7JVmSvMNINVYl+lEUcBSYEputpG3/uu6WxYoZSYpGXxF7JWrtcki999JM7a8kw
 dtKA==
X-Gm-Message-State: ABy/qLbZer8cOz1QW9JAQL2EnKx4BXwxf9UEyVpLP2YSxcHpTjEt/qYK
 YRy6t8q/jCZ+U+daO0G9JrDEMmfxnlb5qQdJ5VtmiK3M
X-Google-Smtp-Source: APBJJlEXgbOOxdy1YqLkyeIgdzQUuSA0vaXErS2KU5lTLGV71/jQ2QpwztABIv0c+Xt+OUfvgYKtjg==
X-Received: by 2002:adf:d4c8:0:b0:313:f07b:8027 with SMTP id
 w8-20020adfd4c8000000b00313f07b8027mr2606481wrk.36.1689282887984; 
 Thu, 13 Jul 2023 14:14:47 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 06/18] target/arm: Use clmul_16* routines
Date: Thu, 13 Jul 2023 22:14:23 +0100
Message-Id: <20230713211435.13505-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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
index 4384b6c188..1b1d5fccbc 100644
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


