Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 675C174C753
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:42:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEE-0005Cy-UR; Sun, 09 Jul 2023 14:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDn-0003LQ-QH
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDk-0004Aa-RY
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313fb7f0f80so3705410f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927596; x=1691519596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ineMFXHMMUsTtHLB4+TRmNQDsbNNDE8LTO9PLI3JgtY=;
 b=yloPZVoeXW1Y9dub8O+N9Q6oI+EOzm/c2NDF5tOIq+sy/vqhSSkItj4XMVMPTQCY0b
 wCt9RPxUoT152hjYGWnWyC09UoewpAvvEKMhvRbYGmfw5maG+xPBdC5wog/v8F9MCmbu
 XsYS/8nLv0w3a+tf+KNu+wej3A1bbiFMb4mX/I1TLvaCTFN9aTe6f/pIInIY2twC7s2c
 WBP9ooE5wAMaSYEzUvFdThV9K/wGzVBKqwISlGV/GQlfk7IY6RbNLiCiyXKoFfO/xhqB
 KtMflNtKTYdOskb80REn0UaOJl+em8lNOO65++vU8ZIOc1juWG6qSWid+zfbqR/7WS4k
 wMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927596; x=1691519596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ineMFXHMMUsTtHLB4+TRmNQDsbNNDE8LTO9PLI3JgtY=;
 b=fq9a7nAEuWa+pLHk47j9xIRNvP2yJnCfKHaj9TbGN6meDlg4aMkyPE3JtncL//OLyK
 HB9fcXatnCtGCXWToglrS2rOtVCPEWLv86vmSPoEmpIhvTh0l3w7hokXZ2mjAev4IR5S
 sCgOi4txIyrYe+KwuaJx1rCAUxeFLld9sjG3uUDdGamPS8ztx3k5Fw4DWZajIy8MrAAE
 VCttuArrss7GfRGUhoMgwY0NWU12GpFfQOCd3CaOt6NgADRovrzL6Kk9KHt+AGs6bF//
 cl3mjEtaKrRLj4aXsZgmxyNEBayuJ8qhYmSXuRdUxSmIiKDa2w67+EwAuoYTL1sBvQbV
 sWrA==
X-Gm-Message-State: ABy/qLarBSoIEWYweGq9rlvIlcKQ5YdxPHqi5fC5v3yLOj7lNRhERXD4
 Pqn4bIT7gjX+HAx4fxZEb0u4ZcOlUq+FCqVTuNT2JA==
X-Google-Smtp-Source: APBJJlE6vC2CeXnYSN0ZTs90hZrgeJoYGQnhsiE83rHLBDUbOU4RWF379vEYG9t+8iZ80ZKjkDDByA==
X-Received: by 2002:a5d:404f:0:b0:307:7f38:37f with SMTP id
 w15-20020a5d404f000000b003077f38037fmr9063280wrp.66.1688927596657; 
 Sun, 09 Jul 2023 11:33:16 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/37] target/i386: Use aesdec_ISB_ISR_IMC_AK
Date: Sun,  9 Jul 2023 19:28:58 +0100
Message-Id: <20230709182934.309468-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

This implements the AESDEC instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 93a4e0cf16..a0e425733f 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2162,16 +2162,12 @@ void glue(helper_pclmulqdq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
 
 void glue(helper_aesdec, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
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
-        d->L(i) = rk.L(i) ^ bswap32(AES_Td0[st.B(AES_ishifts[4 * j + 0])] ^
-                                    AES_Td1[st.B(AES_ishifts[4 * j + 1])] ^
-                                    AES_Td2[st.B(AES_ishifts[4 * j + 2])] ^
-                                    AES_Td3[st.B(AES_ishifts[4 * j + 3])]);
+        aesdec_ISB_ISR_IMC_AK(ad, st, rk, false);
     }
 }
 
-- 
2.34.1


