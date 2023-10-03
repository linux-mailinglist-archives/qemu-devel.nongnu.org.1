Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE4E7B6088
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 07:52:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnYJx-0005Mm-Sy; Tue, 03 Oct 2023 01:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnYJw-0005Me-Bz
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 01:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnYJu-0003iA-Iq
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 01:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696312306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=miTFVY+uLAUGKzHbSoYxsJebD4rQSgUIjkFXPsaF4+c=;
 b=dxis4zmrvsVENohD0K5S3zWIvha8zn7pNH0opZ+nhIjl9H88dBxu048krH1faGPftdh4ph
 wtBXwevAS6AYAnThWbX0L15/pKI33GCVnJCYDHpq9h8dzdMfTJ2MdOerGvUle0FW3IpN+w
 524/7VJC9CBmXdxYlEebwTL+7B3/jmY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-qdj93riPNEuyjVETA_5M5w-1; Tue, 03 Oct 2023 01:51:37 -0400
X-MC-Unique: qdj93riPNEuyjVETA_5M5w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a9e12a3093so57063066b.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 22:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696312296; x=1696917096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=miTFVY+uLAUGKzHbSoYxsJebD4rQSgUIjkFXPsaF4+c=;
 b=Pa0Cm3oqASWFlTI6Wou4x4XClu0mv8ZCr4aw6vACeodxqDcMpK/BjbqKaW/ksy6AZg
 3aXMx0uXePx3/XUXH1/XSetck/H+JdScivWRI62cbIiA0EFQbA8QdYDe5tEyfoRn/H9W
 +FIFfE3/5MF4ZgGCacNl9XZKIUrNRKMmyJcDSHO3XGJZKhE1AdzfUJnR5pTI1Gebdo2o
 hy4b94JxQB9SSwIVK+LwfyAR8IPgn8rLxVReRNWhWIx/zmbv6gQWVq6hDmh4EicoT8LV
 yGCmsX+9bvXpCCn9TycmSPPCXTBHclKiJsdnKMvK3+qvgwyMwfCddDAPdXeCmZ2aCGVy
 /RfA==
X-Gm-Message-State: AOJu0YxPF/4rNSfO4pSi/fdyLC21YSXvHdzWDmDX4hy7EWuCkDtXi3HO
 5z+g2RkC+tM6vPSMWChKb+YNoHSVyKTUeTyCzI4IPuSIsl5NMpi/f1uz2+t84yc0Xac7WJj3FpN
 VGYTos93L07sSjicjMz9znAO5cT/4448=
X-Received: by 2002:a17:907:1c11:b0:9ad:8a96:ad55 with SMTP id
 nc17-20020a1709071c1100b009ad8a96ad55mr1604485ejc.14.1696312296698; 
 Mon, 02 Oct 2023 22:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6TA0DnvZxct6GIAal8l8jpzzUe1EWD/Yt+agHaMOia3TUY+tksTM4FbW8sxDAbaCcDR5+oSbW5MJKwtmgHjg=
X-Received: by 2002:a17:907:1c11:b0:9ad:8a96:ad55 with SMTP id
 nc17-20020a1709071c1100b009ad8a96ad55mr1604470ejc.14.1696312296369; Mon, 02
 Oct 2023 22:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230926055235.9164-1-anisinha@redhat.com>
 <20230927112144-mutt-send-email-mst@kernel.org>
 <00B810C8-CB14-40F6-AB54-3AE7CB63B93F@redhat.com>
 <20231002053024-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231002053024-mutt-send-email-mst@kernel.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 3 Oct 2023 11:21:25 +0530
Message-ID: <CAK3XEhOhwvc88rP=Y5j52H6gAqvoXRRrU1YgcznY_yrusP8hwQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386: changes towards enabling -Wshadow=local
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

On Mon, Oct 2, 2023 at 4:17=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Sep 28, 2023 at 09:14:07AM +0530, Ani Sinha wrote:
> >
> >
> > > On 27-Sep-2023, at 8:55 PM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> > >
> > > On Tue, Sep 26, 2023 at 11:22:35AM +0530, Ani Sinha wrote:
> > >> Code changes that addresses all compiler complaints coming from enab=
ling
> > >> -Wshadow flags. Enabling -Wshadow catches cases of local variables s=
hadowing
> > >> other local variables or parameters. These makes the code confusing =
and/or adds
> > >
> > > These make
> > >
> > >> bugs that are difficult to catch.
> > >>
> > >> CC: Markus Armbruster <armbru@redhat.com>
> > >> CC: Philippe Mathieu-Daude <philmd@linaro.org>
> > >> CC: mst@redhat.com
> > >> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
> > >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > >> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > >> Reviewed-by: Peter Xu <peterx@redhat.com>
> > >> ---
> > >
> > >
> > > chunks seem unrelated. why not split them up?
> >
> > ? No idea what you talking about. Here and ...
>
> you patch 4 files in a single patch.
> intel_iommu is part of vtd emulation and
> has separate maintainers. Slightly better to split up
> to have each maintainer get just the patches
> he cares about.
> Not critical, for sure.

this was from the original email that Markus sent that had this group:

X86 Machines
------------
PC
M: Michael S. Tsirkin <mst@redhat.com>
M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
   hw/i386/acpi-build.c(*3*)
   hw/i386/acpi-microvm.c(*2*)
   hw/i386/intel_iommu.c(*3*)
   hw/i386/pc.c(*2*)
   hw/i386/x86.c(*2*)

Not sure why it was clubbed with others.

