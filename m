Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B9371840C
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:01:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MMC-0006XR-MM; Wed, 31 May 2023 09:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MMB-0006XH-EC
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:59:19 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MM9-0005HZ-On
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:59:19 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3094910b150so5970675f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685541556; x=1688133556;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yHwOlIOtU6Q8C9cHYFHhw1FPR8QlyfcS7ejg9NfmHl8=;
 b=LmIMAJ3NmLeHHMr12QVu5oCcW3uu+mTTQ+5tkLyuXQekt/C49ocUtjMeSnjpds+jqQ
 OgZkBqOvskJZLk2Zfv9PMUH2QJeM8b/g5SwBVieClgj+exCdzaKhqqERXowXmTDHiVmp
 dY5VMzZi5qjAbn//pY5yTxR617AC/z6y0Lrg+sJZdnZvAV2odcKvOZX4Pbg9Qvzr2rOc
 k/NQ+oYST/yYaBgGVNAvCKOL+GNhWEemXWGp966Wh5Pob/HY7u5BXzXs0aOo9y3j7XQ2
 5WHnq0H/KNZdQUn1heXv35vIM85d8yT+9j8UBW9m+w4yUscXBZsFZ4TJ0cMpLr2Vk0F+
 q/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685541556; x=1688133556;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yHwOlIOtU6Q8C9cHYFHhw1FPR8QlyfcS7ejg9NfmHl8=;
 b=VoLaKxTqBWpemo8/L4aES8OUIm3dxFLlDnug9FbicK1ljocfb61L1+PLdGNNa93T4u
 nU7fYO5/3qnpNb3LQytdOiZtQAhqY82PhQf8cqAkchVyiWunjI6D8Xo5llXor32YydNF
 ojhHGkUFTBSuWHddG+p7DijiQxyzrV8/2O+8VDybnv5POiHbtQGeHRmLOfZRAt0EF+GX
 /NBO/tVBmgEBZmbz5uMSczqsh9KrFTrTRGQiIkL+Wvy/WDwDB1Wte960HAv/U1OUaX9f
 rkEZUQT/ZMnuARkGiRZNMwxOEdV3MjcdxdAYChgz6Lb3O+Y13MNQvY+UFVjKU8eH4slR
 y2Fg==
X-Gm-Message-State: AC+VfDyGiZXsthyaCwHieKnVgCPSCqOlBLT1aLNWDL+tR3P9kbJ9eHxF
 VVwazjvuNErp1v4Tni+6gJ+AoA==
X-Google-Smtp-Source: ACHHUZ4+2vPjRbu9BeYYIt87r8CkwHbgbP2e+se3pxqwDkpgHTrJBfvqNsmAVzFbq9uKChQjyg+oJQ==
X-Received: by 2002:a05:6000:1378:b0:30a:e92c:25fa with SMTP id
 q24-20020a056000137800b0030ae92c25famr4353889wrz.60.1685541556095; 
 Wed, 31 May 2023 06:59:16 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 x14-20020adff0ce000000b0030aedb8156esm6890264wro.102.2023.05.31.06.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:59:15 -0700 (PDT)
Message-ID: <fb2e75c7-ed49-8af4-c328-63eb8b0219f2@linaro.org>
Date: Wed, 31 May 2023 15:59:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 10/15] intel-iommu: Implement IOMMU_ATTR_MAX_IOVA
 get_attr() attribute
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-11-joao.m.martins@oracle.com>
 <20790526-6640-3fd0-920a-ef09e5b306c0@linaro.org>
 <5c018403-f6fe-12ec-1c58-7dfa6abab53a@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <5c018403-f6fe-12ec-1c58-7dfa6abab53a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/5/23 11:54, Joao Martins wrote:
> 
> 
> On 30/05/2023 22:45, Philippe Mathieu-Daudé wrote:
>> On 30/5/23 19:59, Joao Martins wrote:
>>> From: Avihai Horon <avihaih@nvidia.com>
>>>
>>> Implement get_attr() method and use the address width property to report
>>> the IOMMU_ATTR_MAX_IOVA attribute.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>    hw/i386/intel_iommu.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)


>>> +    case IOMMU_ATTR_MAX_IOVA:
>>> +    {
>>> +        hwaddr *max_iova = data;
>>
>> Shouldn't we cast to uintptr_t to be safe?
>>
> Perhaps you mean something like this:
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 829dd6eadc6c..479307f1228f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3878,7 +3878,7 @@ static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
>       }
>       case IOMMU_ATTR_MAX_IOVA:
>       {
> -        hwaddr *max_iova = data;
> +        hwaddr *max_iova = (hwaddr *)(uintptr_t) data;
> 
>           *max_iova = (1ULL << s->aw_bits) - 1;
>           break;
> 
> I guess the thinking is to prevent 32-bit failures.

Exactly.

>>> +        *max_iova = (1ULL << s->aw_bits) - 1;
>>
>> Alternatively:
>>
>>             *max_iova = MAKE_64BIT_MASK(0, s->aw_bits);
>>
> 
> I'll switch to your suggestion. Wasn't aware of this macro :)

Thanks, it is a no-brainer when reviewing.


