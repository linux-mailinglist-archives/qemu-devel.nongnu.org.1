Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF63C73EAEE
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:09:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrU2-0002o5-KH; Mon, 26 Jun 2023 15:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrTJ-0000sK-Sr; Mon, 26 Jun 2023 15:01:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrTH-0007sI-SJ; Mon, 26 Jun 2023 15:01:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C191EFC5;
 Mon, 26 Jun 2023 21:59:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 08FA9F800;
 Mon, 26 Jun 2023 21:59:13 +0300 (MSK)
Received: (nullmailer pid 1575382 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Bertalan <dani@danielbertalan.dev>,
 "Tested-By : Solra Bizna" <solra@bizna.name>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 35/43] host-utils: Avoid using __builtin_subcll on
 buggy versions of Apple Clang
Date: Mon, 26 Jun 2023 21:58:53 +0300
Message-Id: <20230626185902.1575177-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

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
(cherry picked from commit b0438861efe1dfbdfdd9fa1d9aa05100d37ea8ee)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index f20a76e4a2..c7ffcaba43 100644
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
index 88d476161c..b3434ec0bc 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -596,7 +596,7 @@ static inline uint64_t uadd64_carry(uint64_t x, uint64_t y, bool *pcarry)
  */
 static inline uint64_t usub64_borrow(uint64_t x, uint64_t y, bool *pborrow)
 {
-#if __has_builtin(__builtin_subcll)
+#if __has_builtin(__builtin_subcll) && !defined(BUILTIN_SUBCLL_BROKEN)
     unsigned long long b = *pborrow;
     x = __builtin_subcll(x, y, b, &b);
     *pborrow = b & 1;
-- 
2.39.2


