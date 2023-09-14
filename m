Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1924B7A057C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmJw-0007t7-R8; Thu, 14 Sep 2023 09:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgmJt-0007so-3b
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:23:46 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgmJr-0001fg-4a
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:23:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09BD41F459;
 Thu, 14 Sep 2023 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694697822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUE7JEiegkyIm1yvGt2Y/uONzYRP6of28Hyhb3T0sa0=;
 b=HASw94rudRKxT9sD1QS+xwVz7Ii4TsvSfWsW1zHQZ4itq1ZSx1rfU/vJYyrT7mu022kfXP
 n2wTIyIwr451zYtFVRIKdu9KjJJYDwG7EOkU2KGkvGCLRkmCyPNPRYTpGyF9jbzuND3pQj
 0Kal0Xy4xgUnt4JsIKjD/ChJU/7OtgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694697822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUE7JEiegkyIm1yvGt2Y/uONzYRP6of28Hyhb3T0sa0=;
 b=mrZJwdQqz/hI/E3+iBcs7zlDWkkf1NbBRE/nt6z6ENkASAU7WsI39qh22Gvrd+oWggoO8+
 1LTM+daUjLTkmbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7895D13580;
 Thu, 14 Sep 2023 13:23:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YNwqDl0JA2XpUAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 14 Sep 2023 13:23:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v6 09/10] migration/yank: Keep track of registered yank
 instances
In-Reply-To: <ZQJKQLNNZe772MUA@x1n>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-10-farosas@suse.de> <ZQIX+KUgL5V6H/gj@x1n>
 <87jzstkaen.fsf@suse.de> <ZQJKQLNNZe772MUA@x1n>
Date: Thu, 14 Sep 2023 10:23:38 -0300
Message-ID: <87h6nwkhwl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Sep 13, 2023 at 06:53:20PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Sep 11, 2023 at 02:13:19PM -0300, Fabiano Rosas wrote:
>> >> The core yank code is strict about balanced registering and
>> >> unregistering of yank functions.
>> >> 
>> >> This creates a difficulty because the migration code registers one
>> >> yank function per QIOChannel, but each QIOChannel can be referenced by
>> >> more than one QEMUFile. The yank function should not be removed until
>> >> all QEMUFiles have been closed.
>> >> 
>> >> Keep a reference count of how many QEMUFiles are using a QIOChannel
>> >> that has a yank function. Only unregister the yank function when all
>> >> QEMUFiles have been closed.
>> >> 
>> >> This improves the current code by removing the need for the programmer
>> >> to know which QEMUFile is the last one to be cleaned up and fixes the
>> >> theoretical issue of removing the yank function while another QEMUFile
>> >> could still be using the ioc and require a yank.
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> ---
>> >>  migration/yank_functions.c | 81 ++++++++++++++++++++++++++++++++++----
>> >>  migration/yank_functions.h |  8 ++++
>> >>  2 files changed, 81 insertions(+), 8 deletions(-)
>> >
>> > I worry this over-complicate things.
>> 
>> It does. We ran out of simple options.
>> 
>> > If you prefer the cleaness that we operate always on qemufile level, can we
>> > just register each yank function per-qemufile?
>> 
>> "just" hehe
>> 
>> we could, but:
>> 
>> i) the yank is a per-channel operation, so this is even more unintuitive;
>
> I mean we can provide something like:
>
> void migration_yank_qemufile(void *opaque)
> {
>     QEMUFile *file = opaque;
>     QIOChannel *ioc = file->ioc;
>
>     qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> }
>
> void migration_qemufile_register_yank(QEMUFile *file)
> {
>     if (migration_ioc_yank_supported(file->ioc)) {
>         yank_register_function(MIGRATION_YANK_INSTANCE,
>                                migration_yank_qemufile,
>                                file);
>     }
> }

Sure, this is what I was thinking as well. IMO it will be yet another
operation that happens on the channel, but it performed via the
file. Just like qio_channel_close() at qemu_fclose(). Not the end of the
world, of course, I just find it error-prone.

>> 
>> ii) multifd doesn't have a QEMUFile, so it will have to continue using
>>     the ioc;
>
> We can keep using migration_ioc_[un]register_yank() for them if there's no
> qemufile attached.  As long as the function will all be registered under
> MIGRATION_YANK_INSTANCE we should be fine having different yank func.
>

ok

>> 
>> iii) we'll have to add a yank to every new QEMUFile created during the
>>      incoming migration (colo, rdma, etc), otherwise the incoming side
>>      will be left using iocs while the src uses the QEMUFile;
>
> For RDMA, IIUC it'll simply be a noop as migration_ioc_yank_supported()
> will be a noop for it for either reg/unreg.
>
> Currently it seems we will also unreg the ioc even for RDMA (even though we
> don't reg for it).  But since unreg will be a noop it seems all fine even
> if not paired.. maybe we should still try to pair it, e.g. register also in
> rdma_start_outgoing_migration() for the rdma ioc so at least they're paired.
>
> I don't see why COLO is special here, though.  Maybe I missed something.

For colo I was thinking we'd have to register the yank just to be sure
that all paths unregistering it have something to unregister.

Maybe I should move the register into qemu_file_new_impl() with a
matching unregister at qemu_fclose().

>> 
>> iv) this is a functional change of the yank feature for which we have no
>>     tests.
>
> Having yank tested should be preferrable.  Lukas is in the loop, let's see
> whether he has something. We can still smoke test it before a selftest
> being there.
>
> Taking one step back.. I doubt whether anyone is using yank for migration?
> Knowing that migration already have migrate-cancel (for precopy) and
> migrate-pause (for postcopy).

Right, both already call qio_channel_shutdown().

> I never used it myself, and I don't think
> it's supported for RHEL.  How's that in suse's case?

Never heard mention of it and I don't see it in our virtualization
documentation.

>
> If no one is using it, maybe we can even avoid registering migration to
> yank?
>

Seems reasonable to me.

>> 
>> If that's all ok to you I'll go ahead and git it a try.
>> 
>> > I think qmp yank will simply fail the 2nd call on the qemufile if the
>> > iochannel is shared with the other one, but that's totally fine, IMHO.
>> >
>> > What do you think?
>> >
>> > In all cases, we should probably at least merge patch 1-8 if that can
>> > resolve the CI issue.  I think all of them are properly reviewed.
>> 
>> I agree. Someone needs to queue this though since Juan has been busy.
>
> Yes, I'll see what I can do.

Thanks. I could even send a pull request myself if it would make things
easier. Let me know.

