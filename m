Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1141784796
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:29:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUFV-0000lq-WA; Tue, 22 Aug 2023 12:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYUFS-0000lZ-SM
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:28:54 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYUFP-0002wT-WF
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:28:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-317716a4622so4222206f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692721730; x=1693326530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3ZKJeK3dj+pXizGZ2gnFoNv1vZYmRKM7P5et2CZMMw=;
 b=sLGpvQKj0zQdVU6u5txBnGXJkGwVEa8wBYIuVM93RkRANx/vCn0xAT7wj+3oRm4f+0
 tVLlBVZDzTcdNbLOwGEdIYLMx0q0TLM0ndnnHwU1jsYnFkM8XFNDEOumEQkDGkLUUqzG
 SzSdajrYJlpaE9jw40/qDO02WTVhJeEiZfQiL2/RPIF4U7N0ZQORnP2QhRjjoj1rhePw
 UJmBgO8f5SqnNL278m4/xIvkCYCKQZ+KxooH2HnW6Aaiz8Egnb7r8Rk6rbBgbFRe6p+R
 M7zWdAg+ROgqu5jdUCyypqd2YBP5cp6DJN+3KG2CUltUHb30PmhIPxiSBa5ArIbKz529
 wXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692721730; x=1693326530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q3ZKJeK3dj+pXizGZ2gnFoNv1vZYmRKM7P5et2CZMMw=;
 b=Zi/GV6k55M6z4O72hP8YC22wlqhlTL0WCPKg1YzbPjOgEt+L/4ye6agAmOM5po9dwX
 MwTijiYvT8KIzBYt5vYpUs16oiwaYAtgHxxbRtm5TQIUu2hIzKtUyvP+ZO8umBBxs5TA
 AdMHVYBsygeKBxHHXZDqzwCpJKu3womhWEp1kKEIIuLlDXTImjjRn00pGqibJ8gzvDYs
 5VMkqqIEi1eXGDt5+jVyWTqsSYeYWLC0m9UCL36NblL6mWVsCgVzarpZCgZIOaLokUFH
 Y8JxGapSQBFhJcX9YIfIE0g2klktpU1Ms/Xqc3YknRJQ3Ezee2F7Z3t2VQ84dvGQ1hiV
 iiiQ==
X-Gm-Message-State: AOJu0YwP957lsEOxCM31d2oG6CAD64AkApDt3erJarAAVI/t35Rfyl7x
 pWmKE8ZNe4x/KRhNLGy1FkY8IhXvrTbkMdJOtxyJ3g==
X-Google-Smtp-Source: AGHT+IGw6gGdPotJr1sff29UMxEJtMbIKGuwTrzBn5DAT1Za3cbr/+vltL5IYP4bfaM9Df2oDBA+rA==
X-Received: by 2002:adf:f6c9:0:b0:319:6956:725f with SMTP id
 y9-20020adff6c9000000b003196956725fmr8000156wrp.41.1692721730122; 
 Tue, 22 Aug 2023 09:28:50 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a5d4b8e000000b0031434c08bb7sm16281378wrt.105.2023.08.22.09.28.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 09:28:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] docs/devel/tcg-ops: Bury mentions of trunc_shr_i64_i32()
Date: Tue, 22 Aug 2023 18:28:47 +0200
Message-ID: <20230822162847.71206-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Commit 609ad70562 ("tcg: Split trunc_shr_i32 opcode into
extr[lh]_i64_i32") remove trunc_shr_i64_i32(). Update the
backend documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-ops.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 6a166c5665..53695e1623 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -882,14 +882,15 @@ sub2_i32, brcond2_i32).
 On a 64 bit target, the values are transferred between 32 and 64-bit
 registers using the following ops:
 
-- trunc_shr_i64_i32
+- extrl_i64_i32
+- extrh_i64_i32
 - ext_i32_i64
 - extu_i32_i64
 
 They ensure that the values are correctly truncated or extended when
 moved from a 32-bit to a 64-bit register or vice-versa. Note that the
-trunc_shr_i64_i32 is an optional op. It is not necessary to implement
-it if all the following conditions are met:
+extrl_i64_i32 and extrh_i64_i32 are optional ops. It is not necessary
+to implement them if all the following conditions are met:
 
 - 64-bit registers can hold 32-bit values
 - 32-bit values in a 64-bit register do not need to stay zero or
-- 
2.41.0


