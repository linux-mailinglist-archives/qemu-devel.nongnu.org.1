Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C5BAE972B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Jun 2025 09:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhIy-0004Or-Ri; Thu, 26 Jun 2025 03:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhIw-0004OW-HU
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhIu-0001vy-Sr
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cohC1TF4+wfU5TNquD8tlKMRJgQq52ejRwWMDBTo4QU=;
 b=UPKKqaruBeaYC/V99Dibu81H5zR2A48hzEyY8G/1+r7xz7HSKsdv8uqT9X2NaYs1POJ9tR
 GIUbdIRjXHm4kMMVZXCXHnYpzInwacbNFX/3PWFhTCm0hqCgjJXvcnk66X9P5IeaIQ/VVL
 OleCTcXw79d8xVPEbAnX1pbxYhTPOuM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-Ttvubg1VMpuR10ov-uc0Fg-1; Thu,
 26 Jun 2025 03:45:50 -0400
X-MC-Unique: Ttvubg1VMpuR10ov-uc0Fg-1
X-Mimecast-MFC-AGG-ID: Ttvubg1VMpuR10ov-uc0Fg_1750923949
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 302151944AAB; Thu, 26 Jun 2025 07:45:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DADF180035C; Thu, 26 Jun 2025 07:45:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/25] vfio/container: fails mdev hotplug if add migration
 blocker failed
Date: Thu, 26 Jun 2025 09:45:10 +0200
Message-ID: <20250626074529.1384114-7-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

It's aggressive to abort a running QEMU process when hotplug a mdev
and it fails migration blocker adding.

Fix by just failing mdev hotplug itself.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250623102235.94877-3-zhenzhong.duan@intel.com
[ clg: Changed test on value returned by migrate_add_blocker_modes() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 2853f6f08b5d3f199b7f2c22de884ec6b57279ce..3e13feaa74c30e8d7f5a0978e15824cecbf6d674 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -992,12 +992,16 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     if (vbasedev->mdev) {
         error_setg(&vbasedev->cpr.mdev_blocker,
                    "CPR does not support vfio mdev %s", vbasedev->name);
-        migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, &error_fatal,
-                                  MIG_MODE_CPR_TRANSFER, -1);
+        if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
+                                      MIG_MODE_CPR_TRANSFER, -1) < 0) {
+            goto hiod_unref_exit;
+        }
     }
 
     return true;
 
+hiod_unref_exit:
+    object_unref(vbasedev->hiod);
 device_put_exit:
     vfio_device_put(vbasedev);
 group_put_exit:
-- 
2.49.0


