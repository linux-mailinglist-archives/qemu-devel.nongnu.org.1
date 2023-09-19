Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3430A7A688F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:04:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qidAQ-0002Yz-S0; Tue, 19 Sep 2023 12:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qidAN-0002WJ-4E
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qidAL-00025N-C9
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695139292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9WJ8C3KLxKHnWRQS4tww0mm1JKkwcqJtyeAWwsBUgVg=;
 b=ZMpLn764qoyscN1UGLVe9JdFQ1qFZpGpCxhlaV1Zmr/UyIulYE3b0gUyoS8NULkYGoMEAn
 c8Lp4RwJy13jT+1K8jLJrwVFsEwydwfS2xEjGYIVkrkw7PSNc503ye892xp8CRbdaWNkf8
 1nLaBK0MjiEBGmwu7z0DbhgDh+5NRIw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Yl5Lnr8SPeCbQaYxIguM1w-1; Tue, 19 Sep 2023 12:01:30 -0400
X-MC-Unique: Yl5Lnr8SPeCbQaYxIguM1w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-404fa5c1d99so23427935e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 09:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695139289; x=1695744089;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9WJ8C3KLxKHnWRQS4tww0mm1JKkwcqJtyeAWwsBUgVg=;
 b=nIlyMzmtQqAAuTq4Yn1dNdZUz8ok3Vdrc+Eg6f5Xi+jhV4XX0vbzip5px6cDgSAujP
 xHlpryu9XKkiuRQ76OozC5e+4nMdL23ua3yk1FHJamtxi7tQDkj0fv0iAd131KALSMcw
 Ene3akrS2x98VoTe4luPUV9yJ1tiUTQg7YmlE1Kmgp1IO1IJFt9NMOl/JHsaxpYbfXD/
 /gwgXZnk4kAelJZSYVgDLT5ntQZHKo20FiN5RLwbrqhjmCPKmUJhI5MBHOJermA49DKy
 PUAckztDM3oPtCCNw8g98N8NXZnuNIXrrSjSP293hPpghbKUGNNUTEBKczsnCffkk1vJ
 f3hA==
X-Gm-Message-State: AOJu0Yy+pzdkwkRofmq5shqqyJa7DHN38OYUCxegbat48SOTOZoQE47O
 kJGC6XMvF+jzq7pI9rdfI1iAsF41E5yGEaH3btVWzPjPgPpOi5FsTj+J4d6kQYLi6wk3MWqkvEk
 sfzkzrfqxB/vjaUw=
X-Received: by 2002:a05:600c:2110:b0:401:b6f6:d90c with SMTP id
 u16-20020a05600c211000b00401b6f6d90cmr147122wml.35.1695139289790; 
 Tue, 19 Sep 2023 09:01:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVqjLhqsHmt0f19gIXzRJyMoesCBpnekaoZT48SbLZbO1jHI1o4IoS/WkmRrAjhGoTRs+xxA==
X-Received: by 2002:a05:600c:2110:b0:401:b6f6:d90c with SMTP id
 u16-20020a05600c211000b00401b6f6d90cmr147097wml.35.1695139289443; 
 Tue, 19 Sep 2023 09:01:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a05600c1d1400b004051d5b2cf1sm842786wms.12.2023.09.19.09.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 09:01:28 -0700 (PDT)
Message-ID: <3dec9822-a884-af13-d8ce-1facbbaf6886@redhat.com>
Date: Tue, 19 Sep 2023 18:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 14/22] vfio/common: Simplify vfio_viommu_preset()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-15-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230830103754.36461-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 8/30/23 12:37, Zhenzhong Duan wrote:
> Commit "vfio/container-base: Introduce [attach/detach]_device container callbacks"
> add support to link to address space, we can utilize it to simplify
> vfio_viommu_preset().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

This looks like a revert of patch 07. Can it be avoided in v2 ?

Thanks,

C.

> ---
>   hw/vfio/common.c | 17 +----------------
>   1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 86b6af5740..6c3e98d5fd 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -165,22 +165,7 @@ void vfio_unblock_multiple_devices_migration(void)
>   
>   bool vfio_viommu_preset(VFIODevice *vbasedev)
>   {
> -    VFIOAddressSpace *space;
> -    VFIOContainer *container;
> -    VFIODevice *tmp_dev;
> -
> -    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> -        QLIST_FOREACH(container, &space->containers, next) {
> -            tmp_dev = NULL;
> -            while ((tmp_dev = vfio_container_dev_iter_next(container,
> -                                                           tmp_dev))) {
> -                if (vbasedev == tmp_dev) {
> -                    return space->as != &address_space_memory;
> -                }
> -            }
> -        }
> -    }
> -    g_assert_not_reached();
> +    return vbasedev->container->space->as != &address_space_memory;
>   }
>   
>   static void vfio_set_migration_error(int err)


