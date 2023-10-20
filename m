Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A277D0FE6
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:49:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtow5-0007nw-6r; Fri, 20 Oct 2023 08:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtow1-0007n7-A0
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:49:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtovy-00009D-W0
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:49:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF5241F8A3;
 Fri, 20 Oct 2023 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697806136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OvZM/R50WKBDxNxHl8OUD42CZ3rDUpjshysVv+KOo8o=;
 b=nAG6M3gTI63ezUVQGf2n4X2aXlNAyaBYYz7WMDuN2a7BgqWaCWmpt2r0nrf38t8/TRNxUX
 wGiJduoEbOtCyNvTsEN0/hyGv5vj2aVPhMCTfr2yX0qNShwMWNNnJ/YDL5ssKHw1LzMUgH
 EynbO3ES3YgWyr4lLWMWBII9aFjeiiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697806136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OvZM/R50WKBDxNxHl8OUD42CZ3rDUpjshysVv+KOo8o=;
 b=yLnFb/8POHxKNkanBJy6C7qX8GtoTVjhvqwoUG6/4Ip0+smgmHbNunRU7CxcO+6HGxVxkO
 LSIRqGp2v5jHwEAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CA87138E2;
 Fri, 20 Oct 2023 12:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /F+uDTh3MmWdEgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 20 Oct 2023 12:48:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
In-Reply-To: <87ttql20hz.fsf@secure.mitica>
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de> <87sf676kxt.fsf@secure.mitica>
 <87r0lqy83p.fsf@suse.de> <87wmvi3akc.fsf@secure.mitica>
 <87lebyy5ac.fsf@suse.de> <87a5se3161.fsf@secure.mitica>
 <ZTF9vL8yyn6McuTx@x1n> <87ttql20hz.fsf@secure.mitica>
Date: Fri, 20 Oct 2023 09:48:54 -0300
Message-ID: <87ttqlh32h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> Peter Xu <peterx@redhat.com> wrote:
>> On Thu, Oct 19, 2023 at 08:41:26PM +0200, Juan Quintela wrote:
>>> We can changing pending_job to a bool if you preffer.  I think that we
>>> have nailed all the off_by_one errors by now (famous last words).
>>
>> Would it work to make pending_job a bool, even with SYNC?  It seems to me
>> multifd_send_sync_main() now can boost pending_job even if pending_job==1.
>
> Then a int is ok, I think.
>
>> That's also the place where I really think confusing too; where it looks
>> like the migration thread can modify a pending job's flag as long as it is
>> fast enough before the send thread put that onto the wire.
>
> It never does.
>
>     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
>         qemu_mutex_lock(&p->mutex);
>         ...
>         if (!p->pending_job) {
>             p->pending_job++;
>             next_channel = (i + 1) % migrate_multifd_channels();
>             break;
>         }
>         qemu_mutex_unlock(&p->mutex);
>     }

We copy the flags into the packet header at multifd_send_fill_packet()
before unlocking. I think that is even independent of the pending_jobs
scheme.

> If pending_job == 0 -> owner of the channel is migration_thread and it
> can use it.
>
> If pending_job > 0 -> owner of the channel is the channel thread and
> migration_thread can't use it.

Do you really mean "migration_thread" here or just multifd_send_pages()?
Because multifd_send_sync_main() doesn't care about this ownership
rule. Does that mean that code is incorrect?

> I think that this is easy to understand.  You are right that it is not
> _explained_.  And clearly, if you have to ask, it is not obvious O:-)

It is explained at multifd.h. But it doesn't really matter because code
can drift and documentation doesn't assure correctness. That's why we
have to ask about seemingly obvious stuff.

> Yes, it was obvious to me, that is the reason why I wrote it on the
> 1st place.  Notice also that it is a common idiom in multithreaded
> apps.  That allows it to do stuff without having to have a mutex
> locked, so other threads can "look" into the state.
>> Then it's
>> unpredictable whether the SYNC flag will be sent with current packet (where
>> due to pending_jobs==1 already, can contain valid pages), or will be only
>> set for the next one (where there will have 0 real page).
>
> I have to think about this one.
> Decrease pending_jobs there if we are doing multiple jobs?
> But we still have the issue of the semaphore.
>
>> IMHO it'll be good to separate the sync task, then we can change
>> pending_jobs to bool.  Something like:
>>
>>   bool pending_send_page;
>>   bool pending_send_sync;
>
> current code:
>
>         qemu_mutex_lock(&p->mutex);
>         qemu_mutex_lock(&p->mutex);
>
>         if (p->pending_job) {
>             uint64_t packet_num = p->packet_num;
>             uint32_t flags;
>             p->normal_num = 0;
>
>             if (use_zero_copy_send) {
>                 p->iovs_num = 0;
>             } else {
>                 p->iovs_num = 1;
>             }
>
>             for (int i = 0; i < p->pages->num; i++) {
>                 p->normal[p->normal_num] = p->pages->offset[i];
>                 p->normal_num++;
>             }
>
>             if (p->normal_num) {
>                 ret = multifd_send_state->ops->send_prepare(p, &local_err);
>                 if (ret != 0) {
>                     qemu_mutex_unlock(&p->mutex);
>                     break;
>                 }
>             }
>             multifd_send_fill_packet(p);
>             flags = p->flags;
>             p->flags = 0;
>             p->num_packets++;
>             p->total_normal_pages += p->normal_num;
>             p->pages->num = 0;
>             p->pages->block = NULL;
>             qemu_mutex_unlock(&p->mutex);
>
>             trace_multifd_send(p->id, packet_num, p->normal_num, flags,
>                                p->next_packet_size);
>
>             if (use_zero_copy_send) {
>                 /* Send header first, without zerocopy */
>                 ret = qio_channel_write_all(p->c, (void *)p->packet,
>                                             p->packet_len, &local_err);
>                 if (ret != 0) {
>                     break;
>                 }
>             } else {
>                 /* Send header using the same writev call */
>                 p->iov[0].iov_len = p->packet_len;
>                 p->iov[0].iov_base = p->packet;
>             }
>
>             ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
>                                               0, p->write_flags, &local_err);
>             if (ret != 0) {
>                 break;
>             }
>
>             stat64_add(&mig_stats.multifd_bytes,
>                        p->next_packet_size + p->packet_len);
>             stat64_add(&mig_stats.transferred,
>                        p->next_packet_size + p->packet_len);
>             p->next_packet_size = 0;
>             qemu_mutex_lock(&p->mutex);
>             p->pending_job--;
>             qemu_mutex_unlock(&p->mutex);
>
>             if (flags & MULTIFD_FLAG_SYNC) {
>                 qemu_sem_post(&p->sem_sync);
>             }
>         } else {
>             qemu_mutex_unlock(&p->mutex);
>             /* sometimes there are spurious wakeups */
>         }
>
> Your suggested change:
>
>        qemu_mutex_lock(&p->mutex);
>
>        if (p->pending_job_page) {

It's a semantic issue really, but I'd rather we avoid locking ourselves
more into the "pages" idea for multifd threads. The data being sent by
the multifd thread should be opaque.