>
>
> > >
> > >> hw/i386/acpi-microvm.c | 12 ++++++------
> > >> hw/i386/intel_iommu.c  |  8 ++++----
> > >> hw/i386/pc.c           |  1 -
> > >> hw/i386/x86.c          |  2 --
> > >> 4 files changed, 10 insertions(+), 13 deletions(-)
> > >>
> > >> changelog:
> > >> v2: kept Peter's changes from https://lore.kernel.org/r/202309221604=
10.138786-1-peterx@redhat.com
> > >> and removed mine.
> > >>
> > >> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> > >> index a075360d85..6e4f8061eb 100644
> > >> --- a/hw/i386/acpi-microvm.c
> > >> +++ b/hw/i386/acpi-microvm.c
> > >> @@ -78,18 +78,18 @@ static void acpi_dsdt_add_virtio(Aml *scope,
> > >>             hwaddr base =3D VIRTIO_MMIO_BASE + index * 512;
> > >>             hwaddr size =3D 512;
> > >>
> > >> -            Aml *dev =3D aml_device("VR%02u", (unsigned)index);
> > >> -            aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0=
005")));
> > >> -            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
> > >> -            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> > >> +            Aml *adev =3D aml_device("VR%02u", (unsigned)index);
> > >> +            aml_append(adev, aml_name_decl("_HID", aml_string("LNRO=
0005")));
> > >> +            aml_append(adev, aml_name_decl("_UID", aml_int(index)))=
;
> > >> +            aml_append(adev, aml_name_decl("_CCA", aml_int(1)));
> > >>
> > >>             Aml *crs =3D aml_resource_template();
> > >>             aml_append(crs, aml_memory32_fixed(base, size, AML_READ_=
WRITE));
> > >>             aml_append(crs,
> > >>                        aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_AC=
TIVE_HIGH,
> > >>                                      AML_EXCLUSIVE, &irq, 1));
> > >> -            aml_append(dev, aml_name_decl("_CRS", crs));
> > >> -            aml_append(scope, dev);
> > >> +            aml_append(adev, aml_name_decl("_CRS", crs));
> > >> +            aml_append(scope, adev);
> > >>         }
> > >>     }
> > >> }
> > >
> > > I would prefer to just drop the devicestate dev pointer, use kid->chi=
ld inside the
> > > macro.

good idea. addressed in v2.

> >
> > Here =E2=80=A6
> >
>
> Well, you renamed dev to adev because there's another dev at
> an outer scope which is set to kid->child, and only used
> once. I suggest just dropping that one instead of removing
> this one.
>
>
> > >
> > >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > >> index c0ce896668..2c832ab68b 100644
> > >> --- a/hw/i386/intel_iommu.c
> > >> +++ b/hw/i386/intel_iommu.c
> > >> @@ -3744,7 +3744,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUSta=
te *s, PCIBus *bus,
> > >> /* Unmap the whole range in the notifier's scope. */
> > >> static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifi=
er *n)
> > >> {
> > >> -    hwaddr size, remain;
> > >> +    hwaddr total, remain;
> > >>     hwaddr start =3D n->start;
> > >>     hwaddr end =3D n->end;
> > >>     IntelIOMMUState *s =3D as->iommu_state;
> > >> @@ -3765,7 +3765,7 @@ static void vtd_address_space_unmap(VTDAddress=
Space *as, IOMMUNotifier *n)
> > >>     }
> > >>
> > >>     assert(start <=3D end);
> > >> -    size =3D remain =3D end - start + 1;
> > >> +    total =3D remain =3D end - start + 1;
> > >>
> > >>     while (remain >=3D VTD_PAGE_SIZE) {
> > >>         IOMMUTLBEvent event;
> > >> @@ -3793,10 +3793,10 @@ static void vtd_address_space_unmap(VTDAddre=
ssSpace *as, IOMMUNotifier *n)
> > >>     trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
> > >>                              VTD_PCI_SLOT(as->devfn),
> > >>                              VTD_PCI_FUNC(as->devfn),
> > >> -                             n->start, size);
> > >> +                             n->start, total);
> > >>
> > >>     map.iova =3D n->start;
> > >> -    map.size =3D size - 1; /* Inclusive */
> > >> +    map.size =3D total - 1; /* Inclusive */
> > >>     iova_tree_remove(as->iova_tree, map);
> > >> }
> > >>
> > >
> > >
> > > arguably an improvement
> > >
> > >
> > >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > >> index 3db0743f31..e7a233e886 100644
> > >> --- a/hw/i386/pc.c
> > >> +++ b/hw/i386/pc.c
> > >> @@ -1116,7 +1116,6 @@ void pc_memory_init(PCMachineState *pcms,
> > >>
> > >>     if (machine->device_memory) {
> > >>         uint64_t *val =3D g_malloc(sizeof(*val));
> > >> -        PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> > >>         uint64_t res_mem_end =3D machine->device_memory->base;
> > >>
> > >>         if (!pcmc->broken_reserved_end) {
> > >> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> > >> index f034df8bf6..b3d054889b 100644
> > >> --- a/hw/i386/x86.c
> > >> +++ b/hw/i386/x86.c
> > >> @@ -365,8 +365,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_de=
v,
> > >>
> > >>     cpu_slot =3D x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &id=
x);
> > >>     if (!cpu_slot) {
> > >> -        MachineState *ms =3D MACHINE(x86ms);
> > >> -
> > >>         x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids=
);
> > >>         error_setg(errp,
> > >>             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u]=
 with"
> > >
> > >
> > > killing dead code, nice
> > >
> > >> --
> > >> 2.39.3
>


