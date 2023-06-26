Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D8773E263
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:47:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNP-0006Di-U7; Mon, 26 Jun 2023 08:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlM7-0004Wb-Qc
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlM6-0003JO-0A
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AciTnBuftzpXPPCO+R3LnCnQ4nRx1NsyQcNXImLvWes=;
 b=QafdhjwRBdmjL3RYVxdmRiM9ckDmCOejBhCCrc8EisRF0JGhAQzUBQZbgXlBOAmFtzWzpt
 +AdU5If4cRckmRZBZqGs7As5Wyo+cBZA/fGMcRk5R3Cr0FMyd0G/lnOh7IFWA+QsvvWv+k
 RGHykIDa8V9GmLyG8Teq46qEtjX4pFw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-1FIgXKV_NniU6SkcrKHnIQ-1; Mon, 26 Jun 2023 08:30:03 -0400
X-MC-Unique: 1FIgXKV_NniU6SkcrKHnIQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f3932e595dso2517676e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782600; x=1690374600;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AciTnBuftzpXPPCO+R3LnCnQ4nRx1NsyQcNXImLvWes=;
 b=Z9LriOfq9YQ3jn6OSiXwDX0dop5dsKal5S34YA3xCH5UITaEfN3k6zqVAQ3cLJ65FU
 gu59Qj3mIzNnWdGiSsdJK7CGhnn6uMUJfsXpCLBzY9gwhMtBEKQHf6U60Lper/1FMtE3
 gL1RcxwsMT/1e5725zju1DvRVQiq5oGvAYDXczK7DjRWB3gFKfVQQX4hn55svhNEWUuU
 b6TI85WpDl1tsGYb/g09ANskseaw/PFhkx46n5NUhmsavWVCqJoORHFV/8D6hVviRV8S
 GwZQuLE7SJnPJ7EW8YtKqMMeKMshShAkj5ZHewqqhFvdXWbtKSQy4Tbf7PinD3a/74Mj
 xLnw==
X-Gm-Message-State: AC+VfDwhnLd1In0KAEfil/gJmT4rCYRVBmQEaMQuo6XqFywB7Oauo+Ff
 mIn+D7fitSeM0lfw5RhY7pOhtpty/eGJP9PrJO5uKX7map6WMO1z18VMbpyZhNvB5Xm3MKaPXPl
 8no5e9puQjAYoNhCOlheSFZWd83Kwtexj3tUsLoiYeYflVMlenvTUFtp2ysc8KUP6ks9R
X-Received: by 2002:a05:6512:2343:b0:4fa:9817:c1da with SMTP id
 p3-20020a056512234300b004fa9817c1damr2577166lfu.21.1687782599944; 
 Mon, 26 Jun 2023 05:29:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6uycp+gGk9kPuiZbfcML67Gp2i7fGbUMkx6V3rOw0pfOelSUzwn/oLNJsLFq1eZZrayA4MMw==
X-Received: by 2002:a05:6512:2343:b0:4fa:9817:c1da with SMTP id
 p3-20020a056512234300b004fa9817c1damr2577143lfu.21.1687782599594; 
 Mon, 26 Jun 2023 05:29:59 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003f90ab2fff9sm7572011wmi.9.2023.06.26.05.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:59 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, longpeng2@huawei.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 43/53] vhost: fix vhost_dev_enable_notifiers() error case
Message-ID: <c02b8159149fc8a89d299abc2c1a54b856b5378b.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

in vhost_dev_enable_notifiers(), if virtio_bus_set_host_notifier(true)
fails, we call vhost_dev_disable_notifiers() that executes
virtio_bus_set_host_notifier(false) on all queues, even on queues that
have failed to be initialized.

This triggers a core dump in memory_region_del_eventfd():

 virtio_bus_set_host_notifier: unable to init event notifier: Too many open files (-24)
 vhost VQ 1 notifier binding failed: 24
 .../softmmu/memory.c:2611: memory_region_del_eventfd: Assertion `i != mr->ioeventfd_nb' failed.

Fix the problem by providing to vhost_dev_disable_notifiers() the
number of queues to disable.

Fixes: 8771589b6f81 ("vhost: simplify vhost_dev_enable_notifiers")
Cc: longpeng2@huawei.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20230602162735.3670785-1-lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost.c | 65 ++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index fb7abc9769..d116c2d6a1 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1530,6 +1530,40 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     memset(hdev, 0, sizeof(struct vhost_dev));
 }
 
+static void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
+                                             VirtIODevice *vdev,
+                                             unsigned int nvqs)
+{
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    int i, r;
+
+    /*
+     * Batch all the host notifiers in a single transaction to avoid
+     * quadratic time complexity in address_space_update_ioeventfds().
+     */
+    memory_region_transaction_begin();
+
+    for (i = 0; i < nvqs; ++i) {
+        r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i,
+                                         false);
+        if (r < 0) {
+            error_report("vhost VQ %d notifier cleanup failed: %d", i, -r);
+        }
+        assert(r >= 0);
+    }
+
+    /*
+     * The transaction expects the ioeventfds to be open when it
+     * commits. Do it now, before the cleanup loop.
+     */
+    memory_region_transaction_commit();
+
+    for (i = 0; i < nvqs; ++i) {
+        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i);
+    }
+    virtio_device_release_ioeventfd(vdev);
+}
+
 /* Stop processing guest IO notifications in qemu.
  * Start processing them in vhost in kernel.
  */
@@ -1559,7 +1593,7 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
         if (r < 0) {
             error_report("vhost VQ %d notifier binding failed: %d", i, -r);
             memory_region_transaction_commit();
-            vhost_dev_disable_notifiers(hdev, vdev);
+            vhost_dev_disable_notifiers_nvqs(hdev, vdev, i);
             return r;
         }
     }
@@ -1576,34 +1610,7 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
  */
 void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
 {
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    int i, r;
-
-    /*
-     * Batch all the host notifiers in a single transaction to avoid
-     * quadratic time complexity in address_space_update_ioeventfds().
-     */
-    memory_region_transaction_begin();
-
-    for (i = 0; i < hdev->nvqs; ++i) {
-        r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i,
-                                         false);
-        if (r < 0) {
-            error_report("vhost VQ %d notifier cleanup failed: %d", i, -r);
-        }
-        assert (r >= 0);
-    }
-
-    /*
-     * The transaction expects the ioeventfds to be open when it
-     * commits. Do it now, before the cleanup loop.
-     */
-    memory_region_transaction_commit();
-
-    for (i = 0; i < hdev->nvqs; ++i) {
-        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i);
-    }
-    virtio_device_release_ioeventfd(vdev);
+    vhost_dev_disable_notifiers_nvqs(hdev, vdev, hdev->nvqs);
 }
 
 /* Test and clear event pending status.
-- 
MST


