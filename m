Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F47B739E9E
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:37:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCHgp-000779-E0; Thu, 22 Jun 2023 06:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHgm-00076v-La
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHgk-0000bH-PW
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687430238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+Mr/PZtav+in0Gls+bSMdayBktroK9wswr4ayJV7Rc=;
 b=T49Of+FS9Xk8sfdzx2Z+/t1WvZMTkKM+hOqCh/hH+eIdFskaAOJEEhS1BDovTbkXEzEReV
 K98P7UKXAz9tCTrUZ8QPobBp3Idb9KFujEJzxxqxAZ44wXaI6K+wRdYtjSLGifdOOpLkfx
 223iDCuzSmKQVtHOnb6VVZy0ShpuFXk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-g5K7TnWaOe2XY16RCFnS-w-1; Thu, 22 Jun 2023 06:37:16 -0400
X-MC-Unique: g5K7TnWaOe2XY16RCFnS-w-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-54fb5dd787aso372585a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687430236; x=1690022236;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+Mr/PZtav+in0Gls+bSMdayBktroK9wswr4ayJV7Rc=;
 b=MYoEWQV7WwIXFXVw9hafsFDRjotdw+Ol9rChpL/DiojSJWJWdp/iw/zmsBjt8Lnchq
 m0FFTB63fenXxr5EDsfFmINL87ndgTOc2Cixy7yhhmzwj1g9BF1eNjRgQHVbJu0+jABP
 Sycu+IapNp7XH+zl5JM79dSEATiFno0vs7QuwiKfQqgMk9sFoQS5B5Hkv/ailGRRmARr
 sQgaihnc+GDkLmvpjSq5cVy8lWjZfNTwYiq4LChPTelxuVoh93+2ubtuycBo7rzK71+L
 SIzbEEW9nprKeVeMSUo3MELU3VGlU/2WNZBoHSJnmUFuBUZcA9U/R+M/m3nd0TWIPmUl
 DMCw==
X-Gm-Message-State: AC+VfDyeXvVYE+AxtWkmPlTDwJEWd7e/04WQitsrvRERpWIXAlU/xn0J
 u6KAzuiFbHVpOBYPXSS5+IxMqv53EkUmOZON6HkU1hrLxwhL7IaOqGIoG3UBU36tq6nTADTz8SU
 Mq1ZPlRu6XdJfDzo=
X-Received: by 2002:a05:6a20:1446:b0:117:c69b:cb34 with SMTP id
 a6-20020a056a20144600b00117c69bcb34mr32913936pzi.2.1687430235697; 
 Thu, 22 Jun 2023 03:37:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73NWYb8qRcPC9HvxVjPbiTibmRsYpcZp918PM97xG+x/B0C/J+aAOjPUS6C1y1XUR6rfA2JQ==
X-Received: by 2002:a05:6a20:1446:b0:117:c69b:cb34 with SMTP id
 a6-20020a056a20144600b00117c69bcb34mr32913919pzi.2.1687430235335; 
 Thu, 22 Jun 2023 03:37:15 -0700 (PDT)
Received: from smtpclient.apple ([115.96.105.213])
 by smtp.gmail.com with ESMTPSA id
 w128-20020a636286000000b005501b24b1c9sm4574027pgb.62.2023.06.22.03.37.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 22 Jun 2023 03:37:14 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v4] hw/pci: enforce use of slot only slot 0 when devices
 have an upstream PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <310ABDD6-4CD0-47DE-9788-D964F6CCD666@redhat.com>
Date: Thu, 22 Jun 2023 16:07:06 +0530
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, michael.labiuk@virtuozzo.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC31F0DB-F959-4DDC-86ED-3207EB786C15@redhat.com>
References: <20230620071805.4400-1-anisinha@redhat.com>
 <20230620062307-mutt-send-email-mst@kernel.org>
 <9B88C548-C607-4949-B401-DE4226DFB6FC@redhat.com>
 <D2277938-2218-4F9F-AF9A-C94A1D5A8050@redhat.com>
 <310ABDD6-4CD0-47DE-9788-D964F6CCD666@redhat.com>
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



