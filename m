Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC7B74147F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEWhN-000405-G2; Wed, 28 Jun 2023 11:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEWhM-0003zw-1M
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEWhK-0002Ha-5u
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687964579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWxh0oP8TAr6YCGQ2pyDZIag0l5umVnDmIYzYUc4ZKs=;
 b=Bh1BNwKKivnqYBxDyCrRvjXu/X4h5nI7giflgZviB9dQTjHnD0yIvBl82kqS46aaIp98gg
 l5i+69A8dYBHsP6Hc3hSa4g6tzyNPpKb3JqEEq88RjPDS9OBhMY5W1Fhm2IDV8NYEB+5Hu
 zZrP+MxbsrDKfcsf5LHyexJuW403+qI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-QZECFbZxPQKsqQHWMxd5FQ-1; Wed, 28 Jun 2023 11:02:55 -0400
X-MC-Unique: QZECFbZxPQKsqQHWMxd5FQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6686e4499b1so2756807b3a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687964563; x=1690556563;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWxh0oP8TAr6YCGQ2pyDZIag0l5umVnDmIYzYUc4ZKs=;
 b=jKxgcjlu5NP1pyoga+ZsKAdrN4MIrVEjdbqm95pNXHL6efAFOAZoN/Y30F2P9NnGkK
 UaR+5F99d17ZM0+GmK9CxEhn+tj1lO6bJKJCV2bpXZJtlxOIIQSYW2xikKPVqnCYScFy
 r94XiajMRLDxQDIVDaQqtQtpsSbngqxbE4islSqPicX732ow8uHI9u/j+eNypFkOmcj4
 FOgheZ68dhrx+l/Z/IrFbOjiHzzYCPUBW53C75tdvZd5IqmXCRlU+ssQ3s189ljS/vg3
 awAk0WVFQq8XKMWESGBc235AjmbxqBjnYXqGFh5uG5lYKcDMl34bibaiBrBpsfOzNl3B
 lL5Q==
X-Gm-Message-State: AC+VfDwB47Q+pbihwKiMwnJC87GOV2Qp8jwrUwgw0IzyNb07i5My020c
 ZAL3PkU8x/WRDjzJqNWvIBQEp9eRWWMR+rFbtNPpS+11Sj0PewfWyJmviZYWHKxTszoRpfBgoJC
 1T741gOPCtvblDU4=
X-Received: by 2002:a05:6a20:4305:b0:123:c3dc:2052 with SMTP id
 h5-20020a056a20430500b00123c3dc2052mr16947839pzk.35.1687964563309; 
 Wed, 28 Jun 2023 08:02:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4lJWqMjdgqLmfZGLURILv6+J901WnNiNp2g01ppDZ2IpAPlQQM39/KGgi+tBt7r9ZNOlVS5w==
X-Received: by 2002:a05:6a20:4305:b0:123:c3dc:2052 with SMTP id
 h5-20020a056a20430500b00123c3dc2052mr16947790pzk.35.1687964562744; 
 Wed, 28 Jun 2023 08:02:42 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.163])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a631f45000000b0051b7d83ff22sm7553755pgm.80.2023.06.28.08.02.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Jun 2023 08:02:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230627102318-mutt-send-email-mst@kernel.org>
Date: Wed, 28 Jun 2023 20:32:37 +0530
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <924159F0-292F-41B0-8424-F778545F8D9A@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
 <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
 <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
 <20230627135849.37e52f87@imammedo.users.ipa.redhat.com>
 <20230627081835-mutt-send-email-mst@kernel.org>
 <20230627143844.514594e8@imammedo.users.ipa.redhat.com>
 <20230627102318-mutt-send-email-mst@kernel.org>
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



> On 27-Jun-2023, at 7:57 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Jun 27, 2023 at 02:38:44PM +0200, Igor Mammedov wrote:
>> On Tue, 27 Jun 2023 08:23:25 -0400
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>=20
>>> On Tue, Jun 27, 2023 at 01:58:49PM +0200, Igor Mammedov wrote:
>>>> On Tue, 27 Jun 2023 15:23:04 +0530
>>>> Ani Sinha <anisinha@redhat.com> wrote:
>>>>=20
>>>>>> On 27-Jun-2023, at 2:32 PM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>>>>>=20
>>>>>> On Mon, 26 Jun 2023 21:42:44 +0530
>>>>>> Ani Sinha <anisinha@redhat.com> wrote:
>>>>>>=20
>>>>>>> PCI Express ports only have one slot, so PCI Express devices can =
only be
>>>>>>> plugged into slot 0 on a PCIE port. Enforce it.   =20
>>>>>>=20
>>>>>> btw, previously you mentioned ARI.
>>>>>> So if we turn it on, wouldn't this patch actually become =
regression?   =20
>>>>>=20
>>>>> If ARI breaks this, it will break other areas in QEMU too, ex =
anywhere pci_get_function_0() is used.
>>>>> Regardless, I think at least the tests are worth fixing, =
particularly the mess with hd-geo-test. =20
>>>>=20
>>>> I'm fine with this patch if you test it with ARI enabled and it =
won't break
>>>> something that has been working before this patch. Just mention =
what testing
>>>> you've done in commit message. =20
>>>=20
>>> Oh yes. That's why it was checking !vf originally. It's because the =
most
>>> common use of ARI is SRIOV, so it works a a kind of hack.
>>=20
>> should we check for ARI cap instead of vf hack?
>> why we haven't that from the beginning?
>=20
> Maybe.

Maybe not. I tried doing=20

!pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI)

But sadly since the device has not been fully initialised and the config =
space memory has not been allocated yet, we can=E2=80=99t check for that =
capability at that point in the code.

Seems checking for vfs is the only best approximation at this point.

> ARI is a capability, driver has to activate it, so it's not 100%
> It does not help that our ARI implementation is broken in several
> places.
>=20
>=20
>>>=20
>>>>>=20
>>>>>>=20
>>>>>>>=20
>>>>>>> CC: jusual@redhat.com
>>>>>>> CC: imammedo@redhat.com
>>>>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>>>>>> ---
>>>>>>> hw/pci/pci.c | 6 ++++++
>>>>>>> 1 file changed, 6 insertions(+)
>>>>>>>=20
>>>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>>>> index bf38905b7d..426af133b0 100644
>>>>>>> --- a/hw/pci/pci.c
>>>>>>> +++ b/hw/pci/pci.c
>>>>>>> @@ -64,6 +64,7 @@ bool pci_available =3D true;
>>>>>>> static char *pcibus_get_dev_path(DeviceState *dev);
>>>>>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>>>> static void pcibus_reset(BusState *qbus);
>>>>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>>>>=20
>>>>>>> static Property pci_props[] =3D {
>>>>>>>    DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>>>>> @@ -1189,6 +1190,11 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>>>>>                   name);
>>>>>>>=20
>>>>>>>       return NULL;
>>>>>>> +    } else if (pcie_has_upstream_port(pci_dev) && =
PCI_SLOT(devfn)) {
>>>>>>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>>>>>>> +                   " parent device only allows plugging into =
slot 0.",
>>>>>>> +                   PCI_SLOT(devfn), name);
>>>>>>> +        return NULL;
>>>>>>>    }
>>>>>>>=20
>>>>>>>    pci_dev->devfn =3D devfn;   =20
>>>>>>=20
>>>>>=20
>>>=20
>=20


