Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 674AEB2F2AC
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Aug 2025 10:47:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0vx-0002tD-Fh; Thu, 21 Aug 2025 04:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0vC-0002Q0-9j
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0uz-0000nC-NF
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755765896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P2FPdADMEMHNFhxXzuVtDKfuv8H3gugQt9Ko65fK9pw=;
 b=jALVSIOFTNPQXNF/CHEK6TFt01rf+BIligtN81DQB8RRTrcZgyRCsJu0MDwn1rWkXm1KK/
 L5nk7/4TYVoeTkBx9+IolAcyUriIpzRb4ZiUAf4ge/mXbnEx1JFxXlZ4JudD9rk/9l6pXq
 zPVN/Vx7Tm/+xXTc5XtkA5Hjylst2fc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-jXcm9PyOMJCM_1ktU_ORhQ-1; Thu, 21 Aug 2025 04:44:55 -0400
X-MC-Unique: jXcm9PyOMJCM_1ktU_ORhQ-1
X-Mimecast-MFC-AGG-ID: jXcm9PyOMJCM_1ktU_ORhQ_1755765894
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24458027f67so17415915ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755765893; x=1756370693;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2FPdADMEMHNFhxXzuVtDKfuv8H3gugQt9Ko65fK9pw=;
 b=GOQqKtTtco0vtdollOCB5B3ADSB+7v0tu4RsGr35LEfekZn0AMnY9KaHT+F3fUipAE
 QwFoJ9Lc9j4n3Q7LaXDUp1f6tk3HbFTlA/K4AekR5LMvNJ1Jp6IsvXdBBM8JCDHmw5/d
 8nuPoQqwF0aV1iofZ4es/mB7bkqPdzzWsdMqTe0jOXY1bqKnR3M1E+QCNz8bx5FuhndF
 elv0WhkWONu/3czC/8uXFEEUcYx3JFQjT1qTXzPhKCeDfMRAdyWojfcbs0P+F9Tc+4fT
 cyXPTOMIkwVWsto/6kVKO7NvDnFtIA76beHsfvGtSgG5UhJ82Ouo+co8nZ/DAGpvUQQI
 lyKg==
X-Gm-Message-State: AOJu0YzhCFZzeFSPlF5jL+3K9nv8N7XCCWgQsiuosuHEDq9P7qckvpXJ
 Swgrv4qKJH0fa0RM2lPcyW4eLCb8TB5rBEThviHp8rHwDoHMYUZIbuhc/rQT+20FaMWwz/mNSLJ
 aouUYknaWnR2fd+XaZVDQKvN2o5/lgt5Jz/FchkzQdow1q/ue/jZ8pZzG
X-Gm-Gg: ASbGncvJsSeYQujcXMO7k9TNxLMLxHHR2j+Icme81P31OK9UvBH5AEUkyxWcHTeNZ5i
 a7hHFJJISD1C/ybVlkoFpeKZCKS4/C5r4bpH/xq0K13fQJkk0KdSSCG4GntLo4iI3cZlu3G9XTf
 eWnGlToB8algXJp0wMtdAyrqEwOnw5mslHGIIhyed6fGgAMNGiCPef03dsMW4aWp1vQg3jI7/SO
 zUACcH0PcZPg3HZW5QJYcuHpqcNrhxl2RCbGFiVvKbnK6L0zj96hk3udQw+PVZ5VfivpbcTvCjT
 VrIxFCXI0W6jvpuZnBTfNO0F59PfKVGaJkqElUP2+ShaxYCtpqND
X-Received: by 2002:a17:902:ce88:b0:240:8cec:4823 with SMTP id
 d9443c01a7336-245fedd00e8mr20738095ad.41.1755765892761; 
 Thu, 21 Aug 2025 01:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9fNSfctYIAjAJ6cSV0NJJg4L74WBW3lxCcdX9jcHZDhcjwAe27dHBn7VBA6tiMbbjfMAcYg==
X-Received: by 2002:a17:902:ce88:b0:240:8cec:4823 with SMTP id
 d9443c01a7336-245fedd00e8mr20737785ad.41.1755765892177; 
 Thu, 21 Aug 2025 01:44:52 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:44:51 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:13:56 +0530
