Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B81F779E90A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:20:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPl7-0007B4-5B; Wed, 13 Sep 2023 09:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPl3-0007A7-Dd; Wed, 13 Sep 2023 09:18:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPl0-0002s1-4t; Wed, 13 Sep 2023 09:18:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B07452175F;
 Wed, 13 Sep 2023 16:18:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9F36827C82;
 Wed, 13 Sep 2023 16:18:01 +0300 (MSK)
Received: (nullmailer pid 4073280 invoked by uid 1000);
 Wed, 13 Sep 2023 13:18:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 05/66] hw: replace most qemu_bh_new calls with
 qemu_bh_new_guarded
Date: Wed, 13 Sep 2023 16:17:29 +0300
Message-Id: <20230913131757.4073200-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
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

From: Alexander Bulekov <alxndr@bu.edu>

This protects devices from bh->mmio reentrancy issues.

Thanks: Thomas Huth <thuth@redhat.com> for diagnosing OS X test failure.
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230427211013.2994127-5-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit f63192b0544af5d3e4d5edfd85ab520fcf671377)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 382be1ab11..4aa9c8c736 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -63,6 +63,7 @@ typedef struct Xen9pfsDev {
 
     int num_rings;
     Xen9pfsRing *rings;
+    MemReentrancyGuard mem_reentrancy_guard;
 } Xen9pfsDev;
 
 static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev);
@@ -450,7 +451,9 @@ static int xen_9pfs_connect(struct XenLegacyDevice *xendev)
         xen_9pdev->rings[i].ring.out = xen_9pdev->rings[i].data +
                                        XEN_FLEX_RING_SIZE(ring_order);
 
-        xen_9pdev->rings[i].bh = qemu_bh_new(xen_9pfs_bh, &xen_9pdev->rings[i]);
+        xen_9pdev->rings[i].bh = qemu_bh_new_guarded(xen_9pfs_bh,
+                                                     &xen_9pdev->rings[i],
+                                                     &xen_9pdev->mem_reentrancy_guard);
         xen_9pdev->rings[i].out_cons = 0;
         xen_9pdev->rings[i].out_size = 0;
         xen_9pdev->rings[i].inprogress = false;
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index b28d81737e..a6202997ee 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -127,7 +127,8 @@ bool virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
     } else {
         s->ctx = qemu_get_aio_context();
     }
-    s->bh = aio_bh_new(s->ctx, notify_guest_bh, s);
+    s->bh = aio_bh_new_guarded(s->ctx, notify_guest_bh, s,
+                               &DEVICE(vdev)->mem_reentrancy_guard);
     s->batch_notify_vqs = bitmap_new(conf->num_queues);
 
     *dataplane = s;
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 734da42ea7..d8bc39d359 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -633,8 +633,9 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
-    dataplane->bh = aio_bh_new(dataplane->ctx, xen_block_dataplane_bh,
-                               dataplane);
+    dataplane->bh = aio_bh_new_guarded(dataplane->ctx, xen_block_dataplane_bh,
+                                       dataplane,
+                                       &DEVICE(xendev)->mem_reentrancy_guard);
 
     return dataplane;
 }
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 7d4601cb5d..dd619f0731 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -985,7 +985,8 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    port->bh = qemu_bh_new(flush_queued_data_bh, port);
+    port->bh = qemu_bh_new_guarded(flush_queued_data_bh, port,
+                                   &dev->mem_reentrancy_guard);
     port->elem = NULL;
 }
 
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 80ce1e9a93..f1c0eb7dfc 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2201,11 +2201,14 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
 
     qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
 
-    qxl->update_irq = qemu_bh_new(qxl_update_irq_bh, qxl);
+    qxl->update_irq = qemu_bh_new_guarded(qxl_update_irq_bh, qxl,
+                                          &DEVICE(qxl)->mem_reentrancy_guard);
     qxl_reset_state(qxl);
 
-    qxl->update_area_bh = qemu_bh_new(qxl_render_update_area_bh, qxl);
-    qxl->ssd.cursor_bh = qemu_bh_new(qemu_spice_cursor_refresh_bh, &qxl->ssd);
+    qxl->update_area_bh = qemu_bh_new_guarded(qxl_render_update_area_bh, qxl,
+                                              &DEVICE(qxl)->mem_reentrancy_guard);
+    qxl->ssd.cursor_bh = qemu_bh_new_guarded(qemu_spice_cursor_refresh_bh, &qxl->ssd,
+                                             &DEVICE(qxl)->mem_reentrancy_guard);
 }
 
 static void qxl_realize_primary(PCIDevice *dev, Error **errp)
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 4e2e0dd53a..7c13b056b9 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1356,8 +1356,10 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 
     g->ctrl_vq = virtio_get_queue(vdev, 0);
     g->cursor_vq = virtio_get_queue(vdev, 1);
