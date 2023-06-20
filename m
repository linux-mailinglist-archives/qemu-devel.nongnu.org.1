Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8577736AB4
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:16:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZEI-0006lH-2b; Tue, 20 Jun 2023 07:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZE3-0006bz-FB
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:43 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZE0-0004V9-EU
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:43 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-982a88ca610so546806866b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259319; x=1689851319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGlC/81ss1Jj94uQ0vf5KkBvhLt8Sw0gG5elkpKjdEk=;
 b=M+U36JOb+hdpql7wKTS5xxcjO6q0z3C42moEd/BzLzNsbtb4qHxKWGxDyv6EwrIQuj
 ji5JLF+DAhfp+DDQ87TKXtNICqMAQ5aeVb3p29odObllS3aS8tG1joJ4YYlt/iadjEhk
 VX80kJjB//wSXh0shC18870/fQL8uQEqYGcIgigKiPCQap7AGDvomy2itvTzYpeJvagy
 +ryEew+VVBTsrscb45I1AMk5yns40t/nJQQ64RYQfu7KmpR3kc6Vb8QYhiMp7H0VvpQx
 DZMLro7AsLxXzhl9fajRg+wRI/R7g+w88yyHHtOqnCWoE78LvQ/UgLbvx43uo0QWurXT
 37xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259319; x=1689851319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wGlC/81ss1Jj94uQ0vf5KkBvhLt8Sw0gG5elkpKjdEk=;
 b=D43bMAtdsK7s1+B9f1pJBRYm41nd2xppybMbK2A+GJT9fisf8/6wSLL3tbiYqb1a0N
 9vinc6U6sBohJ3v4yFoQQWaWMbF9JtHuZ13QTa8EeEudMcGCbbde5HHCFIfhbiByGktE
 mh7BYG+Ec9SqMdXmdA4Lr+6Bwe10fl5alYJ7JTvOAmIT+qfPCiZsw0a35Lzy9pNDzWIi
 0oE+loqkHnmshE5wTtaayRjaCtPmNjC/wlPyM5ELsDuY/gcSFt2JLAdbez//krsKtGx6
 +zeucJrclaAV42SsgLMu85huZiLolUuufavyoo8mm9GDoL0WlKhSd6D+hvVc2DT1x1nD
 cQuw==
X-Gm-Message-State: AC+VfDwMPf2yaepoCy+DNeh3gqgF+mIobzwYdDWaM/f/WhPR5tlqI6hZ
 +28zicKZJi4Y2jrGoKRESrgziEepDrdhpjf9iHrBoxTn
X-Google-Smtp-Source: ACHHUZ4tDz5SCgk7TPfYFrNWaJRwIz1YXHFZHMSk2DU7pbwnhKsA2CBtFnJd7Nmhg0D/LGW2bMAz0g==
X-Received: by 2002:a17:907:a412:b0:989:d9d:d90f with SMTP id
 sg18-20020a170907a41200b009890d9dd90fmr1541158ejc.67.1687259318985; 
 Tue, 20 Jun 2023 04:08:38 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 29/37] crypto: Add aesdec_ISB_ISR_AK_IMC
Date: Tue, 20 Jun 2023 13:07:50 +0200
Message-Id: <20230620110758.787479-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

Add a primitive for InvSubBytes + InvShiftRows +
AddRoundKey + InvMixColumns.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/aes-round.h |  3 +++
 include/crypto/aes-round.h                   | 21 ++++++++++++++++++++
 crypto/aes.c                                 | 14 +++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/host/include/generic/host/crypto/aes-round.h b/host/include/generic/host/crypto/aes-round.h
index db8cfe17eb..1b9720f917 100644
--- a/host/include/generic/host/crypto/aes-round.h
+++ b/host/include/generic/host/crypto/aes-round.h
@@ -23,6 +23,9 @@ void aesdec_IMC_accel(AESState *, const AESState *, bool)
 void aesdec_ISB_ISR_AK_accel(AESState *, const AESState *,
                              const AESState *, bool)
     QEMU_ERROR("unsupported accel");
+void aesdec_ISB_ISR_AK_IMC_accel(AESState *, const AESState *,
+                                 const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
 void aesdec_ISB_ISR_IMC_AK_accel(AESState *, const AESState *,
                                  const AESState *, bool)
     QEMU_ERROR("unsupported accel");
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index 68cec14950..ffd8ec6fa8 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -119,6 +119,27 @@ static inline void aesdec_ISB_ISR_AK(AESState *r, const AESState *st,
     }
 }
 
+/*
+ * Perform InvSubBytes + InvShiftRows + AddRoundKey + InvMixColumns.
+ */
+
+void aesdec_ISB_ISR_AK_IMC_gen(AESState *ret, const AESState *st,
+                               const AESState *rk);
+void aesdec_ISB_ISR_AK_IMC_genrev(AESState *ret, const AESState *st,
+                                  const AESState *rk);
+
+static inline void aesdec_ISB_ISR_AK_IMC(AESState *r, const AESState *st,
+                                         const AESState *rk, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesdec_ISB_ISR_AK_IMC_accel(r, st, rk, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesdec_ISB_ISR_AK_IMC_gen(r, st, rk);
+    } else {
+        aesdec_ISB_ISR_AK_IMC_genrev(r, st, rk);
+    }
+}
+
 /*
  * Perform InvSubBytes + InvShiftRows + InvMixColumns + AddRoundKey.
  */
diff --git a/crypto/aes.c b/crypto/aes.c
index 53696e8953..2676faa962 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1576,6 +1576,20 @@ void aesdec_ISB_ISR_IMC_AK_genrev(AESState *r, const AESState *st,
     aesdec_ISB_ISR_IMC_AK_swap(r, st, rk, true);
 }
 
+void aesdec_ISB_ISR_AK_IMC_gen(AESState *ret, const AESState *st,
+                               const AESState *rk)
+{
+    aesdec_ISB_ISR_AK_gen(ret, st, rk);
+    aesdec_IMC_gen(ret, ret);
+}
+
+void aesdec_ISB_ISR_AK_IMC_genrev(AESState *ret, const AESState *st,
+                                  const AESState *rk)
+{
+    aesdec_ISB_ISR_AK_genrev(ret, st, rk);
+    aesdec_IMC_genrev(ret, ret);
+}
+
 /**
  * Expand the cipher key into the encryption key schedule.
  */
-- 
2.34.1


