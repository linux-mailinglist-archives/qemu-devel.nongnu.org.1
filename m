Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A34673FBB0
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7TN-0001rI-8W; Tue, 27 Jun 2023 08:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qE7TD-0001oX-HU
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qE7TB-0000UY-2Z
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687867612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZg7G2Du6BraMKjHUeTPhRYYcBcrLtPjMs0XgPIU630=;
 b=G5ivIhEgtNsBare/vxUCS6muAQlQNJr+S9HXkj/I1llJ9E109YGRzMhCyfDSWdQLJmkV8E
 n4g2vaXNaXwOkLKQ19ToY7WIr0McNgU7Pdbk9NgmClVSxOGRJk8Khpur/lr64aeXq3tMPZ
 WOhfdc0j0UIisQ6bd/42VAESwCPh7DA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-txF_TgIjO-q6lSmuJwSH9w-1; Tue, 27 Jun 2023 08:06:48 -0400
X-MC-Unique: txF_TgIjO-q6lSmuJwSH9w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso1791403f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687867607; x=1690459607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZg7G2Du6BraMKjHUeTPhRYYcBcrLtPjMs0XgPIU630=;
 b=G51dcKc+i9mD5uKSmISyEnSinWE9WYeP4pntTJTQQ46h/+lYPXOE9kzqWrRdWdpwBD
 xpawRSzyrEfWUVHd7vgf1iKkozwnp3IY1d4uIJLuqBlWWHeMhVC3P/+z0q/AjUlhRsTs
 jJMNseunXSFXdV1Ea/QNR7T5emoyLA7xE1OVK4QyOwxcp2mDAZ6Esnl/TiVLlGqxnZLm
 04Kl1K+nNUnO0SV2ef1hPmOGPs6tohYxjT/gYAujJSQtoDYNk1fHrpkaBEPqy8XqLXHO
 mvl84ylkGCq9NrYDu8eexS9wNugdnXtopVenaD3hbQB/DSBJZMLkqSorfI8qW2cssCAe
 5VSg==
X-Gm-Message-State: AC+VfDz7uODSwzKEYhJ6Q5yTr6gUVQupcYHP9h2VVCk3fVqLVbbh+gQc
 q5YnrZ6BSJgnr02w3wlZgK7itTBSAj+hTlJf2Apkrj8KNVvHW8zrovezAXxsQ1eDXrsESZwIpvJ
 b9cXGVvTY5i1WdMk=
X-Received: by 2002:a5d:63ce:0:b0:313:e404:688b with SMTP id
 c14-20020a5d63ce000000b00313e404688bmr5708364wrw.42.1687867607634; 
 Tue, 27 Jun 2023 05:06:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xmhgbAyEki1CS7pLUk3HUqvE3u5ocRHwbXnV8L1EY3PpsVg7jTKXszZNZLTDT4Gtw3Y2g/Q==
X-Received: by 2002:a5d:63ce:0:b0:313:e404:688b with SMTP id
 c14-20020a5d63ce000000b00313e404688bmr5708351wrw.42.1687867607361; 
 Tue, 27 Jun 2023 05:06:47 -0700 (PDT)
Received: from redhat.com ([2.52.141.236]) by smtp.gmail.com with ESMTPSA id
 u15-20020a5d6acf000000b003111fd2e33dsm10178921wrw.30.2023.06.27.05.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 05:06:46 -0700 (PDT)
Date: Tue, 27 Jun 2023 08:06:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
Message-ID: <20230627080624-mutt-send-email-mst@kernel.org>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
 <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
 <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
 <20230627075433-mutt-send-email-mst@kernel.org>
 <1E87C743-A608-4AB1-927D-ABF93F13078A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1E87C743-A608-4AB1-927D-ABF93F13078A@redhat.com>
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

On Tue, Jun 27, 2023 at 05:31:37PM +0530, Ani Sinha wrote:
> 
> 
> > On 27-Jun-2023, at 5:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Tue, Jun 27, 2023 at 03:23:04PM +0530, Ani Sinha wrote:
> >> 
> >> 
> >>> On 27-Jun-2023, at 2:32 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> >>> 
> >>> On Mon, 26 Jun 2023 21:42:44 +0530
> >>> Ani Sinha <anisinha@redhat.com> wrote:
> >>> 
> >>>> PCI Express ports only have one slot, so PCI Express devices can only be
> >>>> plugged into slot 0 on a PCIE port. Enforce it.
> >>> 
> >>> btw, previously you mentioned ARI.
> >>> So if we turn it on, wouldn't this patch actually become regression?
> >> 
> >> If ARI breaks this, it will break other areas in QEMU too, ex anywhere pci_get_function_0() is used.
> > 
> > We will just fix pci_get_function_0.
> 
> Any code with PCI_SLOT() I believe also would need fixing?

Oh, absolutely.

> > 
> >> Regardless, I think at least the tests are worth fixing, particularly the mess with hd-geo-test.
> > 
> > ok
> > 
> >>> 
> >>>> 
> >>>> CC: jusual@redhat.com
> >>>> CC: imammedo@redhat.com
> >>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> >>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> >>>> ---
> >>>> hw/pci/pci.c | 6 ++++++
> >>>> 1 file changed, 6 insertions(+)
> >>>> 
> >>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >>>> index bf38905b7d..426af133b0 100644
> >>>> --- a/hw/pci/pci.c
> >>>> +++ b/hw/pci/pci.c
> >>>> @@ -64,6 +64,7 @@ bool pci_available = true;
> >>>> static char *pcibus_get_dev_path(DeviceState *dev);
> >>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >>>> static void pcibus_reset(BusState *qbus);
> >>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
> >>>> 
> >>>> static Property pci_props[] = {
> >>>>    DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >>>> @@ -1189,6 +1190,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >>>>                   name);
> >>>> 
> >>>>       return NULL;
> >>>> +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> >>>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> >>>> +                   " parent device only allows plugging into slot 0.",
> >>>> +                   PCI_SLOT(devfn), name);
> >>>> +        return NULL;
> >>>>    }
> >>>> 
> >>>>    pci_dev->devfn = devfn;
> >>> 
> > 


