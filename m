Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B047B7A4AFD
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:11:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiExz-000140-E7; Mon, 18 Sep 2023 10:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiExx-00013l-Bh
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiExr-00056I-Ey
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695046262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ja98jl7alXy7zPYF2+Y292IOZIFEOFLNuT/5WFq65CI=;
 b=XgsWTTSp2SpzsVGyX/Ehgdgcfji98eh91wIU/Y8tRrdqTqFGpu0f0Utfa1OJpZsrJgwfYR
 2bj6SDC9fP9pcjLHy+EUEY3pNJ6Gr9tPDtYr1Gl/GXaYs9fGKDQ1+EjUQ/WsfMKn2wSurv
 Mbt6lPTvtDaAlEaVB/4v01M+jamRD5o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-nGXjPV8GOjGp_P-M0Rax5Q-1; Mon, 18 Sep 2023 10:10:58 -0400
X-MC-Unique: nGXjPV8GOjGp_P-M0Rax5Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-993d7ca4607so327809266b.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 07:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695046257; x=1695651057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ja98jl7alXy7zPYF2+Y292IOZIFEOFLNuT/5WFq65CI=;
 b=jEBJCjTv+ktTDmhK7p5quNY3rIdDxJg1EA89bHMcdU05/ZBUbcaGaRnCQ6xtlg6QHZ
 3H5318fo00NL4oOxzCuPY0/OxkHoL7eVBlonbrV1G/V2q/TNs9khVWtl3B+aI55DxtNN
 iBu6GJU1AolMGFtWsXiD9UhKKUUrFIp5s6v9Juhb7osbNnll6PmOFTk0ZSqkI95BHywE
 BqqrX1L5hMFo+8NZ8OI4zrXj+p1zAu6by4b3pqZKQiMslVX8o5oVqIcrpeblpoJvXtxh
 GPwuvwThLyet0hGSslpcKxge8/vjLnzAd/T4vum1sVTL6kbEM7quUzsp0qnYUro2qRzc
 baZw==
X-Gm-Message-State: AOJu0YxtYeYo/zYpflqkdB7CjGCo6w14+ydu2J21YMeNWjyYbSX/xJUs
 i6eQfnp/0F3st9sSDgRm5wXCao9zi3TbZ/Sgfuun/n6ZpnMfHlZCNonQEha4KXiXPczJ71uKVhq
 US0HoMzNWH9MoZYwP1Hj+pX+kSfrOJLI=
X-Received: by 2002:a17:906:535d:b0:9a1:fb4c:3b65 with SMTP id
 j29-20020a170906535d00b009a1fb4c3b65mr7469777ejo.14.1695046257551; 
 Mon, 18 Sep 2023 07:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAfAN67p1OaPovEl3fPdJY98sRpKlVWOQAE+Te2Qxrf2jXyMvug95js3pbpnonWRIpiLTFmgBERGnxjkLb5QQ=
X-Received: by 2002:a17:906:535d:b0:9a1:fb4c:3b65 with SMTP id
 j29-20020a170906535d00b009a1fb4c3b65mr7469767ejo.14.1695046257153; Mon, 18
 Sep 2023 07:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135448.90963-1-anisinha@redhat.com>
 <20230918095905-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230918095905-mutt-send-email-mst@kernel.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 18 Sep 2023 19:40:45 +0530
Message-ID: <CAK3XEhOH_hpykKx7k_ak-rz5SzanP9s+tLgEUVaNk3MYkA9r-g@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: david@redhat.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, philmd@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

On Mon, Sep 18, 2023 at 7:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Sep 18, 2023 at 07:24:48PM +0530, Ani Sinha wrote:
> > 32-bit systems do not have a reserved memory for hole64 but they may ha=
ve a
> > reserved memory space for memory hotplug. Since, hole64 starts after th=
e
> > reserved hotplug memory, the unaligned hole64 start address gives us th=
e
> > end address for this memory hotplug region that the processor may use.
> > Fix this. This ensures that the physical address space bound checking w=
orks
> > correctly for 32-bit systems as well.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
>
>
> I doubt we can make changes like this without compat machinery. No?

