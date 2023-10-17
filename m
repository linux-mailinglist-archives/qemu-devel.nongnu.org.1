Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADACE7CC3F3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:07:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjcO-00040Y-Mb; Tue, 17 Oct 2023 08:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsjbu-0003uS-K0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsjbq-0002hX-Df
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697547339;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vn+Cq51kYrUOhFi8ei0HDoT3ObldOMNE/Gxh0pp/kis=;
 b=SIfpswYd3LJlaRYlTwpjcwFq7p1A20dPFOW8P5/q7028PAs0zH9sjftDER2PNJmU8GFt8M
 yxMnaBDvULxC8TdTKkKiddxMIBoAfMzbTUUmdVXHuhG11Gl85PipRZoGYumuP1IgZsG7Jz
 EndGNNxYUzFDZBxUB7dc8NSmDs7gelQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-arwq8UdPNjimtqkf0e9MZg-1; Tue, 17 Oct 2023 08:55:37 -0400
X-MC-Unique: arwq8UdPNjimtqkf0e9MZg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5079a66711eso3898550e87.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697547336; x=1698152136;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vn+Cq51kYrUOhFi8ei0HDoT3ObldOMNE/Gxh0pp/kis=;
 b=s/Gp7iqFW8fhv9/aDjTuYuDINK2yCx3POfa3wMJkq7pAybibYWIDyvE8UCr9MQCt9G
 aNEgZEbGOA8pYJmpSAU+qxdm058tMRT3f+9izQUhnOiPLCFwAbHDuHXzc733DP5ZJl3Q
 JXarDRz0/pom7ERwu4FY4UkH/GAZ4m+5vPzjjsUZe0AwMxh34kLpgPBT2EJuxL2arpOo
 50+7Dg9KmMQBKW8MXJOw4WXr8vC0IG9OKc/OL/ttDXgDcmTQLc7pLS3evBuUFKEZxK9c
 G4+lWtOytXWtwRijGkG2dinB/SDFyuMP/DysMXi5XT826l5nOJbQ2VzzXxzTLYOpAxy9
 k+XQ==
X-Gm-Message-State: AOJu0YwQywWSxm0edG9GojGkepPzAdoN82IOIOuw5Q++AB4wTkrQZIns
 mTTdK4lVJG8OBZZiYcsezJ7rm6MXz6MJN32iBarzGMFRe0vjgGVrhE3r4JTHkLKPQIIDnYj34oS
 ntNqbeFcO0UyIRgw=
X-Received: by 2002:a05:6512:3b0c:b0:502:fdca:2eaa with SMTP id
 f12-20020a0565123b0c00b00502fdca2eaamr2125521lfv.52.1697547336225; 
 Tue, 17 Oct 2023 05:55:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIgDrjzf9R1xBKl72b+uYJBQBeV/EbN/loufKUkEOC4j5AAGQQhDVRJV1DQ4YtdEEH2zI4Ow==
X-Received: by 2002:a05:6512:3b0c:b0:502:fdca:2eaa with SMTP id
 f12-20020a0565123b0c00b00502fdca2eaamr2125495lfv.52.1697547335864; 
 Tue, 17 Oct 2023 05:55:35 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f20-20020a05600c155400b0040472ad9a3dsm1892374wmg.14.2023.10.17.05.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 05:55:35 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Fam Zheng <fam@euphon.net>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Li Zhijian
 <lizhijian@fujitsu.com>,  Peter Xu <peterx@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  John Snow <jsnow@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 11/38] tests/qtest: migration-test: Add tests for
 file-based migration
