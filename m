Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB7180A514
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 15:04:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBbS8-00022q-RB; Fri, 08 Dec 2023 09:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rBbS2-0001zi-Hx
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 09:03:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rBbS0-0003Xo-LT
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 09:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702044211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsVxRfR2DMh+9guKE5k9pCcWDf55/Z0sbHEAOW2diM0=;
 b=NmSt8d7Fc8dZgEf7/XXsiqxjO2LSiOHm/n50ddTTZbtCcS2HtniyJe/o50uIuw+k0UiRsz
 Fyso41UHL7hKiKwW7pEk1OWkmhMdgRDYXUP9GeCSz/Ds5J9mOpZhcBYVhNkSTeD6SSa/Uv
 YzvS4Kr6DSMxDPdZetlzV4Sbbl9ZhlY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-RtAygemUOiSg4oGMBLk40g-1; Fri, 08 Dec 2023 09:03:28 -0500
X-MC-Unique: RtAygemUOiSg4oGMBLk40g-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5c6245bc7caso1438324a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 06:03:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702044207; x=1702649007;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsVxRfR2DMh+9guKE5k9pCcWDf55/Z0sbHEAOW2diM0=;
 b=iAzwLvb3vuai4Ka5HiokRL1lL5an6uPnJOvMU3Q415O2Ollmbv7L1NfB45gB5RN2jt
 HQIvXCA+V8p8gpdcsrpKfpsnYRysD+EwDHHQTdURfqHuN+c8dgmF4ELoCJdb1dTNFysJ
 IYnF/98iHBvWX3/hXUL4JpbhCTRxtyDy/8Vip7kmFYnQwUTagpyHvSNznqjtJjWrlKQ7
 6BC7CLaI3tDgfacequKhR6hj0VFBoExtEVqL1iexOJ1iJRE4daYYkGq9o0CgGZrACSvo
 4iF2kHlkxpbw9IyiFvStvEtih3hRTTbgfV7j2wzayKKJ3hfjt7nutpCjnBYWtaQRy2sL
 nh5g==
X-Gm-Message-State: AOJu0YzWAQzkR+S4iSARSzYwpAneYs0oSyhgzjTksE8Ex3m4C4NNJ1cG
 cfizDyRPlB9DBhP7d0l1hYNjrTlOyXv9uFJ5WUMoZ6uimun5pKDea6eWqA9tQsMyWkOKweVujBA
 RsAEez7KRvxS7q70=
X-Received: by 2002:a17:902:b495:b0:1d0:6785:f1be with SMTP id
 y21-20020a170902b49500b001d06785f1bemr40184plr.36.1702044207634; 
 Fri, 08 Dec 2023 06:03:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyUrVcwPWco7k8TJK3JIwMzB6/KI7udgzoAViKvHGtmg5CMCXGyaNV54ZZfmml7s6jxaW6ag==
X-Received: by 2002:a17:902:b495:b0:1d0:6785:f1be with SMTP id
 y21-20020a170902b49500b001d06785f1bemr40168plr.36.1702044207286; 
 Fri, 08 Dec 2023 06:03:27 -0800 (PST)
Received: from smtpclient.apple ([115.96.133.105])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902ed0500b001cf57467ad2sm1728199pld.91.2023.12.08.06.03.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Dec 2023 06:03:26 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] pc: q35: Bump max_cpus to 4096
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ZXMS15q8x5-cWPA3@redhat.com>
Date: Fri, 8 Dec 2023 19:33:11 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <934402FC-145A-420E-B344-A4BC469B1A6B@redhat.com>
References: <20231208122611.32311-1-anisinha@redhat.com>
 <ZXMS15q8x5-cWPA3@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 08-Dec-2023, at 6:27=E2=80=AFPM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Fri, Dec 08, 2023 at 05:56:11PM +0530, Ani Sinha wrote:
>> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to =
allow up to 4096 vCPUs")
>> Linux kernel can support upto a maximum number of 4096 vCPUS when =
MAXSMP is
>> enabled in the kernel. So bump up the max_cpus value for q35 machines =
versions
>> 8.3 and newer to 4096. Older q35 machines versions 8.2 and older =
continue to
>> support 1024 maximum vcpus as before.
>>=20
>> If KVM is not able to support the specified number of vcpus, QEMU =
would
>> return the following error messages:
>>=20
>> $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 4096
>> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested =
(4096) exceeds the recommended cpus supported by KVM (12)
>> Number of SMP cpus requested (4096) exceeds the maximum cpus =
supported by KVM (1024)
>>=20
>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Julia Suvorova <jusual@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> hw/i386/pc_q35.c | 15 ++++++++++++---
>> 1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> What testing has been done to confirm if QEMU is actually capable of
> booting a guest with this CPU count, either UEFI or SeaBIOS or both ?

I admit we did not test this with 4096 cpus.

It was tested downstream with edk2 with modified kernel and increased =
QEMU limit for=20
https://bugzilla.redhat.com/show_bug.cgi?id=3D1983086

> We validated a ~48TB, 1728 cores, and 32 socket vm using legacy
> bios from smbios 3.0, the latest qemu modified with higher vcpu =
limits, a=3D
nd
> modified kernel limits.

I am trying to get some more clarity on the testing front and checking =
what max values for max_cpu we can test with.

>=20
> Historically every time we wanted to raise max cpus we've seen limits
> or scalability problems that needed fixing first. The previous bump to
> 1024 had been implicitly proven via downstream testing we had done in
> RHEL, and had required the switch to SMBIOS v3 entrypoint.
>=20
>>=20
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 4f3e5412f6..2ed57814e1 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -375,7 +375,7 @@ static void pc_q35_machine_options(MachineClass =
*m)
>>     m->default_nic =3D "e1000e";
>>     m->default_kernel_irqchip_split =3D false;
>>     m->no_floppy =3D 1;
>> -    m->max_cpus =3D 1024;
>> +    m->max_cpus =3D 4096;
>>     m->no_parallel =3D =
!module_object_class_by_name(TYPE_ISA_PARALLEL);
>>     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
>>     machine_class_allow_dynamic_sysbus_dev(m, =
TYPE_INTEL_IOMMU_DEVICE);
>> @@ -383,12 +383,22 @@ static void pc_q35_machine_options(MachineClass =
*m)
>>     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
>> }
>>=20
>> -static void pc_q35_8_2_machine_options(MachineClass *m)
>> +static void pc_q35_8_3_machine_options(MachineClass *m)
>> {
>>     pc_q35_machine_options(m);
>>     m->alias =3D "q35";
>> }
>>=20
>> +DEFINE_Q35_MACHINE(v8_3, "pc-q35-8.3", NULL,
>> +                   pc_q35_8_3_machine_options);
>> +
>> +static void pc_q35_8_2_machine_options(MachineClass *m)
>> +{
>> +    pc_q35_8_3_machine_options(m);
>> +    m->alias =3D NULL;
>> +    m->max_cpus =3D 1024;
>> +}
>> +
>> DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
>>                    pc_q35_8_2_machine_options);
>>=20
>> @@ -396,7 +406,6 @@ static void =
pc_q35_8_1_machine_options(MachineClass *m)
>> {
>>     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>>     pc_q35_8_2_machine_options(m);
>> -    m->alias =3D NULL;
>>     pcmc->broken_32bit_mem_addr_check =3D true;
>>     compat_props_add(m->compat_props, hw_compat_8_1, =
hw_compat_8_1_len);
>>     compat_props_add(m->compat_props, pc_compat_8_1, =
pc_compat_8_1_len);
>> --=20
>> 2.42.0
>>=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|



