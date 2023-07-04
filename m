Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273574741C
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:29:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGh1J-0004H6-7q; Tue, 04 Jul 2023 10:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGh1H-0004Gw-Pl
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGh1F-0006W7-SE
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688480921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUvP0TCI9a2rJzNGFVdPC7XaO3z9eJAGJjXUovMNff0=;
 b=WyXKnWwNIjlppYtcEdUAhy0BcZuSfCxFf5hnziL8POuC7p8DxDx20AsxNYKK6iQADYsebn
 KLihZCYBLUy9KpCj/L82MGkwwm2n5g7zkoNpim/HkUbFjnQocaCq8CRTEQjwhLBePcE5lt
 7KHyP4MMt7uO1v1zwBGkXkRx7SpNLtY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-9bvShDHhNKuyWcUs5gNtmA-1; Tue, 04 Jul 2023 10:28:39 -0400
X-MC-Unique: 9bvShDHhNKuyWcUs5gNtmA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9892495397cso392034266b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688480918; x=1691072918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUvP0TCI9a2rJzNGFVdPC7XaO3z9eJAGJjXUovMNff0=;
 b=huxGwclvZ4GdCYJICvPP/7pe448OZGX8plB58GN79rW+GrE7LZqAeHgOqathz0sSHZ
 eOZZKPuneWX8Ek4UbBptrfxgUYog/tbBSFhx4VmCTsB/bgMOuFqE/A19ECPFlxdGEq23
 RKWaqcrUxwZQ5Gae0Tsz4GIcQZZ08rboUcfVTqKaZP65z5JHitaZz2xDjJ5p1ysoN+an
 drKx6FneofpUel8UILOOeTFT8VGq/5ehGyIF4Vy2GJhP1fGm8HxzTBnuhhMEvO/ElLx+
 H2Zkhn7a+P3Jh5KQC7GaZTYfnQxYm882SuB6gnyGA3XX1mkhcGIx9DyaX5HjFK9VDDje
 FH9g==
X-Gm-Message-State: ABy/qLZOdW07VCRRu0yLmmB836N9xZf/m0nON/CIXUqqRM1DPm2sqVnz
 Hv0zupH07DPd8iZZBmJ0cWs3oaIJSM4ZKpE0J6CoxyjZG+jdHpHyYdybAMBaOppkVyUlsS1ZWMR
 jHJsSTzHIDGXWmFg=
X-Received: by 2002:a17:906:779c:b0:991:b2a2:e424 with SMTP id
 s28-20020a170906779c00b00991b2a2e424mr12224334ejm.76.1688480918469; 
 Tue, 04 Jul 2023 07:28:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGHIx38borSWYkLuGwA5aUFDkx4RRTri/3QVuEwyKEGmhdaoJ+HZFjrp6cktr5jl1Mn6YlDQ==
X-Received: by 2002:a17:906:779c:b0:991:b2a2:e424 with SMTP id
 s28-20020a170906779c00b00991b2a2e424mr12224323ejm.76.1688480918225; 
 Tue, 04 Jul 2023 07:28:38 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 qx22-20020a170906fcd600b009931baa0d44sm4984991ejb.140.2023.07.04.07.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 07:28:37 -0700 (PDT)
Date: Tue, 4 Jul 2023 16:28:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel
 <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into
 only slot 0 of PCIE port
Message-ID: <20230704162836.61a08ff9@imammedo.users.ipa.redhat.com>
In-Reply-To: <EC8A962B-80F5-499F-9EA8-CC53DA160F1D@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
 <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
 <2C9BF0F4-6CB0-4805-818D-51CABC1EAFDE@redhat.com>
 <bf793e6b-62a0-0772-0d64-ddb5894ebf53@daynix.com>
 <20230704144825.181a1629@imammedo.users.ipa.redhat.com>
 <EC8A962B-80F5-499F-9EA8-CC53DA160F1D@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Tue, 4 Jul 2023 19:20:00 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> > On 04-Jul-2023, at 6:18 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > On Tue, 4 Jul 2023 21:02:09 +0900
> > Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >   
> >> On 2023/07/04 20:59, Ani Sinha wrote:  
> >>> 
> >>>   
> >>>> On 04-Jul-2023, at 5:24 PM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >>>> 
> >>>> On 2023/07/04 20:25, Ani Sinha wrote:    
> >>>>> PCI Express ports only have one slot, so PCI Express devices can only be
> >>>>> plugged into slot 0 on a PCIE port. Add a warning to let users know when the
> >>>>> invalid configuration is used. We may enforce this more strongly later on once
> >>>>> we get more clarity on whether we are introducing a bad regression for users
> >>>>> currenly using the wrong configuration.
> >>>>> The change has been tested to not break or alter behaviors of ARI capable
> >>>>> devices by instantiating seven vfs on an emulated igb device (the maximum
> >>>>> number of vfs the linux igb driver supports). The vfs instantiated correctly
> >>>>> and are seen to have non-zero device/slot numbers in the conventional PCI BDF
> >>>>> representation.
> >>>>> CC: jusual@redhat.com
> >>>>> CC: imammedo@redhat.com
> >>>>> CC: mst@redhat.com
> >>>>> CC: akihiko.odaki@daynix.com
> >>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> >>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> >>>>> ---
> >>>>>  hw/pci/pci.c | 15 +++++++++++++++
> >>>>>  1 file changed, 15 insertions(+)
> >>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >>>>> index e2eb4c3b4a..47517ba3db 100644
> >>>>> --- a/hw/pci/pci.c
> >>>>> +++ b/hw/pci/pci.c
> >>>>> @@ -65,6 +65,7 @@ bool pci_available = true;
> >>>>>  static char *pcibus_get_dev_path(DeviceState *dev);
> >>>>>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >>>>>  static void pcibus_reset(BusState *qbus);
> >>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
> >>>>>    static Property pci_props[] = {
> >>>>>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >>>>> @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> >>>>>          }
> >>>>>      }
> >>>>>  +    /*
> >>>>> +     * With SRIOV and ARI, vfs can have non-zero slot in the conventional
> >>>>> +     * PCI interpretation as all five bits reserved for slot addresses are
> >>>>> +     * also used for function bits for the various vfs. Ignore that case.    
> >>>> 
> >>>> You don't have to mention SR/IOV; it affects all ARI-capable devices. A PF can also have non-zero slot number in the conventional interpretation so you shouldn't call it vf either.    
> >>> 
> >>> Can you please help write a comment that explains this properly for all cases - ARI/non-ARI, PFs and VFs? Once everyone agrees that its clear and correct, I will re-spin.    
> >> 
> >> Simply, you can say:
> >> With ARI, the slot number field in the conventional PCI interpretation 
> >> can have a non-zero value as the field bits are reused to extend the 
> >> function number bits. Ignore that case.  
> > 
> > mentioning 'conventional PCI interpretation' in comment and then immediately
> > checking 'pci_is_express(pci_dev)' is confusing. Since comment belongs
> > only to PCIE branch it would be better to talk in only about PCIe stuff
> > and referring to relevant portions of spec.  
> 
> Ok so how about this?
> 
>    * With ARI, devices can have non-zero slot in the traditional BDF                                                                                  
>      * representation as all five bits reserved for slot addresses are                                                                                  
>      * also used for function bits. Ignore that case.  

you still refer to traditional (which I misread as 'conventional'),
steal the linux comment and argument it with ARI if necessary,
something like this (probably needs some more massaging):


         /*                                                                       
         * A PCIe Downstream Port normally leads to a Link with only Device      
         * 0 on it (PCIe spec r3.1, sec 7.3.1). 
          However PCI_SLOT() is broken if ARI is enabled, hence work around it
          by skipping check if the later cap is present.                                  
         */
                     
> 
> 
> > (for example see how it's done in kernel code: only_one_child(...)
> > 
> > PS:
> > kernel can be forced  to scan for !0 device numbers, but that's rather
> > a hack, so we shouldn't really care about that.
> >   
> >>   
> >>>   
> >>>>   
> >>>>> +     */
> >>>>> +    if (pci_is_express(pci_dev) &&
> >>>>> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
> >>>>> +        pcie_has_upstream_port(pci_dev) &&
> >>>>> +        PCI_SLOT(pci_dev->devfn)) {
> >>>>> +        warn_report("PCI: slot %d is not valid for %s,"
> >>>>> +                    " parent device only allows plugging into slot 0.",
> >>>>> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
> >>>>> +    }
> >>>>> +
> >>>>>      if (pci_dev->failover_pair_id) {
> >>>>>          if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
> >>>>>              error_setg(errp, "failover primary device must be on "    
> 


