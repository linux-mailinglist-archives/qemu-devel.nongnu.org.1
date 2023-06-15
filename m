Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4200D730D86
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 05:29:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9dfa-0000ya-4F; Wed, 14 Jun 2023 23:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9dfX-0000yE-Gd
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 23:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9dfV-0001zw-Ou
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 23:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686799743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvN7gi36/P20viZZG6ChxzDdhWMiO0pGCEQp3qxuna4=;
 b=PH06sL7CzsfL9lbPfSNrOHjYT5QYricSAIhri1q29f5fFyxmHzcjM1xMpMYm3PF/UY6Hvl
 xEOXEJ8RZbQ4zJ5XzRAINLnPNdz4hGUXCHkKH0qi4tC23JvSXSBjlf9O3gHhXQKhFH0oI3
 XFVTo5HPIgpr2P8F4L0Y8nCo6ZhCAKw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-262NyvjBMZGKtwD4bO-NGw-1; Wed, 14 Jun 2023 23:28:59 -0400
X-MC-Unique: 262NyvjBMZGKtwD4bO-NGw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6668ab28b13so420910b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 20:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686799738; x=1689391738;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvN7gi36/P20viZZG6ChxzDdhWMiO0pGCEQp3qxuna4=;
 b=Atab7oD70JoUz9LNNfHMQtp7OCYx1K+T1KXOqyHqNZT07IhbdlAoa0Kz2w9MSqVx1L
 RPWTfreec1Rjs+02ssBmnq27Er08aqe4DBOUDu6QJBvKEXPm34X8qPXAiBhYPiT8MhQC
 RF0Y5RqNSweE01LpiDBD0EZ6TKl/DGDR7jJYqPgskAykOtqlqDKNgLevMswZJWWLyX+L
 jSTkyKDA50tSjObK3khW+yZVT4I9eJAnTz87wpiQDJhe5Xgzi+LM93SklhD/fgQaCpQ6
 jt5lPI92Z5dNLLY1jbH58SQ0SdXhJfvK/BvA4eMzX7HQBYQoPEAH1f3MXvUJHTkwmscI
 S/fg==
X-Gm-Message-State: AC+VfDy7QmELu81sDfyHWohqpf/Ajv9P496G2ulOp1fDF9wtWJcEdoGN
 NlyMUy29iZnKuUce33qUlttbmFnLiHEgVViPUs4bSKa3Z0ruVEijnOZXoolMxNk+1Fri+DsOF//
 IQ5EM8iwOkr14r4g=
X-Received: by 2002:a05:6a00:174f:b0:64d:5f1d:3d77 with SMTP id
 j15-20020a056a00174f00b0064d5f1d3d77mr5066645pfc.34.1686799738297; 
 Wed, 14 Jun 2023 20:28:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46MZyCTDGeW1r4jx+yphWcuRJq+CkcTuQT+TUW9hQGXUTKv8fg0MWmTZbsLVPPzKctc8se4w==
X-Received: by 2002:a05:6a00:174f:b0:64d:5f1d:3d77 with SMTP id
 j15-20020a056a00174f00b0064d5f1d3d77mr5066630pfc.34.1686799738042; 
 Wed, 14 Jun 2023 20:28:58 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.99])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62bd12000000b0064ff855751fsm10960302pff.4.2023.06.14.20.28.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Jun 2023 20:28:57 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] hw/pci: prevent hotplug of devices on pcie-root-ports
 with wrong devfn address
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230614165253-mutt-send-email-mst@kernel.org>
Date: Thu, 15 Jun 2023 08:58:55 +0530
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com,
 imammedo@redhat.com, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3DF818CF-34EE-4C90-A15C-63B74E3DFC0C@redhat.com>
References: <20230614123150.7077-1-anisinha@redhat.com>
 <20230614102137-mutt-send-email-mst@kernel.org>
 <BDD79A0E-C9D4-4E4B-AFFA-41716326B141@redhat.com>
 <20230614165253-mutt-send-email-mst@kernel.org>
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



> On 15-Jun-2023, at 2:23 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Jun 14, 2023 at 10:09:35PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 14-Jun-2023, at 7:52 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Wed, Jun 14, 2023 at 06:01:50PM +0530, Ani Sinha wrote:
>>>> PCIE root ports only allow one device on slot 0/function 0.
>>>=20
>>>=20
>>> Why do you say this? PCI devices can be multifunction.
>>=20
>> Yeah you are right, the language needs correction. For hot plugging, =
I believe only function 0 is relevant. At least that is what it looks =
like from the code.
>=20
> Adding function 0 is what makes it visible to guest.
> But you can't block multifunction devices that would be a regression.

OK fair enough and I can make a small adjustment in the code.

>=20
>=20
>>>=20
>>>> When hotplugging a
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
>>>> +               !pci_is_vf(pci_dev) &&
>>>> +               pcie_has_upstream_port(pci_dev) && devfn) {
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
>>>> --=20
>>>> 2.39.1
>>>=20
>=20


