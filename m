Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D2B747C98
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 07:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGvIY-0003PY-MG; Wed, 05 Jul 2023 01:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGvIK-0003PG-1g
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:43:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGvIH-0006ye-R0
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688535791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxZcxjChYU3JlE8v7xBDrkcQ1vrNAnXjLoMR7LCOC/I=;
 b=I8cjS38d+6SYiXQSR6HLHFhGUF4k7aHHAVon3tWrmagmM9CD1yMOIrYpCVRgW+gOMs8y6T
 L8UbhbQZx9AHExcGyR89wi3+EFebmvhc6MlYg+Su/LLR/zP5J7QpFOPu6i10qF3N7EGctO
 Un9h4ZYie2jGF8qSkzxGdhVR4lBIc1Q=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-BQY8OB-IMHuHlx2OqVSbrg-1; Wed, 05 Jul 2023 01:43:10 -0400
X-MC-Unique: BQY8OB-IMHuHlx2OqVSbrg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-53425d37fefso6348714a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 22:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688535789; x=1691127789;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxZcxjChYU3JlE8v7xBDrkcQ1vrNAnXjLoMR7LCOC/I=;
 b=Kj39PeiiUlmiBpOfaO4VDT637lJwSwXmMY8tKR7FcweBsb8qrentLXChKU6Y8xFt+3
 3D8iLSg2LemD3ufGhlfuOVtSSDDVfRvA6eMqxxJ5G+LAhLOgC28r+fbzAnuD3dp7Dgdb
 ySO1kg2oHpLDakaRe6jF9oUTYhZkdvS1hyR/8z6FK7Fi4aqQ6zGfCFjpuZ/UHZQZLj6c
 XAKIegt2N8513u6slyINYg5LelMpB30amnZWtE6L/C1rNPtLKgG7du/aM6+neUDTJsya
 0BIUBg7wnXv+ZKfRB86f+rPa8H5kNyIqBYAoGSnfiybSInc4W5HyCD1XMpwrpxlXiPQh
 I4/A==
X-Gm-Message-State: ABy/qLbA9bHZ3TlIjeUVw0Ljc+u2hh3gQwYE17vi2/YNV85Xjr2sDdMU
 Y1E16vmbT1mKBdtw2FG9je6VujRLNk6nbgx1vFxJydWEHmICeFigFins3K0gtHiUQh2FH7RZZWH
 ZVjIfjCrAeGiiyN0=
X-Received: by 2002:a05:6a20:728c:b0:12f:c61e:7cc4 with SMTP id
 o12-20020a056a20728c00b0012fc61e7cc4mr89505pzk.33.1688535788956; 
 Tue, 04 Jul 2023 22:43:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPxRAFkoxQZx5ZgJD6871USv2uyoOgjUO9doJuYQAdMHAQurrHFykJ0Qwwac7kVRGd8M4tLA==
X-Received: by 2002:a05:6a20:728c:b0:12f:c61e:7cc4 with SMTP id
 o12-20020a056a20728c00b0012fc61e7cc4mr89488pzk.33.1688535788528; 
 Tue, 04 Jul 2023 22:43:08 -0700 (PDT)
Received: from smtpclient.apple ([115.96.119.220])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a170902d38200b001b87bedcc6fsm7292816pld.93.2023.07.04.22.43.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jul 2023 22:43:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <0815cf6b-9739-8494-89db-3f2cdf032d40@daynix.com>
Date: Wed, 5 Jul 2023 11:13:03 +0530
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C3053F47-2C39-4CB4-BEBD-9EC95CF1C4BC@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
 <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
 <2C9BF0F4-6CB0-4805-818D-51CABC1EAFDE@redhat.com>
 <bf793e6b-62a0-0772-0d64-ddb5894ebf53@daynix.com>
 <20230704144825.181a1629@imammedo.users.ipa.redhat.com>
 <EC8A962B-80F5-499F-9EA8-CC53DA160F1D@redhat.com>
 <20230704162836.61a08ff9@imammedo.users.ipa.redhat.com>
 <AD213C8D-85EC-43F6-B9C0-3541BFBDCBCF@redhat.com>
 <0815cf6b-9739-8494-89db-3f2cdf032d40@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 05-Jul-2023, at 7:09 AM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
