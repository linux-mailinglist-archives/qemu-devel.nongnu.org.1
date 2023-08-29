Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D344578CA44
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:08:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2Cu-0003d1-Fi; Tue, 29 Aug 2023 13:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qb2CD-00029e-Ba
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qb2C2-0006ZI-89
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693328870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsdwjJWnzcC4cYKgduf285KeubUrHe3kpDfHcWRgW7o=;
 b=L5o/XgMHNkGbCqtgiG1Rwqw8fjwBiJAmydcffvo0T14G9sOt3MFQb5wHZKc2F0X/RrxJCF
 9ZFqOdRz1lX7r6LwhAPZoYoYhXBhzIaO8C/1m2+CVLxauRFhXS8REzcEjXMzVNjn/A3X7t
 EmDnODGk6+Sx6JoUhF5Z8JsVnJI0E4I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-qAQVR3aoMa-ad6scVs2qWw-1; Tue, 29 Aug 2023 13:07:48 -0400
X-MC-Unique: qAQVR3aoMa-ad6scVs2qWw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-52a3e9c53e7so3742946a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328867; x=1693933667;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZsdwjJWnzcC4cYKgduf285KeubUrHe3kpDfHcWRgW7o=;
 b=dTyYsWd7v5FDwjW/6vzsP/P+1Hg1juZMa/xio28B0wbLc1MOa34t65vKlS5ZzUZu83
 SlBQ7PmuS1wYNK20j+at+djF4/gQRRRvK5wAK3Kf72OaL6DV3UpIIUlay1TDBvWO+D3Z
 h7PI3NTIVNuIV+gbWjnRTN1Ilv0bb/dAueGvQuZbYU88pS4hmV703rtAuSPtFes7KH8B
 hBTr4OuhykUZXcQeRT/EU6UNhUYotpsKSUfwyW7PS2iC9LSksWRrVswNSSgUP+nYBPJn
 taYzSGahO6S231are44AwQKAKzZ3Z7yD+WQlWx1UkpL7zROL8nhvKDstc860xPitTkP2
 JLsw==
X-Gm-Message-State: AOJu0Yyjwb65TWd3VWwxv1+W29/FthmK+OVFYX7gGedOnHt3YmGlAJuf
 XFsBORxa7WZAy9ddEYvSBfkKnrDbcFEhySSFBAGXinFpI7hcX68YkT8cGfvDBBLBbzAYFWVaaQ1
 7RkXC6xYDJdjfxuM=
X-Received: by 2002:aa7:c2cd:0:b0:526:9626:e37d with SMTP id
 m13-20020aa7c2cd000000b005269626e37dmr20690207edp.37.1693328867153; 
 Tue, 29 Aug 2023 10:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+miHfYERIK8IowSAuce+W7kxjob6E2i0R5RaIVY/ZLflhhXl111LIPHVdKYPQGI8obMv1tQ==
X-Received: by 2002:aa7:c2cd:0:b0:526:9626:e37d with SMTP id
 m13-20020aa7c2cd000000b005269626e37dmr20690195edp.37.1693328866760; 
 Tue, 29 Aug 2023 10:07:46 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 r6-20020aa7d146000000b0051dd19d6d6esm5899732edo.73.2023.08.29.10.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 10:07:46 -0700 (PDT)
Date: Tue, 29 Aug 2023 13:07:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel@nongnu.org, Gowtham Siddarth <gowtham.siddarth@arm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Message-ID: <20230829130617-mutt-send-email-mst@kernel.org>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
 <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
 <20230829093909-mutt-send-email-mst@kernel.org>
 <43653986-c04f-0076-637b-9061f9702f77@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43653986-c04f-0076-637b-9061f9702f77@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Aug 29, 2023 at 04:04:27PM +0200, Philippe Mathieu-Daudé wrote:
