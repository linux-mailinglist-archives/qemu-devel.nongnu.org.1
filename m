Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB73E7B50A3
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 12:49:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnGSi-0007MU-Lg; Mon, 02 Oct 2023 06:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnGSc-0007M1-Sv
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnGSa-0005eO-P2
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696243650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4PR4gnqODXZvzWtJo8NjKRN7tqY5UWSGF8/CuL+gH8=;
 b=CaJjwQEgi2B4A7vyYMdn9o0i1WWqwW4SEDrSFjjFlYmQDxtqTBHH0INOW/zMN9bXPBy8Xo
 MzRAgOWke3rI2XcINHOscvmC2mBHe2mqvwsGQdjEVaJHXArL4Snm8igh4mxyaPhWEPx2gs
 oc1CdESPtuya5YQrW4tFeY6yJQvAyPM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-m3JdZqfNMzSfbSYCwPdHnQ-1; Mon, 02 Oct 2023 06:47:29 -0400
X-MC-Unique: m3JdZqfNMzSfbSYCwPdHnQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-313c930ee0eso12137370f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 03:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696243648; x=1696848448;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+4PR4gnqODXZvzWtJo8NjKRN7tqY5UWSGF8/CuL+gH8=;
 b=UoXjIozNkw6RX1VOqxGZNgi/EtnbHEDaGZI/KwaUWBX457Fg+apVr1I41t9BU8RAHr
 BTI34INBIfcfJ7Z/kHgdIIgQKljkf+INqc4eEHHAC8ne9CzaHPiFLAg9e6HBnXjCuq5m
 msHmaQ419lWKk+Aqr7GziXbG2XuzHPI0q2eg6XokmDaCyg4tGVuJNXnxkRkaNNlhhZSo
 mpcaLhYopqd55XVAo1XxnwbT+K1li1yPt6rK61Fd0PTwdLvbTv2kLosWPDKyE5OH7zWz
 wYLQLOWeFB3+y4Sceu3s5npgZLMCToZzMz0dxH1gBVvquJPM9FRtNTZPJTSu9amBAAUx
 izxw==
X-Gm-Message-State: AOJu0YyjbnCfFOFkzsm8xyVpnVzhWv6/4G6aV5EqJec45zx4Itpov34M
 LztK7RTzrEoAH8ZqwJaL45vTSQ/5CNi3e2GUsHAJq3XT7CuXzijsVoQRzi1CAkQWpJpc6yrCnzY
 ZZwqhy1+WxsQ0+kE=
X-Received: by 2002:adf:e909:0:b0:323:1887:dd6d with SMTP id
 f9-20020adfe909000000b003231887dd6dmr8989659wrm.3.1696243648103; 
 Mon, 02 Oct 2023 03:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8xhIBFTEoNISL+Vd6mrvVQyYnF7G2yuIDUniaChbxR1UmBi4zY4ImGfa11pd8om1xL01smg==
X-Received: by 2002:adf:e909:0:b0:323:1887:dd6d with SMTP id
 f9-20020adfe909000000b003231887dd6dmr8989642wrm.3.1696243647743; 
 Mon, 02 Oct 2023 03:47:27 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 d12-20020adf9c8c000000b00324887a13f7sm9582645wre.0.2023.10.02.03.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 03:47:26 -0700 (PDT)
Date: Mon, 2 Oct 2023 06:47:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 =?iso-8859-1?B?IkRhbmllbCBQIC4gQmVycmFuZ+ki?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/i386: changes towards enabling -Wshadow=local
Message-ID: <20231002053024-mutt-send-email-mst@kernel.org>
References: <20230926055235.9164-1-anisinha@redhat.com>
 <20230927112144-mutt-send-email-mst@kernel.org>
 <00B810C8-CB14-40F6-AB54-3AE7CB63B93F@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00B810C8-CB14-40F6-AB54-3AE7CB63B93F@redhat.com>
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

On Thu, Sep 28, 2023 at 09:14:07AM +0530, Ani Sinha wrote:
> 
> 
> > On 27-Sep-2023, at 8:55 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Tue, Sep 26, 2023 at 11:22:35AM +0530, Ani Sinha wrote:
> >> Code changes that addresses all compiler complaints coming from enabling
> >> -Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
> >> other local variables or parameters. These makes the code confusing and/or adds
> > 
> > These make
> > 
> >> bugs that are difficult to catch.
> >> 
> >> CC: Markus Armbruster <armbru@redhat.com>
> >> CC: Philippe Mathieu-Daude <philmd@linaro.org>
> >> CC: mst@redhat.com
> >> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> >> Reviewed-by: Peter Xu <peterx@redhat.com>
> >> ---
> > 
> > 
> > chunks seem unrelated. why not split them up?
> 
> ? No idea what you talking about. Here and ...

