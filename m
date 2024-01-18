Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E63D831386
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:58:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNEj-0000zx-SA; Thu, 18 Jan 2024 02:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNEg-0000vp-QK; Thu, 18 Jan 2024 02:54:50 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNEf-0007P7-3M; Thu, 18 Jan 2024 02:54:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B521845038;
 Thu, 18 Jan 2024 10:54:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DB7B5661A1;
 Thu, 18 Jan 2024 10:54:05 +0300 (MSK)
Received: (nullmailer pid 2381670 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Khem Raj <raj.khem@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 14/38] vfio/container: Replace basename with
 g_path_get_basename
Date: Thu, 18 Jan 2024 10:52:41 +0300
Message-Id: <20240118075404.2381519-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
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

From: Cédric Le Goater <clg@redhat.com>

g_path_get_basename() is a portable utility function that has the
advantage of not modifing the string argument. It also fixes a compile
breakage with the Musl C library reported in [1].

[1] https://lore.kernel.org/all/20231212010228.2701544-1-raj.khem@gmail.com/

Reported-by: Khem Raj <raj.khem@gmail.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 213ae3ffda463c0503e39e0cf827511b5298c314)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 242010036a..adc3005beb 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -848,7 +848,8 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
 
 static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
 {
-    char *tmp, group_path[PATH_MAX], *group_name;
+    char *tmp, group_path[PATH_MAX];
+    g_autofree char *group_name = NULL;
     int ret, groupid;
     ssize_t len;
 
@@ -864,7 +865,7 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
 
     group_path[len] = 0;
 
-    group_name = basename(group_path);
+    group_name = g_path_get_basename(group_path);
     if (sscanf(group_name, "%d", &groupid) != 1) {
         error_setg_errno(errp, errno, "failed to read %s", group_path);
         return -errno;
-- 
2.39.2