-    g->ctrl_bh = qemu_bh_new(virtio_gpu_ctrl_bh, g);
-    g->cursor_bh = qemu_bh_new(virtio_gpu_cursor_bh, g);
+    g->ctrl_bh = qemu_bh_new_guarded(virtio_gpu_ctrl_bh, g,
+                                     &qdev->mem_reentrancy_guard);
+    g->cursor_bh = qemu_bh_new_guarded(virtio_gpu_cursor_bh, g,
+                                       &qdev->mem_reentrancy_guard);
     QTAILQ_INIT(&g->reslist);
     QTAILQ_INIT(&g->cmdq);
     QTAILQ_INIT(&g->fenceq);
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 55902e1df7..4e76d6b191 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1509,7 +1509,8 @@ static void ahci_cmd_done(const IDEDMA *dma)
     ahci_write_fis_d2h(ad);
 
     if (ad->port_regs.cmd_issue && !ad->check_bh) {
-        ad->check_bh = qemu_bh_new(ahci_check_cmd_bh, ad);
+        ad->check_bh = qemu_bh_new_guarded(ahci_check_cmd_bh, ad,
+                                           &ad->mem_reentrancy_guard);
         qemu_bh_schedule(ad->check_bh);
     }
 }
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 303fcd7235..2480455372 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -321,6 +321,7 @@ struct AHCIDevice {
     bool init_d2h_sent;
     AHCICmdHdr *cur_cmd;
     NCQTransferState ncq_tfs[AHCI_MAX_CMDS];
+    MemReentrancyGuard mem_reentrancy_guard;
 };
 
 struct AHCIPCIState {
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 45d14a25e9..de48ff9f86 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -513,6 +513,7 @@ BlockAIOCB *ide_issue_trim(
         BlockCompletionFunc *cb, void *cb_opaque, void *opaque)
 {
     IDEState *s = opaque;
+    IDEDevice *dev = s->unit ? s->bus->slave : s->bus->master;
     TrimAIOCB *iocb;
 
     /* Paired with a decrement in ide_trim_bh_cb() */
@@ -520,7 +521,8 @@ BlockAIOCB *ide_issue_trim(
 
     iocb = blk_aio_get(&trim_aiocb_info, s->blk, cb, cb_opaque);
     iocb->s = s;
-    iocb->bh = qemu_bh_new(ide_trim_bh_cb, iocb);
+    iocb->bh = qemu_bh_new_guarded(ide_trim_bh_cb, iocb,
+                                   &DEVICE(dev)->mem_reentrancy_guard);
     iocb->ret = 0;
     iocb->qiov = qiov;
     iocb->i = -1;
diff --git a/hw/misc/imx_rngc.c b/hw/misc/imx_rngc.c
index 632c03779c..082c6980ad 100644
--- a/hw/misc/imx_rngc.c
+++ b/hw/misc/imx_rngc.c
@@ -228,8 +228,10 @@ static void imx_rngc_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 
     sysbus_init_irq(sbd, &s->irq);
-    s->self_test_bh = qemu_bh_new(imx_rngc_self_test, s);
-    s->seed_bh = qemu_bh_new(imx_rngc_seed, s);
+    s->self_test_bh = qemu_bh_new_guarded(imx_rngc_self_test, s,
+                                          &dev->mem_reentrancy_guard);
+    s->seed_bh = qemu_bh_new_guarded(imx_rngc_seed, s,
+                                     &dev->mem_reentrancy_guard);
 }
 
 static void imx_rngc_reset(DeviceState *dev)
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 43bb1f56ba..80a789f32b 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -914,7 +914,7 @@ static void mac_dbdma_realize(DeviceState *dev, Error **errp)
 {
     DBDMAState *s = MAC_DBDMA(dev);
 
-    s->bh = qemu_bh_new(DBDMA_run_bh, s);
+    s->bh = qemu_bh_new_guarded(DBDMA_run_bh, s, &dev->mem_reentrancy_guard);
 }
 
 static void mac_dbdma_class_init(ObjectClass *oc, void *data)
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3b66c97e3d..c9ba367c1b 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2919,7 +2919,8 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
         n->vqs[index].tx_vq =
             virtio_add_queue(vdev, n->net_conf.tx_queue_size,
                              virtio_net_handle_tx_bh);
-        n->vqs[index].tx_bh = qemu_bh_new(virtio_net_tx_bh, &n->vqs[index]);
+        n->vqs[index].tx_bh = qemu_bh_new_guarded(virtio_net_tx_bh, &n->vqs[index],
+                                                  &DEVICE(vdev)->mem_reentrancy_guard);
     }
 
     n->vqs[index].tx_waiting = 0;
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 2097fb1310..812246689c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4607,7 +4607,8 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
         QTAILQ_INSERT_TAIL(&(sq->req_list), &sq->io_req[i], entry);
     }
 
