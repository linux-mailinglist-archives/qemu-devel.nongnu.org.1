Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3E178D03F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:20:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nr-0001ZD-Vf; Tue, 29 Aug 2023 19:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qb5Ai-0008Ij-8l
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qb5Ae-0002dx-ST
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693340318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WVqktiTUcQBcBiM4xgYL3k9ZvbpXEjXZujEnZGRMXW4=;
 b=U2WCDQJPnQagwCJg0zSMrTKGEGLUrpmD9xYePo90xK44PDeDOtfDaTvfkJyE3hZvQ2BuZN
 x/pQobIJxeDXk862zJ+c1myX3BM8HuBtIwvI30W63k/wsrjPk6iKXTO8idjEs9CBAxx9HY
 GPJTHfsVhErs+X8aPA0uolsxVGUhHuQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-zU0q5KMnNcuASx94f1HsxQ-1; Tue, 29 Aug 2023 16:18:36 -0400
X-MC-Unique: zU0q5KMnNcuASx94f1HsxQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993d7ca4607so326938666b.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693340315; x=1693945115;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WVqktiTUcQBcBiM4xgYL3k9ZvbpXEjXZujEnZGRMXW4=;
 b=MRlI2HS1v3rz9tBFokYtpkxHwOngQpDzuZl1hImInOpKy9ugGmkZGoITVdX+T9+YUT
 XYzTtC0aCMqDr5PpE7OOmW6sjWke7Ijaw+qFJsuZPfxtUMrFeetowcsZeBFL7ftdAvlg
 6EJfbKDETmMeVTG1xtefkVn8OCD/qO9MWXbHq1a9fXtEIzO9dzntG1H2mvSuafb7Q9yb
 BvZh0WnY9e7NxhrT8lFiHIi7pCmN3+JdS7M70yTHsXeBwgLHnzF7mStc4+RY8so5IrD+
 DKaIzo8OJCRDTFwsd3oxX8s2W4etAKBcARiTyFBGtDOqMg6CkGbJq9HMNASFuBwGFmm/
 p5Eg==
X-Gm-Message-State: AOJu0YzHT6Es9LpWREQjJRBZBy9HMOPtyG/PaCawVdNW0mJNCFJ/ass5
 /vc16OnNX8DBOJYFO8wZVqXIB2vP4DEvr6Y98Oecc43PDtrvJYVcq+ImzJiDbOo9bAsqv0eRlOX
 8Krl0lVdx2N/7UNs=
X-Received: by 2002:a17:906:1ba9:b0:9a1:c4ba:c04c with SMTP id
 r9-20020a1709061ba900b009a1c4bac04cmr67889ejg.31.1693340315133; 
 Tue, 29 Aug 2023 13:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf9MuW6SvOFY6ZPPQE3S9ndyrHJhowRlQRl8vkkuLoBj7vKwTF2gmm0V936OXeuwOss0xzJw==
X-Received: by 2002:a17:906:1ba9:b0:9a1:c4ba:c04c with SMTP id
 r9-20020a1709061ba900b009a1c4bac04cmr67880ejg.31.1693340314848; 
 Tue, 29 Aug 2023 13:18:34 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 gh20-20020a170906e09400b0099bcb44493fsm6389842ejb.147.2023.08.29.13.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 13:18:34 -0700 (PDT)
Date: Tue, 29 Aug 2023 16:18:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Gowtham Siddarth <gowtham.siddarth@arm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Message-ID: <20230829161732-mutt-send-email-mst@kernel.org>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
 <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
 <20230829093909-mutt-send-email-mst@kernel.org>
 <43653986-c04f-0076-637b-9061f9702f77@linaro.org>
 <20230829130617-mutt-send-email-mst@kernel.org>
 <ff230439-5d76-1f50-a25a-1fd666c3f369@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff230439-5d76-1f50-a25a-1fd666c3f369@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 29, 2023 at 10:05:47PM +0200, Marcin Juszkiewicz wrote:
> W dniu 29.08.2023 o 19:07, Michael S. Tsirkin pisze:
> 
> > No - it depends on secondart bus type and only applies to bridges.
> > Also we need compat machinery.
> > Marcin could you pls test the following?
> 
> Works fine:
> 
>  822 : Check Type 1 config header rules           : Result:  PASS

Thanks! Now if possible I'd like to ask you to run the following test
with both default machine and 8.1 machine types.
With default should pass with 8.1 should fail as before.

Thanks!

diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index ea54a81a15..5cd452115a 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -77,6 +77,9 @@ struct PCIBridge {
 
     pci_map_irq_fn map_irq;
     const char *bus_name;
+
+    /* SLT is RO for PCIE to PCIE bridges, but old QEMU versions had it RW */
+    bool pcie_writeable_slt_bug;
 };
 
 #define PCI_BRIDGE_DEV_PROP_CHASSIS_NR "chassis_nr"
diff --git a/hw/core/machine.c b/hw/core/machine.c
index da699cf4e1..d665c79de3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,7 +39,9 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-pci.h"
 
-GlobalProperty hw_compat_8_1[] = {};
+GlobalProperty hw_compat_8_1[] = {
+    { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
+};
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 
 GlobalProperty hw_compat_8_0[] = {
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index e7b9345615..6a4e38856d 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -38,6 +38,7 @@
 #include "qapi/error.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/acpi/pci.h"
+#include "hw/qdev-properties.h"
 
 /* PCI bridge subsystem vendor ID helper functions */
 #define PCI_SSVID_SIZEOF        8
@@ -385,6 +386,11 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     pci_bridge_region_init(br);
     QLIST_INIT(&sec_bus->child);
     QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
+
+    /* For express secondary buses, secondary latency timer is RO 0 */
+    if (pci_bus_is_express(sec_bus) && !br->pcie_writeable_slt_bug) {
+        dev->wmask[PCI_SEC_LATENCY_TIMER] = 0;
+    }
 }
 
 /* default qdev clean up function for PCI-to-PCI bridge */
@@ -466,10 +472,18 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
     return 0;
 }
 
+static Property pci_bridge_properties[] = {
+    DEFINE_PROP_BOOL("x-pci-express-writeable-slt-bug", PCIBridge,
+                     pcie_writeable_slt_bug, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pci_bridge_class_init(ObjectClass *klass, void *data)
 {
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
+    DeviceClass *k = DEVICE_CLASS(klass);
 
+    device_class_set_props(k, pci_bridge_properties);
     adevc->build_dev_aml = build_pci_bridge_aml;
 }
 


