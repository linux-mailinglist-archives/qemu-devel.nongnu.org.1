Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542373B782
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:37:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxV-0003Ij-7q; Fri, 23 Jun 2023 08:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfxA-0001r8-Fi
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx7-0000ia-UW
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f90b4ac529so7681045e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523507; x=1690115507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=04sNTMPFwuJuDTHJisvdzy72J4iNRUKOEJ9l019SLBo=;
 b=ZGS5GTtLBagFmQ+r9FUBGxPokswGJJ/chPNqQ9m5FkAXzfWr09WausGP6SwqAaSuS4
 ag2qq5kb7IMns6aAqbE3MTu8uD4VV4k+sSjauViGO3GbGWjLAu14v0dtVoCHgp5xMegq
 nMP0fq01fRLRVtZVH7vJV/0goxbIXmC4DdzUwBwLiy9JcqpYxK0Y2/qtxv1IhrGuxUqp
 yxMY2RODPTj9miCjYCU0+vUv7JI/bzPFXQth6UxwUEDSVzWGcZ2ZvlaJ2LuD0W8rDxFh
 yvbluvO5G77msS9koWQDF8aDlE1wyW+Sud/p7vSnhxGECeklac6eMN/PCiRx9tSfYMC5
 DhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523507; x=1690115507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04sNTMPFwuJuDTHJisvdzy72J4iNRUKOEJ9l019SLBo=;
 b=ZMh85QFURS1qNjTFRQJnoDvPp4ia8WB8uBvsUaMJcHFk4tssnz2HmPhEtiLBcR3tcz
 dwxWs7xEocH/8X2Y7XC6j+p4J1ihQ8W18jp6dXi29cjp5lcNcGdOlHdg5zN4h/z0CUDD
 Wf5b/6NdQbiVKyDNV7LVck6oSd6vpFLtgsoHdS//agS9tMyyS7nHAr2H/sy1cxaiH17W
 SrXudM05blAF7Xnf3fSdIcOW4Serh54q3mPsXlv7eL1Rp5UwAURikeyi1sURE+RSiavr
 h5t/WPk8D+LhnNxMxg47pnxliAc6r1WjbRcM2tAKZEkKnLFK0MdfQF0LyU+cHXKC7AQc
 UAgQ==
X-Gm-Message-State: AC+VfDzCtURnAUXMOtXJ0YNc0dCisAboT8pxpwHxg9Zj5eBdh/2YzqNw
 sItOt1pD9jINuLl7Z76zLtZ2AbG0Gu00ODh+LPk=
X-Google-Smtp-Source: ACHHUZ50soHeu9k3JhVBeJY66AdTyszrRjq0qVC/3hLv0Dyye8r/e6QjKw6tN17OQn3H9+3uVrtapw==
X-Received: by 2002:a7b:c7c9:0:b0:3fa:7d11:ad00 with SMTP id
 z9-20020a7bc7c9000000b003fa7d11ad00mr1170879wmk.25.1687523507582; 
 Fri, 23 Jun 2023 05:31:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/26] host-utils: Avoid using __builtin_subcll on buggy
 versions of Apple Clang
Date: Fri, 23 Jun 2023 13:31:31 +0100
Message-Id: <20230623123135.1788191-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

We use __builtin_subcll() to do a 64-bit subtract with borrow-in and
borrow-out when the host compiler supports it.  Unfortunately some
versions of Apple Clang have a bug in their implementation of this
intrinsic which means it returns the wrong value.  The effect is that
a QEMU built with the affected compiler will hang when emulating x86
or m68k float80 division.

The upstream LLVM issue is:
https://github.com/llvm/llvm-project/issues/55253

The commit that introduced the bug apparently never made it into an
upstream LLVM release without the subsequent fix
https://github.com/llvm/llvm-project/commit/fffb6e6afdbaba563189c1f715058ed401fbc88d
but unfortunately it did make it into Apple Clang 14.0, as shipped
in Xcode 14.3 (14.2 is reported to be OK). The Apple bug number is
FB12210478.

Add ifdefs to avoid use of __builtin_subcll() on Apple Clang version
14 or greater.  There is not currently a version of Apple Clang which
has the bug fix -- when one appears we should be able to add an upper
bound to the ifdef condition so we can start using the builtin again.
We make the lower bound a conservative "any Apple clang with major
version 14 or greater" because the consequences of incorrectly
disabling the builtin when it would work are pretty small and the
consequences of not disabling it when we should are pretty bad.

Many thanks to those users who both reported this bug and also
did a lot of work in identifying the root cause; in particular
to Daniel Bertalan and osy.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1631
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1659
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Daniel Bertalan <dani@danielbertalan.dev>
Tested-by: Tested-By: Solra Bizna <solra@bizna.name>
Message-id: 20230622130823.1631719-1-peter.maydell@linaro.org
---
 include/qemu/compiler.h   | 13 +++++++++++++
 include/qemu/host-utils.h |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c2f49df1f91..a309f90c768 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -184,4 +184,17 @@
 #define QEMU_DISABLE_CFI
 #endif
 
+/*
+ * Apple clang version 14 has a bug in its __builtin_subcll(); define
+ * BUILTIN_SUBCLL_BROKEN for the offending versions so we can avoid it.
+ * When a version of Apple clang which has this bug fixed is released
+ * we can add an upper bound to this check.
+ * See https://gitlab.com/qemu-project/qemu/-/issues/1631
+ * and https://gitlab.com/qemu-project/qemu/-/issues/1659 for details.
+ * The bug never made it into any upstream LLVM releases, only Apple ones.
+ */
+#if defined(__apple_build_version__) && __clang_major__ >= 14
+#define BUILTIN_SUBCLL_BROKEN
+#endif
+
 #endif /* COMPILER_H */
diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index d3b4dce6a93..011618373e5 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -649,7 +649,7 @@ static inline uint64_t uadd64_carry(uint64_t x, uint64_t y, bool *pcarry)
  */
 static inline uint64_t usub64_borrow(uint64_t x, uint64_t y, bool *pborrow)
 {
-#if __has_builtin(__builtin_subcll)
+#if __has_builtin(__builtin_subcll) && !defined(BUILTIN_SUBCLL_BROKEN)
     unsigned long long b = *pborrow;
     x = __builtin_subcll(x, y, b, &b);
     *pborrow = b & 1;
-- 
2.34.1


