Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F55B737A8A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 07:09:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBq4E-0001jo-GI; Wed, 21 Jun 2023 01:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBq40-0001jF-Ev
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 01:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBq3y-0004Nf-AB
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 01:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687324044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yX/rTODsrzZBkWIB9/BWb+xdm4DDNCUFnFoaUQ0XKI=;
 b=CEsL5KmROEU6mq0WbTrSXBX3mEsRYVoPFwEH62oQCocGi0M4V/2vWDWMVk4XGFNguRJNZG
 DvdsFu9O6ZTog9rzuhpf6iLOL0imdlBxRk3QjolNcoV7R+UI1S2X1AKhoR2jJsSfJP/6Wx
 ukA4sNTQH9Sk9LMnKlQQOEYU1Q8W6ZU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-PouZvXlUP6-K4aDQD55cyg-1; Wed, 21 Jun 2023 01:07:22 -0400
X-MC-Unique: PouZvXlUP6-K4aDQD55cyg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f81f4a7596so32464955e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 22:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687324041; x=1689916041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2yX/rTODsrzZBkWIB9/BWb+xdm4DDNCUFnFoaUQ0XKI=;
 b=OsYs7C9K2qtFhKn7rxf64LV53mKb3N49cnfsgsE43hIsmEBTGT2zSJNVKoWCqlp6l4
 vB8fmtQTU7hkLwpPQ3zLFQ8O8pdl9f7JVkY8oyuAaZkLPPK2f3f9sWTfg1M/si6P6Nwo
 sNW+hm3l5W6+y94IThhIV7v7SqMn+Sk7GB4W2FEneAvGbW9BD+GJc4WAelmBsWeRgVkz
 lKWSISUcOi6wd2Ti9S55fXvEvNiJ6CkyhAL1K1Dx2wuUkRX1tkHiE2UNg5D+Sdzhxy9j
 Wp2pYjPqydkdX1QbmscegbUISGeyljM9jySpkPd8cBJSe9whDnyUe/Iyb5AsNCzG8c8L
 Sq+w==
X-Gm-Message-State: AC+VfDzmxMy7jWDS2jfefvxAiBGTAfgpS2sAzHaD/yto0WPUiPEIBN9c
 FezfwPCmVwdMhUwL90QjS377Morop7vzi2Zp4VR5CF13WePN1uA8OC3IOif/5gmyQgT25mGz+OR
 Up9yvwd73YczD0Ok=
X-Received: by 2002:a05:600c:2114:b0:3f9:9a93:216f with SMTP id
 u20-20020a05600c211400b003f99a93216fmr6559839wml.29.1687324041593; 
 Tue, 20 Jun 2023 22:07:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dSPiJpKHfhwyHXcNfwqH+UJzT4kM4UQbyp/USjHxueSuk5yorMPHyQPTQwcV6dULADR9vAA==
X-Received: by 2002:a05:600c:2114:b0:3f9:9a93:216f with SMTP id
 u20-20020a05600c211400b003f99a93216fmr6559830wml.29.1687324041267; 
 Tue, 20 Jun 2023 22:07:21 -0700 (PDT)
Received: from redhat.com ([2.52.15.156]) by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b003f90067880esm12267507wmk.47.2023.06.20.22.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 22:07:20 -0700 (PDT)
Date: Wed, 21 Jun 2023 01:07:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4] hw/pci: enforce use of slot only slot 0 when devices
 have an upstream PCIE port
Message-ID: <20230621010614-mutt-send-email-mst@kernel.org>
References: <20230620071805.4400-1-anisinha@redhat.com>
 <20230620062307-mutt-send-email-mst@kernel.org>
 <06B2DB46-643C-4835-B850-D66FD01D5E69@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06B2DB46-643C-4835-B850-D66FD01D5E69@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Jun 21, 2023 at 08:09:55AM +0530, Ani Sinha wrote:
