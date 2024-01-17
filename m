Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7958830BFE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:34:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9o4-0003F0-AA; Wed, 17 Jan 2024 12:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQ9o1-0003DM-OO
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:34:25 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQ9nz-0004VB-PT
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:34:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC49D2208F;
 Wed, 17 Jan 2024 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705512861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vu9q9lLQ7buLJkTxfJiBAAoVWiPE9oHtQUM4Apbrl/k=;
 b=xydv9IuYI9wPM3A1pTc+2WBScYatkzwJhRfB5RnO2fBB7UOCA+5Gc7/JFSXHQPPxsnhGRj
 O/yHImUEtJl8paxWxZmR7xJ7oMPB7RtkfPwGLjfOUczRAK3yQsHb7HhFdU1s3yEcE59wNu
 dSjUTISs2OF/hbvmBLS/gx1wUOLeJsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705512861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vu9q9lLQ7buLJkTxfJiBAAoVWiPE9oHtQUM4Apbrl/k=;
 b=3AvG2dQCiHP4Eiy1nLzEzR7LmUfsflOnZ/ijIplYygmO6BDHff/cdtEUEijknutKDwJch3
 lgdAMjkx3o25ywBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705512861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vu9q9lLQ7buLJkTxfJiBAAoVWiPE9oHtQUM4Apbrl/k=;
 b=xydv9IuYI9wPM3A1pTc+2WBScYatkzwJhRfB5RnO2fBB7UOCA+5Gc7/JFSXHQPPxsnhGRj
 O/yHImUEtJl8paxWxZmR7xJ7oMPB7RtkfPwGLjfOUczRAK3yQsHb7HhFdU1s3yEcE59wNu
 dSjUTISs2OF/hbvmBLS/gx1wUOLeJsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705512861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vu9q9lLQ7buLJkTxfJiBAAoVWiPE9oHtQUM4Apbrl/k=;
 b=3AvG2dQCiHP4Eiy1nLzEzR7LmUfsflOnZ/ijIplYygmO6BDHff/cdtEUEijknutKDwJch3
 lgdAMjkx3o25ywBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35E0213800;
 Wed, 17 Jan 2024 17:34:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LHw+O5wPqGWPQQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jan 2024 17:34:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 13/30] migration/multifd: Add outgoing
 QIOChannelFile support
In-Reply-To: <ZaePsW2Q90se0gi3@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-14-farosas@suse.de> <ZaYApbyD5iexbYYW@x1n>
 <87bk9lxutv.fsf@suse.de> <ZaePsW2Q90se0gi3@x1n>
Date: Wed, 17 Jan 2024 14:34:18 -0300
Message-ID: <87il3rdftx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xydv9IuY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3AvG2dQC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: AC49D2208F
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jan 16, 2024 at 10:37:48AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Nov 27, 2023 at 05:25:55PM -0300, Fabiano Rosas wrote:
>> >> Allow multifd to open file-backed channels. This will be used when
>> >> enabling the fixed-ram migration stream format which expects a
>> >> seekable transport.
>> >> 
>> >> The QIOChannel read and write methods will use the preadv/pwritev
>> >> versions which don't update the file offset at each call so we can
>> >> reuse the fd without re-opening for every channel.
>> >> 
>> >> Note that this is just setup code and multifd cannot yet make use of
>> >> the file channels.
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> ---
>> >> - open multifd channels with O_WRONLY and no mode
>> >> - stop cancelling migration and propagate error via qio_task
>> >> ---
>> >>  migration/file.c      | 47 +++++++++++++++++++++++++++++++++++++++++--
>> >>  migration/file.h      |  5 +++++
>> >>  migration/multifd.c   | 14 +++++++++++--
>> >>  migration/options.c   |  7 +++++++
>> >>  migration/options.h   |  1 +
>> >>  migration/qemu-file.h |  1 -
>> >>  6 files changed, 70 insertions(+), 5 deletions(-)
>> >> 
>> >> diff --git a/migration/file.c b/migration/file.c
>> >> index 5d4975f43e..67d6f42da7 100644
>> >> --- a/migration/file.c
>> >> +++ b/migration/file.c
>> >> @@ -17,6 +17,10 @@
>> >>  
>> >>  #define OFFSET_OPTION ",offset="
>> >>  
>> >> +static struct FileOutgoingArgs {
>> >> +    char *fname;
>> >> +} outgoing_args;
>> >> +
>> >>  /* Remove the offset option from @filespec and return it in @offsetp. */
>> >>  
>> >>  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
>> >> @@ -36,6 +40,42 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
>> >>      return 0;
>> >>  }
>> >>  
>> >> +static void qio_channel_file_connect_worker(QIOTask *task, gpointer opaque)
>> >> +{
>> >> +    /* noop */
>> >> +}
>> >> +
>> >> +int file_send_channel_destroy(QIOChannel *ioc)
>> >> +{
>> >> +    if (ioc) {
>> >> +        qio_channel_close(ioc, NULL);
>> >> +        object_unref(OBJECT(ioc));
>> >> +    }
>> >> +    g_free(outgoing_args.fname);
>> >> +    outgoing_args.fname = NULL;
>> >> +
>> >> +    return 0;
>> >> +}
>> >> +
>> >> +void file_send_channel_create(QIOTaskFunc f, void *data)
>> >> +{
>> >> +    QIOChannelFile *ioc;
>> >> +    QIOTask *task;
>> >> +    Error *err = NULL;
>> >> +    int flags = O_WRONLY;
>> >> +
>> >> +    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, &err);
>> >> +
>> >> +    task = qio_task_new(OBJECT(ioc), f, (gpointer)data, NULL);
>> >> +    if (!ioc) {
>> >> +        qio_task_set_error(task, err);
>> >> +        return;
>> >> +    }
>> >> +
>> >> +    qio_task_run_in_thread(task, qio_channel_file_connect_worker,
>> >> +                           (gpointer)data, NULL, NULL);
>> >
>> > This is pretty weird.  This invokes a thread, but it'll run a noop.  It
>> > seems meaningless to me.
>> >
>> 
>> That's QIOTask weirdness isn't it? It will run the worker in the thread,
>> but it also schedules the completion function as a glib event. So that's
>> when multifd_new_send_channel_async() will run. The crucial aspect here
>> is that it gets dispatched by glib on the main loop. I'm just keeping
>> the model, except that I don't have work to do during the "connection"
>> phase.
>
> The question is why do we need that if "file:" can be done synchronously.

