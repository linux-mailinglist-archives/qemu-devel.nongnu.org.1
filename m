Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F2743604
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8lI-0004cm-KC; Fri, 30 Jun 2023 03:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qF8lG-0004cU-Gb
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qF8lE-0006Do-Ks
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688110903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DA9nISXhj/Fy+ktgqjFgh+r3oZV3+K39R+0e9eSQFSM=;
 b=OS2uRTHn9NsJufhVlKHQmGl3xnARd0A/sR3GGxquNeoq6DKuN9fWV74xg0lxDBAbfn2JpI
 gixJ0nsZtsVf3YWY0uc6YwFr3XEn+5SeFiAQyg615OTva8h/hYfBdcBNqUCW79Niqiyplt
 JGSS03kU4UVUwavX+wtV/rnCXwRb8zE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-pdSJERTgNemdq-OKtsWjPw-1; Fri, 30 Jun 2023 03:41:42 -0400
X-MC-Unique: pdSJERTgNemdq-OKtsWjPw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-563afee3369so1436521eaf.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110901; x=1690702901;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DA9nISXhj/Fy+ktgqjFgh+r3oZV3+K39R+0e9eSQFSM=;
 b=Sn5qKUm42IARx3iTmHQ9sa4vU6UDQA0xzLBesE+XESorsh2/5SCifp/7HU0U3u7gy5
 5x1dWv8J6vW9Mq4jJmheBQdXBj6uyNnQndYrpEUKu16YPzQ3mOHQ6zofKAZLa1rAmxEc
 yK1jycO6QA5lVksRvV1OVT0RdJ7uLBP0Jrvh4yz4Jc/Re2KbuYmfcWsRZZsI4Ypu8dA7
 J72t3254LXXdPweUYC8FhnCKRhbVcvKwz4OKdGUdxPH5+WTgFBYYt/q0NJS2zYKry8+0
 nJgwhd+aQaHPiAikVE43VrJ6kgLJ6GCLuHrLOOJwIBoGp4onOip9Hubw0uhgngbNPgeC
 4uUg==
X-Gm-Message-State: ABy/qLZyXhN6RGq2VPKYaAfKruZn+uxiKkwxG0OX7aUgv24HAqbqmc18
 Y1B8Py8VNPPzaAfKNi7F9Kl5NmHoA0OUnYZIU5oIhUDY6JaNTPe/1yR6izysPi43/jL+YZfWW0b
 kpQtRSwGoe+nioqc=
X-Received: by 2002:a05:6358:f1a:b0:134:d806:69df with SMTP id
 b26-20020a0563580f1a00b00134d80669dfmr739256rwj.18.1688110901527; 
 Fri, 30 Jun 2023 00:41:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFklEosimwIhtXkb8WITtxA1DN1JjCnSl4j5akvFv6nZrhVMmYCongj16SIRlXLADYyNGuuvw==
X-Received: by 2002:a05:6358:f1a:b0:134:d806:69df with SMTP id
 b26-20020a0563580f1a00b00134d80669dfmr739251rwj.18.1688110901175; 
 Fri, 30 Jun 2023 00:41:41 -0700 (PDT)
Received: from smtpclient.apple ([115.96.128.249])
 by smtp.gmail.com with ESMTPSA id
 n189-20020a6327c6000000b0055387ffef10sm10087599pgn.24.2023.06.30.00.41.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Jun 2023 00:41:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
Date: Fri, 30 Jun 2023 13:11:33 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
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



> On 30-Jun-2023, at 8:13 AM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2023/06/29 23:18, Ani Sinha wrote:
>>> On 29-Jun-2023, at 2:19 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>>>=20
>>> On 2023/06/29 17:05, Ani Sinha wrote:
>>>> On Thu, 29 Jun, 2023, 12:17 pm Akihiko Odaki, =
<akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>> wrote:
>>>>    On 2023/06/29 13:07, Ani Sinha wrote:
>>>>     > PCI Express ports only have one slot, so PCI Express devices =
can
>>>>    only be
>>>>     > plugged into slot 0 on a PCIE port. Enforce it.
>>>>     >
>>>>     > The change has been tested to not break ARI by instantiating
>>>>    seven vfs on an
>>>>     > emulated igb device (the maximum number of vfs the linux igb
>>>>    driver supports).
>>>>     > The vfs are seen to have non-zero device/slot numbers in the
>>>>    conventional
>>>>     > PCI BDF representation.
>>>>     >
>>>>     > CC: jusual@redhat.com <mailto:jusual@redhat.com>
>>>>     > CC: imammedo@redhat.com <mailto:imammedo@redhat.com>
>>>>     > CC: akihiko.odaki@daynix.com =
<mailto:akihiko.odaki@daynix.com>
>>>>     >
>>>>     > Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929=

