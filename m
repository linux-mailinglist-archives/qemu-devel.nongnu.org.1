Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF6783D0A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNpT-0000Uv-RS; Tue, 22 Aug 2023 05:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpR-0000Uc-6J
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpP-0001fL-3D
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fef5809999so11181895e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697053; x=1693301853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QkMiRMtS+BPrSW1C74ldMs/YFboqxxYKG6pOhc/mwU=;
 b=HxhCKrhLNHY9hutzC5ZPYe2DemcqKXyNX7mvHguq5SqvdViD/sFD0mza+9X9buu6dj
 Ds9L+RD5XYDWnuQFKAOUwXf91NOnLN+TVzvRFT0gASbqhlaN1dGVXdorKc4uklWdyi48
 Y3kfQapDDUUETu2hmr5MTYuPKhYm+GH2yZnuKC2Twxvw2m2s2DQ3CTzrTyVnsbQXOlpj
 Se/TJLJv7NTMMxjY+o4oND30LFNfrz7Eg7vT0egBOx4eq5zfZbeor8TjT/bOqQd016K0
 Of5WN1AyaY11dUmyg8AEyOE7T85wgak7jwYRpW40OaC1RvrzTe+rLVqfX3rl0xIV4aQc
 9e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697053; x=1693301853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QkMiRMtS+BPrSW1C74ldMs/YFboqxxYKG6pOhc/mwU=;
 b=jLYQ3l80Y+c2EvjzSlahc1E2h5eXio+kRKO1iZ7jmNtm3fToWvq0writVVBeA62XMO
 zm1ur5L/LNeONzbSBZO8DPk1TcCJ/qntqWx8SDdn1Y38AKfI17hl9aFwnF2DKNk8CO5W
 D9jzTqyt0hxolXvc1JiCpIUXJkK3oFEh/MkXSYKht4j12xSte29czzSA1K+jufSa/MEN
 UPaYuuhmvGnwdZSWybBzT17eCLYkCsFcp2xR+B2eULDK2U2irR3Yv4woLbh3+4ycPvRA
 9evQHiQNBQyuAI3RJmSZ2DtgTUrLndIxlIF09L1vYn+jy1TfblvV3eVRKBJeIMfGJCFj
 C75A==
X-Gm-Message-State: AOJu0YzDt/szyZr7/LEzaaU71OqrWpq/qjWIh2vNNJwcwTlCmT+pw+aH
 3rhjCN7pGa/V65QPFltyWBA4Uie2U1/Z3sKYdszo+Q==
X-Google-Smtp-Source: AGHT+IHZhgxsiHBWspd8JCAV6soyGT4zaFtqeksotTPpxixxokkgQq/x2LtSYMmj+T1kLGXSSiIlnw==
X-Received: by 2002:a05:600c:2157:b0:3fb:ff34:a846 with SMTP id
 v23-20020a05600c215700b003fbff34a846mr7168833wml.22.1692697053440; 
 Tue, 22 Aug 2023 02:37:33 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 eo4-20020a05600c82c400b003fe1a092925sm15259234wmb.19.2023.08.22.02.37.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 02:37:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] tcg/tcg-op: Document bswap64() byte pattern
Date: Tue, 22 Aug 2023 11:37:08 +0200
Message-ID: <20230822093712.38922-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822093712.38922-1-philmd@linaro.org>
References: <20230822093712.38922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
 tcg/tcg-op.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e6b0d74a46..f4fe13e040 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1828,6 +1828,11 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
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


