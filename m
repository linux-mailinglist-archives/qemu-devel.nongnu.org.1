Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE790742AC9
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 18:46:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEumB-0000Uf-Of; Thu, 29 Jun 2023 12:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEum8-0000UP-R5
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 12:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEum6-00015C-Tr
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 12:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688057141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uWfb76ySo4VAx8LvJ9wVPoO+SIyRzDOfPVyFfaFRG0=;
 b=deydzF3Iq9M+gJ/R6rlLCbAki0eT8Qw4HHTfr0XNALUay7XN6r0rl33acf88/4X73t7J/K
 qDv9ekLS599eYPHktZ4VbJLP5oEwMKvHJ/l5rFqLzdp2j7Qo/YOt3ksAqAUiFc0EiBQW+z
 dhauZr+1eB7ScCDY+PKgkVx3F55EQtA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-fEb58kQQMdqO1ZWrwoXzKw-1; Thu, 29 Jun 2023 12:45:30 -0400
X-MC-Unique: fEb58kQQMdqO1ZWrwoXzKw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b8303cd306so5207185ad.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 09:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688057129; x=1690649129;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uWfb76ySo4VAx8LvJ9wVPoO+SIyRzDOfPVyFfaFRG0=;
 b=f+crzGDB4XcT8arGdznzY28mm3+uaM77vuTaCcOGqYWShJ4gTvSZQUY0Uafosg+oOs
 bKLSs5CFd5T3ICXG7iyp/gOlZWec1aI9vohiuqiiz5B5vowX9OrBYByDuGBMSP5JERMA
 TmNx/tYmrFhxavhfpGjmZ3GTk3DU4veGFCQqqZvNvS3AH6xLBgF8EZRMD5QSGwLXi91B
 ilXZGpSmz+/lq9sSTe7jrjzILVZzxkoHCmvQI0z8I2zLoa5LgfjRdG+oHXY/MLngHqUi
 jx+JO7Q+ZH3B94vIl8t68NSF3FqvCdgN0WWtfD1z4M/iBjvD8RpQGXPUob9/e7WrVudI
 HJTQ==
X-Gm-Message-State: AC+VfDwbLwhzhiTFWUEh3O8VpDRiVm2rEVSpyaJDpJlJL4Cq1ihziPTW
 GIkjrbs+NJtBRi6tDkV+t9eAyw0YctNjd5p7e9BoXThvw7bWMjE6q+oHvTsqh89QTSdfGF5lDA+
 R8fwMjV8+RI/WNfs=
X-Received: by 2002:a17:902:9a08:b0:1b2:74e:84cb with SMTP id
 v8-20020a1709029a0800b001b2074e84cbmr12365961plp.9.1688057128713; 
 Thu, 29 Jun 2023 09:45:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4sV4TRr5Fhdi1cPJGcdnNKzfYiM1VLPeL38affsuQAGjHBiK4iao1FDqqdQ07BIKW4I8UJ4w==
X-Received: by 2002:a17:902:9a08:b0:1b2:74e:84cb with SMTP id
 v8-20020a1709029a0800b001b2074e84cbmr12365946plp.9.1688057128353; 
 Thu, 29 Jun 2023 09:45:28 -0700 (PDT)
Received: from smtpclient.apple ([203.163.234.183])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a170902cf4600b001b1c4d875f5sm9319306plg.44.2023.06.29.09.45.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Jun 2023 09:45:27 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <A9837DAD-AEF3-4567-8172-EC1BAF2AEA3F@redhat.com>
Date: Thu, 29 Jun 2023 22:15:23 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 akihiko.odaki@daynix.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D19E1234-77A6-42BB-AE00-7F105A5730B0@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <20230629102421-mutt-send-email-mst@kernel.org>
 <A398CFAA-12F6-447D-A03D-F2DAC79AB1B7@redhat.com>
 <20230629113141-mutt-send-email-mst@kernel.org>
 <A9837DAD-AEF3-4567-8172-EC1BAF2AEA3F@redhat.com>
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



