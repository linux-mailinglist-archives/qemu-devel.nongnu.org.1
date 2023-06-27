Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B527F73FB7E
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:56:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7Id-0000ET-Vw; Tue, 27 Jun 2023 07:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE7Ib-0008MW-1K
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE7IY-0005m0-Vm
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687866954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YfCwiNFGT8ZcZi/m0yNbERH3+kyV/v29K+vn34rAQYQ=;
 b=DBsTxK0fnBxXHJLqiz8crmGPf9hWrfTTBojcDLe3lxwJPYVGyPPIGrMUXb4ZP7fn5xeALe
 a5OeXLUM+cBbmOh/qtQhRvLFqDfOvNzLzLLXBdVMZuv1EGFXAQfYnqoBtcFfvdCrD2zUZK
 EBQok81ZDuuu5ZToEa7W8lQU9IDCyEg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-OoS4R2GRNM69nLI3O5FV2Q-1; Tue, 27 Jun 2023 07:55:52 -0400
X-MC-Unique: OoS4R2GRNM69nLI3O5FV2Q-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-66872bfa48aso3872122b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687866936; x=1690458936;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfCwiNFGT8ZcZi/m0yNbERH3+kyV/v29K+vn34rAQYQ=;
 b=kkNzRDMvNvQq9pf5ahuvjvmPWrKbTbc95Iqrh4grzSJ37mwv9aoGEb1Yl4JIGvWJ+b
 rHfdIE5RWAZ/yML42+KR2K+SzpGHHVdRVYaNi2FTQAOFNQ4NPKbNK2XS6ZnANpjoHC3u
 R3gALrpYMnOasR+zrqPXC8I07dM+OIzWTqpoCjXHvva6WAMga4aCNJMzp1oqvbBRGMDB
 j415BS6qm9pnkNwHYgBv2SnYcJX6yTwAa6kSkHuVk5/Q5+U0bfDgc5/qitoGf6u632E8
 2jfyeF6gXOP31a+NplyEQguMnRPrpUdxnkc+oik46Pp4vbrcPU2FmRevn8L/eL8xauYF
 Y9Dg==
X-Gm-Message-State: AC+VfDwkEy+oVMJbo65d3SnEq+doHejcKo1LjHe3V+KOAsOq4766X19H
 THXaBMTePPK3MYJikm6LzkFzkhwncZCjYwB+ftIrg/rbFcGESAwk+Hg+ansItay8nL0j9NWnmuF
 8x6eeW3nXXl5gRTk=
X-Received: by 2002:a05:6a00:2351:b0:668:6445:8931 with SMTP id
 j17-20020a056a00235100b0066864458931mr38750465pfj.29.1687866936362; 
 Tue, 27 Jun 2023 04:55:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ654SC9EdN4F3pfXQhN/QAVdHmdttgc+KxFqda7HpJV/qqDZTcHctMaMDg/Hm+ulpQd7vccNA==
X-Received: by 2002:a05:6a00:2351:b0:668:6445:8931 with SMTP id
 j17-20020a056a00235100b0066864458931mr38750442pfj.29.1687866936052; 
 Tue, 27 Jun 2023 04:55:36 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.30])
 by smtp.gmail.com with ESMTPSA id
 j21-20020aa783d5000000b006580e98326esm5319097pfn.42.2023.06.27.04.55.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Jun 2023 04:55:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
Date: Tue, 27 Jun 2023 17:25:31 +0530
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4205666-B3CC-4BAF-9CE5-BF36BBCD50F4@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
 <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
 <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
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



> On 27-Jun-2023, at 3:23 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 27-Jun-2023, at 2:32 PM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>=20
>> On Mon, 26 Jun 2023 21:42:44 +0530
>> Ani Sinha <anisinha@redhat.com> wrote:
>>=20
>>> PCI Express ports only have one slot, so PCI Express devices can =
only be
>>> plugged into slot 0 on a PCIE port. Enforce it.
>>=20
>> btw, previously you mentioned ARI.
>> So if we turn it on, wouldn't this patch actually become regression?

Looking at =
https://pcisig.com/sites/default/files/specification_documents/ECN-alt-rid=
-interpretation-070604.pdf, section 7.23, seems a root port does not =
support ARI but it can support ARI forwarding capability (section =
7.8.5).
Also with ARI enabled, the device cannot have a non-zero device number. =
Also, shouldn't any code path that uses PCI_SLOT() should probably also =
check for ARI if it wants to be ARI complaint?

Anyways these are just facts I could find but I am not sure if this =
would answer your above question.

>=20
> If ARI breaks this, it will break other areas in QEMU too, ex anywhere =
pci_get_function_0() is used.
> Regardless, I think at least the tests are worth fixing, particularly =
the mess with hd-geo-test.
>=20
>>=20
>>>=20
>>> CC: jusual@redhat.com
>>> CC: imammedo@redhat.com
>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>> ---
>>> hw/pci/pci.c | 6 ++++++
>>> 1 file changed, 6 insertions(+)
>>>=20
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index bf38905b7d..426af133b0 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -64,6 +64,7 @@ bool pci_available =3D true;
>>> static char *pcibus_get_dev_path(DeviceState *dev);
>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>> static void pcibus_reset(BusState *qbus);
>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>=20
>>> static Property pci_props[] =3D {
>>>    DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>> @@ -1189,6 +1190,11 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>                   name);
>>>=20
>>>       return NULL;
>>> +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) =
{
>>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>>> +                   " parent device only allows plugging into slot =
0.",
>>> +                   PCI_SLOT(devfn), name);
>>> +        return NULL;
>>>    }
>>>=20
>>>    pci_dev->devfn =3D devfn;
>>=20
>=20


