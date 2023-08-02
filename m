Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B399476D845
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 21:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRHza-0007sW-Ta; Wed, 02 Aug 2023 15:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qRHzY-0007p0-Bh
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 15:58:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qRHzW-0004n2-HX
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 15:58:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F0A351F381;
 Wed,  2 Aug 2023 19:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691006320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SnmOcc2GDBuYySNNQiupNuFo/rzitKN+5Uehlk2eYmE=;
 b=G3h6fpZSTb9RnpC+kucKyIDuRKFnoNMSfbo3u+4J8ESWn/KnMWfHjkW3q9nJGGWcAhP8tK
 04pLHuM88DIpwRsxtVRIXd6thkll1lkHgftWsNFw5lMuS97kQoAbegEGKXEG3fZF8p9KhT
 M0UIJMPvIqHGWfUVL8VIyEgM6zXWktg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691006320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SnmOcc2GDBuYySNNQiupNuFo/rzitKN+5Uehlk2eYmE=;
 b=NpTyBPYEkKCg4SK8vB2uTB6gANMD3DdI1qIlBtQRRuXUyutpBnIvFMc9puDtWiCTBZhxQK
 m7cRTX0HUay3UnAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F0EB13919;
 Wed,  2 Aug 2023 19:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SYSPEnC1ymRRJwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 02 Aug 2023 19:58:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Wei Wang
 <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 1/2] migration: Split await_return_path_close_on_source
In-Reply-To: <ZMqCFIXONOxUCeSE@x1n>
References: <20230802143644.7534-1-farosas@suse.de>
 <20230802143644.7534-2-farosas@suse.de> <ZMqCFIXONOxUCeSE@x1n>
Date: Wed, 02 Aug 2023 16:58:38 -0300
Message-ID: <874jlhcj2p.fsf@suse.de>
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

> On Wed, Aug 02, 2023 at 11:36:43AM -0300, Fabiano Rosas wrote:
>> This function currently has a straight-forward part which is waiting
>> for the thread to join and a complicated part which is doing a
>> qemu_file_shutdown() on the return path file.
>> 
>> The shutdown is tricky because all calls to qemu_file_shutdown() set
>> f->last_error to -EIO, which means we can never know if an error is an
>> actual error or if we cleanly shutdown the file previously.
>> 
>> This is particularly bothersome for postcopy because it would send the
>> return path thread into the retry routine which would wait on the
>> postcopy_pause_rp_sem and consequently block the main thread. We
>> haven't had reports of this so I must presume we never reach here with
>> postcopy.
>> 
>> The shutdown call is also racy because since it doesn't take the
>> qemu_file_lock, it could NULL-dereference if the return path thread
>> happens to be in the middle of the critical region at
>> migration_release_dst_files().
>
> After you rework the thread model on resume, shall we move
> migration_release_dst_files() into the migration thread to be after the
> pthread_join()?  I assume then we don't even need a mutex to protect it?
>

I just need to figure out if it's ok to move the postcopy_qemufile_src
cleanup along. No idea why it is there in the first place. I see you
moved it from postcopy_pause and we're about to move it back to the
exact same place =D

>> 
>> Move this more complicated part of the code to a separate routine so
>> we can wait on the thread without all of this baggage.
>
> I think you mentioned "some nuance" on having mark_source_rp_bad() in
> await_return_path_close_on_source(), I did remember I tried to look into
> that "nuance" too a long time ago but I just forgot what was that.  Great
> if you can share some details.
>

Well, mark_source_rp_bad() at await_return_path_close_on_source() is
basically useless:

- We only call mark_source_rp_bad() if s->to_dst_file has an error and the
  migration_completion() already checks that condition and fails the
  migration anyway.

- If to_dst_file has an error, chances are the destination already did
  cleanup by this point, so from_dst_file would already have an errno,
  due to that. At qemu_fill_buffer(), the len == 0 case basically means
  "the other end finished cleanly". We still set -EIO in that case, I
  don't know why. Possibly because not all backends will have the same
  semantics for len == 0.

- If the above doesn't happen, then due to the shutdown, from_dst_file
  will already have an error again set by qemu_file_shutdown().

Not to mention that mark_source_rp_bad() is in a race with the return
path thread which could clear the error during postcopy retry.

As this patch tries to convey, this whole shutdown routine is weird. We
don't have any documentation explaining when it could happen, so we're
left with wanting to call it always. Except that doesn't work because in
postcopy we'd trigger the retry logic and that hangs, and because of the
"shutdown means -EIO" issue we'd be eating up whatever error happened
before (it's all -EIO, so there's no way to tell them apart).

Given all of that, I thought just moving this aside would be better for
the time being than to try to rationalise all of this. This series fixes
a reproducible bug while everything I said above is just code inspection
and some artificial testing of mine.

>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration.c | 46 +++++++++++++++++++++++++------------------
>>  1 file changed, 27 insertions(+), 19 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 91bba630a8..58f09275a8 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2038,6 +2038,25 @@ static int open_return_path_on_source(MigrationState *ms,
>>  /* Returns 0 if the RP was ok, otherwise there was an error on the RP */
>>  static int await_return_path_close_on_source(MigrationState *ms)
>>  {
>> +    if (!ms->rp_state.rp_thread_created) {
>> +        return 0;
>> +    }
>> +
>> +    trace_await_return_path_close_on_source_joining();
>> +    qemu_thread_join(&ms->rp_state.rp_thread);
>> +    ms->rp_state.rp_thread_created = false;
>> +    trace_await_return_path_close_on_source_close();
>> +    return ms->rp_state.error;
>> +}
>> +
>> +static int close_return_path_on_source(MigrationState *ms)
>> +{
>> +    int ret;
>> +
>> +    if (!ms->rp_state.rp_thread_created) {
>> +        return 0;
>> +    }
>
> Can we still rely on the await_return_path_close_on_source() check, so as
> to dedup this one?
>

I guess we could, the tracepoints would be off though. We'd print

    trace_migration_return_path_end_before();
    trace_migration_return_path_end_end();

with "nothing" in between. I'll try to think of something.

