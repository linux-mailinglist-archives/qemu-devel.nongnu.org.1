Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E4F9E76A0
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 18:03:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJbi7-0005zr-Mq; Fri, 06 Dec 2024 12:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJbhb-0005kF-6e
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 12:01:18 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJbhT-0003yG-QP
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 12:01:13 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FB421F37E;
 Fri,  6 Dec 2024 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733504464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vHXI2zfR8pGBtrSnIXzXTu/ySpqRgvM1MZALlNeaXdY=;
 b=zF6I6RdtImpytZIBMntABgiz8WlpHPVqcRhj/vBHF98E3XrOr8wSJfE5D83//oZgRN79Sx
 TCRxQOdyf7JTNfAVjJhTXIAuw30pm7fm/Xc+iFVkBY21E5zbkpjF0y9+56vPU7l/9q1Itx
 fLQbYLTUiWPhnspGgHp/gmlOGm8/mPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733504464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vHXI2zfR8pGBtrSnIXzXTu/ySpqRgvM1MZALlNeaXdY=;
 b=aLRapy1ky7fogbDLJ7KiqDPcvkHMpAmSfUzpUgFOzlJS8L2BgdyiTCUjcAAbEDL8WTzCe1
 eH/oUDt1sErOtzBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733504464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vHXI2zfR8pGBtrSnIXzXTu/ySpqRgvM1MZALlNeaXdY=;
 b=zF6I6RdtImpytZIBMntABgiz8WlpHPVqcRhj/vBHF98E3XrOr8wSJfE5D83//oZgRN79Sx
 TCRxQOdyf7JTNfAVjJhTXIAuw30pm7fm/Xc+iFVkBY21E5zbkpjF0y9+56vPU7l/9q1Itx
 fLQbYLTUiWPhnspGgHp/gmlOGm8/mPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733504464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vHXI2zfR8pGBtrSnIXzXTu/ySpqRgvM1MZALlNeaXdY=;
 b=aLRapy1ky7fogbDLJ7KiqDPcvkHMpAmSfUzpUgFOzlJS8L2BgdyiTCUjcAAbEDL8WTzCe1
 eH/oUDt1sErOtzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C45013647;
 Fri,  6 Dec 2024 17:01:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A6JvGM8tU2dcFwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Dec 2024 17:01:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 7/7] migration/multifd: Document the reason to sync
 for save_setup()
In-Reply-To: <Z1MZ8hwPUQBLMLcb@x1n>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-8-peterx@redhat.com> <87r06kc1t0.fsf@suse.de>
 <Z1MZ8hwPUQBLMLcb@x1n>
Date: Fri, 06 Dec 2024 14:01:01 -0300
Message-ID: <87frn0bvaq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

