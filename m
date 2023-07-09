Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E2E74C486
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxd-0000TP-A7; Sun, 09 Jul 2023 10:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxL-0000Og-PX
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:14 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxK-0000bb-05
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:07 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-313fb7f0f80so3552545f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911204; x=1691503204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vdmp9g0LETEOImAoeAZ0vz3CHG5eCYIT92dyMVPeN7s=;
 b=IYEDiDURjrjs7zpSjIPeWWWpKLHVJpEnYcgOvg03nQFuoUk0eQVqQ1faBF11GW+rny
 SV9VolhawGEVprWqVCmivAzpcGL8kbcD/xA8jYHV0+6hM8Yc47L84qg4MuWUa3+G5kR3
 EHcGQXaAx+Vt1sDO7tO+y1j2PSWQMaO1Y5oBJhCRacMayiPkxghgxU7Kn8fzAc5SXX0u
 QqCUkuMxSxSv/3mfHzmmYqEJjV96pe9wNeULwhd/NrT2m+xSPVkfWFx8v0i2+E30dnqU
 0VAqK9Mo393H04NQujU/4yBSDUWtgjgKXnfVzRQxdSTu+dEBFCScLw7nILrkWQd08RvG
 POPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911204; x=1691503204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vdmp9g0LETEOImAoeAZ0vz3CHG5eCYIT92dyMVPeN7s=;
 b=deEHoOKCs3VF7nKYJElfw+Dk7UzVzeW9DsSU4mcNrm5qVYedQVZhBnkQOs1KZdVDgE
 U3lXSkezuzpNiSdjb+IOHaO5L749bQUA6y/IGG+kPBPmr6vtRfxVO81LcDb82Q0TkyJt
 4CYczE71DMuX6sb/KuDLzawkwQ8AkD3noGkyVEACU5IynvcMTIdtu0KzINqymR6hKzwf
 kQyCvk0JmMGqp74WBOZ7uCsxcDK2G5VzJUVFs0Q2hIk1D/4nGCyXaEdaChlxC5bkWSUq
 2WJ0k/UjMu9V8COnyRnJcwfW1OaesOS+kieJ7ljLIZukLZuNwZ3ukwYhmsDwAqASAtvB
 at4A==
X-Gm-Message-State: ABy/qLbGKolX5VvHUczIXnYVHZRrwOZWLG2IYBgeois+DPHmjydaFTUm
 ijL/GzSK71DbDolQhOpc4WJx41fq0/95nGmb0cS0rQ==
X-Google-Smtp-Source: APBJJlEJhg0ZBGncEYvCfyDxWmb4jt7RNdHtazGEw1owQ9CnH6HON6dFW053+DmWuakanigYc5H6Yg==
X-Received: by 2002:a05:6000:104c:b0:313:e55f:b78c with SMTP id
 c12-20020a056000104c00b00313e55fb78cmr8081235wrx.21.1688911204546; 
 Sun, 09 Jul 2023 07:00:04 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/37] target/i386: Use aesdec_ISB_ISR_AK
Date: Sun,  9 Jul 2023 14:59:28 +0100
Message-Id: <20230709135945.250311-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
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


