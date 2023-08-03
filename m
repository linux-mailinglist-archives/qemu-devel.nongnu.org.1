Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CE676ED06
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 16:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZaF-0002EN-5d; Thu, 03 Aug 2023 10:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qRZaD-0002Dh-Tx
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:45:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qRZaC-0007G6-4B
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:45:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 325E41F45A;
 Thu,  3 Aug 2023 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691073941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pOINyC8HhZ3r9ZtZo/YxWWlxMWXEZ3CQqXDZxUvQ590=;
 b=zGW6vKsTvL6Gzvg91X+rJrU/6rtop+3EqDmXrfe2/tOd7Er5dg41tnUpoyEDrDeZrE6AC6
 lAT0h9K46IYTdvpyJRxPg0vBmbN+G7v76boR6H+lChIk2AOhJNpd1TQvWAcQlOLKWKi2Sc
 75lMRTCu6oKdZ0L7jgY0FGJJxOpuvS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691073941;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pOINyC8HhZ3r9ZtZo/YxWWlxMWXEZ3CQqXDZxUvQ590=;
 b=HYYENuMGVvWMHeRR7vxSl1+W+Mij+zBeLQyXM2MY1qQ2hrFZqOqEy1AbwfQNFBPO4jzIZF
 B9seCbtArmu7ILDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B80B71333C;
 Thu,  3 Aug 2023 14:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VhxSIJS9y2QBGgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 03 Aug 2023 14:45:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Wei Wang
 <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 1/2] migration: Split await_return_path_close_on_source
In-Reply-To: <ZMq/QKI+qYSw4gPN@x1n>
References: <20230802143644.7534-1-farosas@suse.de>
 <20230802143644.7534-2-farosas@suse.de> <ZMqCFIXONOxUCeSE@x1n>
 <874jlhcj2p.fsf@suse.de> <ZMq/QKI+qYSw4gPN@x1n>
Date: Thu, 03 Aug 2023 11:45:38 -0300
Message-ID: <87y1isb2wd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Wed, Aug 02, 2023 at 04:58:38PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Wed, Aug 02, 2023 at 11:36:43AM -0300, Fabiano Rosas wrote:
>> >> This function currently has a straight-forward part which is waiting
>> >> for the thread to join and a complicated part which is doing a
>> >> qemu_file_shutdown() on the return path file.
>> >> 
>> >> The shutdown is tricky because all calls to qemu_file_shutdown() set
>> >> f->last_error to -EIO, which means we can never know if an error is an
>> >> actual error or if we cleanly shutdown the file previously.
>> >> 
>> >> This is particularly bothersome for postcopy because it would send the
>> >> return path thread into the retry routine which would wait on the
>> >> postcopy_pause_rp_sem and consequently block the main thread. We
>> >> haven't had reports of this so I must presume we never reach here with
>> >> postcopy.
>> >> 
>> >> The shutdown call is also racy because since it doesn't take the
>> >> qemu_file_lock, it could NULL-dereference if the return path thread
>> >> happens to be in the middle of the critical region at
>> >> migration_release_dst_files().
>> >
>> > After you rework the thread model on resume, shall we move
>> > migration_release_dst_files() into the migration thread to be after the
>> > pthread_join()?  I assume then we don't even need a mutex to protect it?
>> >
>> 
>> I just need to figure out if it's ok to move the postcopy_qemufile_src
>> cleanup along. No idea why it is there in the first place. I see you
>> moved it from postcopy_pause and we're about to move it back to the
>> exact same place =D
>
> It was there because the old postcopy-preempt was sending data via
> postcopy_qemufile_src from the migration thread, while postcopy_pause is
> also the migration thread context.
>
> Then we had 9358982744 ("migration: Send requested page directly in
> rp-return thread") where we moved that "send page" operation into the
> return path thread to reduce latencies.  After moving there it also means
> the file handle can be accessed in >1 threads, so I just moved it over to
> operate that always in the return path thread, then no race should happen.
>

Thanks for the context.

> With your change, return path will vanish before migration thread accesses
> it later (so as mentioned above, it must be after pthread_join()
> succeeded), then I assume it'll be fine too to have it back in migration
> thread.
>
> Or perhaps just take the file lock?
>

There's also migrate_fd_cleanup and migrate_fd_cancel that can touch
these files. We might need to lock anyway, let's see.

In general I'd like to drop all of these "ok not to lock, because...",
it's too easy for code to change and the assumptions to stop being
true. IMHO it's not worth it to gain performance by not taking a lock
when the data is still shared and there's nothing stopping someone in
the future from accessing it concurrently.

>> 
>> >> 
>> >> Move this more complicated part of the code to a separate routine so
>> >> we can wait on the thread without all of this baggage.
>> >
>> > I think you mentioned "some nuance" on having mark_source_rp_bad() in
>> > await_return_path_close_on_source(), I did remember I tried to look into
>> > that "nuance" too a long time ago but I just forgot what was that.  Great
>> > if you can share some details.
>> >
>> 
>> Well, mark_source_rp_bad() at await_return_path_close_on_source() is
>> basically useless:
>> 
>> - We only call mark_source_rp_bad() if s->to_dst_file has an error and the
>>   migration_completion() already checks that condition and fails the
>>   migration anyway.
>> 
>> - If to_dst_file has an error, chances are the destination already did
>>   cleanup by this point, so from_dst_file would already have an errno,
>>   due to that. At qemu_fill_buffer(), the len == 0 case basically means
>>   "the other end finished cleanly". We still set -EIO in that case, I
>>   don't know why. Possibly because not all backends will have the same
>>   semantics for len == 0.
>
> I don't know either, but I checked it's from a555b8092a ("qemu-file: Don't
> do IO after shutdown").  Maybe there's better way to do so we could
> identify the difference, but yes can be for later.
>

That is not the -EIO I'm talking about, but I'm glad you mentioned it,
because I just noticed we might need to revert ac7d25b816 ("qemu-file:
remove shutdown member").

It did a purely logical change which is to drop the f->shutdown flag,
but that has the side-effect that now we cannot differentiate an orderly
shutdown from an IO error.

I get that perhaps ideally all of the code would be resilient to be able
to handle a shutdown in the same way as an IO error, but I'm not sure we
are prepared for that.


Now, the actual -EIO I was mentioning is this one in qemu-file.c:

static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
{
    ...
    ...
    do {
        len = qio_channel_read(f->ioc,
                               (char *)f->buf + pending,
                               IO_BUF_SIZE - pending,
                               &local_error);
        if (len == QIO_CHANNEL_ERR_BLOCK) {
            if (qemu_in_coroutine()) {
                qio_channel_yield(f->ioc, G_IO_IN);
            } else {
                qio_channel_wait(f->ioc, G_IO_IN);
            }
        } else if (len < 0) {
            len = -EIO;
        }
    } while (len == QIO_CHANNEL_ERR_BLOCK);

    if (len > 0) {
        f->buf_size += len;
        f->total_transferred += len;
    } else if (len == 0) {
        qemu_file_set_error_obj(f, -EIO, local_error); <---- THIS
    } else {
        qemu_file_set_error_obj(f, len, local_error);
    }

    return len;
}

the recvmsg manual says:

  "When a stream socket peer has performed an orderly shutdown, the return
  value will be 0 (the traditional "end-of-file" return)."

So both issues combined put us in a situation where there's never an
"orderly shutdown", everything is an error. I wouldn't say that's wrong,
but it's not clear to me whether we consciously made that design
decision.

