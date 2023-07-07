Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9517C74B82B
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:41:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGY-0004u0-HF; Fri, 07 Jul 2023 16:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGP-0004pz-Af
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGN-0004q7-Dw
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so24481445e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762470; x=1691354470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwwpiV6MaHNjI0ciuX+pvMo7jFfE+x6J89Pmy8AxQUY=;
 b=EYUh2BLPTRNhAdG8tv0Cy5osBdVuMu2/SSrMZ5R2SvfSdaE1zHVjASH1VhZ2UmDL9b
 VwSRdSaEhBMnmX4ocUljlSp5Zhd2sEG1Y1haV3Qo8dNA6RxB2acGAo3gKsT3YJ52gT/M
 MbksAWc9pOPXwuk3yiH/nhDXWWNVSTddTNHyN5gwklvWaDmFQiGGooZKBO4Tv7Zlj/P3
 sOCuwf1W1AisIy82XRFJ1yonbWO5Xrf6c0vHNR92KdvHziW1kXFt416EXGuLQCipmXxU
 Dwf09s6qtxmOXMmtT02qQgb1qQw2BCNMa/tjeQp58kw9LacxYEvPGrQbdOE6pbrgAjIZ
 o1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762470; x=1691354470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwwpiV6MaHNjI0ciuX+pvMo7jFfE+x6J89Pmy8AxQUY=;
 b=XoFzOQBrXVLDpm6B6zoQzsQRggGRffH+y9lrI9XwMileZnsgAzdlpj54idUDFCrSBU
 1tDZIeafODRpPFaxOOfCDyt4RKrW36/rGyIwR3m8S2d4dUCmOw5NBZvaBH4jwq7tiiPi
 HuOIb53crwo6H7TUmYGnvI3D9H65TQj3uMI8moadwCGf9q+/D+wPy9hyQsCtEDJfVbaX
 T6c/C0K1yR2n1+whtyXpF/cPcCqloDVnczku/bK5CRWwdQCIYNHp8/VQh4827x6mMP7i
 wHVO2/SIlp858TSKYZqf+ufDt/5l4Skt3FLETOcCCuHK1T6EzjE16yp8ZVId2SziOIPY
 3uqA==
X-Gm-Message-State: ABy/qLaDfTz+RrGNMpNisoswJPhkt5qX//O4Tl1MAth3cH4D6aVGS4oK
 4bN3qt4kXMwcIz7/2uzV3KrtEbpIynhrJXaup0Djyg==
X-Google-Smtp-Source: APBJJlHCtc985I8UNBn4NTu5NzCl42jYrWATxYFrTUbYHv4m9hVBOXjfKA3iE4x6yStXSqrsBimBLQ==
X-Received: by 2002:a7b:c389:0:b0:3fc:9e:eead with SMTP id
 s9-20020a7bc389000000b003fc009eeeadmr1688890wmj.20.1688762470139; 
 Fri, 07 Jul 2023 13:41:10 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru
Subject: [PATCH v2 19/24] linux-user: Rename mmap_reserve to
 mmap_reserve_or_unmap
Date: Fri,  7 Jul 2023 21:40:49 +0100
Message-Id: <20230707204054.8792-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

If !reserved_va, munmap instead and assert success.
Update all callers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 6b030dac42..8c90a690dd 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -722,14 +722,14 @@ fail:
     return -1;
 }
 
-static void mmap_reserve(abi_ulong start, abi_ulong len)
+static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 {
     abi_ulong real_start;
     abi_ulong real_last;
     abi_ulong real_len;
     abi_ulong last;
     abi_ulong a;
-    void *host_start, *ptr;
+    void *host_start;
     int prot;
 
     last = start + len - 1;
@@ -776,9 +776,15 @@ static void mmap_reserve(abi_ulong start, abi_ulong len)
     real_len = real_last - real_start + 1;
     host_start = g2h_untagged(real_start);
 
-    ptr = mmap(host_start, real_len, PROT_NONE,
-               MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
-    assert(ptr == host_start);
+    if (reserved_va) {
+        void *ptr = mmap(host_start, real_len, PROT_NONE,
+                         MAP_FIXED | MAP_ANONYMOUS
+                         | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
+        assert(ptr == host_start);
+    } else {
+        int ret = munmap(host_start, real_len);
+        assert(ret == 0);
+    }
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
@@ -830,11 +836,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
     ret = 0;
     /* unmap what we can */
     if (real_start < real_end) {
-        if (reserved_va) {
-            mmap_reserve(real_start, real_end - real_start);
-        } else {
-            ret = munmap(g2h_untagged(real_start), real_end - real_start);
-        }
+        mmap_reserve_or_unmap(real_start, real_end - real_start);
     }
 
     if (ret == 0) {
@@ -871,7 +873,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
              * If new and old addresses overlap then the above mremap will
              * already have failed with EINVAL.
              */
-            mmap_reserve(old_addr, old_size);
+            mmap_reserve_or_unmap(old_addr, old_size);
         }
     } else if (flags & MREMAP_MAYMOVE) {
         abi_ulong mmap_start;
@@ -886,7 +888,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                                flags | MREMAP_FIXED,
                                g2h_untagged(mmap_start));
             if (reserved_va) {
-                mmap_reserve(old_addr, old_size);
+                mmap_reserve_or_unmap(old_addr, old_size);
             }
         }
     } else {
@@ -912,7 +914,8 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                     errno = ENOMEM;
                     host_addr = MAP_FAILED;
                 } else if (reserved_va && old_size > new_size) {
-                    mmap_reserve(old_addr + old_size, old_size - new_size);
+                    mmap_reserve_or_unmap(old_addr + old_size,
+                                          old_size - new_size);
                 }
             }
         } else {
-- 
2.34.1


