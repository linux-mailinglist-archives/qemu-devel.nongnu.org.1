Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 125BD7B114F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 05:45:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlhwv-0007U3-RW; Wed, 27 Sep 2023 23:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qlhwu-0007Tt-9S
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 23:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qlhwo-0000iw-QC
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 23:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695872656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LB6daGLSu3Zm5aIJq4u9hIqBsTqDhBNq/KMi8yIE2o=;
 b=ZHlTqzu+QLRoWjwS2nv/jf3ebmcMeYZzuEeR0njENtDjYPho4syFXDrLKwbOct1IZ8xEQ3
 7+z+lMmh+Xci6numS1KXLd+vcxYOqlOCSJpT891L3lK9Sd2cm4zEQpSk8ELEizIpiuVkG0
 1OZoCFsAsDCNOn8luFmIjhSq8Yfgdrw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-SbA8917JO-iJD-a609q_RA-1; Wed, 27 Sep 2023 23:44:15 -0400
X-MC-Unique: SbA8917JO-iJD-a609q_RA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1c625d701b9so86423665ad.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 20:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695872654; x=1696477454;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LB6daGLSu3Zm5aIJq4u9hIqBsTqDhBNq/KMi8yIE2o=;
 b=rO9WX9xzM+ocogc3R3RgAriOyHPDbUk6By15momhXaXSd5XrTrO4up3mQy7MWXG9Uf
 0Rztgbz4dugCuAT6tNugeodMqyFdxjjZoKK8pGIt29WVsY1bhi/nrgVOC+7dL9v58vsC
 QRhMoyT1/idAnRtFFzHwcTC/F8CJwGEid2b7oZfczvNX+GtUl94hABOPf82FQtZT7nIq
 TjIwZSyIb4eA7NMwrJ5S6TpfLp2s4rXiPCLao+k8jKcf2Xw0JpissT0G5h2SJ6L7p6vw
 JhujJt6ch708JutmmGhzGCTfEakHfPLX3kkz9w7jn3BEOmJbhViH51Do0KvLuUYmQEaY
 pcuA==
X-Gm-Message-State: AOJu0YxlORUHeA4QAzkeLR37+FJRsFmLynaE3vbPQoW3H8/1adxfNXFj
 fjI0btrMM6h80/QJvWWE+t9FLaB+0Avaf6NvwK/uedVsjrCfFiiVdUAq5NtT9kUJJpZOFXVnH25
 p2UYXxcfyHQ/GZ8c=
X-Received: by 2002:a17:902:ed0b:b0:1bc:3944:9391 with SMTP id
 b11-20020a170902ed0b00b001bc39449391mr67124pld.25.1695872653863; 
 Wed, 27 Sep 2023 20:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8tZoD+Nd8RpXXr1IFKSM+y7DfuE9WNctWeCm64y5ME1GxrxtXAGI/N2EePm3Efwig6P0Azw==
X-Received: by 2002:a17:902:ed0b:b0:1bc:3944:9391 with SMTP id
 b11-20020a170902ed0b00b001bc39449391mr67100pld.25.1695872653460; 
 Wed, 27 Sep 2023 20:44:13 -0700 (PDT)
Received: from smtpclient.apple ([115.96.114.143])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a170903245000b001bdb0483e65sm13878599pls.265.2023.09.27.20.44.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Sep 2023 20:44:12 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v2] hw/i386: changes towards enabling -Wshadow=local
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230927112144-mutt-send-email-mst@kernel.org>
Date: Thu, 28 Sep 2023 09:14:07 +0530
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <00B810C8-CB14-40F6-AB54-3AE7CB63B93F@redhat.com>
References: <20230926055235.9164-1-anisinha@redhat.com>
 <20230927112144-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
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



> On 27-Sep-2023, at 8:55 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Sep 26, 2023 at 11:22:35AM +0530, Ani Sinha wrote:
>> Code changes that addresses all compiler complaints coming from =
enabling
>> -Wshadow flags. Enabling -Wshadow catches cases of local variables =
shadowing
>> other local variables or parameters. These makes the code confusing =
and/or adds
>=20
> These make
>=20
>> bugs that are difficult to catch.
>>=20
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: Philippe Mathieu-Daude <philmd@linaro.org>
>> CC: mst@redhat.com
>> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>=20
>=20
> chunks seem unrelated. why not split them up?

? No idea what you talking about. Here and ...

