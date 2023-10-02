Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F0B7B56D5
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:43:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnL4F-0006g2-3g; Mon, 02 Oct 2023 11:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnL4B-0006fj-El
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 11:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnL49-00045h-Jt
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 11:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696261355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Nt8j4p0c/F4cBjULIdfh56mKovB0Pwhw0NVRta4jKY=;
 b=eziYrWdnAdI3mUwW1h3Et9rMC4XicKqFugq6Z7Vf9b3eaPVG1vMqtbHMrE9a9bIFivI+aC
 wC/C4Q/tJELvdvKlQTRz8/80xo+d5i1JZDsH+FUN3HsPXaasvawrO5xt6znN/BCbSW8Nk6
 iT8AtXXRjLthuQhePM8sDc5KhWOqAa8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Zl-JqROnNvetICEF0-XmYQ-1; Mon, 02 Oct 2023 11:42:24 -0400
X-MC-Unique: Zl-JqROnNvetICEF0-XmYQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65b0af1b0e2so200362936d6.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 08:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696261343; x=1696866143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Nt8j4p0c/F4cBjULIdfh56mKovB0Pwhw0NVRta4jKY=;
 b=N3Tuw6FwotHhAezCccBTmAyP+9vhPh0bUjKqvKft5+kJh8vHIho6KQW8l07/kdOjai
 YgIhI8AetiQcC/ES/0g1hc2HdA0UnUz9CNoPqZWIOEQqnbVt6brFj+E1opSOwEU0WEq/
 BJfXPlbkWyjCtVafRrQL6yoe5WO/co6xP2Hd0LA2CIJPUUBVnF1VTO4V1kwea4D7CsPF
 YRpuhrnGwFB9ZF30dPSSy0eJARp+119Vvxkgo9EeBgSZAqHlrM8Bcn5PX8PEwa8TjQKU
 8akSw0deGxcf0flXuqS5pQWLIWIHXP4HldvlEWJDiE7xDJHZKEBOd4Mu0QL7CTGAalbY
 Z8VA==
X-Gm-Message-State: AOJu0YwAgZ5p20znUANwAkHswYTy7FbnpOVn85n70sC8qWC/iWStEnf8
 CLQJZrGJ769P4gO8qQAwLLaCEqknz3nGNjU7OfNm4P4WOXC5LkRQRsKKR/OQs48DKS99dt9bfkO
 nW3q/Cs+SRrHkqJXLNfaHNzI=
X-Received: by 2002:a0c:da82:0:b0:649:914:6495 with SMTP id
 z2-20020a0cda82000000b0064909146495mr12594829qvj.62.1696261343626; 
 Mon, 02 Oct 2023 08:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIIYmPOexgHwiCfsE7olfm4tfqF7H0g1QphNBaqWIWz83L6xxoyKivjCVXny7sXEIf3SZBKg==
X-Received: by 2002:a0c:da82:0:b0:649:914:6495 with SMTP id
 z2-20020a0cda82000000b0064909146495mr12594813qvj.62.1696261343379; 
 Mon, 02 Oct 2023 08:42:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a0cb2d2000000b0064723b94a23sm6218056qvf.27.2023.10.02.08.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:42:23 -0700 (PDT)
Message-ID: <b68270df-58a2-083b-9760-c16ab04ad8fd@redhat.com>
Date: Mon, 2 Oct 2023 17:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 10/15] intel-iommu: Implement IOMMU_ATTR_MAX_IOVA
 get_attr() attribute
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-11-joao.m.martins@oracle.com>
 <d6787c69-e66b-9e09-2efd-8f60129f0ea5@nvidia.com>
 <2cca62e2-6b16-9736-d015-15883ed1b02d@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <2cca62e2-6b16-9736-d015-15883ed1b02d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/10/23 15:44, Joao Martins wrote:
> 
> 
> On 09/07/2023 16:17, Avihai Horon wrote:
>>
>> On 23/06/2023 0:48, Joao Martins wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: Avihai Horon <avihaih@nvidia.com>
>>>
>>> Implement get_attr() method and use the address width property to report
>>> the IOMMU_ATTR_MAX_IOVA attribute.
>>
>> Nit: get_attr() method was already implemented in patch #6.
>> Maybe just "Use address width property to report IOMMU_ATTR_MAX_IOVA attribute"?
>>
> Yeap, makes sense.

I would merge with the previous patch also.

> 
>> Thanks.
>>
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>    hw/i386/intel_iommu.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index ed2a46e008df..989993e303a6 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -3876,6 +3876,13 @@ static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
>>>            *enabled = s->dma_translation;
>>>            break;
>>>        }
>>> +    case IOMMU_ATTR_MAX_IOVA:
>>> +    {
>>> +        hwaddr *max_iova = (hwaddr *)(uintptr_t) data;
>>> +
>>> +        *max_iova = MAKE_64BIT_MASK(0, s->aw_bits);;

one ; is enough.

Thanks,

C.

>>> +        break;
>>> +    }
>>>        default:
>>>            ret = -EINVAL;
>>>            break;
>>> -- 
>>> 2.17.2
>>>
> 