-    sq->bh = qemu_bh_new(nvme_process_sq, sq);
+    sq->bh = qemu_bh_new_guarded(nvme_process_sq, sq,
+                                 &DEVICE(sq->ctrl)->mem_reentrancy_guard);
 
     if (n->dbbuf_enabled) {
         sq->db_addr = n->dbbuf_dbs + (sqid << 3);
@@ -5253,7 +5254,8 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
         }
     }
     n->cq[cqid] = cq;
-    cq->bh = qemu_bh_new(nvme_post_cqes, cq);
+    cq->bh = qemu_bh_new_guarded(nvme_post_cqes, cq,
+                                 &DEVICE(cq->ctrl)->mem_reentrancy_guard);
 }
 
 static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index c485da792c..3de288b454 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1322,7 +1322,8 @@ static void mptsas_scsi_realize(PCIDevice *dev, Error **errp)
     }
     s->max_devices = MPTSAS_NUM_PORTS;
 
-    s->request_bh = qemu_bh_new(mptsas_fetch_requests, s);
+    s->request_bh = qemu_bh_new_guarded(mptsas_fetch_requests, s,
+                                        &DEVICE(dev)->mem_reentrancy_guard);
 
     scsi_bus_init(&s->bus, sizeof(s->bus), &dev->qdev, &mptsas_scsi_info);
 }
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index c97176110c..3c20b47ad0 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -193,7 +193,8 @@ static void scsi_dma_restart_cb(void *opaque, bool running, RunState state)
         AioContext *ctx = blk_get_aio_context(s->conf.blk);
         /* The reference is dropped in scsi_dma_restart_bh.*/
         object_ref(OBJECT(s));
-        s->bh = aio_bh_new(ctx, scsi_dma_restart_bh, s);
+        s->bh = aio_bh_new_guarded(ctx, scsi_dma_restart_bh, s,
+                                   &DEVICE(s)->mem_reentrancy_guard);
         qemu_bh_schedule(s->bh);
     }
 }
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index fa76696855..4de34536e9 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1184,7 +1184,8 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
         pcie_endpoint_cap_init(pci_dev, PVSCSI_EXP_EP_OFFSET);
     }
 
-    s->completion_worker = qemu_bh_new(pvscsi_process_completion_queue, s);
+    s->completion_worker = qemu_bh_new_guarded(pvscsi_process_completion_queue, s,
+                                               &DEVICE(pci_dev)->mem_reentrancy_guard);
 
     scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(pci_dev), &pvscsi_scsi_info);
     /* override default SCSI bus hotplug-handler, with pvscsi's one */
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 88f99c05d5..f013ded91e 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -937,7 +937,8 @@ static void usb_uas_realize(USBDevice *dev, Error **errp)
 
     QTAILQ_INIT(&uas->results);
     QTAILQ_INIT(&uas->requests);
-    uas->status_bh = qemu_bh_new(usb_uas_send_status_bh, uas);
+    uas->status_bh = qemu_bh_new_guarded(usb_uas_send_status_bh, uas,
+                                         &d->mem_reentrancy_guard);
 
     dev->flags |= (1 << USB_DEV_FLAG_IS_SCSI_STORAGE);
     scsi_bus_init(&uas->bus, sizeof(uas->bus), DEVICE(dev), &usb_uas_scsi_info);
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 8755e9cbb0..a0c4e782b2 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -1364,7 +1364,8 @@ static void dwc2_realize(DeviceState *dev, Error **errp)
     s->fi = USB_FRMINTVL - 1;
     s->eof_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, dwc2_frame_boundary, s);
     s->frame_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, dwc2_work_timer, s);
-    s->async_bh = qemu_bh_new(dwc2_work_bh, s);
+    s->async_bh = qemu_bh_new_guarded(dwc2_work_bh, s,
+                                      &dev->mem_reentrancy_guard);
 
     sysbus_init_irq(sbd, &s->irq);
 }
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index d4da8dcb8d..c930c60921 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2533,7 +2533,8 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp)
     }
 
     s->frame_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ehci_work_timer, s);
