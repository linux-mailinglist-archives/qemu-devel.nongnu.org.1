Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BD77A8287
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 15:02:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwpF-0002PJ-Tz; Wed, 20 Sep 2023 09:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qiwp9-0002Lf-3k
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qiwp7-00070x-4w
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695214840;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycD+P7aPlreOZTI4oSACwPU0pjTfio4b4TUvVsG7VlA=;
 b=cYMMYvVj/y/C/pci3oJbN0ludzYHKgL1ttwXWvu2mNciEwjGmqjSFrt2N2AUoK9l0YMmSr
 TBBnGx0V/7z8q7UH1VU8n2WClt1nuGlpcb51YjaM1cOUlurHyPNzwq054t9IUGv6Z9bVMq
 KNp8cqNQAKZICYXcctCO5PKpnyChZZw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-Xi0HtI_JOsSi1Tm-paVZeQ-1; Wed, 20 Sep 2023 09:00:37 -0400
X-MC-Unique: Xi0HtI_JOsSi1Tm-paVZeQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31f79595669so380724f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 06:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695214836; x=1695819636;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ycD+P7aPlreOZTI4oSACwPU0pjTfio4b4TUvVsG7VlA=;
 b=ipuUE0vGuUlsSQikqsETTzJO0mxeZx/0l4cA4AK2Xj3I8hDcZxmlySZEuDPqfldfFq
 lewrwQnsyYoJfyInFcjDtlgPq/36oGUg2eL0Pf3rd8q02K2GKa5/BVREs1+q4Ampbifv
 GzeXDwLi2jKxmkSO+7QOlqm87289w9s62EGFqeuEipL7PrDaPZPMeCcs+TvlG7JV1ujH
 24SGcDsROvLM6ftrtDBA8VBPJTt9ICgs9Klr8Jp0JZi+a+nIkWCUXFpcuZ9GGi2FfDHZ
 ceAtBWMVrHCIgAqGAB5YfF9hp65dCvpnU84fwdI6vnsQSOEpy4kraSiiwOW4kjUdEIze
 96sw==
X-Gm-Message-State: AOJu0YzMYQb11eekFdev0p2KXgFKt1/yY97NDMtfRaYqfGMODgL3swrd
 KWvg5JEdOrYpLVI4B8KNhMgNfr6O5hJxAUyBI5xg9rD88IkfHH2qy2bpUp1DkXKx/9x1fh8brwb
 lHkV1wQlKJWBNZ7s=
X-Received: by 2002:adf:ec04:0:b0:317:6734:c2ae with SMTP id
 x4-20020adfec04000000b003176734c2aemr4468043wrn.11.1695214836284; 
 Wed, 20 Sep 2023 06:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1XEIr5Mfvw1kQjMo3Lzjj2+a7ShwhLVy/gskfYxH7lo5FnlP4H8HkgFuu+RoIHeS+C9+FIQ==
X-Received: by 2002:adf:ec04:0:b0:317:6734:c2ae with SMTP id
 x4-20020adfec04000000b003176734c2aemr4468006wrn.11.1695214835719; 
 Wed, 20 Sep 2023 06:00:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 e30-20020a5d595e000000b0031fbbe347ebsm18309500wri.22.2023.09.20.06.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 06:00:34 -0700 (PDT)
Message-ID: <768ee6c3-8278-53e8-aa31-ee3fa11399cc@redhat.com>
Date: Wed, 20 Sep 2023 15:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 07/22] vfio/common: Refactor vfio_viommu_preset() to be
 group agnostic
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-8-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230830103754.36461-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 8/30/23 12:37, Zhenzhong Duan wrote:
> So that it doesn't need to be moved into container.c as done
> in following patch.
This is a bit weird to refer to container.c which is not yet created. I
would suggested just reuse the commit title as a commit msg + this will
become easier to handle multiple IOMMU BEs

Eric
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/common.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 51c6e7598e..fda5fc87b9 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -219,7 +219,22 @@ void vfio_unblock_multiple_devices_migration(void)
>  
>  bool vfio_viommu_preset(VFIODevice *vbasedev)
>  {
> -    return vbasedev->group->container->space->as != &address_space_memory;
> +    VFIOAddressSpace *space;
> +    VFIOContainer *container;
> +    VFIODevice *tmp_dev;
> +
> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> +        QLIST_FOREACH(container, &space->containers, next) {
> +            tmp_dev = NULL;
> +            while ((tmp_dev = vfio_container_dev_iter_next(container,
> +                                                           tmp_dev))) {
> +                if (vbasedev == tmp_dev) {
> +                    return space->as != &address_space_memory;
> +                }
> +            }
> +        }
> +    }
> +    g_assert_not_reached();
>  }
>  
>  static void vfio_set_migration_error(int err)


