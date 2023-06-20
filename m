Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A0F736629
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWh2-0003nz-Si; Tue, 20 Jun 2023 04:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgs-0003mo-Rg
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:18 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgq-00064w-U0
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:18 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-98746d7f35dso549307366b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249575; x=1689841575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YqWB26je/oP5QNBDvOv6fwKdPeWhBHe3OHaZa6DMUQ=;
 b=kf3IGipGGaBz4lNCFSJ86mDi174g3jXk9WkI2ouWugEu8fB+wEbxLGnVTjiuMe0ouB
 uI6ukkvUeUjOhkc53NLxgi59xnf6tTpi+KR8WMYySkdpLwx9dpPV6cEkkwK7C7S9kTt+
 a1hq6o4wSNtAz4jIpdV4BVJgGdzpF1KmmihHYgnSthOCfBD87/qYKk6DjY8ytmRzUdir
 QIafAp7BS/Ah5dJ0W37GKiH/hWKEUl82PuylVtfFazK/87ZaxmB6ph4ik+jPu8AeZsH0
 qEl6+qZzmivBzE47JTq5qowYvKZBWqtUj1O57V9a0v+NkMXoiq88WsEJFOdP4o0Yt2t5
 FXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249575; x=1689841575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6YqWB26je/oP5QNBDvOv6fwKdPeWhBHe3OHaZa6DMUQ=;
 b=jzpPYwnkJ9he3xlWvWdOYhcHjEUYJKVIiZNXqpFvHqmiupcSdPbIZFxZT8pyiN7KMS
 IoD1ScGnVNkW4ywEfgeKOppWG131QAX1uHQNUtumot7tDylNdrGkloAu0NwQrn1Z9kVv
 +JqZdatHiBdIgrn4x/K5Nj8hE9u35SncSg4Zz+y0PPTKCu+toVdwAQHhXTvyQj3iZQ39
 XPWeFnSgDOagt6Zd5l6ITUKqZf7TA6ySbxXzxwHqjrIQ2qRzEPFDQa8vMj3EwiIHarES
 /mKzkQY52z2ektlQTmSItbpv3mjbCtbeLVJ6AOoMCJ1U/gEKivdif7R71CzD3jGOuHb8
 MfkQ==
X-Gm-Message-State: AC+VfDwcujV4FmSOFz8BDVvLObeOJlxGG+ftcg1wHiqljWq07yqeuuyd
 POLMJ6NXumKNRe5goFdiVtyRJyA8rFSL88t0ye6SYS0Q
X-Google-Smtp-Source: ACHHUZ7LfV48BIi4oM1gckaLUn14NjYOdPySVr6oiPAC+MhTy+pRHo3LYUtlOX/Dr8dxXaGjmb6fcA==
X-Received: by 2002:a17:907:da2:b0:988:e8e1:6367 with SMTP id
 go34-20020a1709070da200b00988e8e16367mr2959296ejc.54.1687249574822; 
 Tue, 20 Jun 2023 01:26:14 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/16] host/include/x86_64: Use __m128i for "x" constraints
Date: Tue, 20 Jun 2023 10:25:56 +0200
Message-Id: <20230620082611.770620-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
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

The macOS catalina compiler produces an error for __int128_t
as the type for allocation with SSE inline asm constraint.
Create a new X86Int128Union type and use the vector type for
all SSE register inputs and outputs.

Tested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/x86_64/host/atomic128-ldst.h     | 25 ++++++++++++-------
 .../x86_64/host/load-extract-al16-al8.h       |  8 +++---
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/host/include/x86_64/host/atomic128-ldst.h b/host/include/x86_64/host/atomic128-ldst.h
index adc9332f91..8d6f909d3c 100644
--- a/host/include/x86_64/host/atomic128-ldst.h
+++ b/host/include/x86_64/host/atomic128-ldst.h
@@ -8,12 +8,19 @@
  * atomic primitive is meant to provide.
  */
 
