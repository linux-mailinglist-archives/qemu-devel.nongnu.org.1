Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 562DB77FA83
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 17:16:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWejD-0006Lg-Gc; Thu, 17 Aug 2023 11:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWejB-0006LU-Dv
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWej8-0000aI-DF
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692285357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKzA/LNj34HlMFFq+iSninGJukPj8rkjr63C/DJ1xY4=;
 b=fYAavh1n4rXK2hbVehMg50HVv8kNBS4QTMdJQCCJpiaEjXpb1rC4mTJNWPsJOqfjM7xbTr
 IZ1TafDRxXiI3m3q73vsbUG0uRNyPzjHqZEpO5i9nMkACe0XokLteMqFUeIKMdZ1WTmcHU
 VDWrh3dqfh0n+PsCtgwu3zwtdpT9ozU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-gnBqOrOVMgS4lU2kLASwvQ-1; Thu, 17 Aug 2023 11:15:55 -0400
X-MC-Unique: gnBqOrOVMgS4lU2kLASwvQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fd0fa4d08cso50591325e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 08:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692285354; x=1692890154;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xKzA/LNj34HlMFFq+iSninGJukPj8rkjr63C/DJ1xY4=;
 b=NV+jQM6c1Id2BxM1qO/3NvDP1J+yPLMnRKUUoeUau8NzT3JYmwqt9V8fBGZ/o4NGgG
 9Ma9hiFe32cXLiQGdnCqRfu8IKQTB3bTz94cpyNSykduTsXfLAaAJ1ucFIoxrvrO2bVJ
 UcTBgYGd9Z/jbelrHfdCWtwdPaK5QALnPKUo+1SbO8hwnIg3Tupw4qrrbVopafXLX1oF
 v7s4vVrmukvKTzoz9rIjz6jWAqIxcGinq01JWIrjg+JpOIyi4/T2b9XyVoxj5uVDsjJM
 7U4Rv40/NlIMCeYVw24F6jSRxkaAg9odhfe6Gf65RGCnALKqQDNrxjEwMJbFYA0FGIal
 PTxw==
X-Gm-Message-State: AOJu0Yz4NgJvicCnkWdJanYrIa/NsPbp3SDnlKds7lG4Iu9KKIA6BAJx
 EJBGhl/oKY9DsN1qMViHOw+vvmkEFi52Z7hbV2inuFHMbLR5KKZUP8+8IGVjI+aTRcxDjU+J1qZ
 mSLvGFJO3DhoYBsI=
X-Received: by 2002:a7b:c005:0:b0:3fa:93b0:a69c with SMTP id
 c5-20020a7bc005000000b003fa93b0a69cmr36434wmb.24.1692285354648; 
 Thu, 17 Aug 2023 08:15:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1c7IbGR+GKH2/XiVdEhGW1XTTvtyNBYbF8Qs0DbhKHjyTKT568HK6ZmvQt/TizYV9Nq9iGw==
X-Received: by 2002:a7b:c005:0:b0:3fa:93b0:a69c with SMTP id
 c5-20020a7bc005000000b003fa93b0a69cmr36423wmb.24.1692285354278; 
 Thu, 17 Aug 2023 08:15:54 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a05600c218300b003fd2d33ea53sm3274528wme.14.2023.08.17.08.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 08:15:53 -0700 (PDT)
Message-ID: <9b2b884e-095c-7cd5-380b-b3b0c5aad9b6@redhat.com>
Date: Thu, 17 Aug 2023 17:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: ThinerLogoer <logoerthiner1@163.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
 <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
 <CAJSP0QVjxNQ=sMjzEFzbyhJ0e+O5bGBiXkHMgWiB2GOVw4NqHQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJSP0QVjxNQ=sMjzEFzbyhJ0e+O5bGBiXkHMgWiB2GOVw4NqHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 17.08.23 17:13, Stefan Hajnoczi wrote:
> On Thu, 17 Aug 2023 at 05:08, David Hildenbrand <david@redhat.com> wrote:
>>
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
>>    it is opened read-write.  (default: false)"
>>
>> "@share: if false, the memory is private to QEMU; if true, it is
>>    shared (default: false)"
>>
>> So readonly is *all* about the file access mode already ... the mmap()
>> parameters are just a side-effect of that. Adding a new
>> "file-access-mode" or similar would be wrong.
>>
>>
>> Here are the combinations we have right now:
>>
>> -object memory-backend-file,share=on,readonly=on
>>
>>    -> Existing behavior: Open readonly, mmap readonly shared
>>    -> Makes sense, mmap'ing readwrite would fail
>>
>> -object memory-backend-file,share=on,readonly=off
>>
>>    -> Existing behavior: Open readwrite, mmap readwrite shared
>>    -> Mostly makes sense: why open a shared file R/W and not mmap it
>>       R/W?
>>
>> -object memory-backend-file,share=off,readonly=off
>>    -> Existing behavior: Open readwrite, mmap readwrite private
>>    -> Mostly makes sense: why open a file R/W and not map it R/W (even if
>>       private)?
>>
>> -object memory-backend-file,share=off,readonly=on
>>    -> Existing behavior: Open readonly, mmap readonly private
>>    -> That's the problematic one
>>
>>
>> So for your use case (VM templating using a readonly file), you
>> would actually want to use:
>>
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
>>
>>
>> But let's look at the commit that added the "readonly" parameter:
>>
>> commit 86635aa4e9d627d5142b81c57a33dd1f36627d07
>> Author: Stefan Hajnoczi <stefanha@redhat.com>
>> Date:   Mon Jan 4 17:13:19 2021 +0000
>>
>>       hostmem-file: add readonly=on|off option
>>
>>       Let -object memory-backend-file work on read-only files when the
>>       readonly=on option is given. This can be used to share the contents of a
>>       file between multiple guests while preventing them from consuming
>>       Copy-on-Write memory if guests dirty the pages, for example.
>>
>> That was part of
>>
>> https://lore.kernel.org/all/20210104171320.575838-3-stefanha@redhat.com/T/#m712f995e6dcfdde433958bae5095b145dd0ee640
>>
>>   From what I understand, for NVDIMMs we always use
>> "-object memory-backend-file,share=on", even when we want a
>> readonly NVDIMM.
>>
>>
>> So we have two options:
>>
>> 1) Change the current behavior of -object memory-backend-file,share=off,readonly=on:
>>
>> -> Open the file r/o but mmap it writable
> 
> Commit 86635aa4e9d627d5142b81c57a33dd1f36627d07 mentions that we don't
> want guests to be able to dirty pages on the host. The change you're
> proposing would not protect against guests that dirty the memory.

The guest could write memory but not modify the file. Only with 
"share=off,readonly=on" of course, not with "share=on,readonly=on".

> 
> I don't know how important that requirement was (that commit was a
> request from Kata Containers).

Let me take a look if Kata passes "share=on,readonly=on" or 
"share=off,readonly=off".

Thanks!

-- 
Cheers,

David / dhildenb


