Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B584D74D4E1
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:02:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpZj-0003Lp-4i; Mon, 10 Jul 2023 08:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIpZP-0003IX-0A
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIpZN-0005Hu-8i
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688990444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5iYDqtz+1CHRmqDG8zIJZYQdN39OKSnU8nllGYw7uiM=;
 b=P1CsdlPFoBrsV7CwXmFMNBVAu9hUpsat4FE5HF3Fbk99l2stl6HJQ5D5ug60cJq49ScVRo
 WEp4781zz7GV3n7V+J4PT9p94t161bMUtpvwQx4HkhWggQTjvVURIcLA36Uz4xeKaBbRyB
 xMNErz6tiIYUNU44c6rch4BGVBByRhc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-_ASO-pNZP_OxsjghYzn2fw-1; Mon, 10 Jul 2023 08:00:29 -0400
X-MC-Unique: _ASO-pNZP_OxsjghYzn2fw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so24469255e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688990424; x=1691582424;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5iYDqtz+1CHRmqDG8zIJZYQdN39OKSnU8nllGYw7uiM=;
 b=g81j47jTxeqouBIEaVNbVSxSlVRyyG/FAdZCGWSlR/BzejXPsUdWAzSFxpLK7xlFJi
 Rit6UCDTmChagCvZmKHsTkcwS2b6IAOcQyAqfMLhBuH9NTfNLzL9TdxR6fYDqKzzUIYk
 HMbtGAjIs57bUZNsZ6amt/xQa62PiwHZkPRxCVYhEBDbuZaJIPttuWaog7ZcRIv3CRhC
 Wdcc72NJ11imzD/8Bvra/bdyFH6EV8R/8SMoxWyQU6oYu5dSAq81TvLKJ/OY7d/jX62t
 Wt7L1miLnrNE959pN7yBpt1PPqnXkOpto4Bv4/P/tnjUT70efkLFagRa0tXJcX64T6+V
 Xr7A==
X-Gm-Message-State: ABy/qLbWcq48szuN6WOM72RydM7D9EI+ytYW+ygogTTTLFisskvguawd
 +qghmnB3df+zKCzHl1qyh6z0kxqPNOkHCi+iTUVFsmwvFaQEVUfpYBOt9EH5LHGnAHp+cGBJHvF
 sGn+TPE7velrXW8Y=
X-Received: by 2002:a05:600c:3644:b0:3fc:627:ea31 with SMTP id
 y4-20020a05600c364400b003fc0627ea31mr6172306wmq.38.1688990423114; 
 Mon, 10 Jul 2023 05:00:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFgWKOx1yTdQ8H01BnBcyyBfzviUqSXw0ouqGcHMICLt8fuDnrOQTVfgiFMQMkLWR2DeOqjLw==
X-Received: by 2002:a05:600c:3644:b0:3fc:627:ea31 with SMTP id
 y4-20020a05600c364400b003fc0627ea31mr6172102wmq.38.1688990421233; 
 Mon, 10 Jul 2023 05:00:21 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c00d300b003fc02e8ea68sm7593808wmm.13.2023.07.10.05.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:00:20 -0700 (PDT)
Date: Mon, 10 Jul 2023 08:00:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v5 2/2] pcie: Specify 0 for ARI next function numbers
Message-ID: <20230710075925-mutt-send-email-mst@kernel.org>
References: <20230705022421.13115-1-akihiko.odaki@daynix.com>
 <20230705022421.13115-3-akihiko.odaki@daynix.com>
 <E8241AB3-F645-4697-A5AC-9B6BC897B432@redhat.com>
 <20230710051539-mutt-send-email-mst@kernel.org>
 <B82575EB-132B-4B15-B9EC-89B947826367@redhat.com>
 <20230710054117-mutt-send-email-mst@kernel.org>
 <D311E48F-1283-4A6D-895F-4E466717543B@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D311E48F-1283-4A6D-895F-4E466717543B@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 10, 2023 at 03:44:04PM +0530, Ani Sinha wrote:
