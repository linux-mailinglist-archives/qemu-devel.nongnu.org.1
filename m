Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D21C37AD7E8
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 14:22:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkkaK-0008JO-Lk; Mon, 25 Sep 2023 08:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qkkaI-0008J7-GB
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 08:21:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qkkaG-0003xm-9f
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 08:21:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CB4D61F459;
 Mon, 25 Sep 2023 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695644460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6Rzl9xglP9iAKdHa1upppdJZLEcr2kn+D5TSZcey4s=;
 b=PtwLSOZz41PvNKG7JFUz8X9w36mDR1RrKCB+6BaIqog0WO9k81l//GR5AHmyt46QFjWRM1
 lV83EzOFD+4HRyViNAflHF/A1BGjkbeWvvVChNQuoW5O8/sowGVs9xLrPdfTy4jmUCamQT
 fm1Y6LUuBkywC5/afZQ2r/I/0QwmpAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695644460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6Rzl9xglP9iAKdHa1upppdJZLEcr2kn+D5TSZcey4s=;
 b=u7qLz9q5An41eMqnBkCm0NlzcisUMCdg8d+VW7T1qaejfnWfvELekioYTYk8DYliRIo4tQ
 RyE81pN02mG0jiDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E49B13580;
 Mon, 25 Sep 2023 12:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0Z71Cix7EWWlZwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 25 Sep 2023 12:21:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v6 09/10] migration/yank: Keep track of registered yank
 instances
In-Reply-To: <20230925093607.7f3ab989@penguin>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-10-farosas@suse.de> <ZQIX+KUgL5V6H/gj@x1n>
 <87jzstkaen.fsf@suse.de> <ZQJKQLNNZe772MUA@x1n> <87h6nwkhwl.fsf@suse.de>
 <ZQMfa38ulqQiRZ3d@x1n> <20230925093607.7f3ab989@penguin>
Date: Mon, 25 Sep 2023 09:20:58 -0300
Message-ID: <87y1gu4f6d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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

CC: Daniel for the QIOChannel discussion

