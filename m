Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE027474F8
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:09:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhdO-0000sn-LN; Tue, 04 Jul 2023 11:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGhdC-0000qA-Na
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGhdA-00071z-Ca
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688483271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLojf0Vqx4Eo3eQQF/ShQWsQsW/VnY8rgRDVERX/bxk=;
 b=YpuZmwzBuTTG0p2tCGwY0L/5d1eCBNDrg17GINp1cdXOMZucfaUCnSKFcUGpgiLLR9e4Hf
 /90aAbpfyN708Xc7KR2wOcivxROWbpjY+Svw5+r7OWANGvUs2G+iVwFmf9wQ802BQcZM3N
 64UtnyLTe0j+ht6NCLhF0BeHQqPW4K0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-b-wJKIWXMXepjkHtJHaO_A-1; Tue, 04 Jul 2023 11:07:50 -0400
X-MC-Unique: b-wJKIWXMXepjkHtJHaO_A-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-66872889417so5289082b3a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688483269; x=1691075269;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLojf0Vqx4Eo3eQQF/ShQWsQsW/VnY8rgRDVERX/bxk=;
 b=l4IbH6XPumcIuao5uhR7XxqUndmPJG9tGygPK3thTNcnGbKwqTdE5JHS+hWew19OgS
 92UAF2+3Im6s9e1r1zI8aRXpXKVs379ZFhHQSEr+GcQVdylIdspgteFbJLRrjKzgOl4d
 jrYfYeh5wcVcEaYk4L40Up9yXdJx+4nwyTInTARDaFiGoAJPC7m7KxxcjPIpYSZBVve1
 oPwtzkQwIGJWXpScdg0/MPqs7bnDEJYxlrBDvXo0ZnSiVg7XuWNSWBSyFzaMueU7Vr4/
 nKqFIDxypRPpwmkP0sKDrF86zMns5i+DED9pqeJ2bTc+rIvkVzcUIRF5SKHcfUs+xNwz
 A3hA==
X-Gm-Message-State: ABy/qLZ8K/XPnpxbUkXn28N7NQH4ygW6ft1wkH9FQL8beabpE/rChj4g
 pMUZ0NHVoYMaJnq9n7dV8RuhNvNHN8l35hh+An9+PQqzH28MpPBxQuffeogiKJ8suNKyw7SYMJx
 q9x6LbJkT60TaShA=
X-Received: by 2002:a62:7b49:0:b0:67e:5edd:e6f2 with SMTP id
 w70-20020a627b49000000b0067e5edde6f2mr8893860pfc.0.1688483268671; 
 Tue, 04 Jul 2023 08:07:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHCqxS9c3p5boidewiQdUoItQuasmPx70oSQLji1WnAdP3r2RVHrnxP7NEgWS+cq5O6yD2VHA==
X-Received: by 2002:a62:7b49:0:b0:67e:5edd:e6f2 with SMTP id
 w70-20020a627b49000000b0067e5edde6f2mr8893838pfc.0.1688483268282; 
 Tue, 04 Jul 2023 08:07:48 -0700 (PDT)
Received: from smtpclient.apple ([115.96.131.170])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a63e346000000b00553b9e0510esm16309470pgj.60.2023.07.04.08.07.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jul 2023 08:07:47 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230704162836.61a08ff9@imammedo.users.ipa.redhat.com>
Date: Tue, 4 Jul 2023 20:37:43 +0530
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD213C8D-85EC-43F6-B9C0-3541BFBDCBCF@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
 <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
 <2C9BF0F4-6CB0-4805-818D-51CABC1EAFDE@redhat.com>
 <bf793e6b-62a0-0772-0d64-ddb5894ebf53@daynix.com>
 <20230704144825.181a1629@imammedo.users.ipa.redhat.com>
 <EC8A962B-80F5-499F-9EA8-CC53DA160F1D@redhat.com>
 <20230704162836.61a08ff9@imammedo.users.ipa.redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 04-Jul-2023, at 7:58 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Tue, 4 Jul 2023 19:20:00 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>=20