> On Fri, Dec 06, 2024 at 11:40:27AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > It's not straightforward to see why src QEMU needs to sync multifd during
>> > setup() phase.  After all, there's no page queued at that point.
>> >
>> > For old QEMUs, there's a solid reason: EOS requires it to work.  While it's
>> > clueless on the new QEMUs which do not take EOS message as sync requests.
>> >
>> > One will figure that out only when this is conditionally removed.  In fact,
>> > the author did try it out.  Logically we could still avoid doing this on
>> > new machine types, however that needs a separate compat field and that can
>> > be an overkill in some trivial overhead in setup() phase.
>> >
>> > Let's instead document it completely, to avoid someone else tries this
>> > again and do the debug one more time, or anyone confused on why this ever
>> > existed.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/ram.c | 27 +++++++++++++++++++++++++++
>> >  1 file changed, 27 insertions(+)
>> >
>> > diff --git a/migration/ram.c b/migration/ram.c
>> > index 5d4bdefe69..ddee703585 100644
>> > --- a/migration/ram.c
>> > +++ b/migration/ram.c
>> > @@ -3036,6 +3036,33 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>> >          migration_ops->ram_save_target_page = ram_save_target_page_legacy;
>> >      }
>> >  
>> > +    /*
>> > +     * This operation is unfortunate..
>> > +     *
>> > +     * For legacy QEMUs using per-section sync
>> > +     * =======================================
>> > +     *
>> > +     * This must exist because the EOS below requires the SYNC messages
>> > +     * per-channel to work.
>> > +     *
>> > +     * For modern QEMUs using per-round sync
>> > +     * =====================================
>> > +     *
>> > +     * Logically this sync is not needed (because we know there's nothing
>> > +     * in the multifd queue yet!).
>> 
>> This is a bit misleading because even today we could split the
>> multifd_ram_flush_and_sync() into _flush and _sync (haven't I seen a
>> patch doing this somewhere? Maybe from Maciej...) and call just the
>> _sync here, which is unrelated to any multifd queue.
>
> Yeah you have a point, maybe at least I shouldn't mention the queues, they
> can be irrelevant.
>
>> 
>> I think we shouldn't tie "sync" with "wait for multifd threads to finish
>> sending their data (a kind of flush)" as this implies. The sync is as
>> much making sure the threads are ready to receive as it is making sure
>> the data is received in order with relation to ram scanning rounds.
>> 
>> IOW, the local sync is what ensures multifd send threads are flushed
>> while this code deals with the sync of src&dst threads, which is "just"
>> a synchronization point between the two QEMUs.
>
> This is a remote sync, not a local sync.  But yes, it can be the
> synchronization point.
>
> As I mentioned below, such sync point has nothing to do with src, so it can
> be implemented in dest alone without such sync message.  It works, though.
>
>> 
>> > However as a side effect, this makes
>> > +     * sure the dest side won't receive any data before it properly reaches
>> > +     * ram_load_precopy().
>> 
>> I'm not sure it's a side-effect. It seems deliberate to me, seeing that
>> multifd usually does its own synchronization. For instance, on the send
>> side we also need some sync to make sure ram.c doesn't send data to
>> multifd send threads that are not ready yet (i.e. the wait on
>> channels_ready at the start of multifd_send()).
>
> Yes, and that's exactly what I wanted to express.  If dest has that
> "channels_ready" thing, I'm pretty sure we don't need this remote sync.
> We're using a heavier sync to service the purpose for "local sync for
> dest".  It's ok, but it's very unclear on what it really does.
>
>> 
>> > +     *
>> > +     * Without this sync, src QEMU can send data too soon so that dest may
>> > +     * not have been ready to receive it (e.g., rb->receivedmap may be
>> > +     * uninitialized, for example).
>> > +     *
>> > +     * Logically "wait for recv setup ready" shouldn't need to involve src
>> > +     * QEMU at all, however to be compatible with old QEMUs, let's stick
>> 
>> I don't understand this statement, you're saying that QEMU src could
>> just start dumping data on the channel without a remote end? Certainly
>> for file migrations, but socket as well?
>
> Yes.
>
> When reaching here on sender side, all multifd channels are already there:
> multifd_send_setup() guaranteed it.  We can start dump things, AFAICT,
> irrelevant of what dest is doing.
>
> Maybe the recv threads are not even created, but that isn't relevant, IMO,
> as long as they'll be there at some point and start collecting socket
> buffers.
>
>> 
>> > +     * with this.  Fortunately the overhead is low to sync during setup
>> > +     * because the VM is running, so at least it's not accounted as part of
>> > +     * downtime.
>> > +     */
>> >      bql_unlock();
>> >      ret = multifd_ram_flush_and_sync(f);
>> >      bql_lock();
>> 
>
> I removed ambiguous wordings on "queue is empty", and simplified it a bit.
> How's this one look?
>
>     /*
>      * This operation is unfortunate..
>      *
>      * For legacy QEMUs using per-section sync
>      * =======================================
>      *
>      * This must exist because the EOS below requires the SYNC messages
>      * per-channel to work.
>      *
>      * For modern QEMUs using per-round sync
>      * =====================================
>      *
>      * Logically such sync is not needed, and recv threads should not run
>      * until setup ready (using things like channels_ready on src).  Then
>      * we should be all fine.
>      *
>      * However even if we add channels_ready to recv side in new QEMUs, old
>      * QEMU won't have them so this sync will still be needed to make sure
>      * multifd recv threads won't start processing guest pages early before
>      * ram_load_setup() is properly done.
>      *
>      * Let's stick with this.  Fortunately the overhead is low to sync
>      * during setup because the VM is running, so at least it's not
>      * accounted as part of downtime.
>      */

Looks ok, thanks!

