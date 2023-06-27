Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E3E73FDBB
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:24:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE9bg-000686-BB; Tue, 27 Jun 2023 10:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qE9bV-00064u-HU
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qE9bS-0001kE-3q
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687875803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T5LjbJuBdWFD0AAMuZl7bsFyVyIT8AaMHEQeSd3MEEg=;
 b=ZHoAyNOKiXyH9+DwcIlHUZUEtYMM0Y+wKr1AF7AjVWpmTnsQ4+efaqEqyBd97UlM4HTpGj
 Ec3iKt3V7H3y9laDRjqKMnqMOIBSV4RII0mxjpptgyhEqHHaD7FfdfY8ZAfzSs44ThoXKP
 AfhzPo4SzumXVlIDvPQ6L7uLCbVmKw8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-ONxxYf3YP5WDdcP0S4SNmA-1; Tue, 27 Jun 2023 10:23:21 -0400
X-MC-Unique: ONxxYf3YP5WDdcP0S4SNmA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-765a1a97103so285717385a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 07:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687875795; x=1690467795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5LjbJuBdWFD0AAMuZl7bsFyVyIT8AaMHEQeSd3MEEg=;
 b=GdgszB15TvzQXUGQLqEqViI5jMx0pKFRAYJ7aLuw50p+5/dLA3k9Jh1fYCs9qjXqXV
 KiWi3GMsGdW8dJ5OmWW688uiQp01asHzOkXwjctstVpMDuxgzLmUWARnWyltBqgsKjch
 7gCpFK7EtjeRm4OY5ecW8M3+IUwj3EODMX7ARcExI0eRJQzJPmV5ixwedBevUih0+zg0
 CaebKM/GDOIjFU5ah564FXqcQ3RW7gml0jtPTwDxjgN5JYTCJf9gKcTCwB5LWBcusZIp
 7swNGTq9otUO3XJT9cvBBHbcChl0ffSCzxTytv4ZhkK6avXfeXl4C/WIP6jWTqiFvnA6
 J27Q==
X-Gm-Message-State: AC+VfDyfZ9+43Q8eDXtRFFX8AgZyYKegJtoCma/swPHSPcHMnXj+y16s
 7c+8wXLhF6upKOqXKX7wq5cjXIMvqChm7Tl9bulsfhRm/YlR/bNywMKavOpYe+40f1ACTAGdlGz
 oTrN1G+yhZ10C2hQ=
X-Received: by 2002:a05:620a:25ca:b0:765:a74d:62b1 with SMTP id
 y10-20020a05620a25ca00b00765a74d62b1mr6707973qko.19.1687875795534; 
 Tue, 27 Jun 2023 07:23:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5X73TqOeisjL/j2fL5NJ5pkisWmx2qkY4zP45kkh6+jXajSppU8RbIxA1GU/NMsM83JcCt5w==
X-Received: by 2002:a05:620a:25ca:b0:765:a74d:62b1 with SMTP id
 y10-20020a05620a25ca00b00765a74d62b1mr6707956qko.19.1687875795270; 
 Tue, 27 Jun 2023 07:23:15 -0700 (PDT)
Received: from redhat.com ([45.144.113.5]) by smtp.gmail.com with ESMTPSA id
 t3-20020a05620a034300b007654bb4a842sm3966076qkm.104.2023.06.27.07.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 07:23:14 -0700 (PDT)
Date: Tue, 27 Jun 2023 10:23:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
Message-ID: <20230627102239-mutt-send-email-mst@kernel.org>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
 <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
 <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
 <20230627135849.37e52f87@imammedo.users.ipa.redhat.com>
 <20230627081835-mutt-send-email-mst@kernel.org>
 <41FA6F3E-2068-44CC-9457-37F11021BDD2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA6F3E-2068-44CC-9457-37F11021BDD2@redhat.com>
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

On Tue, Jun 27, 2023 at 05:59:02PM +0530, Ani Sinha wrote:
> 
> 
> > On 27-Jun-2023, at 5:53 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Tue, Jun 27, 2023 at 01:58:49PM +0200, Igor Mammedov wrote:
> >> On Tue, 27 Jun 2023 15:23:04 +0530
> >> Ani Sinha <anisinha@redhat.com> wrote:
> >> 
> >>>> On 27-Jun-2023, at 2:32 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> >>>> 
> >>>> On Mon, 26 Jun 2023 21:42:44 +0530
> >>>> Ani Sinha <anisinha@redhat.com> wrote:
> >>>> 
> >>>>> PCI Express ports only have one slot, so PCI Express devices can only be
> >>>>> plugged into slot 0 on a PCIE port. Enforce it.  
> >>>> 
> >>>> btw, previously you mentioned ARI.
> >>>> So if we turn it on, wouldn't this patch actually become regression?  
> >>> 
> >>> If ARI breaks this, it will break other areas in QEMU too, ex anywhere pci_get_function_0() is used.
> >>> Regardless, I think at least the tests are worth fixing, particularly the mess with hd-geo-test.
> >> 
> >> I'm fine with this patch if you test it with ARI enabled and it won't break
> >> something that has been working before this patch. Just mention what testing
> >> you've done in commit message.
> > 
> > Oh yes. That's why it was checking !vf originally. It's because the most
> > common use of ARI is SRIOV, so it works a a kind of hack.
> 
> Ok so should I put it back?
> Also I was thinking of running the qtest and avocado test mentioned in https://www.qemu.org/docs/master/system/devices/igb.html . Not sure if it would be enough to test ARI.

Well you need > 8 VFs for that.

> > 
> >>> 
> >>>> 
> >>>>> 
> >>>>> CC: jusual@redhat.com
> >>>>> CC: imammedo@redhat.com
> >>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> >>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> >>>>> ---
> >>>>> hw/pci/pci.c | 6 ++++++
> >>>>> 1 file changed, 6 insertions(+)
> >>>>> 
> >>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >>>>> index bf38905b7d..426af133b0 100644
> >>>>> --- a/hw/pci/pci.c
> >>>>> +++ b/hw/pci/pci.c
> >>>>> @@ -64,6 +64,7 @@ bool pci_available = true;
> >>>>> static char *pcibus_get_dev_path(DeviceState *dev);
> >>>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >>>>> static void pcibus_reset(BusState *qbus);
> >>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
> >>>>> 
> >>>>> static Property pci_props[] = {
> >>>>>    DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >>>>> @@ -1189,6 +1190,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >>>>>                   name);
> >>>>> 
> >>>>>       return NULL;
> >>>>> +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> >>>>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> >>>>> +                   " parent device only allows plugging into slot 0.",
> >>>>> +                   PCI_SLOT(devfn), name);
> >>>>> +        return NULL;
> >>>>>    }
> >>>>> 
> >>>>>    pci_dev->devfn = devfn;  


