Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D6D747350
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:50:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgQ1-0003dd-5d; Tue, 04 Jul 2023 09:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGgPz-0003d0-Ix
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGgPx-0006nS-HU
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688478608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrxHc79hNIzhjYJmI1XVeHo3MJUejJHHxMs0NgYWi+M=;
 b=VOurK57gZkFOjwa7AgI+Rf4KcsBDO5YKYoUEKEAfpWvY1RiiWt+awibvmFAD/VZczawi9J
 EFqrZxRv8hnDbNOfsesSod7xO5ekYA78w8VBX8SWErEw0A/4fzGv3dwIpqfjYcESoI2tkQ
 6q+xJEXw8VEiJZcZd2Tm3seOtMG8rL8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-Xy53MQHgPBCtJDY-Ba4qQg-1; Tue, 04 Jul 2023 09:50:06 -0400
X-MC-Unique: Xy53MQHgPBCtJDY-Ba4qQg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-66870a96b89so5690549b3a.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688478606; x=1691070606;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lrxHc79hNIzhjYJmI1XVeHo3MJUejJHHxMs0NgYWi+M=;
 b=BMMErFkkCLL4RgvK+1ueVSJ7wVm7AmeFU25KQbaVCPpuT58DZZX0UGaAOm+XU7fztd
 nPhJF4iwVz2p1kLqDeBgCnYNkliNv+youmyRWgKgxiYhDRNWRZAYCaM2/3LCOw3fQmTh
 OpFakoOi6kRFF0q8bfXW+qpwgwoOxbtSeqmimGVPsuZ6pE1WNI9W8OQJMn3b6tVqzekT
 NSUZfxKVMkbaElLhRWdh6js+1c6zaQsVvKSSJG0yC2W00hrBMGAFPJzgTdSLpEi3l5Fo
 14Y/03O1W+BYZpl8h/bx1NuYPOAs6z8L2rharGcN2ldZHBRZOLvNrUpwph/KXTrOyvuY
 nUIw==
X-Gm-Message-State: ABy/qLYoBdBEWcit/NmmKNQ2Rvd4/e0H1bk90+LwsTx5dSaQ5A42gXB1
 KQXCDDzPggxiEKscDZO1fFefPG7SBAJHuRnKr+iU56bM5ISB+rTAG7EN5F+5uWIwn7NKivUqj4l
 k5UBuVnapS7QP4XM=
X-Received: by 2002:a05:6a00:1352:b0:682:4b93:a4d3 with SMTP id
 k18-20020a056a00135200b006824b93a4d3mr13184699pfu.1.1688478605828; 
 Tue, 04 Jul 2023 06:50:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGa5Gn3J2o8CMpo6bf/A7mYqWIxGZ5s6a3CjbmOTBKCRWZUMsq3dlqQuXcl/tTDu+2/7wMvtA==
X-Received: by 2002:a05:6a00:1352:b0:682:4b93:a4d3 with SMTP id
 k18-20020a056a00135200b006824b93a4d3mr13184678pfu.1.1688478605489; 
 Tue, 04 Jul 2023 06:50:05 -0700 (PDT)
Received: from smtpclient.apple ([115.96.131.170])
 by smtp.gmail.com with ESMTPSA id
 ey19-20020a056a0038d300b006827c26f148sm5017224pfb.195.2023.07.04.06.50.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jul 2023 06:50:04 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230704144825.181a1629@imammedo.users.ipa.redhat.com>
