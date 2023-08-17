Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E5B77F802
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:45:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdIf-00009Q-RG; Thu, 17 Aug 2023 09:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWdId-00008t-PI
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWdIb-0002hN-8M
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692279868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5R51J+nDM2wfUzUg31hdTfhiRH43XtIZxGGccgWUKXA=;
 b=dDx4iZhmBEwn5jYf3QpwkMhZtUEbXVSIgZX+E0aliaEExu4IcoxD3zL9hHvvChFL72H/+F
 jF/CfNj2FiliQnPy5kuNe9M+Y63sAQc5Vonr2qfjHS6DB3lo5p2J8ybzHlVj1bgRmv7WL7
 dlpvRwo2kBLoV6HDiDoKp/N+HoqebGQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-UQQXcYTRNImDe6nkJiJ8qg-1; Thu, 17 Aug 2023 09:44:27 -0400
X-MC-Unique: UQQXcYTRNImDe6nkJiJ8qg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31ad77537ebso445089f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 06:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279866; x=1692884666;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5R51J+nDM2wfUzUg31hdTfhiRH43XtIZxGGccgWUKXA=;
 b=Uxzx51s9BLgMqZmjyJSRst6WBJWgfxs5fIQSxFRPZjzE+zM0rJhvFIsyArX6k4Sj/S
 D6az/+GeNUSLjFZSKkC/V656kltaXzPl3QM8mcDx0R5GGPqAS1dMSv0DCu7f5/V2OtUX
 EWy/yaIyJhcUEgVq7x0ZIIJpP66mRy57AM798LnmljhNnNGRFxA706K+V11rqWcs9obt
 vvOZWTlXsWktkyxZ+UxqSC3JOy4Gv9oNgUl96UvI8jUZJjZImMai00ZYQoRNCLxNRWEJ
 4vCeViQZX8NrMIR8CjHjAi1tZxwDX9T9gMKtnDlgc/LEs/V6pYatdOoWpYxB2rfPGmRc
 mpMw==
X-Gm-Message-State: AOJu0YwiN85nj+6z2GM5rIVN+ur5QszYW3kPihvGcK5I8eo8a9KdqJwv
 hMfDOIZ3xBl0eOjiUi5aq/1E2FuM1M8Wf4u5ijqKBmAOWjl9Gz2C+qJON3no3p13Ot/QT+LKEEf
 b4ijfEH6GVSzsvak=
X-Received: by 2002:adf:dd84:0:b0:317:4bdc:6f34 with SMTP id
 x4-20020adfdd84000000b003174bdc6f34mr4393885wrl.64.1692279866285; 
 Thu, 17 Aug 2023 06:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH74eQza2p1DD92nvKWUlnzw7rLgT58i024suJMfdbSPDozW4pOCpbMqhZRcv0XVWEP1RJSCQ==
X-Received: by 2002:adf:dd84:0:b0:317:4bdc:6f34 with SMTP id
 x4-20020adfdd84000000b003174bdc6f34mr4393859wrl.64.1692279865867; 
 Thu, 17 Aug 2023 06:44:25 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 f25-20020a7bcd19000000b003fe2f3a89d4sm3136934wmj.7.2023.08.17.06.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 06:44:25 -0700 (PDT)
Message-ID: <5aebab33-b39f-92b5-6d1e-070a71d95b58@redhat.com>
Date: Thu, 17 Aug 2023 15:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZN4iporZWZGqc2gU@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
In-Reply-To: <ZN4iporZWZGqc2gU@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 17.08.23 15:37, Daniel P. Berrangé wrote:
> On Mon, Aug 07, 2023 at 09:07:32PM +0200, David Hildenbrand wrote:
>> From: Thiner Logoer <logoerthiner1@163.com>
>>
>> Users may specify
>> * "-mem-path" or
>> * "-object memory-backend-file,share=off,readonly=off"
>> and expect such COW (MAP_PRIVATE) mappings to work, even if the user
>> does not have write permissions to open the file.
>>
>> For now, we would always fail in that case, always requiring file write
>> permissions. Let's detect when that failure happens and fallback to opening
>> the file readonly.
>>
>> Warn the user, since there are other use cases where we want the file to
>> be mapped writable: ftruncate() and fallocate() will fail if the file
>> was not opened with write permissions.
>>
>> Signed-off-by: Thiner Logoer <logoerthiner1@163.com>
>> Co-developed-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   softmmu/physmem.c | 26 ++++++++++++++++++--------
>>   1 file changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>> index 3df73542e1..d1ae694b20 100644
>> --- a/softmmu/physmem.c
>> +++ b/softmmu/physmem.c
>> @@ -1289,8 +1289,7 @@ static int64_t get_file_align(int fd)
>>   static int file_ram_open(const char *path,
>>                            const char *region_name,
>>                            bool readonly,
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
>> +    if (fd == -EACCES && !(ram_flags & RAM_SHARED) && !readonly) {
>> +        /*
>> +         * We can have a writable MAP_PRIVATE mapping of a readonly file.
>> +         * However, some operations like ftruncate() or fallocate() might fail
>> +         * later, let's warn the user.
>> +         */
>> +        fd = file_ram_open(mem_path, memory_region_name(mr), true, &created);
>> +        if (fd >= 0) {
>> +            warn_report("backing store %s for guest RAM (MAP_PRIVATE) opened"
>> +                        " readonly because the file is not writable", mem_path);
> 
> IIUC, from the description, the goal is that usage of a readonly
> backing store is intented to be an explicitly supported deployment
> configuration. At the time time though, this scenario could also be
> a deployment mistake that we want to diagnose

FWIW, I abandoned this approach here and instead will look into making

memory-backend-file,readonly=on,share=off

create RAM instead of ROM.

The fallback was wrong after realizing what "readonly" actually is 
supposed to do.

I stared at libvirt, an even it never seems to set readonly=on for R/O 
DIMMs, so you always get RAM and then tell the nvdimm device to not 
perform any writes (unarmed=on)

-- 
Cheers,

David / dhildenb


