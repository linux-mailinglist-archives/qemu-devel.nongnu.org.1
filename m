Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF45782E44
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:22:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cs-0001qd-Cz; Mon, 21 Aug 2023 12:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cb-0001Vi-8Z
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:20 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cW-0005dn-70
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:15 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-56b2e689828so999635a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634748; x=1693239548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeRwmoZj3gayyKtebRoC0JW2YuHlKTaNGyIqgqME+tw=;
 b=AWHYctkqAfQRB+kLjK7K2oY+ra01tdCFC9xxKekA+mPYcQE76r5bW6IlzQOmijDxJC
 ju+0pZliqjWDKqZ7UcpU5P0y9cei/aVzXFrsmqiBuOOGHM3ySSjwZRXTq8CMFx7LfBwj
 EwexEoh7qCFsPu8eEIleqjzGU6mtN9IoOkjRt0ey5Zrl31Jd5TJTYHWDE3BQgnou47Wz
 oefVoXl2qlWumUKem46DhcDtQfIjy4HYvy2Q2D/ebb7ONzUpVEodXRVAiJUbvIDL5j4d
 ypnMvbGwp/m/XXlbW4e7SaOHIqHH4NpDOY03RXDg638ogQbl/vWd5UZzP/T267aUbBYx
 02+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634748; x=1693239548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeRwmoZj3gayyKtebRoC0JW2YuHlKTaNGyIqgqME+tw=;
 b=fpoIUX1UvgACRQ3sruSlTg3KxiPiztd2M8hCMgHm2sZuavA5uF4ZeaEOusvDXkqC8s
 G8+oe4y4OYJLxRYfdCvky/wkxRRZkCr6PlomIZ2AZrXmDm4/ONkbHi+c9sYzDAIzv7sO
 gX1F6GAjp3guVv6Xob5OVypKaCB8WHpJRzQZudJFnD+KNinqc6wDR9g2EmJT2Mula+nn
 1cG2cOnLvsQlIwpesmeIdRHKqe9eM6yuop3qNZz/NUPLPDE9ZmYFU2D64VHHsgrIzfNo
 PW81Y9IUmN2oiDkvnQAl7P6A7WiBjqa0Kc0RZ3Lk3m+PISXZzYzJjJ0oSf7kG3eu9M2E
 Ja9w==
X-Gm-Message-State: AOJu0YzkktU3RoyL3/mZjnxzix+uzEnDReugotyM/IPtL4ZTQ1+ZGFdo
 k4XdFqsLu/Y73jW2q3cKLeX2QTlnLP5tkW5opv0=
X-Google-Smtp-Source: AGHT+IGx1XomcA9TYqvoTlzaXLNzAQw3J9A/np8/qypf3+woVfJ4IfdnzMgYgS0urPeXJjvu9Na4qQ==
X-Received: by 2002:a05:6a20:3945:b0:140:3554:3f44 with SMTP id
 r5-20020a056a20394500b0014035543f44mr10294183pzg.22.1692634748425; 
 Mon, 21 Aug 2023 09:19:08 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 14/19] target/arm: Use clmul_64
Date: Mon, 21 Aug 2023 09:18:48 -0700
Message-Id: <20230821161854.419893-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Use generic routine for 64-bit carry-less multiply.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index ffb4b44ce4..1f93510b85 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2003,28 +2003,14 @@ void HELPER(gvec_pmul_b)(void *vd, void *vn, void *vm, uint32_t desc)
  */
 void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
 {
-    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    intptr_t i, opr_sz = simd_oprsz(desc);
     intptr_t hi = simd_data(desc);
     uint64_t *d = vd, *n = vn, *m = vm;
 
     for (i = 0; i < opr_sz / 8; i += 2) {
-        uint64_t nn = n[i + hi];
-        uint64_t mm = m[i + hi];
-        uint64_t rhi = 0;
-        uint64_t rlo = 0;
-
-        /* Bit 0 can only influence the low 64-bit result.  */
-        if (nn & 1) {
-            rlo = mm;
-        }
-
-        for (j = 1; j < 64; ++j) {
-            uint64_t mask = -((nn >> j) & 1);
-            rlo ^= (mm << j) & mask;
-            rhi ^= (mm >> (64 - j)) & mask;
-        }
-        d[i] = rlo;
-        d[i + 1] = rhi;
+        Int128 r = clmul_64(n[i + hi], m[i + hi]);
+        d[i] = int128_getlo(r);
+        d[i + 1] = int128_gethi(r);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1