>>> On 04-Jul-2023, at 6:18 PM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>>=20
>>> On Tue, 4 Jul 2023 21:02:09 +0900
>>> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>=20
>>>> On 2023/07/04 20:59, Ani Sinha wrote: =20
>>>>>=20
>>>>>=20
>>>>>> On 04-Jul-2023, at 5:24 PM, Akihiko Odaki =
<akihiko.odaki@daynix.com> wrote:
>>>>>>=20
>>>>>> On 2023/07/04 20:25, Ani Sinha wrote:   =20
>>>>>>> PCI Express ports only have one slot, so PCI Express devices can =
only be
>>>>>>> plugged into slot 0 on a PCIE port. Add a warning to let users =
know when the
>>>>>>> invalid configuration is used. We may enforce this more strongly =
later on once
>>>>>>> we get more clarity on whether we are introducing a bad =
regression for users
>>>>>>> currenly using the wrong configuration.
>>>>>>> The change has been tested to not break or alter behaviors of =
ARI capable
>>>>>>> devices by instantiating seven vfs on an emulated igb device =
(the maximum
>>>>>>> number of vfs the linux igb driver supports). The vfs =
instantiated correctly
>>>>>>> and are seen to have non-zero device/slot numbers in the =
conventional PCI BDF
>>>>>>> representation.
>>>>>>> CC: jusual@redhat.com
>>>>>>> CC: imammedo@redhat.com
>>>>>>> CC: mst@redhat.com
>>>>>>> CC: akihiko.odaki@daynix.com
>>>>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>>>>>> ---
>>>>>>> hw/pci/pci.c | 15 +++++++++++++++
>>>>>>> 1 file changed, 15 insertions(+)
>>>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>>>> index e2eb4c3b4a..47517ba3db 100644
>>>>>>> --- a/hw/pci/pci.c
>>>>>>> +++ b/hw/pci/pci.c
>>>>>>> @@ -65,6 +65,7 @@ bool pci_available =3D true;
>>>>>>> static char *pcibus_get_dev_path(DeviceState *dev);
>>>>>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>>>> static void pcibus_reset(BusState *qbus);
>>>>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>>>>   static Property pci_props[] =3D {
>>>>>>>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>>>>> @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState =
*qdev, Error **errp)
>>>>>>>         }
>>>>>>>     }
>>>>>>> +    /*
>>>>>>> +     * With SRIOV and ARI, vfs can have non-zero slot in the =
conventional
>>>>>>> +     * PCI interpretation as all five bits reserved for slot =
addresses are
>>>>>>> +     * also used for function bits for the various vfs. Ignore =
that case.   =20
>>>>>>=20
>>>>>> You don't have to mention SR/IOV; it affects all ARI-capable =
devices. A PF can also have non-zero slot number in the conventional =
interpretation so you shouldn't call it vf either.   =20
>>>>>=20
>>>>> Can you please help write a comment that explains this properly =
for all cases - ARI/non-ARI, PFs and VFs? Once everyone agrees that its =
clear and correct, I will re-spin.   =20
>>>>=20
>>>> Simply, you can say:
>>>> With ARI, the slot number field in the conventional PCI =
interpretation=20
>>>> can have a non-zero value as the field bits are reused to extend =
the=20
>>>> function number bits. Ignore that case. =20
>>>=20
>>> mentioning 'conventional PCI interpretation' in comment and then =
immediately
>>> checking 'pci_is_express(pci_dev)' is confusing. Since comment =
belongs
>>> only to PCIE branch it would be better to talk in only about PCIe =
stuff
>>> and referring to relevant portions of spec. =20
>>=20
>> Ok so how about this?
>>=20
>>   * With ARI, devices can have non-zero slot in the traditional BDF   =
                                                                         =
     =20
>>     * representation as all five bits reserved for slot addresses are =
                                                                         =
       =20
>>     * also used for function bits. Ignore that case. =20
>=20
> you still refer to traditional (which I misread as 'conventional'),
> steal the linux comment and argument it with ARI if necessary,
> something like this (probably needs some more massaging):

The comment messaging in these patches seems to exceed the value of the =
patch itself :-)

How about this?

    /*                                                                   =
                                                                         =
     =20
     * A PCIe Downstream Port normally leads to a Link with only Device  =
                                                                         =
     =20
     * 0 on it (PCIe spec r3.1, sec 7.3.1).                              =
                                                                         =
     =20
     * With ARI, PCI_SLOT() can return non-zero value as all five bits   =
                                                                         =
     =20
     * reserved for slot addresses are also used for function bits.      =
                                                                         =
     =20
     * Hence, ignore ARI capable devices.                                =
                                                                         =
     =20
     */

>=20
>=20
>         /*                                                             =
         =20
>         * A PCIe Downstream Port normally leads to a Link with only =
Device     =20
>         * 0 on it (PCIe spec r3.1, sec 7.3.1).=20
>          However PCI_SLOT() is broken if ARI is enabled, hence work =
around it
>          by skipping check if the later cap is present.                =
                 =20
>         */
>=20
>>=20
>>=20
>>> (for example see how it's done in kernel code: only_one_child(...)
>>>=20
>>> PS:
>>> kernel can be forced  to scan for !0 device numbers, but that's =
rather
>>> a hack, so we shouldn't really care about that.
>>>=20
>>>>=20
>>>>>=20
>>>>>>=20
>>>>>>> +     */
>>>>>>> +    if (pci_is_express(pci_dev) &&
>>>>>>> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>>>>>>> +        pcie_has_upstream_port(pci_dev) &&
>>>>>>> +        PCI_SLOT(pci_dev->devfn)) {
>>>>>>> +        warn_report("PCI: slot %d is not valid for %s,"
>>>>>>> +                    " parent device only allows plugging into =
slot 0.",
>>>>>>> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
>>>>>>> +    }
>>>>>>> +
>>>>>>>     if (pci_dev->failover_pair_id) {
>>>>>>>         if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
>>>>>>>             error_setg(errp, "failover primary device must be on =
"   =20
>>=20
>=20


