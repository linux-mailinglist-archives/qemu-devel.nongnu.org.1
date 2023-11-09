Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F717E6C12
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:06:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15fU-0004oi-Rv; Thu, 09 Nov 2023 09:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15dI-0005pC-8R; Thu, 09 Nov 2023 09:03:48 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15dG-00078E-5r; Thu, 09 Nov 2023 09:03:43 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B051E31BE6;
 Thu,  9 Nov 2023 16:59:57 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B9C3E3451D;
 Thu,  9 Nov 2023 16:59:49 +0300 (MSK)
Received: (nullmailer pid 1462918 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 46/62] Revert "linux-user: fix compat with glibc >=
 2.36 sys/mount.h"
Date: Thu,  9 Nov 2023 16:59:14 +0300
Message-Id: <20231109135933.1462615-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This reverts commit 3cd3df2a9584e6f753bb62a0028bd67124ab5532.

glibc has fixed (in 2.36.9000-40-g774058d729) the problem
that caused a clash when both sys/mount.h annd linux/mount.h
are included, and backported this to the 2.36 stable release
too:

  https://sourceware.org/glibc/wiki/Release/2.36#Usage_of_.3Clinux.2Fmount.h.3E_and_.3Csys.2Fmount.h.3E

It is saner for QEMU to remove the workaround it applied for
glibc 2.36 and expect distros to ship the 2.36 maint release
with the fix. This avoids needing to add a further workaround
to QEMU to deal with the fact that linux/brtfs.h now also pulls
in linux/mount.h via linux/fs.h since Linux 6.1

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230110174901.2580297-3-berrange@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
(cherry picked from commit 6003159ce18faad4e1bc7bf9c85669019cd4950e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7037c51bca..aead0f6ac9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -95,25 +95,7 @@
 #include <linux/soundcard.h>
 #include <linux/kd.h>
 #include <linux/mtio.h>
-
-#ifdef HAVE_SYS_MOUNT_FSCONFIG
-/*
- * glibc >= 2.36 linux/mount.h conflicts with sys/mount.h,
- * which in turn prevents use of linux/fs.h. So we have to
- * define the constants ourselves for now.
- */
-#define FS_IOC_GETFLAGS                _IOR('f', 1, long)
-#define FS_IOC_SETFLAGS                _IOW('f', 2, long)
-#define FS_IOC_GETVERSION              _IOR('v', 1, long)
-#define FS_IOC_SETVERSION              _IOW('v', 2, long)
-#define FS_IOC_FIEMAP                  _IOWR('f', 11, struct fiemap)
-#define FS_IOC32_GETFLAGS              _IOR('f', 1, int)
-#define FS_IOC32_SETFLAGS              _IOW('f', 2, int)
-#define FS_IOC32_GETVERSION            _IOR('v', 1, int)
-#define FS_IOC32_SETVERSION            _IOW('v', 2, int)
-#else
 #include <linux/fs.h>
-#endif
 #include <linux/fd.h>
 #if defined(CONFIG_FIEMAP)
 #include <linux/fiemap.h>
diff --git a/meson.build b/meson.build
index 450c48a9f0..787f91855e 100644
--- a/meson.build
+++ b/meson.build
@@ -2032,8 +2032,6 @@ config_host_data.set('HAVE_OPTRESET',
                      cc.has_header_symbol('getopt.h', 'optreset'))
 config_host_data.set('HAVE_IPPROTO_MPTCP',
                      cc.has_header_symbol('netinet/in.h', 'IPPROTO_MPTCP'))
-config_host_data.set('HAVE_SYS_MOUNT_FSCONFIG',
-                     cc.has_header_symbol('sys/mount.h', 'FSCONFIG_SET_FLAG'))
 
 # has_member
 config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
-- 
2.39.2