In-Reply-To: <8734y9xwfy.fsf@suse.de> (Fabiano Rosas's message of "Tue, 17 Oct
 2023 09:30:57 -0300")
References: <20231016100706.2551-1-quintela@redhat.com>
 <20231016100706.2551-12-quintela@redhat.com> <87sf6azapv.fsf@suse.de>
 <87bkcx3eab.fsf@secure.mitica> <8734y9xwfy.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 14:55:34 +0200
Message-ID: <87pm1d1k8p.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> wrote:
>> D> Juan Quintela <quintela@redhat.com> writes:
>>>
>>>> From: Fabiano Rosas <farosas@suse.de>
>>>>
>>>> Add basic tests for file-based migration.
>>>>
>>>> Note that we cannot use test_precopy_common because that routine
>>>> expects it to be possible to run the migration live. With the file
>>>> transport there is no live migration because we must wait for the
>>>> source to finish writing the migration data to the file before the
>>>> destination can start reading. Add a new migration function
>>>> specifically to handle the file migration.
>>>>
>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>> Message-ID: <20230712190742.22294-7-farosas@suse.de>
>>
>>>> +static void file_offset_finish_hook(QTestState *from, QTestState *to,
>>>> +                                    void *opaque)
>>>> +{
>>>> +#if defined(__linux__)
>>>> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>>>> +    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
>>>> +    uintptr_t *addr, *p;
>>>> +    int fd;
>>>> +
>>>> +    fd = open(path, O_RDONLY);
>>>> +    g_assert(fd != -1);
>>>> +    addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
>>>> +    g_assert(addr != MAP_FAILED);
>>>> +
>>>> +    /*
>>>> +     * Ensure the skipped offset contains zeros and the migration
>>>> +     * stream starts at the right place.
>>>> +     */
>>>> +    p = addr;
>>>> +    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
>>>> +        g_assert(*p == 0);
>>>> +        p++;
>>>> +    }
>>>> +    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);
>>>
>>> This truncates to 32-bits, so it breaks on a BE host. We need this:
>>>
>>> -->8--
>>> From ea0c2d1c988add48d9754891a9fc7f6854a9718a Mon Sep 17 00:00:00 2001
>>> From: Fabiano Rosas <farosas@suse.de>
>>> Date: Mon, 16 Oct 2023 15:21:49 -0300
>>> Subject: [PATCH] fixup! tests/qtest: migration-test: Add tests for file-based
>>>  migration
>>>
>>> ---
>>>  tests/qtest/migration-test.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>> index da02b6d692..e1c110537b 100644
>>> --- a/tests/qtest/migration-test.c
>>> +++ b/tests/qtest/migration-test.c
>>> @@ -1966,7 +1966,7 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
>>>          g_assert(*p == 0);
>>>          p++;
>>>      }
>>> -    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);
>>> +    g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
>>>  
>>>      munmap(addr, size);
>>>      close(fd);
>>
>> I am resubmitting with this change.
>>
>> But I think we need to change this:
>>
>>>> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>>>> +    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
>>>> +    uintptr_t *addr, *p;
>>
>> I think we should change the test so the file is 64 bits on every
>> architecture.
>> Then we can cast to void * or uintptr_t as needed.
>
> Hm, I don't get what you mean here. What needs to be 64 bits?

size_t is 32 bits on 32bits host, and 64 bits on 64 bits host.
uintprt_t is the same.

So using explicit sizes:

static void file_offset_finish_hook(QTestState *from, QTestState *to,
                                    void *opaque)
{
#if defined(__linux__)
    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
    uint64_t *addr, *p;
    int fd;

    fd = open(path, O_RDONLY);
    g_assert(fd != -1);
    addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
    g_assert(addr != MAP_FAILED);

    /*
     * Ensure the skipped offset contains zeros and the migration
     * stream starts at the right place.
     */
    p = addr;
    while (p < (uintprt_t)addr + FILE_TEST_OFFSET) {
        g_assert(*p == 0);
        p++;
    }
    g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);

    munmap(addr, size);
    close(fd);
#endif
}

This is completely untested, but it should make sure that we are reading
64bits integers in both 32 and 64 bits hosts, no?

And yes, for migration, in case of doubt, we use 64bits.  I know it is
unfair for 32 bits host architectures, but they basically don't exist
anymore.

Later, Juan.


