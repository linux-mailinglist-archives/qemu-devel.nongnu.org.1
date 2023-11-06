Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A339E7E2693
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:23:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00Tk-0000q6-TQ; Mon, 06 Nov 2023 09:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1r00Th-0000pP-GM
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:21:21 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1r00Tf-0005R3-Fd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:21:21 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1r00Tc-0000dM-MV; Mon, 06 Nov 2023 15:21:16 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/10] Revert "hw/virtio/virtio-pmem: Replace impossible check
 by assertion"
Date: Mon,  6 Nov 2023 15:20:46 +0100
Message-ID: <2d7f1081864790eb1000e6ef34e202dae66a03d2.1699279190.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1699279190.git.maciej.szmigiero@oracle.com>
References: <cover.1699279190.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This reverts commit 5960f254dbb46f0c7a9f5f44bf4d27c19c34cb97 since the
previous commit made this situation possible again.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/virtio/virtio-pmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index cc24812d2e92..c3512c2dae3f 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -147,7 +147,10 @@ static void virtio_pmem_fill_device_info(const VirtIOPMEM *pmem,
 static MemoryRegion *virtio_pmem_get_memory_region(VirtIOPMEM *pmem,
                                                    Error **errp)
 {
-    assert(pmem->memdev);
+    if (!pmem->memdev) {
+        error_setg(errp, "'%s' property must be set", VIRTIO_PMEM_MEMDEV_PROP);
+        return NULL;
+    }
 
     return &pmem->memdev->mr;
 }

