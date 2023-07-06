Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9ED749D78
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOxu-000470-Uh; Thu, 06 Jul 2023 09:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHOxp-00046s-23
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHOxn-0000IT-Hi
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688649842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5BAXv48qk7ZaK8c1E2ozrrkfWUJlTQOfc9N/KYF/gs=;
 b=fR6AQ5+IsRqic2OQEbQTNYfRBKzUyF7aNrRtY1bDviM7xTZ/bWjPlYmXE0fGjQwqOhPWLI
 4h7OAESjkNYqIJqnDsgWwi6ReJqU9sfvwTw9COV89L7ZVXrZvCOzFSWsm2abIYwQy6+P+F
 SQvVweo7e7MlxP7MFATGrRvA7RT7Fso=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-9T3wIsm7M6aGRAxOsWn3Mg-1; Thu, 06 Jul 2023 09:24:01 -0400
X-MC-Unique: 9T3wIsm7M6aGRAxOsWn3Mg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbb0fdd060so4450635e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649839; x=1691241839;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5BAXv48qk7ZaK8c1E2ozrrkfWUJlTQOfc9N/KYF/gs=;
 b=BnUx1eim68rShm2Hpupog9yP3lewNyQVIcYUVtytYd0ngwebs+0UkFoxxfKdTXM0ao
 FrNedwlP8lRQQr1ETL/RVMx2qTdC/uK/otfrP05av6PWhHBSgAWsdoGvmGHryF0Qlqlh
 olQ/WOL9SzDWJELi0eiNUv6Cndodm/Pop8LpWXqZxpxl3A8xoyfSgGJhtMF8EQKq4XJW
 nnzPU+hmXiDelg8Uzwl/6U3/TBbFt3QwEZcQBrTCNGZtthVGDez60C85ynwxlTI+AHlh
 jfYqMQgljtExlSMm8PaGznXCv5eVTR5paDt+TQ88ttFvjRiYqS4Ryr2ybTBnMACKmto3
 xZtA==
X-Gm-Message-State: ABy/qLasiHKjiL9a8dHtsgZSfsyojd4MGhYIzHOm/FkHuzrKdaANs6LV
 PkTFB12dEqB813ExDfJ19xWEmkcmECne+l/k8fNUXZWK8h0mvT4H6/NTJc1M4ZPIWl4ZrM+yM1j
 gtx3X0tWoecq/A00=
X-Received: by 2002:a5d:5647:0:b0:314:31ca:7d1f with SMTP id
 j7-20020a5d5647000000b0031431ca7d1fmr1349809wrw.20.1688649839344; 
 Thu, 06 Jul 2023 06:23:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE1dX92ERFqHxpu6Wu/p0QXsCxFv46ikzR7dCZQ89VLw7dxgS/d+TFJldCsjXWOmFRFzVqMVw==
X-Received: by 2002:a5d:5647:0:b0:314:31ca:7d1f with SMTP id
 j7-20020a5d5647000000b0031431ca7d1fmr1349795wrw.20.1688649838964; 
 Thu, 06 Jul 2023 06:23:58 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 i14-20020adffdce000000b003141f96ed36sm1945179wrs.0.2023.07.06.06.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 06:23:58 -0700 (PDT)
Message-ID: <74d081c8-f836-bb6d-935e-1ece625b6011@redhat.com>
Date: Thu, 6 Jul 2023 15:23:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-2-david@redhat.com> <87jzvdbgv1.fsf@secure.mitica>
 <6cceb935-1830-2984-7529-59d1f8881d34@redhat.com>
 <87zg496uss.fsf@secure.mitica>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87zg496uss.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 06.07.23 15:20, Juan Quintela wrote:
> David Hildenbrand <david@redhat.com> wrote:
>> On 06.07.23 10:10, Juan Quintela wrote:
>>> David Hildenbrand <david@redhat.com> wrote:
>>>> ram_block_discard_range() cannot possibly do the right thing in
>>>> MAP_PRIVATE file mappings in the general case.
>>>>
>>>> To achieve the documented semantics, we also have to punch a hole into
>>>> the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
>>>> of such a file.
>>>>
>>>> For example, using VM templating -- see commit b17fbbe55cba ("migration:
>>>> allow private destination ram with x-ignore-shared") -- in combination with
>>>> any mechanism that relies on discarding of RAM is problematic. This
>>>> includes:
>>>> * Postcopy live migration
>>>> * virtio-balloon inflation/deflation or free-page-reporting
>>>> * virtio-mem
>>>>
>>>> So at least warn that there is something possibly dangerous is going on
>>>> when using ram_block_discard_range() in these cases.
>>>>
>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>> Tested-by: Mario Casquero <mcasquer@redhat.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> (at least we give a warning)
>>> But I wonder if we can do better and test that:
>>>    * Postcopy live migration
>>>      We can check if we are on postcopy, or put a marker so we know
>>> that
>>>      postcopy can have problems when started.
>>>    * virtio-balloon inflation/deflation or free-page-reporting
>>>      We can check if we have ever used virtio-balloon.
>>>    * virtio-mem
>>>      We can check if we have used virtio-men
>>> I am just wondering if that is even possible?
>>
>> Now we warn when any of these features actually tries discarding RAM
>> (calling ram_block_discard_range()).
>>
>> As these features trigger discarding of RAM, once we reach this point
>> we know that they are getting used. (in comparison to default libvirt
>> attaching a virtio-balloon device without anybody ever using it)
>>
>>
>> The alternative would be checking the RAM for compatibility when
>> configuring each features. I decided to warn at a central place for
>> now, which covers any users.
> 
> I think this is the right thing to do.
> 
> Patient: It hurts when I do this.
> Doctor: Don't do that.
> 
> O:-)

:)

> 
> Now more seriously, at this point we are very late to do anything
> sensible.  I think that the normal thing when we are configuring
> incompatible things just flag it.
> 
> We are following that approach with migration for some time now, and
> everybody is happier.

For the time being I'll move forward with this patch.

I agree that warning early is nicer (but warning for example for 
virtio-balloon early doesn't make too much sense: libvirt adds it 
blindly to each VM just to query guest statistics and never inflate the 
balloon).

In any case we'll want to warn here as well, because we know that new 
callers will easily ignore that limitation / checks.

-- 
Cheers,

David / dhildenb


