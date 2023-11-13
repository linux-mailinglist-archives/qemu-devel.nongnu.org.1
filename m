Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612017E9AB3
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:08:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UnI-0006My-BE; Mon, 13 Nov 2023 06:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnF-0006MZ-FN
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:07:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnD-0001GV-PO
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699873667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrlkbNxpTd5sqKbA6uWnqNUY09ZerYnFW8lZrOKEF7w=;
 b=RqiYHtIe64HK72i7ZxC64WYkGGoBRYfbEb5zCMLwDG8VhjtZpt38c6gTHpJW2clDDEprFr
 +dNu9nCoFWuPX/lONhrTdz4zZC9LanGFHv2lx5lbYN5D1hU0DJSznmlDSY9Tbv4ZHwS666
 kCRPa6RurPTELjGye3m0mDvmS16pqqk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-b6tkycCLNz6dj86ZQTEfUw-1; Mon,
 13 Nov 2023 06:07:44 -0500
X-MC-Unique: b6tkycCLNz6dj86ZQTEfUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B306229AA383;
 Mon, 13 Nov 2023 11:07:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 871052166B26;
 Mon, 13 Nov 2023 11:07:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/12] host/include/generic/host/atomic128: Fix compilation
 problem with Clang 17
Date: Mon, 13 Nov 2023 12:07:29 +0100
Message-ID: <20231113110740.38270-2-thuth@redhat.com>
In-Reply-To: <20231113110740.38270-1-thuth@redhat.com>
References: <20231113110740.38270-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Message-ID: <20231108085954.313071-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 host/include/generic/host/atomic128-cas.h  | 2 +-
 host/include/generic/host/atomic128-ldst.h | 2 +-
 include/qemu/int128.h                      | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

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
index 73624e8be7..174bd7dafb 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -10,6 +10,7 @@
  */
 #if defined(CONFIG_INT128) && !defined(CONFIG_TCG_INTERPRETER)
 typedef __int128_t Int128;
+typedef __int128_t __attribute__((aligned(16))) Int128Aligned;
 
 static inline Int128 int128_make64(uint64_t a)
 {
@@ -224,6 +225,7 @@ static inline Int128 int128_rems(Int128 a, Int128 b)
 #else /* !CONFIG_INT128 */
 
 typedef struct Int128 Int128;
+typedef struct Int128 __attribute__((aligned(16))) Int128Aligned;
 
 /*
  * We guarantee that the in-memory byte representation of an
-- 
2.41.0


