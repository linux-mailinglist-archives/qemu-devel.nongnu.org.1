Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B282A41B
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:45:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhJN-0004RJ-3G; Wed, 10 Jan 2024 17:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJL-0004Qp-8T
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:44:35 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJJ-0002Ro-FU
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:44:35 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7831c604a84so284624885a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926672; x=1705531472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xe6YKO+UBE6YLyYsW2AZ/tSAY+8N62/s82QricPcuNc=;
 b=wFJhcy9I/yiGbYJltig/zkhFNvAYKPMl4+EW9g9vuEC3zi2fA/9MtFILdwVwcYI6Mu
 01B45V1A627L2KCyznlwMB2AdAegNfJ3HniKVIyEg2Z4U3M3nSlG3ueaguwdx/9V+9Jj
 +yLK9pINAKrvzVVBitO6RAcm/fQlOIlnskFpR2/gJYGKi6A94EScLqvmZ2fwMQAQbShb
 +JikKFdckrO8P+3UD4GDBkuL6l6HymAqDZvN/xFV4JMeTniL8ulPwyWphyrNZqRQ6ZTq
 1jAHqXejymK30z9w0uguy+o8sLcaji7cyU0Sb4nUyVt0rZjnVG4aGUMDepLLfG8w/mPf
 j3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926672; x=1705531472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xe6YKO+UBE6YLyYsW2AZ/tSAY+8N62/s82QricPcuNc=;
 b=FKwzbgQIyLA2gxPQuc5PJHacMVW1aPvQDuqj1yRGMddNZvC82L7QoH3cC92kkEaRI5
 4NkLllKC2hDtIZSe1OJZn3UPMO5rhS8DU1cjOXImDoMJJB56z4wLtofkrRDu1zL+8HGe
 Trioqqqyd6Snbyh7mR3PhDunKmNqVIvlPEPHxrA8InSvVM9YUr2Xx/REby9VC2sU6q4k
 RIxHkX3MiMaQaaqh8Jh8Kw17yQgDhxP5Ln5HmLfNCnRqDdQYvstZJitJO7scy4dBaM/2
 WyTfGWJw1Q/0Qpz1nFDR23vF0m8GD61pSdZDRCwaRgPIT6KvXRlRbQkEIKtxEn9M5LXn
 2RYg==
X-Gm-Message-State: AOJu0YwpYUeWV5ZkkdmLNp+Jp1Uig8T0WQJRgqkJzVsXDFhU7GXeTDpS
 1zU++Qqr+M5a3TlQJLTduYOTuS1LBm2c8Cs3zoYjRxIeIwAVy5UF
X-Google-Smtp-Source: AGHT+IF1NAYLCxPrmliUSTAMHtenYTsFl3jAjQdyboTTBD7FebGoowI3yPJew2vrKuYGxKF5VEINqg==
X-Received: by 2002:a05:622a:15d6:b0:429:aac8:95d3 with SMTP id
 d22-20020a05622a15d600b00429aac895d3mr330462qty.45.1704926672212; 
 Wed, 10 Jan 2024 14:44:32 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:44:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 01/38] tcg: Introduce TCG_COND_TST{EQ,NE}
Date: Thu, 11 Jan 2024 09:43:31 +1100
Message-Id: <20240110224408.10444-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
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

Add the enumerators, adjust the helpers to match, and dump.
Not supported anywhere else just yet.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/tcg-ops.rst |  2 ++
 include/tcg/tcg-cond.h | 74 ++++++++++++++++++++++++++++++------------
 tcg/tcg.c              |  4 ++-
 3 files changed, 58 insertions(+), 22 deletions(-)

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
diff --git a/include/tcg/tcg-cond.h b/include/tcg/tcg-cond.h
index 2a38a386d4..5cadbd6ff2 100644
--- a/include/tcg/tcg-cond.h
+++ b/include/tcg/tcg-cond.h
@@ -29,26 +29,34 @@
  * Conditions.  Note that these are laid out for easy manipulation by
  * the functions below:
  *    bit 0 is used for inverting;
