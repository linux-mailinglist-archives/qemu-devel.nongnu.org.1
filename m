Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0798779307
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUU25-0002c0-9j; Fri, 11 Aug 2023 11:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUU23-0002bm-OP
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUU21-0001QG-Vr
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691767589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/T0iEcbhzNNfvTClYMtiQn25Dona4E51OXGcvAAcQw=;
 b=EvCIo8eADJe0DUADJ8+mltB2c8j9w3FbrwNYXsPluTiOGD81TUb5QTvt0Bb2ldlujgFMRo
 gCE/0oOxxWiZAw20JH4THefajw0tp6YjNds8Bh5crTDNe7A6POdLxv9KbWPj1Rf9SOs7p6
 BR/vBjPPPhjC88o0VGxNk9Z3QfwKtI0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-XaZGf8X8PxGE1Ksj1gEubA-1; Fri, 11 Aug 2023 11:26:27 -0400
X-MC-Unique: XaZGf8X8PxGE1Ksj1gEubA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe25f8c4bfso13811075e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 08:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691767586; x=1692372386;
 h=content-transfer-encoding:in-reply-to:subject:organization
 :references:cc:to:from:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2/T0iEcbhzNNfvTClYMtiQn25Dona4E51OXGcvAAcQw=;
 b=N5aQ5suh+qN2AzJY7i1M2eUrxx1r2x+VLMn22ktP/upV1FR2HR/SbLuF7cJxzdN4fy
 ni9QJl7IzS/6nVZT70TYYgOrRnxYgtnt5Ze42Ks8AVnBlqLVg74J+Cy+umkkZWrMQ6PH
 w7sINEs99//1OT0cuZttVAJyvdpD8x4y3MrV/4mfuDQ5R0b6MHoaIjryrXLXJwNBCFSf
 3JFI6CoFD5w9+Ah59Xsgiusy5zE1WYxr/8l73Ulc9jfkzyJ80ySv/+ty8DgBdIj7ZpWd
 NGNxnEgupKLI047ETXuAkYYbfYHdkeYBcB39hWRSBDVRceocXbwZA/saobLg61htxicR
 Oiug==
X-Gm-Message-State: AOJu0Yz84m8GJNu8US5fStwd7EJ/Kx7xboG0zrYZMR2zrpLD7y3dEXwW
 kx/h4aMLGJH3StBSjpWCpvJrayv8fZFTajzw7OPIIBMGmi9gsLBeXyRKRmEPUIHGi4yQkXIPYkr
 R7fS6DRVkwFEhEus=
X-Received: by 2002:a7b:c4c5:0:b0:3fe:22fd:1b23 with SMTP id
 g5-20020a7bc4c5000000b003fe22fd1b23mr1892421wmk.34.1691767586422; 
 Fri, 11 Aug 2023 08:26:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ2MtXCsnMHmWNDTRd8xbGszTn0AcnlQdHtaeHgnOBrq5Zu2WHzC8ecClPKmYafVkygxz15A==
X-Received: by 2002:a7b:c4c5:0:b0:3fe:22fd:1b23 with SMTP id
 g5-20020a7bc4c5000000b003fe22fd1b23mr1892401wmk.34.1691767585976; 
 Fri, 11 Aug 2023 08:26:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:3000:973c:c367:3012:8b20?
 (p200300cbc71a3000973cc36730128b20.dip0.t-ipconnect.de.
 [2003:cb:c71a:3000:973c:c367:3012:8b20])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c021100b003fe1c332810sm8519339wmi.33.2023.08.11.08.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 08:26:25 -0700 (PDT)
Message-ID: <996a69ff-e2dc-0ed0-2ac8-33fd53bd02c2@redhat.com>
Date: Fri, 11 Aug 2023 17:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Peter Xu <peterx@redhat.com>, ThinerLogoer <logoerthiner1@163.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n> <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
In-Reply-To: <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.972, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 11.08.23 16:59, David Hildenbrand wrote:
> On 10.08.23 23:24, Peter Xu wrote:
>> On Fri, Aug 11, 2023 at 01:06:12AM +0800, ThinerLogoer wrote:
>>>> I think we have the following options (there might be more)
>>>>
>>>> 1) This patch.
>>>>
>>>> 2) New flag for memory-backend-file. We already have "readonly" and
>>>> "share=". I'm having a hard time coming up with a good name that really
>>>> describes the subtle difference.
>>>>
>>>> 3) Glue behavior to the QEMU machine
>>>>
>>>
>>> 4) '-deny-private-discard' argv, or environment variable, or both
>>
>> I'd personally vote for (2).  How about "fdperm"?  To describe when we want
>> to use different rw permissions on the file (besides the access permission
>> of the memory we already provided with "readonly"=XXX).  IIUC the only sane
>> value will be ro/rw/default, where "default" should just use the same rw
>> permission as the memory ("readonly"=XXX).
> 
> Hmm, I'm not particularly happy about that.
> 
>>
>> Would that be relatively clean and also work in this use case?
>>
> 
> I get the feeling that we are over-engineering something that probably
> should never have been allowed: MAP_PRIVATE mapping of a file and
> opening it rw because someone might punch holes into it.
> 
> Once we start adding new parameters just for that, I get a bit skeptical
> that this is what we want. The number of people that care about that are
> probably close to 0.
> 
> The only real use case where this used to make sense (by accident I
> assume) was with hugetlb. And somehow, we decided that it was a good
> idea for "-mem-path" to use MAP_PRIVATE.
> 
> So, what stops us from
> 
> a) Leaving -mem-path alone. Keep opening files rw.
> b) Make memory-backend-file with shared=off,readonly=off open the file
>      read-only
> c) Gluing that behavior to a QEMU compat machine
> 
> fallocate(PUNCH_HOLE) will fail, and we can probably let
> virtio-mem/virtio-balloon and postcopy refuse to even start (virtio-mem
> already does that) as early as possible.
> 
> People that care about any such use case would already get a warning
> when punching a hole today.
> 
> If we ever support discarding RAM in that configuration, we can simply
> unlock it again.
> 
> Am I missing any important use case?


I just started looking into the origins of "-mem-path".

Originally c902760fb2 ("Add option to use file backed guest memory"):

* Without MAP_POPULATE support, we use MAP_PRIVATE
* With MAP_POPULATE support we use MAP_PRIVATE if mem_prealloc was not
   defined.

It was only used for hugetlb. The shared memory case didn't really 
matter: they just needed a way to get hugetlb pages into the VM. Opening 
the file R/W even with MAP_PRIVATE kind-of made sense in that case, it 
was an exclusive owner.

Discarding of RAM was not very popular back then I guess: virtio-mem 
didn't exist, virtio-balloon doesn't even handle hugetlb today really, 
postcopy didn't exist.


I guess that's why nobody really cared about "-mem-path" MAP_PRIVATE vs. 
MAP_SHARED semantics: just get hugetlb pages into the VM somehow.

Nowadays, "-mem-path" always defaults to MAP_PRIVATE. For the original 
hugetlb use case, it's still good enough. For anything else, I'm not so 
sure.


-- 
Cheers,

David / dhildenb


