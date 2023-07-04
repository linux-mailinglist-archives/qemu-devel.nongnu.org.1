Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 040447473FD
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:21:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgtT-0000i8-EC; Tue, 04 Jul 2023 10:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGgtO-0000hr-S2
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qGgtM-0004uu-8h
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688480430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/SPZQ2GEyn1BZ3EaO3bLyDBZAq+aztXSFu65EHnYeLE=;
 b=aH+kHmYnSAdMds2JYSB6Hyypntv9t7q7tZMB6mSJ9hE7TT4hRt61kLcE86hIptD9hOkD52
 ZqWuGQCeCWSN1smLxYuozdyDcnWcUhQ0ZUnPBRhXXZhtbufmBdg2+oNASjEO5OXnz3aQ42
 /CEkQwpYPlQqrMJcTbiXCpb2kqnxCwQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-FTvYRGd8MKKI_0B5eQDMlA-1; Tue, 04 Jul 2023 10:20:29 -0400
X-MC-Unique: FTvYRGd8MKKI_0B5eQDMlA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6f51c5cb3so7156131fa.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688480423; x=1691072423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SPZQ2GEyn1BZ3EaO3bLyDBZAq+aztXSFu65EHnYeLE=;
 b=LJGEhoAD7r8EdOhRfB4nvQt/4Y/xcHFvNSTi6BYqUxP10Rb6prxehg57A5jE3VBbIA
 T/Ue9R37v/ozMWUCL20idakX0z+DBVJohGccsJUO2aMWVVMapMOhuw27tJGkjSpULL6p
 g6uXlCJjILJqT3MurcsMpyZusckFxJhZm3ROHjx3GevmBnLePPyaUWlB7jaGbmAF7SkH
 Q5TfrmSBOZDWiDf+3cnpAhVsS1XZ56d2Jy4gSwqtS8ofoC64jyxvQIwGwBZqO+rGvIGa
 oGxF85gtstD44qWvHld7/XlJlfvpjV+7Px0/cYjLzS2c5TnyogIEQUzm6rlh/IDdW+pJ
 yhfA==
X-Gm-Message-State: ABy/qLZe6VHTBMWckhxnvTdTo1kox2A1m9Ys/zogdKSFuXd65XoHiN/e
 lmoclYy0muSyi5fsaPzUJkMZWcfNCmgbH99DTJkKoKm4eNVyPTXYvXya8yfs2VBPSRDFVgxs/Rm
 769wl1tuIeqX0D5A=
X-Received: by 2002:a2e:805a:0:b0:2b6:d7d1:95bf with SMTP id
 p26-20020a2e805a000000b002b6d7d195bfmr8091997ljg.9.1688480423431; 
 Tue, 04 Jul 2023 07:20:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF0tRCqTgm07yFDXgSf2sa5ICyMSfXGF0TBuJOnTQgjU0rdt4Giedk+GKBucZgjNTiic0OTww==
X-Received: by 2002:a2e:805a:0:b0:2b6:d7d1:95bf with SMTP id
 p26-20020a2e805a000000b002b6d7d195bfmr8091976ljg.9.1688480423032; 
 Tue, 04 Jul 2023 07:20:23 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 w6-20020a17090633c600b0098748422178sm13193720eja.56.2023.07.04.07.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 07:20:22 -0700 (PDT)
Date: Tue, 4 Jul 2023 16:20:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, Jason Wang <jasowang@redhat.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v4 2/2] pcie: Specify 0 for ARI next function numbers
Message-ID: <20230704162021.18e05471@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230704122215.23270-3-akihiko.odaki@daynix.com>
References: <20230704122215.23270-1-akihiko.odaki@daynix.com>
 <20230704122215.23270-3-akihiko.odaki@daynix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Tue,  4 Jul 2023 21:22:14 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> The current implementers of ARI are all SR-IOV devices. The ARI next
> function number field is undefined for VF .
                                           ^
add a reference to a spec (spec name, rev, chapter) where it's declared
so reviewer or whoever reads it later could easily find relevant
documentation.

>The PF should end the linked
> list formed with the field by specifying 0.
ditto

> 
> For migration, the field will keep having 1 as its value on the old
> virt models.
> 
> Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
> Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
> Fixes: 3a977deebe ("Intrdocue igb device emulation")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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