> On 21-Jun-2023, at 5:20 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 21-Jun-2023, at 4:55 PM, Ani Sinha <anisinha@redhat.com> wrote:
>>=20
>>=20
>>=20
>>> On 21-Jun-2023, at 4:36 PM, Ani Sinha <anisinha@redhat.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 20-Jun-2023, at 4:13 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>=20
>>>> On Tue, Jun 20, 2023 at 12:48:05PM +0530, Ani Sinha wrote:
>>>>> When a device has an upstream PCIE port, we can only use slot 0.
>>>>=20
>>>> Actually, it's when device is plugged into a PCIE port.
>>>> So maybe:
>>>>=20
>>>> 	PCI Express ports only have one slot, so
>>>> 	PCI Express devices can only be plugged into
>>>> 	slot 0 on a PCIE port
>>>>=20
>>>>> Non-zero slots
>>>>> are invalid. This change ensures that we throw an error if the =
user
>>>>> tries to hotplug a device with an upstream PCIE port to a non-zero =
slot.
>>>>=20
>>>> it also adds a comment explaining why function 0 must not exist
>>>> when function !=3D 0 is added. or maybe split that part out.
>>>>=20
>>>>> CC: jusual@redhat.com
>>>>> CC: imammedo@redhat.com
>>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>> ---
>>>>> hw/pci/pci.c | 18 ++++++++++++++++++
>>>>> 1 file changed, 18 insertions(+)
>>>>>=20
>>>>> changelog:
>>>>> v2: addressed issue with multifunction pcie root ports. Should =
allow
>>>>> hotplug on functions other than function 0.
>>>>> v3: improved commit message.
>>>>> v4: improve commit message and code comments further. Some more
>>>>> improvements might come in v5. No claims made here that this is
>>>>> the final one :-)
>>>>>=20
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index bf38905b7d..30ce6a78cb 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -64,6 +64,7 @@ bool pci_available =3D true;
>>>>> static char *pcibus_get_dev_path(DeviceState *dev);
>>>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>> static void pcibus_reset(BusState *qbus);
>>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>>=20
>>>>> static Property pci_props[] =3D {
>>>>>  DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>>> @@ -1182,6 +1183,11 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>>>  } else if (dev->hotplugged &&
>>>>>             !pci_is_vf(pci_dev) &&
>>>>>             pci_get_function_0(pci_dev)) {
>>>>> +        /*
>>>>> +         * populating function 0 triggers a bus scan from the =
guest that
>>>>> +         * exposes other non-zero functions. Hence we need to =
ensure that
>>>>> +         * function 0 wasn't added yet.
>>>>> +         */
>>>>=20
>>>> Pls capitalize populating. Also, comments like this should come
>>>> before the logic they document, not after. By the way it doesn't
>>>> have to be a bus scan - I'd just say "a scan" - with ACPI
>>>> guest knows what was added and can just probe the device functions.
>=20
> This commit essentially needs fixing:
>=20
> commit c46b126088b5616d8b7cd3ff83aaf5d097c36633
> Author: Michael Labiuk <michael.labiuk@virtuozzo.com>
> Date:   Fri Sep 30 01:35:42 2022 +0300
>=20
>    tests/x86: Add 'q35' machine type to override-tests in hd-geo-test
>=20
>    Signed-off-by: Michael Labiuk <michael.labiuk@virtuozzo.com>
>    Message-Id: <20220929223547.1429580-5-michael.labiuk@virtuozzo.com>
>    Signed-off-by: Thomas Huth <thuth@redhat.com>

I have sent a patch series with a proposed fix for this test =
(hd-geo-test) as well as fixes for bios-tables-test. The series also =
includes my QEMU patch that enforces proper PCIE slot usage.
The patches are part of one series and should be applied in the same =
sequence - test fixes first then the QEMU fix so that the QEMU fix does =
not break the unit tests.
Please review.

>=20
>>>>=20
>>>>>      error_setg(errp, "PCI: slot %d function 0 already occupied by =
%s,"
>>>>>                 " new func %s cannot be exposed to guest.",
>>>>>                 PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
>>>>> @@ -1189,6 +1195,18 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>>>                 name);
>>>>>=20
>>>>>     return NULL;
>>>>> +    } else if (dev->hotplugged &&
>>>>=20
>>>> why hotplugged? Doesn't the same rule apply to all devices?
>>>>=20
>>>>> +               !pci_is_vf(pci_dev) &&
>>>>=20
>>>> Hmm. I think you copied it from here:
>>>> } else if (dev->hotplugged &&
>>>>            !pci_is_vf(pci_dev) &&
>>>>            pci_get_function_0(pci_dev)) {
>>>>=20
>>>> it makes sense there because VFs are added later
>>>> after PF exists.
>>>>=20
>>>> But here it makes no sense that I can see.
>>>=20
>>> This patch with these changes causes failures in bios-tables-test =
which can be fixed easily. It also breaks hd-geo-test and I do not know =
enough of this test to fix them.
>>=20
>> Specifically it breaks test_override_scsi_q35() and =
test_override_virtio_blk_q35().=20
>> I think these tests were wrong to begin with since they attach a =
pcie-to-pci bridge on a pcie root port and then attach a scsi controller =
not on the pcie-to-pci bridge but on the root port (which is not =
possible because we can only attach one device on a non-multifunction =
pcie root port). Even if I fix them, its failing somewhere else.
>>=20
>> I have added Thomas and Laurent, maybe they can help fix these in =
this test.
>> I have pushed my patch here: =
https://gitlab.com/anisinha/qemu/-/commit/24b3eddb968a0739bff222bdf781f722=
365cc9b2
>>=20
>>=20
>>>=20
>>> I think I will drop this patch for now.
>>>=20
>>>>=20
>>>>=20
>>>>> +               pcie_has_upstream_port(pci_dev) && =
PCI_SLOT(devfn)) {
>>>>> +        /*
>>>>> +         * If the device has an upstream PCIE port, like a pcie =
root port,
>>>>=20
>>>> no, a root port can not be an upstream port.
>>>>=20
>>>>=20
>>>>> +         * we only support functions on slot 0.
>>>>> +         */
>>>>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>>>>> +                   " only functions on slot 0 is supported for =
devices"
>>>>> +                   " with an upstream PCIE port.",
>>>>=20
>>>>=20
>>>> something like:
>>>>=20
>>>>     error_setg(errp, "PCI: slot %d is not valid for %s:"
>>>>                " PCI Express devices can only be plugged into slot =
0")
>>>>=20
>>>> and then you don't really need a comment.
>>>>=20
>>>>=20
>>>>> +                   PCI_SLOT(devfn), name);
>>>>> +        return NULL;
>>>>>  }
>>>>>=20
>>>>>  pci_dev->devfn =3D devfn;
>>>>> --=20
>>>>> 2.39.1


