Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0EF70F163
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1k9s-0001i0-Ks; Wed, 24 May 2023 04:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=pqJs=BN=redhat.com=clg@ozlabs.org>)
 id 1q1k9q-0001fP-0E
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:47:46 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=pqJs=BN=redhat.com=clg@ozlabs.org>)
 id 1q1k9o-0002N3-9f
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:47:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QR4ZM24xZz4x4S;
 Wed, 24 May 2023 18:47:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QR4ZK0D88z4x3g;
 Wed, 24 May 2023 18:47:36 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/2] util/vfio-helpers: Use g_file_read_link()
Date: Wed, 24 May 2023 10:47:24 +0200
Message-Id: <20230524084724.2511267-3-clg@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524084724.2511267-1-clg@redhat.com>
References: <20230524084724.2511267-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=pqJs=BN=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
---
 util/vfio-helpers.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 2d8af38f886a..f8bab46c68fa 100644
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
2.40.1


