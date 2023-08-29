Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D39E78D016
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:14:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7ns-0001ZP-6W; Tue, 29 Aug 2023 19:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qb5W0-0007nB-8b
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qb5Vu-0006Hj-IZ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693341636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+qf9ykuOMcnpgfKz+wdwLTLwQ0tWlgl/1ESReE5PKE=;
 b=HFvg2wV4ETFsFoL2hz9UF6rKqeXAcSSdWqhCFcrZVgNlw8cvzG94jjNPHjlz8G2N2ZKso0
 tQXpLE+rwKQRQLREi4N++jFhCHUfv6AX4hobW/LKC7b7XBJ5+I0YgYiXgJ2iKRo2q+WL4r
 4lZbQofO8ZumgjAqdqKz1lFJysHv4MY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-rhVOMdXyOT6t_AtSjA7W1w-1; Tue, 29 Aug 2023 16:40:34 -0400
X-MC-Unique: rhVOMdXyOT6t_AtSjA7W1w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a5c0f8134eso138261066b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693341633; x=1693946433;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g+qf9ykuOMcnpgfKz+wdwLTLwQ0tWlgl/1ESReE5PKE=;
 b=CNOGN44dQS2XZDvS+JWCzwW4l3mhMWp27GP5sb/6p8LaJ0H70xaMl8N1smHRk4avgx
 c03UbfEKahE/G2stK0H/AT1Sp+FiZIq/xBKkadhMR68aIpE090cKuB9SDHzCnR5hF/09
 fltBy8oTBL8afohos+ScJKpRSH5NIjkxibYxa984sHD4u6+85uO/+42/pkm/384++mgy
 jTrRAZ8v/4SgTtaCcZt+3Y5UprQYgRauzd7qXooOzjHE8IfEcF4bmpF8iCX+KcABYEkE
 Y73HJ2Otke9rI3r0oTEkJsvZm88IBoo3SnUxH+s2ojo6mHKtln4/1MX4Gl7HHQYF+bl3
 TTOA==
X-Gm-Message-State: AOJu0YzSWlIjGoSuwMIRwcyl/xb4QmB+tZ/ScjVhqJMpmPUpVJ7LzkHk
 QFl74imXsBjnQB2LvzMLkDwdWbpIW2143s53oSvPyvvgp62csc1NDp8fuDX2x2ex4Xm0ifsnyff
 lFXxmSXi4CYJN/w0=
X-Received: by 2002:a17:906:3099:b0:99d:f7f3:5218 with SMTP id
 25-20020a170906309900b0099df7f35218mr75964ejv.25.1693341633796; 
 Tue, 29 Aug 2023 13:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFruZklxEdtnCab1QwBBM8sOliTkYRix4DE9P6mVWQMHt4FmfIsMxgn2dAv7j/QUXNMBqmsqQ==
X-Received: by 2002:a17:906:3099:b0:99d:f7f3:5218 with SMTP id
 25-20020a170906309900b0099df7f35218mr75953ejv.25.1693341633478; 
 Tue, 29 Aug 2023 13:40:33 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 z23-20020a170906435700b009875a6d28b0sm6298548ejm.51.2023.08.29.13.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 13:40:32 -0700 (PDT)
Date: Tue, 29 Aug 2023 16:40:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Gowtham Siddarth <gowtham.siddarth@arm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Message-ID: <20230829163929-mutt-send-email-mst@kernel.org>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
 <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
 <20230829093909-mutt-send-email-mst@kernel.org>
 <43653986-c04f-0076-637b-9061f9702f77@linaro.org>
 <20230829130617-mutt-send-email-mst@kernel.org>
 <ff230439-5d76-1f50-a25a-1fd666c3f369@linaro.org>
 <20230829161732-mutt-send-email-mst@kernel.org>
 <601619fb-5f1e-4b93-3dd1-b415d0ee8979@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <601619fb-5f1e-4b93-3dd1-b415d0ee8979@linaro.org>
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

