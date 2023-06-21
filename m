Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70073826A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:52:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwMR-0003h6-JN; Wed, 21 Jun 2023 07:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBwMF-0003go-5W
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBwMD-0004G0-C9
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687348240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8cxy1zkcL4v1uu+S7OCS/Rl96SujB/KV78x7TVgUbQ=;
 b=buRulqWDawQgI4kInY8cVr/RPeJhUv/PCEt4B94ay8jMrGhr//esG4UH+bkd9p/LgYWuBh
 vm4cnmkSn9mPJ+Yw9GnB8BtlOdi/eV/sm08+bb77dXXMeZ7bUokH/boJDNMKuQE5Wtjd1S
 AJJMS6CCKIfoYU/JK+NuSqP8kxziYTs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-yhb22Q7LMGCAKhfVjtt-GA-1; Wed, 21 Jun 2023 07:50:38 -0400
X-MC-Unique: yhb22Q7LMGCAKhfVjtt-GA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-53fa2d0c2ebso2593339a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 04:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687348238; x=1689940238;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v8cxy1zkcL4v1uu+S7OCS/Rl96SujB/KV78x7TVgUbQ=;
 b=NMOKE/P3Jwcq/r0q+MYNmQdh9aFXqVoH/WvXrb17EHg/szqAOetsaVSyAJnKpz2KCc
 +cTcNP6zOx++JG0wCs8C04znqOVtf49d08JkG8j+o25aR28n4ufSZ9v1PIo2SkU7M0Wz
 nXF8Scgg3eZlhzLLe5PUCxTF08MRnkYXnYXpHpOjwUMeTheNSN/Lzl0zhN/4nKJw0TlO
 5/YEkajkVnEi5GqWzZemB5Ure9yRrontDH+CqofLypi16QhnVJr8mk0En2lRjWw5vYz3
 jF8+puElrDfiVHmpDoPHJlQVo92xowaUpCIkHz88+VvoAeiblhsTq9x6EMFgG/5QrPVh
 2kBQ==
X-Gm-Message-State: AC+VfDwdtem7YHQMMh9RXTq830y04e3Srf+hd4HXm8Omu3yJScas7q5A
 +0NSqazk7hAWOkq98g4U3LGNJJ0c/Kganzsr2LqzG04OlHwXSEMdseXy0FVbI/DOgOCmVn3RSID
 eBc0cmr+eKDlO44k=
X-Received: by 2002:a17:90a:70cf:b0:25e:8fd9:8dc with SMTP id
 a15-20020a17090a70cf00b0025e8fd908dcmr4747025pjm.42.1687348237701; 
 Wed, 21 Jun 2023 04:50:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66yt9E0ah6hsbGknjdxrqim49lqOKYzgbrao5+Enq/0b2i8Whhw0sBXKJ4WTy58q4QIT83Zw==
X-Received: by 2002:a17:90a:70cf:b0:25e:8fd9:8dc with SMTP id
 a15-20020a17090a70cf00b0025e8fd908dcmr4747009pjm.42.1687348237320; 
 Wed, 21 Jun 2023 04:50:37 -0700 (PDT)
Received: from smtpclient.apple ([115.96.199.101])
 by smtp.gmail.com with ESMTPSA id
 bk10-20020a17090b080a00b0025bcdada95asm3029533pjb.38.2023.06.21.04.50.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Jun 2023 04:50:36 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v4] hw/pci: enforce use of slot only slot 0 when devices
 have an upstream PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <D2277938-2218-4F9F-AF9A-C94A1D5A8050@redhat.com>
Date: Wed, 21 Jun 2023 17:20:32 +0530
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, michael.labiuk@virtuozzo.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <310ABDD6-4CD0-47DE-9788-D964F6CCD666@redhat.com>
References: <20230620071805.4400-1-anisinha@redhat.com>
 <20230620062307-mutt-send-email-mst@kernel.org>
 <9B88C548-C607-4949-B401-DE4226DFB6FC@redhat.com>
 <D2277938-2218-4F9F-AF9A-C94A1D5A8050@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 21-Jun-2023, at 4:55 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 21-Jun-2023, at 4:36 PM, Ani Sinha <anisinha@redhat.com> wrote:
