Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD6774282B
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 16:20:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEsU4-0001KS-8a; Thu, 29 Jun 2023 10:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEsU1-0001KE-UA
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 10:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEsTz-00080W-Gi
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 10:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688048326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcVgr/4HzBm28bEsp+s2LLcGHSzjomJG9FM/JOIi9uA=;
 b=YSVV4WB7kfqRnyepJdngAaC1SoxH4M/eoLSzbyO1PqA1tpv8QpxeJV9xpyHs5fUVD+zPDO
 rFt3C0aMRmCrix1kbhx/cmWdxgpAUG/5A/rdmeECL9mBTL43+p34g/GyX9I8qsJ0dulF0n
 HjjT+isnPEo/88DG2vsnnruMKkNYTcc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-gKFF9pyeMaqAeH9p4wXzdQ-1; Thu, 29 Jun 2023 10:18:42 -0400
X-MC-Unique: gKFF9pyeMaqAeH9p4wXzdQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b80517fd4aso6458045ad.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 07:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688048321; x=1690640321;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcVgr/4HzBm28bEsp+s2LLcGHSzjomJG9FM/JOIi9uA=;
 b=iD90G5OaGAzuBLOfaje9jRX3GD2iCId9XW3ySeGM/k8f+PqAI4UARbYFU92yizwXRl
 7LcszbfceWBb8zxYauNryyH6qAkbFOzPBcNGDVDbklSLfzTvLelPlCZNBn5r368qyBL1
 0JPV5BFeVVean+ncAhQtyoDv6+IQntrzYmATUfQJHz9EKcpW6dcWotB/MCJelAaBUZAR
 Iq0kTsJ74eMtZ1sIFR5IN0OdmjZsmp71EXzv5QxQry3mg9AVJwhzfSHiSLjM6XDQwRmh
 eMEULqgMNvESSP7vrSJH80h8r/N00zy5OsQ2CAuhxT2onDZ+822jKmay3YAvNP5+ZL2n
 by6w==
X-Gm-Message-State: AC+VfDzNzEUsDeOSHAkFGfNJWcDT6GJW8mg0ygjOG2CMmrtFOwSkjas4
 Xl2ZE5jh7htdEB1UrbF9OFEuuxYlTn1ax6r9VQ2G/EO8NG9EI9OP61904Nio0uQh7awqw673zSe
 qPOdsLJusqQekWLc=
X-Received: by 2002:a17:902:b606:b0:1b0:663e:4b10 with SMTP id
 b6-20020a170902b60600b001b0663e4b10mr15975404pls.64.1688048321671; 
 Thu, 29 Jun 2023 07:18:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7yUeIioXETpJyMTs9uIT3ftvBzwOsKFexHI3HdKuUQLTVS6oHe89o/+3TgpAareiKJAUD4rg==
X-Received: by 2002:a17:902:b606:b0:1b0:663e:4b10 with SMTP id
 b6-20020a170902b60600b001b0663e4b10mr15975378pls.64.1688048321272; 
 Thu, 29 Jun 2023 07:18:41 -0700 (PDT)
Received: from smtpclient.apple ([203.163.234.183])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a170902724800b001b3d44788f4sm9173932pll.9.2023.06.29.07.18.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Jun 2023 07:18:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
Date: Thu, 29 Jun 2023 19:48:36 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
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



> On 29-Jun-2023, at 2:19 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2023/06/29 17:05, Ani Sinha wrote:
>> On Thu, 29 Jun, 2023, 12:17 pm Akihiko Odaki, =
<akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>> wrote:
>>    On 2023/06/29 13:07, Ani Sinha wrote:
>>     > PCI Express ports only have one slot, so PCI Express devices =
can
>>    only be
>>     > plugged into slot 0 on a PCIE port. Enforce it.
>>     >
>>     > The change has been tested to not break ARI by instantiating
>>    seven vfs on an
>>     > emulated igb device (the maximum number of vfs the linux igb
>>    driver supports).
>>     > The vfs are seen to have non-zero device/slot numbers in the
>>    conventional
>>     > PCI BDF representation.
>>     >
>>     > CC: jusual@redhat.com <mailto:jusual@redhat.com>
>>     > CC: imammedo@redhat.com <mailto:imammedo@redhat.com>
>>     > CC: akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>>     >
>>     > Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>    <https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929>
>>     > Signed-off-by: Ani Sinha <anisinha@redhat.com
>>    <mailto:anisinha@redhat.com>>
>>     > Reviewed-by: Julia Suvorova <jusual@redhat.com
>>    <mailto:jusual@redhat.com>>
>>     > ---
>>     >   hw/pci/pci.c | 15 +++++++++++++++
>>     >   1 file changed, 15 insertions(+)
>>     >
>>     > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>     > index e2eb4c3b4a..0320ac2bb3 100644
>>     > --- a/hw/pci/pci.c
>>     > +++ b/hw/pci/pci.c
>>     > @@ -65,6 +65,7 @@ bool pci_available =3D true;
>>     >   static char *pcibus_get_dev_path(DeviceState *dev);
>>     >   static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>     >   static void pcibus_reset(BusState *qbus);
>>     > +static bool pcie_has_upstream_port(PCIDevice *dev);
>>     >
>>     >   static Property pci_props[] =3D {
>>     >       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>     > @@ -1190,6 +1191,20 @@ static PCIDevice
>>    *do_pci_register_device(PCIDevice *pci_dev,
>>     >                      name);
>>     >
>>     >          return NULL;
>>     > +    } /*
>>     > +       * With SRIOV and ARI, vfs can have non-zero slot in the
>>    conventional
>>     > +       * PCI interpretation as all five bits reserved for slot
>>    addresses are
>>     > +       * also used for function bits for the various vfs. =
Ignore
>>    that case.
>>     > +       * It is too early here to check for ARI capabilities in
>>    the PCI config
>>     > +       * space. Hence, we check for a vf device instead.
>>     > +       */
>>    Why don't just perform this check after the capabilities are set?
>> We don't want to allocate resources for wrong device parameters. We =
want to error out early. Other checks also are performed at the same =
place .
>=20
> It is indeed better to raise an error as early as possible so that we =
can avoid allocation and other operations that will be reverted and may =
go wrong due to the invalid condition. That should be the reason why =
other checks for the address are performed here.
>=20
> However, in this particular case, we cannot confidently perform the =
check here because it is unknown if the ARI capability will be =
advertised until the device realization code runs. This can justify =
delaying the check after the device realization, unlike the other =
checks.

Ok so are you proposing that the check we have right before (the check =
for unoccupied function 0) be also moved? It also uses the same vf =
approximation for seemingly to support ARI.
Also where do you propose we move the check?

>=20
>> Show quoted text
>>    Regards,
>>    Akihiko Odaki
>>     > +    else if (!pci_is_vf(pci_dev) &&
>>     > +             pcie_has_upstream_port(pci_dev) &&
>>     > +             PCI_SLOT(devfn)) {
>>     > +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>>     > +                   " parent device only allows plugging into
>>    slot 0.",
>>     > +                   PCI_SLOT(devfn), name);
>>     > +        return NULL;
>>     >       }
>>     >
>>     >       pci_dev->devfn =3D devfn;


