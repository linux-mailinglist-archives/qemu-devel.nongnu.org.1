Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC078D017
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:14:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n4-0000pw-0Z; Tue, 29 Aug 2023 19:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qb3ns-0005vq-Rz
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:51:05 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qb3nq-00038v-Ba
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:51:04 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-76c64da0e46so162785939f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693335061; x=1693939861;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2pf4QDv2HzyUXDLQW7UKeXCFQeNg9feQf48aY9sMzI8=;
 b=QBXVveDuw79+bhuRfsUqeT5/QLAbJsXvgt6lAAVd4faHbUJBuPLOkcWIoo6CKOkA4Z
 uVIxypcriukH8queZ5m7cQvrTmTAn/n24T3uw4Vt2mZ/g2rFEXAFE12dqxovgq8BhSog
 Jp4GYITysr+xSM1d8iU8NtyDaR/F2wx2TPWBDclXfHvRM0qEW9hXpHQGyFRj/L/E96JJ
 UzUnvGgjGfJpmyxso4Th5Yb7gvRy8YrM+Of96BP4oKOJ0rhTdCNKzRZWwZwUlCzhHTB/
 PzRAVL+55U9FlI4K6JDSCpR9mITyNaeIlne9L/o8TvKmXj3o3/H/Z5M/1cRVCqNebl9Z
 FdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693335061; x=1693939861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2pf4QDv2HzyUXDLQW7UKeXCFQeNg9feQf48aY9sMzI8=;
 b=O0fhDeKpg0UohczbojMvn62nhUKe4HxbNJI9mWPbAJTzzCy9hzoFQEQtQc5MUVSSnF
 gR6DIwRIfPc5oLQSyy8dluKGa3bw2hhyuECGOTHeeWTHSpfgIzvXPUDhuKFdIvEJTKCA
 oPtFvdAcvH0O+rfpfY9oS3Baf51ZgO6QzGkGE8e852ZtWkVkEg4x6PsYfDrAq06fFa5C
 pcvzf+MQK5drzAFVv1Whd6+XyyMo+hDysXboA+CcKMGgz3603gKsulI2AtqVL+BOyrYZ
 Pdp4Lju0JOzUb39+JRxlpjztIg5cs2a3GBKChndNVn4jxgdzAp73B+yzqGabI0giQ7fC
 TnVg==
X-Gm-Message-State: AOJu0Yy/3FH29m+kM3d4PPsAhGvjdCCsQf5+HA2LHsusPDNThJQquKkA
 1Q/pBtpmyzIFMPYPaDfzxbZmZNtjAIBPDE6UnRA=
X-Google-Smtp-Source: AGHT+IGZhjDR4FKWi//LNXLbSVxmIGRF6D//JMQh+Td98K2vuyhulzxuYSCNREGGqnGHLUmIBHzZLw==
X-Received: by 2002:a05:6e02:964:b0:34d:f0ff:db49 with SMTP id
 q4-20020a056e02096400b0034df0ffdb49mr190435ilt.9.1693335060813; 
 Tue, 29 Aug 2023 11:51:00 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 el23-20020a0566384d9700b0042b91ec7e31sm3345000jab.3.2023.08.29.11.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 11:51:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2] linux-user: Move PRAGMA_DISABLE_PACKED_WARNING to
 compiler.h
Date: Tue, 29 Aug 2023 12:47:43 -0600
Message-ID: <20230829184743.54557-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d36;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd36.google.com
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

Replace the slightly older version of this in include/qemu/compiler.h
that was commit as part of bsd-user changes with the newer one from
linux-user. bsd-user has no regreassions with this.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 include/qemu/compiler.h  |  6 +-----
 linux-user/qemu.h        | 26 --------------------------
 tests/lcitool/libvirt-ci |  2 +-
 3 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index b0374425180..0df9febbe2f 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -31,17 +31,13 @@
  *   functions than host-endian unaligned load/store plus tswapN.
  * - The pragmas are necessary only to silence a clang false-positive
  *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
- * - We have to disable -Wpragmas warnings to avoid a complaint about
- *   an unknown warning type from older compilers that don't know about
- *   -Waddress-of-packed-member.
  * - gcc has bugs in its _Pragma() support in some versions, eg
  *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
  *   include the warning-suppression pragmas for clang
  */
-#ifdef __clang__
+#if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
 #define PRAGMA_DISABLE_PACKED_WARNING                                   \
     _Pragma("GCC diagnostic push");                                     \
-    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
     _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
 
 #define PRAGMA_REENABLE_PACKED_WARNING          \
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4f8b55e2fb0..12821e54d0a 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -193,32 +193,6 @@ static inline bool access_ok(CPUState *cpu, int type,
    These are usually used to access struct data members once the struct has
    been locked - usually with lock_user_struct.  */
 
-/*
- * Tricky points:
- * - Use __builtin_choose_expr to avoid type promotion from ?:,
- * - Invalid sizes result in a compile time error stemming from
- *   the fact that abort has no parameters.
- * - It's easier to use the endian-specific unaligned load/store
- *   functions than host-endian unaligned load/store plus tswapN.
- * - The pragmas are necessary only to silence a clang false-positive
- *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
- * - gcc has bugs in its _Pragma() support in some versions, eg
- *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
- *   include the warning-suppression pragmas for clang
- */
-#if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
-#define PRAGMA_DISABLE_PACKED_WARNING                                   \
-    _Pragma("GCC diagnostic push");                                     \
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
 #define __put_user_e(x, hptr, e)                                            \
     do {                                                                    \
         PRAGMA_DISABLE_PACKED_WARNING;                                      \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index bbd55b4d18c..9bff3b763b5 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634
+Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb
-- 
2.41.0


