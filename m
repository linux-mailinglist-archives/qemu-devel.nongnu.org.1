Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBF87EC35E
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 14:13:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3FgV-0003s1-6N; Wed, 15 Nov 2023 08:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3FgT-0003rj-IG
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:11:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3FgJ-0006oy-0a
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700053902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e+aw5JfAgMR6xh3nx4pBzvhq/hCbgWct40QfuFtvzCk=;
 b=D5mXnxp1AifniFX/VdJZ8svYz0uYGO9847VUBAZ3SvW+y5A2RBQ4CIhzvxddGGjviPzuQ8
 uJhjU000eYa43bSSJFW5OMR97RmVjmE5aB0jeLth40AyeuPXGFuQKwvGzxvyrAQYJqqUNP
 vM59o0ahmIVLpTStnZxpGb9IO8vaz/s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-jxT2eZqoNbWyVO5-ClC2nw-1; Wed, 15 Nov 2023 08:11:40 -0500
X-MC-Unique: jxT2eZqoNbWyVO5-ClC2nw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-778b25af933so831505585a.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 05:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700053900; x=1700658700;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+aw5JfAgMR6xh3nx4pBzvhq/hCbgWct40QfuFtvzCk=;
 b=gHnkgXUpwBIQz6lukoHclWtFR66e7XhSszRTwNirCI1HfHTm4rD59NlNUidnjyGDgG
 aH0rYbsYOiqDGK8nxXpel+PlcS0M5TxjoPrN4862TLdLC+OP8GSmAJ/CHwr5OjP77p9N
 YVeHMj3Rz9KcB0kbQXmktnwvJcHbrBAWqQaFBR9AelnjE1HdfoOa/ndXnr4CfzBSDrWW
 lKbQmmSJ1pokYJ5iHIWjwLgsRLRFlhXLELN8DsUApRXHg5+It72bgbsZ3klzOOMJ9867
 50am1It2I+hfmhHIGGnJKP2XNUdPwT6u0cb/WsY9d/BodeLSD6gYyctVlodL5qC1FgcC
 ijaw==
X-Gm-Message-State: AOJu0Yw9XhxkbC/s24RxUan63Df/h8vPGRKgVO1khV6dAlrd2/hmvHFd
 6NaKlWoHWi2nuKbPR4jaenfwowaJNJcO5AUN6pBZYxxX0HnKReIYRqZaJOpiaCiNXL13iJlb2WL
 JQ3k+ultL6Fy/5D0=
X-Received: by 2002:a05:620a:29cb:b0:777:326d:83de with SMTP id
 s11-20020a05620a29cb00b00777326d83demr5371349qkp.56.1700053900134; 
 Wed, 15 Nov 2023 05:11:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdhOc/fisBjXtbR9nw+LcN/5DI1IC1pj5BQsxW1wX+N9RZzpOmlqHkvb3YyBwNwpyjjHIr0g==
X-Received: by 2002:a05:620a:29cb:b0:777:326d:83de with SMTP id
 s11-20020a05620a29cb00b00777326d83demr5371333qkp.56.1700053899910; 
 Wed, 15 Nov 2023 05:11:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 az36-20020a05620a172400b0077580becd52sm3431461qkb.103.2023.11.15.05.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 05:11:39 -0800 (PST)
Message-ID: <fcf2c5ec-ca54-45c4-b6a6-4f302a6cddf7@redhat.com>
Date: Wed, 15 Nov 2023 14:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] vfio/pci: Move VFIODevice initializations in
 vfio_instance_init
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
 <20231115083218.1973627-2-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231115083218.1973627-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 11/15/23 09:32, Zhenzhong Duan wrote:
> Some of the VFIODevice initializations is in vfio_realize,
> move all of them in vfio_instance_init.
> 
> No functional change intended.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/pci.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index b23b492cce..5a2b7a2d6b 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2969,9 +2969,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       if (vfio_device_get_name(vbasedev, errp)) {
>           return;
>       }
> -    vbasedev->ops = &vfio_pci_ops;
> -    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
> -    vbasedev->dev = DEVICE(vdev);
>   
>       /*
>        * Mediated devices *might* operate compatibly with discarding of RAM, but
> @@ -3320,6 +3317,7 @@ static void vfio_instance_init(Object *obj)
>   {
>       PCIDevice *pci_dev = PCI_DEVICE(obj);
>       VFIOPCIDevice *vdev = VFIO_PCI(obj);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       device_add_bootindex_property(obj, &vdev->bootindex,
>                                     "bootindex", NULL,
> @@ -3328,7 +3326,11 @@ static void vfio_instance_init(Object *obj)
>       vdev->host.bus = ~0U;
>       vdev->host.slot = ~0U;
>       vdev->host.function = ~0U;
> -    vdev->vbasedev.fd = -1;
> +
> +    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
> +    vbasedev->ops = &vfio_pci_ops;
> +    vbasedev->dev = DEVICE(vdev);
> +    vbasedev->fd = -1;

VFIODevice is similar to a base QOM parent. Could we introduce an helper
routine like we did with vfio_device_set_fd() ?

Thanks,

C.

   
>       vdev->nv_gpudirect_clique = 0xFF;
>   


