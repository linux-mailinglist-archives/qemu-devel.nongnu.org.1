Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23051720D62
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H6V-0000VZ-4D; Fri, 02 Jun 2023 22:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6F-0000K7-Db
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:41 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H69-0004iW-Ez
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:38 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-25669acf1b0so2383049a91.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759672; x=1688351672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzPaKBoi+AazRfwP5mOI7xFIN7w0g/MQbp2bpj2kQAc=;
 b=c8VUY7fqmPG9KJzwKTDju8ivBFkRd5H/Zurp/BuEHnmVfYeVhlS1lBBQIc5e0ozit4
 F5nMpmYPIOV1IrHa7IsWo1jiXpLczDqm3DjeTkF/0A1/BD9WfKaLNGNLeJJJpG3m/7zc
 2W2aS9RzlsZ4NC78L1Wv6oxD3DPXzZRkBpOZhr7xGOLnWjhDSZq8bERk3UFMqduKo8s3
 mX7rurpOTGQd2JVU1LFY4wrzSzBMHYEZdpTJFrXw6ItMpqERJ1lsNsjsmgZ17gPt12QD
 aYzPhE7d+SsQS2xs1sAaMwmV68ZaZgWK283lVJjdVqz+1l64UlFbzIy871i3KqgR2ggQ
 eyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759672; x=1688351672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bzPaKBoi+AazRfwP5mOI7xFIN7w0g/MQbp2bpj2kQAc=;
 b=ALpWF5J6D5F6GklvxWEwG6viaRkuXJfiZ653AZ7VtyXUNJ2xbTvUQuZxEux51rAenw
 2AA0TMcCJ8syKsdxB9PT1SFO5z6CIcP5DQjq1YQFuLLW3e1qNIEcM0KDMGTU6GNFpmpn
 b2wgAx3t1SxsIBjK731pDnsbJwwRwY5EkAPvOTLgezpQHJnx0YDLz/Q1f8ghl0SY/5TK
 uEh2YIwCFM4Dn0VzFTai0ipgx5sUcqBTibdAGJa2v9tE3hbCtfDuuHhM4SRw+SvhZHQ8
 XkKXTKUR0fXg/Xq/lYEBFeYTk0pU7sR+cIKDsdUydUEYfXfHcOyux8l63xnSTnlp9yMs
 Lp7A==
X-Gm-Message-State: AC+VfDzVpJ9MJJXYaeA13ZScNA0XPc4hSZuDwbqVXH/KlpWY6XTIZjF8
 LeF7yB4Wm8AsWmSIH08dsCdHpSgINZ3PHWc7d5Q=
X-Google-Smtp-Source: ACHHUZ74GG32sCsz02zvQBpeFpfE4e5SJu7pFh04QWQ4rOB9dPSZrVB11Qn/aAPV5WyNvFraWzTDkw==
X-Received: by 2002:a17:90b:4a4f:b0:250:9e7b:2798 with SMTP id
 lb15-20020a17090b4a4f00b002509e7b2798mr1509757pjb.18.1685759672216; 
 Fri, 02 Jun 2023 19:34:32 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 05/35] target/i386: Use aesenc_SB_SR
Date: Fri,  2 Jun 2023 19:33:56 -0700
Message-Id: <20230603023426.1064431-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

This implements the AESENCLAST instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index fb63af7afa..31e1f6edc7 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -19,6 +19,7 @@
  */
 
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 
 #if SHIFT == 0
 #define Reg MMXReg
@@ -2202,12 +2203,14 @@ void glue(helper_aesenc, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 
 void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
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
-        d->B(i) = rk.B(i) ^ (AES_sbox[st.B(AES_shifts[i & 15] + (i & ~15))]);
+        aesenc_SB_SR(&t, st, false);
+        ad->v = t.v ^ rk->v;
     }
 }
 
-- 
2.34.1


