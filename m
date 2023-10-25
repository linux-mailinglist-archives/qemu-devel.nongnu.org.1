Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D590D7D6313
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:33:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIV-0000Cb-IV; Wed, 25 Oct 2023 03:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIQ-00009V-Sp
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:18 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIK-0004db-5A
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:17 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c434c33ec0so36548665ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218830; x=1698823630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dcov+EvgUKOcstVsIicTu1476ZKJilrV5KBfm5f0U0k=;
 b=exh3C+XXiFHqM3rIifHe65l55SDnpxZ/xfkSMjnh3sUiRVbUoIzGubbD0w/oh+u4jU
 SndYaJwkP/vW3toyvskRbQ89QwCZHvy2mCbPa+nM0q9rahHiazbQbaV15mNR+bOmmVE/
 FH6Dez1pgCeVPH8xztKsZb8Ij/6Fsibvy6rg69pxOYjWTtlU1C6lusDgXUlaTEbWNSb0
 CUbEYsh4Ixr7DXYOHzEZxo7wspeixyY8Oe9zHj0arc+MxSFEJp64CP5OWNoFZGNDRiZz
 UBFQ+5zGhNEHNm6iTXtbnnR3md+hBbuM8wzvnlPOorlD+bJgZRj2rvS0UF8jD+te2azx
 WTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218830; x=1698823630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dcov+EvgUKOcstVsIicTu1476ZKJilrV5KBfm5f0U0k=;
 b=smYVHbK9AXxu0FjtJSkx3LofB5cQe8GGp1icd2oTM4y0aWfMfl+2xfxAY06NZQwLPr
 GyRimFoNK+Cj6xyuXrulG93IrhPAuUO7qPgACTxmkeE5e4ij0ne2v7NtCQ0syedIRK4f
 sRXLAfJqQYlKvckZPTAV9rkTJyyILUjq6gRRTkIWwV+Bk00AIWEhiQarKQonwVz7+oH1
 EGkXn90+fQCwC7Eij1JTByyQPs4T2enNxHNjdH9AIvt2tkA6gdSTXioyrOpQSGoQ+qAl
 xP/K4U5KIkbEN1FsokQ25WFAyTPAXugMJWoRWo4Z5a3BRbg64CjnXoJwkVOfETF/tzsp
 b4Wg==
X-Gm-Message-State: AOJu0YxSyY5veluBwemniTZmVTTQx+31m/CaioSu1watUtcXLnOkYurU
 /A1E0E1lk9E8laSeDtfaRgvFdBWo2/SORefsLOE=
X-Google-Smtp-Source: AGHT+IHqGYx/pNi2gGwJY7yLvaNk0UcBcj2QR09CRsDi7afO9OAONn0oZhZ9Stk6+D/HGSUDqJah5A==
X-Received: by 2002:a17:902:db0c:b0:1ca:7909:6ee6 with SMTP id
 m12-20020a170902db0c00b001ca79096ee6mr12190819plx.61.1698218829753; 
 Wed, 25 Oct 2023 00:27:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 01/29] tcg: Introduce TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:26:39 -0700
Message-Id: <20231025072707.833943-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