> On 29-Jun-2023, at 9:27 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 29-Jun-2023, at 9:02 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>=20
>> On Thu, Jun 29, 2023 at 08:07:57PM +0530, Ani Sinha wrote:
>>>=20
>>>=20
>>>> On 29-Jun-2023, at 7:54 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>=20
>>>> On Thu, Jun 29, 2023 at 09:37:07AM +0530, Ani Sinha wrote:
>>>>> PCI Express ports only have one slot, so PCI Express devices can =
only be
>>>>> plugged into slot 0 on a PCIE port. Enforce it.
>>>>>=20
>>>>> The change has been tested to not break ARI by instantiating seven =
vfs on an
>>>>> emulated igb device (the maximum number of vfs the linux igb =
driver supports).
>>>>=20
>>>> I guess we need to test with some other device then? 7 VFs is same
>>>> slot so hardly a good test.
>>>=20
>>> No its not the same slot. Its using different slots/device numbers. =
I checked that.
>>> The same patch was failing without the vf check.
>>=20
>> Ah, playing with VF stride?

Indeed. You=E2=80=99ll see IGB_VF_STRIDE is 2. pcie_sriov_pf_init() uses =
this to initialise the PCIE config space attributes. register_vfs() uses =
this to increment the devfn values :-)=20


>> Could you show the command line please?
>=20
> Akhido mentioned this in the other thread. Basically For QEMU:
>=20
> -device pcie-root-port,id=3Dp -device igb,bus=3Dp
>=20
> Then from within the guest (in my case RHEL 9.2):
>=20
> $ echo 7 > /sys/bus/pci/devices/0000\:01\:00.0/sriov_numvfs
>=20
> You=E2=80=99ll find that if you use something more than 7 there will =
be ERANGE from the guest kernel because the driver can create maximum 7 =
vfs.
> This above command line will fail if we do not check for !vfs in the =
patch with the following error from QEMU:
>=20
> (qemu) qemu-system-x86_64: PCI: slot 16 is not valid for igbvf, parent =
device only allows plugging into slot 0.
>=20
> and an IO error on the write from the guest kernel.
>=20
> In the current version of the patch with the vf check, you will find =
the vfs created with the addresses:
>=20
> 01:10.{2,4,6,8} and 01.11.{2,4,6} , that is bus 1 for the root port, =
devices 10 and 11, functions 2,4,6,8 etc.
>=20
> There would be no error from QEMU.
>=20
>>=20
>>>>=20
>>>>> The vfs are seen to have non-zero device/slot numbers in the =
conventional
>>>>> PCI BDF representation.
>>>>>=20
>>>>> CC: jusual@redhat.com
>>>>> CC: imammedo@redhat.com
>>>>> CC: akihiko.odaki@daynix.com
>>>>>=20
>>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>>>> ---
>>>>> hw/pci/pci.c | 15 +++++++++++++++
>>>>> 1 file changed, 15 insertions(+)
>>>>>=20
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index e2eb4c3b4a..0320ac2bb3 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -65,6 +65,7 @@ bool pci_available =3D true;
>>>>> static char *pcibus_get_dev_path(DeviceState *dev);
>>>>> static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>> static void pcibus_reset(BusState *qbus);
>>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>>=20
>>>>> static Property pci_props[] =3D {
>>>>>   DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>>> @@ -1190,6 +1191,20 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>>>                  name);
>>>>>=20
>>>>>      return NULL;
>>>>> +    } /*
>>>>> +       * With SRIOV and ARI, vfs can have non-zero slot in the =
conventional
>>>>> +       * PCI interpretation as all five bits reserved for slot =
addresses are
>>>>> +       * also used for function bits for the various vfs. Ignore =
that case.
>>>>> +       * It is too early here to check for ARI capabilities in =
the PCI config
>>>>> +       * space. Hence, we check for a vf device instead.
>>>>> +       */
>>>>> +    else if (!pci_is_vf(pci_dev) &&
>>>>> +             pcie_has_upstream_port(pci_dev) &&
>>>>> +             PCI_SLOT(devfn)) {
>>>>> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>>>>> +                   " parent device only allows plugging into slot =
0.",
>>>>> +                   PCI_SLOT(devfn), name);
>>>>> +        return NULL;
>>>>>   }
>>>>>=20
>>>>>   pci_dev->devfn =3D devfn;
>>>>> --=20
>>>>> 2.39.1


