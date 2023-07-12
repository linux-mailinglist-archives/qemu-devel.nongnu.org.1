Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3451750792
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 14:07:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJYcp-0006OL-Ij; Wed, 12 Jul 2023 08:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJYck-0006Me-LT
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJYci-0000uM-0D
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689163629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sQ+r0O/HBNp/9kBc+LR0gyJdfmixcnxpy5VORDva/MQ=;
 b=fLRoq755UQf37jLCUGSPwkgudfJ6/WgFpJui/B3fBJ568T6IaTS2nhJxiSy6KOn22htPV0
 1FwkkE5vuCFkilPVoCXDX/hD6t8iNIPG9Vu5RqQlrVtr+oQ4h+ag/CLhAlhT023UrBys1a
 q95Mmzakzc7Md61KL4wZTiFvjtsfItk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-bvMhPd_4Oj-GOPPGt-3r3w-1; Wed, 12 Jul 2023 08:07:06 -0400
X-MC-Unique: bvMhPd_4Oj-GOPPGt-3r3w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fc00d7d62cso32471965e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 05:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689163625; x=1691755625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQ+r0O/HBNp/9kBc+LR0gyJdfmixcnxpy5VORDva/MQ=;
 b=HWecIJIEjBJlIr1yCABD6/LczMoaiGFcn5UVrmHukxBY8ZaGw9rLKOTsCbL/3fRjRN
 B5A975jPCCewYLVmJ+86gwsgt+KaDXnPINdzihVvdNHSySowbzWqhKGQ8POq/lJD9802
 jjPVrJq77lnz9J1DRIDl/vnZmGmro3HR5cWNRu6gwtrVuyhw45fjcEOGKIQVuoW2a3io
 DQeYx8Ov7QgII83Bn1OXLQK9DPFDnmfeFj1U7SHzxt1fhGw8K92unByIh3BLsEbUlgqx
 rJOgzv61JZWX+JmMJAlg68rHjuzWqQzmMnR1/xXfY5diX6Uhs+MQ5rt4jrd86jNWMZuo
 ZnSA==
X-Gm-Message-State: ABy/qLYibX976/MdBgy+B73w15bhphRixYyEKfSt3Xgl5eEcoKrcqXeJ
 JCPSqG7RG5VaQCAqekhsVNvQ9hdVEJknq/nGXAxgrHuyZs98AZIHp4OX5b9YHH7ma6JJ68nHfSe
 6GdpxoqbMkNC2TAc=
X-Received: by 2002:a1c:7207:0:b0:3f9:ba2:5d19 with SMTP id
 n7-20020a1c7207000000b003f90ba25d19mr16372904wmc.33.1689163625086; 
 Wed, 12 Jul 2023 05:07:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlER1inv1MMnXou9YVw7+F72kN0Jm8BZ1t+jjbT/J6L3mOuto2ElmNNVhoDv7Hzr5KWNMZLNaw==
X-Received: by 2002:a1c:7207:0:b0:3f9:ba2:5d19 with SMTP id
 n7-20020a1c7207000000b003f90ba25d19mr16372873wmc.33.1689163624651; 
 Wed, 12 Jul 2023 05:07:04 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f3:f1da:a306:cee7:ddff:8ed0])
 by smtp.gmail.com with ESMTPSA id
 o7-20020adfeac7000000b00313f7b077fesm4959430wrn.59.2023.07.12.05.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 05:07:04 -0700 (PDT)
Date: Wed, 12 Jul 2023 08:06:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH] hw/pci: Warn when ARI/SR-IOV device has non-zero
 Function number
Message-ID: <20230712075420-mutt-send-email-mst@kernel.org>
References: <20230712112732.18617-1-akihiko.odaki@daynix.com>
 <20230712073523-mutt-send-email-mst@kernel.org>
 <e8be9581-2308-7fe6-f407-2ce54557dbd0@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8be9581-2308-7fe6-f407-2ce54557dbd0@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 12, 2023 at 08:50:32PM +0900, Akihiko Odaki wrote:
> On 2023/07/12 20:46, Michael S. Tsirkin wrote:
> > On Wed, Jul 12, 2023 at 08:27:32PM +0900, Akihiko Odaki wrote:
> > > Current SR/IOV implementations assume that hardcoded Function numbers
> > > are always available and will not conflict. It is somewhat non-trivial
> > > to make the Function numbers to use controllable to avoid Function
> > > number conflicts so ensure there is only one PF to make the assumption
> > > hold true.
> > > Also warn when non-SR/IOV multifunction was attempted with ARI enabled;
> > > ARI has the next Function number field register, and currently it's
> > > hardcoded to 0, which prevents non-SR/IOV multifunction. It is
> > > certainly possible to add a logic to determine the correct next Function
> > > number according to the configuration, but it's not worth since all
> > > ARI-capable devices are also SR/IOV devices, which do not support
> > > multiple PFs as stated above.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > I am not really interested in adding this stuff.
> > The real thing to focus on is fixing ARI emulation, not
> > warning users about ways in which it's broken.
> 
> What do you think about multiple SR/IOV PFs? Do you think it's worth/easy
> enough to fix SR/IOV code to support it? Otherwise it's not worth fixing ARI
> since currently only SR/IOV devices implement it.

