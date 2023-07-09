Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7174C48D
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxk-0000fT-J3; Sun, 09 Jul 2023 10:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxO-0000Ou-9J
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxM-0000cG-2E
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82d9cso37691245e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911206; x=1691503206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZmDZIvgGB2xxk9tqZEB+B+DCJxeJQyw+1f4RzekeQw=;
 b=XSq/s9hc61HfxIgHfXZOfiUaviQW1tb3gXsFPZEAb66gPIkroyfktErhwQBuGFLkzs
 Xs9jStsYNJsaNxNC2wWIurBiQjQyIOTEFJ2oGFC4NxWA1N5+tgWP63hYujXX++cvZJxX
 jBVIs55+jMSxMBEYckphx+1keQ8GN3luaCdkxg8Bzlcn0tlkNp3Ej3mHk4Hlpk82MhVO
 WU0xttXHC+nbs0yFbSlvkYbA9tAdDhgZsuGypMDgIMzASnKtkev1FYpkV+O5uLWdno7v
 F2v7h41XjJwK9DonHN7fCLErQj9kq2A5+4S4Ec21zV/18CXMVji970WN5qQ7I4LVPZYu
 Adpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911206; x=1691503206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZmDZIvgGB2xxk9tqZEB+B+DCJxeJQyw+1f4RzekeQw=;
 b=LX55G2AKm5yL8PLDTz/Flgd17GQNuj+hGHAKLU0XkpXnJSZUtJzgwqA6Zhrq5JAwGs
 1olMDFCOSLrVBPsLP88OItxRhDL9WhoWtnnD1stOjlXxsugQNjD0rmA8vwVXTSj2YFsh
 FLyp4d25lGjZcIL59IyT1vU8C+jBkNjz8Msq658CGZho94UceOPFrh4WWTrta9QhtHW7
 DmC5QqoTex04KGlAxidy4rdcMIu+i26sQu/rAme623Ts55GknPpMlHOLHyA6pbBcOURh
 l70lHtMx5IXPvaG4fBpdej5Yxtwlw5XGHyp/R+YGgq+ja7pGvsEWpaN74mY+Tenpsht6
 AqWA==
X-Gm-Message-State: ABy/qLatr/YNXD/fRJucApS4wxcFP6bsb/NUO6yst7InM+B7+p9qmVs2
 M/OeAkGhvKU+2WW3bI3QNcxnvZbHodeU87GMIlr+lw==
X-Google-Smtp-Source: APBJJlGYGql1QPiVHpVcX9tGxB4bp0U8WdkXPWpFh0+pVKM+O7O20NfiLXwpPk295/jFk2hPTAU5Ug==
X-Received: by 2002:a05:600c:c8:b0:3fb:b05d:f27c with SMTP id
 u8-20020a05600c00c800b003fbb05df27cmr8106333wmm.34.1688911205651; 
 Sun, 09 Jul 2023 07:00:05 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/37] target/i386: Use aesdec_IMC
Date: Sun,  9 Jul 2023 14:59:29 +0100
Message-Id: <20230709135945.250311-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

This implements the AESIMC instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