>>=20
>>=20
>>=20
>>> On 20-Jun-2023, at 4:13 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Tue, Jun 20, 2023 at 12:48:05PM +0530, Ani Sinha wrote:
>>>> When a device has an upstream PCIE port, we can only use slot 0.
>>>=20
>>> Actually, it's when device is plugged into a PCIE port.
>>> So maybe:
>>>=20
>>> 	PCI Express ports only have one slot, so
>>> 	PCI Express devices can only be plugged into
>>> 	slot 0 on a PCIE port
>>>=20
>>>> Non-zero slots
>>>> are invalid. This change ensures that we throw an error if the user
>>>> tries to hotplug a device with an upstream PCIE port to a non-zero =
slot.
>>>=20
>>> it also adds a comment explaining why function 0 must not exist
>>> when function !=3D 0 is added. or maybe split that part out.
>>>=20
>>>> CC: jusual@redhat.com
>>>> CC: imammedo@redhat.com
>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> ---
>>>> hw/pci/pci.c | 18 ++++++++++++++++++
>>>> 1 file changed, 18 insertions(+)
>>>>=20
>>>> changelog:
>>>> v2: addressed issue with multifunction pcie root ports. Should =
allow
>>>> hotplug on functions other than function 0.
>>>> v3: improved commit message.
>>>> v4: improve commit message and code comments further. Some more
>>>> improvements might come in v5. No claims made here that this is
>>>> the final one :-)
>>>>=20
>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>> index bf38905b7d..30ce6a78cb 100644
>>>> --- a/hw/pci/pci.c
>>>> +++ b/hw/pci/pci.c
>>>> @@ -64,6 +64,7 @@ bool pci_available =3D true;
>>>> static char *pcibus_get_dev_path(DeviceState *dev);
>>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>> static void pcibus_reset(BusState *qbus);
>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>=20
>>>> static Property pci_props[] =3D {
>>>>   DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>> @@ -1182,6 +1183,11 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>>   } else if (dev->hotplugged &&
>>>>              !pci_is_vf(pci_dev) &&
>>>>              pci_get_function_0(pci_dev)) {
>>>> +        /*
>>>> +         * populating function 0 triggers a bus scan from the =
guest that
>>>> +         * exposes other non-zero functions. Hence we need to =
ensure that
>>>> +         * function 0 wasn't added yet.
>>>> +         */
>>>=20
>>> Pls capitalize populating. Also, comments like this should come
>>> before the logic they document, not after. By the way it doesn't
>>> have to be a bus scan - I'd just say "a scan" - with ACPI
>>> guest knows what was added and can just probe the device functions.

This commit essentially needs fixing:

commit c46b126088b5616d8b7cd3ff83aaf5d097c36633
Author: Michael Labiuk <michael.labiuk@virtuozzo.com>
Date:   Fri Sep 30 01:35:42 2022 +0300

    tests/x86: Add 'q35' machine type to override-tests in hd-geo-test
   =20
    Signed-off-by: Michael Labiuk <michael.labiuk@virtuozzo.com>
    Message-Id: <20220929223547.1429580-5-michael.labiuk@virtuozzo.com>
    Signed-off-by: Thomas Huth <thuth@redhat.com>

>>>=20
>>>>       error_setg(errp, "PCI: slot %d function 0 already occupied by =
%s,"
>>>>                  " new func %s cannot be exposed to guest.",
>>>>                  PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
>>>> @@ -1189,6 +1195,18 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>>                  name);
>>>>=20
>>>>      return NULL;
>>>> +    } else if (dev->hotplugged &&
>>>=20
>>> why hotplugged? Doesn't the same rule apply to all devices?
>>>=20
>>>> +               !pci_is_vf(pci_dev) &&
>>>=20
>>> Hmm. I think you copied it from here:
>>>  } else if (dev->hotplugged &&
>>>             !pci_is_vf(pci_dev) &&
>>>             pci_get_function_0(pci_dev)) {
>>>=20
>>> it makes sense there because VFs are added later
>>> after PF exists.
>>>=20
>>> But here it makes no sense that I can see.
>>=20
>> This patch with these changes causes failures in bios-tables-test =
which can be fixed easily. It also breaks hd-geo-test and I do not know =
enough of this test to fix them.
>=20
> Specifically it breaks test_override_scsi_q35() and =
test_override_virtio_blk_q35().=20
> I think these tests were wrong to begin with since they attach a =
pcie-to-pci bridge on a pcie root port and then attach a scsi controller =
not on the pcie-to-pci bridge but on the root port (which is not =
possible because we can only attach one device on a non-multifunction =
pcie root port). Even if I fix them, its failing somewhere else.
>=20
> I have added Thomas and Laurent, maybe they can help fix these in this =
test.
> I have pushed my patch here: =
https://gitlab.com/anisinha/qemu/-/commit/24b3eddb968a0739bff222bdf781f722=
365cc9b2
>=20
>=20
>>=20
>> I think I will drop this patch for now.
>>=20
>>>=20
>>>=20
>>>> +               pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) =
{
>>>> +        /*
>>>> +         * If the device has an upstream PCIE port, like a pcie =
root port,
>>>=20
>>> no, a root port can not be an upstream port.
>>>=20
>>>=20
>>>> +         * we only support functions on slot 0.
>>>> +         */
>>>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>>>> +                   " only functions on slot 0 is supported for =
devices"
>>>> +                   " with an upstream PCIE port.",
>>>=20
>>>=20
>>> something like:
>>>=20
>>>      error_setg(errp, "PCI: slot %d is not valid for %s:"
>>>                 " PCI Express devices can only be plugged into slot =
0")
>>>=20
>>> and then you don't really need a comment.
>>>=20
>>>=20
>>>> +                   PCI_SLOT(devfn), name);
>>>> +        return NULL;
>>>>   }
>>>>=20
>>>>   pci_dev->devfn =3D devfn;
>>>> --=20
>>>> 2.39.1


