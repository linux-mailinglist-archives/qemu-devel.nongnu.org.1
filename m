Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AD37427BC
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:53:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErME-0007H0-4k; Thu, 29 Jun 2023 09:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qErMC-0007GU-QY
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qErMA-0003GO-0e
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688043999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ad7JORx6ZlNYYhxhzdkRw41WBiZtCERiiuQIFpZ4mTI=;
 b=iSEPB1k8jIkUC+YoWLQ5xmYCATgHOX+F9uCyCck3wpG4y9R6gkFZfMV54ackk5LP5cYWab
 ElBcwyrBwc1ubd2dmFJcGePtElF5cLCTk6oiJHhS2XczBhrzNGYK/Ad68IuNCQ3rQt8lmh
 AlAHLyVJkasQERjmQDVdk9La+v8o9Ro=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-8g2cEJvSN3mXjJ5IrC_CWw-1; Thu, 29 Jun 2023 09:06:37 -0400
X-MC-Unique: 8g2cEJvSN3mXjJ5IrC_CWw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fa976b8b6fso3394975e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 06:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688043996; x=1690635996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ad7JORx6ZlNYYhxhzdkRw41WBiZtCERiiuQIFpZ4mTI=;
 b=bqvGljkPteZR1+aYu4TwNkgMZHW4P3VWB8xmwbXmNylIzIjVXKIkk0ATz7/EKvZ9dk
 /VdLDP7YB03Sv387Spr8iCQNkR2iEYw8cILrQRQWRola5Y0b+L6S6GK36UoKUIuaRPkS
 3Z0miN4NHCBMenx0NYdWWTKSDD1btzIczSw8c4e4/3QMkItvM6D8YumvPfnyp8aWv9bo
 pgV5ZHHKGeFV2auZmjteXR5kWeCjOWxjhFZklciMLYiIrohf779julObo+IaR1lCqODc
 VtQFMQpLjQFUa0YrBxt89m4UFIAXkbs8YpQ0U1IrWM8prRugMZ24GECrB9rQx6fwhaRP
 EM8g==
X-Gm-Message-State: AC+VfDx4bCzUlfOyug0J8hx34raS+kff41UzI6NuYyIVkspObm97LRhG
 u3swwehIzFg6NPm5yDteJGks3r6IVQVPtz/AedUlna6mga/QIxQfM9fho4LNYl1X4/YqEndKy5n
 7Rg6ch9D7pT9eDXk=
X-Received: by 2002:a05:600c:2054:b0:3fb:4041:fef5 with SMTP id
 p20-20020a05600c205400b003fb4041fef5mr7396192wmg.23.1688043996448; 
 Thu, 29 Jun 2023 06:06:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZM6eYNpeGEtt5X8PULOE/XNLpjZZAL+cmorgcfN7lNymSqHpkW+2+FYrhN1q7j1j7ih1gVw==
X-Received: by 2002:a05:600c:2054:b0:3fb:4041:fef5 with SMTP id
 p20-20020a05600c205400b003fb4041fef5mr7396177wmg.23.1688043996154; 
 Thu, 29 Jun 2023 06:06:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a7bc455000000b003fa95c466a1sm12007890wmi.5.2023.06.29.06.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 06:06:35 -0700 (PDT)
Message-ID: <a9b5ceb2-8f9d-ce07-b4fe-114658548a1e@redhat.com>
Date: Thu, 29 Jun 2023 15:06:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/5] vfio/pci: Fix a segfault in vfio_realize
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-2-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230629084042.86502-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/29/23 10:40, Zhenzhong Duan wrote:
> The kvm irqchip notifier is only registered if the device supports
> INTx, however it's unconditionally removed in vfio realize error
> path. If the assigned device does not support INTx, this will cause
> QEMU to crash when vfio realize fails. Change it to conditionally
> remove the notifier only if the notify hook is setup.
> 
> Before fix:
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,xres=1
> Connection closed by foreign host.
> 
> After fix:
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,xres=1
> Error: vfio 0000:81:11.1: xres and yres properties require display=on
> (qemu)
> 
> Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 73e19a04b2bf..48df517f79ee 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3221,7 +3221,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   
>   out_deregister:
>       pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> -    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +    if (vdev->irqchip_change_notifier.notify) {
> +        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +    }
>   out_teardown:
>       vfio_teardown_msi(vdev);
>       vfio_bars_exit(vdev);


