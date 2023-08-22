Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A31E678422B
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:36:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRXo-0003YJ-87; Tue, 22 Aug 2023 09:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYRXk-0003WR-LD
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYRXg-0005nz-AZ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692711331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgKPvRRwfeeUsCV5D4yCx2xKiH3CGl17h7UGMTmqI9U=;
 b=LBMK+SF/sFVgDueZi7zQZR0CMxUGNDP5Lailo7CL30d8+jzR5s/AxxDApZet14D9hJ6+Pf
 DGdjyCqC0pa74C12COplHDZM3sr0JbOj86Y5HVO8zA4GbXuTqhQm9wCdNljqFmqA9VFNc5
 ojO6qpY/pgHwv50+DVPXm6I7S9BLwZc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-h1YC-eOrOlCEsDjGLG8hcA-1; Tue, 22 Aug 2023 09:35:29 -0400
X-MC-Unique: h1YC-eOrOlCEsDjGLG8hcA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso2656056f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 06:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692711328; x=1693316128;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RgKPvRRwfeeUsCV5D4yCx2xKiH3CGl17h7UGMTmqI9U=;
 b=Ogn5H+QDXffGHPNSqVUdtJuET+JeS3as+D0QA7qCmWG0qYV2xrOfzdoE/xvYGeA7Tv
 SyDMzBxXpAMFsPMpg5WyqTBaL3mo0Th05WnlDOT3lU1+hbaIxTgFWp8LxeJivWcomMrv
 SYJLRnwdrg7G62hOofsE0GnGhHh1H8nCGPezjrrVsRZ2Hh9j1kQ39+dgLWGf2kBvs4FK
 Cufkb5w2yj4QpL//GBhFRwy93nTQXBTXM9jp7hZSPs7ZS1LUGY2Pe2chbAg1uGCF1X5j
 OnpIaNLjqOhi43eR+LpIVrxvPtfMxdUmTbuqnkYVg3mmK6j+i2rdzw1hYNvJrQtrL+tZ
 83rQ==
X-Gm-Message-State: AOJu0Yzveyt5YXIsD+lW4G1ELBFpogDbVYR2up4mXzTdNAhFYQ9x/Ivk
 Ht8JFJ5XJvYhChB3/owGsnM5l0HR644IPNkIl5+gMzb5yjxALbVdE1vo+J0LzSm/ZQvDl1WTpyy
 XA+Ouu2aYlOz/mlNqNPhix5k=
X-Received: by 2002:a5d:568f:0:b0:317:e5ec:8767 with SMTP id
 f15-20020a5d568f000000b00317e5ec8767mr6789815wrv.21.1692711328120; 
 Tue, 22 Aug 2023 06:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuyJCju050siYmtq4+aa91ziG9fgr76mTavkNoPFs7Por61bm9436j4INnPtSvoaxdNi6u6Q==
X-Received: by 2002:a5d:568f:0:b0:317:e5ec:8767 with SMTP id
 f15-20020a5d568f000000b00317e5ec8767mr6789800wrv.21.1692711327701; 
 Tue, 22 Aug 2023 06:35:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:7400:83da:ebad:ba7f:c97c?
 (p200300cbc706740083daebadba7fc97c.dip0.t-ipconnect.de.
 [2003:cb:c706:7400:83da:ebad:ba7f:c97c])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a5d628e000000b00317eee26bf0sm15930545wru.69.2023.08.22.06.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 06:35:27 -0700 (PDT)
Message-ID: <b7e23f8e-d84b-326a-7817-875bdf1b9dc9@redhat.com>
Date: Tue, 22 Aug 2023 15:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
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
 <ZNZGSON+yDFod2AZ@x1n>
 <2337d9f.16d6.189e8682901.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2337d9f.16d6.189e8682901.Coremail.logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 12.08.23 08:21, ThinerLogoer wrote:
