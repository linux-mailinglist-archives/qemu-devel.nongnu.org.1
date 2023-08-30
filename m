Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A45A378D6A7
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:51:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMXF-00089h-7n; Wed, 30 Aug 2023 10:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qbMXC-00089U-Rc
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:51:06 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qbMX9-00008g-0q
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:51:05 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7951f0e02ecso22867439f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1693407061; x=1694011861;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ntj3mUoC94qWUYkkh5x/XtSzHVTmxFdCwJPtYzRoLVg=;
 b=MVu8rc/t+N0rXoS10xr3+8EWekiO0ZUw0rB2ptiqevMNfK7IVZFoOQXMygRUpEVkVr
 a0h7mLw42wsaezmxUY8XdsGjSaFd6XcPPeQJCh9pt9YsGfjwUT7iCHOn/+mUFnNoaQU0
 m5S/HTfc/5bnSLlLhn83Ka8Amhno+6o2RElGyFxwyBP12NPE+LHjqQcVxMbZ3Q/RnoeQ
 mOLc2s5v3UF12JCjkjk8LfD1JytCV05dNMBIbiCLY3Iqc89MjiI+lRrfqwNz7Zdy9+hN
 NKTVjHBp5DTVaDZg9c4Mq10sZ3imKSFztr+DszWJAGWFrW5agUbb9S4lE0HUmS+py6R8
 K0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407061; x=1694011861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ntj3mUoC94qWUYkkh5x/XtSzHVTmxFdCwJPtYzRoLVg=;
 b=W0ZwjdCm5N+7zzqqa+FZpxuC+F+SI0iEQ0UBNocxAX4igBYi6Ndqwl7fi5hMvA6yRz
 Wa1BV7ni+gbWhv2zJ0PUUwO7jp2aZUoSNXSHLOBiCH8tUk0yJmdBwkwDRIxoUkS5OyUh
 qpQ1gCbvbZbtyt9+Dyi+vbXDo7pFnXm+nUWyQeheLbgPRoh+L9v1+7Y4mUtsDg5MCpw9
 vrkQ0rZ0EJYBJpmsE7vh+pmtASXAGEVIre0mNRnXEGnMQ+IWl7GEEq2tF77oUVazI3Ku
 QQcG9qJTpqLEDNvPtj01AuhUPsygp5NBoaudb0mu9f5eAnGKPsbezfwBk7YZbxR/lNJD
 u19Q==
X-Gm-Message-State: AOJu0YwkONA75pXkds40mXPWGWlFqJClgH080DHq21D9OHdkOUE7MzTz
 8kLO1NCVVqNbDe7F+zZlpFNTjCbTYNNnwXAs9Ws=
X-Google-Smtp-Source: AGHT+IHy294/0Mog+ZxbHyMS2DttFoKvROc6qE14PZASDA71hCC54N3ePydp7SeZg63T0c1NRPBdxQ==
X-Received: by 2002:a92:d28c:0:b0:34a:a4a5:3f93 with SMTP id
 p12-20020a92d28c000000b0034aa4a53f93mr2492010ilp.5.1693407061135; 
 Wed, 30 Aug 2023 07:51:01 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 b8-20020a05663801a800b004290fd3a68dsm3936486jaq.1.2023.08.30.07.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:51:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PATCH v3] bsd-user: Move PRAGMA_DISABLE_PACKED_WARNING etc to qemu.h
Date: Wed, 30 Aug 2023 08:47:43 -0600
Message-ID: <20230830144743.53770-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

For the moment, move PRAGMA_DISABLE_PACKED_WARNING and
PRAGMA_ENABLE_PACKED_WARNING back to bsd-user/qemu.h.

Of course, these should be in compiler.h, but that interferes with too
many things at the moment, so take one step back to unbreak clang
linux-user builds first. Use the exact same version that's in
linux-user/qemu.h since that's what should be in compiler.h.
---
 bsd-user/qemu.h         | 27 +++++++++++++++++++++++++++
 include/qemu/compiler.h | 30 ------------------------------
 2 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 4cfd5c63371..d3158bc2edd 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -273,6 +273,33 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
  * These are usually used to access struct data members once the struct has been
  * locked - usually with lock_user_struct().
  */
+
+/*
+ * Tricky points:
+ * - Use __builtin_choose_expr to avoid type promotion from ?:,
+ * - Invalid sizes result in a compile time error stemming from
+ *   the fact that abort has no parameters.
+ * - It's easier to use the endian-specific unaligned load/store
+ *   functions than host-endian unaligned load/store plus tswapN.
+ * - The pragmas are necessary only to silence a clang false-positive
+ *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
+ * - gcc has bugs in its _Pragma() support in some versions, eg
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
+ *   include the warning-suppression pragmas for clang
+ */
+#if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
+#define PRAGMA_DISABLE_PACKED_WARNING                                   \
+    _Pragma("GCC diagnostic push");                                     \
+    _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
+
+#define PRAGMA_REENABLE_PACKED_WARNING          \
+    _Pragma("GCC diagnostic pop")
+
+#else
+#define PRAGMA_DISABLE_PACKED_WARNING
+#define PRAGMA_REENABLE_PACKED_WARNING
+#endif
+
 #define __put_user_e(x, hptr, e)                                            \
     do {                                                                    \
         PRAGMA_DISABLE_PACKED_WARNING;                                      \
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index b0374425180..a309f90c768 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -22,36 +22,6 @@
 #define QEMU_EXTERN_C extern
 #endif
 
-/*
- * Tricky points:
- * - Use __builtin_choose_expr to avoid type promotion from ?:,
- * - Invalid sizes result in a compile time error stemming from
- *   the fact that abort has no parameters.
- * - It's easier to use the endian-specific unaligned load/store
- *   functions than host-endian unaligned load/store plus tswapN.
- * - The pragmas are necessary only to silence a clang false-positive
- *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
- * - We have to disable -Wpragmas warnings to avoid a complaint about
- *   an unknown warning type from older compilers that don't know about
- *   -Waddress-of-packed-member.
- * - gcc has bugs in its _Pragma() support in some versions, eg
- *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
- *   include the warning-suppression pragmas for clang
- */
-#ifdef __clang__
-#define PRAGMA_DISABLE_PACKED_WARNING                                   \
-    _Pragma("GCC diagnostic push");                                     \
-    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
-    _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
-
-#define PRAGMA_REENABLE_PACKED_WARNING          \
-    _Pragma("GCC diagnostic pop")
-
-#else
-#define PRAGMA_DISABLE_PACKED_WARNING
-#define PRAGMA_REENABLE_PACKED_WARNING
-#endif
-
 #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
 # define QEMU_PACKED __attribute__((gcc_struct, packed))
 #else
-- 
2.41.0


