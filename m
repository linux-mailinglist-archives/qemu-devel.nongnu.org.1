Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F9766B60
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 13:08:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPKyS-0003Bq-73; Fri, 28 Jul 2023 06:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qPKyO-0003BT-HY
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 06:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qPKyM-0004Gi-3o
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 06:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690541125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pxySD38XjD4xlWbD4lOI1R22oxtNXjSLB++O6dJRVZA=;
 b=f7RijEKYTeDYinzwlab7IJnGvblf23uqXhrzKQiadFuz/e58O3UYodI8EqBTzp5V+4AZ9f
 xj8Qh2anjWFq43hnWBZM6D2FzYpf0d7SRK9vKifVms0yPEXAWQkopvwaMRMmzR2ZiApzlf
 /n8nCHY+8MLucpJEJF012xWyIH2mgo4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-vsUq1Ri5Ou6wgM_mvOO1gA-1; Fri, 28 Jul 2023 06:45:23 -0400
X-MC-Unique: vsUq1Ri5Ou6wgM_mvOO1gA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b70bfc97e4so22638001fa.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 03:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690541122; x=1691145922;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxySD38XjD4xlWbD4lOI1R22oxtNXjSLB++O6dJRVZA=;
 b=Hdk0OYrpQSt09YUcJ4qlAzbRqimcFSbiMXXD9zfNLz0UItyFxpnmMd5JBqQz+MFgGl
 eQDdXxv3pfRGKpk11nXneCeVhcRzFan8fpCuW9xxUB8pMz0ascr5JBP5Kq2/RfrqscWV
 cH5TnGe6YyeVPkmCYSFLKGfzSYYu9uffT9sLSj04O7oe8tpjijuwhxmKQ9DA9lttUOol
 eLDbggQmBDbtNFbngl/Ju0mJExCcZDpfuQRpx3f3Cm6d9Wij1EgCnlyL0luigdideP++
 QweScvoL8pFC5LXXoBD/uq0GYaWcRplZdyH4Awibl+2+TrD5So0qw97ozmjefMeO1RSq
 OlIg==
X-Gm-Message-State: ABy/qLaP5EJcfk8sHgYp2RYql8iP6z2OKJ5MRGbVB53V7pc6Jw7FXGUm
 HTUyF3Nev3zIAV2xvXnKU3rS3IX8lhRYKAYNO01iHVS3n15CbtnCP1ej6RqNFM67YrkI8+gh29K
 7yzU0k2qVX5nQ8n6kmwXXGW4=
X-Received: by 2002:a2e:2c0e:0:b0:2b8:4026:1f54 with SMTP id
 s14-20020a2e2c0e000000b002b840261f54mr1365002ljs.49.1690541122393; 
 Fri, 28 Jul 2023 03:45:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEUCiYi7wr5zkWZ+dM3hrXAhnFcpbxc1ydlHAZlQ4Epl9t7lNBBNuXOoXCv6Bpty1yxuYj6vg==
X-Received: by 2002:a2e:2c0e:0:b0:2b8:4026:1f54 with SMTP id
 s14-20020a2e2c0e000000b002b840261f54mr1364968ljs.49.1690541121888; 
 Fri, 28 Jul 2023 03:45:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871?
 (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de.
 [2003:cb:c706:6b00:bf49:f14b:380d:f871])
 by smtp.gmail.com with ESMTPSA id
 y26-20020a1c4b1a000000b003fc04eb92cbsm3850506wma.44.2023.07.28.03.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 03:45:21 -0700 (PDT)
Message-ID: <e2e82f40-2691-b947-bf06-bea0ded99eae@redhat.com>
Date: Fri, 28 Jul 2023 12:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] softmmu/physmem: try opening file readonly before
 failure in file_ram_open
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <20230726145912.88545-1-logoerthiner1@163.com>
 <183e16a8-55c3-7550-a9ff-21f31f65d0e5@redhat.com>
 <6bdbce7f.3e8e.18997f05e47.Coremail.logoerthiner1@163.com>
 <e908495c-252c-745c-036b-1b19778435d9@redhat.com>
 <615091df.3495.1899b089fc8.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <615091df.3495.1899b089fc8.Coremail.logoerthiner1@163.com>
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

On 28.07.23 07:46, ThinerLogoer wrote:
> Sorry my mail agent just have a bug

No worries :)

