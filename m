Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0867434B0
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 08:02:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF7D1-0002si-DG; Fri, 30 Jun 2023 02:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qF7Cz-0002rw-Ey
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qF7Cu-0006zJ-Sp
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688104931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UExWGhiqPCoVlOEkBukiiMg/gDRyMN7GVGDXoPe65UA=;
 b=BxSs+KWaEiksts++N2m0OabqE3CmQ8XmhHLX5NIrqkUk5yanxTv2v+YVLvgeTD/yH8eZ6b
 nhC7cOI8SpzVQsw8SVDgEcRzv3ayJLZwqd4nT3Q+tOdfjs8elvSUWXFmFHcUWMkUZweARb
 Wrrq2u7YhGTiEkM7Gf5qCvFpcBKo2x4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-JD3C-tRDNoWXiPxJiydKjA-1; Fri, 30 Jun 2023 02:02:09 -0400
X-MC-Unique: JD3C-tRDNoWXiPxJiydKjA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3141a98a29aso606224f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 23:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688104929; x=1690696929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UExWGhiqPCoVlOEkBukiiMg/gDRyMN7GVGDXoPe65UA=;
 b=M6DCYNEXahuXy/GasFxKJLtBmg2CmWI6ibslB2aNNzKRdMyccYkZWc6JZxLINjGkBK
 jrExgyOJYUFhlmBq7/BJkFnKvKCA9kr5kOqxfCjVxIeitcXOxs/OdE9jUdcYaGb+JkW7
 Fa1dyOjZdxaGbzLD+G72+3oOBprxLk9X7wlt73Kbc6rCWEKEikKR9OTeFUYvEFwZBWXR
 xwX+y0PvTlXK8nePnnkvu3uMDG+Dww5ATYSY0BQygNUIUackSo9cNlP6PKJwWbNhr4Vi
 EL+4UDFXABKJ3n1oo9n6SHwo+ixkTqGiChYukHcn9IZqu5WP6gbczGxgZYX3DIASpOvX
 eDaQ==
X-Gm-Message-State: ABy/qLZeZQVdqTEw3iGp+GIG3+SIVZKImoJtM99NK1mgld4Euw7kDxZi
 DHMvcV4JV4geYTDUnOVY1npCDcYaMygOTSX2/9yx7F/5z6xa+OT4CtpGhR1FH1yFbDa7GVDL+67
 bs2mLepi93Hn6cZ8=
X-Received: by 2002:adf:e490:0:b0:314:475:bc6b with SMTP id
 i16-20020adfe490000000b003140475bc6bmr1650439wrm.18.1688104928894; 
 Thu, 29 Jun 2023 23:02:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEAWjGoLvXNZD9Lb8gO0mivOEJcPRh3i1u8Z4WKdxpXExSapRj1hiDv+hVzl/uzxODTHyq0YA==
X-Received: by 2002:adf:e490:0:b0:314:475:bc6b with SMTP id
 i16-20020adfe490000000b003140475bc6bmr1650422wrm.18.1688104928587; 
 Thu, 29 Jun 2023 23:02:08 -0700 (PDT)
Received: from redhat.com ([2.52.154.169]) by smtp.gmail.com with ESMTPSA id
 m3-20020adff383000000b0031417b0d338sm3061001wro.87.2023.06.29.23.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 23:02:08 -0700 (PDT)
