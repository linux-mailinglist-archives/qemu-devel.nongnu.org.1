Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3A27FE985
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 08:11:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8bBN-0003nO-BT; Thu, 30 Nov 2023 02:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8bBK-0003nA-VL
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 02:09:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8bBJ-00007Q-3M
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 02:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701328191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5jMznOcmZIjXjINNROHEylog8pC9eJMqhfpCclJlTg=;
 b=hCmH1EbLPgb0NDrVMByUjxqzA/KAgxbf5Xeuqh0vaAdP+4hoZlEqG3R4Iuu+V+5Qog0N6C
 z6ap8VgvBAXLyBgO+aWVLC2WJIJeq5KcNbPIO/VQNYQZrlptJ7hG8zFi8wgrvwUx6qZqcl
 wyyZhYtrrfRMYsNfmjuamejbd9oAzLI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-IoBmG_6oN6SRy8tOubcJIw-1; Thu,
 30 Nov 2023 02:09:50 -0500
X-MC-Unique: IoBmG_6oN6SRy8tOubcJIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 033BD1C18CCD;
 Thu, 30 Nov 2023 07:09:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9206C40C6EB9;
 Thu, 30 Nov 2023 07:09:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81CFF21E6A1F; Thu, 30 Nov 2023 08:09:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 berrange@redhat.com,  peter.maydell@linaro.org,  farosas@suse.de
Subject: Re: [PATCH v3] migration: free 'channel' after its use in migration.c
References: <20231129080624.161578-1-het.gala@nutanix.com>
 <87fs0ok9i1.fsf@pond.sub.org>
 <80e9331a-0691-4bd1-8589-a78c2814e627@nutanix.com>
Date: Thu, 30 Nov 2023 08:09:48 +0100
In-Reply-To: <80e9331a-0691-4bd1-8589-a78c2814e627@nutanix.com> (Het Gala's
 message of "Thu, 30 Nov 2023 02:07:26 +0530")
Message-ID: <878r6fg1j7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Het Gala <het.gala@nutanix.com> writes:

> On 29/11/23 6:21 pm, Markus Armbruster wrote:
>> I'ld like to suggest a clearer subject:
>>
>>    migration: Plug memory leak with migration URIs
> Ack. Will update the commit message
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> 'channel' in qmp_migrate() and qmp_migrate_incoming() is not
>>> auto-freed. migrate_uri_parse() allocates memory to 'channel' if
>>
>> Not sure we need the first sentence.  QMP commands never free their
>> arguments.
>
> Ack.
>
>>> the user opts for old syntax - uri, which is leaked because there
>>> is no code for freeing 'channel'.
>>> So, free channel to avoid memory leak in case where 'channels'
>>> is empty and uri parsing is required.
>>> Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp
>>> migration flow")
>>>
>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>> Suggested-by: Markus Armbruster<armbru@redhat.com>
>>
>> Keep the Fixes: tag on a single line, and next to the other tags:
>>
>>    [...]
>>    is empty and uri parsing is required.
>>
>>    Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp migration flow")
>>    Signed-off-by: Het Gala<het.gala@nutanix.com>
>>    Suggested-by: Markus Armbruster<armbru@redhat.com>
>
> Ack.
>
> [...]
>
>>> +        addr = channels->value->addr;
>>>       } else if (uri) {
>>>           /* caller uses the old URI syntax */
>>>           if (!migrate_uri_parse(uri, &channel, errp)) {
>>>               return;
>>>           }
>>> +        addr = channel->addr;
>>>       } else {
>>>           error_setg(errp, "neither 'uri' or 'channels' argument are "
>>>                      "specified in 'migrate' qmp command ");
>>>           return;
>>>       }
>>> -    addr = channel->addr;
>>>         /* transport mechanism not suitable for migration? */
>>>       if (!migration_channels_and_transport_compatible(addr, errp)) {
>>
>> I tested this with an --enable-santizers build.  Before the patch:
>>
>>      $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -incoming unix:123
>>      ==3260873==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>>      QEMU 8.1.92 monitor - type 'help' for more information
>>      (qemu) q
>>
>>      =================================================================
>>      ==3260873==ERROR: LeakSanitizer: detected memory leaks
>>
>>      Direct leak of 40 byte(s) in 1 object(s) allocated from:
>>          #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
>>          #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
>>          #2 0x55b446454dbe in migrate_uri_parse ../migration/migration.c:490
>>          #3 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
>>          #4 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
>>          #5 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
>>          #6 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
>>          #7 0x55b446f63ca9 in main ../system/main.c:47
>>          #8 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)
>>
>>      Direct leak of 16 byte(s) in 1 object(s) allocated from:
>>          #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
>>          #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
>>          #2 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
>>          #3 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
>>          #4 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
>>          #5 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
>>          #6 0x55b446f63ca9 in main ../system/main.c:47
>>          #7 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)
>>
>>      Direct leak of 8 byte(s) in 1 object(s) allocated from:
>>          #0 0x7f0ba08bb1a8 in operator new(unsigned long) (/lib64/libasan.so.8+0xbb1a8)
>>          #1 0x7f0b9a9255b7 in _sub_I_65535_0.0 (/lib64/libtcmalloc_minimal.so.4+0xe5b7)
>>
>>      Indirect leak of 48 byte(s) in 1 object(s) allocated from:
>>          #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
>>          #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
>>          #2 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
>>          #3 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
>>          #4 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
>>          #5 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
>>          #6 0x55b446f63ca9 in main ../system/main.c:47
>>          #7 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)
>>
>>      Indirect leak of 4 byte(s) in 1 object(s) allocated from:
>>          #0 0x7f0ba08ba6af in __interceptor_malloc (/lib64/libasan.so.8+0xba6af)
>>          #1 0x7f0b9f4eb128 in g_malloc (/lib64/libglib-2.0.so.0+0x5f128)
>>
>>      SUMMARY: AddressSanitizer: 116 byte(s) leaked in 5 allocation(s).
>
> curious: how to get this stack trace ? I tried to configure and build qemu with --enable-santizers option, but on running the tests 'make -j test', I see:
>
> ==226453==LeakSanitizer has encountered a fatal error. ==226453==HINT: For debugging, try setting environment variable LSAN_OPTIONS=verbosity=1:log_threads=1 ==226453==HINT: LeakSanitizer does not work under ptrace (strace, gdb, etc)

I built with

    $ ../configure --disable-werror --target-list=x86_64-softmmu --enable-debug --enable-sanitizers 
    $ make

then ran the manual test shown above.

"make check" fails differently for me than it does for you.

[...]


