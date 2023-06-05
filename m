Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C372313B
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:25:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgM-0007PD-L2; Mon, 05 Jun 2023 16:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gg0-0006wb-Cb
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:43 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfw-0005o1-5f
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b025d26f4fso46227405ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996374; x=1688588374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsyqPtMTdNEpZg829naXwd7rY7o+p0Sx3i4U/bLMgWk=;
 b=nh5RFXsavrU6NmJJ2DwwXqTNGTBxPhKQYo62dTXzowNoZVPmC5VN3/Lqt8jqRCSYzh
 0brcakA4UJinYLLROcnXEC0L1U36XjvMekckHJA8a2CaXSwboeHLoRe5uZkzZa5fu/l/
 RcwKlbR6tqIXUyWXyVRLRHiJ0z211UTGAvON5qwjdVWEbnp0VEDtsGyktkxwS66NWQX1
 SKNujPGi7vSfki1t550gygnfMT8Bx0whfTKJKxXyIJ7q91u4lmGeVOG7r/O2qTUNMcY/
 wrFe4kWyTtmBVoZ5jwWVl4JDWDgOiQYj6QoCxQaAqChtnQEDy7RuAlSuiaLbDnfc/JKm
 Z1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996374; x=1688588374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsyqPtMTdNEpZg829naXwd7rY7o+p0Sx3i4U/bLMgWk=;
 b=UvOO/f1EiPw9w1MENvFOyQ3X2ssBBbZSnU7yKZnldT9E3Rg/O2kNtPWKjJNppZkKQe
 Y88LNeCBuVmIJDQWHne2Ks14McwxA6LElBpJRHaiJbZyKdCiwMhP1ihZUhdS5Nj6WGjj
 SO54SY5dGGoojFruqBMjUmyJX5KKZtCb35DpQfdl4oMhXGatko2z+sMzygVSOIs2hEE2
 Sa7G24K+jIauiwd0b9Sx8qGto9wfUpU+yQhU76Utxq4SaCy+ANlMEC+4Ar90GGOfaNbM
 ljnyVwGD4GeuCE1FsEQDZIbvT7JRGURe6b9lcxAtP/Wgl3Xat/Fd1g904INkrsborBDF
 8tkA==
X-Gm-Message-State: AC+VfDzOnmQX/ydbgWZJ2ySMbnLBVlPLBc+hNc/7SjjweGMMJRPVf6PU
 +x7SVTqebsLMgx5W+3vWgF6JkFSbXV/OBIe1S6I=
X-Google-Smtp-Source: ACHHUZ7UU5KnxqZqJdDAbLtBeG8leVizvaBhyXI9BfxcVvGi5gB6VgwzjgsL3HYNHSyTPVZSpHIjDA==
X-Received: by 2002:a17:903:489:b0:1b0:25ab:a9eb with SMTP id
 jj9-20020a170903048900b001b025aba9ebmr65190plb.8.1685996374641; 
 Mon, 05 Jun 2023 13:19:34 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 52/52] tcg/tcg-op-vec: Remove left over _link_error()
 definitions
Date: Mon,  5 Jun 2023 13:15:48 -0700
Message-Id: <20230605201548.1596865-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In commit d56fea79f9 ("tcg: Move TCG_{LOW,HIGH} to tcg-internal.h")
we replaced the "_link_error" definitions with modern QEMU_ERROR()
attribute markup. We covered tcg-op.c but forgot to completely
clean tcg-op-vec.c. Do it now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230605175647.88395-3-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 35d67eeda0..64bc8a2156 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -24,17 +24,6 @@
 #include "tcg/tcg-mo.h"
 #include "tcg-internal.h"
 
-
-/* Reduce the number of ifdefs below.  This assumes that all uses of
-   TCGV_HIGH and TCGV_LOW are properly protected by a conditional that
-   the compiler can eliminate.  */
-#if TCG_TARGET_REG_BITS == 64
-extern TCGv_i32 TCGV_LOW_link_error(TCGv_i64);
-extern TCGv_i32 TCGV_HIGH_link_error(TCGv_i64);
-#define TCGV_LOW  TCGV_LOW_link_error
-#define TCGV_HIGH TCGV_HIGH_link_error
-#endif
-
 /*
  * Vector optional opcode tracking.
  * Except for the basic logical operations (and, or, xor), and
-- 
2.34.1


