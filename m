Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E41A31687
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Feb 2025 21:23:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thwlo-00054s-3x; Tue, 11 Feb 2025 15:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thwlm-00054f-5t
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 15:22:10 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thwlk-00013I-Ai
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 15:22:09 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8AFB1F7CB;
 Tue, 11 Feb 2025 20:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739305326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SesV60hJMXaraBy4T79Kx2W1v/1bJITZ+V3P2Pxl50=;
 b=ohbHY4QD+TpQQpneSWoq5csWZ3fA+siAC/PWm/MpNuwu2SRsZXIG8IXuGL5DLs+x2UsC8Y
 C6cFm9ACHIS20en+4Jak1nfvKvRO/iPJMHYWXBnT+s81KVGNipxOFI9eTLD6pwdmyOX4TK
 qAwgwEKU3eZrp8wF1N6rPOWaiGk08dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739305326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SesV60hJMXaraBy4T79Kx2W1v/1bJITZ+V3P2Pxl50=;
 b=egM22FLVp3fwKA+WkInCprJMsTXguY45HtoDrgM6VuHldjl7HblvJn+94tonUquGz1Z9RF
 TsiggFqvUH6c9QAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739305326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SesV60hJMXaraBy4T79Kx2W1v/1bJITZ+V3P2Pxl50=;
 b=ohbHY4QD+TpQQpneSWoq5csWZ3fA+siAC/PWm/MpNuwu2SRsZXIG8IXuGL5DLs+x2UsC8Y
 C6cFm9ACHIS20en+4Jak1nfvKvRO/iPJMHYWXBnT+s81KVGNipxOFI9eTLD6pwdmyOX4TK
 qAwgwEKU3eZrp8wF1N6rPOWaiGk08dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739305326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SesV60hJMXaraBy4T79Kx2W1v/1bJITZ+V3P2Pxl50=;
 b=egM22FLVp3fwKA+WkInCprJMsTXguY45HtoDrgM6VuHldjl7HblvJn+94tonUquGz1Z9RF
 TsiggFqvUH6c9QAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2837C13715;
 Tue, 11 Feb 2025 20:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1uJzNm2xq2fJPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 11 Feb 2025 20:22:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 6/9] migration: Don't set FAILED state when cancelling
In-Reply-To: <Z6uoTymcfHcjnrtf@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-7-farosas@suse.de> <Z6uM5TDDGb5FkVqf@x1.local>
 <87wmdwuzm2.fsf@suse.de> <Z6uoTymcfHcjnrtf@x1.local>