>=20
>> hw/i386/acpi-microvm.c | 12 ++++++------
>> hw/i386/intel_iommu.c  |  8 ++++----
>> hw/i386/pc.c           |  1 -
>> hw/i386/x86.c          |  2 --
>> 4 files changed, 10 insertions(+), 13 deletions(-)
>>=20
>> changelog:
>> v2: kept Peter's changes from =
https://lore.kernel.org/r/20230922160410.138786-1-peterx@redhat.com
>> and removed mine.
>>=20
>> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
>> index a075360d85..6e4f8061eb 100644
>> --- a/hw/i386/acpi-microvm.c
>> +++ b/hw/i386/acpi-microvm.c
>> @@ -78,18 +78,18 @@ static void acpi_dsdt_add_virtio(Aml *scope,
>>             hwaddr base =3D VIRTIO_MMIO_BASE + index * 512;
>>             hwaddr size =3D 512;
>>=20
>> -            Aml *dev =3D aml_device("VR%02u", (unsigned)index);
>> -            aml_append(dev, aml_name_decl("_HID", =
aml_string("LNRO0005")));
>> -            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
>> -            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>> +            Aml *adev =3D aml_device("VR%02u", (unsigned)index);
>> +            aml_append(adev, aml_name_decl("_HID", =
aml_string("LNRO0005")));
>> +            aml_append(adev, aml_name_decl("_UID", aml_int(index)));
>> +            aml_append(adev, aml_name_decl("_CCA", aml_int(1)));
>>=20
>>             Aml *crs =3D aml_resource_template();
>>             aml_append(crs, aml_memory32_fixed(base, size, =
AML_READ_WRITE));
>>             aml_append(crs,
>>                        aml_interrupt(AML_CONSUMER, AML_LEVEL, =
AML_ACTIVE_HIGH,
>>                                      AML_EXCLUSIVE, &irq, 1));
>> -            aml_append(dev, aml_name_decl("_CRS", crs));
>> -            aml_append(scope, dev);
>> +            aml_append(adev, aml_name_decl("_CRS", crs));
>> +            aml_append(scope, adev);
>>         }
>>     }
>> }
>=20
> I would prefer to just drop the devicestate dev pointer, use =
kid->child inside the
> macro.

Here =E2=80=A6


>=20
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index c0ce896668..2c832ab68b 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -3744,7 +3744,7 @@ VTDAddressSpace =
*vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>> /* Unmap the whole range in the notifier's scope. */
>> static void vtd_address_space_unmap(VTDAddressSpace *as, =
IOMMUNotifier *n)
>> {
>> -    hwaddr size, remain;
>> +    hwaddr total, remain;
>>     hwaddr start =3D n->start;
>>     hwaddr end =3D n->end;
>>     IntelIOMMUState *s =3D as->iommu_state;
>> @@ -3765,7 +3765,7 @@ static void =
vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>     }
>>=20
>>     assert(start <=3D end);
>> -    size =3D remain =3D end - start + 1;
>> +    total =3D remain =3D end - start + 1;
>>=20
>>     while (remain >=3D VTD_PAGE_SIZE) {
>>         IOMMUTLBEvent event;
>> @@ -3793,10 +3793,10 @@ static void =
vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>     trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
>>                              VTD_PCI_SLOT(as->devfn),
>>                              VTD_PCI_FUNC(as->devfn),
>> -                             n->start, size);
>> +                             n->start, total);
>>=20
>>     map.iova =3D n->start;
>> -    map.size =3D size - 1; /* Inclusive */
>> +    map.size =3D total - 1; /* Inclusive */
>>     iova_tree_remove(as->iova_tree, map);
>> }
>>=20
>=20
>=20
> arguably an improvement
>=20
>=20
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 3db0743f31..e7a233e886 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1116,7 +1116,6 @@ void pc_memory_init(PCMachineState *pcms,
>>=20
>>     if (machine->device_memory) {
>>         uint64_t *val =3D g_malloc(sizeof(*val));
>> -        PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>>         uint64_t res_mem_end =3D machine->device_memory->base;
>>=20
>>         if (!pcmc->broken_reserved_end) {
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index f034df8bf6..b3d054889b 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -365,8 +365,6 @@ void x86_cpu_pre_plug(HotplugHandler =
*hotplug_dev,
>>=20
>>     cpu_slot =3D x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, =
&idx);
>>     if (!cpu_slot) {
>> -        MachineState *ms =3D MACHINE(x86ms);
>> -
>>         x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, =
&topo_ids);
>>         error_setg(errp,
>>             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] =
with"
>=20
>=20
> killing dead code, nice
>=20
>> --=20
>> 2.39.3


