Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A77FD822
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 14:31:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8KeA-0001NS-0Z; Wed, 29 Nov 2023 08:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r8Kdv-0001Kd-KM
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:30:27 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r8Kdt-0006Q9-3P
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:30:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E45001FCE6;
 Wed, 29 Nov 2023 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701264612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bFT/6L9C2+pDny35hY0HfxLhuba9/lKE6ZecHIZESBU=;
 b=0GpM3Yr16kxbLJrlw7hZ937B/HCie8OKFBfyN50CGxynhVU9gwK23p1itpu/AbqqNb6ggS
 /C+GEHpBvY+BuVrIK2nfznZzmY2uol4uLj27gfCeRn4VkTMqDN7WJ1Ab8wC31JpcKwxQPF
 8ho22Bdyu3x/ewmcsJ1EBfNblwJzBq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701264612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bFT/6L9C2+pDny35hY0HfxLhuba9/lKE6ZecHIZESBU=;
 b=8JFka7ecr25SjzW+HX9TXuNCEV2oD3//G5BLgHMbPDvhf8MDwJ87uehrDsu0ka+oxKLok6
 IT7DfP1Zpx87ZABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6687A13A9A;
 Wed, 29 Nov 2023 13:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xtXGC+Q8Z2WfRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Nov 2023 13:30:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v3] migration: free 'channel' after its use in migration.c
In-Reply-To: <87fs0ok9i1.fsf@pond.sub.org>
References: <20231129080624.161578-1-het.gala@nutanix.com>
 <87fs0ok9i1.fsf@pond.sub.org>
