Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E85FF81A050
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:54:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFx0r-0007S3-Bv; Wed, 20 Dec 2023 08:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=wWAb=H7=redhat.com=clg@ozlabs.org>)
 id 1rFx0n-0007Rn-Fx
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:53:25 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=wWAb=H7=redhat.com=clg@ozlabs.org>)
 id 1rFx0l-0007gI-29
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:53:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SwFPw4KHZz4xCp;
 Thu, 21 Dec 2023 00:53:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwFPt0dvHz4wcj;
 Thu, 21 Dec 2023 00:53:05 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] vfio/container: Replace basename with g_path_get_basename
Date: Wed, 20 Dec 2023 14:53:02 +0100
Message-ID: <20231220135302.932039-1-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=wWAb=H7=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

g_path_get_basename() is a portable utility function that has the
advantage of not modifing the string argument. It also fixes a compile
breakage with the Musl C library reported in [1].

[1] https://lore.kernel.org/all/20231212010228.2701544-1-raj.khem@gmail.com/

Reported-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 688cf23bab88f85246378bc5a7da3c51ea6b79d9..8d334f52f2438d05f632502e07ffd4dc2ec76cb5 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -869,7 +869,8 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
 
 static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
 {
-    char *tmp, group_path[PATH_MAX], *group_name;
+    char *tmp, group_path[PATH_MAX];
+    g_autofree char *group_name = NULL;
     int ret, groupid;
     ssize_t len;
 
@@ -885,7 +886,7 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
 
     group_path[len] = 0;
 
-    group_name = basename(group_path);
+    group_name = g_path_get_basename(group_path);
     if (sscanf(group_name, "%d", &groupid) != 1) {
         error_setg_errno(errp, errno, "failed to read %s", group_path);
         return -errno;
-- 
2.43.0