I guess I tend to avoid changing existing patterns when adding a new
feature. But you're right, we don't really need this.

> Please see below.
>
>> 
>> > I assume you wanted to keep using the same async model as the socket typed
>> > multifd, but I don't think that works anyway, because file open blocks at
>> > qio_channel_file_new_path() so it's sync anyway.
>> 
>> It's async regarding multifd_channel_connect(). The connections will be
>> happening while multifd_save_setup() continues execution, IIUC.
>
> Yes.  But I'm wondering whether we can start to simplify at least the
> "file:" for this process.  We all know that we _may_ have created too many
> threads each doing very light work, which might not be needed.  We haven't
> yet resolved the "how to kill a thread along this process if migration
> cancels during when one thread got blocked in a syscall" issue.  We'll need
> to start recording tids for every thread, and that'll be a mess for sure
> when there're tons of threads.
>
>> 
>> >
>> > AFAICT we still share the code, as long as the file path properly invokes
>> > multifd_channel_connect() after the iochannel is setup.
>> >
>> 
>> I don't see the point in moving any of that logic into the URI
>> implementation. We already have the TLS handshake code which can also
>> call multifd_channel_connect() and that is a mess. IMO we should be
>> keeping the interface between multifd and the frontends as boilerplate
>> as possible.
>
> Hmm, I don't think it's a mess?  At least multifd_channel_connect(). AFAICT
> multifd_channel_connect() can be called in any context.

Well this sequence:

multifd_new_send_channel_async() -> multifd_channel_connect() ->
multifd_tls_channel_connect() -> new thread ->
multifd_tls_handshake_thread() -> new task ->
multifd_tls_outgoing_handshake() -> multifd_channel_connect()

...is not what I would call intuitive. Specifically with
multifd_channel_connect() being called more than the number of multifd
channels.

This would be "not a mess" IMO:

for (i = 0; i < migrate_multifd_channels(); i++) {
    multifd_tls_channel_connect();
    multifd_channel_connect() -> 
        qemu_thread_create(..., multifd_send_thread);
}

> multifd_channel_connect() always creates yet another thread, no matter it's
> for tls handshake, or it's one of the multifd send thread.
>
> Here this series already treat file/socket differently:
>
> static void multifd_new_send_channel_create(gpointer opaque)
> {
>     if (migrate_to_file()) {
>         file_send_channel_create(multifd_new_send_channel_async, opaque);
>     } else {
>         socket_send_channel_create(multifd_new_send_channel_async, opaque);
>     }
> }
>
> What I am thinking is it could be much simpler if
> multifd_new_send_channel_create() can create the multifd channels
> synchronously here, then directly call multifd_channel_connect(), further
> that'll create threads for whatever purposes.
>
> When TLS is not enabled, I'd expect if with that change and with a "file:"
> URI, after multifd_save_setup() completes, all send threads will be created
> already.
>
> I think multifd_new_send_channel_create() can already take
> "MultiFDSendParams *p" as parameter, then:
>
> static void multifd_new_send_channel_create(MultiFDSendParams *p)
> {
>     if (migrate_to_file()) {
>         file_send_channel_create(p);
>     } else {
>         socket_send_channel_create(multifd_new_send_channel_async, p);
>     }
> }
>
> Where file_send_channel_create() can call multifd_channel_connect()
> directly upon the ioc created.
>
> Would that work for us, and much cleaner?

Looks cleaner indeed, let me give it a try.