Is that for not breaking migration or being backward compatible
(something which was broken in the first place used to work but now
its doesnt because we fixed it?)

>
> > ---
> >  hw/i386/pc.c | 60 ++++++++++++++++++++++++++++++----------------------
> >  1 file changed, 35 insertions(+), 25 deletions(-)
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 54838c0c41..c8abcabd53 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -904,13 +904,43 @@ static uint64_t pc_get_cxl_range_end(PCMachineSta=
te *pcms)
> >      return start;
> >  }
> >
> > +/*
> > + * The 64bit pci hole starts after "above 4G RAM" and
> > + * potentially the space reserved for memory hotplug.
> > + * This function returns unaligned start address.
> > + */
> > +static uint64_t pc_pci_hole64_start_unaligned(void)
> > +{
> > +    PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
> > +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> > +    MachineState *ms =3D MACHINE(pcms);
> > +    uint64_t hole64_start =3D 0;
> > +    ram_addr_t size =3D 0;
> > +
> > +    if (pcms->cxl_devices_state.is_enabled) {
> > +        hole64_start =3D pc_get_cxl_range_end(pcms);
> > +    } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram=
_size)) {
> > +        pc_get_device_memory_range(pcms, &hole64_start, &size);
> > +        if (!pcmc->broken_reserved_end) {
> > +            hole64_start +=3D size;
> > +        }
> > +    } else {
> > +        hole64_start =3D pc_above_4g_end(pcms);
> > +    }
> > +
> > +    return hole64_start;
> > +}
> > +
> >  static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole6=
4_size)
> >  {
> >      X86CPU *cpu =3D X86_CPU(first_cpu);
> >
> > -    /* 32-bit systems don't have hole64 thus return max CPU address */
> > -    if (cpu->phys_bits <=3D 32) {
> > -        return ((hwaddr)1 << cpu->phys_bits) - 1;
> > +    /*
> > +     * 32-bit systems don't have hole64, but we might have a region fo=
r
> > +     * memory hotplug.
> > +     */
> > +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
> > +        return pc_pci_hole64_start_unaligned() - 1;
> >      }
> >
>
> I see you are changing cpu->phys_bits to a CPUID check.
> Could you explain why in the commit log?

Yeah missed that but will do in v2.

>
> >      return pc_pci_hole64_start() + pci_hole64_size - 1;
> > @@ -1147,30 +1177,10 @@ void pc_memory_init(PCMachineState *pcms,
> >      pcms->memhp_io_base =3D ACPI_MEMORY_HOTPLUG_BASE;
> >  }
> >
> > -/*
> > - * The 64bit pci hole starts after "above 4G RAM" and
> > - * potentially the space reserved for memory hotplug.
> > - */
> > +/* returns 1 GiB aligned hole64 start address */
> >  uint64_t pc_pci_hole64_start(void)
> >  {
> > -    PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
> > -    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> > -    MachineState *ms =3D MACHINE(pcms);
> > -    uint64_t hole64_start =3D 0;
> > -    ram_addr_t size =3D 0;
> > -
> > -    if (pcms->cxl_devices_state.is_enabled) {
> > -        hole64_start =3D pc_get_cxl_range_end(pcms);
> > -    } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram=
_size)) {
> > -        pc_get_device_memory_range(pcms, &hole64_start, &size);
> > -        if (!pcmc->broken_reserved_end) {
> > -            hole64_start +=3D size;
> > -        }
> > -    } else {
> > -        hole64_start =3D pc_above_4g_end(pcms);
> > -    }
> > -
> > -    return ROUND_UP(hole64_start, 1 * GiB);
> > +    return ROUND_UP(pc_pci_hole64_start_unaligned(), 1 * GiB);
> >  }
> >
> >  DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
> > --
> > 2.39.1
>


