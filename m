Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EC374D13B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIn4A-00069j-3v; Mon, 10 Jul 2023 05:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qIn42-00069G-NK
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qIn3v-0006UP-1r
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688980806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yltN/0SFfZF3wPcXSIqUhOBoPcKPlLkFHIoSC4DS+2A=;
 b=aP4r2ye8J5tWRhc3+xHEBafwj83pAsMObUUUI3SYB4J2QWhBLNh60eOCK0bsQ20HDidyDU
 qk7qB8P5Bb0UnFOrwRbdT644iM5fYubEYCn4lmNhzgxEz6hTduIrAODWOcXM31qMlou0tR
 dYUZTsp5DDZUSv7YMIoJ5iyNyvthEcQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-hMSvlcmeNsK5Eerz6MijHg-1; Mon, 10 Jul 2023 05:20:04 -0400
X-MC-Unique: hMSvlcmeNsK5Eerz6MijHg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-26304c2e178so7152401a91.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688980801; x=1691572801;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yltN/0SFfZF3wPcXSIqUhOBoPcKPlLkFHIoSC4DS+2A=;
 b=eIpEcSHsPnrK/hNiLPQEtPhcPKLH5ldKqufolh6ZJACBoy2a75FQBUUHSUNahbF+Cs
 wD73/lciq5zmfInewfrMY4q9iu0UfyNObSYdAmETxE7z8loGxZN0MPV7H8cqCmDV2bad
 Pn0zIHrt0ssrPvg+p0VyE6LXZKFEXId4KP59g/kmXxq7DSaHvA6VCNNdG/Fhcrh6VTMa
 gUDmErn1RBbertNIl2moo3CTvNOJYepP/tkvumKmKFhcRqN1rWKBYWxfHpMpH8i3UV84
 rkUhSrzDmfcrC1FZhQWrKjEVBFw3osBYQb9wqpmac+Nuyy/dRutlLZ0/1qfEa0pSeBFe
 l6Wg==
X-Gm-Message-State: ABy/qLYoS9ZJgTJ56rwCiMOpCQcoxRjTgvUGimIsn9tr+TFHiQ+u5yGR
 dqng8kFwCuNS20vABQe34Q1I2reJ8VkImTWx9dslvxgSqxHBTXh9YbK78ymSw9ggEF82yT0eplz
 pMS1cR3fAujlM0i4=
X-Received: by 2002:a17:90a:8d0a:b0:262:ecc3:ee6b with SMTP id
 c10-20020a17090a8d0a00b00262ecc3ee6bmr12586488pjo.39.1688980801313; 
 Mon, 10 Jul 2023 02:20:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEaMbh9BbvDaXhiPxoXk5U2H+NJbdqYs5kDJOUhrS78g7Zw7RfD7HdkTmrEaQRbvt7e3JOQCQ==
X-Received: by 2002:a17:90a:8d0a:b0:262:ecc3:ee6b with SMTP id
 c10-20020a17090a8d0a00b00262ecc3ee6bmr12586465pjo.39.1688980800920; 
 Mon, 10 Jul 2023 02:20:00 -0700 (PDT)
Received: from smtpclient.apple ([203.212.247.118])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a17090ac28c00b00262ff206931sm5785216pjt.42.2023.07.10.02.19.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jul 2023 02:20:00 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v5 2/2] pcie: Specify 0 for ARI next function numbers
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230710051539-mutt-send-email-mst@kernel.org>
Date: Mon, 10 Jul 2023 14:49:55 +0530
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B82575EB-132B-4B15-B9EC-89B947826367@redhat.com>
References: <20230705022421.13115-1-akihiko.odaki@daynix.com>
 <20230705022421.13115-3-akihiko.odaki@daynix.com>
 <E8241AB3-F645-4697-A5AC-9B6BC897B432@redhat.com>
 <20230710051539-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



> On 10-Jul-2023, at 2:46 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Mon, Jul 10, 2023 at 01:21:50PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 05-Jul-2023, at 7:54 AM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>>>=20
>>> The current implementers of ARI are all SR-IOV devices. The ARI next
>>> function number field is undefined for VF according to PCI Express =
Base
>>> Specification Revision 5.0 Version 1.0 section 9.3.7.7. The PF =
should
>>> end the linked list formed with the field by specifying 0 according =
to
>>> section 7.8.7.2.
>>=20
>> Section 7.8.7.2 ARI Capability Register (Offset 04h), I see only this
>>=20
>> Next Function Number - This field indicates the Function Number of =
the next higher numbered Function in the Device, or 00h if there are no =
higher numbered Functions. Function 0 starts this linked list of =
Functions.
>>=20
>> I do not see anything specifically for PF. What am I missing?
>=20
> This is *only* for PFs.

I think this covers both SRIOV and non SRIOV cases both. This is a =
general case for all devices, PF or other non-SRIOV capable devices.

> There's separate text explaining that
> VFs use NumVFs VFOffset and VFStride.
>=20
>=20
>>>=20
>>> For migration, the field will keep having 1 as its value on the old
>>> virt models.
>>>=20
>>> Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in =
docs/pcie_sriov.txt")
>>> Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
>>> Fixes: 3a977deebe ("Intrdocue igb device emulation")
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>> include/hw/pci/pci.h | 2 ++
>>> hw/core/machine.c    | 1 +
>>> hw/pci/pci.c         | 2 ++
>>> hw/pci/pcie.c        | 2 +-
>>> 4 files changed, 6 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index e6d0574a29..9c5b5eb206 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -209,6 +209,8 @@ enum {
>>>    QEMU_PCIE_CAP_CXL =3D (1 << QEMU_PCIE_CXL_BITNR),
>>> #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
>>>    QEMU_PCIE_ERR_UNC_MASK =3D (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
>>> +#define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
>>> +    QEMU_PCIE_ARI_NEXTFN_1 =3D (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
>>> };
>>>=20
>>> typedef struct PCIINTxRoute {
>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index 46f8f9a2b0..f0d35c6401 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -41,6 +41,7 @@
>>>=20
>>> GlobalProperty hw_compat_8_0[] =3D {
>>>    { "migration", "multifd-flush-after-each-section", "on"},
>>> +    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
>>> };
>>> const size_t hw_compat_8_0_len =3D G_N_ELEMENTS(hw_compat_8_0);
>>>=20
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index e2eb4c3b4a..45a9bc0da8 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -82,6 +82,8 @@ static Property pci_props[] =3D {
>>>    DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
>>>    DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
>>>                    QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>>> +    DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>>> +                    QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
>>>    DEFINE_PROP_END_OF_LIST()
>>> };
>>>=20
>>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>>> index 9a3f6430e8..cf09e03a10 100644
>>> --- a/hw/pci/pcie.c
>>> +++ b/hw/pci/pcie.c
>>> @@ -1030,7 +1030,7 @@ void pcie_sync_bridge_lnk(PCIDevice =
*bridge_dev)
>>> /* ARI */
>>> void pcie_ari_init(PCIDevice *dev, uint16_t offset)
>>> {
>>> -    uint16_t nextfn =3D 1;
>>> +    uint16_t nextfn =3D dev->cap_present & QEMU_PCIE_ARI_NEXTFN_1 ? =
1 : 0;
>>>=20
>>>    pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
>>>                        offset, PCI_ARI_SIZEOF);
>>> --=20
>>> 2.41.0
>>>=20
>=20


