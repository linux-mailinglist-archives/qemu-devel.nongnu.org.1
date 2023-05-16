Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A627057FE
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0em-00032r-DO; Tue, 16 May 2023 15:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cN-0000Vz-Oc
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:56 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cK-0003iw-6z
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:55 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ae4be0b1f3so545275ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266350; x=1686858350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x0m1o00zlToFNXbMeHftTRJjM9JUo6XAGwMqXPxpsNk=;
 b=xh8JkQ8sexYe60SmPHI76wR/QADRDBQ3fs8bCoV4k/6wa6Za0Vy/RaSLjbI16MyRqQ
 4FmF89yy1ad2yD/G9B+iOkQeLr65AwOYDXVwfKisxX3JOvGrwUWpOKHRw/9NJc00lf7T
 dbIZzYSiXgbxRES4ahV7bpHVgO/uV3osIpmQ3ma/G2q1IPDkP1sY2pW60dmD+Hfo2itO
 u+oKJRsYpGyTo7lZ6e/zNl71mM2DZYKyOS/lNP7V198S7NWTj9rgN4MRYLsxuk9BxZGj
 AocXAhVcl71uN3n9n5RdxbSW0zd0jB1gnnIczOHCpGu4yVJHuj/0GaE45E/ct+WMmAC+
 hWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266350; x=1686858350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x0m1o00zlToFNXbMeHftTRJjM9JUo6XAGwMqXPxpsNk=;
 b=cmTazjfkDVBAuCmAyGcLWssFuFeT9xMRSftXaMJeSlzZ5z7l5VsqlIIdexlHvOdLar
 uTvz/w7ipEPFnJ2o5+8RcyGzlJdK/XUwbQvYivHno7+ZOWEqofXGDq0YArV72wAgrYfT
 CQR5jNsbIGK7HZYGQkPg7zMidcTW3eJ39iKdMEcO9F6qYXKuAyG4D+ddvrzYs4/Ewghs
 W1HxqV5dIImDtq/63nfMiT7RkCv61EWQDZLM12/2VFC6cbqoMcq+EWZ2/n/SVt7bDi2M
 tbnyNH/D9Ctqtld8tq2KsrvAGRph9nvg1rWXAS9w3ASXcWhrIupYpIWvQWNakN7nFcYg
 ZAsQ==
X-Gm-Message-State: AC+VfDzw6N6CG3e0XgiYsny5FBGe6YvD4DGaRzcgD+AYb6PMwsuBkb8y
 wGFxwonNLCn35rwVAoJJ4J2tTA8LAyj+bbncMtY=
X-Google-Smtp-Source: ACHHUZ67Fm/7T42B2nlNcr2vsY+iVxQ8pitmHrr/dAekc3vpd7/rtMo79qwa6oWnE+/74Mzu9mBK/A==
X-Received: by 2002:a17:90a:7388:b0:253:3d7c:949a with SMTP id
 j8-20020a17090a738800b002533d7c949amr520361pjg.33.1684266350191; 
 Tue, 16 May 2023 12:45:50 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 72/80] tcg/arm: Remove TARGET_LONG_BITS
Date: Tue, 16 May 2023 12:41:37 -0700
Message-Id: <20230516194145.1749305-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

All uses can be infered from the INDEX_op_qemu_*_a{32,64}_*
opcode being used.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 47f3ff18fa..3c38e868e2 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1431,18 +1431,18 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
      * Load the tlb comparator into R2/R3 and the fast path addend into R1.
      */
     if (cmp_off == 0) {
-        if (TARGET_LONG_BITS == 64) {
-            tcg_out_ldrd_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
-        } else {
+        if (s->addr_type == TCG_TYPE_I32) {
             tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
+        } else {
+            tcg_out_ldrd_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
         }
     } else {
         tcg_out_dat_reg(s, COND_AL, ARITH_ADD,
                         TCG_REG_R1, TCG_REG_R1, TCG_REG_R0, 0);
-        if (TARGET_LONG_BITS == 64) {
-            tcg_out_ldrd_8(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
-        } else {
+        if (s->addr_type == TCG_TYPE_I32) {
             tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
+        } else {
+            tcg_out_ldrd_8(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
         }
     }
 
@@ -1485,7 +1485,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                         SHIFT_IMM_LSL(TARGET_PAGE_BITS));
     }
 
-    if (TARGET_LONG_BITS == 64) {
+    if (s->addr_type != TCG_TYPE_I32) {
         tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, TCG_REG_R3, addrhi, 0);
     }
 #else
-- 
2.34.1


