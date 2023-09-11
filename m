Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F00F79A7A3
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:32:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qff9O-00084P-2n; Mon, 11 Sep 2023 07:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qff9K-00081b-JR
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qff9G-0008Qb-Qg
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694431928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNrT4X4tqw/2Zf6GNeJoNvsLEl1ebfr6D/CVU8SvKmc=;
 b=ZP0LSO/GtdEJwmd4HRNjbbYAJeHlY+ouVYMCS5bcFB/hG6z9yt9lJneP7ofGE3PIi9FdSc
 er7umnMs3E6nQMG6Qy1HJfTcdQPUyk/ON3fcInNk2V3+xo1qqArpOmfHekdjU8Xymj7ahR
 obI8mhVJ67YfKlzrbyMHS5ZcMAphVJA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-zjXboTSjM1OHRbyuzU0jPA-1; Mon, 11 Sep 2023 07:32:06 -0400
X-MC-Unique: zjXboTSjM1OHRbyuzU0jPA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99bebfada8cso287804066b.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 04:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694431925; x=1695036725;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VNrT4X4tqw/2Zf6GNeJoNvsLEl1ebfr6D/CVU8SvKmc=;
 b=D8RmSA7NCy93HAoa3jFrqzqMBmcwBZeziMLT9EJkVYyw0KMuiwdkm7QU1rEtzt4OUn
 8Dzfeg9MI+eU4oUl1nGJdIvJwc8oMZwUTjlLqUhAEoDKCGAaAYMttJjq1TckCkC2wp96
 iX81ooUTB5uV29aISP6/ulV8D2z2/SY5B/rjPu+XBWAA3t3b0ypsXROPR0scBZZ0ATB/
 2aJEVg2ryUJQ7KtvpsfNdVHLogaA2Ww8bBzKPfOkPg4903TzGV4W+rW3QdjP9pjACDy8
 Wi4V9Y4aRlL24l6COf+EiDA4EvDFYnXcDK7jkxcdf1hkbAPJ5+r0FADI9NbNChwmzARe
 +RGw==
X-Gm-Message-State: AOJu0YzsNCYfJAx9fudgyxV9vhPvcfRXRX6B42HUcAm3/w7tKsSfoHiG
 zSMejHZebTKCfhItbBQ8vSHyYdQw6w0LYGEWwrjyi3Jykq95V7KK4OzfWaM1eF9cw2KbxoY0CDz
 BH6AvMhZxuCms4JvZ6tzK9Oo=
X-Received: by 2002:a17:907:2711:b0:9a1:b967:aca8 with SMTP id
 w17-20020a170907271100b009a1b967aca8mr7502130ejk.4.1694431924924; 
 Mon, 11 Sep 2023 04:32:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmeUbKx1QcjV9OUOGOK8qE8r6QZSRN6k1lpialEeCRQd3Hj5sYgEl0AiAM14oVbAZ/Q1D+hA==
X-Received: by 2002:a17:907:2711:b0:9a1:b967:aca8 with SMTP id
 w17-20020a170907271100b009a1b967aca8mr7502115ejk.4.1694431924571; 
 Mon, 11 Sep 2023 04:32:04 -0700 (PDT)
Received: from redhat.com ([2.52.12.107]) by smtp.gmail.com with ESMTPSA id
 l15-20020a1709066b8f00b0099bca8b9a31sm5139817ejr.100.2023.09.11.04.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 04:32:03 -0700 (PDT)
Date: Mon, 11 Sep 2023 07:32:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: Should pcie-pci-bridge use 32-bit non-prefetchable memory?
Message-ID: <20230911062751-mutt-send-email-mst@kernel.org>
References: <6a0b9345-a447-4cf9-ba9a-88c420e7ab79@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a0b9345-a447-4cf9-ba9a-88c420e7ab79@linaro.org>
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