> 
> 
> > On 20-Jun-2023, at 4:13 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Tue, Jun 20, 2023 at 12:48:05PM +0530, Ani Sinha wrote:
> >> When a device has an upstream PCIE port, we can only use slot 0.
> > 
> > Actually, it's when device is plugged into a PCIE port.
> > So maybe:
> > 
> > 	PCI Express ports only have one slot, so
> > 	PCI Express devices can only be plugged into
> > 	slot 0 on a PCIE port
> > 
> >> Non-zero slots
> >> are invalid. This change ensures that we throw an error if the user
> >> tries to hotplug a device with an upstream PCIE port to a non-zero slot.
> > 
> > it also adds a comment explaining why function 0 must not exist
> > when function != 0 is added. or maybe split that part out.
> > 
> >> CC: jusual@redhat.com
> >> CC: imammedo@redhat.com
> >> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> ---
> >> hw/pci/pci.c | 18 ++++++++++++++++++
> >> 1 file changed, 18 insertions(+)
> >> 
> >> changelog:
> >> v2: addressed issue with multifunction pcie root ports. Should allow
> >> hotplug on functions other than function 0.
> >> v3: improved commit message.
> >> v4: improve commit message and code comments further. Some more
> >> improvements might come in v5. No claims made here that this is
> >> the final one :-)
> >> 
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index bf38905b7d..30ce6a78cb 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -64,6 +64,7 @@ bool pci_available = true;
> >> static char *pcibus_get_dev_path(DeviceState *dev);
> >> static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >> static void pcibus_reset(BusState *qbus);
> >> +static bool pcie_has_upstream_port(PCIDevice *dev);
> >> 
> >> static Property pci_props[] = {
> >>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >> @@ -1182,6 +1183,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >>     } else if (dev->hotplugged &&
> >>                !pci_is_vf(pci_dev) &&
> >>                pci_get_function_0(pci_dev)) {
> >> +        /*
> >> +         * populating function 0 triggers a bus scan from the guest that
> >> +         * exposes other non-zero functions. Hence we need to ensure that
> >> +         * function 0 wasn't added yet.
> >> +         */
> > 
> > Pls capitalize populating. Also, comments like this should come
> > before the logic they document, not after. By the way it doesn't
> > have to be a bus scan - I'd just say "a scan" - with ACPI
> > guest knows what was added and can just probe the device functions.
> > 
> >>         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
> >>                    " new func %s cannot be exposed to guest.",
> >>                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> >> @@ -1189,6 +1195,18 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >>                    name);
> >> 
> >>        return NULL;
> >> +    } else if (dev->hotplugged &&
> > 
> > why hotplugged? Doesn't the same rule apply to all devices?
> > 
> >> +               !pci_is_vf(pci_dev) &&
> > 
> > Hmm. I think you copied it from here:
> >    } else if (dev->hotplugged &&
> >               !pci_is_vf(pci_dev) &&
> >               pci_get_function_0(pci_dev)) {
> > 
> > it makes sense there because VFs are added later
> > after PF exists.
> 
> I thought PFs are handled only in the host OS and only VFs are
> passthrough into the guest?

This is emulated SRIOV. host and guest would be nested L2.

> I thought this check was because VFs have
> a different domain address separate from other non-vf devices in the
> guest PCI tree. 

Maybe take a look at the SRIOV spec then.

> > 
> > But here it makes no sense that I can see.
> > 
> > 
> >> +               pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> >> +        /*
> >> +         * If the device has an upstream PCIE port, like a pcie root port,
> > 
> > no, a root port can not be an upstream port.
> > 
> > 
> >> +         * we only support functions on slot 0.
> >> +         */
> >> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> >> +                   " only functions on slot 0 is supported for devices"
> >> +                   " with an upstream PCIE port.",
> > 
> > 
> > something like:
> > 
> >        error_setg(errp, "PCI: slot %d is not valid for %s:"
> >                   " PCI Express devices can only be plugged into slot 0")
> > 
> > and then you don't really need a comment.
> > 
> > 
> >> +                   PCI_SLOT(devfn), name);
> >> +        return NULL;
> >>     }
> >> 
> >>     pci_dev->devfn = devfn;
> >> -- 
> >> 2.39.1


