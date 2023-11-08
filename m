Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E757E524C
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:01:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0eQi-00072p-7A; Wed, 08 Nov 2023 04:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0eQg-00072Y-Pf
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0eQe-0001MY-2y
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699434050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dTsho8FGtRvStR/bWeiKDoJOyarK7P+vm5zQGOP1y84=;
 b=O6mAIDDu0evE7thRiE2WtBzDM9t+9pOsRtRceXuSOvPf/ixJZeRSPpgZnVWliqe668sudi
 KLr1W9WMQa2n+UQ6Fi0mPdkYnItnxBtle/cE8yEKunQCVbo3mmS8ofCGUp3jcR4qDTsUgs
 n7tRf+zfYU+FGM32A5fI32fr1iDFNIQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-g-M0IV7kNCGFQwa5SZKjhQ-1; Wed,
 08 Nov 2023 03:59:56 -0500
X-MC-Unique: g-M0IV7kNCGFQwa5SZKjhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17E0F280666A;
 Wed,  8 Nov 2023 08:59:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D2C725C1;
 Wed,  8 Nov 2023 08:59:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org
Subject: [PATCH] host/include/generic/host/atomic128: Fix compilation problem
 with Clang 17
Date: Wed,  8 Nov 2023 09:59:54 +0100
Message-ID: <20231108085954.313071-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When compiling QEMU with Clang 17 on a s390x, the compilation fails:

In file included from ../accel/tcg/cputlb.c:32:
In file included from /root/qemu/include/exec/helper-proto-common.h:10:
In file included from /root/qemu/include/qemu/atomic128.h:62:
/root/qemu/host/include/generic/host/atomic128-ldst.h:68:15: error:
 __sync builtin operation MUST have natural alignment (consider using __
atomic). [-Werror,-Wsync-alignment]
   68 |     } while (!__sync_bool_compare_and_swap_16(ptr_align, old, new.i));
      |               ^
In file included from ../accel/tcg/cputlb.c:32:
In file included from /root/qemu/include/exec/helper-proto-common.h:10:
In file included from /root/qemu/include/qemu/atomic128.h:61:
/root/qemu/host/include/generic/host/atomic128-cas.h:36:11: error:
 __sync builtin operation MUST have natural alignment (consider using __a
tomic). [-Werror,-Wsync-alignment]
   36 |     r.i = __sync_val_compare_and_swap_16(ptr_align, c.i, n.i);
      |           ^
2 errors generated.

It's arguably a bug in Clang since we already use __builtin_assume_aligned()
to tell the compiler that the pointer is properly aligned. But according to
https://github.com/llvm/llvm-project/issues/69146 it seems like the Clang
folks don't see an easy fix on their side and recommend to use a type
declared with __attribute__((aligned(16))) to work around this problem.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1934
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 host/include/generic/host/atomic128-cas.h  | 2 +-
 host/include/generic/host/atomic128-ldst.h | 2 +-
 include/qemu/int128.h                      | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/host/include/generic/host/atomic128-cas.h b/host/include/generic/host/atomic128-cas.h
index 991d3da082..6b40cc2271 100644
--- a/host/include/generic/host/atomic128-cas.h
+++ b/host/include/generic/host/atomic128-cas.h
@@ -28,7 +28,7 @@ atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
 static inline Int128 ATTRIBUTE_ATOMIC128_OPT
 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
 {
-    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128Aligned *ptr_align = __builtin_assume_aligned(ptr, 16);
     Int128Alias r, c, n;
 
     c.s = cmp;
diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h
index 80fff0643a..691e6a8531 100644
--- a/host/include/generic/host/atomic128-ldst.h
+++ b/host/include/generic/host/atomic128-ldst.h
@@ -58,7 +58,7 @@ atomic16_read_rw(Int128 *ptr)
 static inline void ATTRIBUTE_ATOMIC128_OPT
 atomic16_set(Int128 *ptr, Int128 val)
 {
-    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128Aligned *ptr_align = __builtin_assume_aligned(ptr, 16);
     __int128_t old;
     Int128Alias new;
 
diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 73624e8be7..44530d3e10 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -10,6 +10,7 @@
  */
 #if defined(CONFIG_INT128) && !defined(CONFIG_TCG_INTERPRETER)
 typedef __int128_t Int128;
+typedef __int128_t __attribute__((aligned(16))) Int128Aligned;
 
 static inline Int128 int128_make64(uint64_t a)
 {
-- 
2.41.0


