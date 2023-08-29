Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5CE78D042
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:20:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n0-0000o4-E7; Tue, 29 Aug 2023 19:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qb3lR-0005OF-Gc
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:48:33 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qb3lO-0002nA-1m
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:48:32 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34deefc2016so2521125ab.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693334908; x=1693939708;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jRMdwRZVaHcJhDUF3R1tki83zY7wZVELi6/t8QmFp0I=;
 b=hpa1tJqtdk1c48KA6ZG8p8RzRl5cTvl5dhTc/U6azYFhLz/2yoYyqNB89j0hlQDxME
 as0680Q+dyVDlmHF4vMPOCylF8XHqRSAxgO8AsIxzaeAlTV2GFAXGtMAMyrQNhOGeF5w
 8tDXg1kHx3gO9caV758Pv/ZhNZ+BNuOskzcFKfZ0wg69qVe/B4jFU5HBk5sBzT+BB9I8
 OflVCyUzStZDaHmgJrMb0egXHDNFcpJcaenHMtHAmNY71SGjvqEl5eClS6gbWLUg3/d1
 wEDxbyDHLe3hLwfwmoQYiVCvexByOWcbhwyt2gQqknIoR2lstmIxylK5tMrXjg4ltLDe
 O/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693334908; x=1693939708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jRMdwRZVaHcJhDUF3R1tki83zY7wZVELi6/t8QmFp0I=;
 b=Q1azoSQscpdz/pRQLauOxswA1gDDy4wS/as5MsGpYH+45Crlb1LKmAuBVtdBBxbAyG
 qFqCgONOYRP1CAQ0RvMigwU/xdrx8nuP1eCK77CDG56HUl4aslFccAKCGtzspJB7S3We
 u6/Qa2yoWdk3bpYFTE8ZzoAFXd3kCfwsGvfhcBVvIQH7x3HvE+dRMZqVyhTHkv+Dmay2
 TvShojjfJdQ20mo4swjKkl3A9Ojdhjjlg+w3QeWyLzChboC4bKrFIclVs11pNwHSCMWn
 YnUUSWT+IbSQSa1cfy+1tSxIXfabKzL0fEuQHC5dxRXolIRSWNFrXsssYOa5AOGdzHCj
 cyvw==
X-Gm-Message-State: AOJu0YzE6w0DPfnTvX+ec7bZsXDVGNoBTHLuFADT0lGCfXwu0/Gsy73Z
 e+tuHUkGo7VIUxcEUuUdvqPWrhc1tkHfvY1poLQ=
X-Google-Smtp-Source: AGHT+IFWrvkqYWt8xE+TdVo9HBtDfZ257NbaVULH8RvstVPop/fHLxonWYBYUpU3PtRRazItc3xrzg==
X-Received: by 2002:a05:6e02:1a21:b0:348:fe78:e9ed with SMTP id
 g1-20020a056e021a2100b00348fe78e9edmr269235ile.7.1693334907842; 
 Tue, 29 Aug 2023 11:48:27 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 h9-20020a02c729000000b0042b326ed1ebsm3394534jao.48.2023.08.29.11.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 11:48:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Beraldo Leal <bleal@redhat.com>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH] linux-user: Move PRAGMA_DISABLE_PACKED_WARNING to compiler.h
Date: Tue, 29 Aug 2023 12:45:09 -0600
Message-ID: <20230829184509.54434-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::131;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x131.google.com
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
 include/qemu/compiler.h  |  3 +--
 linux-user/qemu.h        | 26 --------------------------
 tests/lcitool/libvirt-ci |  2 +-
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index b0374425180..9496a65ea57 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -38,10 +38,9 @@
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