-    s->async_bh = qemu_bh_new(ehci_work_bh, s);
+    s->async_bh = qemu_bh_new_guarded(ehci_work_bh, s,
+                                      &dev->mem_reentrancy_guard);
     s->device = dev;
 
     s->vmstate = qemu_add_vm_change_state_handler(usb_ehci_vm_state_change, s);
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 8ac1175ad2..77baaa7a6b 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1190,7 +1190,7 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
                               USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL);
         }
     }
-    s->bh = qemu_bh_new(uhci_bh, s);
+    s->bh = qemu_bh_new_guarded(uhci_bh, s, &DEVICE(dev)->mem_reentrancy_guard);
     s->frame_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, uhci_frame_timer, s);
     s->num_ports_vmstate = NB_PORTS;
     QTAILQ_INIT(&s->queues);
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 176868d345..f500db85ab 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1141,7 +1141,8 @@ static void usb_host_nodev_bh(void *opaque)
 static void usb_host_nodev(USBHostDevice *s)
 {
     if (!s->bh_nodev) {
-        s->bh_nodev = qemu_bh_new(usb_host_nodev_bh, s);
+        s->bh_nodev = qemu_bh_new_guarded(usb_host_nodev_bh, s,
+                                          &DEVICE(s)->mem_reentrancy_guard);
     }
     qemu_bh_schedule(s->bh_nodev);
 }
@@ -1739,7 +1740,8 @@ static int usb_host_post_load(void *opaque, int version_id)
     USBHostDevice *dev = opaque;
 
     if (!dev->bh_postld) {
-        dev->bh_postld = qemu_bh_new(usb_host_post_load_bh, dev);
+        dev->bh_postld = qemu_bh_new_guarded(usb_host_post_load_bh, dev,
+                                             &DEVICE(dev)->mem_reentrancy_guard);
     }
     qemu_bh_schedule(dev->bh_postld);
     dev->bh_postld_pending = true;
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index fd7df599bc..39fbaaab16 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1441,8 +1441,10 @@ static void usbredir_realize(USBDevice *udev, Error **errp)
         }
     }
 
-    dev->chardev_close_bh = qemu_bh_new(usbredir_chardev_close_bh, dev);
-    dev->device_reject_bh = qemu_bh_new(usbredir_device_reject_bh, dev);
+    dev->chardev_close_bh = qemu_bh_new_guarded(usbredir_chardev_close_bh, dev,
+                                                &DEVICE(dev)->mem_reentrancy_guard);
+    dev->device_reject_bh = qemu_bh_new_guarded(usbredir_device_reject_bh, dev,
+                                                &DEVICE(dev)->mem_reentrancy_guard);
     dev->attach_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, usbredir_do_attach, dev);
 
     packet_id_queue_init(&dev->cancelled, dev, "cancelled");
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 66cb3f7c24..38ee660a30 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -1032,7 +1032,8 @@ static void usbback_alloc(struct XenLegacyDevice *xendev)
 
     QTAILQ_INIT(&usbif->req_free_q);
     QSIMPLEQ_INIT(&usbif->hotplug_q);
-    usbif->bh = qemu_bh_new(usbback_bh, usbif);
+    usbif->bh = qemu_bh_new_guarded(usbback_bh, usbif,
+                                    &DEVICE(xendev)->mem_reentrancy_guard);
 }
 
 static int usbback_free(struct XenLegacyDevice *xendev)
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 746f07c4d2..d60dd1f61e 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -908,8 +908,9 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
         precopy_add_notifier(&s->free_page_hint_notify);
 
         object_ref(OBJECT(s->iothread));
-        s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
-                                     virtio_ballloon_get_free_page_hints, s);
+        s->free_page_bh = aio_bh_new_guarded(iothread_get_aio_context(s->iothread),
+                                             virtio_ballloon_get_free_page_hints, s,
+                                             &dev->mem_reentrancy_guard);
     }
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index ccaa704530..f4a25de5ac 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1081,7 +1081,8 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
         vcrypto->vqs[i].dataq =
                  virtio_add_queue(vdev, 1024, virtio_crypto_handle_dataq_bh);
         vcrypto->vqs[i].dataq_bh =
-                 qemu_bh_new(virtio_crypto_dataq_bh, &vcrypto->vqs[i]);
+                 qemu_bh_new_guarded(virtio_crypto_dataq_bh, &vcrypto->vqs[i],
+                                     &dev->mem_reentrancy_guard);
         vcrypto->vqs[i].vcrypto = vcrypto;
     }
 
-- 
2.39.2


