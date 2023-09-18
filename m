Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 165497A50F2
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiI1c-0005GR-Ot; Mon, 18 Sep 2023 13:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qiI1Z-0005Fr-MV
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qiI1X-0004EX-QI
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695058022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=urIvxsoNNN8bzRtONHaug0/w/dSlkWIXS9KxVuTn/pw=;
 b=KeXOKsz2TekWambOKAlU5lrt1btqMhma1WDzBUke6m7KxEztC9BoeY8vHGlUDRtfK03qgz
 iir9e76PcEtfi5lbFX7Ovyil5GD9wLnRd+iVOAooIHcofu1DDCOzLMGG/2pcW3Z8vPSHs0
 7ThsybWkEdLKbyqjM3U3+qvipFaXsOc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-iHEakid4PqCi0Ojk73jzWQ-1; Mon, 18 Sep 2023 13:27:01 -0400
X-MC-Unique: iHEakid4PqCi0Ojk73jzWQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9ad8ab8bc9fso333926266b.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 10:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695058020; x=1695662820;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=urIvxsoNNN8bzRtONHaug0/w/dSlkWIXS9KxVuTn/pw=;
 b=diNnGuEPq9M2Tzdn1IiEOSowmhnDNfaNsV9//iT6Vku/Idh6LxQN7joZJUKzd8Dqlc
 /y342ITAqlRm61UTBNGONWa+RsLl7LbVASDqChy32yT8j0Af4A6fRW0s8HRqthuLn7Ul
 cvIUVXzz8QEZDmNGhLtllblWo1cCzO02T4E5iwb3YZbOz3fthsNS2yZnT7oo7z2udE/w
 WTQCkVLPJg20UPrghb1XuDNngeH+TnCoQnfEzhkmGSjOwzuHgoM5ydhbX6T+1tpM8SWW
 lAYnPa+aRTDiTVBvFEOKxZDwUni9r9v/l96+88u4KJObm5OnZCGsc+I6XQP+x4HYRbXf
 QXCQ==
X-Gm-Message-State: AOJu0Yx63JjhNdBhDI3+QQWKr0ROz6xK48tSh4cP7wXujTHXdnfvtSdn
 tTug2MFZcBWfhrMPCzQm7FV5inl03bRrIjgrNsqPQYYQEhDsT1Azp6WY1nt2oSf1NPJ+9+Z4gmF
 sqkdJ2ebE/icJFLc=
X-Received: by 2002:a17:907:270a:b0:9ad:8782:3d7 with SMTP id
 w10-20020a170907270a00b009ad878203d7mr7820766ejk.51.1695058020048; 
 Mon, 18 Sep 2023 10:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsJrQLEQ3kWmiAQOUCCCQsNX+HpEFxCZ3XGAd+laLX6r3UqNn/9oeL4CtUz8f4nnWzvWEJsA==
X-Received: by 2002:a17:907:270a:b0:9ad:8782:3d7 with SMTP id
 w10-20020a170907270a00b009ad878203d7mr7820755ejk.51.1695058019746; 
 Mon, 18 Sep 2023 10:26:59 -0700 (PDT)
Received: from redhat.com ([2.52.3.35]) by smtp.gmail.com with ESMTPSA id
 p8-20020a1709061b4800b0099c53c44083sm6717728ejg.79.2023.09.18.10.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 10:26:59 -0700 (PDT)
Date: Mon, 18 Sep 2023 13:26:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: david@redhat.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, philmd@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
Message-ID: <20230918132631-mutt-send-email-mst@kernel.org>
References: <20230918135448.90963-1-anisinha@redhat.com>
 <20230918095905-mutt-send-email-mst@kernel.org>
 <CAK3XEhOH_hpykKx7k_ak-rz5SzanP9s+tLgEUVaNk3MYkA9r-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3XEhOH_hpykKx7k_ak-rz5SzanP9s+tLgEUVaNk3MYkA9r-g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 18, 2023 at 07:40:45PM +0530, Ani Sinha wrote:
