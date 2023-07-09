Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7976B74C4A1
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:06:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxe-0000Un-Hr; Sun, 09 Jul 2023 10:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxP-0000Ow-9J
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxM-0000cN-3N
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3142ee41fd2so3551866f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911207; x=1691503207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBbRyJEaYCF6DplERXnYlyOqNcFvmMhKu7a8Ju7Ez3M=;
 b=ChNG7oeBvyoQpH6hcvOBCDY51pQZ7OC+1X1y41WQuo93cWHgTsIHuLW4ulySsd9dVP
 Ha/b8BaySVFZbLR5QvYL12sGGMw+9rYUhrX2Co0Ya27Jt52EunVuhH/yCNdlpi83OIVZ
 Jr9YyjD+i7t7mCaQ1vpOfQvQhiRpr8gT68SXak0XJR7ajQQejcLGDwEQAH31eVV82iXY
 zIvLI0kC7Ou3gBg++U6fPlAKZ5qJRc/fSCSPAvo9ETFwO+3ZIQ6jDYSEF1nzCmepWgmT
 rYnLg+04TZV8o7s0fAHPWUuwUSjDB/7P+CFgl5M4d4Lc5fdeNO7UzWOmFjV9fVZlALGv
 UN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911207; x=1691503207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBbRyJEaYCF6DplERXnYlyOqNcFvmMhKu7a8Ju7Ez3M=;
 b=ERafas68AkDAbYFuZLFTU250Rn9vRPLCBhqqGoItrcAMxL+Gh1KhppvxPCD6SArWB1
 aTHiUfndy61v5p2GsIE1eUtXhHBAWhOaPgAe30/B47yz4f6EJfzmPh9m3AmVj3jBfQj/
 d3+ETCo+k7wr7/AgzBzm7G5BSfIY8oV6v0NmfQ2kfebuI/AhZtraN4FgmW85mEWycjnL
 gq1BQhA//5O3xQzJNZPbWJrb3qbULxY9zZFLdOVw59ox1a6n4u23DpPa+y+t21gv6XtT
 yCwWe5JHudEds+/0kzJSqmdXX6ApH/Yssz9CIENkWFsV30zA6AtBAw69tNf1BWdClGm/
 M16Q==
X-Gm-Message-State: ABy/qLZxcrgCz+4ijdrEJ8JABO7Da3TyzsjrnBNI6Rl6PCzrkzihzXfE
 FXrymK2GY0/U0gw4Cj5a5haclm77MDPrejwPUFSDFw==
X-Google-Smtp-Source: APBJJlF0Z2xsgyGdZ0O31bTwH7Bqo+6V5YcOODe47fjOD/bhg+2fRXmGnvCDuLucodJURWVjtZ6x1A==
X-Received: by 2002:a5d:58cf:0:b0:314:77a:c2b2 with SMTP id
 o15-20020a5d58cf000000b00314077ac2b2mr7774527wrf.32.1688911206772; 
 Sun, 09 Jul 2023 07:00:06 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/37] target/i386: Use aesenc_SB_SR_MC_AK
Date: Sun,  9 Jul 2023 14:59:30 +0100
Message-Id: <20230709135945.250311-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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