Date: Tue, 11 Feb 2025 17:22:03 -0300
Message-ID: <87tt90ut90.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Feb 11, 2025 at 03:04:37PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Tue, Feb 11, 2025 at 12:01:33PM -0300, Fabiano Rosas wrote:
>> >> It's possible that the migration is cancelled during
>> >> migration_switchover_start(). In that case, don't set the migration
>> >> state FAILED in migration_completion().
>> >> 
>> >> Fixes: 3dde8fdbad ("migration: Merge precopy/postcopy on switchover start")
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >
>> > I remember I paid some attention on this one when working on the commit,
>> > where it has:
>> >
>> > static bool migration_switchover_prepare(MigrationState *s)
>> > {
>> >     /* Concurrent cancellation?  Quit */
>> >     if (s->state == MIGRATION_STATUS_CANCELLING) {   <================= [1]
>> >         return false;
>> >     }
>> >     ...
>> >     bql_unlock();
>> >
>> >     qemu_sem_wait(&s->pause_sem);
>> >
>> >     bql_lock();
>> >     /*
>> >      * After BQL released and retaken, the state can be CANCELLING if it
>> >      * happend during sem_wait().. Only change the state if it's still
>> >      * pre-switchover.
>> >      */
>> >     migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER, <====== [2]
>> >                       MIGRATION_STATUS_DEVICE);
>> >
>> >     return s->state == MIGRATION_STATUS_DEVICE;
>> > }
>> >
>> > So when holding BQL logically it can't change to CANCELLING, it'll check
>> > first [1] making sure no prior CANCELLING.  Then after release and retake
>> > BQL it'll check again [2] (see the comment above [2], it's done by passing
>> > in explicit old_state to not change it if it's CANCELLING).
>> 
>> Right, it doesn't change the state. But the function returns false and
>> someone else changes to FAILED. That's what both my patch and your
>> snippet below fix.
>> 
>> >
>> > Any hint on how this could be triggered?
>> >
>> > OTOH, when looking at this.. I seem to have found a bug indeed (which could
>> > be another?), where I may have forgot to touch up the old_state in
>> > migrate_set_state() after switching to always use DEVICE..
>> >
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index 74c50cc72c..513e5955cc 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -2793,8 +2793,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>> >  fail_closefb:
>> >      qemu_fclose(fb);
>> >  fail:
>> > -    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>> > -                          MIGRATION_STATUS_FAILED);
>> > +    if (ms->state != MIGRATION_STATUS_CANCELLING) {
>> > +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
>> > +    }
>> 
>> Now that I think about it, we should probably just use the skip at
>> migrate_set_state() always. Isn't this^ the same as:
>> 
>> migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
>> MIGRATION_STATUS_FAILED);
>> 
>> Better to list the state explicitly, no?
>
> There's one case where it can be in ACTIVE rather than DEVICE,
> unfortunately:
>
>     ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
>     if (ret < 0) {
>         error_setg_errno(errp, -ret, "%s: Failed to stop the VM", __func__);
>         goto fail;
>     }
>
>> 
>> Or... do we want to incorporate this into migrate_set_state()?
>> 
>> void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>>                        MigrationStatus new_state)
>> {
>>     assert(new_state < MIGRATION_STATUS__MAX);
>> 
>>     if (qatomic_read(state) == CANCELLING && new_state != CANCELLED) {
>>         /* Once it's cancelling, there's no way back, it must finish cancel */
>>         return;
>>     }
>> 
>>     if (qatomic_cmpxchg(state, old_state, new_state) == old_state) {
>>         trace_migrate_set_state(MigrationStatus_str(new_state));
>>         migrate_generate_event(new_state);
>>     }
>> }
>
> IMHO we'll need the original migrate_set_state() more or less, e.g. when
> setting CANCELLING->CANCELLED in migration_[fd_]cleanup().  So maybe it's
> slightly easier we keep it.
>
> Said that, maybe we could have a few helpers for the state transitions,
> like:
>
>   migrate_set_state_failure(MigrationState *s)
>
> Which can consider CANCELLING.
>
> Also, we have a portion of such state transitions not caring about current
> state, so we could also have some helper for that, like:
>
>   migrate_set_state_always(MigrationState *s, MigrationStatus status)
>
> Or rename old migrate_set_state() into migrate_set_state_atomic(), then
> make migrate_set_state() to ignore current state.
>

Thanks for the input.

I think for this series I'll stick with the

if (s->state != MIGRATION_STATUS_CANCELLING)

and prepare a new series with generic improvements to the migration
state code. I want to also fix the nomenclature of status vs. state.

>> 
>> >      migration_block_activate(NULL);
>> >      migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
>> >      bql_unlock();
>> >
>> > I'm not sure whether it's relevant to what you hit, though.. since you're
>> > looking at this, I'd rely on you help figuring it out before I do.. :)
>> >
>> >> ---
>> >>  migration/migration.c | 4 +++-
>> >>  1 file changed, 3 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/migration/migration.c b/migration/migration.c
>> >> index 375de6d460..5dc43bcdc0 100644
>> >> --- a/migration/migration.c
>> >> +++ b/migration/migration.c
>> >> @@ -2986,7 +2986,9 @@ fail:
>> >>          error_free(local_err);
>> >>      }
>> >>  
>> >> -    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>> >> +    if (s->state != MIGRATION_STATUS_CANCELLING) {
>> >> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>> >> +    }
>> >>  }
>> >>  
>> >>  /**
>> >> -- 
>> >> 2.35.3
>> >> 
>> 

