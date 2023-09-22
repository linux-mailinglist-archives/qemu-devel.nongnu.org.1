Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4FF7AB3BD
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:35:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhFe-00057l-8O; Fri, 22 Sep 2023 10:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjhFF-000578-4y
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjhFD-0005O1-Mg
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695393297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bIdsgT1QYA3UMLVcdGTOHHI+qUwslHKYT6fB8m7ao2U=;
 b=FUtR6FxQxfYJAc6/AjhZdoFDhiX/6Ti2oruyKhJPvKM+pgjZSTkIG52Iv+sequSieWD3CB
 fTDX1zBreAn17WXhW7FNfok09jRRcS2wWo1PDnBO7ridDtIYgtL1O1t7W1cOB8/sCAOwsQ
 aeVRxE9zMEcTOGnUuaTvpkAA1dT/3O4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-vsZArzDdNyO9GK3yEq9KuA-1; Fri, 22 Sep 2023 10:34:56 -0400
X-MC-Unique: vsZArzDdNyO9GK3yEq9KuA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fd0fa4d08cso16445555e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 07:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695393295; x=1695998095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bIdsgT1QYA3UMLVcdGTOHHI+qUwslHKYT6fB8m7ao2U=;
 b=KowRjCbVOGAcoVTKtRLo5FHp+Y01DwVkvukV+aoILhF+UO1EQIp6v+3dKz6b54EEp7
 /mvX1c3wpaWlSRrYrqjQtws0l1ZOINbLOWqdThGF439zD9sxG9O3qr1PYKnrZe1hG19l
 XMd9gcpyq3Aqz3+noyRFdaip2E3VVTGhaeqxaIaQVuDCJYbX04TA4T9AfgZNT2kzn6eE
 cWuUbziv9/Qz3YdSCyuvqgey5TX/BDjZeXenrB5rod2EdVkcGq4EbFzaa97tyQrIoF56
 dum02eVxhukuxaU0SHcuD5/Yb3HxajnPYVjj72t/VmEyoWbGDWbL9RQiIe9JeXyebV75
 /fzg==
X-Gm-Message-State: AOJu0Yx2bfXvIrxVuQBb5nOGYfZsrj9pV8GtoviC1DrezSbd8OGggsFj
 S6CP0zVgN0nHqXRjibGaWQO3DzNpgnxxdYu/64CKcFOL218usxmdAyfyKiCrMF7Ywxe1gvIG/yR
 U+momDyCRPUB0t/s=
X-Received: by 2002:a05:600c:4fc4:b0:405:49aa:d578 with SMTP id
 o4-20020a05600c4fc400b0040549aad578mr221748wmq.37.1695393294954; 
 Fri, 22 Sep 2023 07:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8H8hpQGBxvs/GhhXk/hOv/b4Fn8jEue1ARm6U8fx2BiPHAXSU484/mBBOkD9PP4SPdFEsyQ==
X-Received: by 2002:a05:600c:4fc4:b0:405:49aa:d578 with SMTP id
 o4-20020a05600c4fc400b0040549aad578mr221732wmq.37.1695393294612; 
 Fri, 22 Sep 2023 07:34:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a05600c205600b003fbe4cecc3bsm7605002wmg.16.2023.09.22.07.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 07:34:53 -0700 (PDT)
Message-ID: <141f1a39-6d54-598e-b44a-a313ca7c2c2c@redhat.com>
Date: Fri, 22 Sep 2023 16:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] vfio/pci: rename vfio_put_device to vfio_pci_put_device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, chao.p.peng@intel.com
References: <20230922025223.1091821-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230922025223.1091821-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/22/23 04:52, Zhenzhong Duan wrote:
> vfio_put_device() is a VFIO PCI specific function, rename it with
> 'vfio_pci' prefix to avoid confusing.
> 
> No functional change.

There is more to be done but it can wait after the big code reshuffle.

> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Applied to vfio-next.

Thanks,

C.

> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3b2ca3c24ca2..b2d5010b9f0e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2826,7 +2826,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>       }
>   }
>   
> -static void vfio_put_device(VFIOPCIDevice *vdev)
> +static void vfio_pci_put_device(VFIOPCIDevice *vdev)
>   {
>       g_free(vdev->vbasedev.name);
>       g_free(vdev->msix);
> @@ -3317,7 +3317,7 @@ static void vfio_instance_finalize(Object *obj)
>        *
>        * g_free(vdev->igd_opregion);
>        */
> -    vfio_put_device(vdev);
> +    vfio_pci_put_device(vdev);
>       vfio_put_group(group);
>   }
>   


