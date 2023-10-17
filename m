Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4E7CC4C7
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:32:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskA4-0001Tq-SZ; Tue, 17 Oct 2023 09:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsk9t-0001Qu-In
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsk9r-0001bg-Ri
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697549450;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zKPs+vg5r3pIWvsjc4pPR7PwuGrodKiG+5foWBs0SrA=;
 b=iIwTBu4jqEvA6x+mPOlB8QPu6qBIqhK9xbUXOuU7V9tDcfVVYKA0o3pI89waaqGLM8oUmT
 axIRZuXDUYYg20MQ3gePFehFWA0yOObon4c20xiLlJtJxel9gixEAJp/aXFgoDEdMZ8mCG
 kJkvQ/YJO6SGCPEpZZmB4ncXwBjUt18=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-UUMzhBKRNxuzCx3Ws7oZ2w-1; Tue, 17 Oct 2023 09:30:48 -0400
X-MC-Unique: UUMzhBKRNxuzCx3Ws7oZ2w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso42060825e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697549447; x=1698154247;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zKPs+vg5r3pIWvsjc4pPR7PwuGrodKiG+5foWBs0SrA=;
 b=TD1g0P09jORQK1dBRuVnp3pXWNCZFuGlhyUrlbLI4q4bAoWMn/4vxNuRAVGo+zXISR
 f4gwx/lYKrUfVyybEkW++RluG9k1p2PnPAM4FV9i7d7NiDVFhUJB5UazVtKUef+ZTylH
 k1seVmwn4ae38TjAUJkX+XO3UVkVRClAbzylanP8PEEXb++NNW3Bsb5+AKSQiJ4vKMTK
 8X02lbkgqVRT8LofNEJGXET3LQNDoK2vpc9+mDbwj7v7zFXNyI7G94oaVsEylznitUY5
 mzyLRyTsDMHZlroe2myQ/Fq3W9MMkha2RR2MTvm2XU7jxiz+7mB7bpkl1+Y2xZhMlIeO
 7GEg==
X-Gm-Message-State: AOJu0YyciNe3G5p3hlCpo10gWcXts9iWF7PMbPb8MQrPvpVw92bI6jEy
 maqw3QEZQJiXYxF8gVwywJOhPXu4W5V9aDo9h3yOA+XZ+lSv0L/kn9vczcW84HwRpQj15dmkHTp
 bcwtXyl99roillSo=
X-Received: by 2002:a05:600c:358e:b0:405:4776:735a with SMTP id
 p14-20020a05600c358e00b004054776735amr1703440wmq.2.1697549447686; 
 Tue, 17 Oct 2023 06:30:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeBB4ElPiXOeFWZDBSBxiex8vVMYFUDmdWYqzGsdXvsIHCTxk2FJ+UdfZgU4due6IQCUcooQ==
X-Received: by 2002:a05:600c:358e:b0:405:4776:735a with SMTP id
 p14-20020a05600c358e00b004054776735amr1703402wmq.2.1697549447227; 
 Tue, 17 Oct 2023 06:30:47 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 t15-20020a05600c198f00b004077227bcdesm9904110wmq.26.2023.10.17.06.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 06:30:46 -0700 (PDT)
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
In-Reply-To: <87wmvlwfm2.fsf@suse.de> (Fabiano Rosas's message of "Tue, 17 Oct
 2023 10:19:49 -0300")
References: <20231016100706.2551-1-quintela@redhat.com>
 <20231016100706.2551-12-quintela@redhat.com> <87sf6azapv.fsf@suse.de>
 <87bkcx3eab.fsf@secure.mitica> <8734y9xwfy.fsf@suse.de>
 <87pm1d1k8p.fsf@secure.mitica> <87wmvlwfm2.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 15:30:45 +0200
Message-ID: <87edht1im2.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[..]

>>>> I am resubmitting with this change.
>>>>
>>>> But I think we need to change this:
>>>>
>>>>>> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>>>>>> +    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
>>>>>> +    uintptr_t *addr, *p;
>>>>
>>>> I think we should change the test so the file is 64 bits on every
>>>> architecture.
>>>> Then we can cast to void * or uintptr_t as needed.
>>>
>>> Hm, I don't get what you mean here. What needs to be 64 bits?
>>
>> size_t is 32 bits on 32bits host, and 64 bits on 64 bits host.
>> uintprt_t is the same.
>
> Right, I have thought of that when writing this fix yesterday, but I
> dismissed it because I thought we were never have a 32bit host running
> these tests.
>
>> So using explicit sizes:
>>
>> static void file_offset_finish_hook(QTestState *from, QTestState *to,
>>                                     void *opaque)
>> {
>> #if defined(__linux__)
>>     g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>>     size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
>>     uint64_t *addr, *p;
>>     int fd;
>>
>>     fd = open(path, O_RDONLY);
>>     g_assert(fd != -1);
>>     addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
>>     g_assert(addr != MAP_FAILED);
>>
>>     /*
>>      * Ensure the skipped offset contains zeros and the migration
>>      * stream starts at the right place.
>>      */
>>     p = addr;
>>     while (p < (uintprt_t)addr + FILE_TEST_OFFSET) {
>>         g_assert(*p == 0);
>>         p++;
>>     }
>>     g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
>>
>>     munmap(addr, size);
>>     close(fd);
>> #endif
>> }
>>
>> This is completely untested, but it should make sure that we are reading
>> 64bits integers in both 32 and 64 bits hosts, no?
>
> Looks like it. I can give it a try and send an update as a separate
> patch.

Send the update against migration-20231017 please.
That branch is on github and the patches are on the PULL request on the
list.

Thanks, Juan.


