Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1378C78D736
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:44:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNMD-0004FW-6O; Wed, 30 Aug 2023 11:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qbNMB-0004FC-Jf
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:43:47 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qbNLx-00049U-PA
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:43:37 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34cb5c41777so17844765ab.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1693410205; x=1694015005;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8dJ9TkQAZUpgc686GsI19q/GGiHeugYLNIbj9BWx/2w=;
 b=JpDHJ2j8tI7d1T21YJ+4NL4KdH1x3Hpxkhj0/4qgvxmfIxzl9xojRz7We4LQ03JXWg
 XMJtNUkPFMb4A/mOw8MHrZn+N/V5o+w9MPmQbz4PZAm5yOPBaqk0ekINkf6BBlsZcJ23
 OR54pQee70i0qfWMP5hfCABvzUlcHeDQAuDmI+/OA7rQVVC1jGkCbY73Hhv/1h3TLQjz
 ZdXLDSN+UGjRJlmjxCde/mQ9jl2Qr05Lnr4KqS0q85GJmbDKcWv6tK5uPnhgDPiPl6CW
 tbLR5oIQAVNtfHOnQXNMlmRjygSJaL3zeUJg3Cyf/QG2b0fUi2C9QCfmPZNQLOBs2rLd
 JQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693410205; x=1694015005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8dJ9TkQAZUpgc686GsI19q/GGiHeugYLNIbj9BWx/2w=;
 b=PlMFUuMu8zjO0g7ccdqE/2v52qdvhSCPrWzQSPt56HXFfYOmiR7Ciq2Kx1dFPyRggB
 gEyQ4fJKirSFy+ETmuTR+KHmlHzUZ7D8a97b0BV4p52w2pIpOmLfO++hdW8PEgO8jg88
 wzcmmT0kAZwcS5l6g8RlbfsETuVarWgM3OI/C78l26frdjsgl4iObCTucYeqFWsxtHMw
 WbjgKoHSEG55eKaqXpfdtjYwJ+cEopsiuFivm83HL6Wr9Q5VAQ8THKTqX3sajvi1iwqQ
 vTTS9NlpXz46uW/MTKsfStWR5d7zBIcrL+C8LeaN5OhfKsJX9YmNXK4hxOWeYtePDtel
 woUg==
X-Gm-Message-State: AOJu0YwEKv0KP6QKsS8Ie+bw36slj/GE+WJh0+Y9/FEqVuDmgQX20fMH
 8Zqz1przl8frQr7B5a+MoH6WHL62Frkm9tbMokU=
X-Google-Smtp-Source: AGHT+IEWX7a9jRr9tctP8UhTBfG18Uddg5us4JRnKEZ2kJPaN2/EzEL1l0ZP7SgfDSk4CppqzxglWg==
X-Received: by 2002:a05:6e02:ca3:b0:34c:e84b:4c5e with SMTP id
 3-20020a056e020ca300b0034ce84b4c5emr2786790ilg.8.1693410205649; 
 Wed, 30 Aug 2023 08:43:25 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 h14-20020a92c08e000000b00345e3a04f2dsm3899980ile.62.2023.08.30.08.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 08:43:25 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/1] bsd-user: Move PRAGMA_DISABLE_PACKED_WARNING etc to qemu.h
Date: Wed, 30 Aug 2023 09:40:07 -0600
Message-ID: <20230830154007.54297-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830154007.54297-1-imp@bsdimp.com>
References: <20230830154007.54297-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::129;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x129.google.com
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


