Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62528747048
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:00:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGegv-0007V9-Lk; Tue, 04 Jul 2023 07:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGegu-0007UX-2o
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGegs-0001iJ-8q
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688471969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q98DKgWvohtE0ifzs/uZh0g8HTziIRAIGEyAWr1Y34A=;
 b=G7rd+NbCYdL2waisOtytvjRxwejOVIslkmXCdRxVJy0tHgqjLsjByKRsSJK4yzpla+UnNo
 LpBAkkaHbCXrrxop5Op5a+a8yPYIG7DCBSqlQuuJvH1nzvX3CNI5U/88JqY/T6HXUBZz0Q
 w60xS/Feo4KR6DSgf2RMtGdo6Is3hQI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-LGQl79eOM2CTxWyE1_hNwg-1; Tue, 04 Jul 2023 07:59:28 -0400
X-MC-Unique: LGQl79eOM2CTxWyE1_hNwg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-55b2c66d713so7514909a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 04:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688471967; x=1691063967;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q98DKgWvohtE0ifzs/uZh0g8HTziIRAIGEyAWr1Y34A=;
 b=A/pi6Cj+Eaq62sO/A/kZlbV1T1ujCuaddf4FwHeVk+SvWd6NwAIt3milN7uv/VW82Y
 85/Wk6+YRQU5TDYi2dop8SQX7ZHy9s6HJWamSK6zmmnbJCFnECZ6daOoBlPioeLj5mTq
 FgwPnZJz5vGgvkzB9LlcVmOJPxjcC1VmWfW7TLcMspdC3smp6t6B+W2unyQOoeuCZ2Ms
 lBI20zVa2alJyF2qRc0YmGw9VeeXG1Stt+u57qs/9jBSpuQz1+sw72WlKBV9S8ExZG6K
 nDNLAiyRx1h0mu3OqPZFKk0ncm4tvIh11/goE7MruO+a+RlHemDXue4R4vgInlBYU5aR
 9C+Q==
X-Gm-Message-State: ABy/qLZulwgNeVjZi5Us0RYU6y7X485HrbMcERHQEJ2YZxv0cGGSBz/N
 5csqpSA7T4PI9i619Ad73nBRi96PZpzxpBxWJ5NH8RAmfrm8sAWdv6+fdb2N5XD+s+xRYCDwpth
 /yqlY28Cus787lUw=
X-Received: by 2002:a05:6a20:918e:b0:12e:ae1a:4c1c with SMTP id
 v14-20020a056a20918e00b0012eae1a4c1cmr6286140pzd.36.1688471966865; 
 Tue, 04 Jul 2023 04:59:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNphVOqIrD+pw2eVFvJDtBBun4fnv/vKfnzbPz8VOxTsRfW8y6G+v7+8A6Lzv+bLOIImprZg==
X-Received: by 2002:a05:6a20:918e:b0:12e:ae1a:4c1c with SMTP id
 v14-20020a056a20918e00b0012eae1a4c1cmr6286120pzd.36.1688471966433; 
 Tue, 04 Jul 2023 04:59:26 -0700 (PDT)
Received: from smtpclient.apple ([115.96.131.170])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a1709028eca00b001b85bb5fd77sm8753043plo.119.2023.07.04.04.59.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jul 2023 04:59:26 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
Date: Tue, 4 Jul 2023 17:29:21 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, imammedo@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C9BF0F4-6CB0-4805-818D-51CABC1EAFDE@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
 <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
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



> On 04-Jul-2023, at 5:24 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2023/07/04 20:25, Ani Sinha wrote:
>> PCI Express ports only have one slot, so PCI Express devices can only =
be
>> plugged into slot 0 on a PCIE port. Add a warning to let users know =
when the
>> invalid configuration is used. We may enforce this more strongly =
later on once
>> we get more clarity on whether we are introducing a bad regression =
for users
>> currenly using the wrong configuration.
>> The change has been tested to not break or alter behaviors of ARI =
capable
>> devices by instantiating seven vfs on an emulated igb device (the =
maximum
>> number of vfs the linux igb driver supports). The vfs instantiated =
correctly
>> and are seen to have non-zero device/slot numbers in the conventional =
PCI BDF
>> representation.
>> CC: jusual@redhat.com
>> CC: imammedo@redhat.com
>> CC: mst@redhat.com
>> CC: akihiko.odaki@daynix.com
>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>> ---
>>  hw/pci/pci.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index e2eb4c3b4a..47517ba3db 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -65,6 +65,7 @@ bool pci_available =3D true;
>>  static char *pcibus_get_dev_path(DeviceState *dev);
>>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>  static void pcibus_reset(BusState *qbus);
>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>    static Property pci_props[] =3D {
>>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>> @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState =
*qdev, Error **errp)
>>          }
>>      }
>>  +    /*
>> +     * With SRIOV and ARI, vfs can have non-zero slot in the =
conventional
>> +     * PCI interpretation as all five bits reserved for slot =
addresses are
>> +     * also used for function bits for the various vfs. Ignore that =
case.
>=20
> You don't have to mention SR/IOV; it affects all ARI-capable devices. =
A PF can also have non-zero slot number in the conventional =
interpretation so you shouldn't call it vf either.

Can you please help write a comment that explains this properly for all =
cases - ARI/non-ARI, PFs and VFs? Once everyone agrees that its clear =
and correct, I will re-spin.

>=20
>> +     */
>> +    if (pci_is_express(pci_dev) &&
>> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>> +        pcie_has_upstream_port(pci_dev) &&
>> +        PCI_SLOT(pci_dev->devfn)) {
>> +        warn_report("PCI: slot %d is not valid for %s,"
>> +                    " parent device only allows plugging into slot =
0.",
>> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
>> +    }
>> +
>>      if (pci_dev->failover_pair_id) {
>>          if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
>>              error_setg(errp, "failover primary device must be on "
>=20