On Mon, Sep 11, 2023 at 12:17:13PM +0200, Marcin Juszkiewicz wrote:
> I am working on aarch64/sbsa-ref machine so people can have virtual
> machine to test their OS against something reminding standards compliant
> system.
> 
> One of tools I use is BSA ACS (Base System Architecture - Architecture
> Compliance Suite) [1] written by Arm. It runs set of tests to check does
> system conforms to BSA specification.
> 
> 1. https://github.com/ARM-software/bsa-acs
> 
> To run tests I use my "boot-sbsa-ref.sh" script [2] which allows me to
> run exactly same setup each time.
> 
> 2. https://github.com/hrw/sbsa-ref-status/blob/main/boot-sbsa-ref.sh
> 
> Since we have ITS support in whole stack (qemu, tf-a, edk2) I use
> overcomplicated PCIe setup:
> 
> -device igb
> -device pcie-root-port,id=root_port_for_switch1,chassis=0,slot=0
>  -device x3130-upstream,id=upstream_port1,bus=root_port_for_switch1
>   -device xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=1,slot=0
>    -device ac97,bus=downstream_port1
> -device pcie-root-port,id=root_port_for_nvme1,chassis=2,slot=0
>  -device nvme,serial=deadbeef,bus=root_port_for_nvme1
> -device pcie-root-port,id=root_port_for_igb,chassis=3,slot=0
>  -device igb,bus=root_port_for_igb
> -device pcie-root-port,id=root_port_for_xhci,chassis=4,slot=0
>  -device qemu-xhci,bus=root_port_for_xhci
> -device pcie-root-port,id=root_port_for_rng,chassis=5,slot=0
>  -device virtio-rng-pci,bus=root_port_for_rng
> -device pcie-root-port,id=root_port_for_pci,chassis=6,slot=0
>  -device pcie-pci-bridge,id=pci,bus=root_port_for_pci
>   -device es1370,bus=pci,addr=9
>   -device e1000,bus=pci,addr=10
> -device pxb-pcie,id=pxb1,bus_nr=1
>  -device pcie-root-port,id=root_port_for_ahci,bus=pxb1,chassis=10,slot=0
>   -device ahci,bus=root_port_for_ahci
> 
> BSA ACS test 841 checks do Type-1 PCIe devices have 32-bit
> non-prefetchable memory. And fails on pcie-pci-bridge:
> 
> Operating System View:
>  841 : NP type-1 PCIe supp 32-bit only                START
> 
>        BDF - 0x400
>        BDF - 0x500
>        BDF - 0x600
>        BDF - 0x700
>        BDF - 0x800
>        BDF - 0x900
>        BDF - 0x10000
>        BDF - 0x30000
>        Skipping Non Type-1 headers
>        BDF - 0x40000
>        Skipping Non Type-1 headers
>        BDF - 0x50000
>        Skipping Non Type-1 headers
>        BDF - 0x60000
>        Skipping Non Type-1 headers
>        BDF - 0x70000
>        NP type-1 pcie is not 32-bit mem type
>        Failed on PE -    0
>        PCI_MM_04
>        Checkpoint --  1                           : Result:  FAIL
> 
> 0x70000 is pcie-pci-bridge card.
> 
> I opened issue for BSA ACS [3] and asked where the problem is.
> 
> 3. https://github.com/ARM-software/bsa-acs/issues/197
> 
> Got quote from BSA (Arm Base System Architecture) [4]
> chapter E.2 PCI Express Memory Space:
> 
> > When PCI Express memory space is mapped as normal memory, the system
> > must support unaligned accesses to that region.
> > PCI Type 1 headers, used in PCI-to-PCI bridges, and therefore in root
> > ports and switches, have to be programmed with the address space
> > resources claimed by the given bridge.
> > For non-prefetchable (NP) memory, Type 1 headers only support 32-bit
> > addresses. This implies that endpoints on the other end of a
> > PCI-to-PCI bridge only support 32-bit NP BARs
> 
> 4. https://developer.arm.com/documentation/den0094/latest/
> 
> 
> I looked at code and tried to switch pcie-pci-bridge to 32-bit:
> 
> ------------------------------------------------------------------------
> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
> index 2301b2ca0b..45199d2fa0 100644
> --- a/hw/pci-bridge/pcie_pci_bridge.c
> +++ b/hw/pci-bridge/pcie_pci_bridge.c
> @@ -82,7 +82,7 @@ static void pcie_pci_bridge_realize(PCIDevice *d, Error **errp)
>          }
>      }
>      pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
> -                     PCI_BASE_ADDRESS_MEM_TYPE_64, &pcie_br->shpc_bar);
> +                     PCI_BASE_ADDRESS_MEM_TYPE_32, &pcie_br->shpc_bar);
>      return;
> 
>  msi_error:
> 
> ------------------------------------------------------------------------
> 
> With it, test 841 passes.
> 
> The difference in "lspci -vvvv" output suggests that this region address
> was 32-bit in both cases:
> 
> -       Region 0: Memory at 81c00000 (64-bit, non-prefetchable) [size=256]
> +       Region 0: Memory at 81c00000 (32-bit, non-prefetchable) [size=256]
> 
> Any ideas how to continue from here?

It's a bug in BSA spec then. PCI Express allows 64 bit non prefetcheable
BARs in devices even though the top 32 bit just goes unused on all
systems.

Try to raise this with them?

but the express spec also says:

On PCI Express systems that meet the criteria enumerated below, setting the Prefetchable bit in a candidate BAR
will still permit correct operation even if the BAR’s range includes some locations that have read side-effects or
cannot tolerate write merging. This is primarily due to the fact that PCI Express Memory Reads always contain an
explicit length, and PCI Express Switches never prefetch or do byte merging. Generally only 64-bit BARs are good
candidates, since only Legacy Endpoints are permitted to set the Prefetchable bit in 32-bit BARs, and most
scalable platforms map all 32-bit Memory BARs into non-prefetchable Memory Space regardless of the
Prefetchable bit value.
Here are criteria that are sufficient to guarantee correctness for a given candidate BAR:
• The entire path from the host to the adapter is over PCI Express.
• No conventional PCI or PCI-X devices do peer-to-peer reads to the range mapped by the BAR.
• The PCI Express Host Bridge does no byte merging. (This is believed to be true on most platforms.)
• Any locations with read side-effects are never the target of Memory Reads with the TH bit Set. See
§ Section 2.2.5 .
• The range mapped by the BAR is never the target of a speculative Memory Read, either Host initiated or
peer-to-peer.

I need to look into implications of the TH bit, but maybe it's ok to map
SHPC prefetcheable.
-- 
MST


