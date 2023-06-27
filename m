Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D81273FBEA
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7hx-0001BT-Ad; Tue, 27 Jun 2023 08:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qE7ht-0001BA-Fq
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qE7hr-0003l7-Fz
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687868521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOeq/UKLlmfmzT8sRzR0lCrWNwu/ZYRGbGfjlJc328o=;
 b=U8pd34YQo2nFDsGedxQ081or1eeIKJJKwJZOLI1SBds7a5OVEIF/vrhtWIQd/qPOuvZL4t
 WnjxeThJ4mqCjgb6bSz+fSTHVavEngcgiRNCxzIFXRWzdxpwsUZtJWDJuv71nalxBcraNP
 S2NFd9moevd0NESMz92UWDoelIMYl/Q=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-jaMbhp8ROjmOTPXv8btGiw-1; Tue, 27 Jun 2023 08:22:00 -0400
X-MC-Unique: jaMbhp8ROjmOTPXv8btGiw-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-78f1e2e7f7aso667419241.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687868519; x=1690460519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tOeq/UKLlmfmzT8sRzR0lCrWNwu/ZYRGbGfjlJc328o=;
 b=WxY9qLVZdx4Bm0wtBrtgfoDxY/04N+zRKoKxLzqd3mCJfsLt+whTkGIDSX65xgIRUV
 +nrJfT3HBp9UJ77WGx9gyhwaYoZ5wlrO3ItmHZGjPIGJ2F5FekeCA51u3QcjQhZYj7ik
 sczt6tJYGF9yFHZAvYGE7HZGXHwumN1LnP0XGETaMQop6WJ42LKpE/sIgX4eWtEq0oxf
 F9y+VPu4+OFMSzBECJIl7jjmci9pqiXMAX/YsxhSE4NA2fKZjImdxUJ8mqMlyciyDcMV
 7Gmg40bMP5ehBRBbnLQ10mEpjhYdVMw1uCm6hNSXTv5EUuIbZfmMxCYOor0e/IrNjn8I
 rCOg==
X-Gm-Message-State: AC+VfDzj3di7uHBnCC18b/Lbfw6k94lAdkc3oZmTGcHMaCYRiOmOG5y3
 2tyHbVxyZgaQ5drCWxvSkYgAdsNRjmduQ63bsWpj/tnSNBbwt0JA8KQdBQwnVhLPKX0+gFrInUF
 L54nPre3ARa4ODZo=
X-Received: by 2002:a67:e21a:0:b0:443:66b9:b8f0 with SMTP id
 g26-20020a67e21a000000b0044366b9b8f0mr2772695vsa.10.1687868519573; 
 Tue, 27 Jun 2023 05:21:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gz8bv50vinls/K9QGDyrflsZYOkAP8HkXM2EhknsEHBZbqvtTeM3eI/rigOsiMwTCAm1szg==
X-Received: by 2002:a67:e21a:0:b0:443:66b9:b8f0 with SMTP id
 g26-20020a67e21a000000b0044366b9b8f0mr2772685vsa.10.1687868519334; 
 Tue, 27 Jun 2023 05:21:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 mm9-20020a0562145e8900b006238d903f9bsm4493533qvb.42.2023.06.27.05.21.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 05:21:58 -0700 (PDT)
Message-ID: <0a6e8496-f3c8-567a-c886-b8ea604c799a@redhat.com>
Date: Tue, 27 Jun 2023 14:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 qemu-devel@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
 <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
 <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
 <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
 <20230626112729.06dc48d8.alex.williamson@redhat.com>
 <976b7037-ee62-f86d-5772-6a2deca0816d@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <976b7037-ee62-f86d-5772-6a2deca0816d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

[ Cc: Shameer ]


>>> I see ON_OFF_AUTO_ON as a way to abort the machine startup while
>>> ON_OFF_AUTO_AUTO would let it run but block migration.
>>
>> Agreed.  There's a little bit of redundancy between the device-level
>> "enable-migration=on" option and the global "-only-migratable" option
>> relative to preventing machine startup, but it also doesn't make sense
>> to me if the device-level option let realize complete successfully if
>> the device doesn't support or fails migration setup.  So I think we'd
>> generally rely on using the -only-migratable option with the default
>> ON_OFF_AUTO_AUTO value, allow the ON_OFF_AUTO_ON value to enable
>> dis-recommended support, and live with the redundancy that it should
>> also cause the device realize to fail if migration is not supported.
>> Thanks,
>>
>> Alex
> 
> OK.
> 
> When enable_migration=AUTO we allow blockers.
> When enable_migration=ON we don't allow blockers and instead prevent realization of VFIO device.
> 
> Regarding device dirty tracking, we keep current behavior, right?
> That is:
> When enable_migration=AUTO we block migration if device dirty tracking is not supported.
> When enable_migration=ON we allow migration even if device dirty tracking is not supported > (in which case DMA-able memory will be perpetually dirtied).

Yes. That's how I understand it. This is what you initially proposed.

The default behavior is to allow migration only if the host kernel
driver supports dirty tracking.

We have a way to run and migrate a machine with a device not supporting
dirty tracking. Only Hisilicon is in that case today. May be there are
plans to add dirty tracking support ?

Thanks,

C.


