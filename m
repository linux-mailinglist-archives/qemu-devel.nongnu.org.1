Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34245720D73
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7N-0001Jh-Me; Fri, 02 Jun 2023 22:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6O-0000Qf-1c
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:48 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6F-0004l8-RS
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:47 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6af6f49e41cso2582273a34.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759677; x=1688351677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkRgnPsc0Ve6BufNeSHHC/2pZ6sOVWVoi1e0lmM14MQ=;
 b=nvfMKk7KtkK3U2aye2JQ5Hub0UYgYp2CJfccQEzqOJroixiktXEuswj6zJph3rS2kV
 Eye0wliBHUThuARCeXYu6xvPZ8ribE1DvuW6LfO8AR9lXqAz/XaGBT+RGaje3/ruO85p
 7VuXM/tF8uOOCsuvsq+jndA7GDgoNcO4x+gytr/Z5n05gSQcjdsYtE5AgorbR4GNZqRY
 9ITBjK2UdlLHEV+r23oaoIXP/BfGo1r+6ChLkPrPmTzN/4l1f2VgEDe8CPkRBz7c+cph
 weIzUgeT0VZwsOs3jep+w8wMolBidcWKqy8nWT3CGG4kHVkMykAMpE76f2jYSQHMmUMv
 8v3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759677; x=1688351677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkRgnPsc0Ve6BufNeSHHC/2pZ6sOVWVoi1e0lmM14MQ=;
 b=LLhRuGTCywvvqJSeMU4yrQ9kkhI57VCn5cajFDJUbeUH7wS6RZ60XQyQ9ePFKfr11G
 ZQrhGt7GAYJZDU5xRELgSWsRyjOKWPWnEoBHW0faZOZqTS3sDJnHo/wQcgHSeSn8e/VV
 dYyg4qEat+qA6SsBZL/k1emaF/3cxAE2FNOyjLf2zMJY6JrVqB4ZWZhGm7dXrhE6tith
 GSIUdmlAYYd4vMmpV3TnN38QUHOE6M0ab6cK94r7LCiZSPpxObHtFTswBClNXPdpvmHb
 feP0oCfxmnKFuRltZrWgvekN5g+1n03NLRdoiwy5YGLZ3djmxnytHIG6f9A0jvUukOO9
 uISA==
X-Gm-Message-State: AC+VfDwB8FI8uZGsz8lEySCsnYAj/cKaVYUI2Z395LEmlIbiiQLLpjxu
 adylP2TBJ9/k41m2vEIcK3Sx3d4Yslx7VubCv/A=
X-Google-Smtp-Source: ACHHUZ7VlM9IWW6bY0QF257SLhMWdCOgesJoeL5MRHNGhKqr71BDPgFpxVYI7aoQxd82qcVfxris4g==
X-Received: by 2002:a05:6358:3403:b0:125:908e:22c9 with SMTP id
 h3-20020a056358340300b00125908e22c9mr13305538rwd.10.1685759677532; 
 Fri, 02 Jun 2023 19:34:37 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 11/35] target/i386: Use aesdec_ISB_ISR
Date: Fri,  2 Jun 2023 19:34:02 -0700
Message-Id: <20230603023426.1064431-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This implements the AESDECLAST instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 31e1f6edc7..036eabdf95 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2177,12 +2177,14 @@ void glue(helper_aesdec, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 
 void glue(helper_aesdeclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
-    int i;
-    Reg st = *v;
-    Reg rk = *s;
+    for (int i = 0; i < SHIFT; i++) {
+        AESState *ad = (AESState *)&d->ZMM_X(i);
+        AESState *st = (AESState *)&v->ZMM_X(i);
+        AESState *rk = (AESState *)&s->ZMM_X(i);
+        AESState t;
 
-    for (i = 0; i < 8 << SHIFT; i++) {
-        d->B(i) = rk.B(i) ^ (AES_isbox[st.B(AES_ishifts[i & 15] + (i & ~15))]);
+        aesdec_ISB_ISR(&t, st, false);
+        ad->v = t.v ^ rk->v;
     }
 }
 
-- 
2.34.1


