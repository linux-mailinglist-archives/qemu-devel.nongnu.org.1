Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA21AC649D
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 10:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKCII-0002y2-Ta; Wed, 28 May 2025 04:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKCIE-0002wx-EN
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKCI7-0000Pw-CJ
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748421457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nmPwXedPPTSTEA42diIQYFW0FrB0EwSVhLSkX3N8O+U=;
 b=eN931aEESjxPS6p68AqnEZEmsc/6rgN5cGXfmiV7B7lEWyqT8Nv0qXDyJiU6benCSt3F3v
 8GVS/1D2RR9VinGMjCpEfzPEeVWQSBoL/UouiTEiWA8w4vNcz5uw6P18rwYD2+6H37rI0I
 l72AUN8EUqwSNKZpSki72YCWAZuXmu8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-O4ioCfDaNeWX2xTJzDwAMQ-1; Wed, 28 May 2025 04:37:33 -0400
X-MC-Unique: O4ioCfDaNeWX2xTJzDwAMQ-1
X-Mimecast-MFC-AGG-ID: O4ioCfDaNeWX2xTJzDwAMQ_1748421452
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45048826b64so2809475e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748421452; x=1749026252;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nmPwXedPPTSTEA42diIQYFW0FrB0EwSVhLSkX3N8O+U=;
 b=EsSrJL448SPeI08oicH0BjWye1jZndVq2ykpOzdisNH2nffgNSBR6JLlEHHEf5wxMT
 54jwEfPC599OwsGiPKvKm++73xruy49WhqUOhyvRLoBORwrWqNXk3R/5Jjis0mW+UjLL
 dF3cFT7FE6EzF1lTVyCmTHg6Eru/q7L/jiU72VS3RyE5w3achcSCDOHKI1i2aMSqo1pS
 7ASPam4pN1g9+jpZsU+FLGVM8JlVJ/fxucwqO3sylKhghDtXMazKF99VFiuku+nTTxDl
 CBSp9Z+jE+UXYPEMOPDXlytjakz1oRlS0G64VeJDPILgXkRAssuwkjG9G1gCwWJb37vB
 srdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtDbwwpGp3Y9uvbYqGp8fK+xinghiauZ7EpEr93eOeN1Z1VDyta45KLLw3JapYpaRshRfsvJuu3s6h@nongnu.org
X-Gm-Message-State: AOJu0Yy/zQAA4BBdUXj/wYhCYLRIIP++VwRZVRHFUaZ7tRsyUNXAUbwO
 sn5nPiYaGy0mGDG1Y8YhiJUn8GHXaCa1kB2qfUx4pIWoQCABE7BOXDHFdZYXnq/1DYApbFwH5au
 Zvf+KoSiIN5p9Fvxtu0zovLt8qR+vMEOIrkTEjfVsspXczlft2SPGKhVQ
X-Gm-Gg: ASbGncvPBEt3UMYT19aeBgEpQPwc+LOlJe1gHrKKS+WxZ7p54Nx4QUcmHkRvsAVyy0C
 +27Z6apf7v+6FWtcfuUaL8dL/kTtyjqltK29tMmkM8+h9FzeiB5rsmJHx4SPmHSflx1sLHjYnNu
 Jd4xDgHhX+3OZv5M9B3tliBhTRNB2ocY9+rKRXvi3z48hzla1s1773wUUC+rm2qFIWW+FLHzRLH
 mWqOOFP3f92zgkOtsKvBtRU6gClQ5cENlV8k18yKhDH1IkDnGKmcdER07SVbV5FOzvNVuq10yWs
 RtAZPwypf20jUI4mQ3qvNdKX0+koa4ZTUNHAL6bw01gJml6CShJZ
X-Received: by 2002:a05:600c:1d0d:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-44c9160702fmr163551045e9.2.1748421451970; 
 Wed, 28 May 2025 01:37:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ/YwUKZWO4VTb/zTI6hSuDn/bfrQd6FTrb03z7P1ouz+jPT7Nr7hEWA6QPEoR2MYArki39g==
X-Received: by 2002:a05:600c:1d0d:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-44c9160702fmr163550575e9.2.1748421451483; 
 Wed, 28 May 2025 01:37:31 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45072559736sm10225605e9.19.2025.05.28.01.37.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 01:37:31 -0700 (PDT)
Message-ID: <1c8914b3-bdf5-453d-980c-5f9d14b7e8eb@redhat.com>
Date: Wed, 28 May 2025 10:37:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/19] hw/block/fdc-isa: Remove 'fallback' property
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-14-philmd@linaro.org>
 <6484086d-22a7-4cb6-9140-bb5251c5cf93@redhat.com>
 <bfc0d4e7-d062-4526-8969-9fc0a7a3d179@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <bfc0d4e7-d062-4526-8969-9fc0a7a3d179@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/05/2025 10.30, Thomas Huth wrote:
> On 27/05/2025 19.20, Thomas Huth wrote:
>> On 12/05/2025 10.39, Philippe Mathieu-Daudé wrote:
>>> The "fallback" property was only used by the hw_compat_2_5[] array,
>>> as 'fallback=144'. We removed all machines using that array, lets
>>> remove ISA floppy drive 'fallback' property, manually setting the
>>> default value in isabus_fdc_realize().
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>> ---
>>>   hw/block/fdc-isa.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> FWIW, this needs a fixup for iotest 172:
>>
>>   https://gitlab.com/thuth/qemu/-/jobs/10166450223#L466
> 
> FYI, since I was testing this series anyway, I'll fix up this patch
...
> and I will queue this series (without the "Remove X86CPU::check_cpuid field" 
> patch as mentioned by Xiaoyao Li), unless Paolo or another x86 maintainer 
> wants to do this instead (please let me know!).

Hmm, looking at this twice, hw/block/fdc-sysbus.c has a "fallback" property, 
too, and there are people out there who set this property manually, e.g.:

  https://github.com/mariuz/linux-0.01/issues/4#issuecomment-974768898

So it seems like this property is meant as a config knob for the user, 
indeed, not just an internal one. I'll drop this patch for now.

  Thomas


