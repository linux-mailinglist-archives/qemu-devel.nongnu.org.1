Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1820473F92D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:54:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5Ns-0003r1-9z; Tue, 27 Jun 2023 05:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE5Np-0003ql-T4
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE5No-00033Q-8f
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687859591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vgo4uEOauubbcl8HAFXAj1r7oIOvBIERe0XGKpDsEV8=;
 b=fzMggaK03ra9nfSxyQzCGpN8OUUXy6SXCYSZk0iPASOWJwQxorCZaDq/YABOfcRatWYH93
 xoMazRD3Rw53XgzwC61Dsflp8/GnfPe/2hz4xB48nJM+TicO9ytmro+4FE/Nr7fpbD6aky
 K2KzRO5W0v11PZWP1CRXjgQMnWL3LUI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-c4ldXW_9OpekpK9o2a1_eg-1; Tue, 27 Jun 2023 05:53:09 -0400
X-MC-Unique: c4ldXW_9OpekpK9o2a1_eg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7656c94fc4eso346212485a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687859589; x=1690451589;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgo4uEOauubbcl8HAFXAj1r7oIOvBIERe0XGKpDsEV8=;
 b=YoYUppPaz0pn/edVsdQwp7Tcx61q/A8HiO+D3wHJy3siVfX+6bZ/RjupxmVNxFwJV3
 0Jecvq8hZZBLeGsrzF4gFg4MPUhDisMPTpua3LVziULygtwrlthsRN5QoyjoyQxi75YO
 LCyB/ei/Llw3VvpwHHxbmuPTOihy5OnV6pJDxHq9cosYu2lgJf9Fl5yQ4gaMVwALimd+
 BuhhrHqYJ9RQnn0rCIJv4mf8Q34OhNs5j0ko1HsM60CYaEC0E8KCeQIRRbGoa4uaAdQK
 UCytTVZ6vPfRKXaaJ5IkwfE79Wjf9je/RtXgO6lnqLUDbIamUAGyIqMdnAKwfe5b10RB
 ceWw==
X-Gm-Message-State: AC+VfDx3Oe8tTEthYR2iPotnrPGLJANjjyOBAgFKKL99Oec02uNKqA1A
 K0IRzNdROuLApuEWe5Yiar+0tamx231zaJ7PMpvNVTnz8RoguGh68e3+jFaK6hYPPIIJtKlkkLS
 CEydCWulNQP6wwWk=
X-Received: by 2002:a05:620a:81d:b0:763:a638:f064 with SMTP id
 s29-20020a05620a081d00b00763a638f064mr22608639qks.40.1687859589314; 
 Tue, 27 Jun 2023 02:53:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45KqEwbsByh5hM9evXUW9WvCKhuhjwTMpqHyZF++8/Jo5VTfpnPYP/7q/6wuKW5Na7rrJmBA==
X-Received: by 2002:a05:620a:81d:b0:763:a638:f064 with SMTP id
 s29-20020a05620a081d00b00763a638f064mr22608630qks.40.1687859589020; 
 Tue, 27 Jun 2023 02:53:09 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.30])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a170902968200b001b7cbc5871csm848787plp.53.2023.06.27.02.53.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Jun 2023 02:53:08 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
Date: Tue, 27 Jun 2023 15:23:04 +0530
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
 <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
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



> On 27-Jun-2023, at 2:32 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Mon, 26 Jun 2023 21:42:44 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>=20
>> PCI Express ports only have one slot, so PCI Express devices can only =
be
>> plugged into slot 0 on a PCIE port. Enforce it.
>=20
> btw, previously you mentioned ARI.
> So if we turn it on, wouldn't this patch actually become regression?

If ARI breaks this, it will break other areas in QEMU too, ex anywhere =
pci_get_function_0() is used.
Regardless, I think at least the tests are worth fixing, particularly =
the mess with hd-geo-test.

>=20
>>=20
>> CC: jusual@redhat.com
>> CC: imammedo@redhat.com
>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>> ---
>> hw/pci/pci.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>=20
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index bf38905b7d..426af133b0 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -64,6 +64,7 @@ bool pci_available =3D true;
>> static char *pcibus_get_dev_path(DeviceState *dev);
>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>> static void pcibus_reset(BusState *qbus);
>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>=20
>> static Property pci_props[] =3D {
>>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>> @@ -1189,6 +1190,11 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>                    name);
>>=20
>>        return NULL;
>> +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>> +                   " parent device only allows plugging into slot =
0.",
>> +                   PCI_SLOT(devfn), name);
>> +        return NULL;
>>     }
>>=20
>>     pci_dev->devfn =3D devfn;
>=20


