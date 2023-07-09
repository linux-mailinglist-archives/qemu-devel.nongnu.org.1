Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 936D674C726
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:35:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZE2-0003RP-7i; Sun, 09 Jul 2023 14:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDl-00033c-1Z
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDg-0004A1-KT
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:18 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso49182145e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927595; x=1691519595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBbRyJEaYCF6DplERXnYlyOqNcFvmMhKu7a8Ju7Ez3M=;
 b=ryBrjVtCzcG5Bxe66Yg3RhXI1AJDqQ5I53JXZsqA92sGwkS2tzrfYPSy+9pyDpmb7o
 bLkxrUNXeDaX3Z6qgH4465ZwQYpaF6Zb9V6XDptnt7B4DCyaESvC4XHHHGnQBlsp7xmw
 LY/2tijGhCc1AtVkuxzsR7th7mOJtGKM86nB1YIZCkzuJm/q3xLt/U233bgmuw77p2O/
 gwTzbHh0xxnRLMdJSWO46e59TV7Y6HpL7qNHF2NkdlNxotwBGFvLqjXnmBsUrOaXKg/j
 fd1VrPacoZLFm7MxUYSi5F6e8IeHE+J3qrNFlYzTdFWEwQu/XycC5f5SzX1AVPHf/2LK
 M/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927595; x=1691519595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBbRyJEaYCF6DplERXnYlyOqNcFvmMhKu7a8Ju7Ez3M=;
 b=PbqqYJQy8wEMgmSEfHxZbqN62F4Bi04D6bRWAwChrZq12roECCTB+TxMt88pQGnX1K
 7W1q9Dg3RfrtSBzRsHFCPkHcKpv9PKHlc6nQLkfi1XlSEf67yf8GUIbieeaRP6cl5dQx
 CUp3suMPC5teYfpTF9p3GtV6Adtd2du1bTAd1aTxMhlD2caAFfSvIYhFTd6Rw0pp7Bm9
 Z0zK6GiKWWvVeGwCPZeqv6jdb+BqsNVzFLz209KLItEFp0Tm3h45Bz1gJi6jkbUMqoLi
 IoHHuz0Xhzx62RvU6uKOYG1xw9FzEVf8yaMmw2A30eMbx9uAF9h913JKqY6p2/Q1LytN
 pdMA==
X-Gm-Message-State: ABy/qLZhsRZC2wLX31wtaleYsabMV1FFuFos87zoJJvRBlbchewUwhsp
 0fJQnHFVBifn2QuqtkrBb3CMxwqpSuwndSRoagOfEQ==
X-Google-Smtp-Source: APBJJlF04K6INghEKWWJZMs1KXFNtPcBv/D51G1J5OMXv8EsIZf2ePNgu7/d3Pgxx6v31HOOoyObjA==
X-Received: by 2002:a5d:6a08:0:b0:315:8a80:329e with SMTP id
 m8-20020a5d6a08000000b003158a80329emr8433162wru.40.1688927595095; 
 Sun, 09 Jul 2023 11:33:15 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/37] target/i386: Use aesenc_SB_SR_MC_AK
Date: Sun,  9 Jul 2023 19:28:56 +0100
Message-Id: <20230709182934.309468-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

This implements the AESENC instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 893913ebf8..93a4e0cf16 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2188,16 +2188,12 @@ void glue(helper_aesdeclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 
 void glue(helper_aesenc, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
-    int i;
-    Reg st = *v;
-    Reg rk = *s;
+    for (int i = 0; i < SHIFT; i++) {
+        AESState *ad = (AESState *)&d->ZMM_X(i);
+        AESState *st = (AESState *)&v->ZMM_X(i);
+        AESState *rk = (AESState *)&s->ZMM_X(i);
 
-    for (i = 0 ; i < 2 << SHIFT ; i++) {
-        int j = i & 3;
-        d->L(i) = rk.L(i) ^ bswap32(AES_Te0[st.B(AES_shifts[4 * j + 0])] ^
-                                    AES_Te1[st.B(AES_shifts[4 * j + 1])] ^
-                                    AES_Te2[st.B(AES_shifts[4 * j + 2])] ^
-                                    AES_Te3[st.B(AES_shifts[4 * j + 3])]);
+        aesenc_SB_SR_MC_AK(ad, st, rk, false);
     }
 }
 
-- 
2.34.1


