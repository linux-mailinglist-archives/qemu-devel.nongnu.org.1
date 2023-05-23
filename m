Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F004E70DE01
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:53:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMt-00019b-CG; Tue, 23 May 2023 09:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMq-00010Q-Bx
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:48:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMn-00016c-RI
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:48:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d5b4c3ffeso2141962b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849677; x=1687441677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WXDf+ZM8xKRR3ok9Sko5lUMigoP5WIzPelyBaHT6/A=;
 b=LHzBkzOPg1fzTGbJrq0pBhfshleqDI0+hu8H7iD9HEW+ugZuYghdycyGcJQjySw1jK
 2zA8HTOdLgfHB9JKYMCXrdzWlGNW3wT4PKLawoMFFmRXuRExFMcS6jwm2H3qwQCJfTqm
 thELLd3qTDWHwkcGAGZ8SSHtRPqD4RxwILVrrYppBAKMeBvZfkJCsQGIyRXzr3TH22Lz
 8dh0/J4BJw27MVs/Ghj4Xo85E580kBg5HIqqIfsOEd7q+NgdTgZmbSsIFOjEfMC2AbK7
 QweU1tILIy3CnluGMoFti2zdWgxwosEys0DQTrgq+YNsqmd0x8MVCaPQzNbIbjMXt3z0
 OeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849677; x=1687441677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WXDf+ZM8xKRR3ok9Sko5lUMigoP5WIzPelyBaHT6/A=;
 b=MiN47GiT+3cM9yy95J8zrUyhDZqoMLrhpshRFou/vuVF97GykF8kQJjLYdqZ02/Qew
 SkWxO6/yHAKUiFoYjzx8SZskUAXpZ0PIJzNnuFDbI2QMnM/fodAtNb7fdiM/FChQc6rO
 JQkapiIulpZP4wsq4wROkWphPDG8uAeupO9KilflqEpMs9HUoW1YHQSt7DJeqeMZZev5
 rhhq4gNXpEgoZrgDJaCznUbvW9IEnTL/L7dHdFiIAA1gTYmNron3/T1Fa5jMHFfRckTk
 jkvWtZSTLnlgY7OZSTsEWjCt+s1rnIPeWVP5n6n39eRtDT+CjxGXZWB8+ZZFlWkkqnTZ
 2k+A==
X-Gm-Message-State: AC+VfDx5c4gKuKabP04OLp28RffN2m0DOTbYtzfSrKi29XzaqTrshQ1w
 2WS5snjfGMs8x5cjXl2wCSwJUB80cQKW1NmLhXc=
X-Google-Smtp-Source: ACHHUZ4n3ManZQI0l+8WjzkACCofTc/ogMnSejT5j7isWOPWY6fAC+4TX+hjibicDYbU/vGNp25+bg==
X-Received: by 2002:a05:6a00:804:b0:64c:c841:4e8a with SMTP id
 m4-20020a056a00080400b0064cc8414e8amr19532639pfk.22.1684849676811; 
 Tue, 23 May 2023 06:47:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 25/27] qemu/atomic128: Improve cmpxchg fallback for
 atomic16_set
Date: Tue, 23 May 2023 06:47:31 -0700
Message-Id: <20230523134733.678646-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Use __sync_bool_compare_and_swap_16 to control the loop,
rather than a separate comparison.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/atomic128-ldst.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h
index 79d208b7a4..80fff0643a 100644
--- a/host/include/generic/host/atomic128-ldst.h
+++ b/host/include/generic/host/atomic128-ldst.h
@@ -58,11 +58,14 @@ atomic16_read_rw(Int128 *ptr)
 static inline void ATTRIBUTE_ATOMIC128_OPT
 atomic16_set(Int128 *ptr, Int128 val)
 {
-    Int128 old = *ptr, cmp;
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    __int128_t old;
+    Int128Alias new;
+
+    new.s = val;
     do {
-        cmp = old;
-        old = atomic16_cmpxchg(ptr, cmp, val);
-    } while (int128_ne(old, cmp));
+        old = *ptr_align;
+    } while (!__sync_bool_compare_and_swap_16(ptr_align, old, new.i));
 }
 
 #else
-- 
2.34.1


