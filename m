Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F41728DE1
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 04:26:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7RpB-0005EX-F5; Thu, 08 Jun 2023 22:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7Ro5-0002y9-UD
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:24:54 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7Rna-0005ha-Qp
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:24:52 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-39a3f165ac5so219138b6e.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 19:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686277461; x=1688869461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lOYUQGr/W2hN41A+MbMW4B7XkhWFliC6iC1qe2q7c8=;
 b=zbpS69gzh/dR28tCj8pisAa4WcDflkfTGy34MML4nwm224mHp68pxd8rw/fqix2T4f
 xkqOV/t6pfQl33O7MS8TK3EZSnkdYzMHFcva9He5YHwrDapHfK+7VRvDN49qvwUekK3c
 qN8UJZuwcq4Trr25e4gP0LTzGX2wjF2OnRfNpGd4N8EwG1+7xJOQ6RMXsG/o1TUvKPjR
 NJc1TaA4IpEi6+t9oGPLBL5qqf6Ol0IYXaTuhh15wUQ8OhKfKTNtEJiiKPi7F/akFqny
 OXmidwh/llLp3QxVnUZVeVoBkprE9qZ/gboVVqH5Q7JmdizhXPtEC4Rbw4+fwrRLMs7D
 8LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277461; x=1688869461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lOYUQGr/W2hN41A+MbMW4B7XkhWFliC6iC1qe2q7c8=;
 b=Hm427SzmArFPlMEl5ebf0MRl8TdImh3vrUcusK/BTsCQn/eNcyL5mBwSj9t+/BZ7o+
 PcqlbpJT/KEI3nLiOkCxd7jZtgvxdR8R7IjFL6la9BmLMiQSZgUU424U6/m7RmSHmkEd
 rLUdgOeDUgRJzK9LTwp599Dh4CQFp6zPST2fYdGAoYV49bmoAHSW/EUyCuJjxRrf/LUE
 CLe+/Gp0nAhyehm0ssJ8wGbhY5xVzHsnkMVHSMDE+woYvRjKLd9ZgC8LteHRmPcXOgpx
 aNogzQtrNSw72eCf8WQafm2JJswdOhREKEZsR4Lw7MFmCR5kobdepxRfdEYcMYtVnnuk
 RstA==
X-Gm-Message-State: AC+VfDwmtJGbYzZCBS1ePVRnIoOhH2z+kokip+ptq77c/o/Y91nN5U42
 zibje4QT7XonOAZhp87QZg9QcmtzOnCZ68hUPS4=
X-Google-Smtp-Source: ACHHUZ5TXCBAyKR6oBOE7Z+TcE3kgttcfeHVraoM6/NwhUTIuND4PbvTuT+NTYI924H3o+xudSEONg==
X-Received: by 2002:aca:b01:0:b0:38c:5a32:325b with SMTP id
 1-20020aca0b01000000b0038c5a32325bmr262270oil.41.1686277461655; 
 Thu, 08 Jun 2023 19:24:21 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a62fb19000000b0063afb08afeesm1686458pfm.67.2023.06.08.19.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 19:24:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH v2 20/38] target/i386: Use aesdec_IMC
Date: Thu,  8 Jun 2023 19:23:43 -0700
Message-Id: <20230609022401.684157-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609022401.684157-1-richard.henderson@linaro.org>
References: <20230609022401.684157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

This implements the AESIMC instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 0a37bde595..893913ebf8 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2215,15 +2215,10 @@ void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 #if SHIFT == 1
 void glue(helper_aesimc, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
-    int i;
-    Reg tmp = *s;
+    AESState *ad = (AESState *)&d->ZMM_X(0);
+    AESState *st = (AESState *)&s->ZMM_X(0);
 
-    for (i = 0 ; i < 4 ; i++) {
-        d->L(i) = bswap32(AES_imc[tmp.B(4 * i + 0)][0] ^
-                          AES_imc[tmp.B(4 * i + 1)][1] ^
-                          AES_imc[tmp.B(4 * i + 2)][2] ^
-                          AES_imc[tmp.B(4 * i + 3)][3]);
-    }
+    aesdec_IMC(ad, st, false);
 }
 
 void glue(helper_aeskeygenassist, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
-- 
2.34.1


