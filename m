Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90A782E3D
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cn-0001Wl-FG; Mon, 21 Aug 2023 12:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cP-0001Tm-6n
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:05 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cM-0005bw-JM
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso18697195ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634741; x=1693239541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPO8TcwjCQpKboJkMUgpUg7QTAvab+8lUqTEXa4XMVA=;
 b=i9Pul3Abu2Ih4oaJAslQeER23SCU1VmvZM7Y5D30Y6DYKiqjKAPycL898FqD6Yrswk
 WtTxnlqy/CQZnrUQvp+7ToVsCOBVPBUmBRayPEVrpxRkRPoXwSSM7ff4CNsp3L9Ylbh4
 IErifGiIs4tfi1euqT+9QWZ622G5PWEIwsl0NcCn4mkpRD1bbxtL+UtfrwmH3fYL3xAZ
 EYDWmfQ0BzCz/pSoYzhWr8kgXp9xBuAbD8R+B07gR5UkV/L+xbulczPKWHSDeMFSUJFm
 GjwYJBzQ0RmVwYYArS3/liRh0H3I6CV2Jhwd+W0uCw/Cn2r3nUpZraZ2d9bvJ5ZNHx6l
 mQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634741; x=1693239541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPO8TcwjCQpKboJkMUgpUg7QTAvab+8lUqTEXa4XMVA=;
 b=CqEiOareqFntWce0MDqCF5MphP8y2qdnfTKoRUqiIeELsxc21JvUaI5Vf6HK4YxAzu
 KFIYkZCq3xUgtlpVpKhPiSk7bjD9gnx8lP1nJ8o3AxNeq22kn9+wZi8gvylOvQOkyu1S
 Tr8oTQyrVpQfFJ5+fnBh2j8xBv4FATBq2LI3NLbhawDU+FZTSFyeUjVlupfjcnQF5ga8
 5vNln62EiJlnxA0kc0+TwHPlXfRoNXDQgeqQxMn+ehFp8P58QeaC9+ihLX5FGWtI/vpg
 2rljaJ2YwBRij6kWnTNUWQxaBWxyCD+JyjjWhyA1I5vsFzsX1gZD+/eXTSaPAPxVMnSg
 nkQA==
X-Gm-Message-State: AOJu0Yw4cG/0Q2w0vqsvsosrTZLvqbAgPj1Sc2sQFwR2rDyrzR4M0qvG
 tbldTyk/ZmDthuqUhniB1zrF6u77hkFeuA3pUAU=
X-Google-Smtp-Source: AGHT+IGxjazfYQYWFo1Mr0XeTZgywJ5d64+5vU5ZTvdPXiUx0C8vzefD2+XIVmFMyKkjOWCPQm6N1g==
X-Received: by 2002:a17:903:11cc:b0:1b9:da8b:4eac with SMTP id
 q12-20020a17090311cc00b001b9da8b4eacmr4743575plh.56.1692634741170; 
 Mon, 21 Aug 2023 09:19:01 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/19] target/arm: Use clmul_16* routines
Date: Mon, 21 Aug 2023 09:18:40 -0700
Message-Id: <20230821161854.419893-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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


