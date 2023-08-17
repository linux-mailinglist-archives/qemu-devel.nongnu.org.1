Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1A377FA31
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 17:04:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWeWa-0008AI-HO; Thu, 17 Aug 2023 11:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWeWX-00088Y-Rm
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWeWV-0004z7-7R
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692284573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGCqbWFlYh62I7PDOYpWVdXyZxSwztiZMJdzqJ/0ff0=;
 b=iEBfL/8OWLAEOyV2nPQGdNzZiByyaJL4dkSEseSXIl7vUeh9uywtzDk3rciERH+ZPZJZ5M
 KWkqphl+4QMts4QOVho4OYCzpFk4DWcLKcX5hJNcH8cNE46WK+8bgsP11Q7Cgp4Tdab07l
 9m1VS+4OR+Z15RKJqxlhPI4fueEIt+M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-7iDwdCCJNYagca8W5mV_jg-1; Thu, 17 Aug 2023 11:02:52 -0400
X-MC-Unique: 7iDwdCCJNYagca8W5mV_jg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe232ba9e5so52537165e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 08:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692284571; x=1692889371;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XGCqbWFlYh62I7PDOYpWVdXyZxSwztiZMJdzqJ/0ff0=;
 b=lOVpmznI9mtL7SxgmTv7L80GQp/6xgCc4hj1Ww/AsHW1LjxxdZsqSymKgra94fCNF8
 2KlT11k3cpaUUSuJZSXUi7R3TwLeGMzzdNH8GQnDRU6XKbgtlfvw7Fc2JN8vbBKNfeFF
 szREPVxST0vRSYtcMcoq4B2G+4MtzUhw0bGh0vEuBIWZDtNI4CJm99cYWuObmdza0fA9
 9YntGFoJxaaH4nylCV6pLwm3TaS/M06QzNwONXJKS+JkQNHh+sfllACF40060lJXKxj4
 Efqajm+fWj14ZFyzmpX2rSInkYMBOnUZEwQ/XftytacN2FPtpxqwgqbSX/z6BABgnAwk
 PrQQ==
X-Gm-Message-State: AOJu0YwElL0vW8+aQZLXc7CevSibw1eaL+BRZtMVnuxslMQv5c5rZeZB
 YjJsrChRrVpt8f1k7WZWDQSkRiiNdFUQ6FVQ1u/BxWwn6BksDX5cyYMh8VPW8bJsheZgO56aOA7
 fTK+3yz4C41yBZbU=
X-Received: by 2002:a05:600c:287:b0:3f9:871:c2da with SMTP id
 7-20020a05600c028700b003f90871c2damr4280541wmk.40.1692284571051; 
 Thu, 17 Aug 2023 08:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn9SNTd/2fOqoBWo3fbEggQNnJAJQO0Oz4OgdjWOS+1gmWvaS/F1UvISphCX+/B5tw6PdvZg==
X-Received: by 2002:a05:600c:287:b0:3f9:871:c2da with SMTP id
 7-20020a05600c028700b003f90871c2damr4280517wmk.40.1692284570642; 
 Thu, 17 Aug 2023 08:02:50 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c22cd00b003fa98908014sm3292227wmg.8.2023.08.17.08.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 08:02:50 -0700 (PDT)
Message-ID: <0aee0753-9b4b-bd16-5bfb-85ee6580869d@redhat.com>
Date: Thu, 17 Aug 2023 17:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
 <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com> <ZN4xhh9FXLIRFeHF@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
In-Reply-To: <ZN4xhh9FXLIRFeHF@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 17.08.23 16:41, Peter Xu wrote:
> On Thu, Aug 17, 2023 at 11:07:23AM +0200, David Hildenbrand wrote:
>> @Stefan, see below on a R/O NVDIMM question.
>>
>> We're discussing how to get MAPR_PRIVATE R/W mapping of a
>> memory-backend-file running when using R/O files.
>>
>>>
>>> This seems a good idea. I am good with the solution you proposed
>>> here as well.
>>
>> I was just going to get started working on that, when I realized
>> something important:
>>
>>
>> "@readonly: if true, the backing file is opened read-only; if false,
>>   it is opened read-write.  (default: false)"
>>
>> "@share: if false, the memory is private to QEMU; if true, it is
>>   shared (default: false)"
>>
>> So readonly is *all* about the file access mode already ... the mmap()
>> parameters are just a side-effect of that. Adding a new
>> "file-access-mode" or similar would be wrong.
> 
> Not exactly a side effect, IMHO.  IIUC it's simply because we didn't have a
> need of using different perm for memory/file levels.  See the other patch
> commit message from Stefan:
> 
> https://lore.kernel.org/all/20210104171320.575838-2-stefanha@redhat.com/
> 
>      There is currently no way to open(O_RDONLY) and mmap(PROT_READ) when
>      [...]
> 
> So the goal at that time was to map/open both in RO mode, afaiu.  So one

