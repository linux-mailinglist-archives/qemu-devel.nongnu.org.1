Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43260785B48
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:57:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpI0-0006xr-88; Wed, 23 Aug 2023 10:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHM-0006oc-C7
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:16 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHK-0007XP-I9
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:16 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so7244625a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692802573; x=1693407373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TDxedktHF/mlH5ygYaw8lfO5Y3QpjQH82Lwm6XiycI=;
 b=hvWL6+3nd4dLOv1KivUwXYLVIasA4s9FKim2Cbzm2CMd9DUvE1pZOu0f0wy5OrWARj
 2WhrIzfeyI7kRljvN6vxhwDH3NTNpbVX33OExP8DEG2X4o+OcOaiv9Tg24srSNML3bt8
 FriLfZujHWdZ7/ozy6fVmNZt8Dzez0v1HYlLBd6dOHzOBMK4XMhSEUrEFOF48wzLta/8
 tvtSZtbcZh0d5t6470lapGxaDK7F4qTsSqmqAS2TTmayfRxrrLpqBw8TjmJdCSrp5+vV
 VdqmbdkDFbgvigBHfu61cnY8Aj8UdVkGzfnx3/zIl7/KxT3Ub4IKuCKaWDwWtPH+EqUj
 WCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802573; x=1693407373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TDxedktHF/mlH5ygYaw8lfO5Y3QpjQH82Lwm6XiycI=;
 b=WO7znQ5EjYYIaGpRz3pDGvD2xsIiBVfF1Oqwc9yIe58ln9goaxQJX51+jLQK7UAIXC
 Ifh4+dJ74a55Uq5LjIaDPRJY84RrpLMqA1T72qomILx6ifLYHSqf+3kJDw/PochGNigv
 EQgH8Icy/QxzJ5l3RTyeRc7l9w/j552B77GMZL4qXVfpLFpI3uxYiwSjkY/xPJ99sz2H
 9ekguxuRiPZ4lTOzK0KJJzcFk6wpycDhTTgwDnVHEGtSFMhRgTZuI6XSvSPyXi7GAX5k
 ZAcx7nWcwXFW8V1VxUOFjMJEXBex1JDYoGeaIcg4C4qwFX7sc41gAaR0gS9RNSs7y2Ip
 oO3g==
X-Gm-Message-State: AOJu0YxMg3pORlt36nZceGccfjvDq6AzFXQDxmLMzEgNv7JA+KAGGD5F
 y1sQ7Jw8/Cc5S0GpIyAuA0FjhJdswskGUsfrhpDoNg==
X-Google-Smtp-Source: AGHT+IEydd+BE/Y03wkMv7+y/RUl5fr08mpzbI+mMUhWV6z1QAjX/xodxLvBo2phxTkzNRwr36XoeQ==
X-Received: by 2002:aa7:d790:0:b0:523:b37e:b83d with SMTP id
 s16-20020aa7d790000000b00523b37eb83dmr10024633edq.41.1692802572895; 
 Wed, 23 Aug 2023 07:56:12 -0700 (PDT)
Received: from m1x-phil.lan (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 v13-20020aa7d80d000000b00522828d438csm9392751edq.7.2023.08.23.07.56.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Aug 2023 07:56:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/8] tcg/tcg-op: Document bswap64_i64() byte pattern
Date: Wed, 23 Aug 2023 16:55:39 +0200
Message-ID: <20230823145542.79633-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823145542.79633-1-philmd@linaro.org>
References: <20230823145542.79633-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e6e62c4278..45290cccad 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1846,6 +1846,11 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
     }
 }
 
+/*
+ * bswap64_i64: 64-bit byte swap on a 64-bit value.
+ *
+ * Byte pattern:  bswap64_i64(abcdefgh) -> hgfedcba
+ */
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 32) {
-- 
2.41.0


