Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D37D9DC5
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 18:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPMg-0002FH-BN; Fri, 27 Oct 2023 12:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwPMY-0002F5-4c
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwPMV-0006f1-RC
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nSRXS0x85/cHJydcxSQrR+/OlDbWP4rqLdavrM+Q1oQ=;
 b=eXyS88/VHo/koOQSBzPtjeOk4OlDN8eQQheMPNHVn8Bar0yFi9gNH8oOHrob4MbDoeHJ0D
 5lpCLsgaQGFVwpLWcqGobFub6uqyl9IpJYpogTEVlN0euEdD+GiexhyfRuUWlGOtCArEqi
 cQdIdyBciN4eQfQcTSTnZDj1Ad195qg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-QyatkoiaMVSahGbdeIdmWA-1; Fri, 27 Oct 2023 12:07:01 -0400
X-MC-Unique: QyatkoiaMVSahGbdeIdmWA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7789f06778aso476488185a.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 09:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698422821; x=1699027621;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nSRXS0x85/cHJydcxSQrR+/OlDbWP4rqLdavrM+Q1oQ=;
 b=Cb8NaBWRhVDMZuQMu6K3jxeZ8LjFEn6vSegUZRACHDXLFKReZde75IfBJmY640edNW
 /IVq88EkTwAv940UlRi4WeE3f9IrWjOZtA3yo2S76cDb5/3oV48VitALSpiU9zK7r3sZ
 D8OgurSjz0qBpC/NgbjdEjLQudn9MgDFxmgSZY/+MQb0c1Y1dBSN26I/N+hhW3s0hfLM
 8advc00ENQqnoyBs19hN/vw8UhuWNgQo2ieg0ivlUdDFHDbbig1FOu1z3G0Da7Uv0p/P
 m3VL72wwI2BqvxeF0n0S80jNU5UZsRD2ThtjbFKPtQLJooRJp9kwF0g1JPyCYRHN11zg
 FdYQ==
X-Gm-Message-State: AOJu0YyVG7K6M6LJRRTVbgLo7XBswVFIbJ5os+XqdxhrtV2cJMLwFGnz
 dtpb8pNp1tNlsLofX1zgBKRq2SZzarft9H+6eOiKqajypnU27pLuWx7aQPM8rlhha7XigRdxGI8
 ExGVKNPGpiyLqzmQ=
X-Received: by 2002:a05:620a:3954:b0:779:ef44:4e8b with SMTP id
 qs20-20020a05620a395400b00779ef444e8bmr4235918qkn.30.1698422820743; 
 Fri, 27 Oct 2023 09:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm07rL2h46JFst4fzow9VyUKlxg9FqIIrJLne2l6rWbasZtxOpS4PHK1NNCgakzQlsTWXAlQ==
X-Received: by 2002:a05:620a:3954:b0:779:ef44:4e8b with SMTP id
 qs20-20020a05620a395400b00779ef444e8bmr4235883qkn.30.1698422820489; 
 Fri, 27 Oct 2023 09:07:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 y27-20020a05620a09db00b007742ad3047asm651072qky.54.2023.10.27.09.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 09:07:00 -0700 (PDT)
Message-ID: <1edb9511-da25-4582-bf9f-b28aad5fc8cf@redhat.com>
Date: Fri, 27 Oct 2023 18:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v3 18/37] vfio/container: Implement attach/detach_device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-19-zhenzhong.duan@intel.com>
Content-Language: en-US
In-Reply-To: <20231026103104.1686921-19-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sorry, previous email was empty. Friday effect !

On 10/26/23 12:30, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> No fucntional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/common.c    | 16 ++++++++++++++++
>   hw/vfio/container.c | 12 +++++-------
>   2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index d62c815d7f..64565b4ae9 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1500,3 +1500,19 @@ retry:
>   
>       return info;
>   }
> +
> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
> +                       AddressSpace *as, Error **errp)
> +{
> +    const VFIOIOMMUOps *ops = &vfio_legacy_ops;

hmm, this looks wrong. please explain.

Thanks,

C.

> +
> +    return ops->attach_device(name, vbasedev, as, errp);
> +}
> +
> +void vfio_detach_device(VFIODevice *vbasedev)
> +{
> +    if (!vbasedev->bcontainer) {
> +        return;
> +    }
> +    vbasedev->bcontainer->ops->detach_device(vbasedev);
> +}
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 36c34683ad..c8ff0f2037 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -874,8 +874,8 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>    * @name and @vbasedev->name are likely to be different depending
>    * on the type of the device, hence the need for passing @name
>    */
> -int vfio_attach_device(char *name, VFIODevice *vbasedev,
> -                       AddressSpace *as, Error **errp)
> +static int vfio_legacy_attach_device(char *name, VFIODevice *vbasedev,
> +                                     AddressSpace *as, Error **errp)
>   {
>       int groupid = vfio_device_groupid(vbasedev, errp);
>       VFIODevice *vbasedev_iter;
> @@ -915,14 +915,10 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>       return ret;
>   }
>   
> -void vfio_detach_device(VFIODevice *vbasedev)
> +static void vfio_legacy_detach_device(VFIODevice *vbasedev)
>   {
>       VFIOGroup *group = vbasedev->group;
>   
> -    if (!vbasedev->bcontainer) {
> -        return;
> -    }
> -
>       QLIST_REMOVE(vbasedev, global_next);
>       QLIST_REMOVE(vbasedev, container_next);
>       vbasedev->bcontainer = NULL;
> @@ -934,6 +930,8 @@ void vfio_detach_device(VFIODevice *vbasedev)
>   const VFIOIOMMUOps vfio_legacy_ops = {
>       .dma_map = vfio_legacy_dma_map,
>       .dma_unmap = vfio_legacy_dma_unmap,
> +    .attach_device = vfio_legacy_attach_device,
> +    .detach_device = vfio_legacy_detach_device,
>       .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
>       .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
>   };