>>>>    <https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929>
>>>>     > Signed-off-by: Ani Sinha <anisinha@redhat.com
>>>>    <mailto:anisinha@redhat.com>>
>>>>     > Reviewed-by: Julia Suvorova <jusual@redhat.com
>>>>    <mailto:jusual@redhat.com>>
>>>>     > ---
>>>>     >   hw/pci/pci.c | 15 +++++++++++++++
>>>>     >   1 file changed, 15 insertions(+)
>>>>     >
>>>>     > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>     > index e2eb4c3b4a..0320ac2bb3 100644
>>>>     > --- a/hw/pci/pci.c
>>>>     > +++ b/hw/pci/pci.c
>>>>     > @@ -65,6 +65,7 @@ bool pci_available =3D true;
>>>>     >   static char *pcibus_get_dev_path(DeviceState *dev);
>>>>     >   static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>     >   static void pcibus_reset(BusState *qbus);
>>>>     > +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>     >
>>>>     >   static Property pci_props[] =3D {
>>>>     >       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>>     > @@ -1190,6 +1191,20 @@ static PCIDevice
>>>>    *do_pci_register_device(PCIDevice *pci_dev,
>>>>     >                      name);
>>>>     >
>>>>     >          return NULL;
>>>>     > +    } /*
>>>>     > +       * With SRIOV and ARI, vfs can have non-zero slot in =
the
>>>>    conventional
>>>>     > +       * PCI interpretation as all five bits reserved for =
slot
>>>>    addresses are
>>>>     > +       * also used for function bits for the various vfs. =
Ignore
>>>>    that case.
>>>>     > +       * It is too early here to check for ARI capabilities =
in
>>>>    the PCI config
>>>>     > +       * space. Hence, we check for a vf device instead.
>>>>     > +       */
>>>>    Why don't just perform this check after the capabilities are =
set?
>>>> We don't want to allocate resources for wrong device parameters. We =
want to error out early. Other checks also are performed at the same =
place .
>>>=20
>>> It is indeed better to raise an error as early as possible so that =
we can avoid allocation and other operations that will be reverted and =
may go wrong due to the invalid condition. That should be the reason why =
other checks for the address are performed here.
>>>=20
>>> However, in this particular case, we cannot confidently perform the =
check here because it is unknown if the ARI capability will be =
advertised until the device realization code runs. This can justify =
delaying the check after the device realization, unlike the other =
checks.
>> Ok so are you proposing that the check we have right before (the =
check for unoccupied function 0) be also moved? It also uses the same vf =
approximation for seemingly to support ARI.
>=20
> No, I don't think the check for function 0 is required to be disabled =
because of the change of addressing caused by ARI, but it is required =
because SR-IOV VF can be added and removed while the PF (function 0) =
remains. I think this check should be performed also when SR-IOV is =
disabled and ARI is enabled.

OK I am a little confused with your explanation here. I understand the =
non-ARI case - to detect the PF we need to have function 0 available. =
Looking at the comment in pci_init_multifunction() it seems in ARI case, =
we can simply have a vf in function 0 (conventional interpretation) as =
well. Hence we need to ignore vfs both in ARI and non-ARI cases. This is =
what I understood.

>=20
> Thus the check for unoccupied function 0 needs to use pci_is_vf() =
instead of checking ARI capability, and that can happen in =
do_pci_register_device().
>=20
>> Also where do you propose we move the check?
>=20
> In pci_qdev_realize(), somewhere after pc->realize() and before option =
ROM loading.

Hmm, I tried this. The issue here is something like this would be now =
allowed since the PF has ARI capability:

-device pcie-root-port,id=3Dp -device igb,bus=3Dp,addr=3D0x2.0x0

The above should not be allowed and when used, we do not see the igb =
ethernet device from the guest OS.

> See the check for failover pair as an example. I guess it's also =
placed in this region because it needs capability information.
>=20
>>>=20
>>>> Show quoted text
>>>>    Regards,
>>>>    Akihiko Odaki
>>>>     > +    else if (!pci_is_vf(pci_dev) &&
>>>>     > +             pcie_has_upstream_port(pci_dev) &&
>>>>     > +             PCI_SLOT(devfn)) {
>>>>     > +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>>>>     > +                   " parent device only allows plugging into
>>>>    slot 0.",
>>>>     > +                   PCI_SLOT(devfn), name);
>>>>     > +        return NULL;
>>>>     >       }
>>>>     >
>>>>     >       pci_dev->devfn =3D devfn;


