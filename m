Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2143674C723
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZE2-0003RA-79; Sun, 09 Jul 2023 14:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDg-0002be-BI
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDe-00049e-Aa
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3143ccb0f75so4500776f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927591; x=1691519591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vdmp9g0LETEOImAoeAZ0vz3CHG5eCYIT92dyMVPeN7s=;
 b=GcDB1cwlWv8onx7DRhbKruSIPUGqxU8t2/6QJ0jA+nsc8g335q46Y75foy3clj4/2a
 sblvdanIRgZEsp/BTZ+2G+Tjw473RDCjTCREVzGseG6fsQmQt/9pQaPkIo8IVgUz3/FZ
 nMcP9H6YTVBXa9Iwwg40ddClph1v2sRQJUemrNb9ohWYS1do2b4giSUIuCM87OmCGfro
 nC6TGj7CySxDfspvcuusHY6zJra1BkoXKO9n0RfsKqfDRz7XxieqZ5Wbq6/4u9WrvIDe
 hXaabtaVRm4fymQMXvhvzrhiNY+HLzmvxcK+L8TuUlAm+nJFupr7cQWXpHDtEUXMVLNx
 DjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927591; x=1691519591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vdmp9g0LETEOImAoeAZ0vz3CHG5eCYIT92dyMVPeN7s=;
 b=XXePY6oOMclUQLckRK5m3CHcOvs17l82rfrVafZyvdNZlzGYE9+ZINcTzQUkLOmDSk
 wl5rO3CgGZmo5Goae09GGOdbxF0CRj7pW+wW5LtYa/Rh8akoR6ttw7QdnE2ef7ac7/Zg
 JeRfADywQSD6wvsXXeY+WmiGvS3lI3lnD5MefvVmvYM6Df9J+PZeeAPqAwxbLgC4LUsB
 GTghCQ1i8/j214WQsvh307TLNomZFGyAbiF+KxJWjB6wq4GsSsY2EtT/iQ1Hksomtv5O
 C/wuTOp4igWwnuLz2IyVilJoO0Lmlt65x/TiUTmg0QNqNMgdURcaTr91V5vlccU2OsV6
 CSKg==
X-Gm-Message-State: ABy/qLZ4xZ3/yRaJJ23HrCvd7D6WY/IsP5dPTyiDPMz85UDqTIJLSidj
 CW5PASQYr6itWuf8ViBpiGh9WG8FjsWqWKqz4hLxlw==
X-Google-Smtp-Source: APBJJlFlaDKUCd46y5jIqRP71apM35BnIibYqPH3F/RR50osMFYYiYQGTTnQYhnCVdjgRiE/tRFqAg==
X-Received: by 2002:adf:de0a:0:b0:313:eb81:d2f6 with SMTP id
 b10-20020adfde0a000000b00313eb81d2f6mr13119496wrm.4.1688927591647; 
 Sun, 09 Jul 2023 11:33:11 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/37] target/i386: Use aesdec_ISB_ISR_AK
Date: Sun,  9 Jul 2023 19:28:52 +0100
Message-Id: <20230709182934.309468-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

This implements the AESDECLAST instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 63fdecbe03..0a37bde595 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2177,12 +2177,12 @@ void glue(helper_aesdec, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 
 void glue(helper_aesdeclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
-    int i;
-    Reg st = *v;
-    Reg rk = *s;
+    for (int i = 0; i < SHIFT; i++) {
+        AESState *ad = (AESState *)&d->ZMM_X(i);
+        AESState *st = (AESState *)&v->ZMM_X(i);
+        AESState *rk = (AESState *)&s->ZMM_X(i);
 
-    for (i = 0; i < 8 << SHIFT; i++) {
-        d->B(i) = rk.B(i) ^ (AES_isbox[st.B(AES_ishifts[i & 15] + (i & ~15))]);
+        aesdec_ISB_ISR_AK(ad, st, rk, false);
     }
 }
 
-- 
2.34.1


