Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 887AD73FBA0
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:03:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7OL-0005Iu-4Z; Tue, 27 Jun 2023 08:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE7OG-0005Br-M8
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE7OD-00076y-UM
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687867305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41GU3zaaybWTOXQWwAtVQOg4zLdtrjwquimkE96OJ8g=;
 b=LZi5etPqSU5zwCDE4oTn4tCR3ECaq/NqQRnzb/p3Ehq8Yj+ivMSSHA7l7dH/XvnDrHbBLp
 kv34hbYJbhp4/nTnuOLkHov+KlV5UHhRse5rZbA2+A+HJXmI7Ha8uymF87mojvRrTy57Kp
 2U7mOb7Wp/CkX3gLlajjdTVwt/bLukY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-Fh03QzWYPw2szuTqt2QxtQ-1; Tue, 27 Jun 2023 08:01:43 -0400
X-MC-Unique: Fh03QzWYPw2szuTqt2QxtQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-262ecb0c44fso1865183a91.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687867302; x=1690459302;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41GU3zaaybWTOXQWwAtVQOg4zLdtrjwquimkE96OJ8g=;
 b=L0r4MWKgeKxbSXJaKDTqNFp8aa6ynit3e02RXNbFjIUBNLxKjek54CZsxnOEpcnBHh
 DAAKOK8C3MdFYF25PEkqJV5uZtLYbzkdItfODnZBfTjMyHZjHk3L3EmM+J2bvFo5sO7d
 p1HcLcBsPIdSvKqiQI+7FF3QSd1eLojCt0kZSfWoX9nLAKpD4gptGRu1nJc3g/VdbrY8
 RcxlJN5eaD6alE1v/pBzlyqIiiCqpgNPwRnyKXwYbe/Bj7+m/1peXu23JJ1K8UJIhOCO
 M39vDd2imMhiVBb6qdDrHxguHnRDnqv95iUGX7eJZAI0EjxAZ39Nk0GyKHIKKfHVjnPs
 IjvA==
X-Gm-Message-State: AC+VfDzjruY9vZRaHJvV2wLc7p11c3Kwdycq5mp0MwopeCbJNIG8R+6I
 ZdZSUIw5ZE8+v/sy9i08BGrUz4z6hp9bBfJ99ugoEb41/UHOt0hdIZkXtdRcCyvo/eljGPH6FxW
 mVBCSPVcJosaKTm4=
X-Received: by 2002:a17:90b:3881:b0:25e:f133:41cb with SMTP id
 mu1-20020a17090b388100b0025ef13341cbmr26893476pjb.21.1687867301972; 
 Tue, 27 Jun 2023 05:01:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZzT37x+KZ14jXTx98sRjmXwLCMpSDWk2uhP4vs32WxRXDIouEt2HtLyrvQRsk6xbD5uHp1A==
X-Received: by 2002:a17:90b:3881:b0:25e:f133:41cb with SMTP id
 mu1-20020a17090b388100b0025ef13341cbmr26893461pjb.21.1687867301688; 
 Tue, 27 Jun 2023 05:01:41 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.30])
 by smtp.gmail.com with ESMTPSA id
 s18-20020a17090a881200b0024e05b7ba8bsm6059988pjn.25.2023.06.27.05.01.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Jun 2023 05:01:41 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230627075433-mutt-send-email-mst@kernel.org>
Date: Tue, 27 Jun 2023 17:31:37 +0530
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E87C743-A608-4AB1-927D-ABF93F13078A@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
 <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
 <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
 <20230627075433-mutt-send-email-mst@kernel.org>
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



> On 27-Jun-2023, at 5:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Jun 27, 2023 at 03:23:04PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 27-Jun-2023, at 2:32 PM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>>=20
>>> On Mon, 26 Jun 2023 21:42:44 +0530
>>> Ani Sinha <anisinha@redhat.com> wrote:
>>>=20
>>>> PCI Express ports only have one slot, so PCI Express devices can =
only be
>>>> plugged into slot 0 on a PCIE port. Enforce it.
>>>=20
>>> btw, previously you mentioned ARI.
>>> So if we turn it on, wouldn't this patch actually become regression?
>>=20
>> If ARI breaks this, it will break other areas in QEMU too, ex =
anywhere pci_get_function_0() is used.
>=20
> We will just fix pci_get_function_0.

Any code with PCI_SLOT() I believe also would need fixing?

>=20
>> Regardless, I think at least the tests are worth fixing, particularly =
the mess with hd-geo-test.
>=20
> ok
>=20
>>>=20
>>>>=20
>>>> CC: jusual@redhat.com
>>>> CC: imammedo@redhat.com
>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>>> ---
>>>> hw/pci/pci.c | 6 ++++++
>>>> 1 file changed, 6 insertions(+)
>>>>=20
>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>> index bf38905b7d..426af133b0 100644
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
>>>> @@ -1189,6 +1190,11 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>>                   name);
>>>>=20
>>>>       return NULL;
>>>> +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) =
{
>>>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>>>> +                   " parent device only allows plugging into slot =
0.",
>>>> +                   PCI_SLOT(devfn), name);
>>>> +        return NULL;
>>>>    }
>>>>=20
>>>>    pci_dev->devfn =3D devfn;
>>>=20
>=20


