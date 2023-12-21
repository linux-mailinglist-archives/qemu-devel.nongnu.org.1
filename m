Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BA881B009
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:11:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGE8j-0002EE-B3; Thu, 21 Dec 2023 03:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=/aOx=IA=redhat.com=clg@ozlabs.org>)
 id 1rGE8G-00020h-Vd
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:10:20 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=/aOx=IA=redhat.com=clg@ozlabs.org>)
 id 1rGE8E-0004KT-KB
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:10:16 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Swjld2Svvz4xMw;
 Thu, 21 Dec 2023 19:10:05 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swjlb0m70z4wcJ;
 Thu, 21 Dec 2023 19:10:02 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/iommufd: Remove the use of stat() to check file existence
Date: Thu, 21 Dec 2023 09:09:57 +0100
Message-ID: <20231221080957.1081077-1-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=/aOx=IA=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Using stat() before opening a file or a directory can lead to a
time-of-check to time-of-use (TOCTOU) filesystem race, which is
reported by coverity as a Security best practices violations. The
sequence could be replaced by open and fdopendir but it doesn't add
much in this case. Simply use opendir to avoid the race.

Fixes: CID 1531551
Signed-off-by: Cédric Le Goater <clg@redhat.com>
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


