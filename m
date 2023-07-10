Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DB974D136
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:16:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIn0l-0003T9-Uu; Mon, 10 Jul 2023 05:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIn0X-0003CD-M5
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIn0V-000508-UM
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688980593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SLxwdo8XpYp4rc3mCTHP8a6srwBZVAWHNBpDZ8jOUTo=;
 b=Rrs13EeUHOBNATW0pkI+5uLqETJAU61hnDG5OW79wJb9fR8vgMQHRxybzGJGSQLLXs5bzr
 SV+7KN251WZyL4Va0+6+cN8XyDEoS2NZ0CIwBsQ6UM6kKqi2LMr4ZwPAd2dmoq2viifWzL
 DGJTXKtE4We2BXvTb/hsM0Xw/fX0pUM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-ihYqOoGTPpK1R3ygz7ewKA-1; Mon, 10 Jul 2023 05:16:32 -0400
X-MC-Unique: ihYqOoGTPpK1R3ygz7ewKA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3143ac4a562so2355190f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688980590; x=1691572590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLxwdo8XpYp4rc3mCTHP8a6srwBZVAWHNBpDZ8jOUTo=;
 b=FMDndvHtZJGt0N41OCmTxjXNqQFfWL7a+PLSHaD3Vdk38Vkr0ipi30U4Gt3uAgmfZe
 ASQTE8PSYX3JGkhIivlphlbUvFRK/hId5mNrVMYKLeqSuphQEU5EoNb3NsGK/WedpwK3
 wZ2hgRXyPvUtz4Adu/IceZPkQnljuGl3DFcC1nx2jiFDpqvQjUpSUfKfA5ZLAVLhqdo6
 mlYMIbOVukNLW/5dWDTV7M9Cj3YJFXwvpwVYNUewHf5lBIrwsYzV3HmZlYf9q7jUqpO9
 HHMl2ehk8/zq3UVRP8sKOdER1I1KVHU2jmAEwNaKsy583BtodnOgEmVYsRaQ2YnmT6jA
 NPtw==
X-Gm-Message-State: ABy/qLaYx1u9VTUssgeqZDNpC3UxkUwwqwIKzY7JZnjuAq0ozbWCbYDq
 kT4Ff4EpSI4se8cd9V84v4T63pHbcmTmEgyacvEnQsAiIHFNjyJsSe8LnfCN48jEBQ71bsgjtio
 JsXr+RN+6+eQHZKM=
X-Received: by 2002:a5d:6ad0:0:b0:313:fdbb:422 with SMTP id
 u16-20020a5d6ad0000000b00313fdbb0422mr12257377wrw.43.1688980589934; 
 Mon, 10 Jul 2023 02:16:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEOomDGr8UYaTg/CbkXPmOHzLm5K8Mgy1S8H0LsME11vOkU0bfkM8aU8mzP2kSpZgjmD6KxuQ==
X-Received: by 2002:a5d:6ad0:0:b0:313:fdbb:422 with SMTP id
 u16-20020a5d6ad0000000b00313fdbb0422mr12257351wrw.43.1688980589465; 
 Mon, 10 Jul 2023 02:16:29 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 n2-20020a5d6b82000000b0030ae901bc54sm11147945wrx.62.2023.07.10.02.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 02:16:28 -0700 (PDT)
Date: Mon, 10 Jul 2023 05:16:25 -0400
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
Message-ID: <20230710051539-mutt-send-email-mst@kernel.org>
References: <20230705022421.13115-1-akihiko.odaki@daynix.com>
 <20230705022421.13115-3-akihiko.odaki@daynix.com>
 <E8241AB3-F645-4697-A5AC-9B6BC897B432@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8241AB3-F645-4697-A5AC-9B6BC897B432@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 10, 2023 at 01:21:50PM +0530, Ani Sinha wrote:
> 
> 
> > On 05-Jul-2023, at 7:54 AM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > 
> > The current implementers of ARI are all SR-IOV devices. The ARI next
> > function number field is undefined for VF according to PCI Express Base
> > Specification Revision 5.0 Version 1.0 section 9.3.7.7. The PF should
> > end the linked list formed with the field by specifying 0 according to
> > section 7.8.7.2.
> 
> Section 7.8.7.2 ARI Capability Register (Offset 04h), I see only this
> 
> Next Function Number - This field indicates the Function Number of the next higher numbered Function in the Device, or 00h if there are no higher numbered Functions. Function 0 starts this linked list of Functions.
> 
> I do not see anything specifically for PF. What am I missing?

This is *only* for PFs. There's separate text explaining that
VFs use NumVFs VFOffset and VFStride.


> > 
> > For migration, the field will keep having 1 as its value on the old
> > virt models.
> > 
> > Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
> > Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
> > Fixes: 3a977deebe ("Intrdocue igb device emulation")
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > include/hw/pci/pci.h | 2 ++
> > hw/core/machine.c    | 1 +
> > hw/pci/pci.c         | 2 ++
> > hw/pci/pcie.c        | 2 +-
> > 4 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index e6d0574a29..9c5b5eb206 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -209,6 +209,8 @@ enum {
> >     QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
> > #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
> >     QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
> > +#define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
> > +    QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> > };
> > 
> > typedef struct PCIINTxRoute {
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 46f8f9a2b0..f0d35c6401 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -41,6 +41,7 @@
> > 
> > GlobalProperty hw_compat_8_0[] = {
> >     { "migration", "multifd-flush-after-each-section", "on"},
> > +    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> > };
> > const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index e2eb4c3b4a..45a9bc0da8 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -82,6 +82,8 @@ static Property pci_props[] = {
> >     DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
> >     DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
> >                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > +    DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> > +                    QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> >     DEFINE_PROP_END_OF_LIST()
> > };
> > 
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index 9a3f6430e8..cf09e03a10 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -1030,7 +1030,7 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
> > /* ARI */
> > void pcie_ari_init(PCIDevice *dev, uint16_t offset)
> > {
> > -    uint16_t nextfn = 1;
> > +    uint16_t nextfn = dev->cap_present & QEMU_PCIE_ARI_NEXTFN_1 ? 1 : 0;
> > 
> >     pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
> >                         offset, PCI_ARI_SIZEOF);
> > -- 
> > 2.41.0
> > 


