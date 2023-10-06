Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E2B7BB185
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 08:26:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoeCW-0005El-MH; Fri, 06 Oct 2023 02:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=cI0A=FU=redhat.com=clg@ozlabs.org>)
 id 1qoeCS-0005Cv-Vw
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:20:36 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=cI0A=FU=redhat.com=clg@ozlabs.org>)
 id 1qoeCR-0002yR-7u
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:20:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S1ywL3zF8z4xQk;
 Fri,  6 Oct 2023 17:20:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1ywJ70hdz4xQV;
 Fri,  6 Oct 2023 17:20:32 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/21] vfio/common: Propagate KVM_SET_DEVICE_ATTR error if any
Date: Fri,  6 Oct 2023 08:19:54 +0200
Message-ID: <20231006062005.1040296-11-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006062005.1040296-1-clg@redhat.com>
References: <20231006062005.1040296-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=cI0A=FU=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

In the VFIO_SPAPR_TCE_v2_IOMMU container case, when
KVM_SET_DEVICE_ATTR fails, we currently don't propagate the
error as we do on the vfio_spapr_create_window() failure
case. Let's align the code. Take the opportunity to
reword the error message and make it more explicit.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4e122fc4e4001ee02e24c5593e4d36b428c848e2..c54a72ec803779b45803573c6c633a170c5bad1f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -878,11 +878,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
                 QLIST_FOREACH(group, &container->group_list, container_next) {
                     param.groupfd = group->fd;
                     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-                        error_report("vfio: failed to setup fd %d "
-                                     "for a group with fd %d: %s",
-                                     param.tablefd, param.groupfd,
-                                     strerror(errno));
-                        return;
+                        error_setg_errno(&err, errno,
+                                         "vfio: failed GROUP_SET_SPAPR_TCE for "
+                                         "KVM VFIO device %d and group fd %d",
+                                         param.tablefd, param.groupfd);
+                        goto fail;
                     }
                     trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
                 }
-- 
2.41.0