Subject: [PATCH v12 02/27] migration: push Error **errp into
 vmstate_load_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-2-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=28913; i=armenon@redhat.com;
 h=from:subject:message-id; bh=++rhMn5BRu5/6ldMZ/sKwurDc5PN18dU+iSJxVKP9Vs=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayO8mFz7bveCImfYIzzMaV94XJlcWX5nZYPFkbWq955
 +f7qmdnO0pZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAEykoJHhf5JDissUb5//Sx4p
 X40+tZO3UHb3jc1XU9N2nnoY/+64sTHDX9lHMzqmH2bMfL3bzct3Q5Z9/eFVd7sUJpxXeKh8qZr
 Fig0A
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that vmstate_load_state() must report an error
in errp, in case of failure.

The errors are temporarily reported using warn_report_err().
This is removed in the subsequent patches in this series,
when we are actually able to propagate the error to the calling
function using errp. Whereas, if we want the function to exit on
error, then error_fatal is passed.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/display/virtio-gpu.c     |  2 +-
 hw/pci/pci.c                |  3 ++-
 hw/s390x/virtio-ccw.c       |  2 +-
 hw/scsi/spapr_vscsi.c       |  4 ++-
 hw/vfio/pci.c               |  5 +++-
 hw/virtio/virtio-mmio.c     |  3 ++-
 hw/virtio/virtio-pci.c      |  2 +-
 hw/virtio/virtio.c          |  7 +++--
 include/migration/vmstate.h |  2 +-
 migration/cpr.c             |  3 +--
 migration/savevm.c          |  8 ++++--
 migration/vmstate-types.c   | 22 +++++++++++----
 migration/vmstate.c         | 65 +++++++++++++++++++++++++++++++--------------
 tests/unit/test-vmstate.c   | 63 ++++++++++++++++++++++++++++++++++++-------
 ui/vdagent.c                |  5 +++-
 15 files changed, 147 insertions(+), 49 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5dc31bc6bfb0272e29a4364ab10de2595a4bedf7 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     }
 
     /* load & apply scanout state */
-    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
+    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
 
     return 0;
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..6be932d3bb67ff0c4808707db2a7b6378a90e82b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -934,7 +934,8 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
 int pci_device_load(PCIDevice *s, QEMUFile *f)
 {
     int ret;
-    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id);
+    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
+                             &error_fatal);
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
     return ret;
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index d2f85b39f30f7fc82e0c600144c0a958e1269b2c..6a9641a03d5d3a38a4de7ceb9deffc0cc303bcff 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
+    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
 }
 
 static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 20f70fb2729de78b9636a6b8c869695dab4f8902..8622419497db650523d51bcb41557bbca254eaa3 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -642,15 +642,17 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     VSCSIState *s = VIO_SPAPR_VSCSI_DEVICE(bus->qbus.parent);
     vscsi_req *req;
     int rc;
+    Error *local_err = NULL;
 
     assert(sreq->tag < VSCSI_REQ_LIMIT);
     req = &s->reqs[sreq->tag];
     assert(!req->active);
 
     memset(req, 0, sizeof(*req));
-    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
+    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &local_err);
     if (rc) {
         fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->tag);
+        warn_report_err(local_err);
         return NULL;
     }
     assert(req->active);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fa692c1a32bcfa4e4939e5fcb64f2bf19905b3b..a65e34b6979eadfa0851666aeae7cf731a00fa40 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2790,13 +2790,16 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
     PCIDevice *pdev = &vdev->pdev;
     pcibus_t old_addr[PCI_NUM_REGIONS - 1];
     int bar, ret;
+    Error *local_err = NULL;
 
     for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
         old_addr[bar] = pdev->io_regions[bar].addr;
     }
 
-    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
+    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1,
+                             &local_err);
     if (ret) {
+        warn_report_err(local_err);
         return ret;
     }
 
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..0a688909fc606a3c9fde933667ae8c309ab527d0 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -34,6 +34,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "trace.h"
+#include "qapi/error.h"
 
 static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
 {
@@ -619,7 +620,7 @@ static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
-    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
+    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &error_fatal);
 }
 
 static bool virtio_mmio_has_extra_state(DeviceState *opaque)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 767216d795998708f5716a23ae16c79cd90ff489..b04faa1e5c91b5cef40e54ec41d92422d16bfc13 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
 