Date: Fri, 30 Jun 2023 02:02:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230630020122-mutt-send-email-mst@kernel.org>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Jun 30, 2023 at 11:43:15AM +0900, Akihiko Odaki wrote:
> On 2023/06/29 23:18, Ani Sinha wrote:
> > 
> > 
> > > On 29-Jun-2023, at 2:19 PM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > > 
> > > On 2023/06/29 17:05, Ani Sinha wrote:
> > > > On Thu, 29 Jun, 2023, 12:17 pm Akihiko Odaki, <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>> wrote:
> > > >     On 2023/06/29 13:07, Ani Sinha wrote:
> > > >      > PCI Express ports only have one slot, so PCI Express devices can
> > > >     only be
> > > >      > plugged into slot 0 on a PCIE port. Enforce it.
> > > >      >
> > > >      > The change has been tested to not break ARI by instantiating
> > > >     seven vfs on an
> > > >      > emulated igb device (the maximum number of vfs the linux igb
> > > >     driver supports).
> > > >      > The vfs are seen to have non-zero device/slot numbers in the
> > > >     conventional
> > > >      > PCI BDF representation.
> > > >      >
> > > >      > CC: jusual@redhat.com <mailto:jusual@redhat.com>
> > > >      > CC: imammedo@redhat.com <mailto:imammedo@redhat.com>
> > > >      > CC: akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> > > >      >
> > > >      > Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> > > >     <https://bugzilla.redhat.com/show_bug.cgi?id=2128929>
> > > >      > Signed-off-by: Ani Sinha <anisinha@redhat.com
> > > >     <mailto:anisinha@redhat.com>>
> > > >      > Reviewed-by: Julia Suvorova <jusual@redhat.com
> > > >     <mailto:jusual@redhat.com>>
> > > >      > ---
> > > >      >   hw/pci/pci.c | 15 +++++++++++++++
> > > >      >   1 file changed, 15 insertions(+)
> > > >      >
> > > >      > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > >      > index e2eb4c3b4a..0320ac2bb3 100644
> > > >      > --- a/hw/pci/pci.c
> > > >      > +++ b/hw/pci/pci.c
> > > >      > @@ -65,6 +65,7 @@ bool pci_available = true;
> > > >      >   static char *pcibus_get_dev_path(DeviceState *dev);
> > > >      >   static char *pcibus_get_fw_dev_path(DeviceState *dev);
> > > >      >   static void pcibus_reset(BusState *qbus);
> > > >      > +static bool pcie_has_upstream_port(PCIDevice *dev);
> > > >      >
> > > >      >   static Property pci_props[] = {
> > > >      >       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> > > >      > @@ -1190,6 +1191,20 @@ static PCIDevice
> > > >     *do_pci_register_device(PCIDevice *pci_dev,
> > > >      >                      name);
> > > >      >
> > > >      >          return NULL;
> > > >      > +    } /*
> > > >      > +       * With SRIOV and ARI, vfs can have non-zero slot in the
> > > >     conventional
> > > >      > +       * PCI interpretation as all five bits reserved for slot
> > > >     addresses are
> > > >      > +       * also used for function bits for the various vfs. Ignore
> > > >     that case.
> > > >      > +       * It is too early here to check for ARI capabilities in
> > > >     the PCI config
> > > >      > +       * space. Hence, we check for a vf device instead.
> > > >      > +       */
> > > >     Why don't just perform this check after the capabilities are set?
> > > > We don't want to allocate resources for wrong device parameters. We want to error out early. Other checks also are performed at the same place .
> > > 
> > > It is indeed better to raise an error as early as possible so that we can avoid allocation and other operations that will be reverted and may go wrong due to the invalid condition. That should be the reason why other checks for the address are performed here.
> > > 
> > > However, in this particular case, we cannot confidently perform the check here because it is unknown if the ARI capability will be advertised until the device realization code runs. This can justify delaying the check after the device realization, unlike the other checks.
> > 
> > Ok so are you proposing that the check we have right before (the check for unoccupied function 0) be also moved? It also uses the same vf approximation for seemingly to support ARI.
> 
> No, I don't think the check for function 0 is required to be disabled
> because of the change of addressing caused by ARI, but it is required
> because SR-IOV VF can be added and removed while the PF (function 0)
> remains. I think this check should be performed also when SR-IOV is disabled
> and ARI is enabled.
> 
> Thus the check for unoccupied function 0 needs to use pci_is_vf() instead of
> checking ARI capability, and that can happen in do_pci_register_device().
> 
> > Also where do you propose we move the check?
> 
> In pci_qdev_realize(), somewhere after pc->realize() and before option ROM
> loading. See the check for failover pair as an example. I guess it's also
> placed in this region because it needs capability information.

How about instead of spending so much time on working around
incomplete ARI support we actually complete ARI support?



> > 
> > > 
> > > > Show quoted text
> > > >     Regards,
> > > >     Akihiko Odaki
> > > >      > +    else if (!pci_is_vf(pci_dev) &&
> > > >      > +             pcie_has_upstream_port(pci_dev) &&
> > > >      > +             PCI_SLOT(devfn)) {
> > > >      > +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> > > >      > +                   " parent device only allows plugging into
> > > >     slot 0.",
> > > >      > +                   PCI_SLOT(devfn), name);
> > > >      > +        return NULL;
> > > >      >       }
> > > >      >
> > > >      >       pci_dev->devfn = devfn;
> > 