- *    bit 1 is signed,
- *    bit 2 is unsigned,
- *    bit 3 is used with bit 0 for swapping signed/unsigned.
+ *    bit 1 is used for conditions that need swapping (signed/unsigned).
+ *    bit 2 is used with bit 1 for swapping.
+ *    bit 3 is used for unsigned conditions.
  */
 typedef enum {
     /* non-signed */
     TCG_COND_NEVER  = 0 | 0 | 0 | 0,
     TCG_COND_ALWAYS = 0 | 0 | 0 | 1,
+
+    /* equality */
     TCG_COND_EQ     = 8 | 0 | 0 | 0,
     TCG_COND_NE     = 8 | 0 | 0 | 1,
+
+    /* "test" i.e. and then compare vs 0 */
+    TCG_COND_TSTEQ  = 8 | 4 | 0 | 0,
+    TCG_COND_TSTNE  = 8 | 4 | 0 | 1,
+
     /* signed */
     TCG_COND_LT     = 0 | 0 | 2 | 0,
     TCG_COND_GE     = 0 | 0 | 2 | 1,
-    TCG_COND_LE     = 8 | 0 | 2 | 0,
-    TCG_COND_GT     = 8 | 0 | 2 | 1,
+    TCG_COND_GT     = 0 | 4 | 2 | 0,
+    TCG_COND_LE     = 0 | 4 | 2 | 1,
+
     /* unsigned */
-    TCG_COND_LTU    = 0 | 4 | 0 | 0,
-    TCG_COND_GEU    = 0 | 4 | 0 | 1,
-    TCG_COND_LEU    = 8 | 4 | 0 | 0,
-    TCG_COND_GTU    = 8 | 4 | 0 | 1,
+    TCG_COND_LTU    = 8 | 0 | 2 | 0,
+    TCG_COND_GEU    = 8 | 0 | 2 | 1,
+    TCG_COND_GTU    = 8 | 4 | 2 | 0,
+    TCG_COND_LEU    = 8 | 4 | 2 | 1,
 } TCGCond;
 
 /* Invert the sense of the comparison.  */
@@ -60,25 +68,49 @@ static inline TCGCond tcg_invert_cond(TCGCond c)
 /* Swap the operands in a comparison.  */
 static inline TCGCond tcg_swap_cond(TCGCond c)
 {
-    return c & 6 ? (TCGCond)(c ^ 9) : c;
+    return (TCGCond)(c ^ ((c & 2) << 1));
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
+    return (c & (8 | 2)) == 2;
 }
 
 /* Must a comparison be considered unsigned?  */
 static inline bool is_unsigned_cond(TCGCond c)
 {
-    return (c & 4) != 0;
+    return (c & (8 | 2)) == (8 | 2);
+}
+
+/* Must a comparison be considered a test?  */
+static inline bool is_tst_cond(TCGCond c)
+{
+    return (c | 1) == TCG_COND_TSTNE;
+}
+
+/* Create an "unsigned" version of a "signed" comparison.  */
+static inline TCGCond tcg_unsigned_cond(TCGCond c)
+{
+    return is_signed_cond(c) ? (TCGCond)(c + 8) : c;
+}
+
+/* Create a "signed" version of an "unsigned" comparison.  */
+static inline TCGCond tcg_signed_cond(TCGCond c)
+{
+    return is_unsigned_cond(c) ? (TCGCond)(c - 8) : c;
+}
+
+/* Create the eq/ne version of a tsteq/tstne comparison.  */
+static inline TCGCond tcg_tst_eqne_cond(TCGCond c)
+{
+    return is_tst_cond(c) ? (TCGCond)(c - 4) : c;
+}
+
+/* Create the lt/ge version of a tstne/tsteq comparison of the sign.  */
+static inline TCGCond tcg_tst_ltge_cond(TCGCond c)
+{
+    return is_tst_cond(c) ? (TCGCond)(c ^ 0xf) : c;
 }
 
 /*
@@ -92,7 +124,7 @@ static inline TCGCond tcg_high_cond(TCGCond c)
     case TCG_COND_LE:
     case TCG_COND_GEU:
     case TCG_COND_LEU:
-        return (TCGCond)(c ^ 8);
+        return (TCGCond)(c ^ (4 | 1));
     default:
         return c;
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e2c38f6d11..9d146b13aa 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2482,7 +2482,9 @@ static const char * const cond_name[] =
     [TCG_COND_LTU] = "ltu",
     [TCG_COND_GEU] = "geu",
     [TCG_COND_LEU] = "leu",
-    [TCG_COND_GTU] = "gtu"
+    [TCG_COND_GTU] = "gtu",
+    [TCG_COND_TSTEQ] = "tsteq",
+    [TCG_COND_TSTNE] = "tstne",
 };
 
 static const char * const ldst_name[(MO_BSWAP | MO_SSIZE) + 1] =
-- 
2.34.1


