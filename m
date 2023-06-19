Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F3173565D
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 14:02:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBDZb-00061r-JE; Mon, 19 Jun 2023 08:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBDZX-000610-21
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBDZV-0007LX-72
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687176083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trdsiw/s4e2na4YZmKwH9nDWCJlMMVjXWI1MFINwNmw=;
 b=QLUA4mzTU8qG50HgQ/Uk8W756a3n2jqe0egzseJfvbPZWVPCJsweHMTBxYd1V7mvIF0RZG
 CL3FPXxqN15+mnOb0zkgGqRdAMIYxihkjJDCY9SWOkQH0/250lQWrYGUq0kJeICHZShr0P
 lFAPZzza5/hIVyNG7DK5cHzdxCjDmuI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-3aUhRhElPq6hrZHugootnQ-1; Mon, 19 Jun 2023 08:01:21 -0400
X-MC-Unique: 3aUhRhElPq6hrZHugootnQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-668728d5328so721613b3a.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 05:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687176080; x=1689768080;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=trdsiw/s4e2na4YZmKwH9nDWCJlMMVjXWI1MFINwNmw=;
 b=dpoff8Cj92VCoPY27tyAv/QRvXPIdu/jVyKeCMV83KEg/suPfezddS5ZRBP1r74nSl
 HDmqmBqskofzB5B+NFEDKGMMWjL0IXvU02deotE1h+iViOCU7yggXhyRHI+fC2In3dqA
 Thd4ZJw4oisVMatQLrleACdXSnvDM1ATRukr0vQZDfNo+VC/kQOKZsSX3VsVP00OLFoV
 DNhAYldRRZJcuvsG5erdqGPGsTLxCCnX/HGmNKwfPggpKcFLDL8lQ1wW+CndnT+8rd4/
 D7Q8RYeg4764C+0ILmFJ+0c8ppqP4I5w4fbzZwybD3Y6gAwsTENzFSucBQVVaxAGaSln
 Sidg==
X-Gm-Message-State: AC+VfDzlvDVndSTtxxa6jCFW9H8cPvib/2kSHNQusvLDmKKSNtlVKfND
 X5gRde4TXP4ksQTa6vI8HiyOpIo+VD3nldYFA6jpOQFC0UNYTxaYVsIgAa8CeDeu7/qQIlXBxPR
 8Qys7qBLkpkYQhs4=
X-Received: by 2002:a05:6a00:3989:b0:668:64fa:30f0 with SMTP id
 fi9-20020a056a00398900b0066864fa30f0mr8670006pfb.0.1687176080450; 
 Mon, 19 Jun 2023 05:01:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6jceYVjNpgy05Zb4myDt95l6ke7VepTvcCsfwnB0M5EMD2tKDm1xfaNFdbyA9GHcroCziiBg==
X-Received: by 2002:a05:6a00:3989:b0:668:64fa:30f0 with SMTP id
 fi9-20020a056a00398900b0066864fa30f0mr8669956pfb.0.1687176080069; 
 Mon, 19 Jun 2023 05:01:20 -0700 (PDT)
Received: from smtpclient.apple ([115.96.121.2])
 by smtp.gmail.com with ESMTPSA id
 b5-20020aa78105000000b0063b6451cd01sm17434661pfi.121.2023.06.19.05.01.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Jun 2023 05:01:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v2] hw/pci: prevent hotplug of devices on pcie-root-ports
 on the wrong slot
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230615132659.6bcfcf0c@imammedo.users.ipa.redhat.com>
Date: Mon, 19 Jun 2023 17:31:15 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C5219DB-B71A-4553-ABD7-26914D06BF50@redhat.com>
References: <20230615051645.4798-1-anisinha@redhat.com>
 <20230615132659.6bcfcf0c@imammedo.users.ipa.redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 15-Jun-2023, at 4:56 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Thu, 15 Jun 2023 10:46:45 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>=20
>> PCIE root ports and other upstream ports only allow one device on =
slot 0.
>> When hotplugging a device on a pcie root port, make sure that the =
device
>> address passed always represents slot 0. Any other slot value would =
be
>> illegal on a root port.
>>=20
>> CC: jusual@redhat.com
>> CC: imammedo@redhat.com
>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> hw/pci/pci.c | 16 ++++++++++++++++
>> 1 file changed, 16 insertions(+)
>>=20
>> changelog:
>> v2: feedback from mst included.
>>=20
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index bf38905b7d..66999352cc 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -64,6 +64,7 @@ bool pci_available =3D true;
>> static char *pcibus_get_dev_path(DeviceState *dev);
>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>> static void pcibus_reset(BusState *qbus);
>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>=20
>> static Property pci_props[] =3D {
>>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>> @@ -1182,6 +1183,11 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>     } else if (dev->hotplugged &&
>>                !pci_is_vf(pci_dev) &&
>>                pci_get_function_0(pci_dev)) {
>> +        /*
>> +         * populating function 0 triggers a bus scan from the guest =
that
>> +         * exposes other non-zero functions. Hence we need to ensure =
that
>> +         * function 0 is available.
>> +         */
>>         error_setg(errp, "PCI: slot %d function 0 already occupied by =
%s,"
>>                    " new func %s cannot be exposed to guest.",
>>                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
>> @@ -1189,6 +1195,16 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>                    name);
>>=20
>>        return NULL;
>> +    } else if (dev->hotplugged &&
>> +               !pci_is_vf(pci_dev) &&
>> +               pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
>> +        /*
>> +         * If the device is being plugged into an upstream PCIE =
port,
>=20
> you probably mixing up downstream port with upstream one,
> the only thing that could be plugged into upstream port
> is PCIE switch.
>=20
> Also I'm not sure that we should do this at all.
> Looking at BZ it seems that QEMU crashes inside backend
> and tear down/cleanup sequence is broken somewhere.
> And that is the root cause, so I'd rather fix that 1st
> and only after that consider adding workarounds if any
> were necessary.

I have sent an upstream patch "vhost-vdpa: do not cleanup the =
vdpa/vhost-net structures if peer nic is present=E2=80=9D for the =
backend vdpa cleanup issue.

>=20
>=20
>> +         * like a pcie root port, we only support one device at slot =
0
>> +         */
>> +        error_setg(errp, "PCI: slot %d is not valid for %s",
>> +                   PCI_SLOT(devfn), name);
>> +        return NULL;
>>     }
>>=20
>>     pci_dev->devfn =3D devfn;
>=20


