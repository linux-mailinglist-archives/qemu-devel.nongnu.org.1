Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 525E27B64FA
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 11:07:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnbLn-0003z8-1d; Tue, 03 Oct 2023 05:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnbLl-0003z0-1l
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 05:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnbLj-0007r7-Aq
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 05:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696323950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UyaEO9swQ6aNMj6JB430xdzjjFxwbFX+m6gPNKxV7Xs=;
 b=OoRrBWbml0AbNL0ZrvhXhDFYxcX4TjmR02f/2Ey2F3m/jjQ7xhACjTr2TJYosuJfCXoAHR
 ippA/FxVpBB6IaxLqq4mulOryAQOqW0OhX6EczWWV817v61cDR/+MH1b1E9TYc+lss9qR0
 oRlZkGsz+YcBe18ybOxzH0TfeqZg+RY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-fGoOIC44PC2-w98pLT16jw-1; Tue, 03 Oct 2023 05:05:48 -0400
X-MC-Unique: fGoOIC44PC2-w98pLT16jw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5849bcbf26bso529351a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 02:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696323947; x=1696928747;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyaEO9swQ6aNMj6JB430xdzjjFxwbFX+m6gPNKxV7Xs=;
 b=goVl/IglSxsz+J2TcDZY0tfWX/Y0I3wkoR9r9Nkda7nH3srfbcM9bw0SQ3D2fCAEDA
 sEhPmjiFLK8K28tnEb6yariwzkY5Yoct20awiq6sdkxWIO02uwGvA2V76gDvHwQuIXrl
 8e+S77bTl/htnw5Rpo+PAqwoPXUgKpTjpLC70GlRcEn3CYHDrP17QsbmYozk2580MG8n
 pmn6gcai2SaVSmQnqDIt1ATdPuyzepKRvO0EmYFxQaqoGcQv+KEwfb2YewZiAFCXE2g4
 foCQ62NSIsXkh0iX/OnpgvwbWacSc7Vx3K/jQIXRhI8NupeXstBC43pgweEE1tP/cdJv
 RcAQ==
X-Gm-Message-State: AOJu0Yz7WDZf25TrRWCwbHXrt3rro+RWr14X2xM+7uF92Riw2P8qPwTZ
 toBrwgCU6KM3tDYG6xZkHc/WlHKI6Kk5fg1/QLSvknbrSVedhvoD2OXM8m9b3/jfYzshWt089CR
 MuYiDHGJbJFpS8Ic=
X-Received: by 2002:a05:6a20:12ca:b0:f0:50c4:4c43 with SMTP id
 v10-20020a056a2012ca00b000f050c44c43mr3131521pzg.5.1696323947460; 
 Tue, 03 Oct 2023 02:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQXDLr+XqXX50wElUyvorITbobD4U9sK9RVxUWsxt8cGpNqfbAt/OTZqRjF2TEN6uwcxFx9Q==
X-Received: by 2002:a05:6a20:12ca:b0:f0:50c4:4c43 with SMTP id
 v10-20020a056a2012ca00b000f050c44c43mr3131493pzg.5.1696323947108; 
 Tue, 03 Oct 2023 02:05:47 -0700 (PDT)
Received: from smtpclient.apple ([115.96.159.31])
 by smtp.gmail.com with ESMTPSA id
 c16-20020aa781d0000000b0068890c19c49sm866548pfn.180.2023.10.03.02.05.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Oct 2023 02:05:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v2] hw/i386: changes towards enabling -Wshadow=local
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231003054306.4372-1-anisinha@redhat.com>
Date: Tue, 3 Oct 2023 14:35:42 +0530
Cc: Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDC8D506-EE66-47E9-9198-C5C1DBA8CE02@redhat.com>
References: <20231003054306.4372-1-anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
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



> On 03-Oct-2023, at 11:13 AM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> Code changes that addresses all compiler complaints coming from =
enabling
> -Wshadow flags. Enabling -Wshadow catches cases of local variables =
shadowing
> other local variables or parameters. These makes the code confusing =
and/or adds
> bugs that are difficult to catch.
>=20
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Philippe Mathieu-Daude <philmd@linaro.org>
> CC: mst@redhat.com
> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
> hw/i386/acpi-microvm.c | 4 ++--
> hw/i386/intel_iommu.c  | 8 ++++----
> hw/i386/pc.c           | 1 -
> hw/i386/x86.c          | 2 --
> 4 files changed, 6 insertions(+), 9 deletions(-)
>=20
> changelog:
> v2: addressed suggestion from mst.

Please ignore this. This was supposed to be v3. I will re-send. Will =
split-up intel_iommu into a separate patch.

>=20
> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> index a075360d85..6ddcfb0419 100644
> --- a/hw/i386/acpi-microvm.c
> +++ b/hw/i386/acpi-microvm.c
> @@ -55,8 +55,8 @@ static void acpi_dsdt_add_virtio(Aml *scope,
>=20
>     bus =3D sysbus_get_default();
>     QTAILQ_FOREACH(kid, &bus->children, sibling) {
> -        DeviceState *dev =3D kid->child;
> -        Object *obj =3D object_dynamic_cast(OBJECT(dev), =
TYPE_VIRTIO_MMIO);
> +        Object *obj =3D object_dynamic_cast(OBJECT(kid->child),
> +                                          TYPE_VIRTIO_MMIO);
>=20
>         if (obj) {
>             VirtIOMMIOProxy *mmio =3D VIRTIO_MMIO(obj);
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c0ce896668..2c832ab68b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3744,7 +3744,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState =
*s, PCIBus *bus,
> /* Unmap the whole range in the notifier's scope. */
> static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier =
*n)
> {
> -    hwaddr size, remain;
> +    hwaddr total, remain;
>     hwaddr start =3D n->start;
>     hwaddr end =3D n->end;
>     IntelIOMMUState *s =3D as->iommu_state;
> @@ -3765,7 +3765,7 @@ static void =
vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>     }
>=20
>     assert(start <=3D end);
> -    size =3D remain =3D end - start + 1;
> +    total =3D remain =3D end - start + 1;
>=20
>     while (remain >=3D VTD_PAGE_SIZE) {
>         IOMMUTLBEvent event;
> @@ -3793,10 +3793,10 @@ static void =
vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>     trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
>                              VTD_PCI_SLOT(as->devfn),
>                              VTD_PCI_FUNC(as->devfn),
> -                             n->start, size);
> +                             n->start, total);
>=20
>     map.iova =3D n->start;
> -    map.size =3D size - 1; /* Inclusive */
> +    map.size =3D total - 1; /* Inclusive */
>     iova_tree_remove(as->iova_tree, map);
> }
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3db0743f31..e7a233e886 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1116,7 +1116,6 @@ void pc_memory_init(PCMachineState *pcms,
>=20
>     if (machine->device_memory) {
>         uint64_t *val =3D g_malloc(sizeof(*val));
> -        PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>         uint64_t res_mem_end =3D machine->device_memory->base;
>=20
>         if (!pcmc->broken_reserved_end) {
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index f034df8bf6..b3d054889b 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -365,8 +365,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>=20
>     cpu_slot =3D x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, =
&idx);
>     if (!cpu_slot) {
> -        MachineState *ms =3D MACHINE(x86ms);
> -
>         x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>         error_setg(errp,
>             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] =
with"
> --=20
> 2.42.0
>=20