Good point. And you can have both with "share=on,readonly=on" ever since 
Stefan introduced that flag, which that patch enabled.

Stefan didn't go into details to describe the required interactions 
between MAP_PRIVATE / MAP_SHARED.

[...]

>> -object memory-backend-file,share=off,readonly=on
>>
>> BUT, have the mmap be writable (instead of currently readonly).
>>
>> Assuming we would change the current behavior, what if someone would
>> specify:
>>
>> -object memory-backend-file,readonly=on
>>
>> (because the default is share=off ...) and using it for a R/O NVDIMM,
>> where we expect any write access to fail.
> 
> It will (as expected), right?  fallocate() will just fail on the RO files.

Yes, if the file was opened R/O, any fallocate() will fail.

> 
> To be explicit, maybe we should just remember the readonly attribute for a
> ramblock and then we can even provide a more meaningful error log, like:

Hah, I have a patch that adds RAM_READONLY :) . But it expresses 
"mmapped shared" not "file opened shared".

> 
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 3df73542e1..f8c11c8d54 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -3424,9 +3424,13 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
>   int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>   {
>       int ret = -1;
> -
>       uint8_t *host_startaddr = rb->host + start;
>   
> +    if (rb->flags & RAM_READONLY) {
> +        // more meaningful error reports (though right now no errp passed in..)
> +        return -EACCES;
> +    }

Remembering whether a file is opened R/O might be reasonable to improve 
the error messages.

[...]

>>
>> But let's look at the commit that added the "readonly" parameter:
>>
>> commit 86635aa4e9d627d5142b81c57a33dd1f36627d07
>> Author: Stefan Hajnoczi <stefanha@redhat.com>
>> Date:   Mon Jan 4 17:13:19 2021 +0000
>>
>>      hostmem-file: add readonly=on|off option
>>      Let -object memory-backend-file work on read-only files when the
>>      readonly=on option is given. This can be used to share the contents of a
>>      file between multiple guests while preventing them from consuming
>>      Copy-on-Write memory if guests dirty the pages, for example.
>>
>> That was part of
>>
>> https://lore.kernel.org/all/20210104171320.575838-3-stefanha@redhat.com/T/#m712f995e6dcfdde433958bae5095b145dd0ee640
>>
>>  From what I understand, for NVDIMMs we always use
>> "-object memory-backend-file,share=on", even when we want a
>> readonly NVDIMM.
>>
>>
>> So we have two options:
>>
>> 1) Change the current behavior of -object memory-backend-file,share=off,readonly=on:
>>
>> -> Open the file r/o but mmap it writable
>>
>> 2) Add a new property to configure the mmap accessibility. Not a big fan of that.
>>
>>
>> @Stefan, do you have any concern when we would do 1) ?
>>
>> As far as I can tell, we have to set the nvdimm to "unarmed=on" either way:
>>
>> +   "unarmed" controls the ACPI NFIT NVDIMM Region Mapping Structure "NVDIMM
>> +   State Flags" Bit 3 indicating that the device is "unarmed" and cannot accept
>> +   persistent writes. Linux guest drivers set the device to read-only when this
>> +   bit is present. Set unarmed to on when the memdev has readonly=on.
>>
>> So changing the behavior would not really break the nvdimm use case.
>>
>> Further, we could warn in nvdimm code when we stumble over this configuration with
>> unarmed=on.
> 
> I'll leave nvdimm specific question to Stefan, but isn't this also will map
> any readonly=on memory backends (besides nvdimm) to have the memory
> writable, which is still unexpected?

Note that libvirt *never* sets readonly=on for R/O NVDIMMs, and R/O 
NVDIMMs are really the only use case.

I don't think "open file read only" raises the expectation "map it read 
only". It certainly does for shared mappings, but not for private mappings.

To me, the expectation of "open the file read only" is that the file 
won't be modified, ever.

Libvirt should probably be taught to use "share=on,readonly=on" when 
dealing with R/O NVDIMMs, instead of "share=off" (implying readonly=on) 
to create a writable COW mapping.

-- 
Cheers,

David / dhildenb


