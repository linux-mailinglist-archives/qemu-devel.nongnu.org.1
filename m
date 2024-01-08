Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCE48268B2
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 08:37:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMk8N-0003In-MB; Mon, 08 Jan 2024 02:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk8L-0003Ia-J9
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:33:17 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk8H-0004gd-IT
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:33:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T7m4m6gv8z4wcc;
 Mon,  8 Jan 2024 18:33:12 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7m4l175Qz4x22;
 Mon,  8 Jan 2024 18:33:10 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <Zhenzhong.duan@intel.com>
Subject: [PULL 13/17] vfio/iommufd: Remove the use of stat() to check file
 existence
Date: Mon,  8 Jan 2024 08:32:28 +0100
Message-ID: <20240108073232.118228-14-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108073232.118228-1-clg@redhat.com>
References: <20240108073232.118228-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=P3fH=IS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Using stat() before opening a file or a directory can lead to a
time-of-check to time-of-use (TOCTOU) filesystem race, which is
reported by coverity as a Security best practices violations. The
sequence could be replaced by open and fdopendir but it doesn't add
much in this case. Simply use opendir to avoid the race.

Fixes: CID 1531551
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <Zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index d4c586e842def8f04d3a914843f5eece2c75ea30..9bfddc1360895413176a9f170e29e89027384a66 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -121,17 +121,11 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
     DIR *dir = NULL;
     struct dirent *dent;
     gchar *contents;
-    struct stat st;
     gsize length;
     int major, minor;
     dev_t vfio_devt;
 
     path = g_strdup_printf("%s/vfio-dev", sysfs_path);
-    if (stat(path, &st) < 0) {
-        error_setg_errno(errp, errno, "no such host device");
-        goto out_free_path;
-    }
-
     dir = opendir(path);
     if (!dir) {
         error_setg_errno(errp, errno, "couldn't open directory %s", path);
-- 
2.43.0


