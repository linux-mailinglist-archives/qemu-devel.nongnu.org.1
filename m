Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 481FD89EA00
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Apr 2024 07:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQnv-0000fa-EB; Wed, 10 Apr 2024 01:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlz-00056E-0c; Wed, 10 Apr 2024 01:45:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlx-0001hr-1N; Wed, 10 Apr 2024 01:45:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC6985D4E8;
 Wed, 10 Apr 2024 08:46:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7282CB014F;
 Wed, 10 Apr 2024 08:44:17 +0300 (MSK)
Received: (nullmailer pid 4182049 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Minwoo Im <minwoo.im@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 16/41] hw/nvme: separate 'serial' property for VFs
Date: Wed, 10 Apr 2024 08:43:37 +0300
Message-Id: <20240410054416.4181891-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Minwoo Im <minwoo.im@samsung.com>

Currently, when a VF is created, it uses the 'params' object of the PF
as it is. In other words, the 'params.serial' string memory area is also
shared. In this situation, if the VF is removed from the system, the
PF's 'params.serial' object is released with object_finalize() followed
by object_property_del_all() which release the memory for 'serial'
property. If that happens, the next VF created will inherit a serial
from a corrupted memory area.

If this happens, an error will occur when comparing subsys->serial and
n->params.serial in the nvme_subsys_register_ctrl() function.

Cc: qemu-stable@nongnu.org
Fixes: 44c2c09488db ("hw/nvme: Add support for SR-IOV")
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 4f0a4a3d5854824e5c5eccf353d4a1f4f749a29d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f2b308f5fa..c2c0fc991d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7515,9 +7515,15 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     if (pci_is_vf(pci_dev)) {
         /*
          * VFs derive settings from the parent. PF's lifespan exceeds
-         * that of VF's, so it's safe to share params.serial.
+         * that of VF's.
          */
         memcpy(&n->params, &pn->params, sizeof(NvmeParams));
+
+        /*
+         * Set PF's serial value to a new string memory to prevent 'serial'
+         * property object release of PF when a VF is removed from the system.
+         */
+        n->params.serial = g_strdup(pn->params.serial);
         n->subsys = pn->subsys;
     }
 
-- 
2.39.2


