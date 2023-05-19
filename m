Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C3709AAC
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01SA-0003AF-FV; Fri, 19 May 2023 10:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01S4-00037f-7y
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01S2-0003dV-Da
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scD/t6FKL2vSfOhKYpUs6/tNGVFI4PHgCamZz9KPYUk=;
 b=B5Z09pEtVuZWLNsxctTqqky+jRv3MY2dB81hs1DX/FsWACFcDVC/I7hfLxxqN8th+kzfI4
 L+IoY1EsMzUgjYnbWaq1UiQ20R5FEPjHBmUGk/3rt2etDgr+tQH3mGFpZtBS50qJZQknv5
 r2mOsS0myve/mX08fGWx+dmJdiWZGPU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-3GaB10ZTM7iP8JR1Zgy2iA-1; Fri, 19 May 2023 10:51:23 -0400
X-MC-Unique: 3GaB10ZTM7iP8JR1Zgy2iA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ac7e062911so17915711fa.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507882; x=1687099882;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scD/t6FKL2vSfOhKYpUs6/tNGVFI4PHgCamZz9KPYUk=;
 b=NovS4NwZP2VHUHg5HFWjB9K5wuwyRos6DIG8kaD4gEGWaUL4LOLiCo9k2QllXdDWdz
 1XlUtk9+vTcsVWxshVwOMruQXK3VvlezBfZhbQmc1HDjbq7LPhXo2x2D/m0UsjZoiHp6
 SfAlzQdrqe1uPSqrQsV9nUMLEDuOeUJYdgUfn/wv8RrAk0mvBMxTizBXPQrVnGcnvNCW
 WWSKgvom2tfgIW/8xiW5P9kjsacGcJe8cvqdes00hjmjeCZm2xpo2xpPtbFgkqISxRcN
 aCJ/K0fqdgO/GmnTZOjkqPbRk8i5GWKnr36CCLtHoYVONxYUL4T5d8q1k/yhEm0159zP
 U08Q==
X-Gm-Message-State: AC+VfDyXiVY7SyBk4nGv7rjD4MWk0fhUYP1tbhsEaihYqCzvJLrLAGfh
 Oj1e1wp/1Bdf5dQExFFgGr8MaemJDYQUMyOK2rT2VDT28+alyFjUpLD5EKyfrsvm0YKTfb+0L2K
 E4mU92bGbaqnzYilyWsffQopb8C2UI5YA2fdmHU+XjysXKZNyxZvaRdCyhm77ZzUfzL+T
X-Received: by 2002:ac2:489a:0:b0:4f3:a4ce:7ccd with SMTP id
 x26-20020ac2489a000000b004f3a4ce7ccdmr837224lfc.35.1684507881921; 
 Fri, 19 May 2023 07:51:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6L/auj6WCtEsR82SBz3AfLgfsHQKnDqe1Q4VCZa4CrmBkzQAu10udk/ot9EQqqkzog3ZBDog==
X-Received: by 2002:ac2:489a:0:b0:4f3:a4ce:7ccd with SMTP id
 x26-20020ac2489a000000b004f3a4ce7ccdmr837209lfc.35.1684507881652; 
 Fri, 19 May 2023 07:51:21 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 a6-20020a19f806000000b004f38260f196sm618728lff.218.2023.05.19.07.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:51:21 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Leonardo Bras <leobras@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 19/40] hw/pci: Disable PCI_ERR_UNCOR_MASK register for machine
 type < 8.0
Message-ID: <5ed3dabe57dd9f4c007404345e5f5bf0e347317f.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

From: Leonardo Bras <leobras@redhat.com>

Since it's implementation on v8.0.0-rc0, having the PCI_ERR_UNCOR_MASK
set for machine types < 8.0 will cause migration to fail if the target
QEMU version is < 8.0.0 :

qemu-system-x86_64: get_pci_config_device: Bad config data: i=0x10a read: 40 device: 0 cmask: ff wmask: 0 w1cmask:0
qemu-system-x86_64: Failed to load PCIDevice:config
qemu-system-x86_64: Failed to load e1000e:parent_obj
qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:02.0/e1000e'
qemu-system-x86_64: load of migration failed: Invalid argument

The above test migrated a 7.2 machine type from QEMU master to QEMU 7.2.0,
with this cmdline:

./qemu-system-x86_64 -M pc-q35-7.2 [-incoming XXX]

In order to fix this, property x-pcie-err-unc-mask was introduced to
control when PCI_ERR_UNCOR_MASK is enabled. This property is enabled by
default, but is disabled if machine type <= 7.2.

Fixes: 010746ae1d ("hw/pci/aer: Implement PCI_ERR_UNCOR_MASK register")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Leonardo Bras <leobras@redhat.com>
Message-Id: <20230503002701.854329-1-leobras@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1576
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h |  2 ++
 hw/core/machine.c    |  1 +
 hw/pci/pci.c         |  2 ++
 hw/pci/pcie_aer.c    | 11 +++++++----
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 935b4b91b4..e6d0574a29 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -207,6 +207,8 @@ enum {
     QEMU_PCIE_EXTCAP_INIT = (1 << QEMU_PCIE_EXTCAP_INIT_BITNR),
 #define QEMU_PCIE_CXL_BITNR 10
     QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
+#define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
+    QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
 };
 
 typedef struct PCIINTxRoute {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 47a34841a5..07f763eb2e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -48,6 +48,7 @@ GlobalProperty hw_compat_7_2[] = {
     { "e1000e", "migrate-timadj", "off" },
     { "virtio-mem", "x-early-migration", "false" },
     { "migration", "x-preempt-pre-7-2", "true" },
+    { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
 };
 const size_t hw_compat_7_2_len = G_N_ELEMENTS(hw_compat_7_2);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3a0107758c..1cc7c89036 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -79,6 +79,8 @@ static Property pci_props[] = {
     DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
                        failover_pair_id),
     DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
+    DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
+                    QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 103667c368..374d593ead 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -112,10 +112,13 @@ int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
 
     pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
                  PCI_ERR_UNC_SUPPORTED);
-    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
-                 PCI_ERR_UNC_MASK_DEFAULT);
-    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
-                 PCI_ERR_UNC_SUPPORTED);
+
+    if (dev->cap_present & QEMU_PCIE_ERR_UNC_MASK) {
+        pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
+                     PCI_ERR_UNC_MASK_DEFAULT);
+        pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
+                     PCI_ERR_UNC_SUPPORTED);
+    }
 
     pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
                  PCI_ERR_UNC_SEVERITY_DEFAULT);
-- 
MST


