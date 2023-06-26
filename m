Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193D73D8D3
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:50:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDgym-0001VL-57; Mon, 26 Jun 2023 03:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDgye-0001Rp-Gg
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDgyc-0002vE-Jg
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687765773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tbRLPdnpHFupGqq6Mh1rkW354837MdnnvhuQ/O2U98=;
 b=ARBPWbYrvT47NyNgbpp173pQhb1uOrCey/Za8BXxFq6E5RcCXvq3zrSLrfrLrufNlM5ZxN
 uevfvTR4mflG9D2knwkWkj6BW7k8+qf8tGOZOlX6t3D0mvgJwg70y3i4KPmGyK4+uSfECu
 8x0Z6PdeRybFZ8VxKh5qZtT2cyxxuQk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-uETLJIfsOGChQ9GRoJcg5A-1; Mon, 26 Jun 2023 03:49:31 -0400
X-MC-Unique: uETLJIfsOGChQ9GRoJcg5A-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-262d69faef9so492632a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 00:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687765770; x=1690357770;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+tbRLPdnpHFupGqq6Mh1rkW354837MdnnvhuQ/O2U98=;
 b=Z31XI1FKErvkPSXqK4CEUzmEDDT/L+R3YIYS+01m+nX7DHJltD8DBouMYaAYkSMcwX
 zbF0Ez9GNnbDg8TBH0EM8UuW7ipp8JCcnDSf6g/sG57GpkeF7aaUwVOfIDtW8ErUfKvb
 NaKxg7xYRd2i9dFGk2qudvHOVrCRVMRxDViUGCazKqfoD8hWzwRtkOkJkJe3hO4m7uSp
 4xoU3K64O8aKi7UX/eokQrjJkN3d0MMVyB4sp5BGa7MLq7fhlx+SOzvJDaZ42uxyKTUe
 dir1yvsodny06BEvq1eft7w8PQ++jUGCr07EElmabSMjfWl2ILcp/OR5UhTvfJpy+MW1
 bXAg==
X-Gm-Message-State: AC+VfDya4N5rema2ihw3QSw0pn7u/OFtHz6+6LJ8gP6+Flv64Bl0OeKI
 4JgDsgMVHb+G9Nmd6c2uTxeSVpwERw9WqdQrcdrKUUEIsEFG3EArDMJ7ldRmsFldSCXlDRwxOjJ
 6bnmmDN/IMyYd/bI=
X-Received: by 2002:a17:90b:2246:b0:24e:1575:149 with SMTP id
 hk6-20020a17090b224600b0024e15750149mr19706734pjb.48.1687765770471; 
 Mon, 26 Jun 2023 00:49:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YH9vhF0Ss+u6hbPB6xaHjZG3v7McZFdhLF37E9Sq2aXfUITvjHny23RXw8dAtqG0oLAgkAw==
X-Received: by 2002:a17:90b:2246:b0:24e:1575:149 with SMTP id
 hk6-20020a17090b224600b0024e15750149mr19706725pjb.48.1687765770131; 
 Mon, 26 Jun 2023 00:49:30 -0700 (PDT)
Received: from smtpclient.apple ([115.96.139.77])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a17090a34c300b0025bb1bdb989sm4173279pjf.29.2023.06.26.00.49.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Jun 2023 00:49:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v2 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230625171058-mutt-send-email-mst@kernel.org>
Date: Mon, 26 Jun 2023 13:19:25 +0530
Cc: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8552DE01-FFCC-47ED-B1C2-2948934D31D0@redhat.com>
References: <20230622103255.267289-1-anisinha@redhat.com>
 <20230622103255.267289-6-anisinha@redhat.com>
 <CAMDeoFWHJhN3ppAO4XB9jGUg4Yu-zFzzzKwAvDiSJSgjeZH6jg@mail.gmail.com>
 <20230622134437-mutt-send-email-mst@kernel.org>
 <CAMDeoFUAaRhN_hRHmTDfu6dWyiz_dNEhCJt9jQTVzeNSTbwuAg@mail.gmail.com>
 <20230625171058-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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



> On 26-Jun-2023, at 2:41 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Fri, Jun 23, 2023 at 04:57:20PM +0200, Julia Suvorova wrote:
>> On Thu, Jun 22, 2023 at 7:48=E2=80=AFPM Michael S. Tsirkin =
<mst@redhat.com> wrote:
>>>=20
>>> On Thu, Jun 22, 2023 at 05:46:40PM +0200, Julia Suvorova wrote:
>>>> On Thu, Jun 22, 2023 at 12:34=E2=80=AFPM Ani Sinha =
<anisinha@redhat.com> wrote:
>>>>>=20
>>>>> PCI Express ports only have one slot, so PCI Express devices can =
only be
>>>>> plugged into slot 0 on a PCIE port. Enforce it.
>>>>>=20
>>>>> CC: jusual@redhat.com
>>>>> CC: imammedo@redhat.com
>>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>> ---
>>>>> hw/pci/pci.c | 6 ++++++
>>>>> 1 file changed, 6 insertions(+)
>>>>>=20
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index bf38905b7d..5f25ab9f5e 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -64,6 +64,7 @@ bool pci_available =3D true;
>>>>> static char *pcibus_get_dev_path(DeviceState *dev);
>>>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>> static void pcibus_reset(BusState *qbus);
>>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>>=20
>>>>> static Property pci_props[] =3D {
>>>>>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>>> @@ -1189,6 +1190,11 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>>>                    name);
>>>>>=20
>>>>>        return NULL;
>>>>> +    } else if (pcie_has_upstream_port(pci_dev) && =
PCI_SLOT(devfn)) {
>>>>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>>>>> +                   " PCI express devices can only be plugged into =
slot 0.",
>>>>=20
>>>> This is not technically correct, because downstream ports and root
>>>> ports are also PCIe devices, and they can have different slots =
under
>>>> upstream ports and RC. But this error will never be shown for them, =
so
>>>> it seems fine.
>>>=20
>>> Hmm. Confusing users is not nice ... I agree this might
>>> make people think they can not use root ports in slot !=3D0 either.
>>>=20
>>> Would you add "with an upstream port"?
>>> E.g. "PCI Express devices with an upstream port" ?
>>=20
>> This whole upstream port conditioning is quite confusing.
>> How about "%parent device% only allows plugging into slot 0"?
>>=20
>> Best regards, Julia Suvorova.
>=20
> Good idea!

OK I will send out another iteration once Igor has a chance to take a =
look at the test fixes or someone else reviews them.=20

>=20
>>>>=20
>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>> +                   PCI_SLOT(devfn), name);
>>>>> +        return NULL;
>>>>>     }
>>>>>=20
>>>>>     pci_dev->devfn =3D devfn;
>>>>> --
>>>>> 2.39.1
>>>>>=20
>>>=20
>=20


