Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAE5779776
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 21:01:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUXNl-0006nT-B9; Fri, 11 Aug 2023 15:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUXNi-0006mJ-6q
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 15:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUXNd-0002YT-Nv
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 15:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691780460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ThkEM/h/nE6pm3pyVuI4H72MCJcx3t/zGo8wB8bUdkg=;
 b=XfdQ5S87KgMHR7lzYbsKcuI9KoZEdqmDpfQCfDfBo6MwGmAA/DWCE3iuCGJCgNyNniyLG5
 WoVNi1gKut+yIOwsuxe8nG/efO7EtDeP9mO0UYqyMA82CScbaWKaWlBke7HVCnTJutkXSs
 1SkqP0EN5wP+FahXs8nPhOOEnpq0v0k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-WyrAY_M0OeqN8bRyCzm-9g-1; Fri, 11 Aug 2023 15:00:57 -0400
X-MC-Unique: WyrAY_M0OeqN8bRyCzm-9g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3172a94b274so1451016f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 12:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691780456; x=1692385256;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ThkEM/h/nE6pm3pyVuI4H72MCJcx3t/zGo8wB8bUdkg=;
 b=UqJHOs9haGpbTp8CgsHcyL08gJOQfVdur3opGotLcTRLvKJ/aiKFdr6yRpyO5pIdRz
 0ple1cXQGtU/L7JKJuTa75zihX6y5q/3Qbgl02U709KUFwUA0Roib8UIpfZ0EhTkeC7R
 KaA8R5Kn+fc/VgA78stl5L8gDzseL+2911N/C8iMus1NYZ+FTyszbuspVlBt7QoR3PxD
 qqyp0S4PFBDfrB0Y/7szhKCiBicU87QF8t84S+VWbCL6iAyrwm/8ZHnDFGCNBmBqtaMP
 M1RPh0Is4+yijwmlJq5P9aUtSD6nNIAdXt0mYVhOSlgvof97XUZrk+r7Gj28C0oXrRUI
 bO9g==
X-Gm-Message-State: AOJu0Yy9+4H/df3hrDSEF7cAqD6Gl5ZpgMbFT/bnW5IbNhZSiA9U4NmH
 9APDaar98x/7TLt27zv5h6YS/FYmCG8YZ5YDdG6LUVikOnxI56ev6b45CyyhnK/sUkjah3oU/lr
 B4H9DJEdQuYJm05U=
X-Received: by 2002:adf:ce11:0:b0:315:963a:4a3e with SMTP id
 p17-20020adfce11000000b00315963a4a3emr2313268wrn.7.1691780456164; 
 Fri, 11 Aug 2023 12:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3sTiyf/M1KVrcWjGc6TVzVFRkUaAX7q2neCz3EtKIusdbbGjF5pVge2BJtxobuXJnCyQgrQ==
X-Received: by 2002:adf:ce11:0:b0:315:963a:4a3e with SMTP id
 p17-20020adfce11000000b00315963a4a3emr2313252wrn.7.1691780455784; 
 Fri, 11 Aug 2023 12:00:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:3000:973c:c367:3012:8b20?
 (p200300cbc71a3000973cc36730128b20.dip0.t-ipconnect.de.
 [2003:cb:c71a:3000:973c:c367:3012:8b20])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a1cf70e000000b003fe24441e23sm6019988wmh.24.2023.08.11.12.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 12:00:55 -0700 (PDT)
Message-ID: <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
Date: Fri, 11 Aug 2023 21:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
In-Reply-To: <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
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

On 11.08.23 07:49, ThinerLogoer wrote:
> At 2023-08-11 05:24:43, "Peter Xu" <peterx@redhat.com> wrote:
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
>>
>> Would that be relatively clean and also work in this use case?
>>
>> (the other thing I'd wish we don't have that fallback is, as long as we
>> have any of that "fallback" we'll need to be compatible with it since
>> then, and for ever...)
> 
> If it must be (2), I would vote (2) + (4), with (4) adjust the default behavior of said `fdperm`.
> Mainly because (private+discard) is itself not a good practice and (4) serves
> as a good tool to help catch existing (private+discard) problems.

Instead of fdperm, maybe we could find a better name.

The man page of "open" says: The argument flags must include one of the 
following access modes: O_RDONLY, O_WRONLY, or O_RDWR.  These request 
opening the file read-only, write-only, or read/write, respectively.

So maybe something a bit more mouthful like "file-access-mode" would be 
better.

We could have the options
*readwrite
*readonly
*auto

Whereby "auto" is the default.

Specifying:

* "readonly=true,file-access-mode=readwrite" would fail.
* "shared=true,readonly=false,file-access-mode=readonly" would fail.
* "shared=false,readonly=false,file-access-mode=readonly" would work.

In theory, we could adjust the mode of "auto" with compat machines. But 
maybe it would be sufficient to do something like the following

1) shared=true,readonly=false
	-> readwrite
2) shared=true,readonly=true
	> readonly
2) shared=false,readonly=true
	-> readonly
3) shared=false,readonly=true
	hugetlb? -> readwrite
	otherwise -> readonly

Reason being the traditional usage of hugetlb with MAP_PRIVATE where I 
can see possible users with postcopy. Further, VM templating with 
hugetlb might not be that common ... users could still modify the 
behavior if they really have to.

That would make your use case work automatically with file-backed memory.

-- 
Cheers,

David / dhildenb


