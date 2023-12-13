Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F040E811271
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:04:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDOtg-0001QG-Tf; Wed, 13 Dec 2023 08:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOs1-0008Il-Ok; Wed, 13 Dec 2023 08:01:49 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOrz-00071U-Vc; Wed, 13 Dec 2023 08:01:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 97F8B3B440;
 Wed, 13 Dec 2023 16:01:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3D6DB3C8D1;
 Wed, 13 Dec 2023 16:00:42 +0300 (MSK)
Received: (nullmailer pid 1024733 invoked by uid 1000);
 Wed, 13 Dec 2023 13:00:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.8 13/24] hw/virtio: Add
 VirtioPCIDeviceTypeInfo::instance_finalize field
Date: Wed, 13 Dec 2023 16:00:22 +0300
Message-Id: <20231213130041.1024630-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
References: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VirtioPCIDeviceTypeInfo structure, added in commit a4ee4c8baa
("virtio: Helper for registering virtio device types") got extended
in commit 8ea90ee690 ("virtio: add class_size") with the @class_size
field. Do similarly with the @instance_finalize field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231121174051.63038-2-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 837053a7f491b445088eac647abe7f462c50f59a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 67e771c373..e5e74a7160 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2174,6 +2174,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .parent        = t->parent ? t->parent : TYPE_VIRTIO_PCI,
         .instance_size = t->instance_size,
         .instance_init = t->instance_init,
+        .instance_finalize = t->instance_finalize,
         .class_size    = t->class_size,
         .abstract      = true,
         .interfaces    = t->interfaces,
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 938799e8f6..c4676ff4d4 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -241,6 +241,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
     size_t instance_size;
     size_t class_size;
     void (*instance_init)(Object *obj);
+    void (*instance_finalize)(Object *obj);
     void (*class_init)(ObjectClass *klass, void *data);
     InterfaceInfo *interfaces;
 } VirtioPCIDeviceTypeInfo;
-- 
2.39.2