Lukas Straub <lukasstraub2@web.de> writes:
> On Thu, 14 Sep 2023 10:57:47 -0400
> Peter Xu <peterx@redhat.com> wrote:
>
>> On Thu, Sep 14, 2023 at 10:23:38AM -0300, Fabiano Rosas wrote:
>> > Peter Xu <peterx@redhat.com> writes:
>> >   
>> > > On Wed, Sep 13, 2023 at 06:53:20PM -0300, Fabiano Rosas wrote:  
>> > >> Peter Xu <peterx@redhat.com> writes:
>> > >>   
>> > >> > On Mon, Sep 11, 2023 at 02:13:19PM -0300, Fabiano Rosas wrote:  
>> > >> >> The core yank code is strict about balanced registering and
>> > >> >> unregistering of yank functions.
>> > >> >> 
>> > >> >> This creates a difficulty because the migration code registers one
>> > >> >> yank function per QIOChannel, but each QIOChannel can be referenced by
>> > >> >> more than one QEMUFile. The yank function should not be removed until
>> > >> >> all QEMUFiles have been closed.
>> > >> >> 
>> > >> >> Keep a reference count of how many QEMUFiles are using a QIOChannel
>> > >> >> that has a yank function. Only unregister the yank function when all
>> > >> >> QEMUFiles have been closed.
>> > >> >> 
>> > >> >> This improves the current code by removing the need for the programmer
>> > >> >> to know which QEMUFile is the last one to be cleaned up and fixes the
>> > >> >> theoretical issue of removing the yank function while another QEMUFile
>> > >> >> could still be using the ioc and require a yank.
>> > >> >> 
>> > >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > >> >> ---
>> > >> >>  migration/yank_functions.c | 81 ++++++++++++++++++++++++++++++++++----
>> > >> >>  migration/yank_functions.h |  8 ++++
>> > >> >>  2 files changed, 81 insertions(+), 8 deletions(-)  
>> > >> >
>> > >> > I worry this over-complicate things.  
>> > >> 
>> > >> It does. We ran out of simple options.
>> > >>   
>> > >> > If you prefer the cleaness that we operate always on qemufile level, can we
>> > >> > just register each yank function per-qemufile?  
>> > >> 
>> > >> "just" hehe
>> > >> 
>> > >> we could, but:
>> > >> 
>> > >> i) the yank is a per-channel operation, so this is even more unintuitive;  
>> > >
>> > > I mean we can provide something like:
>> > >
>> > > void migration_yank_qemufile(void *opaque)
>> > > {
>> > >     QEMUFile *file = opaque;
>> > >     QIOChannel *ioc = file->ioc;
>> > >
>> > >     qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
>> > > }
>> > >
>> > > void migration_qemufile_register_yank(QEMUFile *file)
>> > > {
>> > >     if (migration_ioc_yank_supported(file->ioc)) {
>> > >         yank_register_function(MIGRATION_YANK_INSTANCE,
>> > >                                migration_yank_qemufile,
>> > >                                file);
>> > >     }
>> > > }  
>> > 
>> > Sure, this is what I was thinking as well. IMO it will be yet another
>> > operation that happens on the channel, but it performed via the
>> > file. Just like qio_channel_close() at qemu_fclose(). Not the end of the
>> > world, of course, I just find it error-prone.
>> >   
>> > >> 
>> > >> ii) multifd doesn't have a QEMUFile, so it will have to continue using
>> > >>     the ioc;  
>> > >
>> > > We can keep using migration_ioc_[un]register_yank() for them if there's no
>> > > qemufile attached.  As long as the function will all be registered under
>> > > MIGRATION_YANK_INSTANCE we should be fine having different yank func.
>> > >  
>> > 
>> > ok
>> >   
>> > >> 
>> > >> iii) we'll have to add a yank to every new QEMUFile created during the
>> > >>      incoming migration (colo, rdma, etc), otherwise the incoming side
>> > >>      will be left using iocs while the src uses the QEMUFile;  
>> > >
>> > > For RDMA, IIUC it'll simply be a noop as migration_ioc_yank_supported()
>> > > will be a noop for it for either reg/unreg.
>> > >
>> > > Currently it seems we will also unreg the ioc even for RDMA (even though we
>> > > don't reg for it).  But since unreg will be a noop it seems all fine even
>> > > if not paired.. maybe we should still try to pair it, e.g. register also in
>> > > rdma_start_outgoing_migration() for the rdma ioc so at least they're paired.
>> > >
>> > > I don't see why COLO is special here, though.  Maybe I missed something.  
>> > 
>> > For colo I was thinking we'd have to register the yank just to be sure
>> > that all paths unregistering it have something to unregister.
>> > 
>> > Maybe I should move the register into qemu_file_new_impl() with a
>> > matching unregister at qemu_fclose().  
>> 
>> Sounds good.  Or...
>> 
>> >   
>> > >> 
>> > >> iv) this is a functional change of the yank feature for which we have no
>> > >>     tests.  
>> > >
>> > > Having yank tested should be preferrable.  Lukas is in the loop, let's see
>> > > whether he has something. We can still smoke test it before a selftest
>> > > being there.
>> > >
>
> Hi All,
> Sorry for the late reply.
>
> Yes, testing missing. I'll work on it.
>
>> > > Taking one step back.. I doubt whether anyone is using yank for migration?
>> > > Knowing that migration already have migrate-cancel (for precopy) and
>> > > migrate-pause (for postcopy).  
>> > 
>> > Right, both already call qio_channel_shutdown().
>> >   
>> > > I never used it myself, and I don't think
>> > > it's supported for RHEL.  How's that in suse's case?  
>> > 
>> > Never heard mention of it and I don't see it in our virtualization
>> > documentation.
>> >   
>> > >
>> > > If no one is using it, maybe we can even avoid registering migration to
>> > > yank?
>> > >  
>> > 
>> > Seems reasonable to me.  
>> 
>> ... let's wait for a few days from Lukas to see whether he as any more
>> input, or I'd vote for dropping yank for migration as a whole. It caused
>> mostly more crashes that I knew than benefits, so far..
>> 
>> I also checked libvirt is not using yank.
>> 
>
> The main user for yank is COLO. It can't be replaced by 'migrate_pause'
> or 'migrate_cancel', because:
>
> 1) It needs to work while the main lock is taken by the migration
>    thread, so it needs to be an OOB qmp command. There are places
>    where the migration thread can hang on a socket while the main lock
>    is taken. 'migrate_pause' is OOB, but not usable in the COLO case (it
>    doesn't support postcopy).
>
> 2) In COLO, it needs to work both on outgoing and on incoming side, since
>    both sides have a completely healthy and ready to takeover guest state.
>
> I agree that the migration yank code was not well thought out :(.

I'd say the QIOChannel being referenced via multiple QEMUFiles throws a
curve ball to the yank design.

> I had the idea back then to create child class of the IOCs, e.g.
> YankableQIOChannelSocket and YankableQIOChannelTLS. It's not
> perfect, but then the lifetime of the yank functions is directly
> coupled with the iochannel. Then the IOCs can be used just as usual in
> the rest of the migration code.

The yank really wants to be tied to the channel. We should do that.

I'm just thinking whether a feature bit + setter would be simpler to
implement. It wouldn't require changing any of the object creation code,
just add a qio_channel_enable_yank() at the start of migration and let
the channel take care of the rest.

> Another problem area was to be that there was no clear point in
> migration code where all channels are closed to unregister the yank
> instance itself. That seems to be solved now?

I'm inclined to add reference counting all over instead of trying to
squint at the code and figure out where these cleanups should
go. Specially since we have these pause/recovery scenarios.

That said, I haven't looked closely at the instance unregister, but I
don't think this series changes anything that would help in that regard.

