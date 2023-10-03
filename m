Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C462C7B6D67
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhbM-0005YE-QN; Tue, 03 Oct 2023 11:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhb5-0005UA-6W
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhb3-0004Ts-Mc
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696347965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vv9GYOpzOg7FIe/HIWXVGRyhM/DBclADdM9tLii0bKY=;
 b=NRuj9xulsSkPyb1FinRoZwyKAzhi0RBaSxi5vjIp/u/YieZ/vrIjVX3J/nsZ3w6Hg5xxL9
 bDDOFZ5yKT8fv1ZMvjmiBY9XtY/bU+qUg8SkkWMV2mVDrDc50zGefufdbsxkrOknEHBFT2
 y2XKfKV3naDJRkYixj1of2pyhPfDP70=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68--qsxyb0pMgWU0Xm15UgaQw-1; Tue, 03 Oct 2023 11:46:03 -0400
X-MC-Unique: -qsxyb0pMgWU0Xm15UgaQw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-418099ca1c2so11592011cf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696347963; x=1696952763;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vv9GYOpzOg7FIe/HIWXVGRyhM/DBclADdM9tLii0bKY=;
 b=pDjZsbi+T/2MZv0rhqrNzfVqXXmBkTlndIwy4NYreF/e360M1JxBA9NYsEtvIZkkW8
 XG39XMZCfM5GuAZOP+gJL5sfO+nSHoIqRApi7XUAF9RLEQwWatFvhCePI5i2zbouPffm
 reNkxcDFWSgsGkiZoYgw2SxDaRfBUdcOV5JkaluqpGSe0TcKLc8XN6iFuOtPE17fLBat
 V5eSaBKFy1C9gz7CYix9xRMZrWBw3t9c0A69dyUcidfHXVPd3NYy07eKsVPhrkkqrXhe
 bKnmw9IXTwhzkoH+ZSYh4BDio51QmpUknai38nrlvCyxoqT9uP3xQByoe6CMzw6VzgFE
 z4bw==
X-Gm-Message-State: AOJu0YzaR1Do9XPOOMNBr6BfrLW60nMfE/DtgKtMAGQbU5/8eQ1HJpjF
 lhT387t6cehYOLXSbKswFdn5Pnjcig9i1k2YqZNdKc82vC6qwOkjLgfHE6n8i48hM5X12N1OFq3
 aifNYrH7faXv/qZQ=
X-Received: by 2002:ac8:5acf:0:b0:417:b45b:84c3 with SMTP id
 d15-20020ac85acf000000b00417b45b84c3mr16385105qtd.65.1696347963453; 
 Tue, 03 Oct 2023 08:46:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrfIAEKbVl0FAh0MXcZDk7oOPSy1Dd9fGmL+Gn9mKFx+u3YRYYeKrDnEibXayDHd/DZnE3vw==
X-Received: by 2002:ac8:5acf:0:b0:417:b45b:84c3 with SMTP id
 d15-20020ac85acf000000b00417b45b84c3mr16385086qtd.65.1696347963213; 
 Tue, 03 Oct 2023 08:46:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 e23-20020ac845d7000000b004181234dd1dsm522664qto.96.2023.10.03.08.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 08:46:02 -0700 (PDT)
Message-ID: <36f1fb7c-aa46-e1c0-587a-07bb81412677@redhat.com>
Date: Tue, 3 Oct 2023 17:46:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 11/15] vfio/common: Move VFIO reset handler
 registration to a group agnostic function
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-12-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231003101530.288864-12-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 10/3/23 12:14, Eric Auger wrote:
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Move the reset handler registration/unregistration to a place that is not
> group specific. vfio_[get/put]_address_space are the best places for that
> purpose.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   hw/vfio/common.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 56cfe94d97..019da387d2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1909,6 +1909,10 @@ static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
>       space->as = as;
>       QLIST_INIT(&space->containers);
>   
> +    if (QLIST_EMPTY(&vfio_address_spaces)) {
> +        qemu_register_reset(vfio_reset_handler, NULL);
> +    }
> +
>       QLIST_INSERT_HEAD(&vfio_address_spaces, space, list);
>   
>       return space;
> @@ -1920,6 +1924,9 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
>           QLIST_REMOVE(space, list);
>           g_free(space);
>       }
> +    if (QLIST_EMPTY(&vfio_address_spaces)) {
> +        qemu_unregister_reset(vfio_reset_handler, NULL);
> +    }
>   }
>   
>   /*
> @@ -2385,10 +2392,6 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>           goto close_fd_exit;
>       }
>   
> -    if (QLIST_EMPTY(&vfio_group_list)) {
> -        qemu_register_reset(vfio_reset_handler, NULL);
> -    }
> -
>       QLIST_INSERT_HEAD(&vfio_group_list, group, next);
>   
>       return group;
> @@ -2417,10 +2420,6 @@ static void vfio_put_group(VFIOGroup *group)
>       trace_vfio_put_group(group->fd);
>       close(group->fd);
>       g_free(group);
> -
> -    if (QLIST_EMPTY(&vfio_group_list)) {
> -        qemu_unregister_reset(vfio_reset_handler, NULL);
> -    }
>   }
>   
>   struct vfio_device_info *vfio_get_device_info(int fd)