-#ifndef AARCH64_ATOMIC128_LDST_H
-#define AARCH64_ATOMIC128_LDST_H
+#ifndef X86_64_ATOMIC128_LDST_H
+#define X86_64_ATOMIC128_LDST_H
 
 #ifdef CONFIG_INT128_TYPE
 #include "host/cpuinfo.h"
 #include "tcg/debug-assert.h"
+#include <immintrin.h>
+
+typedef union {
+    __m128i v;
+    __int128_t i;
+    Int128 s;
+} X86Int128Union;
 
 /*
  * Through clang 16, with -mcx16, __atomic_load_n is incorrectly
@@ -25,10 +32,10 @@
 
 static inline Int128 atomic16_read_ro(const Int128 *ptr)
 {
-    Int128Alias r;
+    X86Int128Union r;
 
     tcg_debug_assert(HAVE_ATOMIC128_RO);
-    asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
+    asm("vmovdqa %1, %0" : "=x" (r.v) : "m" (*ptr));
 
     return r.s;
 }
@@ -36,10 +43,10 @@ static inline Int128 atomic16_read_ro(const Int128 *ptr)
 static inline Int128 atomic16_read_rw(Int128 *ptr)
 {
     __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
-    Int128Alias r;
+    X86Int128Union r;
 
     if (HAVE_ATOMIC128_RO) {
-        asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
+        asm("vmovdqa %1, %0" : "=x" (r.v) : "m" (*ptr_align));
     } else {
         r.i = __sync_val_compare_and_swap_16(ptr_align, 0, 0);
     }
@@ -49,10 +56,10 @@ static inline Int128 atomic16_read_rw(Int128 *ptr)
 static inline void atomic16_set(Int128 *ptr, Int128 val)
 {
     __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
-    Int128Alias new = { .s = val };
+    X86Int128Union new = { .s = val };
 
     if (HAVE_ATOMIC128_RO) {
-        asm("vmovdqa %1, %0" : "=m"(*ptr_align) : "x" (new.i));
+        asm("vmovdqa %1, %0" : "=m"(*ptr_align) : "x" (new.v));
     } else {
         __int128_t old;
         do {
@@ -65,4 +72,4 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
 #include "host/include/generic/host/atomic128-ldst.h"
 #endif
 
-#endif /* AARCH64_ATOMIC128_LDST_H */
+#endif /* X86_64_ATOMIC128_LDST_H */
diff --git a/host/include/x86_64/host/load-extract-al16-al8.h b/host/include/x86_64/host/load-extract-al16-al8.h
index 31b6fe8c45..baa506b7b5 100644
--- a/host/include/x86_64/host/load-extract-al16-al8.h
+++ b/host/include/x86_64/host/load-extract-al16-al8.h
@@ -9,7 +9,7 @@
 #define X86_64_LOAD_EXTRACT_AL16_AL8_H
 
 #ifdef CONFIG_INT128_TYPE
-#include "host/cpuinfo.h"
+#include "host/atomic128-ldst.h"
 
 /**
  * load_atom_extract_al16_or_al8:
@@ -26,7 +26,7 @@ load_atom_extract_al16_or_al8(void *pv, int s)
     uintptr_t pi = (uintptr_t)pv;
     __int128_t *ptr_align = (__int128_t *)(pi & ~7);
     int shr = (pi & 7) * 8;
-    Int128Alias r;
+    X86Int128Union r;
 
     /*
      * ptr_align % 16 is now only 0 or 8.
@@ -35,9 +35,9 @@ load_atom_extract_al16_or_al8(void *pv, int s)
      * when ptr_align % 16 == 0 for 16-byte atomicity.
      */
     if ((cpuinfo & CPUINFO_ATOMIC_VMOVDQU) || (pi & 8)) {
-        asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
+        asm("vmovdqu %1, %0" : "=x" (r.v) : "m" (*ptr_align));
     } else {
-        asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
+        asm("vmovdqa %1, %0" : "=x" (r.v) : "m" (*ptr_align));
     }
     return int128_getlo(int128_urshift(r.s, shr));
 }
-- 
2.34.1