> 
> 
> > On 10-Jul-2023, at 3:14 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Mon, Jul 10, 2023 at 02:49:55PM +0530, Ani Sinha wrote:
> >> 
> >> 
> >>> On 10-Jul-2023, at 2:46 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> 
> >>> On Mon, Jul 10, 2023 at 01:21:50PM +0530, Ani Sinha wrote:
> >>>> 
> >>>> 
> >>>>> On 05-Jul-2023, at 7:54 AM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >>>>> 
> >>>>> The current implementers of ARI are all SR-IOV devices. The ARI next
> >>>>> function number field is undefined for VF according to PCI Express Base
> >>>>> Specification Revision 5.0 Version 1.0 section 9.3.7.7. The PF should
> >>>>> end the linked list formed with the field by specifying 0 according to
> >>>>> section 7.8.7.2.
> >>>> 
> >>>> Section 7.8.7.2 ARI Capability Register (Offset 04h), I see only this
> >>>> 
> >>>> Next Function Number - This field indicates the Function Number of the next higher numbered Function in the Device, or 00h if there are no higher numbered Functions. Function 0 starts this linked list of Functions.
> >>>> 
> >>>> I do not see anything specifically for PF. What am I missing?
> >>> 
> >>> This is *only* for PFs.
> >> 
> >> I think this covers both SRIOV and non SRIOV cases both. This is a
> >> general case for all devices, PF or other non-SRIOV capable devices.
> > 
> > "this" being what?
> 
> “this” is the following line I quoted above:
> 
> "Next Function Number - This field indicates the Function Number of the next higher numbered Function in the Device, or 00h if there are no higher numbered Functions. Function 0 starts this linked list of Functions.”
> 
> I think it applies for all devices in general (except VFs).

For all functions of devices with ARI support, yes. Does not apply to VFs.

> > I'm talking about the pci spec text
> > you quoted.
> > 
> > check out the sriov spec:
> > Next Function Number – VFs are located using First
> > VF Offset (see Section 3.3.9) and VF Stride (see
> > Section 3.3.10).
> > 
> > 
> > 
> >>> There's separate text explaining that
> >>> VFs use NumVFs VFOffset and VFStride.
> >>> 
> >>> 
> >>>>> 
> >>>>> For migration, the field will keep having 1 as its value on the old
> >>>>> virt models.
> >>>>> 
> >>>>> Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
> >>>>> Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
> >>>>> Fixes: 3a977deebe ("Intrdocue igb device emulation")
> >>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>> ---
> >>>>> include/hw/pci/pci.h | 2 ++
> >>>>> hw/core/machine.c    | 1 +
> >>>>> hw/pci/pci.c         | 2 ++
> >>>>> hw/pci/pcie.c        | 2 +-
> >>>>> 4 files changed, 6 insertions(+), 1 deletion(-)
> >>>>> 
> >>>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> >>>>> index e6d0574a29..9c5b5eb206 100644
> >>>>> --- a/include/hw/pci/pci.h
> >>>>> +++ b/include/hw/pci/pci.h
> >>>>> @@ -209,6 +209,8 @@ enum {
> >>>>>   QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
> >>>>> #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
> >>>>>   QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
> >>>>> +#define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
> >>>>> +    QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> >>>>> };
> >>>>> 
> >>>>> typedef struct PCIINTxRoute {
> >>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >>>>> index 46f8f9a2b0..f0d35c6401 100644
> >>>>> --- a/hw/core/machine.c
> >>>>> +++ b/hw/core/machine.c
> >>>>> @@ -41,6 +41,7 @@
> >>>>> 
> >>>>> GlobalProperty hw_compat_8_0[] = {
> >>>>>   { "migration", "multifd-flush-after-each-section", "on"},
> >>>>> +    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> >>>>> };
> >>>>> const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
> >>>>> 
> >>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >>>>> index e2eb4c3b4a..45a9bc0da8 100644
> >>>>> --- a/hw/pci/pci.c
> >>>>> +++ b/hw/pci/pci.c
> >>>>> @@ -82,6 +82,8 @@ static Property pci_props[] = {
> >>>>>   DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
> >>>>>   DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
> >>>>>                   QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> >>>>> +    DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> >>>>> +                    QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> >>>>>   DEFINE_PROP_END_OF_LIST()
> >>>>> };
> >>>>> 
> >>>>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> >>>>> index 9a3f6430e8..cf09e03a10 100644
> >>>>> --- a/hw/pci/pcie.c
> >>>>> +++ b/hw/pci/pcie.c
> >>>>> @@ -1030,7 +1030,7 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
> >>>>> /* ARI */
> >>>>> void pcie_ari_init(PCIDevice *dev, uint16_t offset)
> >>>>> {
> >>>>> -    uint16_t nextfn = 1;
> >>>>> +    uint16_t nextfn = dev->cap_present & QEMU_PCIE_ARI_NEXTFN_1 ? 1 : 0;
> >>>>> 
> >>>>>   pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
> >>>>>                       offset, PCI_ARI_SIZEOF);
> >>>>> -- 
> >>>>> 2.41.0
> >>>>> 
> >>> 
> > 