> On 29/8/23 15:48, Michael S. Tsirkin wrote:
> > On Tue, Aug 29, 2023 at 02:14:51PM +0100, Peter Maydell wrote:
> > > On Tue, 29 Aug 2023 at 12:40, Marcin Juszkiewicz
> > > <marcin.juszkiewicz@linaro.org> wrote:
> > > > 
> > > > I am working on aarch64/sbsa-ref machine so people can have virtual
> > > > machine to test their OS against something reminding standards compliant
> > > > system.
> > > > 
> > > > One of tools I use is BSA ACS (Base System Architecture - Architecture
> > > > Compliance Suite) [1] written by Arm. It runs set of tests to check does
> > > > system conforms to BSA specification.
> > > > 
> > > > 1. https://github.com/ARM-software/bsa-acs
> > > > 
> > > > 
> > > > SBSA-ref goes better and better, yet still we have some issues. One of
> > > > them is test 822 ("Check Type 1 config header rules") which fails on
> > > > each PCIe root port device:
> > > > 
> > > > BDF 0x400 : SLT attribute mismatch: 0xFF020100 instead of 0x20100
> > > > BDF 0x500 : SLT attribute mismatch: 0xFF030300 instead of 0x30300
> > > > BDF 0x600 : SLT attribute mismatch: 0xFF040400 instead of 0x40400
> > > > 
> > > > I reported it as an issue [2] and got response that it may be QEMU
> > > > fault. My pcie knowledge is not good enough to know where the problem is.
> > > > 
> > > > 2. https://github.com/ARM-software/bsa-acs/issues/193
> > > > 
> > > > 
> > > > In the comment Gowtham Siddarth wrote:
> > > > 
> > > > > Regarding the SLT (Secondary Latency Timer) register, the expected
> > > > > values align with the ACS specifications, registering as 0. However,
> > > > > a discrepancy arises in the register's attribute, intended to be set
> > > > > as Read-Only. Contrary to this intent, the bit field seems to
> > > > > function as> Read-Write. Ordinarily, when attempting to write to the
> > > > > register by configuring all bits to 1, the anticipated behaviour
> > > > > should involve rejecting the write operation, maintaining the value
> > > > > at 0 to uphold the register's designated Read-Only nature. However,
> > > > > in this scenario, the write action takes effect, leading to a
> > > > > transformation of the register's value to FFs. This anomaly could
> > > > > potentially stem from an issue within the emulator.
> > > > 
> > > > Does someone know where the problem may be? And how to fix it?
> > > 
> > > I don't know enough about PCI to be sure here, but it sounds like
> > > what you're saying is happening is that the test case writes all-1s
> > > to some PCI register for the root port device, and expects that where
> > > some bits in it are defined in the spec as read-only they don't get set?
> > > 
> > > Which registers exactly is the test case trying to write in this way ?
> > > 
> > > I've cc'd the QEMU PCI maintainers.
> > > 
> > > thanks
> > > -- PMM
> > 
> > 
> > yes, this is a bug.
> > 
> > 
> > static void pci_init_mask_bridge(PCIDevice *d)
> > {
> >      /* PCI_PRIMARY_BUS, PCI_SECONDARY_BUS, PCI_SUBORDINATE_BUS and
> >         PCI_SEC_LETENCY_TIMER */
> >      memset(d->wmask + PCI_PRIMARY_BUS, 0xff, 4);
> > 
> > 
> > note there's a typo: PCI_SEC_LETENCY_TIMER should be
> > PCI_SEC_LATENCY_TIMER.
> > 
> > But the express spec says:
> > 	This register does not apply to PCI Express. It must be read-only and hardwired to 00h. For PCI Express to PCI/PCI-X
> > 	Bridges, refer to the [PCIe-to-PCI-PCI-X-Bridge] for requirements for this register.
> > 
> > 
> > So, only for the pci express to pci express bridges, and only for new
> > machine types, we need to override the mask to 0:
> > 
> > 	d->wmask[PCI_SEC_LATENCY_TIMER] = 0;
> 
> Ah right. So smth like:
> 
> -- >8 --
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 881d774fb6..c73de617e0 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1241,2 +1241,5 @@ static PCIDevice *do_pci_register_device(PCIDevice
> *pci_dev,
>          pci_init_mask_bridge(pci_dev);
> +        if (pci_is_express(pci_dev)) {
> +            pci_set_byte(d->wmask + PCI_SEC_LATENCY_TIMER, 0);
> +        }
>      }
> ---
> 
> ?



No - it depends on secondart bus type and only applies to bridges.
Also we need compat machinery.
Marcin could you pls test the following?


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
 