-    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
+    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &error_fatal);
 }
 
 static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e013fc254899c4e55cff1f76a6112a4..419f3516c9f0a3df43831eebc77aa1e6dfcd0f41 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3235,6 +3235,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    Error *local_err = NULL;
 
     /*
      * We poison the endianness to ensure it does not get used before
@@ -3327,15 +3328,17 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
 
     if (vdc->vmsd) {
-        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id);
+        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, &local_err);
         if (ret) {
+            warn_report_err(local_err);
             return ret;
         }
     }
 
     /* Subsections */
-    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1);
+    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1, &local_err);
     if (ret) {
+        warn_report_err(local_err);
         return ret;
     }
 
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..056781b1c21e737583f081594d9f88b32adfd674 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1196,7 +1196,7 @@ extern const VMStateInfo vmstate_info_qlist;
     }
 
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, int version_id);
+                       void *opaque, int version_id, Error **errp);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc);
 int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
diff --git a/migration/cpr.c b/migration/cpr.c
index 42ad0b0d500e5de57faf0c6517e216b2d1c0cacf..8abb6db76d2474157f804ece4c35ebfc8c22d21a 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -233,9 +233,8 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
         return -ENOTSUP;
     }
 
-    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
+    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
     if (ret) {
-        error_setg(errp, "vmstate_load_state error %d", ret);
         qemu_fclose(f);
         return ret;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index fabbeb296ae987d0c06ba6dafda63720205fecfd..464e8b778404a642bf60f368205f5e6fa59118ba 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -969,7 +969,8 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
     if (!se->vmsd) {         /* Old style */
         return se->ops->load_state(f, se->opaque, se->load_version_id);
     }
-    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id);
+    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
+                              &error_fatal);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2817,6 +2818,7 @@ static int qemu_loadvm_state_header(QEMUFile *f)
 {
     unsigned int v;
     int ret;
+    Error *local_err = NULL;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
@@ -2839,9 +2841,11 @@ static int qemu_loadvm_state_header(QEMUFile *f)
             error_report("Configuration section missing");
             return -EINVAL;
         }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 &local_err);
 
         if (ret) {
+            warn_report_err(local_err);
             return ret;
         }
     }
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 741a588b7e18c6d37724b08a0101edc8bc74a0a5..f41670cc853c5b41ccc8def354886a8e5c1451fd 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -19,6 +19,7 @@
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "trace.h"
+#include "qapi/error.h"
 
 /* bool */
 
@@ -543,13 +544,17 @@ static int get_tmp(QEMUFile *f, void *pv, size_t size,
                    const VMStateField *field)
 {
     int ret;
+    Error *local_err = NULL;
     const VMStateDescription *vmsd = field->vmsd;
     int version_id = field->version_id;
     void *tmp = g_malloc(size);
 
     /* Writes the parent field which is at the start of the tmp */
     *(void **)tmp = pv;
-    ret = vmstate_load_state(f, vmsd, tmp, version_id);
+    ret = vmstate_load_state(f, vmsd, tmp, version_id, &local_err);
+    if (ret < 0) {
+        warn_report_err(local_err);
+    }
     g_free(tmp);
     return ret;
 }
