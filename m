Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 943DC7783E3
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 01:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUEd3-0006SU-KV; Thu, 10 Aug 2023 18:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUEd1-0006O4-8z
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 18:59:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUEcz-000188-CP
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 18:59:39 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso9453705ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691708375; x=1692313175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jUjLXJJMYaIpToBcme2x1V4uk8XXlXc8AfA/OwkjDWg=;
 b=JLzn8WjQNcx93G48oh8lWOb+5waA1pHz+cpgLW/sQTYkdg8ACEbdvOsB2WbYURVDSI
 fBWNmyP/9qpI3XduUlvCaOdW/mLdLSCGYhfVp3GGkbpP32h4S6KFqPyIZ/WYXprUezkP
 Cs0HbWTf+Zw/Yfy/e/+iVV3dlPUm5YKjTRRmDLXC8Bk3rtkqbP/5eJrSx59q0xBteVaQ
 9HUANKdKB5JpaMxgYUPrr3K0YH2E/SupG1Iw+IXimT/itA6gntkyzTl8W3Au6l1rIoSy
 8o38JruGfmDRL3UK/9VACiKSsk2tgFJXK7enYPs4tf8i2s+wX/3VJnoc4nFfcDBp9fY7
 rCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691708375; x=1692313175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jUjLXJJMYaIpToBcme2x1V4uk8XXlXc8AfA/OwkjDWg=;
 b=MeS2HBm0kDPXXHIQ5oHpJ8vB186bqnsw0W3z2vkOKhFoqbKfaIlmv8BN4RSijdXE0N
 UjpdRLSYZ5NdkThV6P2PKE2bHJI36gov/uFrpgGva+OUUXkXt9XMXabIiVPyy5yJ+xa8
 KSsHifQv+cX9hdGjyHUbzcy3o5XkQUHrCQg3LJfAOGMw+HxZdFq8aVkoMqrdp0Cuj0jh
 3HDMH7klhSKNGHTCZjOg/ckTk/+pNvueUMPdeBDHT3s7fdHA+4dRjqNIMaNiduBnGK+Y
 BiYIqguHteqsLfpSKdIHScZLr38xJTWVbdJKvTgBxzIy6cHufvPjMZmKMRCZRUjo2J87
 EP6w==
X-Gm-Message-State: AOJu0Ywg2PRjT3pMpEyhySq6GPsFY9FRUQXKcSQvz4LVdAjGhLvxBO06
 n4gibCz4il/QPXa9b/TEGeuslw==
X-Google-Smtp-Source: AGHT+IEtQkXNmReG26L0MrMigSG656EgsGsVZkB8xWZuuHwdm4Ig7OEEWo1oHVOiSqzVM158FlGYfQ==
X-Received: by 2002:a17:902:f68a:b0:1b6:bced:1dc2 with SMTP id
 l10-20020a170902f68a00b001b6bced1dc2mr246545plg.0.1691708375454; 
 Thu, 10 Aug 2023 15:59:35 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a170902b20400b001b552309aedsm2308002plr.192.2023.08.10.15.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 15:59:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, laurent@vivier.eu, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2] util: Delete checks for old host definitions
Date: Fri, 11 Aug 2023 07:59:20 +0900
Message-ID: <20230810225922.21600-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

IA-64 and PA-RISC host support is already removed with commit
b1cef6d02f("Drop remaining bits of ia64 host support").

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 util/async-teardown.c |  3 ---
 util/oslib-posix.c    | 14 ++------------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/util/async-teardown.c b/util/async-teardown.c
index 62cdeb0f20..396963c091 100644
--- a/util/async-teardown.c
+++ b/util/async-teardown.c
@@ -121,10 +121,7 @@ static void *new_stack_for_clone(void)
 
     /* Allocate a new stack and get a pointer to its top. */
     stack_ptr = qemu_alloc_stack(&stack_size);
-#if !defined(HOST_HPPA)
-    /* The top is at the end of the area, except on HPPA. */
     stack_ptr += stack_size;
-#endif
 
     return stack_ptr;
 }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 760390b31e..6da3cc5014 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -585,7 +585,7 @@ char *qemu_get_pid_name(pid_t pid)
 
 void *qemu_alloc_stack(size_t *sz)
 {
-    void *ptr, *guardpage;
+    void *ptr;
     int flags;
 #ifdef CONFIG_DEBUG_STACK_USAGE
     void *ptr2;
@@ -618,17 +618,7 @@ void *qemu_alloc_stack(size_t *sz)
         abort();
     }
 
-#if defined(HOST_IA64)
-    /* separate register stack */
-    guardpage = ptr + (((*sz - pagesz) / 2) & ~pagesz);
-#elif defined(HOST_HPPA)
-    /* stack grows up */
-    guardpage = ptr + *sz - pagesz;
-#else
-    /* stack grows down */
-    guardpage = ptr;
-#endif
-    if (mprotect(guardpage, pagesz, PROT_NONE) != 0) {
+    if (mprotect(ptr, pagesz, PROT_NONE) != 0) {
         perror("failed to set up stack guard page");
         abort();
     }
-- 
2.41.0


