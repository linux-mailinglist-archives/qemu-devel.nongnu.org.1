Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9194574707A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:08:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGepV-0004YW-Rw; Tue, 04 Jul 2023 08:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGepS-0004Y1-KM
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGepP-0003sS-SZ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688472498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wShcw2Bkrq4rC0AaD5pAg3RJg0vj4y2pGDUP9vXHBu0=;
 b=GTzUi1TpJa3GfyFYAmEpEFe/dJy5jgPhOBeziV6iQtJ+/pm5fw62PQiCRopjh1z9nfa/Fy
 DtbO38+sPZ5qF9UO5PH3dfnFGTEyOgR4oNm2R4VEfii5Z8OjOhhZdywq+r0WdKJPCPE4dY
 K3R+/zk4eD/Hj8jWE+m3AeBHPzFEAlI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-VH7rhi71PEKdeOCI1SGpJA-1; Tue, 04 Jul 2023 08:08:17 -0400
X-MC-Unique: VH7rhi71PEKdeOCI1SGpJA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-262d505f44cso5545453a91.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688472496; x=1691064496;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wShcw2Bkrq4rC0AaD5pAg3RJg0vj4y2pGDUP9vXHBu0=;
 b=K+kJIyNMd3ZaBaQv1hvGIZdJC6UfmhOTb3WoQCoh8IRLt2+iNZGTnlyagA2Bjwflx8
 LyCo836mZXRfwHZH8JsKGSbvmzgJkwcQlvyaQdGXX4w31XD23dtnatRSrPx+uwKuCjdL
 PC3cB4gAkhjV2knUFukuwh8D0pRHPbD8D7jR2u4BzuDfDvGwoG0SDFl/JOUT6isqpCYu
 Hg7hnlybF9vk7eyMaH/VnU069rPf1LPXjNeiLEYAEb4/W5l4pzTfm501eJ8VG9G9IZfK
 Kr+L3/VwCdhpP0qT4gUWv0E3aDwDuTzIZ2VHeKhvk4r2Helz8KmUi+KyOLANZP5Faflc
 SSyg==
X-Gm-Message-State: ABy/qLZ+NxmO1YpWvQNNMYm78n1mKrcAwcDadZkgYtRl0ioSdltBgvBO
 EfRLym5zF/zz/h3s4NNKci7OSzVf/jFb2dyrP2PZAY4QC8aUE7sBA3Mfzbq1MX7keoLJVq43rg9
 7W3iftNN6+ysnR1U=
X-Received: by 2002:a17:90a:68c9:b0:25b:fbdc:434e with SMTP id
 q9-20020a17090a68c900b0025bfbdc434emr11968137pjj.32.1688472496599; 
 Tue, 04 Jul 2023 05:08:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVgTPqskofViML9obcCgoW6sHEKVDUnHJH+FzdLuiGCci4F5UbSxBb6ak1BigobTbX2JLK3g==
X-Received: by 2002:a17:90a:68c9:b0:25b:fbdc:434e with SMTP id
 q9-20020a17090a68c900b0025bfbdc434emr11968121pjj.32.1688472496287; 
 Tue, 04 Jul 2023 05:08:16 -0700 (PDT)
Received: from smtpclient.apple ([115.96.131.170])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a63c145000000b00519c3475f21sm16396487pgi.46.2023.07.04.05.08.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jul 2023 05:08:15 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <bf793e6b-62a0-0772-0d64-ddb5894ebf53@daynix.com>
Date: Tue, 4 Jul 2023 17:38:11 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, imammedo@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AB4A93A-7543-4991-A934-4C6054F0C2BA@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
 <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
 <2C9BF0F4-6CB0-4805-818D-51CABC1EAFDE@redhat.com>
 <bf793e6b-62a0-0772-0d64-ddb5894ebf53@daynix.com>
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



> On 04-Jul-2023, at 5:32 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2023/07/04 20:59, Ani Sinha wrote:
>>> On 04-Jul-2023, at 5:24 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>>>=20
>>> On 2023/07/04 20:25, Ani Sinha wrote:
>>>> PCI Express ports only have one slot, so PCI Express devices can =
only be
>>>> plugged into slot 0 on a PCIE port. Add a warning to let users know =
when the
>>>> invalid configuration is used. We may enforce this more strongly =
later on once
>>>> we get more clarity on whether we are introducing a bad regression =
for users
>>>> currenly using the wrong configuration.
>>>> The change has been tested to not break or alter behaviors of ARI =
capable
>>>> devices by instantiating seven vfs on an emulated igb device (the =
maximum
>>>> number of vfs the linux igb driver supports). The vfs instantiated =
correctly
>>>> and are seen to have non-zero device/slot numbers in the =
conventional PCI BDF
>>>> representation.
>>>> CC: jusual@redhat.com
>>>> CC: imammedo@redhat.com
>>>> CC: mst@redhat.com
>>>> CC: akihiko.odaki@daynix.com
>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
>>>> ---
>>>>  hw/pci/pci.c | 15 +++++++++++++++
>>>>  1 file changed, 15 insertions(+)
>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>> index e2eb4c3b4a..47517ba3db 100644
>>>> --- a/hw/pci/pci.c
>>>> +++ b/hw/pci/pci.c
>>>> @@ -65,6 +65,7 @@ bool pci_available =3D true;
>>>>  static char *pcibus_get_dev_path(DeviceState *dev);
>>>>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
>>>>  static void pcibus_reset(BusState *qbus);
>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
>>>>    static Property pci_props[] =3D {
>>>>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>>> @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState =
*qdev, Error **errp)
>>>>          }
>>>>      }
>>>>  +    /*
>>>> +     * With SRIOV and ARI, vfs can have non-zero slot in the =
conventional
>>>> +     * PCI interpretation as all five bits reserved for slot =
addresses are
>>>> +     * also used for function bits for the various vfs. Ignore =
that case.
>>>=20
>>> You don't have to mention SR/IOV; it affects all ARI-capable =
devices. A PF can also have non-zero slot number in the conventional =
interpretation so you shouldn't call it vf either.
>> Can you please help write a comment that explains this properly for =
all cases - ARI/non-ARI, PFs and VFs? Once everyone agrees that its =
clear and correct, I will re-spin.
>=20
> Simply, you can say:
> With ARI, the slot number field in the conventional PCI interpretation =
can have a non-zero value as the field bits are reused to extend the =
function number bits. Ignore that case.

but we are not checking for ARI capability here in the code. So the =
comment is confusing.

>=20
>>>=20
>>>> +     */
>>>> +    if (pci_is_express(pci_dev) &&
>>>> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>>>> +        pcie_has_upstream_port(pci_dev) &&
>>>> +        PCI_SLOT(pci_dev->devfn)) {
>>>> +        warn_report("PCI: slot %d is not valid for %s,"
>>>> +                    " parent device only allows plugging into slot =
0.",
>>>> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
>>>> +    }
>>>> +
>>>>      if (pci_dev->failover_pair_id) {
>>>>          if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
>>>>              error_setg(errp, "failover primary device must be on "