@@ -626,6 +631,7 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
                       const VMStateField *field)
 {
     int ret = 0;
+    Error *local_err = NULL;
     const VMStateDescription *vmsd = field->vmsd;
     /* size of a QTAILQ element */
     size_t size = field->size;
@@ -649,8 +655,9 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
 
     while (qemu_get_byte(f)) {
         elm = g_malloc(size);
-        ret = vmstate_load_state(f, vmsd, elm, version_id);
+        ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
         if (ret) {
+            warn_report_err(local_err);
             return ret;
         }
         QTAILQ_RAW_INSERT_TAIL(pv, elm, entry_offset);
@@ -772,6 +779,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
     GTree *tree = *pval;
     void *key, *val;
     int ret = 0;
+    Error *local_err = NULL;
 
     /* in case of direct key, the key vmsd can be {}, ie. check fields */
     if (!direct_key && version_id > key_vmsd->version_id) {
@@ -803,18 +811,20 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
             key = (void *)(uintptr_t)qemu_get_be64(f);
         } else {
             key = g_malloc0(key_size);
-            ret = vmstate_load_state(f, key_vmsd, key, version_id);
+            ret = vmstate_load_state(f, key_vmsd, key, version_id, &local_err);
             if (ret) {
                 error_report("%s : failed to load %s (%d)",
                              field->name, key_vmsd->name, ret);
+                warn_report_err(local_err);
                 goto key_error;
             }
         }
         val = g_malloc0(val_size);
-        ret = vmstate_load_state(f, val_vmsd, val, version_id);
+        ret = vmstate_load_state(f, val_vmsd, val, version_id, &local_err);
         if (ret) {
             error_report("%s : failed to load %s (%d)",
                          field->name, val_vmsd->name, ret);
+            warn_report_err(local_err);
             goto val_error;
         }
         g_tree_insert(tree, key, val);
@@ -872,6 +882,7 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
                      const VMStateField *field)
 {
     int ret = 0;
+    Error *local_err = NULL;
     const VMStateDescription *vmsd = field->vmsd;
     /* size of a QLIST element */
     size_t size = field->size;
@@ -892,10 +903,11 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
 
     while (qemu_get_byte(f)) {
         elm = g_malloc(size);
-        ret = vmstate_load_state(f, vmsd, elm, version_id);
+        ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
         if (ret) {
             error_report("%s: failed to load %s (%d)", field->name,
                          vmsd->name, ret);
+            warn_report_err(local_err);
             g_free(elm);
             return ret;
         }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 3d9f284700368e2fd573d5d77b7f7ab88008cc91..6324e5b17addcd1b4f2fcdddbd47c3e4befc1d50 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -132,30 +132,34 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
 }
 
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, int version_id)
+                       void *opaque, int version_id, Error **errp)
 {
+    ERRP_GUARD();
     const VMStateField *field = vmsd->fields;
     int ret = 0;
-    Error *local_err = NULL;
 
     trace_vmstate_load_state(vmsd->name, version_id);
     if (version_id > vmsd->version_id) {
-        error_report("%s: incoming version_id %d is too new "
-                     "for local version_id %d",
-                     vmsd->name, version_id, vmsd->version_id);
+        error_setg(errp, "%s: incoming version_id %d is too new "
+                   "for local version_id %d",
+                   vmsd->name, version_id, vmsd->version_id);
         trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
         return -EINVAL;
     }
     if  (version_id < vmsd->minimum_version_id) {
-        error_report("%s: incoming version_id %d is too old "
-                     "for local minimum version_id  %d",
-                     vmsd->name, version_id, vmsd->minimum_version_id);
+        error_setg(errp, "%s: incoming version_id %d is too old "
+                   "for local minimum version_id %d",
+                   vmsd->name, version_id, vmsd->minimum_version_id);
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
     if (vmsd->pre_load) {
         ret = vmsd->pre_load(opaque);
         if (ret) {
+            error_setg(errp, "pre load hook failed for: '%s', "
+                       "version_id: %d, minimum version_id: %d, ret: %d",
+                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
+                       ret);
             return ret;
         }
     }
@@ -193,13 +197,21 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 
                 if (inner_field->flags & VMS_STRUCT) {
                     ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->vmsd->version_id);
+                                             inner_field->vmsd->version_id,
+                                             errp);
                 } else if (inner_field->flags & VMS_VSTRUCT) {
                     ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->struct_version_id);
+                                             inner_field->struct_version_id,
+                                             errp);
                 } else {
                     ret = inner_field->info->get(f, curr_elem, size,
                                                  inner_field);
+                    if (ret < 0) {
+                        error_setg(errp,
+                                   "Failed to load element of type %s for %s: "
+                                   "%d", inner_field->info->name,
+                                   inner_field->name, ret);
+                    }
                 }
 
                 /* If we used a fake temp field.. free it now */
@@ -209,31 +221,43 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 
                 if (ret >= 0) {
                     ret = qemu_file_get_error(f);
+                    if (ret < 0) {
+                        error_setg(errp,
+                                   "Failed to load %s state: stream error: %d",
+                                   vmsd->name, ret);
+                    }
                 }
                 if (ret < 0) {
                     qemu_file_set_error(f, ret);
-                    error_report("Failed to load %s:%s", vmsd->name,
-                                 field->name);
+                    error_prepend(errp,
+                                  "Failed to load %s/%s version_id: %d: ",
+                                  vmsd->name, field->name, vmsd->version_id);
                     trace_vmstate_load_field_error(field->name, ret);
                     return ret;
                 }
             }
         } else if (field->flags & VMS_MUST_EXIST) {
-            error_report("Input validation failed: %s/%s",
-                         vmsd->name, field->name);
+            error_setg(errp, "Input validation failed: %s/%s version_id: %d",
+                       vmsd->name, field->name, vmsd->version_id);
             return -1;
         }
         field++;
     }
     assert(field->flags == VMS_END);
