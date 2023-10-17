Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7DB7CC4A1
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:20:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjzU-0007A3-Eg; Tue, 17 Oct 2023 09:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qsjzJ-0006r0-PL; Tue, 17 Oct 2023 09:19:58 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qsjzH-0007fE-Sd; Tue, 17 Oct 2023 09:19:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2737721D1B;
 Tue, 17 Oct 2023 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697548792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EMrhxDlPxtCjyRvyigcjTXAm1LViD8GGRk/5OdgV7dk=;
 b=I/1yNUDno4nCbdqqs5ZWdsiFyiZ4PY8p62JBV9GfqoyX8fybur6/WQsNJk/7RPDE6hYdPG
 qE1YJO7mj/c5WbQ+G1eb+pGiSn02yhlipxngGi/stYsBu4Itga+miIswjIOHx/DZdGCj70
 n/CMbn6DN8zn5nCH1lXPXVdmWfsJLdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697548792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EMrhxDlPxtCjyRvyigcjTXAm1LViD8GGRk/5OdgV7dk=;
 b=sWNIThMN8vvKBN7MKPTdTqxTenscLEqjYrDhQmfn+7Vs1MHwUb+Nr5Q2kzumUKnrQcT5OP
 4yDlVDa3GqpFp+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A50D213584;
 Tue, 17 Oct 2023 13:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /yKzHPeJLmVYcAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 17 Oct 2023 13:19:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Fam Zheng <fam@euphon.net>, Cleber Rosa
 <crosa@redhat.com>, Eric Blake <eblake@redhat.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 11/38] tests/qtest: migration-test: Add tests for
 file-based migration
In-Reply-To: <87pm1d1k8p.fsf@secure.mitica>
References: <20231016100706.2551-1-quintela@redhat.com>
 <20231016100706.2551-12-quintela@redhat.com> <87sf6azapv.fsf@suse.de>
 <87bkcx3eab.fsf@secure.mitica> <8734y9xwfy.fsf@suse.de>
 <87pm1d1k8p.fsf@secure.mitica>
Date: Tue, 17 Oct 2023 10:19:49 -0300
Message-ID: <87wmvlwfm2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[16];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Juan Quintela <quintela@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> Fabiano Rosas <farosas@suse.de> wrote:
>>> D> Juan Quintela <quintela@redhat.com> writes:
>>>>
>>>>> From: Fabiano Rosas <farosas@suse.de>
>>>>>
>>>>> Add basic tests for file-based migration.
>>>>>
>>>>> Note that we cannot use test_precopy_common because that routine
>>>>> expects it to be possible to run the migration live. With the file
>>>>> transport there is no live migration because we must wait for the
>>>>> source to finish writing the migration data to the file before the
>>>>> destination can start reading. Add a new migration function
>>>>> specifically to handle the file migration.
>>>>>
>>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>>> Message-ID: <20230712190742.22294-7-farosas@suse.de>
>>>
>>>>> +static void file_offset_finish_hook(QTestState *from, QTestState *to,
>>>>> +                                    void *opaque)
>>>>> +{
>>>>> +#if defined(__linux__)
>>>>> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>>>>> +    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
>>>>> +    uintptr_t *addr, *p;
>>>>> +    int fd;
>>>>> +
>>>>> +    fd = open(path, O_RDONLY);
>>>>> +    g_assert(fd != -1);
>>>>> +    addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
>>>>> +    g_assert(addr != MAP_FAILED);
>>>>> +
>>>>> +    /*
>>>>> +     * Ensure the skipped offset contains zeros and the migration
>>>>> +     * stream starts at the right place.
>>>>> +     */
>>>>> +    p = addr;
>>>>> +    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
>>>>> +        g_assert(*p == 0);
>>>>> +        p++;
>>>>> +    }
>>>>> +    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);
>>>>
>>>> This truncates to 32-bits, so it breaks on a BE host. We need this:
>>>>
>>>> -->8--
>>>> From ea0c2d1c988add48d9754891a9fc7f6854a9718a Mon Sep 17 00:00:00 2001
>>>> From: Fabiano Rosas <farosas@suse.de>
>>>> Date: Mon, 16 Oct 2023 15:21:49 -0300
>>>> Subject: [PATCH] fixup! tests/qtest: migration-test: Add tests for file-based
>>>>  migration
>>>>
>>>> ---
>>>>  tests/qtest/migration-test.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>>> index da02b6d692..e1c110537b 100644
>>>> --- a/tests/qtest/migration-test.c
>>>> +++ b/tests/qtest/migration-test.c
>>>> @@ -1966,7 +1966,7 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
>>>>          g_assert(*p == 0);
>>>>          p++;
>>>>      }
>>>> -    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);
>>>> +    g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
>>>>  
>>>>      munmap(addr, size);
>>>>      close(fd);
>>>
>>> I am resubmitting with this change.
>>>
>>> But I think we need to change this:
>>>
>>>>> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>>>>> +    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
>>>>> +    uintptr_t *addr, *p;
>>>
>>> I think we should change the test so the file is 64 bits on every
>>> architecture.
>>> Then we can cast to void * or uintptr_t as needed.
>>
>> Hm, I don't get what you mean here. What needs to be 64 bits?
>
> size_t is 32 bits on 32bits host, and 64 bits on 64 bits host.
> uintprt_t is the same.

Right, I have thought of that when writing this fix yesterday, but I
dismissed it because I thought we were never have a 32bit host running
these tests.

> So using explicit sizes:
>
> static void file_offset_finish_hook(QTestState *from, QTestState *to,
>                                     void *opaque)
> {
> #if defined(__linux__)
>     g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>     size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
>     uint64_t *addr, *p;
>     int fd;
>
>     fd = open(path, O_RDONLY);
>     g_assert(fd != -1);
>     addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
>     g_assert(addr != MAP_FAILED);
>
>     /*
>      * Ensure the skipped offset contains zeros and the migration
>      * stream starts at the right place.
>      */
>     p = addr;
>     while (p < (uintprt_t)addr + FILE_TEST_OFFSET) {
>         g_assert(*p == 0);
>         p++;
>     }
>     g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
>
>     munmap(addr, size);
>     close(fd);
> #endif
> }
>
> This is completely untested, but it should make sure that we are reading
> 64bits integers in both 32 and 64 bits hosts, no?

Looks like it. I can give it a try and send an update as a separate
patch.