>=20
>=20
> On 2023/07/05 0:07, Ani Sinha wrote:
>>> On 04-Jul-2023, at 7:58 PM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>>=20
>>> On Tue, 4 Jul 2023 19:20:00 +0530
>>> Ani Sinha <anisinha@redhat.com> wrote:
>>>=20
>>>>> On 04-Jul-2023, at 6:18 PM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>>>>=20
>>>>> On Tue, 4 Jul 2023 21:02:09 +0900
>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>=20
>>>>>> On 2023/07/04 20:59, Ani Sinha wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>>> On 04-Jul-2023, at 5:24 PM, Akihiko Odaki =
<akihiko.odaki@daynix.com> wrote:
>>>>>>>>=20
>>>>>>>> On 2023/07/04 20:25, Ani Sinha wrote:
>>>>>>>>> PCI Express ports only have one slot, so PCI Express devices =
can only be
>>>>>>>>> plugged into slot 0 on a PCIE port. Add a warning to let users =
know when the
>>>>>>>>> invalid configuration is used. We may enforce this more =
strongly later on once
>>>>>>>>> we get more clarity on whether we are introducing a bad =
regression for users
>>>>>>>>> currenly using the wrong configuration.
>>>>>>>>> The change has been tested to not break or alter behaviors of =
ARI capable
>>>>>>>>> devices by instantiating seven vfs on an emulated igb device =
(the maximum
>>>>>>>>> number of vfs the linux igb driver supports). The vfs =
instantiated correctly
>>>>>>>>> and are seen to have non-zero device/slot numbers in the =
conventional PCI BDF
>>>>>>>>> representation.
>>>>>>>>> CC: jusual@redhat.com
>>>>>>>>> CC: imammedo@redhat.com
>>>>>>>>> CC: mst@redhat.com
>>>>>>>>> CC: akihiko.odaki@daynix.com
>>>>>>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>>>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>>>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>>>>>>>> ---
>>>>>>>>> hw/pci/pci.c | 15 +++++++++++++++
>>>>>>>>> 1 file changed, 15 insertions(+)
>>>>>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>>>>>> index e2eb4c3b4a..47517ba3db 100644
>>>>>>>>> --- a/hw/pci/pci.c
>>>>>>>>> +++ b/hw/pci/pci.c
>>>>>>>>> @@ -65,6 +65,7 @@ bool pci_available =3D true;
>>>>>>>>> static char *pcibus_get_dev_path(DeviceState *dev);
>>>>>>>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>>>>>> static void pcibus_reset(BusState *qbus);
>>>>>>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>>>>>>   static Property pci_props[] =3D {
>>>>>>>>>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>>>>>>> @@ -2121,6 +2122,20 @@ static void =
pci_qdev_realize(DeviceState *qdev, Error **errp)
>>>>>>>>>         }
>>>>>>>>>     }
>>>>>>>>> +    /*
>>>>>>>>> +     * With SRIOV and ARI, vfs can have non-zero slot in the =
conventional
>>>>>>>>> +     * PCI interpretation as all five bits reserved for slot =
addresses are
>>>>>>>>> +     * also used for function bits for the various vfs. =
Ignore that case.
>>>>>>>>=20
>>>>>>>> You don't have to mention SR/IOV; it affects all ARI-capable =
devices. A PF can also have non-zero slot number in the conventional =
interpretation so you shouldn't call it vf either.
>>>>>>>=20
>>>>>>> Can you please help write a comment that explains this properly =
for all cases - ARI/non-ARI, PFs and VFs? Once everyone agrees that its =
clear and correct, I will re-spin.
>>>>>>=20
>>>>>> Simply, you can say:
>>>>>> With ARI, the slot number field in the conventional PCI =
interpretation
>>>>>> can have a non-zero value as the field bits are reused to extend =
the
>>>>>> function number bits. Ignore that case.
>>>>>=20
>>>>> mentioning 'conventional PCI interpretation' in comment and then =
immediately
>>>>> checking 'pci_is_express(pci_dev)' is confusing. Since comment =
belongs
>>>>> only to PCIE branch it would be better to talk in only about PCIe =
stuff
>>>>> and referring to relevant portions of spec.
>>>>=20
>>>> Ok so how about this?
>>>>=20
>>>>   * With ARI, devices can have non-zero slot in the traditional BDF
>>>>     * representation as all five bits reserved for slot addresses =
are
>>>>     * also used for function bits. Ignore that case.
>>>=20
>>> you still refer to traditional (which I misread as 'conventional'),
>>> steal the linux comment and argument it with ARI if necessary,
>>> something like this (probably needs some more massaging):
>> The comment messaging in these patches seems to exceed the value of =
the patch itself :-)
>> How about this?
>>     /*
>>      * A PCIe Downstream Port normally leads to a Link with only =
Device
>>      * 0 on it (PCIe spec r3.1, sec 7.3.1).
>>      * With ARI, PCI_SLOT() can return non-zero value as all five =
bits
>>      * reserved for slot addresses are also used for function bits.
>>      * Hence, ignore ARI capable devices.
>>      */
>=20
> Perhaps: s/normally leads to/must lead to/
>=20
> =46rom the kernel perspective, they may need to deal with a quirky =
hardware that does not conform with the specification, but from QEMU =
perspective, it is what we *must* conform with.