-    ret = vmstate_subsection_load(f, vmsd, opaque, &local_err);
+    ret = vmstate_subsection_load(f, vmsd, opaque, errp);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
-        warn_report_err(local_err);
         return ret;
     }
     if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
+        if (ret < 0) {
+            error_setg(errp,
+                       "post load hook failed for: %s, version_id: %d, "
+                       "minimum_version: %d, ret: %d",
+                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
+                       ret);
+        }
     }
     trace_vmstate_load_state_end(vmsd->name, "end", ret);
     return ret;
@@ -570,6 +594,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, Error **errp)
 {
+    ERRP_GUARD();
     trace_vmstate_subsection_load(vmsd->name);
 
     while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
@@ -609,12 +634,12 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_skip(f, len); /* idstr */
         version_id = qemu_get_be32(f);
 
-        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
+        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id, errp);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
-            error_setg(errp,
-                       "Loading VM subsection '%s' in '%s' failed: %d",
-                       idstr, vmsd->name, ret);
+            error_prepend(errp,
+                          "Loading VM subsection '%s' in '%s' failed: %d: ",
+                          idstr, vmsd->name, ret);
             return ret;
         }
     }
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 63f28f26f45691a70936d33e7341d16477a3471f..cfab58c7f45ba50f70af164c3e58b01aaf9cc656 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -30,6 +30,7 @@
 #include "../migration/savevm.h"
 #include "qemu/module.h"
 #include "io/channel-file.h"
+#include "qapi/error.h"
 
 static int temp_fd;
 
