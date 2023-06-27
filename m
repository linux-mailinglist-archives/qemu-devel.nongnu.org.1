Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E05573FC01
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:30:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7op-0007EB-HN; Tue, 27 Jun 2023 08:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE7ol-0007DE-Lx
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE7oj-00057p-TW
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687868949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qn4330NLkDMM0kq0yjEm518/dloKf9owKbTjx8tMnrE=;
 b=W0FW4ZASadPi7rhAtf+F/Htm6PyhRskXVPdahWmGL2PckkZtjiPEm1Wo96khL42x+7xUqu
 5x9zz/X9B2h6G+Q9s3Z9juGqnljZnAautrGNX3TE9yWoZHTHShel9urskLKah93gnTNywm
 diq282oyZgjq+yL++00s2QuN+v2eDBU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-h4XbyK38MQqo8IHDsGEqZg-1; Tue, 27 Jun 2023 08:29:07 -0400
X-MC-Unique: h4XbyK38MQqo8IHDsGEqZg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-395ff4dc3abso4972489b6e.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687868947; x=1690460947;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qn4330NLkDMM0kq0yjEm518/dloKf9owKbTjx8tMnrE=;
 b=hUB3UMJCAEvYi8Kkcr8rRhruIhDrK68sls5iudJlvYq8LbDx+JQHGCYR/P1whtMELG
 JIPbPjSKDp6/jZkwWmgw+nfuxPWME3LhBW5UzGbdLu1+yF8FZ3xqhRCAwtEizRFQoTDx
 0AtSlpDBBt41nvWIdAH5IDiZYn6L018hwh4qXOAFbxqu9HuiPDQBZPd4jbLXY5iYd2zT
 VZPQuz1VB4nIQMxL75N1ZI9DmURRksidIk3+70omMBluxHYk342CJ8hkDJCV2cOO3uJs
 WD/tvn1yM3J9pM5bYdT0XgC29zuz0wLl09sAey1sbOwfKreizf3uQ8E2phZZmrX1sKGn
 csBw==
X-Gm-Message-State: AC+VfDx/yTOYyPLAUnVtk4K5yFana647+dCF+pzuv8Ag+N8jL6W02B2L
 N1paSWKIgo9sBRghybs4DAixu1us1xOoAofZA9LP71oV+Q0ZCSMFFw5p66Mnk14QpRmFm5xQzfc
 Vqk/e6bKE3tLVxww=
X-Received: by 2002:a05:6808:f8a:b0:3a1:cb53:2c2f with SMTP id
 o10-20020a0568080f8a00b003a1cb532c2fmr9036659oiw.17.1687868946895; 
 Tue, 27 Jun 2023 05:29:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yaKaBgn/WLLAg9fQg4fjNGKeQv8okwFW1quUvyO2qQ+4+uPbbCgptpZn/zF66ZE2TRVJz7g==
X-Received: by 2002:a05:6808:f8a:b0:3a1:cb53:2c2f with SMTP id
 o10-20020a0568080f8a00b003a1cb532c2fmr9036650oiw.17.1687868946681; 
 Tue, 27 Jun 2023 05:29:06 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.30])
 by smtp.gmail.com with ESMTPSA id
 x13-20020a17090a1f8d00b0025bf9e02e1bsm6487520pja.51.2023.06.27.05.29.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Jun 2023 05:29:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230627081835-mutt-send-email-mst@kernel.org>
Date: Tue, 27 Jun 2023 17:59:02 +0530
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <41FA6F3E-2068-44CC-9457-37F11021BDD2@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
 <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
 <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
 <20230627135849.37e52f87@imammedo.users.ipa.redhat.com>
 <20230627081835-mutt-send-email-mst@kernel.org>
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



> On 27-Jun-2023, at 5:53 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Jun 27, 2023 at 01:58:49PM +0200, Igor Mammedov wrote:
>> On Tue, 27 Jun 2023 15:23:04 +0530
>> Ani Sinha <anisinha@redhat.com> wrote:
>>=20
>>>> On 27-Jun-2023, at 2:32 PM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>>>=20
>>>> On Mon, 26 Jun 2023 21:42:44 +0530
>>>> Ani Sinha <anisinha@redhat.com> wrote:
>>>>=20
>>>>> PCI Express ports only have one slot, so PCI Express devices can =
only be
>>>>> plugged into slot 0 on a PCIE port. Enforce it. =20
>>>>=20
>>>> btw, previously you mentioned ARI.
>>>> So if we turn it on, wouldn't this patch actually become =
regression? =20
>>>=20
>>> If ARI breaks this, it will break other areas in QEMU too, ex =
anywhere pci_get_function_0() is used.
>>> Regardless, I think at least the tests are worth fixing, =
particularly the mess with hd-geo-test.
>>=20
>> I'm fine with this patch if you test it with ARI enabled and it won't =
break
>> something that has been working before this patch. Just mention what =
testing
>> you've done in commit message.
>=20
> Oh yes. That's why it was checking !vf originally. It's because the =
most
> common use of ARI is SRIOV, so it works a a kind of hack.

Ok so should I put it back?
Also I was thinking of running the qtest and avocado test mentioned in =
https://www.qemu.org/docs/master/system/devices/igb.html . Not sure if =
it would be enough to test ARI.

>=20
>>>=20
>>>>=20
>>>>>=20
>>>>> CC: jusual@redhat.com
>>>>> CC: imammedo@redhat.com
>>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>>>> ---
>>>>> hw/pci/pci.c | 6 ++++++
>>>>> 1 file changed, 6 insertions(+)
>>>>>=20
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index bf38905b7d..426af133b0 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -64,6 +64,7 @@ bool pci_available =3D true;
>>>>> static char *pcibus_get_dev_path(DeviceState *dev);
>>>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>> static void pcibus_reset(BusState *qbus);
>>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>>=20
>>>>> static Property pci_props[] =3D {
>>>>>    DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>>> @@ -1189,6 +1190,11 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>>>                   name);
>>>>>=20
>>>>>       return NULL;
>>>>> +    } else if (pcie_has_upstream_port(pci_dev) && =
PCI_SLOT(devfn)) {
>>>>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>>>>> +                   " parent device only allows plugging into slot =
0.",
>>>>> +                   PCI_SLOT(devfn), name);
>>>>> +        return NULL;
>>>>>    }
>>>>>=20
>>>>>    pci_dev->devfn =3D devfn; =20


