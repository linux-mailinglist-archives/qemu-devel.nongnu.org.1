Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 237CF812694
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 05:31:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDdNf-0000P6-Nq; Wed, 13 Dec 2023 23:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rDdNd-0000Ov-UI
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 23:31:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rDdNc-0005qN-5t
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 23:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702528282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nslo+29rvQnfTyoDiRESZbY8S1En7SdL2F6UZRW+lHs=;
 b=YxG/fLGZvO9Ws5iIlxoVZrUdikn8yjybP5W50iAobRPUAvK8AARgfGrj+vb4Y2cT8H57wZ
 cM3W8SE2MkA9Bn3srTEiv12TKOS+9/il7PY1XBdI0kzKxwWKNfGUhF3CzB3hD/FBqxjDeN
 rygloNt0fiqgAaicWiBbgcok9OnEoq0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-4LUNnHmmNN-19Z_gO-UsAg-1; Wed, 13 Dec 2023 23:31:20 -0500
X-MC-Unique: 4LUNnHmmNN-19Z_gO-UsAg-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-591129c72d6so4750624eaf.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 20:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702528280; x=1703133080;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nslo+29rvQnfTyoDiRESZbY8S1En7SdL2F6UZRW+lHs=;
 b=gtdRGusM+O7Lfcvr2mQDYnRyIFEWitgb2s6amk6OW8Qtdu0IbNCi0eaLecLgiU3Lob
 m6XF75J9qu3fpbEguwu1G4PWhZDGPAH7fIlujZTA1mUhriDfEzJHYShj+RDtDSWJ3ren
 BgUr6fiGba0b4GC3wISwdSBEnJEuqRjQDKIOO8dgk3gBC2MDtOAmCWzB9M37D2TQ4jL3
 BBcVwWKwfjHLCmYz6LIeos/OxMEL4Hpjy4GwbFG2S9lI3Zx+iKgzwhOHaXnaudscQLn9
 ZWRy3MG1m8Opsq58a5jz262qIdyzWILjz+IxHIq/UoJoAPiW0L+UiTpUFLn8gz8Diw8g
 pwZQ==
X-Gm-Message-State: AOJu0YzKMnxrGEU6FHQBXauV4zxCQF/3Jgb8ha0dst6HLLHZUJwPJkSU
 O9OeUsvRttdbkd9R9h+F+5IdmjOkBn37lcElGItAWafh9BiDn1udZzZEume45Oyo6WWdDsL2LnN
 LC8lbvBK5GVFf6Uo=
X-Received: by 2002:a05:6808:1203:b0:3b8:b063:9b5c with SMTP id
 a3-20020a056808120300b003b8b0639b5cmr11880724oil.78.1702528280269; 
 Wed, 13 Dec 2023 20:31:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZ/t2H/utBOALr8hinJKBer7DD8r8yVn8vgK5NP28CauUNoKkXAiuvzFVes8NCYjBSxCP0XA==
X-Received: by 2002:a05:6808:1203:b0:3b8:b063:9b5c with SMTP id
 a3-20020a056808120300b003b8b0639b5cmr11880714oil.78.1702528280015; 
 Wed, 13 Dec 2023 20:31:20 -0800 (PST)
Received: from smtpclient.apple ([115.96.117.154])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a056a000bc300b006cea17d08ebsm10760601pfu.120.2023.12.13.20.31.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Dec 2023 20:31:19 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] pc: q35: Bump max_cpus to 4096
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <a7863276-f92e-40b1-b894-2cbff7725237@redhat.com>
Date: Thu, 14 Dec 2023 10:01:03 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFE93D65-01D3-4E2C-BC7E-43C8430DE9D3@redhat.com>
References: <20231208122611.32311-1-anisinha@redhat.com>
 <a7863276-f92e-40b1-b894-2cbff7725237@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 11-Dec-2023, at 11:27=E2=80=AFAM, Thomas Huth <thuth@redhat.com> =
wrote:
>=20
> On 08/12/2023 13.26, Ani Sinha wrote:
>> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to =
allow up to 4096 vCPUs")
>> Linux kernel can support upto a maximum number of 4096 vCPUS when =
MAXSMP is
>> enabled in the kernel. So bump up the max_cpus value for q35 machines =
versions
>> 8.3 and newer to 4096. Older q35 machines versions 8.2 and older =
continue to
>> support 1024 maximum vcpus as before.
>> If KVM is not able to support the specified number of vcpus, QEMU =
would
>> return the following error messages:
>> $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 4096
>> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested =
(4096) exceeds the recommended cpus supported by KVM (12)
>> Number of SMP cpus requested (4096) exceeds the maximum cpus =
supported by KVM (1024)
>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Julia Suvorova <jusual@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  hw/i386/pc_q35.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 4f3e5412f6..2ed57814e1 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -375,7 +375,7 @@ static void pc_q35_machine_options(MachineClass =
*m)
>>      m->default_nic =3D "e1000e";
>>      m->default_kernel_irqchip_split =3D false;
>>      m->no_floppy =3D 1;
>> -    m->max_cpus =3D 1024;
>> +    m->max_cpus =3D 4096;
>>      m->no_parallel =3D =
!module_object_class_by_name(TYPE_ISA_PARALLEL);
>>      machine_class_allow_dynamic_sysbus_dev(m, =
TYPE_AMD_IOMMU_DEVICE);
>>      machine_class_allow_dynamic_sysbus_dev(m, =
TYPE_INTEL_IOMMU_DEVICE);
>> @@ -383,12 +383,22 @@ static void pc_q35_machine_options(MachineClass =
*m)
>>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
>>  }
>>  -static void pc_q35_8_2_machine_options(MachineClass *m)
>> +static void pc_q35_8_3_machine_options(MachineClass *m)
>=20
> Hi Ani!
>=20
> The next QEMU version after 8.2 is 9.0.

Ah yes I completely forgot about our versioning scheme.


> Maybe best if you rebase your patch on top of:
>=20
> =
https://lore.kernel.org/qemu-devel/20231120094259.1191804-1-cohuck@redhat.=
com/

Will do. I am trying to get some data with testing on edk2. It seems on =
legacy bios, we have done some testing downstream with 4096 vcpus with =
qemu modifications and patched host kernel [1] and the linux guest boots =
fine. With edk2 it seems we have tested with 1880 vcpus and it works =
fine with the patched edk2 [2]. I am working downstream with HPE folks =
to get some testing done with 4096 vcpus.

[1] patched with =
https://github.com/kvm-x86/linux/commit/f10a570b093e60c6bd3f210ae909f014f4=
21352a .
[2] =
https://github.com/tianocore/edk2/pull/4181/commits/03ca8224f995eda75e2769=
ed9a2fc437e321db8e



