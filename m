Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C406873E10C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:51:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlRd-00028m-E9; Mon, 26 Jun 2023 08:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLB-0002TT-3X
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlL7-00033e-0g
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0oeErSXAGqtdLlL9WwcgUJY5/rn+3CrQVAQVjQGGBg=;
 b=TjF6g1Bw9ukjDqP4XdECAE9P3dNPV9XAyNgj09483XVjKq3hhJ4jhCcz2NPJWWmE5l8Cx6
 ovnFUXd8CxEtNFqg8oQstVwAgXCT5AoEeyiRSEbnHjPCZRNJe0uBPHaKimxx0duP0xgSYj
 MHEj3xOHVtWgrmC23PK5R50gn5pRZJk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-ZTQjL5VXN1e6qL90vEbXEA-1; Mon, 26 Jun 2023 08:29:01 -0400
X-MC-Unique: ZTQjL5VXN1e6qL90vEbXEA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fa979d0c32so3382305e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782539; x=1690374539;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H0oeErSXAGqtdLlL9WwcgUJY5/rn+3CrQVAQVjQGGBg=;
 b=XKmePHPPh6Z3rOI5zs/h0o0hTaB6MxeM2AvBTFXsfhDZFHmZ+9k8lY9HNXIAmiWKWx
 NSED+8LXEKUBpZTExSTB4c99xBjdEumDEYC24SD9LiM6GmYeLQt7rdG58CHdlxTj4flP
 e9zA2UPT3DtoZ4075Q5u2ekH8beh3xQBmjcyoFxv6XMNKmKLeTgF29AjQj7h07FUyBH8
 KVyTnY2B7gFGI426iZGZ27fbQOyZ7m44cQ/V/790xk/NEwmsHCjRyfAeARXiGTehMhot
 +Wk3snhv67tDbiXxDf2kfkmhl4Q7B9pPHJAOcoBsklWwelq0Pn1QsSkVQkm+HHgNoAYZ
 Xl2Q==
X-Gm-Message-State: AC+VfDwBtM8BsjgXUZI7KLAbwbyH95gMHFf9rYRDFwa+ry+2bx6VmPQv
 cfAdAXk99UKr1dop73qjPvz+BtYpFldhch5nRquEb9YkkHBYi37VP92TtT0XF58JJvZ6SYqlh4r
 Hxx9cQhRh6cTvwRYjMBToCgqZDej7Z71dYJyp8OmnBb9F5dwqEJJpnP/Aq9O9b0E/GWIj
X-Received: by 2002:a5d:548e:0:b0:313:ed1b:3622 with SMTP id
 h14-20020a5d548e000000b00313ed1b3622mr2609368wrv.7.1687782539409; 
 Mon, 26 Jun 2023 05:28:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Bx3bavs2aCu91/d77ggZgWCvBtmfx6+k/B8f2EMglSXR5gq6hxYC72gxvvQm18LQof8eVaQ==
X-Received: by 2002:a5d:548e:0:b0:313:ed1b:3622 with SMTP id
 h14-20020a5d548e000000b00313ed1b3622mr2609347wrv.7.1687782539072; 
 Mon, 26 Jun 2023 05:28:59 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm1706603wrm.103.2023.06.26.05.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:58 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: [PULL 22/53] hw/virtio: Build various target-agnostic objects just
 once
Message-ID: <7a0903f7ea8ac7e5b3191c9a2cfd1751b153f48c.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The previous commit remove the unnecessary "virtio-access.h"
header. These files no longer have target-specific dependency.
Move them to the generic 'softmmu_ss' source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230524093744.88442-11-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/dataplane/meson.build |  2 +-
 hw/scsi/meson.build            | 10 +++++++---
 hw/virtio/meson.build          | 11 ++++++-----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/block/dataplane/meson.build b/hw/block/dataplane/meson.build
index 78d7ac1a11..025b3b061b 100644
--- a/hw/block/dataplane/meson.build
+++ b/hw/block/dataplane/meson.build
@@ -1,2 +1,2 @@
-specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+system_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
 specific_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index 43746700be..bb7d289aa0 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -1,5 +1,6 @@
 scsi_ss = ss.source_set()
 specific_scsi_ss = ss.source_set()
+virtio_scsi_ss = ss.source_set()
 specific_virtio_scsi_ss = ss.source_set()
 
 scsi_ss.add(files(
@@ -15,12 +16,15 @@ scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
 scsi_ss.add(when: 'CONFIG_MPTSAS_SCSI_PCI', if_true: files('mptsas.c', 'mptconfig.c', 'mptendian.c'))
 scsi_ss.add(when: 'CONFIG_VMW_PVSCSI_SCSI_PCI', if_true: files('vmw_pvscsi.c'))
 
-specific_virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
+virtio_scsi_ss.add(files('virtio-scsi-dataplane.c'))
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi.c'))
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi.c'))
+
+specific_virtio_scsi_ss.add(files('virtio-scsi.c'))
 specific_virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI_COMMON', if_true: files('vhost-scsi-common.c'))
-specific_virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi.c'))
-specific_virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi.c'))
 
 specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: specific_virtio_scsi_ss)
+scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
 
 specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
 
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index a6ea5beae7..f32b22f61b 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -2,13 +2,18 @@ softmmu_virtio_ss = ss.source_set()
 softmmu_virtio_ss.add(files('virtio-bus.c'))
 softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
 softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
 specific_virtio_ss = ss.source_set()
 specific_virtio_ss.add(files('virtio.c'))
 specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c'))
 
 if have_vhost
-  specific_virtio_ss.add(files('vhost.c', 'vhost-backend.c', 'vhost-iova-tree.c'))
+  softmmu_virtio_ss.add(files('vhost.c'))
+  specific_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
   if have_vhost_user
     specific_virtio_ss.add(files('vhost-user.c'))
   endif
@@ -20,20 +25,16 @@ else
 endif
 
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
 virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
-- 
MST


