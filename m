Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A171E78163D
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMM-0008Sj-6J; Fri, 18 Aug 2023 21:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMI-0008QT-Az
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMG-0007Lf-1a
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6889078ee66so1257382b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406946; x=1693011746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRvobRxifTOwS5r7R7zXbKsRuZh6imu3x1ylIR15QTo=;
 b=vSko8l00lJ/TbMwRXhOCOhzuMltviL06MrhXmbaZ+WA6VbtgxNFy4qNtBdn5AcXqPj
 zY06qybaC4EC3+HvW8OM8cA9TFgcQfE7HTxbKu+s1tV0/9etrIbXocr2MUHMBitX0yuB
 XMD6D/DXPDDzsSwYFB4k5WPzkIJdki4I7/lSGFyW2EYemGgctdPIM/sbeX0K6IaXhlSe
 adR5pOXzBUJObFqd86n2dWDMreKNyLBtSPXM9kqEEkzGtGN0DA3NP294kDr8mQH5Q3yI
 8/ZxlHiPxltspoAwp0Pl78TPJgi79ocr/dY4m6bxxOctdxIW6peLObg1z3ZMXWctvgmy
 Ijug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406946; x=1693011746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZRvobRxifTOwS5r7R7zXbKsRuZh6imu3x1ylIR15QTo=;
 b=gOVdQv0FBLZQOFzDESr3SOBGcDY9ua8P05n/I6J+ARkWmAWfGj+a/NizsERQXyneAx
 gZG/7688w/FV0vi72oUVWUtS2geIYxznzR43MS5jpBajHsndVtFf7gTnXlv4F5lOsqEs
 E/YundQMy1t+Km7eLQuqMcBt8ANLlmunicddT9c+lpuIbA2uAi5bM2VYhey1ouzON+DT
 n2YpIHGeRsmiuZrdyQqCa5LjXIWMM/VyF8i9bGRoXvr/yltRnAeY49FW3f0pzz9d1wVb
 tafmcBFnRC0dXZgLuAsYYSjf3QaaSkeQM2Pba5TWgkRwhD+Y7INF02AZ1PjOsEHFHSWD
 7S5Q==
X-Gm-Message-State: AOJu0YzakWh4vXmm7UulJLolXmHW0vdf7IIEy6uQDQPDPc+s1MnOXW3H
 7DzsnNlTuPz9PbDChls0uscFmFpwFT4HB2R2sc0=
X-Google-Smtp-Source: AGHT+IHBpa13d5+x55j1vb5IXf9CPDBvSMnQp3ThkTW39w2093KoZOIj6nzn3e1B+z+sRZoe+Jz15w==
X-Received: by 2002:a05:6a20:8f09:b0:137:2281:944f with SMTP id
 b9-20020a056a208f0900b001372281944fmr916565pzk.40.1692406946554; 
 Fri, 18 Aug 2023 18:02:26 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 07/18] target/s390x: Use clmul_16* routines
Date: Fri, 18 Aug 2023 18:02:07 -0700
Message-Id: <20230819010218.192706-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
Remove our local version of galois_multiply16.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/vec_int_helper.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/vec_int_helper.c b/target/s390x/tcg/vec_int_helper.c
index edff4d6b2b..11477556e5 100644
--- a/target/s390x/tcg/vec_int_helper.c
+++ b/target/s390x/tcg/vec_int_helper.c
@@ -180,7 +180,6 @@ static uint##TBITS##_t galois_multiply##BITS(uint##TBITS##_t a,                \
     }                                                                          \
     return res;                                                                \
 }
-DEF_GALOIS_MULTIPLY(16, 32)
 DEF_GALOIS_MULTIPLY(32, 64)
 
 static S390Vector galois_multiply64(uint64_t a, uint64_t b)
@@ -231,6 +230,30 @@ void HELPER(gvec_vgfma8)(void *v1, const void *v2, const void *v3,
     q1[1] = do_gfma8(q2[1], q3[1], q4[1]);
 }
 
+static inline uint64_t do_gfma16(uint64_t n, uint64_t m, uint64_t a)
+{
+    return clmul_16x2_even(n, m) ^ clmul_16x2_odd(n, m) ^ a;
+}
+
+void HELPER(gvec_vgfm16)(void *v1, const void *v2, const void *v3, uint32_t d)
+{
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3;
+
+    q1[0] = do_gfma16(q2[0], q3[0], 0);
+    q1[1] = do_gfma16(q2[1], q3[1], 0);
+}
+
+void HELPER(gvec_vgfma16)(void *v1, const void *v2, const void *v3,
+                         const void *v4, uint32_t d)
+{
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3, *q4 = v4;
+
+    q1[0] = do_gfma16(q2[0], q3[0], q4[0]);
+    q1[1] = do_gfma16(q2[1], q3[1], q4[1]);
+}
+
 #define DEF_VGFM(BITS, TBITS)                                                  \
 void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
                              uint32_t desc)                                    \
@@ -248,7 +271,6 @@ void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFM(16, 32)
 DEF_VGFM(32, 64)
 
 void HELPER(gvec_vgfm64)(void *v1, const void *v2, const void *v3,
@@ -284,7 +306,6 @@ void HELPER(gvec_vgfma##BITS)(void *v1, const void *v2, const void *v3,        \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFMA(16, 32)
 DEF_VGFMA(32, 64)
 
 void HELPER(gvec_vgfma64)(void *v1, const void *v2, const void *v3,
-- 
2.34.1