@@ -108,14 +109,16 @@ static int load_vmstate_one(const VMStateDescription *desc, void *obj,
 {
     QEMUFile *f;
     int ret;
+    Error *local_err = NULL;
 
     f = open_test_file(true);
     qemu_put_buffer(f, wire, size);
     qemu_fclose(f);
 
     f = open_test_file(false);
-    ret = vmstate_load_state(f, desc, obj, version);
+    ret = vmstate_load_state(f, desc, obj, version, &local_err);
     if (ret) {
+        warn_report_err(local_err);
         g_assert(qemu_file_get_error(f));
     } else{
         g_assert(!qemu_file_get_error(f));
@@ -355,6 +358,8 @@ static const VMStateDescription vmstate_versioned = {
 
 static void test_load_v1(void)
 {
+    Error *local_err = NULL;
+    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 30,             /* c */
@@ -365,7 +370,10 @@ static void test_load_v1(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .b = 200, .e = 500, .f = 600 };
-    vmstate_load_state(loading, &vmstate_versioned, &obj, 1);
+    ret = vmstate_load_state(loading, &vmstate_versioned, &obj, 1, &local_err);
+    if (ret < 0) {
+        warn_report_err(local_err);
+    }
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 200);
@@ -378,6 +386,8 @@ static void test_load_v1(void)
 
 static void test_load_v2(void)
 {
+    Error *local_err = NULL;
+    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 20,             /* b */
@@ -391,7 +401,10 @@ static void test_load_v2(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj;
-    vmstate_load_state(loading, &vmstate_versioned, &obj, 2);
+    ret = vmstate_load_state(loading, &vmstate_versioned, &obj, 2, &local_err);
+    if (ret < 0) {
+        warn_report_err(local_err);
+    }
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
     g_assert_cmpint(obj.c, ==, 30);
@@ -467,6 +480,8 @@ static void test_save_skip(void)
 
 static void test_load_noskip(void)
 {
+    Error *local_err = NULL;
+    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 20,             /* b */
@@ -480,7 +495,10 @@ static void test_load_noskip(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .skip_c_e = false };
-    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
+    ret = vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &local_err);
+    if (ret < 0) {
+        warn_report_err(local_err);
+    }
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
@@ -493,6 +511,8 @@ static void test_load_noskip(void)
 
 static void test_load_skip(void)
 {
+    Error *local_err = NULL;
+    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 20,             /* b */
@@ -504,7 +524,10 @@ static void test_load_skip(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .skip_c_e = true, .c = 300, .e = 500 };
-    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
+    ret = vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &local_err);
+    if (ret < 0) {
+        warn_report_err(local_err);
+    }
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
@@ -744,6 +767,8 @@ static void test_save_q(void)
 
 static void test_load_q(void)
 {
+    int ret;
+    Error *local_err = NULL;
     TestQtailq obj_q = {
         .i16 = -512,
         .i32 = 70000,
@@ -773,7 +798,10 @@ static void test_load_q(void)
     TestQtailq tgt;
 
     QTAILQ_INIT(&tgt.q);
-    vmstate_load_state(fload, &vmstate_q, &tgt, 1);
+    ret = vmstate_load_state(fload, &vmstate_q, &tgt, 1, &local_err);
+    if (ret < 0) {
+        warn_report_err(local_err);
+    }
     char eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(tgt.i16, ==, obj_q.i16);
@@ -1115,6 +1143,8 @@ static void diff_iommu(TestGTreeIOMMU *iommu1, TestGTreeIOMMU *iommu2)
 
 static void test_gtree_load_domain(void)
 {
+    Error *local_err = NULL;
+    int ret;
     TestGTreeDomain *dest_domain = g_new0(TestGTreeDomain, 1);
     TestGTreeDomain *orig_domain = create_first_domain();
     QEMUFile *fload, *fsave;
@@ -1127,7 +1157,11 @@ static void test_gtree_load_domain(void)
 
     fload = open_test_file(false);
 
-    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1);
+    ret = vmstate_load_state(fload, &vmstate_domain, dest_domain, 1,
+                             &local_err);
+    if (ret < 0) {
+        warn_report_err(local_err);
+    }
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(orig_domain->id, ==, dest_domain->id);
@@ -1230,6 +1264,8 @@ static void test_gtree_save_iommu(void)
 
 static void test_gtree_load_iommu(void)
 {
+    Error *local_err = NULL;
+    int ret;
     TestGTreeIOMMU *dest_iommu = g_new0(TestGTreeIOMMU, 1);
     TestGTreeIOMMU *orig_iommu = create_iommu();
     QEMUFile *fsave, *fload;
@@ -1241,7 +1277,10 @@ static void test_gtree_load_iommu(void)
     qemu_fclose(fsave);
 
     fload = open_test_file(false);
-    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1);
+    ret = vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1, &local_err);
+    if (ret < 0) {
+        warn_report_err(local_err);
+    }
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(orig_iommu->id, ==, dest_iommu->id);
@@ -1363,6 +1402,8 @@ static void test_save_qlist(void)
 
 static void test_load_qlist(void)
 {
+    Error *local_err = NULL;
+    int ret;
     QEMUFile *fsave, *fload;
     TestQListContainer *orig_container = alloc_container();
     TestQListContainer *dest_container = g_new0(TestQListContainer, 1);
@@ -1376,7 +1417,11 @@ static void test_load_qlist(void)
     qemu_fclose(fsave);
 
     fload = open_test_file(false);
-    vmstate_load_state(fload, &vmstate_container, dest_container, 1);
+    ret = vmstate_load_state(fload, &vmstate_container, dest_container, 1,
+                             &local_err);
+    if (ret < 0) {
+        warn_report_err(local_err);
+    }
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(eof, ==, QEMU_VM_EOF);
diff --git a/ui/vdagent.c b/ui/vdagent.c
index c0746fe5b168fdc7aeb4866de2ba0c3387566649..bec728668de4d2410c3b741bcb0a21deb373dcd3 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -1001,6 +1001,7 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(pv);
     struct CBInfoArray cbinfo = {};
     int i, ret;
+    Error *local_err = NULL;
 
     if (!have_clipboard(vd)) {
         return 0;
@@ -1008,8 +1009,10 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
 
     vdagent_clipboard_peer_register(vd);
 
-    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0);
+    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0,
+                             &local_err);
     if (ret) {
+        warn_report_err(local_err);
         return ret;
     }
 

-- 
2.50.1


