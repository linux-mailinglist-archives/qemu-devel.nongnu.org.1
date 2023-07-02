Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5680D744C4D
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 07:07:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFpHB-00026p-Oc; Sun, 02 Jul 2023 01:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFpGs-00025z-C7
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFpGq-0008Br-AV
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688274310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZFu4wRAilY5ImS9rxPMvrvn2QsquzuhTxUyvW/gzO0=;
 b=Wf6izQlrHntXVc9NHOx5Ze67l2L64eMMLmSXQ04y+oHjrFlv8G7gSrWw0IPmZpXatEI46T
 qPpECDhaUXrH+Y2CQZbamc4h0lU6WpiDmLIcUpXnS8400WLkdsqCWnvXd2x1ENrR+sRNPP
 3T6pqlxbtiw04ExQaKWT5AgzBtODDFg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-U4ElvtYUPxeP0y-ibI-B4w-1; Sun, 02 Jul 2023 01:05:09 -0400
X-MC-Unique: U4ElvtYUPxeP0y-ibI-B4w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbb34f7224so19146445e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 22:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688274308; x=1690866308;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VZFu4wRAilY5ImS9rxPMvrvn2QsquzuhTxUyvW/gzO0=;
 b=goN6qoot71hmfQjuQP2NXJZg/IYV8C+TIkhqIDgaF1HQuSJTUZjenqYloS5moEr2Q2
 26bOkmvgE6vHppBJQWVAn/pg4qUb5H1Tgf/5BwY2JXMO+IvtB3ItxYytMptUi+fT5GW9
 MnWy/7XQ8EbsuLvz4mCK3V78hIk7F8MO0iGVb3rYu4KFS0HrSg3265FvBW77bJU6IPLg
 R32/lSP8VscUhr8RyR72oMQ6t1UMtET0UDWukso6Yib05/JSNVSe5/mu75grvgSXO10M
 nr2Ya0WU18qfl9gcOkcpP+yJF0l6lNBpX0eB1LI0lpN26tx0Nu2WnuUsDupoQAmn88PB
 WHxg==
X-Gm-Message-State: AC+VfDzRyRxAi2liinsXwfK/AqlNzNGKRxtdOsX5MMHYd9RGq+Q8BgGv
 JaV+kv2qgG7YtpmLBZT3Q0sGqqvpDdrBZ4IHJal/PptNO/U2h9o6YX6iNi1UQ8nKHCkz7wdTHuq
 Vr1+F7vV/43ULqUc=
X-Received: by 2002:a7b:c8c6:0:b0:3fb:b530:a4e4 with SMTP id
 f6-20020a7bc8c6000000b003fbb530a4e4mr5459467wml.8.1688274308000; 
 Sat, 01 Jul 2023 22:05:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ75XpCofZSXTXMD8O/sWLvyvJ6wFjkqzJ2AZbnphipxrRdgnVtLjCITpB6LC7xnyWEkcQosQQ==
X-Received: by 2002:a7b:c8c6:0:b0:3fb:b530:a4e4 with SMTP id
 f6-20020a7bc8c6000000b003fbb530a4e4mr5459447wml.8.1688274307618; 
 Sat, 01 Jul 2023 22:05:07 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 o23-20020a05600c379700b003fae92e7a8dsm17161624wmr.27.2023.07.01.22.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jul 2023 22:05:06 -0700 (PDT)
Date: Sun, 2 Jul 2023 01:05:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 3/4] igb: Fix ARI next function numbers
Message-ID: <20230702010041-mutt-send-email-mst@kernel.org>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
 <20230701070133.24877-4-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230701070133.24877-4-akihiko.odaki@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Sat, Jul 01, 2023 at 04:01:21PM +0900, Akihiko Odaki wrote:
> The next function numbers are expected to form a linked list ending with
> 0.
> 
> Fixes: 3a977deebe ("Intrdocue igb device emulation")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/igb_core.h | 3 +++
>  hw/net/igb.c      | 4 +---
>  hw/net/igbvf.c    | 5 ++++-
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
> index 9cbbfd516b..e1dab76995 100644
> --- a/hw/net/igb_core.h
> +++ b/hw/net/igb_core.h
> @@ -49,6 +49,9 @@
>  #define IGB_NUM_QUEUES          (16)
>  #define IGB_NUM_VM_POOLS        (8)
>  
> +#define IGB_VF_OFFSET           (0x80)
> +#define IGB_VF_STRIDE           (2)
> +
>  typedef struct IGBCore IGBCore;
>  
>  enum { PHY_R = BIT(0),
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index 1c989d7677..543ca0114a 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -81,8 +81,6 @@ struct IGBState {
>  };
>  
>  #define IGB_CAP_SRIOV_OFFSET    (0x160)
> -#define IGB_VF_OFFSET           (0x80)
> -#define IGB_VF_STRIDE           (2)
>  
>  #define E1000E_MMIO_IDX     0
>  #define E1000E_FLASH_IDX    1
> @@ -431,7 +429,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>          hw_error("Failed to initialize AER capability");
>      }
>  
> -    pcie_ari_init(pci_dev, 0x150, 1);
> +    pcie_ari_init(pci_dev, 0x150, IGB_VF_OFFSET);
>  
>      pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
>          IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,


I think this change would break migrations from 8.0. No?


More importantly your commit log says linked list should end
with 0, but you make it point at a VF instead.


> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
> index 284ea61184..bf2f237ab5 100644
> --- a/hw/net/igbvf.c
> +++ b/hw/net/igbvf.c
> @@ -240,6 +240,9 @@ static const MemoryRegionOps mmio_ops = {
>  static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
>  {
>      IgbVfState *s = IGBVF(dev);
> +    uint16_t nextvfn = pcie_sriov_vf_number(dev) + 1;
> +    uint16_t nextfn = nextvfn < IGB_MAX_VF_FUNCTIONS ?
> +                      IGB_VF_OFFSET + nextvfn * IGB_VF_STRIDE : 0;
>      int ret;
>      int i;
>  
> @@ -270,7 +273,7 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
>          hw_error("Failed to initialize AER capability");
>      }
>  
> -    pcie_ari_init(dev, 0x150, 1);
> +    pcie_ari_init(dev, 0x150, nextfn);



For this one I don't see why it matters at all:

The presence of Shadow Functions does not affect this field.
For VFs, this field is undefined since VFs are located using First VF Offset (see § Section 9.3.3.9 ) and VF
Stride (see § Section 9.3.3.10 ).




>  }
>  
>  static void igbvf_pci_uninit(PCIDevice *dev)
> -- 
> 2.41.0


