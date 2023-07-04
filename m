Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C107471B6
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:49:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfSO-0002DU-Eb; Tue, 04 Jul 2023 08:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGfSJ-0002BO-TX
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGfSI-00072A-47
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688474908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1GiKA5wHzxOCUHoDVGWIovg74Fh67/GvKeEPNG0eIs=;
 b=an/GDTqW6OILtOnl53iQkcNLYwcbeKZCITdAiMxpIRDJtbZsuk9z9jRYHlXOLnFs1DNDIw
 jv4QsYRb8Ng5ymeFOdo0DgVMAgFni/MoyrPvveO6SvYA9vcChGT9ZRNQiWzyVS4h7DNlRq
 VRJYhNhvdDXYyLd6C9EpTUbRcOkHepY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-pOhq-EAcOxmvGPV9Jr8OLg-1; Tue, 04 Jul 2023 08:48:28 -0400
X-MC-Unique: pOhq-EAcOxmvGPV9Jr8OLg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a355c9028so375642266b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688474906; x=1691066906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1GiKA5wHzxOCUHoDVGWIovg74Fh67/GvKeEPNG0eIs=;
 b=EcRbkmhrVE7PKQpNRW3S7OiYBN8wyGQo4FnE3Ra0iTEBqCSTjCGIdv/4pb2OPhyesr
 CByoEKUd3r9no66pc6v0nZIAuxRuqN1ZsRkDe2pVBAy/2Gp5RI3iKAEEr5NIpthDO9ES
 1PCafY7FBYCNhsIfBYBCY5qislw1+EOv3dRF93es50gLU7p02sIhUYkIFpwXcNiXWJc2
 KH2sjvOqGe7NmEqm7x/BM/83HWhgCPOw8b0rlp2Qru5B/k+44PXaPtS3yCKB2UrBT/T2
 3e6K/O7zXve79/L5QahUqmNc/GDrE+fhl/HYW4bHpOSNT2HuRbb/RdudegSxgsv/beY3
 wkjQ==
X-Gm-Message-State: ABy/qLan3cP2BzuOvTHU/zRYhuXbntUSB1bAlunlo/PAR7Wdag5oxRBj
 4AS6lQTGiObw5E+L2QHMlmkCelbuaPanrOvFvpa/rB8iMPvjsKUyH/JwHluQEMv6+ovyyw7vUje
 PpKW/N75KASlub0M=
X-Received: by 2002:a17:906:c357:b0:993:28eb:fc05 with SMTP id
 ci23-20020a170906c35700b0099328ebfc05mr6625510ejb.49.1688474906672; 
 Tue, 04 Jul 2023 05:48:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHjoSoiO97X1AgeCBNnqixLSTefFc9StFL8Xeok2DsQ1z7unsQB3rq/qUVk+d4YnrkqdxRyCg==
X-Received: by 2002:a17:906:c357:b0:993:28eb:fc05 with SMTP id
 ci23-20020a170906c35700b0099328ebfc05mr6625499ejb.49.1688474906421; 
 Tue, 04 Jul 2023 05:48:26 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 z18-20020a1709067e5200b00989257be620sm13111162ejr.200.2023.07.04.05.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 05:48:25 -0700 (PDT)
Date: Tue, 4 Jul 2023 14:48:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into
 only slot 0 of PCIE port
Message-ID: <20230704144825.181a1629@imammedo.users.ipa.redhat.com>
In-Reply-To: <bf793e6b-62a0-0772-0d64-ddb5894ebf53@daynix.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
 <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
 <2C9BF0F4-6CB0-4805-818D-51CABC1EAFDE@redhat.com>
 <bf793e6b-62a0-0772-0d64-ddb5894ebf53@daynix.com>
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

On Tue, 4 Jul 2023 21:02:09 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> On 2023/07/04 20:59, Ani Sinha wrote:
> > 
> >   
> >> On 04-Jul-2023, at 5:24 PM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >>
> >> On 2023/07/04 20:25, Ani Sinha wrote:  
> >>> PCI Express ports only have one slot, so PCI Express devices can only be
> >>> plugged into slot 0 on a PCIE port. Add a warning to let users know when the
> >>> invalid configuration is used. We may enforce this more strongly later on once
> >>> we get more clarity on whether we are introducing a bad regression for users
> >>> currenly using the wrong configuration.
> >>> The change has been tested to not break or alter behaviors of ARI capable
> >>> devices by instantiating seven vfs on an emulated igb device (the maximum
> >>> number of vfs the linux igb driver supports). The vfs instantiated correctly
> >>> and are seen to have non-zero device/slot numbers in the conventional PCI BDF
> >>> representation.
> >>> CC: jusual@redhat.com
> >>> CC: imammedo@redhat.com
> >>> CC: mst@redhat.com
> >>> CC: akihiko.odaki@daynix.com
> >>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> >>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> >>> ---
> >>>   hw/pci/pci.c | 15 +++++++++++++++
> >>>   1 file changed, 15 insertions(+)
> >>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >>> index e2eb4c3b4a..47517ba3db 100644
> >>> --- a/hw/pci/pci.c
> >>> +++ b/hw/pci/pci.c
> >>> @@ -65,6 +65,7 @@ bool pci_available = true;
> >>>   static char *pcibus_get_dev_path(DeviceState *dev);
> >>>   static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >>>   static void pcibus_reset(BusState *qbus);
> >>> +static bool pcie_has_upstream_port(PCIDevice *dev);
> >>>     static Property pci_props[] = {
> >>>       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >>> @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> >>>           }
> >>>       }
> >>>   +    /*
> >>> +     * With SRIOV and ARI, vfs can have non-zero slot in the conventional
> >>> +     * PCI interpretation as all five bits reserved for slot addresses are
> >>> +     * also used for function bits for the various vfs. Ignore that case.  
> >>
> >> You don't have to mention SR/IOV; it affects all ARI-capable devices. A PF can also have non-zero slot number in the conventional interpretation so you shouldn't call it vf either.  
> > 
> > Can you please help write a comment that explains this properly for all cases - ARI/non-ARI, PFs and VFs? Once everyone agrees that its clear and correct, I will re-spin.  
> 
> Simply, you can say:
> With ARI, the slot number field in the conventional PCI interpretation 
> can have a non-zero value as the field bits are reused to extend the 
> function number bits. Ignore that case.

mentioning 'conventional PCI interpretation' in comment and then immediately
checking 'pci_is_express(pci_dev)' is confusing. Since comment belongs
only to PCIE branch it would be better to talk in only about PCIe stuff
and referring to relevant portions of spec.
(for example see how it's done in kernel code: only_one_child(...)

PS:
kernel can be forced  to scan for !0 device numbers, but that's rather
a hack, so we shouldn't really care about that.

> 
> >   
> >>  
> >>> +     */
> >>> +    if (pci_is_express(pci_dev) &&
> >>> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
> >>> +        pcie_has_upstream_port(pci_dev) &&
> >>> +        PCI_SLOT(pci_dev->devfn)) {
> >>> +        warn_report("PCI: slot %d is not valid for %s,"
> >>> +                    " parent device only allows plugging into slot 0.",
> >>> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
> >>> +    }
> >>> +
> >>>       if (pci_dev->failover_pair_id) {
> >>>           if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
> >>>               error_setg(errp, "failover primary device must be on "  
> >>  
> >   
> 


