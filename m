Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D017AF108
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlB9U-0000fO-Fc; Tue, 26 Sep 2023 12:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qlB9Q-0000di-CI
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qlB9L-0002KH-8D
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695746580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCPqOmPuBVn5103KD3wD2dbbKaBzazQ3++6us2+GCRo=;
 b=ZAFWL7R8DFfhlf7l+XZSG2XK+G4+ADXpo8VCIM0WyvxtsJUjFjVEUOsn3gfNafYqdxD5kn
 ieDpvqKXMxl9LYq8Q9xH5y5+xkNS7YWnfDT0iFMEE2RO9tjeYtbwg6PETWLFC4cp6FeqwQ
 fuqtVVNoKwWwZAHnQjRhYMQHujLAgNg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-OemgLR_PPNy1m6r4-F2PVQ-1; Tue, 26 Sep 2023 12:42:59 -0400
X-MC-Unique: OemgLR_PPNy1m6r4-F2PVQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65b0af1b0e2so85372446d6.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695746579; x=1696351379;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rCPqOmPuBVn5103KD3wD2dbbKaBzazQ3++6us2+GCRo=;
 b=ec8MF9aNXnUOmdzSSYD8dfAsp6GmCFqLaXs88o+0j3cn2jK3CNbl/eBkThT2Lw+3Wz
 VhNSlihrnAUVcwlwhsaBiaTAfbt4baWfjMrATU/s3ZtVhlkW3maW2svGVdGZQnxC/uKT
 3nCzpktVHu6HHiY+HnyAVPELrzh/gc4ImOwY2CPSbg58H3fNrBqZXawGMyTpMnTd7CGl
 r2u/hudF6hwM/RNVCU+T34ONLWp0TSir5QcRP7eiBXkcam/B0rNe7aidR7/fh+/A/0k0
 Ase9k4vQ05kuoBYtD3FbBjTn0l0i38FhgBo4Jf/AnzbOqDtLJukr0AahJsILb3R2eGf1
 33nw==
X-Gm-Message-State: AOJu0YziVH1VSbJWy4D83VGQS1yOjL8Ya/DBz/GzF0N1OwWWGB4T9vIk
 gu8jUCT6PfAX64TWtgwjResu6ZzAJDAakAP9zzVb2MqTVIcPeF4w5s6iTHy0cLZFfhYPrlktxKi
 x0fRaprfM6Rrmbsw=
X-Received: by 2002:a05:6214:190f:b0:658:8f94:5921 with SMTP id
 er15-20020a056214190f00b006588f945921mr9279787qvb.59.1695746578904; 
 Tue, 26 Sep 2023 09:42:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwPSqq/JwmlD5nOwBRfraT+2YfGieKJkvPCuMgp2LkBArlOMfr0yibALra+jQH4uvhnUvkqA==
X-Received: by 2002:a05:6214:190f:b0:658:8f94:5921 with SMTP id
 er15-20020a056214190f00b006588f945921mr9279765qvb.59.1695746578624; 
 Tue, 26 Sep 2023 09:42:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 s21-20020a0cb315000000b0065afe8f149asm2681314qve.69.2023.09.26.09.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 09:42:58 -0700 (PDT)
Message-ID: <97a7e808-f5b8-b56f-bea3-2ddd01f74e5d@redhat.com>
Date: Tue, 26 Sep 2023 18:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 01/12] scripts/update-linux-headers: Add iommufd.h
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230926113255.1177834-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/26/23 13:32, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Update the script to import iommufd.h
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   scripts/update-linux-headers.sh | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 35a64bb501..34295c0fe5 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -161,7 +161,8 @@ done
>   rm -rf "$output/linux-headers/linux"
>   mkdir -p "$output/linux-headers/linux"
>   for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
> -              psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h vduse.h; do
> +              psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
> +              vduse.h iommufd.h; do
>       cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
>   done
>   