Date: Tue, 4 Jul 2023 19:20:00 +0530
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC8A962B-80F5-499F-9EA8-CC53DA160F1D@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
 <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
 <2C9BF0F4-6CB0-4805-818D-51CABC1EAFDE@redhat.com>
 <bf793e6b-62a0-0772-0d64-ddb5894ebf53@daynix.com>
 <20230704144825.181a1629@imammedo.users.ipa.redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 04-Jul-2023, at 6:18 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Tue, 4 Jul 2023 21:02:09 +0900
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>=20
>> On 2023/07/04 20:59, Ani Sinha wrote:
>>>=20
>>>=20
>>>> On 04-Jul-2023, at 5:24 PM, Akihiko Odaki =
<akihiko.odaki@daynix.com> wrote:
>>>>=20
>>>> On 2023/07/04 20:25, Ani Sinha wrote: =20
>>>>> PCI Express ports only have one slot, so PCI Express devices can =
only be
>>>>> plugged into slot 0 on a PCIE port. Add a warning to let users =
know when the
>>>>> invalid configuration is used. We may enforce this more strongly =
later on once
>>>>> we get more clarity on whether we are introducing a bad regression =
for users
>>>>> currenly using the wrong configuration.
>>>>> The change has been tested to not break or alter behaviors of ARI =
capable
>>>>> devices by instantiating seven vfs on an emulated igb device (the =
maximum
>>>>> number of vfs the linux igb driver supports). The vfs instantiated =
correctly
>>>>> and are seen to have non-zero device/slot numbers in the =
conventional PCI BDF
>>>>> representation.
>>>>> CC: jusual@redhat.com
>>>>> CC: imammedo@redhat.com
>>>>> CC: mst@redhat.com
>>>>> CC: akihiko.odaki@daynix.com
>>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>>>> ---
>>>>>  hw/pci/pci.c | 15 +++++++++++++++
>>>>>  1 file changed, 15 insertions(+)
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index e2eb4c3b4a..47517ba3db 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -65,6 +65,7 @@ bool pci_available =3D true;
>>>>>  static char *pcibus_get_dev_path(DeviceState *dev);
>>>>>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>>  static void pcibus_reset(BusState *qbus);
>>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>>    static Property pci_props[] =3D {
>>>>>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>>> @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState =
*qdev, Error **errp)
>>>>>          }
>>>>>      }
>>>>>  +    /*
>>>>> +     * With SRIOV and ARI, vfs can have non-zero slot in the =
conventional
>>>>> +     * PCI interpretation as all five bits reserved for slot =
addresses are
>>>>> +     * also used for function bits for the various vfs. Ignore =
that case. =20
>>>>=20
>>>> You don't have to mention SR/IOV; it affects all ARI-capable =
devices. A PF can also have non-zero slot number in the conventional =
interpretation so you shouldn't call it vf either. =20
>>>=20
>>> Can you please help write a comment that explains this properly for =
all cases - ARI/non-ARI, PFs and VFs? Once everyone agrees that its =
clear and correct, I will re-spin. =20
>>=20
>> Simply, you can say:
>> With ARI, the slot number field in the conventional PCI =
interpretation=20
>> can have a non-zero value as the field bits are reused to extend the=20=

>> function number bits. Ignore that case.
>=20
> mentioning 'conventional PCI interpretation' in comment and then =
immediately
> checking 'pci_is_express(pci_dev)' is confusing. Since comment belongs
> only to PCIE branch it would be better to talk in only about PCIe =
stuff
> and referring to relevant portions of spec.

Ok so how about this?

   * With ARI, devices can have non-zero slot in the traditional BDF     =
                                                                         =
   =20
     * representation as all five bits reserved for slot addresses are   =
                                                                         =
     =20
     * also used for function bits. Ignore that case.                    =
  =20


> (for example see how it's done in kernel code: only_one_child(...)
>=20
> PS:
> kernel can be forced  to scan for !0 device numbers, but that's rather
> a hack, so we shouldn't really care about that.
>=20
>>=20
>>>=20
>>>>=20
>>>>> +     */
>>>>> +    if (pci_is_express(pci_dev) &&
>>>>> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>>>>> +        pcie_has_upstream_port(pci_dev) &&
>>>>> +        PCI_SLOT(pci_dev->devfn)) {
>>>>> +        warn_report("PCI: slot %d is not valid for %s,"
>>>>> +                    " parent device only allows plugging into =
slot 0.",
>>>>> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
>>>>> +    }
>>>>> +
>>>>>      if (pci_dev->failover_pair_id) {
>>>>>          if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
>>>>>              error_setg(errp, "failover primary device must be on =
" =20


