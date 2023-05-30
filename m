Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4F716D1C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:05:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Zs-0000pl-6O; Tue, 30 May 2023 15:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ZY-0000mm-9D
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:59:56 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ZW-0000sb-Hk
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:59:56 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64fd7723836so2037670b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473193; x=1688065193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TO6p4PSEQ7x4gG5VCvqOcrj7NhLU97TFrPxxkMMo4M=;
 b=kQa0NMiTCAiwjBbcCudy/nmpdGmWZibM5CmMso71h9S8Xx22CSo1BoBN0Gzk6ALJJ5
 PCqHZI8xTWxtiYwn3CQsxEiqs/VvqloGHlAwN1VbIgHE0g1hmZlv174APFR4PYOau05H
 GVb7TozBBtfTT18OquTYat1Kb11DL8+FAbYyr/yrThIQErH0UcZEQwmgz7vc7modXDpg
 7XKxtc/BkWNrfpF3eS84CnbXBB7ISPJQDzi5NJFOHVQOvLZbU51+GMVEcSJkBSy3/QGT
 e51ZyK21o+5XVj5MLKCbkALgd1WQZ4HyUStKxyRMxcEVr1eXn9d0bfq+e4Y1UajHoOW1
 JhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473193; x=1688065193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TO6p4PSEQ7x4gG5VCvqOcrj7NhLU97TFrPxxkMMo4M=;
 b=ZWPv2+mJFb8EIvmqyNbbw14Xbqch72vXeGyF/AK/+Nz2fBWwJ62tKpdSZUhXEjmDTk
 GYGZrsTXuPgFIFyrE3Ae/VPMc91YM4+4gK61xBDcb08k0+LAdHDCIrEA40O8NXguaP/8
 hN3oIjzRrdczmsyD26TpbO1bVz+6f3Db2BXP2TiEN83TiGVH0Ie82plYqfY+gwHNhPER
 DfFOTRAs1Wf5ckQeWtuL7P6u+sdxt7ACf0oYnSJ3zPnioAmLAJ2Kmi62AnavgsCx6UgS
 TeK03qoUUpTDtLY6HNt/TLlbqY5PU3g8Pe21DYR7ZzqrQtKD5x7yvP4jgDFbLSVzJQ7P
 g93Q==
X-Gm-Message-State: AC+VfDwTJfAG2UvRLzg5r66zTahTjp98IGLVHHsGGsYGye7BEp1Wl2g9
 aE1etZnYe0av9zvJS6F+WUUk08W1XU2IVqbHXMc=
X-Google-Smtp-Source: ACHHUZ41wHIN7uJCKddirgKyIij4OqIfuPOWhsccGVJ9UZmW/jGf2rpL3JeMtO9yZePtmAQ0wFHiMQ==
X-Received: by 2002:a05:6a20:9c8f:b0:110:9210:f6af with SMTP id
 mj15-20020a056a209c8f00b001109210f6afmr3302349pzb.27.1685473193325; 
 Tue, 30 May 2023 11:59:53 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.11.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 11:59:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/27] meson: Split test for __int128_t type from __int128_t
 arithmetic
Date: Tue, 30 May 2023 11:59:25 -0700
Message-Id: <20230530185949.410208-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Older versions of clang have missing runtime functions for arithmetic
with -fsanitize=undefined (see 464e3671f9d5c), so we cannot use
__int128_t for implementing Int128.  But __int128_t is present,
data movement works, and it can be used for atomic128.

Probe for both CONFIG_INT128_TYPE and CONFIG_INT128, adjust
qemu/int128.h to define Int128Alias if CONFIG_INT128_TYPE,
and adjust the meson probe for atomics to use has_int128_type.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build           | 15 ++++++++++-----
 include/qemu/int128.h |  4 ++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 2d48aa1e2e..bc76ea96bf 100644
--- a/meson.build
+++ b/meson.build
@@ -2543,7 +2543,13 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
     return 0;
   }'''))
 
-has_int128 = cc.links('''
+has_int128_type = cc.compiles('''
+  __int128_t a;
+  __uint128_t b;
+  int main(void) { b = a; }''')
+config_host_data.set('CONFIG_INT128_TYPE', has_int128_type)
+
+has_int128 = has_int128_type and cc.links('''
   __int128_t a;
   __uint128_t b;
   int main (void) {
@@ -2552,10 +2558,9 @@ has_int128 = cc.links('''
     a = a * a;
     return 0;
   }''')
-
 config_host_data.set('CONFIG_INT128', has_int128)
 
-if has_int128
+if has_int128_type
   # "do we have 128-bit atomics which are handled inline and specifically not
   # via libatomic". The reason we can't use libatomic is documented in the
   # comment starting "GCC is a house divided" in include/qemu/atomic128.h.
@@ -2564,7 +2569,7 @@ if has_int128
   # __alignof(unsigned __int128) for the host.
   atomic_test_128 = '''
     int main(int ac, char **av) {
-      unsigned __int128 *p = __builtin_assume_aligned(av[ac - 1], 16);
+      __uint128_t *p = __builtin_assume_aligned(av[ac - 1], 16);
       p[1] = __atomic_load_n(&p[0], __ATOMIC_RELAXED);
       __atomic_store_n(&p[2], p[3], __ATOMIC_RELAXED);
       __atomic_compare_exchange_n(&p[4], &p[5], p[6], 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
@@ -2586,7 +2591,7 @@ if has_int128
       config_host_data.set('CONFIG_CMPXCHG128', cc.links('''
         int main(void)
         {
-          unsigned __int128 x = 0, y = 0;
+          __uint128_t x = 0, y = 0;
           __sync_val_compare_and_swap_16(&x, y, x);
           return 0;
         }
diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 9e46cfaefc..73624e8be7 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -481,7 +481,7 @@ static inline void bswap128s(Int128 *s)
  * a possible structure and the native types.  Ease parameter passing
  * via use of the transparent union extension.
  */
-#ifdef CONFIG_INT128
+#ifdef CONFIG_INT128_TYPE
 typedef union {
     __uint128_t u;
     __int128_t i;
@@ -489,6 +489,6 @@ typedef union {
 } Int128Alias __attribute__((transparent_union));
 #else
 typedef Int128 Int128Alias;
-#endif /* CONFIG_INT128 */
+#endif /* CONFIG_INT128_TYPE */
 
 #endif /* INT128_H */
-- 
2.34.1


