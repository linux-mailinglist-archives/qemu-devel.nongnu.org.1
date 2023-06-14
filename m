Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E3730B07
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 00:57:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9ZQ2-00085r-RB; Wed, 14 Jun 2023 18:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=52269c73c=graf@amazon.de>)
 id 1q9ZPr-00084U-7g; Wed, 14 Jun 2023 18:56:39 -0400
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=52269c73c=graf@amazon.de>)
 id 1q9ZPo-0000eb-0o; Wed, 14 Jun 2023 18:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1686783396; x=1718319396;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HkoVjAiIpnHIOcBeQ5R/tis/X7PpChro1Dy9refD3/o=;
 b=sg6EZ+wNPBg7EAousLqSpqeU6H1xpo80DT3fjFbajc/m7GaFRbUoDIy6
 ugTNZEwTbKVAfvRmEqwYXqO+975GAY7dF9fG7rJIwFeTaA5DcgmTpJmJR
 0TXZ/kyUTFEy1DT4w/ofs7raNa/5lJ1wS8QFEU9eDTgkd7MUl/A29/Lc/ I=;
X-IronPort-AV: E=Sophos;i="6.00,243,1681171200"; d="scan'208";a="590668780"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 22:56:35 +0000
Received: from EX19MTAUWB001.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
 by email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com (Postfix)
 with ESMTPS id CFD0380FA5; Wed, 14 Jun 2023 22:56:30 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 22:56:30 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 22:56:28 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <qemu-arm@nongnu.org>, Cameron Esfahani
 <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Peter
 Maydell" <peter.maydell@linaro.org>
Subject: [PATCH 05/12] hw/virtio: Add support for apple virtio-blk
Date: Wed, 14 Jun 2023 22:56:22 +0000
Message-ID: <20230614225626.97734-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614224038.86148-1-graf>
References: <20230614224038.86148-1-graf>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Precedence: Bulk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=52.119.213.152;
 envelope-from=prvs=52269c73c=graf@amazon.de; helo=smtp-fw-52003.amazon.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Apple has its own virtio-blk PCI device ID where it deviates from the
official virtio-pci spec slightly: It puts a new "apple type"
field at a static offset in config space and introduces a new discard
command.

This patch adds a new qdev property called "apple-type" to virtio-blk-pci.
When that property is set, we assume the virtio-blk device is an Apple one
of the specific type and act accordingly.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/block/virtio-blk.c                       | 23 +++++++++++++++++++++
 hw/virtio/virtio-blk-pci.c                  |  7 +++++++
 include/hw/pci/pci_ids.h                    |  1 +
 include/hw/virtio/virtio-blk.h              |  1 +
 include/standard-headers/linux/virtio_blk.h |  3 +++
 5 files changed, 35 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 39e7f23fab..76b85bb3cb 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1120,6 +1120,20 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
 
         break;
     }
+    case VIRTIO_BLK_T_APPLE1:
+    {
+        if (s->conf.x_apple_type) {
+            /* Only valid on Apple Virtio */
+            char buf[iov_size(in_iov, in_num)];
+            memset(buf, 0, sizeof(buf));
+            iov_from_buf(in_iov, in_num, 0, buf, sizeof(buf));
+            virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
+        } else {
+            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
+        }
+        virtio_blk_free_request(req);
+        break;
+    }
     default:
         virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
         virtio_blk_free_request(req);
@@ -1351,6 +1365,10 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
     } else {
         blkcfg.zoned.model = VIRTIO_BLK_Z_NONE;
     }
+    if (s->conf.x_apple_type) {
+        /* Apple abuses the same location for its type id */
+        blkcfg.max_secure_erase_sectors = s->conf.x_apple_type;
+    }
     memcpy(config, &blkcfg, s->config_size);
 }
 
@@ -1625,6 +1643,10 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
 
     s->config_size = virtio_get_config_size(&virtio_blk_cfg_size_params,
                                             s->host_features);
+    if (s->conf.x_apple_type) {
+        /* Apple Virtio puts the blk type at 0x3c, make sure we have space. */
+        s->config_size = MAX(s->config_size, 0x3d);
+    }
     virtio_init(vdev, VIRTIO_ID_BLOCK, s->config_size);
 
     s->blk = conf->conf.blk;
@@ -1734,6 +1756,7 @@ static Property virtio_blk_properties[] = {
                        conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SECTORS),
     DEFINE_PROP_BOOL("x-enable-wce-if-config-wce", VirtIOBlock,
                      conf.x_enable_wce_if_config_wce, true),
+    DEFINE_PROP_UINT32("x-apple-type", VirtIOBlock, conf.x_apple_type, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index 9743bee965..5fbf98f750 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -62,6 +62,13 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     }
 
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+
+    if (conf->x_apple_type) {
+        /* Apple virtio-blk uses a different vendor/device id */
+        pci_config_set_vendor_id(vpci_dev->pci_dev.config, PCI_VENDOR_ID_APPLE);
+        pci_config_set_device_id(vpci_dev->pci_dev.config,
+                                 PCI_DEVICE_ID_APPLE_VIRTIO_BLK);
+    }
 }
 
 static void virtio_blk_pci_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index e4386ebb20..74e589a298 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -188,6 +188,7 @@
 #define PCI_DEVICE_ID_APPLE_UNI_N_AGP    0x0020
 #define PCI_DEVICE_ID_APPLE_U3_AGP       0x004b
 #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC   0x0021
+#define PCI_DEVICE_ID_APPLE_VIRTIO_BLK   0x1a00
 
 #define PCI_VENDOR_ID_SUN                0x108e
 #define PCI_DEVICE_ID_SUN_EBUS           0x1000
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index dafec432ce..7117ce754c 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -46,6 +46,7 @@ struct VirtIOBlkConf
     uint32_t max_discard_sectors;
     uint32_t max_write_zeroes_sectors;
     bool x_enable_wce_if_config_wce;
+    uint32_t x_apple_type;
 };
 
 struct VirtIOBlockDataPlane;
diff --git a/include/standard-headers/linux/virtio_blk.h b/include/standard-headers/linux/virtio_blk.h
index 7155b1a470..bbea5d50b9 100644
--- a/include/standard-headers/linux/virtio_blk.h
+++ b/include/standard-headers/linux/virtio_blk.h
@@ -204,6 +204,9 @@ struct virtio_blk_config {
 /* Reset All zones command */
 #define VIRTIO_BLK_T_ZONE_RESET_ALL 26
 
+/* Write zeroes command */
+#define VIRTIO_BLK_T_APPLE1	0x10000
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
-- 
2.39.2 (Apple Git-143)




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




