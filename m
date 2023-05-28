Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717A71382E
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 09:00:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ALW-0006RH-LL; Sun, 28 May 2023 02:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ALU-0006Pd-79; Sun, 28 May 2023 02:57:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ALR-0001cn-Jc; Sun, 28 May 2023 02:57:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7F0FC8E01;
 Sun, 28 May 2023 09:57:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1B56D7E21;
 Sun, 28 May 2023 09:57:17 +0300 (MSK)
Received: (nullmailer pid 42078 invoked by uid 1000);
 Sun, 28 May 2023 06:57:15 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 69/73] util/vfio-helpers: Use g_file_read_link()
Date: Sun, 28 May 2023 09:57:07 +0300
Message-Id: <20230528065714.42005-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230528095540@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230528095540@cover.tls.msk.ru>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

When _FORTIFY_SOURCE=2, glibc version is 2.35, and GCC version is
12.1.0, the compiler complains as follows:

In file included from /usr/include/features.h:490,
                 from /usr/include/bits/libc-header-start.h:33,
                 from /usr/include/stdint.h:26,
                 from /usr/lib/gcc/aarch64-unknown-linux-gnu/12.1.0/include/stdint.h:9,
                 from /home/alarm/q/var/qemu/include/qemu/osdep.h:94,
                 from ../util/vfio-helpers.c:13:
In function 'readlink',
    inlined from 'sysfs_find_group_file' at ../util/vfio-helpers.c:116:9,
    inlined from 'qemu_vfio_init_pci' at ../util/vfio-helpers.c:326:18,
    inlined from 'qemu_vfio_open_pci' at ../util/vfio-helpers.c:517:9:
/usr/include/bits/unistd.h:119:10: error: argument 2 is null but the corresponding size argument 3 value is 4095 [-Werror=nonnull]
  119 |   return __glibc_fortify (readlink, __len, sizeof (char),
      |          ^~~~~~~~~~~~~~~

This error implies the allocated buffer can be NULL. Use
g_file_read_link(), which allocates buffer automatically to avoid the
error.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit dbdea0dbfe2cef9ef6c752e9077e4fc98724194c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 2d8af38f88..f8bab46c68 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -106,15 +106,17 @@ struct QEMUVFIOState {
  */
 static char *sysfs_find_group_file(const char *device, Error **errp)
 {
+    g_autoptr(GError) gerr = NULL;
     char *sysfs_link;
     char *sysfs_group;
     char *p;
     char *path = NULL;
 
     sysfs_link = g_strdup_printf("/sys/bus/pci/devices/%s/iommu_group", device);
-    sysfs_group = g_malloc0(PATH_MAX);
-    if (readlink(sysfs_link, sysfs_group, PATH_MAX - 1) == -1) {
-        error_setg_errno(errp, errno, "Failed to find iommu group sysfs path");
+    sysfs_group = g_file_read_link(sysfs_link, &gerr);
+    if (gerr) {
+        error_setg(errp, "Failed to find iommu group sysfs path: %s",
+                   gerr->message);
         goto out;
     }
     p = strrchr(sysfs_group, '/');
-- 
2.39.2