> 
> At 2023-07-28 02:30:09, "David Hildenbrand" <david@redhat.com> wrote:
>> On 27.07.23 17:20, ThinerLogoer wrote:
>>>
>>> At 2023-07-27 21:18:44, "David Hildenbrand" <david@redhat.com> wrote:
>>>> On 26.07.23 16:59, Thiner Logoer wrote:
>>>>> Users may give "-mem-path" a read only file and expect the file
>>>>> to be mapped read-write privately. Allow this but give a warning
>>>>> since other users may surprise when the ram file is readonly and
>>>>> qemu suddenly aborts elsewhere.
>>>>>
>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>> Signed-off-by: Thiner Logoer <logoerthiner1@163.com>
>>>>> ---
>>>>>
>>>>> See the previous version at:
>>>>> https://lore.kernel.org/qemu-devel/96a462ec-6f9d-fd83-f697-73e132432ca4@redhat.com/T/
>>>>>
>>>>> verified, this patch works for my setup, both functionality and the warning
>>>>> are expected behavior.
>>>>>
>>>>> Also another problem when I look at the file_ram_open
>>>>>
>>>>> When readonly is true and the path is a directory, the open will succeed but
>>>>> any later operations will fail since it is a directory fd. This may require
>>>>> additional commits which is out of my scope. Merely record the question here.
>>>
>>> Maybe you can notice this edge case? I am not sure whether this
>>> case is on your todo list?
>>
>> I guess we would have to check if we opened a directory. Should be easy to add.
>>
>> As long as QEMU fails reasonably well later, good for now :)
>>
>>>
>>>>>
>>>>>     softmmu/physmem.c | 14 ++++++++++++++
>>>>>     1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>>>>> index 3df73542e1..e8279d69d4 100644
>>>>> --- a/softmmu/physmem.c
>>>>> +++ b/softmmu/physmem.c
>>>>> @@ -1296,6 +1296,7 @@ static int file_ram_open(const char *path,
>>>>>         char *sanitized_name;
>>>>>         char *c;
>>>>>         int fd = -1;
>>>>> +    bool first_trial = true;
>>>>>     
>>>>>         *created = false;
>>>>>         for (;;) {
>>>>> @@ -1332,6 +1333,18 @@ static int file_ram_open(const char *path,
>>>>>                     break;
>>>>>                 }
>>>>>                 g_free(filename);
>>>>> +        } else if (first_trial && !readonly && errno == EACCES) {
>>>>
>>>> I guess it's better to only retry on private mappings, for shared
>>>> mappings that cannot possibly work.
>>>
>>> I feel that the retry can be applied in general - for shared mappings,
>>> it will merely fail on the mmap step and should be ok?
>>
>> I guess a proper "can't open backing store" message is better for the cases that obviously can't work.
>>
>>>
>>> Though, to retry only on private mapping seems straightforwards -
>>> this function is called only once, and whether the mapping is private
>>> can be passed here with a boolean flag as argument. Nonetheless
>>> it may make the logic of the function more complex and less intuitive.
>>
>> Quick untested attempt to move retry handling to the caller:
>>
>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>> index 3df73542e1..c826bb78fc 100644
>> --- a/softmmu/physmem.c
>> +++ b/softmmu/physmem.c
>> @@ -1289,8 +1289,7 @@ static int64_t get_file_align(int fd)
>>   static int file_ram_open(const char *path,
>>                            const char *region_name,
>>                            bool readonly,
> 
> For some reason this prereq part of patch has one additional space,
> which causes my `patch` to reject the patch. I have to manually
> fix it to test later.

Yes, to be expected. Pasting a "git show" diff always messes up 
whitespace for me. It was only meant as a POC.

> 
>> -                         bool *created,
>> -                         Error **errp)
>> +                         bool *created)
>>   {
>>       char *filename;
>>       char *sanitized_name;
>> @@ -1334,10 +1333,7 @@ static int file_ram_open(const char *path,
>>               g_free(filename);
>>           }
>>           if (errno != EEXIST && errno != EINTR) {
>> -            error_setg_errno(errp, errno,
>> -                             "can't open backing store %s for guest RAM",
>> -                             path);
>> -            return -1;
>> +            return -errno;
>>           }
>>           /*
>>            * Try again on EINTR and EEXIST.  The latter happens when
>> @@ -1946,9 +1942,23 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>>       bool created;
>>       RAMBlock *block;
>>   
>> -    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created,
>> -                       errp);
>> +    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created);
>> +    if (fd == -EACCES && !(ram_flags & RAM_SHARED) && readonly) {
> 
> "readonly" should be "!readonly" here? The readonly variable in this function is
> about whether the mapping is readonly. In our case the mapping is private
> writable, so readonly will be false.

Yes, indeed!

> 
> After manually fix this up, this patch also works in my environment, both
> functionality and the warning.
> 
> Maybe you can directly format the patch and start a new thread there?


Whatever you prefer! If I resend the patch, I would keep you the author 
and only add my Co-authored-by: Signed-off-by:.

Just let me know.

-- 
Cheers,

David / dhildenb


