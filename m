Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B677D7962
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:26:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2n-000723-O0; Wed, 25 Oct 2023 20:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2S-0006y2-As
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2N-0004pH-J2
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:15:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ca215cc713so2016735ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279345; x=1698884145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dcov+EvgUKOcstVsIicTu1476ZKJilrV5KBfm5f0U0k=;
 b=WPKowjfQJWVwFKPYucglTywmHO+jpyGzh+BvfOrShZZ93jzZ2D03wfNOMs83uMlfir
 GwZxnM5Vku2giu1Dzck/qpsMFT6UJcopOfFmE7huTIExzwwNHy+nVOePc5ZfAtx30/V8
 ljCrQkQsq0W2iMjnkfjkpfvU5Zoh+Lf1EIb68GLg8biOyzYCv630vsMdpusjfr2rtwwV
 JBII6O3WPS/i2s1pUTqlB3IR+0zHQCRuIY2C1kfp1OPyQdaHwSpEjrHSkDVFj7Q2+Wb5
 SuzAS9/lYQia4euvT/ixeeMsNJL02+QUtP0Z/feQR4uTnligjrFlzW99TvQtSlduuqHV
 DuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279345; x=1698884145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dcov+EvgUKOcstVsIicTu1476ZKJilrV5KBfm5f0U0k=;
 b=Ot+AbY4+S5Xsn/3r+H/RXok+WD752UDLzHZAp2NE4WXLuNLSgmydK5M9jYK8l7fHS+
 aqgGFFt/ev6cbq1HFZcjrALCfBUIeGmbvI2EEA5iwoqNy4o5kkMM8KII0yzQbFbYaQ3u
 YFZ20co5eaZ0SPbQB0yMmmDj9murqxqQlLoK7tXIezC++CuzcTvI5ROrmfl+mbyL0ktC
 3mOAgloiFGjoxpuNYnJLDbaA55XxQy+FmShuUPmFg5K5Rz/dFXnmL08Dm6V3GmSTe9dp
 JxNxWEEHe4bEHxEuE3Q8nE7UtgVQLaQyHinQlfK6qABS0By0pxzoz4se5h0c0ufrrKNh
 C1wQ==
X-Gm-Message-State: AOJu0YzNzAARkrceEY51C6Q+/+BzyVlbhGCwdhRK43XGVHYLLvMz/jln
 Sw6HWSZDPG4fmzlirhUVPuW3AMPKBlxaRKH7f6I=
X-Google-Smtp-Source: AGHT+IH6eA5Blzb8w9nLZvQNNdBr488p2pnsdRzjIk3TXJiLVNNFsk9v/mBwWaGTu5VfX4pWKHkeXg==
X-Received: by 2002:a17:903:2450:b0:1ca:2ec4:7f3f with SMTP id
 l16-20020a170903245000b001ca2ec47f3fmr16268257pls.45.1698279345552; 
 Wed, 25 Oct 2023 17:15:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/29] tcg: Introduce TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 17:13:41 -0700
Message-Id: <20231026001542.1141412-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Add the enumerators, adjust the helpers to match, and dump.
Not supported anywhere else just yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-cond.h | 49 ++++++++++++++++++++++++++++++++----------
 tcg/tcg.c              |  4 +++-
 docs/devel/tcg-ops.rst |  2 ++
 3 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-cond.h b/include/tcg/tcg-cond.h
index 2a38a386d4..bf3fcf5968 100644
--- a/include/tcg/tcg-cond.h
+++ b/include/tcg/tcg-cond.h
@@ -49,6 +49,9 @@ typedef enum {
     TCG_COND_GEU    = 0 | 4 | 0 | 1,
     TCG_COND_LEU    = 8 | 4 | 0 | 0,
     TCG_COND_GTU    = 8 | 4 | 0 | 1,
+    /* "test" i.e. and then compare vs 0 */
+    TCG_COND_TSTEQ  = 8 | 4 | 2 | 0,
+    TCG_COND_TSTNE  = 8 | 4 | 2 | 1,
 } TCGCond;
 
 /* Invert the sense of the comparison.  */
@@ -60,25 +63,49 @@ static inline TCGCond tcg_invert_cond(TCGCond c)
 /* Swap the operands in a comparison.  */
 static inline TCGCond tcg_swap_cond(TCGCond c)
 {
-    return c & 6 ? (TCGCond)(c ^ 9) : c;
+    return (c + 2) & 4 ? (TCGCond)(c ^ 9) : c;
 }
 
-/* Create an "unsigned" version of a "signed" comparison.  */
-static inline TCGCond tcg_unsigned_cond(TCGCond c)
+/* Must a comparison be considered signed?  */
+static inline bool is_signed_cond(TCGCond c)
 {
-    return c & 2 ? (TCGCond)(c ^ 6) : c;
-}
-
-/* Create a "signed" version of an "unsigned" comparison.  */
-static inline TCGCond tcg_signed_cond(TCGCond c)
-{
-    return c & 4 ? (TCGCond)(c ^ 6) : c;
+    return (c & 6) == 2;
 }
 
 /* Must a comparison be considered unsigned?  */
 static inline bool is_unsigned_cond(TCGCond c)
 {
-    return (c & 4) != 0;
+    return (c & 6) == 4;
+}
+
+/* Must a comparison be considered a test?  */
+static inline bool is_tst_cond(TCGCond c)
+{
+    return (c | 1) == 0xf;
+}
+
+/* Create an "unsigned" version of a "signed" comparison.  */
+static inline TCGCond tcg_unsigned_cond(TCGCond c)
+{
+    return is_signed_cond(c) ? (TCGCond)(c ^ 6) : c;
+}
+
+/* Create a "signed" version of an "unsigned" comparison.  */
+static inline TCGCond tcg_signed_cond(TCGCond c)
+{
+    return is_unsigned_cond(c) ? (TCGCond)(c ^ 6) : c;
+}
+
+/* Create the eq/ne version of a tsteq/tstne comparison.  */
+static inline TCGCond tcg_tst_eqne_cond(TCGCond c)
+{
+    return is_tst_cond(c) ? (TCGCond)(c ^ 6) : c;
+}
+
+/* Create the lt/ge version of a tstne/tsteq comparison of the sign.  */
+static inline TCGCond tcg_tst_ltge_cond(TCGCond c)
+{
+    return is_tst_cond(c) ? (TCGCond)(c ^ (8 | 4 | 1)) : c;
 }
 
 /*
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 35158a0846..57d0583fe7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2378,7 +2378,9 @@ static const char * const cond_name[] =
     [TCG_COND_LTU] = "ltu",
     [TCG_COND_GEU] = "geu",
     [TCG_COND_LEU] = "leu",
-    [TCG_COND_GTU] = "gtu"
+    [TCG_COND_GTU] = "gtu",
+    [TCG_COND_TSTEQ] = "tsteq",
+    [TCG_COND_TSTNE] = "tstne",
 };
 
 static const char * const ldst_name[(MO_BSWAP | MO_SSIZE) + 1] =
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 8ae59ea02b..d46b625e0e 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -253,6 +253,8 @@ Jumps/Labels
        |   ``TCG_COND_GEU /* unsigned */``
        |   ``TCG_COND_LEU /* unsigned */``
        |   ``TCG_COND_GTU /* unsigned */``
+       |   ``TCG_COND_TSTEQ /* t1 & t2 == 0 */``
+       |   ``TCG_COND_TSTNE /* t1 & t2 != 0 */``
 
 Arithmetic
 ----------
-- 
2.34.1