PCI base spec 4.0, rev 3, section 7.3.1 says:

" =20
Downstream Ports that do not have ARI Forwarding enabled must associate =
only Device 0 with the device attached to the Logical Bus representing =
the Link from the Port. Configuration Requests 15 targeting the Bus =
Number associated with a Link specifying Device Number 0 are delivered =
to the device attached to the Link; Configuration Requests specifying =
all other Device Numbers (1-31) must be terminated by the Switch =
Downstream Port or the Root Port with an Unsupported Request Completion =
Status (equivalent to Master Abort in PCI). Non-ARI Devices must not =
assume that Device Number 0 is associated with their Upstream Port, but =
must capture their assigned Device Number as discussed in Section =
2.2.6.2. Non-ARI Devices must respond to all Type 0 Configuration Read =
Requests, regardless of the Device Number specified in the Request.

=E2=80=A6

With an ARI Device, its Device Number is implied to be 0 rather than =
specified by a field within an ID. The traditional 5-bit Device Number =
and 3-bit Function Number fields in its associated Routing IDs, =
Requester IDs, and Completer IDs are interpreted as a single 8-bit =
Function Number. See Section 6.13. Any Type 0 Configuration Request =
targeting an unimplemented Function in an ARI Device must be handled as =
an Unsupported Request.

=E2=80=9C

So it seems they do indeed use the =E2=80=9Cmust=E2=80=9D clause. I =
prefer to use the line from the spec verbatim as possible. Hence, this =
is what I am going with and be done with this patchset:

    /*                                                                   =
                                                                         =
     =20
     * A PCIe Downstream Port that do not have ARI Forwarding enabled =
must                                                                     =
        =20
     * associate only Device 0 with the device attached to the bus       =
                                                                         =
     =20
     * representing the Link from the Port (PCIe base spec rev 4.0 ver =
0.3,                                                                     =
       =20
     * sec 7.3.1).                                                       =
                                                                         =
     =20
     * With ARI, PCI_SLOT() can return non-zero value as the traditional =
                                                                         =
     =20
     * 5-bit Device Number and 3-bit Function Number fields in its =
associated                                                               =
           =20
     * Routing IDs, Requester IDs and Completer IDs are interpreted as a =
                                                                         =
     =20
     * single 8-bit Function Number. Hence, ignore ARI capable devices.  =
                                                                         =
     =20
     */


>=20
> Otherwise looks good to me.
>=20
>>>=20
>>>=20
>>>         /*
>>>         * A PCIe Downstream Port normally leads to a Link with only =
Device
>>>         * 0 on it (PCIe spec r3.1, sec 7.3.1).
>>>          However PCI_SLOT() is broken if ARI is enabled, hence work =
around it
>>>          by skipping check if the later cap is present.
>>>         */
>>>=20
>>>>=20
>>>>=20
>>>>> (for example see how it's done in kernel code: only_one_child(...)
>>>>>=20
>>>>> PS:
>>>>> kernel can be forced  to scan for !0 device numbers, but that's =
rather
>>>>> a hack, so we shouldn't really care about that.
>>>>>=20
>>>>>>=20
>>>>>>>=20
>>>>>>>>=20
>>>>>>>>> +     */
>>>>>>>>> +    if (pci_is_express(pci_dev) &&
>>>>>>>>> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>>>>>>>>> +        pcie_has_upstream_port(pci_dev) &&
>>>>>>>>> +        PCI_SLOT(pci_dev->devfn)) {
>>>>>>>>> +        warn_report("PCI: slot %d is not valid for %s,"
>>>>>>>>> +                    " parent device only allows plugging into =
slot 0.",
>>>>>>>>> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>>     if (pci_dev->failover_pair_id) {
>>>>>>>>>         if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
>>>>>>>>>             error_setg(errp, "failover primary device must be =
on "
>>>>=20
>>>=20
>=20


