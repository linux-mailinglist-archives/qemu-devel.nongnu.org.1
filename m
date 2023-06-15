Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFBA730D87
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 05:29:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9dek-0000lo-8C; Wed, 14 Jun 2023 23:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9dei-0000lX-G8
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 23:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9deg-0001tH-CU
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 23:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686799692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NyBZOq339KD+pj4tZN/tc0VTYuXIKooZV6eygUhHaq8=;
 b=dWDVJ9S3nFSnc6GW160BnbueFTcPsfHuaeuWlLFX2AHHRqPnz0mKB64iNnopN4OHrnLlkn
 HD4sIcDUp3F1PK9G5WAdUQ5qdM7HxqfQEG3YyzRVxqiUKdNBoFkucTkAfPyT/v7dGFJwex
 jyCdGkZUJYblz53r/6W78ACNs9B0sck=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-qabO132CN3e__BeZ4wauLQ-1; Wed, 14 Jun 2023 23:28:10 -0400
X-MC-Unique: qabO132CN3e__BeZ4wauLQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-666818500b4so491363b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 20:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686799690; x=1689391690;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyBZOq339KD+pj4tZN/tc0VTYuXIKooZV6eygUhHaq8=;
 b=YX6n5Il3HyOqNnPFJEP3wJIfDtU08m+IkkFfE3wdpF3Mtge31I1l/9qQIivGtTtYWg
 uCDb3Rvmkcp92eTB8TcQ7NC6UEq8MPgSKBkQQYiYh5o/SJr1CL8tB6zr0Npq4JDMSPWO
 y6JoNVgZi4o8KpAw2ElXjPDwNxFr4ISNyY4yCYgPQ8h0JEWq3uhjks0bjv2x9g7VWR5x
 sTWk6Ke2VPyUWNf+4R5XSIcqd7K0Ph8NZooMbVuZl2M15F2wr0JulXhasDu6pdGvsNIm
 Xf5y+dREdfDP6R1ZRzb7uAsuSMF0H+MCOz20OGLlHOQay4voa4vcW6X7PVQCxls8LVv1
 cACA==
X-Gm-Message-State: AC+VfDwZeNFKi5AudEq7ENcSYt8bpZy/LnKU5+CkUt3fM1wqZEiSGUJp
 t4BTZti25nvEnAGaSNTQxIuJSamVa2F+hKT6Ni4uE4ET7zspGO7m+mOb4DG0lNeATnNn42ok8v6
 qeM1ANWOwYY1PlIc=
X-Received: by 2002:a05:6a00:390e:b0:658:7f40:652 with SMTP id
 fh14-20020a056a00390e00b006587f400652mr3749981pfb.20.1686799689730; 
 Wed, 14 Jun 2023 20:28:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ42ryWu3P8JGvcUUiUvTdVN7vwm7IQstQeQmZ3Bd8V1KJX48j+qZ7vFOvXbSKwtfCT/1ImA/Q==
X-Received: by 2002:a05:6a00:390e:b0:658:7f40:652 with SMTP id
 fh14-20020a056a00390e00b006587f400652mr3749970pfb.20.1686799689369; 
 Wed, 14 Jun 2023 20:28:09 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.99])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62bd12000000b0064ff855751fsm10960302pff.4.2023.06.14.20.28.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Jun 2023 20:28:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] hw/pci: prevent hotplug of devices on pcie-root-ports
 with wrong devfn address
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230614165051-mutt-send-email-mst@kernel.org>
Date: Thu, 15 Jun 2023 08:58:04 +0530
Cc: Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3D73D25-90A5-4EBF-9E0C-61A97E314B26@redhat.com>
References: <20230614123150.7077-1-anisinha@redhat.com>
 <20230614150157.03952658@imammedo.users.ipa.redhat.com>
 <E6BFF3BE-42D8-4651-99B1-D4BF6C1D17B1@redhat.com>
 <20230614165051-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 15-Jun-2023, at 2:22 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Jun 14, 2023 at 10:31:40PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 14-Jun-2023, at 6:31 PM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>>=20