> On Mon, Sep 18, 2023 at 7:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 18, 2023 at 07:24:48PM +0530, Ani Sinha wrote:
> > > 32-bit systems do not have a reserved memory for hole64 but they may have a
> > > reserved memory space for memory hotplug. Since, hole64 starts after the
> > > reserved hotplug memory, the unaligned hole64 start address gives us the
> > > end address for this memory hotplug region that the processor may use.
> > > Fix this. This ensures that the physical address space bound checking works
> > > correctly for 32-bit systems as well.
> > >
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >
> >
> > I doubt we can make changes like this without compat machinery. No?
> 
> Is that for not breaking migration or being backward compatible
> (something which was broken in the first place used to work but now
> its doesnt because we fixed it?)

migration mostly.

> >
> > > ---
> > >  hw/i386/pc.c | 60 ++++++++++++++++++++++++++++++----------------------
> > >  1 file changed, 35 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index 54838c0c41..c8abcabd53 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -904,13 +904,43 @@ static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
> > >      return start;
> > >  }
> > >
> > > +/*
> > > + * The 64bit pci hole starts after "above 4G RAM" and
> > > + * potentially the space reserved for memory hotplug.
> > > + * This function returns unaligned start address.
> > > + */
> > > +static uint64_t pc_pci_hole64_start_unaligned(void)
> > > +{
> > > +    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
> > > +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> > > +    MachineState *ms = MACHINE(pcms);
> > > +    uint64_t hole64_start = 0;
> > > +    ram_addr_t size = 0;
> > > +
> > > +    if (pcms->cxl_devices_state.is_enabled) {
> > > +        hole64_start = pc_get_cxl_range_end(pcms);
> > > +    } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
> > > +        pc_get_device_memory_range(pcms, &hole64_start, &size);
> > > +        if (!pcmc->broken_reserved_end) {
> > > +            hole64_start += size;
> > > +        }
> > > +    } else {
> > > +        hole64_start = pc_above_4g_end(pcms);
> > > +    }
> > > +
> > > +    return hole64_start;
> > > +}
> > > +
> > >  static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
> > >  {
> > >      X86CPU *cpu = X86_CPU(first_cpu);
> > >
> > > -    /* 32-bit systems don't have hole64 thus return max CPU address */
> > > -    if (cpu->phys_bits <= 32) {
> > > -        return ((hwaddr)1 << cpu->phys_bits) - 1;
> > > +    /*
> > > +     * 32-bit systems don't have hole64, but we might have a region for
> > > +     * memory hotplug.
> > > +     */
> > > +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
> > > +        return pc_pci_hole64_start_unaligned() - 1;
> > >      }
> > >
> >
> > I see you are changing cpu->phys_bits to a CPUID check.
> > Could you explain why in the commit log?
> 
> Yeah missed that but will do in v2.
> 
> >
> > >      return pc_pci_hole64_start() + pci_hole64_size - 1;
> > > @@ -1147,30 +1177,10 @@ void pc_memory_init(PCMachineState *pcms,
> > >      pcms->memhp_io_base = ACPI_MEMORY_HOTPLUG_BASE;
> > >  }
> > >
> > > -/*
> > > - * The 64bit pci hole starts after "above 4G RAM" and
> > > - * potentially the space reserved for memory hotplug.
> > > - */
> > > +/* returns 1 GiB aligned hole64 start address */
> > >  uint64_t pc_pci_hole64_start(void)
> > >  {
> > > -    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
> > > -    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> > > -    MachineState *ms = MACHINE(pcms);
> > > -    uint64_t hole64_start = 0;
> > > -    ram_addr_t size = 0;
> > > -
> > > -    if (pcms->cxl_devices_state.is_enabled) {
> > > -        hole64_start = pc_get_cxl_range_end(pcms);
> > > -    } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
> > > -        pc_get_device_memory_range(pcms, &hole64_start, &size);
> > > -        if (!pcmc->broken_reserved_end) {
> > > -            hole64_start += size;
> > > -        }
> > > -    } else {
> > > -        hole64_start = pc_above_4g_end(pcms);
> > > -    }
> > > -
> > > -    return ROUND_UP(hole64_start, 1 * GiB);
> > > +    return ROUND_UP(pc_pci_hole64_start_unaligned(), 1 * GiB);
> > >  }
> > >
> > >  DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
> > > --
> > > 2.39.1
> >


