Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A20B74CF4E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:00:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlna-0000x5-Ay; Mon, 10 Jul 2023 03:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qIlnU-0000vv-3F
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qIlnS-0003Wz-KR
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688975941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hO4L4LWrFU4xqR/h9UCWhINI2BTBj61ogP6YKFxh6p4=;
 b=T6PofYuTYjOHgQn3cnyJdqCICUaB5JbFlYliQsVAu9TyaZTAWLqroI1Oq2Q2wHB2aPKh6X
 r/f215FD5xQjLjxUAOFdu6vzQtKMTbBCNYOEwIgOSyXqQQTDWOJmR0eCNJ4bKQZzjiE/yJ
 zY9wPssnKVSbtuqO+bIQU7HXn1vGsPI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-QOE9NTEmNhqQDV7xMdWpiA-1; Mon, 10 Jul 2023 03:58:57 -0400
X-MC-Unique: QOE9NTEmNhqQDV7xMdWpiA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b9de135bddso11522795ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 00:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688975936; x=1691567936;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hO4L4LWrFU4xqR/h9UCWhINI2BTBj61ogP6YKFxh6p4=;
 b=cqAvOyTT2CnzNmzUROumIQOt2791FJWbuN52dm/i58eOD4+32gNb7OVgEbfIOkG7ZU
 D8w5tblgkMS4n7Ued3y804BsqZFpua+VqC/DCA0DW3l0njlv+UYwa6d62ng6VRfPwU9+
 b9TYzDDlYd6ltmysT4AdTNmizKgBiS0ei8kLTeUNgYZmrGmM3WGQShbdcI/NKQLAKKRu
 bhy+A+vRCR4/Krn7SRA3aCNHx0fBzJTrnOZRv9dbCzeypeKqjcFB26ZUr0ftyp7QZQZ/
 lG0fUFkeKylqG7EPoOa9AEu48oI+Je1ArSIgtKox1oKsxG5NGSvwpwa8lQ026ciJZe8p
 xAfw==
X-Gm-Message-State: ABy/qLbcKQ/D788RzN6gLGLeVcg7FvHYDNeAzIpHqpiL8vw4LNQ/LH9L
 R5ZDO5OLPgWDM41mjfhAYqGh1FyGuR5//y/rXIe0hyGpEsMuEe95/hYNSdHP2Dve0rBjcYAPRSP
 kMrNjzL1M1s4hu7E=
X-Received: by 2002:a17:902:7087:b0:1b8:649d:3652 with SMTP id
 z7-20020a170902708700b001b8649d3652mr9701319plk.32.1688975936136; 
 Mon, 10 Jul 2023 00:58:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGczisK95jM5iPKWzfaRoutSKQVOgB29DXTC8gDtIXVxCT4FqDi1RS/NIzLpkaGqR56OhkDew==
X-Received: by 2002:a17:902:7087:b0:1b8:649d:3652 with SMTP id
 z7-20020a170902708700b001b8649d3652mr9701312plk.32.1688975935797; 
 Mon, 10 Jul 2023 00:58:55 -0700 (PDT)
Received: from smtpclient.apple ([203.212.247.118])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a170902694c00b001b672af624esm7575897plt.164.2023.07.10.00.58.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jul 2023 00:58:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v5 2/2] pcie: Specify 0 for ARI next function numbers
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <f46049e1-dabf-9038-ca12-386ff5a77442@daynix.com>
Date: Mon, 10 Jul 2023 13:28:50 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE49DFB5-DA8E-45C3-8975-59ED33D14F10@redhat.com>
References: <20230705022421.13115-1-akihiko.odaki@daynix.com>
 <20230705022421.13115-3-akihiko.odaki@daynix.com>
 <E8241AB3-F645-4697-A5AC-9B6BC897B432@redhat.com>
 <f46049e1-dabf-9038-ca12-386ff5a77442@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 10-Jul-2023, at 1:23 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2023/07/10 16:51, Ani Sinha wrote:
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
>> Section 7.8.7.2 ARI Capability Register (Offset 04h), I see only this
>> Next Function Number - This field indicates the Function Number of =
the next higher numbered Function in the Device, or 00h if there are no =
higher numbered Functions. Function 0 starts this linked list of =
Functions.
>> I do not see anything specifically for PF. What am I missing?
>=20
> It's not specific to PF, but in general the linked list of Functions =
needs to end with 0.

OK so the language is confusing here. Maybe just say that the next =
function number should be 00h if there are no higher numbered functions, =
without saying anything about PF.

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
>>>     QEMU_PCIE_CAP_CXL =3D (1 << QEMU_PCIE_CXL_BITNR),
>>> #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
>>>     QEMU_PCIE_ERR_UNC_MASK =3D (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
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
>>>     { "migration", "multifd-flush-after-each-section", "on"},
>>> +    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
>>> };
>>> const size_t hw_compat_8_0_len =3D G_N_ELEMENTS(hw_compat_8_0);
>>>=20
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index e2eb4c3b4a..45a9bc0da8 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -82,6 +82,8 @@ static Property pci_props[] =3D {
>>>     DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
>>>     DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
>>>                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>>> +    DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>>> +                    QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
>>>     DEFINE_PROP_END_OF_LIST()
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
>>>     pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
>>>                         offset, PCI_ARI_SIZEOF);
>>> --=20
>>> 2.41.0
>>>=20
>=20