you patch 4 files in a single patch.
intel_iommu is part of vtd emulation and
has separate maintainers. Slightly better to split up
to have each maintainer get just the patches
he cares about.
Not critical, for sure.


> > 
> >> hw/i386/acpi-microvm.c | 12 ++++++------
> >> hw/i386/intel_iommu.c  |  8 ++++----
> >> hw/i386/pc.c           |  1 -
> >> hw/i386/x86.c          |  2 --
> >> 4 files changed, 10 insertions(+), 13 deletions(-)
> >> 
> >> changelog:
> >> v2: kept Peter's changes from https://lore.kernel.org/r/20230922160410.138786-1-peterx@redhat.com
> >> and removed mine.
> >> 
> >> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> >> index a075360d85..6e4f8061eb 100644
> >> --- a/hw/i386/acpi-microvm.c
> >> +++ b/hw/i386/acpi-microvm.c
> >> @@ -78,18 +78,18 @@ static void acpi_dsdt_add_virtio(Aml *scope,
> >>             hwaddr base = VIRTIO_MMIO_BASE + index * 512;
> >>             hwaddr size = 512;
> >> 
> >> -            Aml *dev = aml_device("VR%02u", (unsigned)index);
> >> -            aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
> >> -            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
> >> -            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> >> +            Aml *adev = aml_device("VR%02u", (unsigned)index);
> >> +            aml_append(adev, aml_name_decl("_HID", aml_string("LNRO0005")));
> >> +            aml_append(adev, aml_name_decl("_UID", aml_int(index)));
> >> +            aml_append(adev, aml_name_decl("_CCA", aml_int(1)));
> >> 
> >>             Aml *crs = aml_resource_template();
> >>             aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
> >>             aml_append(crs,
> >>                        aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
> >>                                      AML_EXCLUSIVE, &irq, 1));
> >> -            aml_append(dev, aml_name_decl("_CRS", crs));
> >> -            aml_append(scope, dev);
> >> +            aml_append(adev, aml_name_decl("_CRS", crs));
> >> +            aml_append(scope, adev);
> >>         }
> >>     }
> >> }
> > 
> > I would prefer to just drop the devicestate dev pointer, use kid->child inside the
> > macro.
> 
> Here …
> 

Well, you renamed dev to adev because there's another dev at
an outer scope which is set to kid->child, and only used
once. I suggest just dropping that one instead of removing
this one.


> > 
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index c0ce896668..2c832ab68b 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -3744,7 +3744,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
> >> /* Unmap the whole range in the notifier's scope. */
> >> static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
> >> {
> >> -    hwaddr size, remain;
> >> +    hwaddr total, remain;
> >>     hwaddr start = n->start;
> >>     hwaddr end = n->end;
> >>     IntelIOMMUState *s = as->iommu_state;
> >> @@ -3765,7 +3765,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
> >>     }
> >> 
> >>     assert(start <= end);
> >> -    size = remain = end - start + 1;
> >> +    total = remain = end - start + 1;
> >> 
> >>     while (remain >= VTD_PAGE_SIZE) {
> >>         IOMMUTLBEvent event;
> >> @@ -3793,10 +3793,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
> >>     trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
> >>                              VTD_PCI_SLOT(as->devfn),
> >>                              VTD_PCI_FUNC(as->devfn),
> >> -                             n->start, size);
> >> +                             n->start, total);
> >> 
> >>     map.iova = n->start;
> >> -    map.size = size - 1; /* Inclusive */
> >> +    map.size = total - 1; /* Inclusive */
> >>     iova_tree_remove(as->iova_tree, map);
> >> }
> >> 
> > 
> > 
> > arguably an improvement
> > 
> > 
> >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> index 3db0743f31..e7a233e886 100644
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -1116,7 +1116,6 @@ void pc_memory_init(PCMachineState *pcms,
> >> 
> >>     if (machine->device_memory) {
> >>         uint64_t *val = g_malloc(sizeof(*val));
> >> -        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> >>         uint64_t res_mem_end = machine->device_memory->base;
> >> 
> >>         if (!pcmc->broken_reserved_end) {
> >> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> >> index f034df8bf6..b3d054889b 100644
> >> --- a/hw/i386/x86.c
> >> +++ b/hw/i386/x86.c
> >> @@ -365,8 +365,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >> 
> >>     cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
> >>     if (!cpu_slot) {
> >> -        MachineState *ms = MACHINE(x86ms);
> >> -
> >>         x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> >>         error_setg(errp,
> >>             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
> > 
> > 
> > killing dead code, nice
> > 
> >> -- 
> >> 2.39.3


