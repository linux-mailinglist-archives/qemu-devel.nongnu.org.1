Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 197EE70FDEA
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 20:34:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1tIP-000606-N9; Wed, 24 May 2023 14:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tII-0005t6-9i
 for qemu-devel@nongnu.org; Wed, 24 May 2023 14:33:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tIE-0006wm-A9
 for qemu-devel@nongnu.org; Wed, 24 May 2023 14:33:06 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1afeec98a00so1986585ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684953180; x=1687545180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MLP6U/C3AZrL2k7IblCR47p9592oz4H1EvaAF4qcoY=;
 b=FqU9Oa81cv1pTH1NLwN48s89nSwPXm/k4TL9OO92XWVkmBrrw2icUUzYTAD5JpSB1E
 Vdw1FdGPves9xkDkOEqoRFWxGKk6uj5Ya5szF+hhpFrdBMlgK24fbDKo82h6vipY0ZMg
 UsasVDhptUXDmeqhyTQTmOrKKlpz1dBXaSOvAut4/wpGRdxz6mUK9DBeASYhQVdf2Zvi
 ooATXr/pKg8FcaddDDUJktouk3LVYw70hLxtZ/qjV1Zpk6NZUXz30syqj7wXx3RrqPmG
 xfgj84mqktslukWxVfIPfFMctUfHH+nfHiIs6cMsHi3OyGATSq0QXVmXNvo7OfQPD41Q
 Hzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684953180; x=1687545180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MLP6U/C3AZrL2k7IblCR47p9592oz4H1EvaAF4qcoY=;
 b=MkppbfYagMYDfk+ipNUONDBFt/wNP9Wiqs80L+k+XfAKZbCdGBoFIxzxMQ09e7q1A0
 ScrpZtfGM5RLg6Jr723FqiudsJuc8chn52T11MSZa49L3DCPwxcsaXU3GvMxc1bDS83T
 zggb4Dz86HH8Za2rswMuEF3S/G2GMPd6F2uCclwKNGBJAwlkDaHF5Q2FQObpLygwvYmv
 mlTCeaPwtmPFNnJmUjb23QexZJWCS3iARFUia7pJ1KyFFOzXVBenJd5BK0XbuNwvrMHP
 zG1DwHJCIN2f495wVV91K5lbKfKKK3BvFJTkAuwdOV//vBDTcpv+AjRBe3qaSj20rebE
 SM6A==
X-Gm-Message-State: AC+VfDymjI4Ju5CL6BXS8589cWzo2yhWLvu4Z1RBzuCBkvDiBqkq7/dE
 wVLARNVkbI61lnVGGnv3FzTncDRxrM5di8ZlFvM=
X-Google-Smtp-Source: ACHHUZ5f+uZ/YtBg/toy4pIHgCindjaRW/xCpiU2mWuFaVwYrfKwOV584WLwSb40jC1wK3vVswMvbg==
X-Received: by 2002:a17:903:22c2:b0:1ac:aba5:7885 with SMTP id
 y2-20020a17090322c200b001acaba57885mr22564217plg.47.1684953180463; 
 Wed, 24 May 2023 11:33:00 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 2-20020a170902c20200b001ac2be26340sm9042008pll.222.2023.05.24.11.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 11:33:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v3 1/2] meson: Split test for __int128_t type from __int128_t
 arithmetic
Date: Wed, 24 May 2023 11:32:57 -0700
Message-Id: <20230524183258.1194571-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524183258.1194571-1-richard.henderson@linaro.org>
References: <20230524183258.1194571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
data movement works, and can be use for atomic128.

Probe for both CONFIG_INT128_TYPE and CONFIG_INT128, adjust
qemu/int128.h to define Int128Alias if CONFIG_INT128_TYPE,
and adjust the meson probe for atomics to use has_int128_type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build           | 15 ++++++++++-----
 include/qemu/int128.h |  4 ++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index ef181ff2df..1f73c68a41 100644
--- a/meson.build
+++ b/meson.build
@@ -2536,7 +2536,13 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
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
@@ -2545,10 +2551,9 @@ has_int128 = cc.links('''
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
@@ -2557,7 +2562,7 @@ if has_int128
   # __alignof(unsigned __int128) for the host.
   atomic_test_128 = '''
     int main(int ac, char **av) {
-      unsigned __int128 *p = __builtin_assume_aligned(av[ac - 1], 16);
+      __uint128_t *p = __builtin_assume_aligned(av[ac - 1], 16);
       p[1] = __atomic_load_n(&p[0], __ATOMIC_RELAXED);
       __atomic_store_n(&p[2], p[3], __ATOMIC_RELAXED);
       __atomic_compare_exchange_n(&p[4], &p[5], p[6], 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
@@ -2579,7 +2584,7 @@ if has_int128
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


