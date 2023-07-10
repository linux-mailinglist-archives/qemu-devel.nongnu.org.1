Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F374D4C0
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 13:46:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpKJ-0008SP-U9; Mon, 10 Jul 2023 07:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qIpJy-0008NA-OI
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qIpJs-0007KY-LO
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688989479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DRdkqJcWr9EQrgDgFYLCu87V/Io6viQC7DaB09M/7MU=;
 b=i0Vs91P9wEILds4RrV8yTXML0lSYvzL5Q6cDd4zXO424Rm2IPmWaTvwYRvmFlqwxr8Kc14
 rjgPIYa1V6+pL6SvYr/5DZ8O/6+WQIOAsQSdLQGulMD2VXH2jyXdhUa/XoqdvAYteW3o2C
 ZiF/KDhduVhv/H3kKfVx/yj2y6HP1js=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-zYTDQ7PGPR25cubUJt7XDQ-1; Mon, 10 Jul 2023 07:44:37 -0400
X-MC-Unique: zYTDQ7PGPR25cubUJt7XDQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-262d8993033so5507967a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 04:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688989476; x=1691581476;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DRdkqJcWr9EQrgDgFYLCu87V/Io6viQC7DaB09M/7MU=;
 b=F8KJcT2++0wzZyD1fj2+6bTzUoeg5Dc+DtSU+A8BK0SFbNE2697M20kwC9Yg3Pu2OK
 Yg5y/TM6g1WqnXKzFGukD3ILzlvcZD0tEV9APN/tANn0sQAmmDpHNXBBtpK/0f2/Hi4g
 3JTedSG2kJRLUMSqcHio34pqjM26OAvVxzlwISYdjtp4e/y7yiohuxtHDMByAs8gegD2
 9iKIta+XPqVauUihTa97Goph9hzITDNkscHNm1xfQ3OIookBpD6LWmPE2g6+48X5IXtB
 6G8tFx2R1FgZsakdHJjgI8NwecT+jutAjst4m4LTxz1McApIfLXkywRHWilKnoyA58vZ
 ppWQ==
X-Gm-Message-State: ABy/qLZq5p7JaiU2+nAz+v5WqJYdW0Tl9e6PQCBi1zgn47UjS1CuFvuF
 7jODz6bKnT2S7tRGy7WfbGs4JiGyw54la0DBh+4I/IgXh9G1NyKaEAxIxr+OoOeIQqIbI95H68Y
 bOV03JLTTI49d2uA=
X-Received: by 2002:a17:903:110f:b0:1b0:3a74:7fc4 with SMTP id
 n15-20020a170903110f00b001b03a747fc4mr11773614plh.24.1688989476101; 
 Mon, 10 Jul 2023 04:44:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFsBAnDNmvge8+laujl7zMiwnfHa+vJHJP/UL+xBvnoChn6civA7oyJAkehjRi9tdSzNODpBA==
X-Received: by 2002:a17:903:110f:b0:1b0:3a74:7fc4 with SMTP id
 n15-20020a170903110f00b001b03a747fc4mr11773601plh.24.1688989475783; 
 Mon, 10 Jul 2023 04:44:35 -0700 (PDT)
Received: from fc37-ani ([203.212.247.118])
 by smtp.googlemail.com with ESMTPSA id
 l9-20020a170903244900b001b83e5ec666sm8121278pls.6.2023.07.10.04.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 04:44:35 -0700 (PDT)
Date: Mon, 10 Jul 2023 17:14:28 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
cc: Qemu devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v6 2/2] pcie: Specify 0 for ARI next function numbers
In-Reply-To: <20230710080830.19053-3-akihiko.odaki@daynix.com>
Message-ID: <ed4a6b30-7f51-d032-585f-301ba902d6c9@redhat.com>
References: <20230710080830.19053-1-akihiko.odaki@daynix.com>
 <20230710080830.19053-3-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



On Mon, 10 Jul 2023, Akihiko Odaki wrote:

> The current implementers of ARI are all SR-IOV devices. The ARI next
> function number field is undefined for VF according to PCI Express Base
> Specification Revision 5.0 Version 1.0 section 9.3.7.7. The PF still
> requires some defined value so end the linked list formed with the field
> by specifying 0 as required for any ARI implementation according to
> section 7.8.7.2.
>
> For migration, the field will keep having 1 as its value on the old
> virt models.
^^^^^^^^^^^^^^
I would say old qemu machine versions here

>
> Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
> Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
> Fixes: 3a977deebe ("Intrdocue igb device emulation")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

modulo the above, looks ok to me,

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  include/hw/pci/pci.h | 2 ++
>  hw/core/machine.c    | 1 +
>  hw/pci/pci.c         | 2 ++
>  hw/pci/pcie.c        | 2 +-
>  4 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index e6d0574a29..9c5b5eb206 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -209,6 +209,8 @@ enum {
>      QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
>  #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
>      QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
> +#define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
> +    QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
>  };
>
>  typedef struct PCIINTxRoute {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 46f8f9a2b0..f0d35c6401 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,7 @@
>
>  GlobalProperty hw_compat_8_0[] = {
>      { "migration", "multifd-flush-after-each-section", "on"},
> +    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
>  };
>  const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e2eb4c3b4a..45a9bc0da8 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -82,6 +82,8 @@ static Property pci_props[] = {
>      DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
>      DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
>                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> +    DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> +                    QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
>      DEFINE_PROP_END_OF_LIST()
>  };
>
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 9a3f6430e8..cf09e03a10 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1030,7 +1030,7 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
>  /* ARI */
>  void pcie_ari_init(PCIDevice *dev, uint16_t offset)
>  {
> -    uint16_t nextfn = 1;
> +    uint16_t nextfn = dev->cap_present & QEMU_PCIE_ARI_NEXTFN_1 ? 1 : 0;
>
>      pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
>                          offset, PCI_ARI_SIZEOF);
> --
> 2.41.0
>
>


