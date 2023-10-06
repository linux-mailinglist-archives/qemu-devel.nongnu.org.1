Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E97D7BBE85
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 20:16:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qopMA-0007Cm-7J; Fri, 06 Oct 2023 14:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qopM5-0007CD-Nk; Fri, 06 Oct 2023 14:15:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qopM3-0000eO-Ts; Fri, 06 Oct 2023 14:15:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1CEEA28463;
 Fri,  6 Oct 2023 21:15:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BABB62D71A;
 Fri,  6 Oct 2023 21:15:05 +0300 (MSK)
Received: (nullmailer pid 3297251 invoked by uid 1000);
 Fri, 06 Oct 2023 18:15:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 49/57] win32: avoid discarding the exception handler
Date: Fri,  6 Oct 2023 21:14:38 +0300
Message-Id: <20231006181504.3297196-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231006191112@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231006191112@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

In all likelihood, the compiler with lto doesn't see the function being
used, from assembly macro __try1. Help it by marking the function has
being used.

Resolves:
https://gitlab.com/qemu-project/qemu/-/issues/1904

Fixes: commit d89f30b4df ("win32: wrap socket close() with an exception handler")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 75b773d84c89220463a14a6883d2b2a8e49e5b68)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(mjt: trivial context fixup in include/qemu/compiler.h)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index a309f90c76..5c7f63f351 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -197,4 +197,10 @@
 #define BUILTIN_SUBCLL_BROKEN
 #endif
 
+#if __has_attribute(used)
+# define QEMU_USED __attribute__((used))
+#else
+# define QEMU_USED
+#endif
+
 #endif /* COMPILER_H */
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 19a0ea7fbe..55b0189dc3 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -479,7 +479,7 @@ int qemu_bind_wrap(int sockfd, const struct sockaddr *addr,
     return ret;
 }
 
-EXCEPTION_DISPOSITION
+QEMU_USED EXCEPTION_DISPOSITION
 win32_close_exception_handler(struct _EXCEPTION_RECORD *exception_record,
                               void *registration, struct _CONTEXT *context,
                               void *dispatcher)
-- 
2.39.2


