Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA4A24ACE
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Feb 2025 17:52:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZ7-00007K-6q; Sat, 01 Feb 2025 11:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYd-0007I1-9a
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:23 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYb-0001JM-KE
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:23 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so1894871f8f.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428080; x=1739032880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OWU/PlXSyEzT9phV28MmmzHlFyTyrUZHww5V+yN3G6E=;
 b=lXnvWQpB7EsQAL49ODDDdeIt07/IAPtv4zrS1lgNjvu0zMdz6VF/qmxE7RP/dwXXGC
 lKnT8FUXyYc1s/ic3EgqzBlaEIOknVegKxU1m1LmpbT3BZZPEBzfR0WIahc/tAWD8FxG
 PSWoiPz+Yi3kNsudl/WuXYWtbMtgn6D/UWHUwL31p9fukYuVbjSvakMOimj7HFSEwR1G
 1oPjjjjwcCAb1oyGoIJxhvCRzQpMg75yrK9pC10NgAq66+MSUkfWpuc2i3jtRTXiYUkz
 pCCz2fv1cwOHdSXr9xNT17xgiok55d9WHSfefEhnFgw1xmhT6Mx6Wm0BNAAHkW7Cjg+X
 9kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428080; x=1739032880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWU/PlXSyEzT9phV28MmmzHlFyTyrUZHww5V+yN3G6E=;
 b=ItAK3Bpj7rjjAXSfJJdBhpSQZz6CEYBSjEZ2lE/sUKZzTLEmCk/HmJhBfgXES/8vrz
 fVuO/O4LxcZ4KVm4z4kWbT2KyF0TSY2hRUWoRUbtHDHkt0IcCNDRS2UfyfPBIckQ3Qqz
 /G7E0BWHXfQSbiCUGaZrhn2LtW2QV+NjOMkYl6wPfmY+tCv63bRDAZcs3HZ5tvR6mOJV
 w8MKbd2j3LBLLt54nd5D4Dwwy/dIHJPJ9faS9/MHjifIOgrNkRz0ziYxpy0dw/gY75tN
 diQpE5sTwr9Z9lmUFCtz0gcw/0xfMMmomrJYzkG/VDSd4zAMr924KuPKlNs9sq69ngWT
 GEyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZbLWlXSIUoK9obHDSw1B9YqfKbyld1LprJ86camCFP4KsJCxuuKXDgaNgtzEWwk9kBPFN4g+F/0oI@nongnu.org
X-Gm-Message-State: AOJu0Yw9QMZHN+ylyREBv2DHjHjHd46FDyMlUbSWa3gobH0pfTyTvlms
 xEwlcrRBZxsYPd7AJ0iUn+91T+IzmQwJjmJAdUebBESpGi2gVhkdaFmMsjUWHVc=
X-Gm-Gg: ASbGnctkA3xajUGUWzhxhvggRehzTOI4/RjRRicluhzWYQmaP/tRfhzTCZc4um+WXzj
 1CddLE56vvByogVNmhnNuT4R+0JuETlc+k7qiRxJdRSEVpUGWkw14HFZ35RH4vyFwmPE/z9i6gT
 hgDhPyGqVHqnKIxvZ16aqMbHiGw2GpTuHLUP75Pokq8W4hk/x1XWoUYSotthXb95WqJc3BLRP41
 F91rbZLRPODWFyCfWLJaPd1AraJimkf8b6V1THCL262KYveUNxMh4L8EMsQBQTajuJIpLzIE5Sj
 ZAj/GGNZtemaLLQzIbvs
X-Google-Smtp-Source: AGHT+IEV/hyeN1gXANhM5dxT976LsJ6oum5RIMASzLgIkZ3j9yGr6wbuw2Q7eXRgxKNxZMj5nSDctA==
X-Received: by 2002:a05:6000:1567:b0:38c:5bb2:b928 with SMTP id
 ffacd0b85a97d-38c5bb2bd44mr7951163f8f.20.1738428080015; 
 Sat, 01 Feb 2025 08:41:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 50/69] target/arm: Handle FPCR.AH in SVE FMLSL (indexed)
Date: Sat,  1 Feb 2025 16:39:53 +0000
Message-Id: <20250201164012.1660228-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Handle FPCR.AH's requirement to not negate the sign of a NaN in SVE
FMLSL (indexed), using the usual trick of negating by XOR when AH=0
and by muladd flags when AH=1.

Since we have the CPUARMState* in the helper anyway, we can
look directly at env->vfp.fpcr and don't need toa pass in the
FPCR.AH value via the SIMD data word.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-32-richard.henderson@linaro.org
[PMM: commit message tweaked]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 5f0656f34ca..42bb43acd78 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2250,23 +2250,32 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
                                CPUARMState *env, uint32_t desc)
 {
     intptr_t i, j, oprsz = simd_oprsz(desc);
-    uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
+    bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
+    int negx = 0, negf = 0;
+
+    if (is_s) {
+        if (env->vfp.fpcr & FPCR_AH) {
+            negf = float_muladd_negate_product;
+        } else {
+            negx = 0x8000;
+        }
+    }
 
     for (i = 0; i < oprsz; i += 16) {
         float16 mm_16 = *(float16 *)(vm + i + idx);
         float32 mm = float16_to_float32_by_bits(mm_16, fz16);
 
         for (j = 0; j < 16; j += sizeof(float32)) {
-            float16 nn_16 = *(float16 *)(vn + H1_2(i + j + sel)) ^ negn;
+            float16 nn_16 = *(float16 *)(vn + H1_2(i + j + sel)) ^ negx;
             float32 nn = float16_to_float32_by_bits(nn_16, fz16);
             float32 aa = *(float32 *)(va + H1_4(i + j));
 
             *(float32 *)(vd + H1_4(i + j)) =
-                float32_muladd(nn, mm, aa, 0, status);
+                float32_muladd(nn, mm, aa, negf, status);
         }
     }
 }
-- 
2.34.1


