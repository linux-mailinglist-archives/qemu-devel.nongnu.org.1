Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF77973794D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 04:41:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBnlU-0006kA-Jt; Tue, 20 Jun 2023 22:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBnlO-0006jU-V4
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 22:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBnlN-0003aN-0o
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 22:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687315203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqG2Mvin8eJoDV+r4O0IzIg7wMo4Kc62Efi+S0K2tAE=;
 b=dsobYhABRLA1ksa5ihVURMRe/ySZDUjJ5GEZoi2ArUKddbQCtXipRs2nP2wvHJAlMsWg1x
 xZotQc7/83KAnYcdIgD1b5MTXDp7zjA3ZDSLLdfoieWdX1wmlsT8LOxGE/VVKIe0VC4XJA
 aXVeqLWtXTM4nclVhvu4W0N9PSzJmnU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-LhUz5nUjNfWSQFsbEDsygg-1; Tue, 20 Jun 2023 22:40:00 -0400
X-MC-Unique: LhUz5nUjNfWSQFsbEDsygg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1b52f9b8b19so41437825ad.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 19:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687315200; x=1689907200;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqG2Mvin8eJoDV+r4O0IzIg7wMo4Kc62Efi+S0K2tAE=;
 b=IAwYtig30+ZrdCRFDRse3aA8jI8b1J4R40TkWRUEbi9nsPZwusjSAyZHx/7Qn5fQHe
 N9vGHGi3qBxngdtxsDewft5sA4uPePNzqWCO0Eu05XPazqu5PxnV7FnlS01zQYIX7X+H
 qZ0aN2SPJqFotI5rx13/U6rGSUDalO4CIlwc9Alk0hJGLBVouqgoYAjvfEtjV2BOwiF2
 MWnvsGeTTiqYdu10kfypEY19xwSTrqTXeSK3PV7AJugOucxtOism+OxPcr2KYk4n1lKQ
 XxmURE/hhAJo8i49Mf+FO//GWWZyKThO9RANQ9ixNCMB6WUkKn8byrT2Z9RsuC7DRHT9
 hwpA==
X-Gm-Message-State: AC+VfDz5gVsHsTIge6JbrjGraNGcs5jogH1eWgAPl/MsWcM2XVoRETlf
 SpYjNS16P5UfjMBl3JydUL73Ltr5Bds9fBiqQbVINM52qfJItEJdMRhudKiMu4UmE2fBVLgfY4b
 s6mWLmeDR7GLnslA=
X-Received: by 2002:a17:903:258e:b0:1b1:78ba:f350 with SMTP id
 jb14-20020a170903258e00b001b178baf350mr12460479plb.46.1687315199713; 
 Tue, 20 Jun 2023 19:39:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5V8nMWRsbK3T4Wp9K3PumRIXayaMtajQsXtY6SGBWkk9YLr6GUYzM4oJAtJgFOniDkJGyAjA==
X-Received: by 2002:a17:903:258e:b0:1b1:78ba:f350 with SMTP id
 jb14-20020a170903258e00b001b178baf350mr12460467plb.46.1687315199401; 
 Tue, 20 Jun 2023 19:39:59 -0700 (PDT)
Received: from smtpclient.apple ([115.96.199.101])
 by smtp.gmail.com with ESMTPSA id
 bd7-20020a170902830700b001b53472353csm2222372plb.211.2023.06.20.19.39.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Jun 2023 19:39:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v4] hw/pci: enforce use of slot only slot 0 when devices
 have an upstream PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230620062307-mutt-send-email-mst@kernel.org>
Date: Wed, 21 Jun 2023 08:09:55 +0530
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <06B2DB46-643C-4835-B850-D66FD01D5E69@redhat.com>
References: <20230620071805.4400-1-anisinha@redhat.com>
 <20230620062307-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
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



> On 20-Jun-2023, at 4:13 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Jun 20, 2023 at 12:48:05PM +0530, Ani Sinha wrote:
>> When a device has an upstream PCIE port, we can only use slot 0.
>=20
> Actually, it's when device is plugged into a PCIE port.
> So maybe:
>=20
> 	PCI Express ports only have one slot, so
> 	PCI Express devices can only be plugged into
> 	slot 0 on a PCIE port
>=20
>> Non-zero slots
>> are invalid. This change ensures that we throw an error if the user
>> tries to hotplug a device with an upstream PCIE port to a non-zero =
slot.
>=20
> it also adds a comment explaining why function 0 must not exist
> when function !=3D 0 is added. or maybe split that part out.
>=20
>> CC: jusual@redhat.com
>> CC: imammedo@redhat.com
>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> hw/pci/pci.c | 18 ++++++++++++++++++
>> 1 file changed, 18 insertions(+)
>>=20
>> changelog:
>> v2: addressed issue with multifunction pcie root ports. Should allow
>> hotplug on functions other than function 0.
>> v3: improved commit message.
>> v4: improve commit message and code comments further. Some more
>> improvements might come in v5. No claims made here that this is
>> the final one :-)
>>=20
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index bf38905b7d..30ce6a78cb 100644
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
>> +         * function 0 wasn't added yet.
>> +         */
>=20
> Pls capitalize populating. Also, comments like this should come
> before the logic they document, not after. By the way it doesn't
> have to be a bus scan - I'd just say "a scan" - with ACPI
> guest knows what was added and can just probe the device functions.
>=20
>>         error_setg(errp, "PCI: slot %d function 0 already occupied by =
%s,"
>>                    " new func %s cannot be exposed to guest.",
>>                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
>> @@ -1189,6 +1195,18 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>                    name);
>>=20
>>        return NULL;
>> +    } else if (dev->hotplugged &&
>=20
> why hotplugged? Doesn't the same rule apply to all devices?
>=20
>> +               !pci_is_vf(pci_dev) &&
>=20
> Hmm. I think you copied it from here:
>    } else if (dev->hotplugged &&
>               !pci_is_vf(pci_dev) &&
>               pci_get_function_0(pci_dev)) {
>=20
> it makes sense there because VFs are added later
> after PF exists.

I thought PFs are handled only in the host OS and only VFs are =
passthrough into the guest? I thought this check was because VFs have a =
different domain address separate from other non-vf devices in the guest =
PCI tree.=20

>=20
> But here it makes no sense that I can see.
>=20
>=20
>> +               pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
>> +        /*
>> +         * If the device has an upstream PCIE port, like a pcie root =
port,
>=20
> no, a root port can not be an upstream port.
>=20
>=20
>> +         * we only support functions on slot 0.
>> +         */
>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>> +                   " only functions on slot 0 is supported for =
devices"
>> +                   " with an upstream PCIE port.",
>=20
>=20
> something like:
>=20
>        error_setg(errp, "PCI: slot %d is not valid for %s:"
>                   " PCI Express devices can only be plugged into slot =
0")
>=20
> and then you don't really need a comment.
>=20
>=20
>> +                   PCI_SLOT(devfn), name);
>> +        return NULL;
>>     }
>>=20
>>     pci_dev->devfn =3D devfn;
>> --=20
>> 2.39.1


