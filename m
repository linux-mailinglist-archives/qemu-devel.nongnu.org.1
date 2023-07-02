Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F070744CD5
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 11:00:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFswJ-0002EI-96; Sun, 02 Jul 2023 05:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFswH-0002Du-EW
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFswD-0007bb-1G
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688288408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wC6IAWWfPZ1lNxjtYt2vDaasL6gHy4yA2lrkaJqtxoU=;
 b=e26+CiDe68q14vpDlzGH8CvCZq/wtGNw4at7aCBCMvHXPphIVUM+UwFtD/VPzxdjcb2zt1
 9M2hdLgdniZPasetWIkAfL1ZHECAMGp4JK5AGWgE0J0xAQLPcOA64ilnOCF5K4yFlgfHyv
 vQQRHzeg6zJQXWjUs2k6a+Y5qrVL3PM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-AsohXqBqNViM00k18ccE_g-1; Sun, 02 Jul 2023 05:00:06 -0400
X-MC-Unique: AsohXqBqNViM00k18ccE_g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-987a0365f77so189349466b.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 02:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688288405; x=1690880405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wC6IAWWfPZ1lNxjtYt2vDaasL6gHy4yA2lrkaJqtxoU=;
 b=btidxqcMwxOPCONAYnLPjRjSqaEGYvvORBx08HSpfhyKTYqYiITNCa2OVo7lX5uXQd
 6b/j/mLABD9IOEvhFzLmsuT6iYJGzXQCr/sCUQ6CespolXPE8rWmjkmzwGz5OkN8LrmQ
 OFC/folGiwTipY3av1RuVzoKuKo0ZYa2fAq0tYrNCXI2cM6K6OVRq3/+s0tRgGptKT1v
 tCq28RuPMTJrOPVCjjq8JYBNXDrCCr9sqCsvQV4a9YttTKEh1UAgbH3TAgmaLv2P4dAh
 cLzC93rAz0YRiJjKlQA+NQ7VIIav03h9lqGZxUdLi5cCtoRZM6kxNLkjqQ+yJUrW9twz
 hH5w==
X-Gm-Message-State: ABy/qLZIrT6aSx6Mhd4OvSAwvjE/TkrKzZLv896vWaVp/btzmmMZk8jw
 mJpjU5RRstiWjImdixthFzkLScNB79uPQogl7hhHZznCmRyzmKr3/czy7KG6+QiXH8UzoyH5FOi
 v4dAXaNM/FnmnU4LCV2X0NFbZ2g==
X-Received: by 2002:a17:906:480d:b0:974:20bd:6e15 with SMTP id
 w13-20020a170906480d00b0097420bd6e15mr4793394ejq.4.1688288405259; 
 Sun, 02 Jul 2023 02:00:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFMGwPcoaHCeXJW6xoHdLiNyKOXAHedWEyuQhIv7KvxNdVrY4jS+Hv9KhAVY09T6R+it11ohg==
X-Received: by 2002:a17:906:480d:b0:974:20bd:6e15 with SMTP id
 w13-20020a170906480d00b0097420bd6e15mr4793380ejq.4.1688288404964; 
 Sun, 02 Jul 2023 02:00:04 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 ci8-20020a170906c34800b00982d0563b11sm10248612ejb.197.2023.07.02.02.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 02:00:04 -0700 (PDT)
Date: Sun, 2 Jul 2023 05:00:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 3/3] igb: Fix ARI next function numbers
Message-ID: <20230702045815-mutt-send-email-mst@kernel.org>
References: <20230702083357.13517-1-akihiko.odaki@daynix.com>
 <20230702083357.13517-4-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702083357.13517-4-akihiko.odaki@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Sun, Jul 02, 2023 at 05:33:56PM +0900, Akihiko Odaki wrote:
> The ARI next function number field is undefined for VF so the PF should
> end the linked list formed with the field by specifying 0.
> 
> Fixes: 3a977deebe ("Intrdocue igb device emulation")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>


I would also change it for the VF just so people don't wonder
what's the magic value. Do document in commit log though.

Maybe just drop this parameter from pcie_ari_init completely
for now?


> ---
>  hw/net/igb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index 1c989d7677..897386fc09 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -431,7 +431,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>          hw_error("Failed to initialize AER capability");
>      }
>  
> -    pcie_ari_init(pci_dev, 0x150, 1);
> +    pcie_ari_init(pci_dev, 0x150, 0);
>  
>      pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
>          IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
> -- 
> 2.41.0