On Tue, Aug 29, 2023 at 10:31:25PM +0200, Marcin Juszkiewicz wrote:
> W dniu 29.08.2023 o 22:18, Michael S. Tsirkin pisze:
> > On Tue, Aug 29, 2023 at 10:05:47PM +0200, Marcin Juszkiewicz wrote:
> > > W dniu 29.08.2023 o 19:07, Michael S. Tsirkin pisze:
> > > 
> > > > No - it depends on secondart bus type and only applies to bridges.
> > > > Also we need compat machinery.
> > > > Marcin could you pls test the following?
> > > 
> > > Works fine:
> > > 
> > >   822 : Check Type 1 config header rules           : Result:  PASS
> > 
> > Thanks! Now if possible I'd like to ask you to run the following test
> > with both default machine and 8.1 machine types.
> > With default should pass with 8.1 should fail as before.
> 
> It passes with sbsa-ref (which is not using QEMU versioning).
> 
> Fails (as expected) when used new property for each pcie-root-port
> (ignore line breaks):
> 
> "-device pcie-root-port,
>   x-pci-express-writeable-slt-bug=true,
>   id=root30,chassis=30,slot=0"


could you also check with -machine pc-q35-8.1 instead of this
property?



> > Thanks!
> 
> Thanks for sorting it out. I may have some more PCIe related
> questions in future.
> > diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> > index ea54a81a15..5cd452115a 100644
> > --- a/include/hw/pci/pci_bridge.h
> > +++ b/include/hw/pci/pci_bridge.h
> > @@ -77,6 +77,9 @@ struct PCIBridge {
> >       pci_map_irq_fn map_irq;
> >       const char *bus_name;
> > +
> > +    /* SLT is RO for PCIE to PCIE bridges, but old QEMU versions had it RW */
> > +    bool pcie_writeable_slt_bug;
> >   };
> >   #define PCI_BRIDGE_DEV_PROP_CHASSIS_NR "chassis_nr"
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index da699cf4e1..d665c79de3 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -39,7 +39,9 @@
> >   #include "hw/virtio/virtio.h"
> >   #include "hw/virtio/virtio-pci.h"
> > -GlobalProperty hw_compat_8_1[] = {};
> > +GlobalProperty hw_compat_8_1[] = {
> > +    { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
> 
> ../hw/core/machine.c:43:7: error: ‘TYPE_PCI_BRIDGE’ undeclared here (not in a function); did you mean ‘TYPE_PCI_BUS’?
>    43 |     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
>       |       ^~~~~~~~~~~~~~~
>       |       TYPE_PCI_BUS
> 
> Works with TYPE_PCI_BUS.
> 
> > +};
> >   const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
> >   GlobalProperty hw_compat_8_0[] = {
> > diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> > index e7b9345615..6a4e38856d 100644
> > --- a/hw/pci/pci_bridge.c
> > +++ b/hw/pci/pci_bridge.c
> > @@ -38,6 +38,7 @@
> >   #include "qapi/error.h"
> >   #include "hw/acpi/acpi_aml_interface.h"
> >   #include "hw/acpi/pci.h"
> > +#include "hw/qdev-properties.h"
> >   /* PCI bridge subsystem vendor ID helper functions */
> >   #define PCI_SSVID_SIZEOF        8
> > @@ -385,6 +386,11 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
> >       pci_bridge_region_init(br);
> >       QLIST_INIT(&sec_bus->child);
> >       QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
> > +
> > +    /* For express secondary buses, secondary latency timer is RO 0 */
> > +    if (pci_bus_is_express(sec_bus) && !br->pcie_writeable_slt_bug) {
> > +        dev->wmask[PCI_SEC_LATENCY_TIMER] = 0;
> > +    }
> >   }
> >   /* default qdev clean up function for PCI-to-PCI bridge */
> > @@ -466,10 +472,18 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
> >       return 0;
> >   }
> > +static Property pci_bridge_properties[] = {
> > +    DEFINE_PROP_BOOL("x-pci-express-writeable-slt-bug", PCIBridge,
> > +                     pcie_writeable_slt_bug, false),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> >   static void pci_bridge_class_init(ObjectClass *klass, void *data)
> >   {
> >       AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
> > +    DeviceClass *k = DEVICE_CLASS(klass);
> > +    device_class_set_props(k, pci_bridge_properties);
> >       adevc->build_dev_aml = build_pci_bridge_aml;
> >   }
> > 


