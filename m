Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 962337A23BD
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBtz-0004Sa-6S; Fri, 15 Sep 2023 12:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtx-0004S2-5G
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:41 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtv-0004tu-GM
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:40 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fc292de9dso1741831b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796158; x=1695400958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPO8TcwjCQpKboJkMUgpUg7QTAvab+8lUqTEXa4XMVA=;
 b=uszINTY93z64c5xS2WK0WrEVGE6UGrafjRE03mus10CKe7mu7aE2FtW8qKKwJ8yjhO
 q+TvB/t9QUEC+DNRZbzW75fgRrtGyQeZCgoi+rn/ebq60HqfEuhz2ty7mNLinxx1Owpy
 Yr9eSV0LFtazxNtdybn/CzpPuandN51xVres2yVRO16HO6bXmfHEdKosVY20VukuL9+s
 GA+CUjYLfVU6vn3b4TO5v5sbZNCOcVplDuJaN/M0+/eSPIGixRz3taMekBoTb3DAxUIo
 lbosHRC1LI5O30G/E6gnrVirAiEBt494ub6MroAoro6hQ5sFX5t05oTW52GW5i1CjgJV
 fz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796158; x=1695400958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPO8TcwjCQpKboJkMUgpUg7QTAvab+8lUqTEXa4XMVA=;
 b=W2UtM/gjQV7CRNj4/frA98EDp2hEBtGBR08j+R7FusbMOoyLp2YR9KIkK16Hs2byU9
 ZKrWrltdiYVePg/JUetTfEzIdsGGBWW6BvA2ZkL6hz+Mc1Iw0pN1kj+CfMHbnuQpc7Wm
 nAEj7j6+j7yNpljBgIaYGPT1GFNhdPUVpCp87LQF/UlSoZPCBK+7J0D/Br2DL2kaqQjQ
 n4tTOZXRwDXKU9Wy7Qj13Ejcwu5zFPXWREIG2+XQ8XijK3vK/5kG1hkRGriC6VVvux8Y
 A5Jk30Bomlav8Ha7VhP84m29BajZzivSWyKeyfDxIW8gGhkS0fl23ZdR5E/MTeXskSgB
 w5yg==
X-Gm-Message-State: AOJu0YwO7P8U1ApgDsTIHGnX7PszDdMrlp7MfkI6cbjiB55URP7Spc/m
 YDoiv8+xDDOn3nFZhmW4CN6n/N6ykV+xUXcgz5o=
X-Google-Smtp-Source: AGHT+IErj3eEBUGFfIiLM+ImYDXNUSvcsf32VZVCBBM2Ae3hO5sMh3f+iXrI34EBL5H7vbLsoMTftw==
X-Received: by 2002:a05:6a00:1f97:b0:68f:cbd3:5b01 with SMTP id
 bg23-20020a056a001f9700b0068fcbd35b01mr5936723pfb.13.1694796158156; 
 Fri, 15 Sep 2023 09:42:38 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/19] target/arm: Use clmul_16* routines
Date: Fri, 15 Sep 2023 09:42:18 -0700
Message-Id: <20230915164231.123580-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


