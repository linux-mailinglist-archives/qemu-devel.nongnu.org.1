Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 591EE744D4D
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 12:35:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFuP1-0005rH-Bc; Sun, 02 Jul 2023 06:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFuOy-0005ql-Nv
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 06:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFuOx-0000T1-3Z
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 06:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688294033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RlnahdG8z+DTT0VrC+GZF88bKnRdtBvepFnCM+RiWK8=;
 b=G96TJMcHTPhCDQJWmHYHXC8mbNcgyVL/vqcfGEG4HiUudQtiUTDWyVuoC9kDmdZf1bIl46
 Ed+GFT7rTY55K/AECiC2bIDEmF2ZiW7DZvxMStC7itNgiQj3JK+fO9Ms2cETMlMGkeb4Jf
 MVr7YxV9DXEdNVYQLjJEx9WNYhivkCQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-fkDBfRjuPOS3pRBnJu3pVg-1; Sun, 02 Jul 2023 06:33:52 -0400
X-MC-Unique: fkDBfRjuPOS3pRBnJu3pVg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51d8823eb01so1882701a12.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 03:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688294031; x=1690886031;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlnahdG8z+DTT0VrC+GZF88bKnRdtBvepFnCM+RiWK8=;
 b=RUFwzs/kulTWnXeXwxYodTQ8lqpnrs7n36URnsVslHJafq2NS8BYFKZ/TDy6+4F264
 EKOfwwF6Cdh5f6u+Z/pFB3EJLLZ4KA4+LgosgEFP/txfGesgQCq5sh0G0+inu12MfWl6
 qvuwyOw3EVDvXbdUibTXUYukuwRt0vEClC6u/WzqNCLSfQP3bE8TFaIdVH9flyZ4hXBi
 O76UN31X2xsWI/5olP1a028ll7bxUzT1l8LQUH+vPZIpyBFbfhEq/VmCAFPgKLmcXI3L
 722SQOIjMqE8/eTycc/pg68Ut1alLe2VIQ5nzUNlSBQ43xlusQvOf4qQSfrO7cxkV2IW
 oo+Q==
X-Gm-Message-State: ABy/qLZEK7qUjhCj7MDDsHm42Yf+SxUzYM47TS5eMPALBJ0K+BvV9Obb
 QzFENEoReeB+6tmxSoi7K+jfQrjPbF5yceJjH2nXga9+dpQoz4fk1LhJnTGbltwe46MN5JrZpHE
 ph+JIlNZPRQeuF/0=
X-Received: by 2002:aa7:c609:0:b0:514:af52:e49a with SMTP id
 h9-20020aa7c609000000b00514af52e49amr4944144edq.25.1688294031086; 
 Sun, 02 Jul 2023 03:33:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFRN61stYeTIOU0JMtFhJY37ysiOxYYyEvyaTlOBi4Xq7nxiK2eZ97Kk5hwbT/hlc63lR3kfA==
X-Received: by 2002:aa7:c609:0:b0:514:af52:e49a with SMTP id
 h9-20020aa7c609000000b00514af52e49amr4944131edq.25.1688294030813; 
 Sun, 02 Jul 2023 03:33:50 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 m3-20020a170906720300b009926928d486sm5576353ejk.35.2023.07.02.03.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 03:33:49 -0700 (PDT)
Date: Sun, 2 Jul 2023 06:33:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v2 3/4] igb: Fix ARI next function numbers
Message-ID: <20230702063136-mutt-send-email-mst@kernel.org>
References: <20230702094631.39111-1-akihiko.odaki@daynix.com>
 <20230702094631.39111-4-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702094631.39111-4-akihiko.odaki@daynix.com>
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

On Sun, Jul 02, 2023 at 06:46:27PM +0900, Akihiko Odaki wrote:
> The ARI next function number field is undefined for VF so the PF should
> end the linked list formed with the field by specifying 0.
> 
> Fixes: 3a977deebe ("Intrdocue igb device emulation")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/core/machine.c | 3 ++-
>  hw/net/igb.c      | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f984a767a2..1f5aacd1dc 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,7 +41,8 @@
>  
>  GlobalProperty hw_compat_8_0[] = {
>      { "migration", "multifd-flush-after-each-section", "on"},
> -    { "nvme", "ari-nextfn-1", "on"},
> +    { "igb", "ari-nextfn-1", "on" },
> +    { "nvme", "ari-nextfn-1", "on" },
>  };
>  const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>  
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index 1c989d7677..d37d43c155 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -78,6 +78,8 @@ struct IGBState {
>      uint32_t ioaddr;
>  
>      IGBCore core;
> +
> +    bool ari_nextfn_1;

Document this field please, explaining why it's there.

>  };
>  
>  #define IGB_CAP_SRIOV_OFFSET    (0x160)
> @@ -431,7 +433,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>          hw_error("Failed to initialize AER capability");
>      }
>  
> -    pcie_ari_init(pci_dev, 0x150, 1);
> +    pcie_ari_init(pci_dev, 0x150, s->ari_nextfn_1 ? 1 : 0);

Why don't we move the logic to pci core, and drop code duplication
completely?

>  
>      pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
>          IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
> @@ -582,6 +584,7 @@ static const VMStateDescription igb_vmstate = {
>  
>  static Property igb_properties[] = {
>      DEFINE_NIC_PROPERTIES(IGBState, conf),
> +    DEFINE_PROP_BOOL("ari-nextfn-1", IGBState, ari_nextfn_1, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };

This really needs to be a non stable property (prefix with "x-").



> -- 
> 2.41.0


