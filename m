Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7314F73052E
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 18:41:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9TXJ-0008Oa-KY; Wed, 14 Jun 2023 12:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9TXA-0008OE-5v
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 12:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9TX7-0007C6-At
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 12:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686760783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9g7QoyTYEk2kSrsmOo3n/dMZi96MQRLl4Dm5KKMM0is=;
 b=ituudIGqESAOAONPMKZ91TsEzp7S3sOLlwsrdn1XL6PKFx/qvFZbE0koWptX8jrOOfCUXU
 hGoZrAF4T+kDyM4IEOJ/fyk37lphBq0pMHwGsVZMG0e4FKzWTx5cVfMvFj8fgx/UZ1UqcE
 sZ+LxXi+TpNvi1eoQCkWq/JdIMqwIO4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-PqIrqd5WM52vqGiRfZZUbw-1; Wed, 14 Jun 2023 12:39:41 -0400
X-MC-Unique: PqIrqd5WM52vqGiRfZZUbw-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-39acaa239b2so5189905b6e.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 09:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686760780; x=1689352780;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9g7QoyTYEk2kSrsmOo3n/dMZi96MQRLl4Dm5KKMM0is=;
 b=VbPYX97IXE5yvOhLcZjxVq6ARzh6GUM6jxFuV9A6ok6p1c9SITzGwIxi5nPBtSh2G0
 Iyhvap49FuO/KMXAJP7vKKrXzrR7vLlOqDayfMrMhAUJ6j9ul12QLNExRfox+xq/vnkQ
 u95GYFwJ/f7TchRVkjcPLaxKeAfn3+vQcTtPLmD1ZJq4dMZi6P6fwTl0w//6IwVtpiwx
 WxnpxNw5BzEvsR/2qcEfJETJELQfm8tOrHQoSIkU2n7nXNv2YbzM7OJu2SlG5YMvWBuX
 sIOPk/ekWx4leWV8Q0Iy5fPqD4iBWNMAlKk48/i8KCMdp0kOCgv1CWrFNTAo+F9xUOXZ
 U3pw==
X-Gm-Message-State: AC+VfDx/kHatpPhUrdrkqO0jEo3qDtvuguIiGCDgMOdSL51nijum5Tgc
 b5FRV7VsIHOllD6SDXY5MquIkN485sAOCkda0S67zAAcRpwjXfbHVQida9PEVZRfakIxozZ9r8H
 YB/qJNX8v50m+hJE=
X-Received: by 2002:a05:6808:8c7:b0:394:39dc:a4b0 with SMTP id
 k7-20020a05680808c700b0039439dca4b0mr10606196oij.52.1686760780772; 
 Wed, 14 Jun 2023 09:39:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4+rkUQbaGBPGAZhIa1HVi3eNekmF9IwqGqgenXxtIL5LlL3HxL1eyMHU7BV5ndv6MMRR3Z5Q==
X-Received: by 2002:a05:6808:8c7:b0:394:39dc:a4b0 with SMTP id
 k7-20020a05680808c700b0039439dca4b0mr10606178oij.52.1686760780450; 
 Wed, 14 Jun 2023 09:39:40 -0700 (PDT)
Received: from smtpclient.apple ([116.72.128.64])
 by smtp.gmail.com with ESMTPSA id
 pq8-20020a17090b3d8800b00258bb7e8b47sm13029931pjb.50.2023.06.14.09.39.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Jun 2023 09:39:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] hw/pci: prevent hotplug of devices on pcie-root-ports
 with wrong devfn address
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230614102137-mutt-send-email-mst@kernel.org>
Date: Wed, 14 Jun 2023 22:09:35 +0530
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com,
 imammedo@redhat.com, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDD79A0E-C9D4-4E4B-AFFA-41716326B141@redhat.com>
References: <20230614123150.7077-1-anisinha@redhat.com>
 <20230614102137-mutt-send-email-mst@kernel.org>
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



> On 14-Jun-2023, at 7:52 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Jun 14, 2023 at 06:01:50PM +0530, Ani Sinha wrote:
>> PCIE root ports only allow one device on slot 0/function 0.
>=20
>=20
> Why do you say this? PCI devices can be multifunction.

Yeah you are right, the language needs correction. For hot plugging, I =
believe only function 0 is relevant. At least that is what it looks like =
from the code.

>=20
>> When hotplugging a
>> device on a pcie root port, make sure that the device address passed =
is
>> always 0x00 that represents slot 0 and function 0. Any other slot =
value and
>> function value would be illegal on a root port.
>>=20
>> CC: jusual@redhat.com
>> CC: imammedo@redhat.com
>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> hw/pci/pci.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>=20
>> Note:
>> I tested this with both native and acpi hotplug enabled on pcie. The
>> check seems to work on both.
>>=20
>> (qemu)  netdev_add socket,id=3Dhostnet1,listen=3D:1234
>> (qemu) device_add =
e1000e,netdev=3Dhostnet1,mac=3D00:11:22:33:44:03,id=3Dnet1,bus=3Dpci.6,add=
r=3D0x2.0x5
>> Error: PCI: slot 2 function 5 is not valid for e1000e
>> (qemu) device_add =
e1000e,netdev=3Dhostnet1,mac=3D00:11:22:33:44:03,id=3Dnet1,bus=3Dpci.6,add=
r=3D0x0.0
>> (qemu) info network
>> net1: index=3D0,type=3Dnic,model=3De1000e,macaddr=3D00:11:22:33:44:03
>> \ hostnet1: index=3D0,type=3Dsocket,
>> (qemu) device_del net1
>> (qemu) info network
>> hostnet1: index=3D0,type=3Dsocket,
>>=20
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index bf38905b7d..bc39322dfd 100644
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
>> @@ -1189,6 +1190,14 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>                    name);
>>=20
>>        return NULL;
>> +    } else if (dev->hotplugged &&
>> +               !pci_is_vf(pci_dev) &&
>> +               pcie_has_upstream_port(pci_dev) && devfn) {
>> +        /* For an upstream PCIE port, we only support one device at =
slot 0 */
>> +        error_setg(errp, "PCI: slot %d function %d is not valid for =
%s",
>> +                   PCI_SLOT(devfn), PCI_FUNC(devfn), name);
>> +        return NULL;
>> +
>>     }
>>=20
>>     pci_dev->devfn =3D devfn;
>> --=20
>> 2.39.1
>=20


