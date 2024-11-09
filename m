Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9DF9C2CEA
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:26:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kPP-0006Gk-ST; Sat, 09 Nov 2024 07:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kOA-0004kQ-9L; Sat, 09 Nov 2024 07:16:30 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kO6-0005A7-PZ; Sat, 09 Nov 2024 07:16:24 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A0891A1639;
 Sat,  9 Nov 2024 15:08:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 684C0167FC0;
 Sat,  9 Nov 2024 15:09:02 +0300 (MSK)
Received: (nullmailer pid 3296176 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 16/58] vfio/migration: Report only stop-copy size in
 vfio_state_pending_exact()
Date: Sat,  9 Nov 2024 15:08:17 +0300
Message-Id: <20241109120901.3295995-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

vfio_state_pending_exact() is used to update migration core how much
device data is left for the device migration. Currently, the sum of
pre-copy and stop-copy sizes of the VFIO device are reported.

The pre-copy size is obtained via the VFIO_MIG_GET_PRECOPY_INFO ioctl,
which returns the amount of device data available to be transferred
while the device is in the PRE_COPY states.

The stop-copy size is obtained via the VFIO_DEVICE_FEATURE_MIG_DATA_SIZE
ioctl, which returns the total amount of device data left to be
transferred in order to complete the device migration.

According to the above, current implementation is wrong -- it reports
extra overlapping data because pre-copy size is already contained in
stop-copy size. Fix it by reporting only stop-copy size.

Fixes: eda7362af959 ("vfio/migration: Add VFIO migration pre-copy support")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 3b5948f808e3b99aedfa0aff45cffbe8b7ec07ed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 262d42a46e..dd717e8d6c 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -576,9 +576,6 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
 
     if (vfio_device_state_is_precopy(vbasedev)) {
         vfio_query_precopy_size(migration);
-
-        *must_precopy +=
-            migration->precopy_init_size + migration->precopy_dirty_size;
     }
 
     trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
-- 
2.39.5


