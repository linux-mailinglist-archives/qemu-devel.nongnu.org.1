Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFAE7D9DC0
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 18:04:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPK8-00007y-Fp; Fri, 27 Oct 2023 12:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwPJu-00007m-07
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwPJs-0005vZ-85
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+JSZN+POuvrA2hVNYGbmPWPBfpFBODVF/tZjeO/Lgg=;
 b=b+C9Q1B8nR9HXg+UNoVfo9I5ftLa1mbgc3MkaBD4Jpv0UFbI6ip7EMa0MasdfdrAe1Gt4J
 ElUFD4FeGQfWnn8OotZKB13qAdQTDSO9YFw1xPXgZN6ZW8g1vh76K9289te0ObGyFfZv+Z
 8imob8izKSlTPIpneOphVqf9VVfGpJA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-LXBX0LjYMi2bfJ0c7gs0Kw-1; Fri, 27 Oct 2023 12:04:17 -0400
X-MC-Unique: LXBX0LjYMi2bfJ0c7gs0Kw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41cba27f8b2so26719221cf.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 09:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698422657; x=1699027457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h+JSZN+POuvrA2hVNYGbmPWPBfpFBODVF/tZjeO/Lgg=;
 b=vWXxNuuoTy8+E1Ewyiy3j7Q3dYmYfn8TNMWoKulT6JrKPM7LYyPM053jgzlqX9fnDo
 imCO+dUKpLdZP//Sl0S7bHELRteeJ24DQtmNQ15Tj5idAoIBFcRmXb//vySsWXI+e4I5
 q/oMGJBngU1gvi4F8lmgoCk2nqv7ZZgodZjDcr+APOporjXIqq9NfK79bMs1c1k1dy/Y
 T7RsTNsIgLb/pBViccljzvE2HI3IuqeLJNQQDDyN11TfE+fneGqZOoZffrmU2S1sVE/i
 CR5u1i6D5LOXQju7JU8geu2sQfKNp51YMBktaHeaRUYENdNhYPHHzBsYO03yzriCiv90
 qyzA==
X-Gm-Message-State: AOJu0Yy02ZTXcI2gLbjukeK3mDKc/e9dURbK+pGrY6VjIs/PDgTe+i/U
 Rgq5fPG55smP+ZgwmtRzb5vrujl854ahDhZNo5PRXVX7wBH/3Gf+oAvMB12Zf5bI9w27KcRvoa8
 ts3WXAw0gX9zh+Pk=
X-Received: by 2002:ac8:7f4f:0:b0:41c:bc52:69a5 with SMTP id
 g15-20020ac87f4f000000b0041cbc5269a5mr3484252qtk.28.1698422657072; 
 Fri, 27 Oct 2023 09:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/9tjzflgx7zwyfgWw49x7PSozW56zLqOCFuil71DhtOC0V9yxSjCEjb3xLIncHuk34Jfb7A==
X-Received: by 2002:ac8:7f4f:0:b0:41c:bc52:69a5 with SMTP id
 g15-20020ac87f4f000000b0041cbc5269a5mr3484176qtk.28.1698422656265; 
 Fri, 27 Oct 2023 09:04:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 f8-20020ac81348000000b00419b5274381sm677366qtj.94.2023.10.27.09.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 09:04:15 -0700 (PDT)
Message-ID: <05600dcd-e82f-4fc7-adc4-aa325f9e5485@redhat.com>
Date: Fri, 27 Oct 2023 18:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/37] vfio/container: Implement attach/detach_device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-19-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-19-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


