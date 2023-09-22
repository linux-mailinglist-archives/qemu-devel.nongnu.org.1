Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 797837AB03E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 13:11:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qje3G-0004wP-LL; Fri, 22 Sep 2023 07:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qje36-0004wF-6I
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qje33-00012H-LR
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695381012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMGnTqVqUa08PSV2RG3ZbIqLUaLZovAWsUr4Xv4L25w=;
 b=G3LkerSrcq9IZNgyG9pgk88RCBRGcsyWyk9hktDcJ2GagN7rGd2FgekkvRQjd/q9frBymX
 b4l4xX6P1EGw9/N1y2cI9g4+HvDn9N2W6TkeWDgMi3COW5pXITqzgp5bObnaTUFpWAwKAK
 DzrwjN7pHCqt3IYCLVoZOwNBVxoRWdQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-6gG7WJvJMLiJWTo0Mn4mLA-1; Fri, 22 Sep 2023 07:10:11 -0400
X-MC-Unique: 6gG7WJvJMLiJWTo0Mn4mLA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso1315718f8f.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 04:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695381010; x=1695985810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fMGnTqVqUa08PSV2RG3ZbIqLUaLZovAWsUr4Xv4L25w=;
 b=a1fExf/HuTGkj0OkJxOrzZzxaPMt+EVRKSh6mDO4dC6Kx4jn9aHy+X1SSNgKx0KDZR
 u8Dv10HV1BidtAD6qxQwJb3C1+GxPhUz+N3Yke8gAL4eCSkkCe/MESkRicNunYhXQH2N
 8+9cszJx+tkY1hh84TgJJEakNAMTsHP24jitp6th6067bE1vgolpboo+bf6wuJZSCzdc
 T7Aod51MYYKaJxonp8nCeZZUS1LGIDABElpC8FK38nSje8SPNY+Vqd1M3XYkvAIjNkgK
 ArXSOiC8gCBlYtQeRD0g6vkajfI5dkXYPfbUIe/PmGwYnuT1O5j7KD+L3Da+N2lOuM+L
 K+8Q==
X-Gm-Message-State: AOJu0YxzVSQSjzj6N4OnlISHdAWiZCH3OuIOOuDF5Ao3lJj1uUROuAgb
 UHH02S4x6opBoe3pH2kNqIoHTkuFnE8qndHHQOyKJ5OcEMQkRWjXI3f+QZQ6f8jPj3GP2B2EXbY
 4PR7Yugox5dGBwJI=
X-Received: by 2002:a5d:4fcc:0:b0:31a:ed75:75d9 with SMTP id
 h12-20020a5d4fcc000000b0031aed7575d9mr6397669wrw.16.1695381010084; 
 Fri, 22 Sep 2023 04:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVVHY/I9jYHNk47o9fB5A1Qy8i4lYUP45/DlZULDxk7Qn8AWiC36alQw284O/NouZrcf9Hnw==
X-Received: by 2002:a5d:4fcc:0:b0:31a:ed75:75d9 with SMTP id
 h12-20020a5d4fcc000000b0031aed7575d9mr6397653wrw.16.1695381009752; 
 Fri, 22 Sep 2023 04:10:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a5d6b51000000b0031980294e9fsm4167294wrw.116.2023.09.22.04.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 04:10:08 -0700 (PDT)
Message-ID: <8c13e55d-5894-d81d-23e7-5cd693093589@redhat.com>
Date: Fri, 22 Sep 2023 13:10:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] vfio/display: Fix missing update to set backing
 fields
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Alex Williamson <alex.williamson@redhat.com>, kraxel@redhat.com
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230816215550.1723696-1-alex.williamson@redhat.com>
 <a3a6f8ec-ca61-4472-45b4-1077dd27bb52@linaro.org>
 <acddfb4a-fe42-ba8c-e920-edc7e9ff5268@intel.com>
 <CAJ+F1C+YiDgRuyWcGeUPhaNO4SdjOSFSHKBY1wBS3dJFLO-k2w@mail.gmail.com>
 <20230904081129.3908c083.alex.williamson@redhat.com>
 <CAJ+F1CJFiHCu4FTbSFfLgSANiHJHEowJg7Um3j+ZMiHb_S21aQ@mail.gmail.com>
 <20230905090907.2b70b6a0.alex.williamson@redhat.com>
 <20230913131827.3bfe7bcb.alex.williamson@redhat.com>
 <b138199a-ceaa-4bf9-4d91-50a05ccc3267@redhat.com>
 <a95cb9f0-cdef-a0e9-c472-31f5534e58c1@tls.msk.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <a95cb9f0-cdef-a0e9-c472-31f5534e58c1@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 9/22/23 11:49, Michael Tokarev wrote:
> 22.09.2023 12:38, Cédric Le Goater wrote:
>> On 9/13/23 21:18, Alex Williamson wrote:
>>>
>>> Hi Gerd,
>>>
>>> Some consultation would be appreciated on this thread to get this patch
>>> out of limbo.  Is there a better solution that what I've proposed?
>>
>> This does fix a regression reproducible on systems with an Intel Gen 8,
>> my T480 laptop for instance.
>>
>> Tested-by: Cédric Le Goater <clg@redhat.com>
>>
>> Also, queuing it in vfio-next.
>>
> 
> Is it not https://gitlab.com/qemu-project/qemu/-/issues/1891 ?

It is.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1891

Thanks,

C.