> At 2023-08-11 22:31:36, "Peter Xu" <peterx@redhat.com> wrote:
>> On Fri, Aug 11, 2023 at 01:49:52PM +0800, ThinerLogoer wrote:
>>> At 2023-08-11 05:24:43, "Peter Xu" <peterx@redhat.com> wrote:
>>>> On Fri, Aug 11, 2023 at 01:06:12AM +0800, ThinerLogoer wrote:
>>>>>> I think we have the following options (there might be more)
>>>>>>
>>>>>> 1) This patch.
>>>>>>
>>>>>> 2) New flag for memory-backend-file. We already have "readonly" and
>>>>>> "share=". I'm having a hard time coming up with a good name that really
>>>>>> describes the subtle difference.
>>>>>>
>>>>>> 3) Glue behavior to the QEMU machine
>>>>>>
>>>>>
>>>>> 4) '-deny-private-discard' argv, or environment variable, or both
>>>>
>>>> I'd personally vote for (2).  How about "fdperm"?  To describe when we want
>>>> to use different rw permissions on the file (besides the access permission
>>>> of the memory we already provided with "readonly"=XXX).  IIUC the only sane
>>>> value will be ro/rw/default, where "default" should just use the same rw
>>>> permission as the memory ("readonly"=XXX).
>>>>
>>>> Would that be relatively clean and also work in this use case?
>>>>
>>>> (the other thing I'd wish we don't have that fallback is, as long as we
>>>> have any of that "fallback" we'll need to be compatible with it since
>>>> then, and for ever...)
>>>
>>> If it must be (2), I would vote (2) + (4), with (4) adjust the default behavior of said `fdperm`.
>>> Mainly because (private+discard) is itself not a good practice and (4) serves
>>> as a good tool to help catch existing (private+discard) problems.
>>>
>>> Actually (readonly+private) is more reasonable than (private+discard), so I
>>> want at least one room for a default (readonly+private) behavior.
>>
>> Just for purely discussion purpose: I think maybe someday private+discard
>> could work.  IIUC what we're missing is an syscall interface to install a
>> zero page for a MAP_PRIVATE, atomically freeing what's underneath: it seems
>> either punching a hole or DONTNEED won't suffice here.  It'll just be
>> another problem when having zero page involved in file mappings at least.
>>
>>>
>>> Also in my case I kind of have to use "-mem-path" despite it being considered
>>> to be close to deprecated. Only with this I can avoid knowledge of memory
>>> backend before migration. Actually there seems to be no equivalent working after-migration
>>> setup of "-object memory-backend-file,... -machine q35,mem=..." that can match
>>> before-migration setup of "-machine q35" (specifying nothing). Therefore
>>> I must make a plan and choose a migration method BEFORE I boot the
>>> machine and prepare to migrate, reducing the operation freedom.
>>> Considering that, I have to use "-mem-path" which keeps the freedom but
>>> has no configurable argument and I have to rely on default config.
>>>
>>> Are there any "-object memory-backend-file..." setup equivalent to "-machine q35"
>>> that can migrate from and to each other? If there is, I want to try it out.
>>> By the way "-object memory-backend-file,id=pc.ram" has just been killed by an earlier
>>> commit.
>>
>> I'm actually not familiar enough on the interfaces here, but I just checked
>> up the man page; would this work for you, together with option (2)?
>>
>>         memory-backend='id'
>>                 An alternative to legacy -mem-path and mem-prealloc options.  Allows to use a memory backend as main RAM.
>>
>>                 For example:
>>
>>                 -object memory-backend-file,id=pc.ram,size=512M,mem-path=/hugetlbfs,prealloc=on,share=on
>>                 -machine memory-backend=pc.ram
>>                 -m 512M
>>
> 
> Wait ... I thought it should not work but it did work today. How bad am I at reading
> the correct part of documentation ...
> 
> '-machine q35 -m 512M' is equivalent to '-object
> memory-backend-file,id=pc.ram,size=512M
> -machine q35,memory-backend=pc.ram',
> the latter works, and the two mentioned setup can be
> migrated from one to another.
> 
> What I was consistently trying was '-object
> memory-backend-file,id=pc.ram,size=512M -machine q35', and qemu raises an error
> for this in a recent update:
> 
> ```
> qemu-system-x86_64: object name 'pc.ram' is reserved for the default RAM backend, it can't be used for any other purposes. Change the object's 'id' to something else
> ```
> 
> This error is misleading. Actually in this case, the error report message should be more
> close to:
> ```
> object name 'pc.ram' is reserved for the default RAM backend, it can't
> be used for any other purposes. Change the object's 'id' to something
> else, or append "memory-backend=pc.ram" to -machine arguments
> ```

What about:

$ ./build/qemu-system-x86_64 -object 
memory-backend-file,id=pc.ram,size=512M,mem-path=tmp -machine q35
qemu-system-x86_64: object name 'pc.ram' is reserved for the default RAM 
backend, it can't be used for any other purposes. Change the object's 
'id' to something else or disable automatic creation of the default RAM 
backend by setting the 'memory-backend' machine property

?

-- 
Cheers,

David / dhildenb


