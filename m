Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF97305A1
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 19:02:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9TsX-0007M0-S4; Wed, 14 Jun 2023 13:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9TsW-0007Iv-2s
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 13:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q9TsU-00049y-3y
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 13:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686762108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OsPvgojoVY1a16QT5fevg37VL70N6Xdve84b75zxys=;
 b=cTrjsRgHfRlmJzACVMphv3twAORxWeA0Ssjm9Ym73hKf1kMUEj3i6qkHwKJ/nO0FlqPc95
 VfX6lcXNUNtVC3pe9EL2VQMcWrfmHPiqsJr8YVIfMLIQwqE840H/91PC5ra61pSxuPMrI0
 FStQKbEAB+V1h1hB0ErUoA4fSPTL2SA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-CJjWYu9PPDShDu_AjSYCHw-1; Wed, 14 Jun 2023 13:01:46 -0400
X-MC-Unique: CJjWYu9PPDShDu_AjSYCHw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-51f7638a56fso4830580a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 10:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686762105; x=1689354105;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OsPvgojoVY1a16QT5fevg37VL70N6Xdve84b75zxys=;
 b=YDIQIgUvQGd7rXH1PkG2JceSysI8t4Pu5B4jkt2d2YEGvBU4GLVbOlJIxfhHih5HZN
 YJi13MbuhELi3rDdgZsXpZLiOKNC0QDi2cLKuaGGmGrAymZ18gohtmouCgJn08QKs/2s
 squsVRBJyArOdQ7bRCNT35uohdpMYY68bqRpjqita5JOqkKWI9NgXUWwTuX+64PVuIWx
 SnE0KfBoggwnZvd7Kx6zIH33/hR3xRgnT84Y7eFivex6HXFNpJzpnmBebeAfdAWmfB43
 U6Li8ZBcjvvLCFgw4AKtoIqhCNDozvVD1ELqAgJ8k6jtB+48fHn/G9C/LjJeCdnRpigA
 k37A==
X-Gm-Message-State: AC+VfDx7lV4xQiO2y4hgOXOPpDU6fJukLoES4oJACVeG0VhyzjBNEf2d
 2il1v8oQSEXw7ytedtThj5VJUZyAszEeH8EnAuv78VEbDvGnlgbR/O9bddRwKfLMTpZajFfK9wH
 o6HyxUJcHiTcUCOg=
X-Received: by 2002:a17:902:e5ca:b0:1b0:637e:e25a with SMTP id
 u10-20020a170902e5ca00b001b0637ee25amr16559280plf.67.1686762104820; 
 Wed, 14 Jun 2023 10:01:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72Whs74L89hT+tkYo+ZXXCWnIcuozX7ZeMWMkRMD1r2KSTbrFRpo6EWg87MKNxgrC1CWL2OA==
X-Received: by 2002:a17:902:e5ca:b0:1b0:637e:e25a with SMTP id
 u10-20020a170902e5ca00b001b0637ee25amr16559250plf.67.1686762104397; 
 Wed, 14 Jun 2023 10:01:44 -0700 (PDT)
Received: from smtpclient.apple ([116.72.128.64])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a170902779800b001afbc038492sm12394545pll.299.2023.06.14.10.01.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Jun 2023 10:01:43 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] hw/pci: prevent hotplug of devices on pcie-root-ports
 with wrong devfn address
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230614150157.03952658@imammedo.users.ipa.redhat.com>
Date: Wed, 14 Jun 2023 22:31:40 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6BFF3BE-42D8-4651-99B1-D4BF6C1D17B1@redhat.com>
References: <20230614123150.7077-1-anisinha@redhat.com>
 <20230614150157.03952658@imammedo.users.ipa.redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
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



> On 14-Jun-2023, at 6:31 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Wed, 14 Jun 2023 18:01:50 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>=20
>> PCIE root ports only allow one device on slot 0/function 0. When =
hotplugging a
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
>=20
>> +               !pci_is_vf(pci_dev) &&
>> +               pcie_has_upstream_port(pci_dev)=20
> can you clarify what above 2 lines are here for?
>=20
> you can't hotplug anything into upstream port (only downstream)

This code checks if the hot plugged device is being plugged into a pcie =
root port. For pcie root ports, only slot 0 can be used. Please see =
3f1e1478db2d67098d9 . The conditional check just above this hunk =
therefore checks for unoccupied function 0 in slot 0 if the device is =
plugged into an upstream pcie root port. I think for hot plugs, only =
function 0 is allowed.

As for vf, I am not sure. I believe for vfs the restriction is not =
valid. I just kept the check based on the conditional just prior to it.

> and why _vf() is here also not clear.
>=20
>> && devfn) {
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


