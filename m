Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F75783D05
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:38:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNpN-0000UK-1u; Tue, 22 Aug 2023 05:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpL-0000U6-92
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:31 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpJ-0001f5-6R
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fed6c2a5cfso36531695e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697047; x=1693301847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScWnOEjDsuqOjg+NrysUJ/0UybO3mydJWW4efYlOcP8=;
 b=H0pNobUtiCZdW651FbO/wmC5OXN0Dz7vwvnB0zAGqZtsQiLGN/J4KkaEvb4q4xP1LU
 XnpZt7jVRHjgP8+fqjl0eZTTeiakV86cVzksBBfLroI9/rAFMcWCM1BJpsuHol4kr7wX
 ASkPQ1GxPbCzldfmyh6V+wtdIPhwNAinPGN2V3DsnloxmmY2Yh6D9TXluWZYwJN/kxGA
 5/+qi2cl1FiT+fO2Rsxh6CPICYAjhIVSlT2PqMPpj+u0b+JbIWqJZ+t9wIxWqcfp5ScF
 ApFTJmnhZ0Y3JyLag+RsU1P0CYoyv4M4F2y/Phx9gixIIUmGfTLjGTeIpIrhpNBACf6l
 oI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697047; x=1693301847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ScWnOEjDsuqOjg+NrysUJ/0UybO3mydJWW4efYlOcP8=;
 b=Iv2fC52tVViSVGJiKL8/jW/l6KZvViJ47w7T6iywshjE9S7OMwXz9QKaczWWkYuwyJ
 cBivK6qMjBonAiuTXdqYrpeo4VjcEpg2Rd1eHbWR0AivkyUDL9tLkBj/V88nReEaRC9n
 u3D9onWrWGl+Em8k0zhR54IWlwHxhsKp/sEeym3HQu1JFBhbF6ch/CJkHQeedVylQxBS
 qF+pIx0lZa7e+b9zWpzVpRe0546Ez5kEJmVzpMG5EIoKXspFOkWy+HFOwxlhSGhEhPzi
 Q61cgFI88Vv5mBCKheEtPgnI1uAwyWmVU7BbKnKUdr2kKXeJMyNR/2ycghMwnzGLIjwc
 r2ew==
X-Gm-Message-State: AOJu0YyVeuqpKLVcQH7dhJSmMgUfWQGuz80Y5IE0+XR9g5aS7f2z2qim
 ka7ert7UQDa7i8ZN2Z8OMHUJSHQSaV/2qybEtIE96g==
X-Google-Smtp-Source: AGHT+IGqY0zjGrSLmymreaH0EJXezEnzPgRVgu+RY5Q+kD0hebPCTYNYL4enXb1URtipRMiWBvv86Q==
X-Received: by 2002:a7b:cb59:0:b0:3fe:f45:772d with SMTP id
 v25-20020a7bcb59000000b003fe0f45772dmr7038232wmj.28.1692697047571; 
 Tue, 22 Aug 2023 02:37:27 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c040c00b003fe2397c17fsm18871021wmb.17.2023.08.22.02.37.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 02:37:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] tcg/tcg-op: Document bswap32() byte pattern
Date: Tue, 22 Aug 2023 11:37:07 +0200
Message-ID: <20230822093712.38922-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822093712.38922-1-philmd@linaro.org>
References: <20230822093712.38922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f164ddc95e..e6b0d74a46 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1061,6 +1061,11 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
     }
 }
 
+/*
+ * bswap32_i32: 32-bit byte swap on a 32-bit value.
+ *
+ * Byte pattern:  bswap32_i32(abcd) -> dcba
+ */
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (TCG_TARGET_HAS_bswap32_i32) {
@@ -1776,6 +1781,13 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
     }
 }
 
+/*
+ * bswap32_i64: 32-bit byte swap on the low bits of a 64-bit value.
+ *
+ * Byte pattern:  bswap32_i64(xxxxabcd) -> ....dcba     (TCG_BSWAP_OZ)
+ *                bswap32_i64(xxxxabcd) -> ssssdcba     (TCG_BSWAP_OS)
+ *                bswap32_i64(xxxxabcd) -> xxxxdcba
+ */
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
 {
     /* Only one extension flag may be present. */
-- 
2.41.0


