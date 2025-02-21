Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A2A3FDE9
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 18:51:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXA5-0000qt-9G; Fri, 21 Feb 2025 12:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlXA1-0000pQ-W2; Fri, 21 Feb 2025 12:50:02 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlX9z-0001ba-Sa; Fri, 21 Feb 2025 12:50:01 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3A6C2EFB68;
 Fri, 21 Feb 2025 20:49:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E72321BB584;
 Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D972053F83; Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 jonah.palmer@oracle.com, aesteve@redhat.com, hreitz@redhat.com,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.2 05/14] qmp: update vhost-user protocol feature maps
Date: Fri, 21 Feb 2025 20:49:35 +0300
Message-Id: <20250221174949.836197-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
References: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Laurent Vivier <lvivier@redhat.com>

Add VHOST_USER_PROTOCOL_F_SHARED_OBJECT and
VHOST_USER_PROTOCOL_F_DEVICE_STATE protocol feature maps to
the virtio introspection.

Cc: jonah.palmer@oracle.com
Fixes: 160947666276 ("vhost-user: add shared_object msg")
Cc: aesteve@redhat.com
Fixes: cda83adc62b6 ("vhost-user: Interface for migration state transfer")
Cc: hreitz@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 1e3d4d9a1a32ac6835f0d295a5117851c421fb5d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index cccc6fe761..8a32a3b105 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -121,6 +121,12 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
             "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
             "device status supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_SHARED_OBJECT, \
+            "VHOST_USER_PROTOCOL_F_SHARED_OBJECT: Backend shared object "
+            "supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_DEVICE_STATE, \
+            "VHOST_USER_PROTOCOL_F_DEVICE_STATE: Backend device state transfer "
+            "supported"),
     { -1, "" }
 };
 
-- 
2.39.5


