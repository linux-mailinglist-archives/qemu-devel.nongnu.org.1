Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DEE7E8793
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:33:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1crI-00023V-9t; Fri, 10 Nov 2023 20:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crG-00023J-G1
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:22 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crE-0001aW-Oi
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:22 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso2116381b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666339; x=1700271139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yoygu1nJdDoN9VfRDXSQCv3IzXcMHrs0/BGmVO3uAho=;
 b=WbOlaaQ2Ck9KgQykR2kal1Z/KODnN/MixKpiH/N/dh8SuAoZzclDxaMeOFBb7s89i5
 YdFeu6exl6MWdZ/g6tLXJp6yaLV5beupLmSjLtTIckCpzqgjcLHo518ufqmWn8GqSTQO
 2aP3Y4izvxF8Gxvq1tzTiutBxAqNZ/+xra39hyeMWRWNLtgH9pDaMg1vywknm6QHLtjF
 FhX5pmWhIXNs+FH1pxFD9QGEPtKDZJX47IAcu8dYgG5LVDycz4bC2MtiOaAPe4scgc5G
 kvYXwsGsXrhmRcY5Scin6OZrw3yF921NbtL9R1ZvPQdvjXc9IN803L+b/R4UZoxjbVFk
 CjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666339; x=1700271139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yoygu1nJdDoN9VfRDXSQCv3IzXcMHrs0/BGmVO3uAho=;
 b=i6WMJ97spVintTzS13y1MxZ7FYRRIP0zjsnDneiAjlPiskRMdEtMAyvJXiBxJPB9Kl
 lyOOOhmgstzSwdrKL1tqv1OslD5YhPOKkvg+MGkDTfX/lh4IsR3oPDR4SkHmpMaeapIS
 5Ll4iHXfs8a8v+REp77QNheMbaGYQeLKvgQ1i6zXEZIa51qIU2XfRgtXbNMsL36g5pMf
 GtWhJlsP6o8BN2pU79UsJxQ13l5YWmoe25eLY0Bn4JHyBjr5qCHi+T0f0veAAeEsF4Ut
 c3TDDjA/hEYjYnPt469CEewNMHkGaaJGaqufBsh8zRUukcAuiG9mG4yzgQr9Zs0UKPxP
 BSGA==
X-Gm-Message-State: AOJu0YylE/1HX6UMLsU8TkYO1LbO5tQRgmrpfYLej4r72QJ8LzYmyu/X
 hivK3Z2nEmji4bVjEEUkaomBnNtcRQFF5v4zgkY=
X-Google-Smtp-Source: AGHT+IFgXA9473bydny4Mh0qqNXeWpdo6sboES5FZB4jxqpoCREOp+gEK7sVCuBGF5ZjnSRkaNOHEw==
X-Received: by 2002:aa7:8892:0:b0:6be:c6f7:f9fd with SMTP id
 z18-20020aa78892000000b006bec6f7f9fdmr8078712pfe.11.1699666339443; 
 Fri, 10 Nov 2023 17:32:19 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a62f20b000000b006c1221bc58bsm333502pfh.115.2023.11.10.17.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:32:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 03/11] target/hppa: Mask reserved PSW bits in expand_sm_imm
Date: Fri, 10 Nov 2023 17:32:04 -0800
Message-Id: <20231111013212.229673-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111013212.229673-1-richard.henderson@linaro.org>
References: <20231111013212.229673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

From: Helge Deller <deller@gmx.de>

The system mask is a restricted subset of the psw, with only
a couple of reserved bits.  It is better to handle this up
front in the translator than require helper_swap_system_mask
to use cpu_hppa_get_psw and cpu_hppa_put_psw.

Signed-off-by: Helge Deller <deller@gmx.de>
[rth: Handle this in expand_sm_imm not helper_swap_system_mask.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index bcce65d587..f3b17ba16d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -77,11 +77,14 @@ typedef struct DisasContext {
 /* Note that ssm/rsm instructions number PSW_W and PSW_E differently.  */
 static int expand_sm_imm(DisasContext *ctx, int val)
 {
-    if (val & PSW_SM_E) {
-        val = (val & ~PSW_SM_E) | PSW_E;
-    }
-    if (val & PSW_SM_W) {
-        val = (val & ~PSW_SM_W) | PSW_W;
+    /* Keep unimplemented bits disabled -- see cpu_hppa_put_psw. */
+    if (ctx->is_pa20) {
+        if (val & PSW_SM_W) {
+            val |= PSW_W;
+        }
+        val &= ~(PSW_SM_W | PSW_SM_E | PSW_G);
+    } else {
+        val &= ~(PSW_SM_W | PSW_SM_E | PSW_O);
     }
     return val;
 }
-- 
2.34.1


