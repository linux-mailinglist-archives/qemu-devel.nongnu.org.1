Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C40337EC42F
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 14:57:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3GNL-0001iv-Gu; Wed, 15 Nov 2023 08:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3GNJ-0001ij-03
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3GNH-0001CK-CR
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700056570;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9SDQmL/iJb3hBS8oJk89gKl54Ke2Jtw0efKH55fadE4=;
 b=Kiydce5My4vkzBr5+lChwjQdA3p4uew0BP90SX0BaQhpndpu3SbVE/qfE7n/K+GpBNOv4I
 4b1k6W9Ymv5p8orWeUzpeBQZkGxPMB7SMWiHu/eHji8MPIamJSwrLaY4OQnR0laQqbWGsn
 sHuWjOB7sIXAATyPQeoSrB232dhnP10=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-tCLsK6J2OYGL9Kk_Fnojlg-1; Wed, 15 Nov 2023 08:56:09 -0500
X-MC-Unique: tCLsK6J2OYGL9Kk_Fnojlg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5afbcffe454so144654217b3.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 05:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700056568; x=1700661368;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9SDQmL/iJb3hBS8oJk89gKl54Ke2Jtw0efKH55fadE4=;
 b=X1t177qcfLrkpJwmQsjSWOTlpWYAVXNZ+gXDdC/rN2xHWtHwt/QrrEKfz5lTTIHGRY
 5LS/4ykMbZVhSrHBY2hFoll5X2yf14zOsSHEkM2aaUHP9y5Sv7+kDkVo3h1hyIDyyvZb
 NNxtnApp1ToF4HyhC99UZaue0jYsPAED2rGtseZUpV1SrbZ80I7S4NhNBvnMFRDAjW4Q
 rCTS8twc3WjEArcVHgU629YumQ7uS8/x4DSdIGHSYRbW2/0kt7GD1WWnfVymNwgQgavj
 4/ZB41G927sF/n9if27K2dUHBHZ8HCLPBpFo1yDWwoNiyNuV/BweqOk2mkzvM6EZCO6Q
 TX6g==
X-Gm-Message-State: AOJu0YyGTNBFgWKoVVwe/dZaE3LjTCBfXUclAXQRcK2Kj5w13HDI8sqU
 9SxdDCFsy3E0sg2HFNH1mDc4QsTQ1Lv8eBGbTO/jM+QldCtiARzBCy7EuLPIxAzDH3zZ5j0YzsY
 kaaB0epqMOFai1v0=
X-Received: by 2002:a25:e613:0:b0:da3:9565:637d with SMTP id
 d19-20020a25e613000000b00da39565637dmr11581392ybh.9.1700056568528; 
 Wed, 15 Nov 2023 05:56:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcJEPZ+f4vowu3Yk09uDaSII3kQJ4uvN26cFv6bGn14YX2GaPXWTQQFQ7G+n1jfVvG79Hpqw==
X-Received: by 2002:a25:e613:0:b0:da3:9565:637d with SMTP id
 d19-20020a25e613000000b00da39565637dmr11581380ybh.9.1700056568272; 
 Wed, 15 Nov 2023 05:56:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b00656e2464719sm552132qvl.92.2023.11.15.05.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 05:56:07 -0800 (PST)
Message-ID: <cf6bbf4e-b0e9-457a-a54f-ee669b93bd9e@redhat.com>
Date: Wed, 15 Nov 2023 14:56:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/21] vfio/iommufd: Relax assert check for iommufd
 backend
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-6-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231114100955.1961974-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 11/14/23 11:09, Zhenzhong Duan wrote:
> Currently iommufd doesn't support dirty page sync yet,
> but it will not block us doing live migration if VFIO
> migration is force enabled.
>
> So in this case we allow set_dirty_page_tracking to be NULL.
> Note we don't need same change for query_dirty_bitmap because
> when dirty page sync isn't supported, query_dirty_bitmap will
> never be called.
>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric
> ---
>  hw/vfio/container-base.c | 4 ++++
>  hw/vfio/container.c      | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 71f7274973..eee2dcfe76 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -55,6 +55,10 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>  int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                             bool start)
>  {
> +    if (!bcontainer->dirty_pages_supported) {
> +        return 0;
> +    }
> +
>      g_assert(bcontainer->ops->set_dirty_page_tracking);
>      return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
>  }
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 6bacf38222..ed2d721b2b 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -216,10 +216,6 @@ static int vfio_legacy_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>          .argsz = sizeof(dirty),
>      };
>  
> -    if (!bcontainer->dirty_pages_supported) {
> -        return 0;
> -    }
> -
>      if (start) {
>          dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_START;
>      } else {