There's nothing especially hard about it. You can in particular just
assume the user knows what he's doing and not worry too much about
checking. Creating invalid configs might also come handy e.g. for debug.
The important thing, and that's missing ATM, is giving management
ability to find out TotalVFs, VF offset and VF stride, so it can
avoid creating these conflicts.

For igd maybe we should make VF offset and VF stride just 1 unconditionally -
I have no idea why it was made 2 ATM - could you check what does
real hardware do?

Yes, warning at least is handy for
management debugging. It shouldn't be hard I think, but the
logic does tend to be O(n^2). Maybe add a flag to check,
and management developers can use that for debugging.

> > 
> > > ---
> > >   hw/pci/pci.c | 59 +++++++++++++++++++++++++++++++++++++---------------
> > >   1 file changed, 42 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index 784c02a182..50359a0f3a 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -2124,23 +2124,48 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> > >           }
> > >       }
> > > -    /*
> > > -     * A PCIe Downstream Port that do not have ARI Forwarding enabled must
> > > -     * associate only Device 0 with the device attached to the bus
> > > -     * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
> > > -     * sec 7.3.1).
> > > -     * With ARI, PCI_SLOT() can return non-zero value as the traditional
> > > -     * 5-bit Device Number and 3-bit Function Number fields in its associated
> > > -     * Routing IDs, Requester IDs and Completer IDs are interpreted as a
> > > -     * single 8-bit Function Number. Hence, ignore ARI capable devices.
> > > -     */
> > > -    if (pci_is_express(pci_dev) &&
> > > -        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
> > > -        pcie_has_upstream_port(pci_dev) &&
> > > -        PCI_SLOT(pci_dev->devfn)) {
> > > -        warn_report("PCI: slot %d is not valid for %s,"
> > > -                    " parent device only allows plugging into slot 0.",
> > > -                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
> > > +    if (pci_is_express(pci_dev)) {
> > > +        /*
> > > +         * A PCIe Downstream Port that do not have ARI Forwarding enabled must
> > > +         * associate only Device 0 with the device attached to the bus
> > > +         * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
> > > +         * sec 7.3.1).
> > > +         * With ARI, PCI_SLOT() can return non-zero value as the traditional
> > > +         * 5-bit Device Number and 3-bit Function Number fields in its
> > > +         * associated Routing IDs, Requester IDs and Completer IDs are
> > > +         * interpreted as a single 8-bit Function Number. Hence, ignore ARI
> > > +         * capable devices.
> > > +         */
> > > +        if (!pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
> > > +            pcie_has_upstream_port(pci_dev) &&
> > > +            PCI_SLOT(pci_dev->devfn)) {
> > > +            warn_report("PCI: slot %d is not valid for %s,"
> > > +                        " parent device only allows plugging into slot 0.",
> > > +                        PCI_SLOT(pci_dev->devfn), pci_dev->name);
> > > +        }
> > > +
> > > +        /*
> > > +         * Current SR/IOV implementations assume that hardcoded Function numbers
> > > +         * are always available. Ensure there is only one PF to make the
> > > +         * assumption hold true.
> > > +         */
> > > +        if (pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV) &&
> > > +            PCI_FUNC(pci_dev->devfn)) {
> > > +            warn_report("PCI: function %d is not valid for %s,"
> > > +                        " currently PF can only be assigned to function 0.",
> > > +                        PCI_FUNC(pci_dev->devfn), pci_dev->name);
> > > +        }
> > > +
> > > +        /*
> > > +         * ARI has the next Function number field register, and currently it's
> > > +         * hardcoded to 0, which prevents non-SR/IOV multifunction.
> > > +         */
> > > +        if (pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
> > > +            !pci_is_vf(pci_dev) && (pci_dev->devfn & 0xff)) {
> > > +            warn_report("PCI: function %d is not valid for %s,"
> > > +                        " non-SR/IOV multifunction is not supported with ARI enabled.",
> > > +                        pci_dev->devfn & 0xff, pci_dev->name);
> > > +        }
> > >       }
> > >       if (pci_dev->failover_pair_id) {
> > > -- 
> > > 2.41.0
> > 


