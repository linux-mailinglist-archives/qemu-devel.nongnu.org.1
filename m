Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E76947B6AEA
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 15:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnfnM-0001Uu-14; Tue, 03 Oct 2023 09:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnfnG-0001UP-KC
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnfnF-00086X-6k
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696341030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=msq1sFohloqsJV8+aYU6w74LtuW7E4SdfRyLZcGQfxo=;
 b=f9xrRF4nKQgBHimYRBmdDJwftlx15nvCI6+Sp7f+pkQhURASdcALWU2I3exkeAI4/FoU9X
 qwswaw2PLO1pjy5hOkRAQtbavRETeULxJrvr2FxSj7+ZhIBvgBVBSN3Qr+1kpAt0tyoOUp
 6DROB8I9mpmt2pEWq0kon1N1nBdnmOk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-nRpSBb_pPv223VPAYiI35Q-1; Tue, 03 Oct 2023 09:50:19 -0400
X-MC-Unique: nRpSBb_pPv223VPAYiI35Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-668ed90e5f6so11020636d6.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 06:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696341019; x=1696945819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=msq1sFohloqsJV8+aYU6w74LtuW7E4SdfRyLZcGQfxo=;
 b=KBbum3hFSqcxo0QWKVcCDvP5Gy29sWzd/WZFkvdMpz5F7qoZlOCyNMsF0aoUWLcznp
 nzOZlEiOD08IYGZrK70pgqss+qaOJH2W6P2xP4JHV0z2hA/sbejnI0r7v9bTX12SSs3E
 VG2zLbtnlzhlrmL50gxDDJgdebdCnodcZqI/+Y/Gp6LkrWkNc2LFzoLDwsLS8z4k4/Cd
 DkWheA33dLq9KF2wkAc5K+bwIoCQsEMKx0bFGkvscX+SICO1igC3+Ux3mB8KJQnSGV7W
 TIfxpZT0CUkjc8h5j/6H/e76lTrJyDwVtKwNSR71wukXTQNc0pmsExQtO1bjiD5j4LMX
 ZR+A==
X-Gm-Message-State: AOJu0YwDuOoTu3Y8PdM5aMyUj+0EDCy5/HmRsmvCmn+m1nvfKxhUTEQn
 SiIzsV1MF1RayBfOZQ8H7P1Yzz+QowEilPC0SOyu4/Y2lfbXMa+PF2pajuCORjoi8T4wbqYe/+C
 lPzUBDjIYQdLqSTk=
X-Received: by 2002:a0c:f944:0:b0:657:3e7a:917a with SMTP id
 i4-20020a0cf944000000b006573e7a917amr14922926qvo.2.1696341018909; 
 Tue, 03 Oct 2023 06:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6aZWcKsGNlBLiyTRMWDTqCPb2Aij4urQs6IbSvMBIF6zPjIv/oCUwJQR/RI8S/OU8ohxdiQ==
X-Received: by 2002:a0c:f944:0:b0:657:3e7a:917a with SMTP id
 i4-20020a0cf944000000b006573e7a917amr14922906qvo.2.1696341018471; 
 Tue, 03 Oct 2023 06:50:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a0cb292000000b006560eea8a7esm491164qve.132.2023.10.03.06.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 06:50:18 -0700 (PDT)
Message-ID: <585e22ab-fca2-004c-dd99-524cb747a1b3@redhat.com>
Date: Tue, 3 Oct 2023 15:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 01/15] scripts/update-linux-headers: Add iommufd.h
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-2-eric.auger@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231003101530.288864-2-eric.auger@redhat.com>
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

On 10/3/23 12:13, Eric Auger wrote:
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


