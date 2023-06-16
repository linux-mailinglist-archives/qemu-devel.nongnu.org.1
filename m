Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8237732907
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 09:38:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA40a-00015N-NI; Fri, 16 Jun 2023 03:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qA40M-00015B-Ci
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qA40K-0006eM-JC
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686900975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzxT0HBVR43htf94mczgCfjN0Lcgg/Q61wP4ebVCSFc=;
 b=TmCIX55+wXiNwstGICkkIEfivNacbuWFScR45J9QVoQzpxv4OMP8pzj32FBgSiCxf8N/BY
 VuC2wU2hI5n62oYPd6UpI8JEHWLrkV3wdm5Q2ylaKXXWU06TEIJLpX2tIl9m5DE3SHiyoh
 Osu5fqDTMhmE5DGHnAgNQ8FUqWWtqj0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-fqnS_77YMe2J5jZj5SQKPg-1; Fri, 16 Jun 2023 03:36:13 -0400
X-MC-Unique: fqnS_77YMe2J5jZj5SQKPg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b5277e57d6so4328955ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 00:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686900972; x=1689492972;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzxT0HBVR43htf94mczgCfjN0Lcgg/Q61wP4ebVCSFc=;
 b=AenpMNGuDyRuHFyov0DWcAnx+uDXtXZk4wUzGt2iyQaodG1Qmry8A6Ez58gK7r0u5J
 EpXEIxJFou4aaMm31MH4vRftSVZOho0zZVDjpq0rQMuZXe3kKi8ps0umeT2TjYRmlAdH
 UHC+R/yrxCT4p4/DCn4a1SGB40LUH/59BsH75L4QgoB+Ald1iKLK5SHn/kMXgjrIeTtB
 SIakeyj822F6V+fb/owe6lcejsgA9yPaI85UCv9eAwGKX7I/j4yiut4IaMncDIrEOg3S
 8jZz35K+vsyu6DsFUn//djZsQf2TDPvshquCmJYWlcgvu9+I1PiRptb8mayp6OPw7oMx
 gYOg==
X-Gm-Message-State: AC+VfDx9Y+DYTRHuC2gvm/0vSlIK9f/+fmFuMUeo8MJJ0Aegr9hoVzT9
 I6zYqVpF6psSOshalRZ23gEmHUOMSa4NWRox40wsU1WlUWjlA6Z2pTcibWiQwchnsr/+B4Z8ZUT
 IEc5NS2baOK1rqeo=
X-Received: by 2002:a17:903:18a:b0:1b0:1095:f4f6 with SMTP id
 z10-20020a170903018a00b001b01095f4f6mr1365898plg.24.1686900971990; 
 Fri, 16 Jun 2023 00:36:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/CEpmQSXX296bkb6dYoFKZRCp5rWR6tPLsiwKqVg6X72j5yUkqSJzs0J+Tf5KURG55nfX0g==
X-Received: by 2002:a17:903:18a:b0:1b0:1095:f4f6 with SMTP id
 z10-20020a170903018a00b001b01095f4f6mr1365883plg.24.1686900971563; 
 Fri, 16 Jun 2023 00:36:11 -0700 (PDT)
Received: from smtpclient.apple ([115.96.159.188])
 by smtp.gmail.com with ESMTPSA id
 x1-20020a170902ec8100b001a6f7744a27sm9404508plg.87.2023.06.16.00.36.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Jun 2023 00:36:11 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v2] hw/pci: prevent hotplug of devices on pcie-root-ports
 on the wrong slot
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230615132659.6bcfcf0c@imammedo.users.ipa.redhat.com>
Date: Fri, 16 Jun 2023 13:06:06 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D505615B-F22E-441A-9F6C-566E46C714E8@redhat.com>
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

I have added more details in the ticket. I still believe that my =
approach is in the right direction.

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


