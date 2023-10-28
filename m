Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342E7DA915
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:49:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFT-0004gt-P7; Sat, 28 Oct 2023 15:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFQ-0004g7-Qy
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:28 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFP-00045m-6J
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:28 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b3c2607d9bso2910924b3a.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522325; x=1699127125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsrfUb0AmZ7c8AfnEr9wziF3Zzy/kyouo9+mBfFHQpI=;
 b=mHxTpO3gb2TDtbHPjP6E/p81ArA3SebUAjvLmDYc3tjRTd3U/slwklgQ5nGp8+jgnB
 a2jSfXMKQ3z3ueVMHGfVrJKwb73zhsczYU5eSa+KcrAvZJAeZQVMIKhtZvtQtTrf1cxC
 tsZNtMUq8exXB+m+n9snEeJEXmsQWOlUG1WO5lps7MKZYw/2QNrwBCEmF4eZYJ2f8OyI
 gvMrvS/2xLZwxvtu8MqR2QkQJsfyvW9tkJpajhSQFG3+lAWZUIXTc44FyKOvM2ZsyfZv
 1DmFueg9FUDzZm47yLELRB5tqwWYCX3JmTRFaM2VqBnrFVOjulHxuLFxlZdzhqCjT779
 KdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522325; x=1699127125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LsrfUb0AmZ7c8AfnEr9wziF3Zzy/kyouo9+mBfFHQpI=;
 b=lq+8LKvYldWhseVo1zCjXN5zbqlvz0RKisS83H/NLpda9NznoxdRaTadYyq1yggs7y
 JiARFaqAQ/3KTHP8Y3ofEWTuD0W8kQ2xUhT+1sthWlS807sPCefCMQKHrNLszQuIXJ/0
 ZUswTaZVRtXJfqnxJYAKV+f7dbCZa0aqdKks8bkSpY89y/BxCCb55Jon3m1Sn34F9Yc2
 X11VzfhhTUgUtagboWz/b4MyMWCPHFPIdbuHGhrdg397ILHlf/ZzzfWWORCfA++nwYzW
 p59kigwIEoWjPFTJvIEAmYrb0nr6gFw2PYzepbaeuIr6woT7bKhHCqPkKfEF0ZzTIUPv
 x6kg==
X-Gm-Message-State: AOJu0YxpXR1JVygr6LWAc0gKxFzSc2GyqZ7I0erpkX6IB/NJuVEMUBnj
 RLcbk/SnA8pgLXc+Jg6EJCenDU4270DspOKkCsw=
X-Google-Smtp-Source: AGHT+IF0yQKwFlXHyImr6rdxCGqA8SlLMbD9KLZzxjJMnwEYiw4NQ9WSoNKxD+aXwhE541VjX6mQQw==
X-Received: by 2002:a05:6a20:54a3:b0:13d:17cc:5bca with SMTP id
 i35-20020a056a2054a300b0013d17cc5bcamr6563145pzk.18.1698522325375; 
 Sat, 28 Oct 2023 12:45:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 01/35] tcg: Introduce TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:44:48 -0700
Message-Id: <20231028194522.245170-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 docs/devel/tcg-ops.rst |  2 ++
 include/tcg/tcg-cond.h | 49 ++++++++++++++++++++++++++++++++----------
 tcg/tcg.c              |  4 +++-
 3 files changed, 43 insertions(+), 12 deletions(-)

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
-- 
2.34.1


