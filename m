Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A11B705FC6
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 08:13:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzAOd-0001Yj-Vz; Wed, 17 May 2023 02:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1pzAO7-0001Wm-UG
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1pzAO5-0004xM-8z
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684303905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ywM94PkXtwqNvuIugFzts8OsQxGtnD65y6I0QXlk9g=;
 b=imZeOAfaxJnj59/e059FVbj8v/zKC5bxv4RC1f8NzV+wskjjpjDX+cK4Kd5vpNS6AW0waj
 7l6LLOjekEMmnj7yC+cZ1TILlz6ByRmN4WOlOWP1TulQ7gabMvnZ40hSq5Atk7Ygt7puEg
 /RYTVvjYu7HMzhNM+DHQXOgn00tCwSo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-R8toeKskOHCaT5SLJfNrIg-1; Wed, 17 May 2023 02:11:44 -0400
X-MC-Unique: R8toeKskOHCaT5SLJfNrIg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3093cb05431so227983f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 23:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684303903; x=1686895903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ywM94PkXtwqNvuIugFzts8OsQxGtnD65y6I0QXlk9g=;
 b=C23svpCvFx3WyM417McFhsWkBBnZZgGOxRf8torWZs9ei24YqzvRvHugl4/5LQDTCb
 DMH9tVX/e04pjv9LgvfW5Wteo4SdlHyXCt/x5GPbM7lrNOtictXsrObf+y+RpOJj744L
 pMOGzHPICPC4mB0jvWT2aCX19hJ/tnk373T+vPY0xmy6U8Ubbg7zVXlLzT6pLXbm4eXS
 Th8N5tCboBeifBY0pcomNtBjmhduZ+dxpE/RXRiaqiPPaNNkQTqOJNBSaaRaogLyk2JW
 AYuo1tsQCFih/6j0E8ZluI5/zK/McBs002TgvudiPudFYAeet7Ht6vIXpBDv3YC6J83x
 k1uQ==
X-Gm-Message-State: AC+VfDwTuJx+T9eeE2GpvzFUJd428iuEQtLlSc4/P/sNaak34NnoBnj5
 h7ZThLamObAizbGdO4XNIBAe/qN+vK8OdiW+6gRWaX2JGYcfZ8U2SqyQaawhxL5zpP6xYRsbx8H
 cV7iYB/n6EijU0RM=
X-Received: by 2002:adf:fc8c:0:b0:306:3204:3633 with SMTP id
 g12-20020adffc8c000000b0030632043633mr26883537wrr.22.1684303902937; 
 Tue, 16 May 2023 23:11:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pc3v712i/j3GEg/5Dr7WOiPJjDem5WrhiVq0wDIX37s5C7lTaSw6UsrcDONxpwX6HDw+pjw==
X-Received: by 2002:adf:fc8c:0:b0:306:3204:3633 with SMTP id
 g12-20020adffc8c000000b0030632043633mr26883521wrr.22.1684303902669; 
 Tue, 16 May 2023 23:11:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a5d4088000000b0030642f5da27sm1546824wrp.37.2023.05.16.23.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 23:11:42 -0700 (PDT)
Message-ID: <fc5ef659-ba8a-ca1c-1240-8c7d38a50de1@redhat.com>
Date: Wed, 17 May 2023 08:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] vfio/pci: Fix a use-after-free issue
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: minwoo.im@samsung.com, alex.williamson@redhat.com, chao.p.peng@intel.com
References: <20230517024651.82248-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230517024651.82248-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.666, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/17/23 04:46, Zhenzhong Duan wrote:
> vbasedev->name is freed wrongly which leads to garbage VFIO trace log.
> Fix it by allocating a dup of vbasedev->name and then free the dup.
> 
> Fixes: 2dca1b37a7 ("vfio/pci: add support for VF token")
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
> v2: "toke" -> "token", Cedric
>      Update with Alex suggested change
> 
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index bf27a3990564..73874a94de12 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2994,7 +2994,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           qemu_uuid_unparse(&vdev->vf_token, uuid);
>           name = g_strdup_printf("%s vf_token=%s", vbasedev->name, uuid);
>       } else {
> -        name = vbasedev->name;
> +        name = g_strdup(vbasedev->name);
>       }
>   
>       ret = vfio_get_device(group, name, vbasedev, errp);


