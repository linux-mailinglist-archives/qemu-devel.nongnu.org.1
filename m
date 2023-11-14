Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5001E7EB0E6
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 14:30:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2tUD-00047y-FA; Tue, 14 Nov 2023 08:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2tUB-00047g-Dm
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:29:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2tU9-00023M-V8
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699968585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sg9vOjKVKslpSAjyLI94XWKN0La+Em43qGmQVe/sgfQ=;
 b=JimcaPJfjr52KfNObsKKCaMr/r4I5p0wn3WraH8fRcb4294u6hceIRuFA7PFBtJi0IHvpL
 58YjglaN4Z0+cM1MGqxdDH7sQLUYUFNNetGbBPJX2lKU3HTTHrLqFqiE/k6oiF29FkNjmR
 Fe8ENdo3bsn7BPwsGWrsO5VqT4BJ8g0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-WvzvQds9MqOZV345lxNPXQ-1; Tue, 14 Nov 2023 08:29:44 -0500
X-MC-Unique: WvzvQds9MqOZV345lxNPXQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41ea8e21785so97034491cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 05:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699968583; x=1700573383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sg9vOjKVKslpSAjyLI94XWKN0La+Em43qGmQVe/sgfQ=;
 b=gvWJn8O63h27xDhuWDdpP2Bd0QGyOHVBJYbLKznyITt8fkaFJFPAS2xdki7wQM/+P4
 Yk9MZlrgwzaKSqlvjjbX+netQgYzUOxbTtlVNBSDN/pIH6R/cImqJDYxHY5CKSO2QbMw
 TGrtdJMYFXm8L5MtiFBHFJGOa7PVJMwx7Nfanb1IWDitHNGyHj4geVd0vOahF4uZuoff
 V3TXa/Y2IA2T0lpm3HJArnaspIKjCWQwMBEXgISZsWmw0yn1pjPHF+UIMen7KfeERFIk
 VYtpDQoWD69Ki11rFgxrzgspwBBN/gkGWhBq2l4LogC6m+xyaXqjlimX+6uG46Hmy251
 0aSA==
X-Gm-Message-State: AOJu0Yy/lBQuNkVkIOE66+7OaapOTcutSVgH5Yp96eEfuYJR21vIy6+F
 FH7r3SwxUR4e1vKOsVipV5wKgvkt83LWjWxAcUZNior3p3TA0CCF8mPeeyb+x/jCziYsOfj8i3O
 TKw1Hu7IQOS34JKQ=
X-Received: by 2002:a05:622a:288:b0:3f9:d1c3:cc45 with SMTP id
 z8-20020a05622a028800b003f9d1c3cc45mr3347822qtw.28.1699968583607; 
 Tue, 14 Nov 2023 05:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXIMpFtz0WFBFcCi2xmPJXq5IXVhkwLh/8ULI0fC4DD48QeYyWqfdMDFG5AQlzjtxoB2GPqg==
X-Received: by 2002:a05:622a:288:b0:3f9:d1c3:cc45 with SMTP id
 z8-20020a05622a028800b003f9d1c3cc45mr3347795qtw.28.1699968583356; 
 Tue, 14 Nov 2023 05:29:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d15-20020ac8544f000000b0041cf5ec8b75sm2720761qtq.96.2023.11.14.05.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 05:29:43 -0800 (PST)
Message-ID: <18c7eb32-a67b-412e-8d0d-9bdc98d0cbf8@redhat.com>
Date: Tue, 14 Nov 2023 14:29:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/21] vfio/common: return early if space isn't empty
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-4-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-4-zhenzhong.duan@intel.com>
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

On 11/14/23 11:09, Zhenzhong Duan wrote:
> This is a trivial optimization. If there is active container in space,
> vfio_reset_handler will never be unregistered. So revert the check of
> space->containers and return early.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/common.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 572ae7c934..934f4f5446 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1462,10 +1462,13 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
>   
>   void vfio_put_address_space(VFIOAddressSpace *space)
>   {
> -    if (QLIST_EMPTY(&space->containers)) {
> -        QLIST_REMOVE(space, list);
> -        g_free(space);
> +    if (!QLIST_EMPTY(&space->containers)) {
> +        return;
>       }
> +
> +    QLIST_REMOVE(space, list);
> +    g_free(space);
> +
>       if (QLIST_EMPTY(&vfio_address_spaces)) {
>           qemu_unregister_reset(vfio_reset_handler, NULL);
>       }


