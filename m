Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0976F92E837
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jul 2024 14:24:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRspc-0002RY-55; Thu, 11 Jul 2024 08:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRspa-0002R3-E7
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRspY-0008JI-Bf
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720700602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OnyCG9jLNSkK29ol0NSD8qGt7MpNaFgicQ9xROE6ndQ=;
 b=MXZ41JRSuc7A2pLEHJMu7nOY7tP6C+IKulUAsfTjGVh3xr+wiK/HZxOeV/sJ6CLFsmJfFW
 E74nhauY93d1GUInCH7Sdv/no5WEPb5qhylO7itscafVnlHoassfWFRA/bcAqNxERsIItg
 diBSq83y8Uk3HYijMEWLQKScm8InN+M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-fQ_QxDpVN0y-auGKrn0pbA-1; Thu, 11 Jul 2024 08:23:21 -0400
X-MC-Unique: fQ_QxDpVN0y-auGKrn0pbA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42796140873so4951685e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 05:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720700600; x=1721305400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnyCG9jLNSkK29ol0NSD8qGt7MpNaFgicQ9xROE6ndQ=;
 b=Gqole1Wx8wpNT4CIXhTGU5H1vjqTj9L/j8bhG/lCuOgCTj68QdYSwHvmMKse/cCV4q
 wmtLS63lremA/4fOMDtxVEyJZTuA/+NkwU67e0P+lRuzeSpoP+r6Cu1ua80JgBaF7FBq
 isIe/a6yTiUM7ZWz0Qcr3ykPgKwRHxf2wz4KpWElZGEmjptmfELyhYOCDoFf0qf28pbX
 rkWsDm+Wu4Bu1vtl43pr9gla6LK9t2iJ6zQswarbpXf3gK087uORimRI/4nsCCEimoZR
 wGoyjHSTEeG1SgG2THYuMGCKBySs0w3g4QNyZHFQprzzzkbAPwLwZbIuuBg4eOlfuiIR
 RvHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2bJvPRxw7ATdP7E1s4X/Xy4GALn+miHp/YyW7OGUGYli9TyxwQPWiK+k/97dmOhsti7/0rAwoC1J75uW1+P8R2otC4cI=
X-Gm-Message-State: AOJu0YyZCeabrkRYAB8uiOspVTVhFgm4HV1SHI8iHJo5JFONTzKGAC9N
 vD/EYCfoUOY+y+w36edHJWGeJ6DXrO4vR3VI3j4RqpADPvGNJfyuSZkAHJiKc1s5vniX/M4MdKo
 2++UKGdkWUdtPKsofjLohfQNmK2hv1Q/EPBIEgs0kLrGL6eMfDIiz
X-Received: by 2002:adf:e98d:0:b0:367:89d3:6581 with SMTP id
 ffacd0b85a97d-367cea67d70mr5897762f8f.17.1720700600375; 
 Thu, 11 Jul 2024 05:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVTReJvehVyFPqpX0/1+vB6rD4l1DZVJ3/3qhaXBXbIdOMd17ey8C0rWVb+SgIhIueZOW73Q==
X-Received: by 2002:adf:e98d:0:b0:367:89d3:6581 with SMTP id
 ffacd0b85a97d-367cea67d70mr5897736f8f.17.1720700599994; 
 Thu, 11 Jul 2024 05:23:19 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfb2281sm7592520f8f.115.2024.07.11.05.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 05:23:19 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:23:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 05/13] hw/pci: Add a busnr property to pci_props and
 use for acpi/gi
Message-ID: <20240711142316.1150870e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240711135331.6f0e4639@imammedo.users.ipa.redhat.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
 <20240702131428.664859-6-Jonathan.Cameron@huawei.com>
 <20240711135331.6f0e4639@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, 11 Jul 2024 13:53:31 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 2 Jul 2024 14:14:10 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Using a property allows us to hide the internal details of the PCI device
> > from the code to build a SRAT Generic Initiator Affinity Structure with
> > PCI Device Handle.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > V4: Avoid confusion with device creation parameter bus but renaming to
> >     busnr
> > ---
> >  hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
> >  hw/pci/pci.c                     | 14 ++++++++++++++
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > index 73bafaaaea..f2711c91ef 100644
> > --- a/hw/acpi/acpi_generic_initiator.c
> > +++ b/hw/acpi/acpi_generic_initiator.c
> > @@ -9,6 +9,7 @@
> >  #include "hw/boards.h"
> >  #include "hw/pci/pci_device.h"
> >  #include "qemu/error-report.h"
> > +#include "qapi/error.h"
> >  
> >  typedef struct AcpiGenericInitiatorClass {
> >      ObjectClass parent_class;
> > @@ -79,7 +80,7 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> >      MachineState *ms = MACHINE(qdev_get_machine());
> >      AcpiGenericInitiator *gi;
> >      GArray *table_data = opaque;
> > -    PCIDevice *pci_dev;
> > +    uint8_t bus, devfn;
> >      Object *o;
> >  
> >      if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> > @@ -100,10 +101,10 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> >          exit(1);
> >      }
> >  
> > -    pci_dev = PCI_DEVICE(o);
> > -    build_srat_pci_generic_initiator(table_data, gi->node, 0,
> > -                                     pci_bus_num(pci_get_bus(pci_dev)),
> > -                                     pci_dev->devfn);
> > +    bus = object_property_get_uint(o, "busnr", &error_fatal);
> > +    devfn = object_property_get_uint(o, "addr", &error_fatal);  
> 
> devfn in PCI code is 32bit, while here it's declared as unit8_t,
> which seems wrong.
> It likely would work in case of PCIe root ports/switches where slot is 0,
> but should quickly break elsewhere as soon as slot is more than 0.
> 
> If it's intentional, there should be fat comment here about why it this way
> and an assert to catch silent cropping of the value. 

Ignore that, obviously the rest of the QEMU does not care about this downcast.

Maybe add assert anyways to catch too big devfn returned,
which unlikely to happen ever.

anyways:

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> > +
> > +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> >  
> >      return 0;
> >  }
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 50b86d5790..29d4852c21 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >  static void pcibus_reset_hold(Object *obj, ResetType type);
> >  static bool pcie_has_upstream_port(PCIDevice *dev);
> >  
> > +static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
> > +                             void *opaque, Error **errp)
> > +{
> > +    uint8_t busnr = pci_dev_bus_num(PCI_DEVICE(obj));
> > +
> > +    visit_type_uint8(v, name, &busnr, errp);
> > +}
> > +
> > +static const PropertyInfo prop_pci_busnr = {
> > +    .name = "busnr",
> > +    .get = prop_pci_busnr_get,
> > +};
> > +
> >  static Property pci_props[] = {
> >      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
> > @@ -85,6 +98,7 @@ static Property pci_props[] = {
> >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > +    { .name = "busnr", .info = &prop_pci_busnr },
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >    
> 


