Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0515176D85C
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 22:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRI5a-0001tp-O0; Wed, 02 Aug 2023 16:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qRI5U-0001tS-AQ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 16:04:52 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qRI5S-0007D8-IX
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 16:04:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9BC0E21A01;
 Wed,  2 Aug 2023 20:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691006688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HQqBsDhFSQJZ7bS/G9ksWBogx7vxRgSA1lotAFhZns=;
 b=MdadMEN1bPdjWhSBDvNM6CM+ZKghLLf4PpJcPm83rudlTHUSHEi2ZD4Ieyxohb9MQTJA5N
 tgYxXMoeMCj4LnkR7cCc4U10atoh/O62TFVaQtCHvNA41VWcTMD1N/HEhYYrIhZq62l/aA
 iKCSj73TJSndTUNnwLNpFHJPCtmIsIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691006688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HQqBsDhFSQJZ7bS/G9ksWBogx7vxRgSA1lotAFhZns=;
 b=WW6+uJ+4IlItMKqbEhvM3hfc2RZg5So8KM/vel6WpT/0vTKwoW0Mmqrxb2qe2agGatO7Fy
 uzuMR0t1+qyjGZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D60C13919;
 Wed,  2 Aug 2023 20:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id loggOt+2ymS5KQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 02 Aug 2023 20:04:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Wei Wang
 <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 2/2] migration: Replace the return path retry logic
In-Reply-To: <ZMp+DsWuAZHr5Sj/@x1n>
References: <20230802143644.7534-1-farosas@suse.de>
 <20230802143644.7534-3-farosas@suse.de> <ZMp+DsWuAZHr5Sj/@x1n>
Date: Wed, 02 Aug 2023 17:04:45 -0300
Message-ID: <871qglcisi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

>> +        if (await_return_path_close_on_source(s)) {
>> +            trace_migration_return_path_pause_err();
>> +            return MIG_THR_ERR_FATAL;
>> +        }
>
> I see that here on return path failures we'll bail out, and actually it's
> against the instinction (that when pause it should have failed, so it's
> weird why it's returning 0).
>
> So how about above suggestion, plus here we just call
> await_return_path_close_on_source(), without caring about the retval?

So you are suggesting to remove the knowledge of the retry entirely from
the thread. It just reports the error and the postcopy_pause takes the
responsibility of ignoring it when we want to retry... It could be
clearer that way indeed.

>> +
>>          migrate_set_state(&s->state, s->state,
>>                            MIGRATION_STATUS_POSTCOPY_PAUSED);
>>  
>> @@ -2566,12 +2542,6 @@ static MigThrError postcopy_pause(MigrationState *s)
>>          if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
>>              /* Woken up by a recover procedure. Give it a shot */
>>  
>> -            /*
>> -             * Firstly, let's wake up the return path now, with a new
>> -             * return path channel.
>> -             */
>> -            qemu_sem_post(&s->postcopy_pause_rp_sem);
>> -
>>              /* Do the resume logic */
>>              if (postcopy_do_resume(s) == 0) {
>>                  /* Let's continue! */
>> @@ -3259,7 +3229,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>       * QEMU uses the return path.
>>       */
>>      if (migrate_postcopy_ram() || migrate_return_path()) {
>> -        if (open_return_path_on_source(s, !resume)) {
>> +        if (open_return_path_on_source(s)) {
>>              error_report("Unable to open return-path for postcopy");
>>              migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>>              migrate_fd_cleanup(s);
>> @@ -3320,7 +3290,6 @@ static void migration_instance_finalize(Object *obj)
>>      qemu_sem_destroy(&ms->rate_limit_sem);
>>      qemu_sem_destroy(&ms->pause_sem);
>>      qemu_sem_destroy(&ms->postcopy_pause_sem);
>> -    qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
>>      qemu_sem_destroy(&ms->rp_state.rp_sem);
>>      qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
>>      qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
>> @@ -3340,7 +3309,6 @@ static void migration_instance_init(Object *obj)
>>      migrate_params_init(&ms->parameters);
>>  
>>      qemu_sem_init(&ms->postcopy_pause_sem, 0);
>> -    qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
>>      qemu_sem_init(&ms->rp_state.rp_sem, 0);
>>      qemu_sem_init(&ms->rp_state.rp_pong_acks, 0);
>>      qemu_sem_init(&ms->rate_limit_sem, 0);
>> diff --git a/migration/migration.h b/migration/migration.h
>> index b7c8b67542..e78db5361c 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -382,7 +382,6 @@ struct MigrationState {
>>  
>>      /* Needed by postcopy-pause state */
>>      QemuSemaphore postcopy_pause_sem;
>> -    QemuSemaphore postcopy_pause_rp_sem;
>>      /*
>>       * Whether we abort the migration if decompression errors are
>>       * detected at the destination. It is left at false for qemu
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 5259c1044b..19ec649d1d 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -164,6 +164,7 @@ migration_rate_limit_pre(int ms) "%d ms"
>>  migration_rate_limit_post(int urgent) "urgent: %d"
>>  migration_return_path_end_before(void) ""
>>  migration_return_path_end_after(int rp_error) "%d"
>> +migration_return_path_pause_err(void) ""
>
> If it should never trigger, it shouldn't need a tracepoint.  It needs an
> assertion if we're 100% confident, or error_report_once() perhaps would be
> more suitable.

It would trigger when a rp error happened that wasn't related to the
QEMUFile. If we go with your suggestion above, then this goes away.