Date: Wed, 29 Nov 2023 10:29:58 -0300
Message-ID: <871qc8bsbt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nutanix.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> I'ld like to suggest a clearer subject:
>
>   migration: Plug memory leak with migration URIs
>
> Het Gala <het.gala@nutanix.com> writes:
>
>> 'channel' in qmp_migrate() and qmp_migrate_incoming() is not
>> auto-freed. migrate_uri_parse() allocates memory to 'channel' if
>
> Not sure we need the first sentence.  QMP commands never free their
> arguments.
>
>> the user opts for old syntax - uri, which is leaked because there
>> is no code for freeing 'channel'.
>> So, free channel to avoid memory leak in case where 'channels'
>> is empty and uri parsing is required.
>> Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp
>> migration flow")
>>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>
> Keep the Fixes: tag on a single line, and next to the other tags:
>
>   [...]
>   is empty and uri parsing is required.
>
>   Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp migration flow")
>   Signed-off-by: Het Gala <het.gala@nutanix.com>
>   Suggested-by: Markus Armbruster <armbru@redhat.com>
>
>> ---
>>  migration/migration.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 28a34c9068..34340f3440 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -515,7 +515,7 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>                                            MigrationChannelList *channels,
>>                                            Error **errp)
>>  {
>> -    MigrationChannel *channel = NULL;
>> +    g_autoptr(MigrationChannel) channel = NULL;
>>      MigrationAddress *addr = NULL;
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>>  
>> @@ -533,18 +533,18 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>              error_setg(errp, "Channel list has more than one entries");
>>              return;
>>          }
>> -        channel = channels->value;
>> +        addr = channels->value->addr;
>>      } else if (uri) {
>>          /* caller uses the old URI syntax */
>>          if (!migrate_uri_parse(uri, &channel, errp)) {
>>              return;
>>          }
>> +        addr = channel->addr;
>>      } else {
>>          error_setg(errp, "neither 'uri' or 'channels' argument are "
>>                     "specified in 'migrate-incoming' qmp command ");
>>          return;
>>      }
>> -    addr = channel->addr;
>>  
>>      /* transport mechanism not suitable for migration? */
>>      if (!migration_channels_and_transport_compatible(addr, errp)) {
>> @@ -1932,7 +1932,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>>      bool resume_requested;
>>      Error *local_err = NULL;
>>      MigrationState *s = migrate_get_current();
>> -    MigrationChannel *channel = NULL;
>> +    g_autoptr(MigrationChannel) channel = NULL;
>>      MigrationAddress *addr = NULL;
>>  
>>      /*
>> @@ -1949,18 +1949,18 @@ void qmp_migrate(const char *uri, bool has_channels,
>>              error_setg(errp, "Channel list has more than one entries");
>>              return;
>>          }
>> -        channel = channels->value;
>> +        addr = channels->value->addr;
>>      } else if (uri) {
>>          /* caller uses the old URI syntax */
>>          if (!migrate_uri_parse(uri, &channel, errp)) {
>>              return;
>>          }
>> +        addr = channel->addr;
>>      } else {
>>          error_setg(errp, "neither 'uri' or 'channels' argument are "
>>                     "specified in 'migrate' qmp command ");
>>          return;
>>      }
>> -    addr = channel->addr;
>>  
>>      /* transport mechanism not suitable for migration? */
>>      if (!migration_channels_and_transport_compatible(addr, errp)) {
>
> I tested this with an --enable-santizers build.  Before the patch:
>
>     $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -incoming unix:123
>     ==3260873==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>     QEMU 8.1.92 monitor - type 'help' for more information
>     (qemu) q
>
>     =================================================================
>     ==3260873==ERROR: LeakSanitizer: detected memory leaks
>
>     Direct leak of 40 byte(s) in 1 object(s) allocated from:
>         #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
>         #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
>         #2 0x55b446454dbe in migrate_uri_parse ../migration/migration.c:490
>         #3 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
>         #4 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
>         #5 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
>         #6 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
>         #7 0x55b446f63ca9 in main ../system/main.c:47
>         #8 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)
>
>     Direct leak of 16 byte(s) in 1 object(s) allocated from:
>         #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
>         #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
>         #2 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
>         #3 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
>         #4 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
>         #5 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
>         #6 0x55b446f63ca9 in main ../system/main.c:47
>         #7 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)
>
>     Direct leak of 8 byte(s) in 1 object(s) allocated from:
>         #0 0x7f0ba08bb1a8 in operator new(unsigned long) (/lib64/libasan.so.8+0xbb1a8)
>         #1 0x7f0b9a9255b7 in _sub_I_65535_0.0 (/lib64/libtcmalloc_minimal.so.4+0xe5b7)
>
>     Indirect leak of 48 byte(s) in 1 object(s) allocated from:
>         #0 0x7f0ba08ba097 in calloc (/lib64/libasan.so.8+0xba097)
>         #1 0x7f0b9f4eb5b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
>         #2 0x55b4464557c9 in qemu_start_incoming_migration ../migration/migration.c:539
>         #3 0x55b446461687 in qmp_migrate_incoming ../migration/migration.c:1734
>         #4 0x55b4463df1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
>         #5 0x55b4463e4d8e in qemu_init ../system/vl.c:3753
>         #6 0x55b446f63ca9 in main ../system/main.c:47
>         #7 0x7f0b9d04a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)
>
>     Indirect leak of 4 byte(s) in 1 object(s) allocated from:
>         #0 0x7f0ba08ba6af in __interceptor_malloc (/lib64/libasan.so.8+0xba6af)
>         #1 0x7f0b9f4eb128 in g_malloc (/lib64/libglib-2.0.so.0+0x5f128)
>
>     SUMMARY: AddressSanitizer: 116 byte(s) leaked in 5 allocation(s).
>
>
> Afterwards:
>
>     ==3260526==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>     QEMU 8.1.92 monitor - type 'help' for more information
>     (qemu) q
>
>     =================================================================
>     ==3260526==ERROR: LeakSanitizer: detected memory leaks
>
>     Direct leak of 40 byte(s) in 1 object(s) allocated from:
>         #0 0x7f97e54ba097 in calloc (/lib64/libasan.so.8+0xba097)
>         #1 0x7f97e41c75b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x5f5b0)
>         #2 0x55ae31b02dbe in migrate_uri_parse ../migration/migration.c:490
>         #3 0x55ae31b0382c in qemu_start_incoming_migration ../migration/migration.c:539
>         #4 0x55ae31b0f724 in qmp_migrate_incoming ../migration/migration.c:1734
>         #5 0x55ae31a8d1c2 in qmp_x_exit_preconfig ../system/vl.c:2718
>         #6 0x55ae31a92d8e in qemu_init ../system/vl.c:3753
>         #7 0x55ae32611de2 in main ../system/main.c:47
>         #8 0x7f97e1c4a54f in __libc_start_call_main (/lib64/libc.so.6+0x2754f)
>
>     Direct leak of 8 byte(s) in 1 object(s) allocated from:
>         #0 0x7f97e54bb1a8 in operator new(unsigned long) (/lib64/libasan.so.8+0xbb1a8)
>         #1 0x7f97df6055b7 in _sub_I_65535_0.0 (/lib64/libtcmalloc_minimal.so.4+0xe5b7)
>
>     SUMMARY: AddressSanitizer: 48 byte(s) leaked in 2 allocation(s).
>
> This confirms the patch succeeds at plugging leaks the -incoming path.
> It also shows there's one left in migrate_uri_parse():
>
>     bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>                            Error **errp)
>     {
>         g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
>         g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>         SocketAddress *saddr = NULL;
>
> Useless initializer.
>
>         InetSocketAddress *isock = &addr->u.rdma;
>         strList **tail = &addr->u.exec.args;
>
>         if (strstart(uri, "exec:", NULL)) {
>             addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
>     #ifdef WIN32
>             QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
>             QAPI_LIST_APPEND(tail, g_strdup("/c"));
>     #else
>             QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
>             QAPI_LIST_APPEND(tail, g_strdup("-c"));
>     #endif
>             QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
>         } else if (strstart(uri, "rdma:", NULL)) {
>             if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
>                 qapi_free_InetSocketAddress(isock);
>                 return false;
>             }
>             addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
>         } else if (strstart(uri, "tcp:", NULL) ||
>                     strstart(uri, "unix:", NULL) ||
>                     strstart(uri, "vsock:", NULL) ||
>                     strstart(uri, "fd:", NULL)) {
>
> Aside: indentation is off.
>
>             addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
>             saddr = socket_parse(uri, errp);
>
> @saddr allocated.
>
>             if (!saddr) {
>                 return false;
>             }
>             addr->u.socket.type = saddr->type;
>             addr->u.socket.u = saddr->u;
>
> Members of @saddr copied into @addr.
>
>         } else if (strstart(uri, "file:", NULL)) {
>             addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
>             addr->u.file.filename = g_strdup(uri + strlen("file:"));
>             if (file_parse_offset(addr->u.file.filename, &addr->u.file.offset,
>                                   errp)) {
>                 return false;
>             }
>         } else {
>             error_setg(errp, "unknown migration protocol: %s", uri);
>             return false;
>         }
>
>         val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
>         val->addr = g_steal_pointer(&addr);
>         *channel = g_steal_pointer(&val);
>
> @saddr leaked.
>
>         return true;
>     }
>
> Obvious fix: g_free(saddr) right after copying its members.
>
> Another fix: make @saddr g_autofree, and keep the initializer.
>
> Separate patch.  Would you like to take care of it?

That is already being worked by someone else:

[PATCH v3] migration: free 'saddr' since be no longer used
https://lore.kernel.org/r/20231120031428.908295-1-zhouzongmin@kylinos.cn