>>> On Wed, 14 Jun 2023 18:01:50 +0530
>>> Ani Sinha <anisinha@redhat.com> wrote:
>>>=20
>>>> PCIE root ports only allow one device on slot 0/function 0. When =
hotplugging a
>>>> device on a pcie root port, make sure that the device address =
passed is
>>>> always 0x00 that represents slot 0 and function 0. Any other slot =
value and
>>>> function value would be illegal on a root port.
>>>>=20
>>>> CC: jusual@redhat.com
>>>> CC: imammedo@redhat.com
>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> ---
>>>> hw/pci/pci.c | 9 +++++++++
>>>> 1 file changed, 9 insertions(+)
>>>>=20
>>>> Note:
>>>> I tested this with both native and acpi hotplug enabled on pcie. =
The
>>>> check seems to work on both.
>>>>=20
>>>> (qemu)  netdev_add socket,id=3Dhostnet1,listen=3D:1234
>>>> (qemu) device_add =
e1000e,netdev=3Dhostnet1,mac=3D00:11:22:33:44:03,id=3Dnet1,bus=3Dpci.6,add=
r=3D0x2.0x5
>>>> Error: PCI: slot 2 function 5 is not valid for e1000e
>>>> (qemu) device_add =
e1000e,netdev=3Dhostnet1,mac=3D00:11:22:33:44:03,id=3Dnet1,bus=3Dpci.6,add=
r=3D0x0.0
>>>> (qemu) info network
>>>> net1: index=3D0,type=3Dnic,model=3De1000e,macaddr=3D00:11:22:33:44:03=

>>>> \ hostnet1: index=3D0,type=3Dsocket,
>>>> (qemu) device_del net1
>>>> (qemu) info network
>>>> hostnet1: index=3D0,type=3Dsocket,
>>>>=20
>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>> index bf38905b7d..bc39322dfd 100644
>>>> --- a/hw/pci/pci.c
>>>> +++ b/hw/pci/pci.c
>>>> @@ -64,6 +64,7 @@ bool pci_available =3D true;
>>>> static char *pcibus_get_dev_path(DeviceState *dev);
>>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>> static void pcibus_reset(BusState *qbus);
>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>=20
>>>> static Property pci_props[] =3D {
>>>>    DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>> @@ -1189,6 +1190,14 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>>                   name);
>>>>=20
>>>>       return NULL;
>>>> +    } else if (dev->hotplugged &&
>>>=20
>>>> +               !pci_is_vf(pci_dev) &&
>>>> +               pcie_has_upstream_port(pci_dev)=20
>>> can you clarify what above 2 lines are here for?
>>>=20
>>> you can't hotplug anything into upstream port (only downstream)
>>=20
>> This code checks if the hot plugged device is being plugged into a =
pcie root port. For pcie root ports, only slot 0 can be used. Please see =
3f1e1478db2d67098d9 . The conditional check just above this hunk =
therefore checks for unoccupied function 0 in slot 0 if the device is =
plugged into an upstream pcie root port. I think for hot plugs, only =
function 0 is allowed.
>=20
> Not really. The way we hotplug a multifunction device is by first
> populating all functions !=3D 0, then finally pupulating function 0
> which is when the event triggers.

Let me explain better ..

This check currently already exists:
    } else if (dev->hotplugged &&
               !pci_is_vf(pci_dev) &&
               pci_get_function_0(pci_dev)) {
        error_setg(errp, "PCI: slot %d function 0 already occupied by =
%s,"
                   " new func %s cannot be exposed to guest.",
                   PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
                   pci_get_function_0(pci_dev)->name,
                   name);

       return NULL;
    }

This code checks for unoccupied function 0. If you look into =
pci_get_function_0(), it checks for slot 0 function 0 for devices that =
are plugged into pcie root port.

>=20
>>=20
>> As for vf, I am not sure. I believe for vfs the restriction is not =
valid. I just kept the check based on the conditional just prior to it.
>>=20
>>> and why _vf() is here also not clear.
>>>=20
>>>> && devfn) {
>>>> +        /* For an upstream PCIE port, we only support one device =
at slot 0 */
>>>> +        error_setg(errp, "PCI: slot %d function %d is not valid =
for %s",
>>>> +                   PCI_SLOT(devfn), PCI_FUNC(devfn), name);
>>>> +        return NULL;
>>>> +
>>>>    }
>>>>=20
>>>>    pci_dev->devfn =3D devfn;


