Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB959736A91
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:11:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZDm-00069M-Ca; Tue, 20 Jun 2023 07:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDi-00066H-QH
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:23 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDg-0004Iz-40
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:22 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51a2661614cso6072756a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259298; x=1689851298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vdmp9g0LETEOImAoeAZ0vz3CHG5eCYIT92dyMVPeN7s=;
 b=POXZzDwbBxVX8W7rYgGEU1p3NOiohanZdbS6eqbZd95rSQ28b8KjIpQEXgLolavkIl
 U8v5G31gB6S1zxvNNAFb8WR8Elr9DLRUueBe2IVA1yOtFXRF4/38cSj4V26+4VAzcfbC
 QEcCF3hg2l/omEgBApSMvnXihuHqVeL+96Jj+fG8j4zmnqYuv25wmN/E292eFjatEcjm
 XlYOemqRvbJKA9FvbD9Wmxjh1TqD3u7NySWEU6h4G86J0twSu9IZK4lOZG2fS5Gg5jM6
 NBGvFPGxrz8HBRt/tIppt+cJgUAZR4bIQ/83p/VF0qGKUOzOOxzlLtL3DBXWgqEIWgmu
 sc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259298; x=1689851298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vdmp9g0LETEOImAoeAZ0vz3CHG5eCYIT92dyMVPeN7s=;
 b=erDUwXYey7vcgiq/Jo6fYLfSj19Y/kQEj1nu09WckgvfbHNgWTZqUIsrgsekZtTzC1
 Up7EGEr/Ewhq80r3xR5GZ84oGIp97hBGHMq2izs6t1xbcCBxtiAf0gHAx6/Ql63y16lm
 mp3Kw29p7oc07wn1UbA5HTvGKSWASXZq5jPp0N/v/zqh+j+TRtWogk6ijIqkCr4lbyBj
 mP2ix9Ti7nJfTYmpU/k3REEPt7+OAZgGX1tTXuW3li3UoxeXIF9Dnev3nUogHC7R3aqt
 hWBvZUAHJdlf9WE6Qk4tm3gBWe73B8c64ari4cYHVi5CdpgHozAHZveRjJu2cOlV9doh
 5dsw==
X-Gm-Message-State: AC+VfDz72UkeI67hH3P2weN5WSEjSuFyfDS1sMMggglTA3eCG89EAy0y
 /nI/Kc3E06r1DF6dA+UvzB79zBeHlzqiuXKNWae1YXpA
X-Google-Smtp-Source: ACHHUZ5WWPutOkvLN9+PVTteiYXFt3FURMhofhqJtAFZyhbrrKJGvohnK0+vfx//gXD3e8ClKrqjAQ==
X-Received: by 2002:a17:907:1609:b0:986:4789:1029 with SMTP id
 hb9-20020a170907160900b0098647891029mr11972896ejc.23.1687259298750; 
 Tue, 20 Jun 2023 04:08:18 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/37] target/i386: Use aesdec_ISB_ISR_AK
Date: Tue, 20 Jun 2023 13:07:33 +0200
Message-Id: <20230620110758.787479-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x530.google.com
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


