Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B12705835
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0eo-00035F-Be; Tue, 16 May 2023 15:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cS-0000fT-Hq
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:00 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cN-0003pi-Hn
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:00 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2533d3acd5fso52234a91.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266354; x=1686858354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2t4/KP+oyhaRd7avsPSAhu3hAhPGFiLJYL76pKfu08=;
 b=gHxnzoSv2+J5gKvHcyEiJjhqkX2IdGDyxlxkIAMs7CDLnGGOanxofW6ZQa4swQjcY1
 OpPxuNdjFz/Zlb+7SgtrIeP5Z/yHQ5vsPGZXiIVADxpbHDNpU0zNRO3OsrUKv6XFkpa3
 NMXg9fN+zrp1Rdt+FiGzCzB3F51p2ltajtxeWln7ueYCo7omLHnDOB3q2U8xRKPld5wm
 Qv6iNPQ9SDCwDXI5QDZiTVvZFGUkNDC4d6p/ptjee/7Fm7ylSk64YAkU1hqw1k+rjp6c
 buRgOdRuSeRLIuXp7hDLEjQ4YmZ5T1ISVk36Xv8Y7URb4WQMqPpdKt1t610Bwat7h1gw
 ctJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266354; x=1686858354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2t4/KP+oyhaRd7avsPSAhu3hAhPGFiLJYL76pKfu08=;
 b=iFlQNpr2ZnHobfFUYa+GXswUnV7MkcI10ZMCu0rdvtrq4gGmiTU2fYY6YNc5+Myx2K
 wrJvc3Tn4NJgXKDNZx3/nShWVLTGL1nBZjckYTWqwPR6wjvIg/4H5m9C82PaLkPnqy+J
 XAuVC6WDBI/emcqf8lg3nWAq7pHoa/hDHas60Qsy3Et0bxnBl+SJSEOHQRCNkBJvxNAd
 8QqJd+9eUxW817jMRT26i9bo4wmaFDBofuZ42QLiCB1of5LlrstVrSI3ETacfwZF3xlh
 plvX9Da1AueTivSysu+1vun0JqWLA4EUQ/A9fPvIc5Ad8eq56DZ1bylh3RnjHFqMUDl8
 2n4A==
X-Gm-Message-State: AC+VfDxd6sVLJjQXO80xGxzXZcbtyhxdDR7MNnWOv3pQFuPL6XfiYyhV
 4gdXjyIFMeRrU2F3cAAPpAB7yVKSyq1ZuIKhUXU=
X-Google-Smtp-Source: ACHHUZ7c/ISfn8pOtMIQ7p+iEAFQG1Tlrrwy1w1cf2eERzOnwKMt/Zri38Xpp+egQyQD6i9Zi0ml3A==
X-Received: by 2002:a17:90a:cb02:b0:249:6098:b068 with SMTP id
 z2-20020a17090acb0200b002496098b068mr38362907pjt.45.1684266354040; 
 Tue, 16 May 2023 12:45:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 77/80] tcg: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 16 May 2023 12:41:42 -0700
Message-Id: <20230516194145.1749305-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

All uses replaced with TCGContext.addr_type.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5a2b2b1371..4bd598c18b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -5612,12 +5612,7 @@ static void tcg_out_ld_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
     next_arg = 1;
 
     loc = &info->in[next_arg];
-    if (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 64) {
-        nmov = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, TCG_TYPE_TL,
-                                      ldst->addrlo_reg, ldst->addrhi_reg);
-        tcg_out_helper_load_slots(s, nmov, mov, parm);
-        next_arg += nmov;
-    } else {
+    if (TCG_TARGET_REG_BITS == 32 && s->addr_type == TCG_TYPE_I32) {
         /*
          * 32-bit host with 32-bit guest: zero-extend the guest address
          * to 64-bits for the helper by storing the low part, then
@@ -5631,6 +5626,11 @@ static void tcg_out_ld_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
         tcg_out_helper_load_imm(s, loc[!HOST_BIG_ENDIAN].arg_slot,
                                 TCG_TYPE_I32, 0, parm);
         next_arg += 2;
+    } else {
+        nmov = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, s->addr_type,
+                                      ldst->addrlo_reg, ldst->addrhi_reg);
+        tcg_out_helper_load_slots(s, nmov, mov, parm);
+        next_arg += nmov;
     }
 
     switch (info->out_kind) {
@@ -5785,12 +5785,7 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
 
     /* Handle addr argument. */
     loc = &info->in[next_arg];
-    if (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 64) {
-        n = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, TCG_TYPE_TL,
-                                   ldst->addrlo_reg, ldst->addrhi_reg);
-        next_arg += n;
-        nmov += n;
-    } else {
+    if (TCG_TARGET_REG_BITS == 32 && s->addr_type == TCG_TYPE_I32) {
         /*
          * 32-bit host with 32-bit guest: zero-extend the guest address
          * to 64-bits for the helper by storing the low part.  Later,
@@ -5802,6 +5797,11 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
                                ldst->addrlo_reg, -1);
         next_arg += 2;
         nmov += 1;
+    } else {
+        n = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, s->addr_type,
+                                   ldst->addrlo_reg, ldst->addrhi_reg);
+        next_arg += n;
+        nmov += n;
     }
 
     /* Handle data argument. */
@@ -5847,7 +5847,8 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
         g_assert_not_reached();
     }
 
-    if (TCG_TARGET_REG_BITS == 32 && TARGET_LONG_BITS == 32) {
+    if (TCG_TARGET_REG_BITS == 32 && s->addr_type == TCG_TYPE_I32) {
+        /* Zero extend the address by loading a zero for the high part. */
         loc = &info->in[1 + !HOST_BIG_ENDIAN];
         tcg_out_helper_load_imm(s, loc->arg_slot, TCG_TYPE_I32, 0, parm);
     }
-- 
2.34.1


