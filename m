Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B6F77EBA5
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 23:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWNx0-0006yj-SJ; Wed, 16 Aug 2023 17:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWNwx-0006yW-O1
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:21:07 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWNws-0001hG-7h
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:21:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D8D01F86C;
 Wed, 16 Aug 2023 21:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692220861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6m3T0CEHSiwA6AoWlyxVwouiuf5+wAI8hbMvWWQtrKs=;
 b=NhzTIZzI6GTZy/K78PG8uRgal2utvbFq6JZQINTUX88Vfy1f0lQ+YhmQsR1eqQpKSup7ds
 dJK22Ae1Ougb1VRGHz2sFzAVSCalFU8xHF8GVY5tT1NbjIRO64fwJzdguRwL5+uMmhJCTN
 M+ynyeyTiCW6Vvfu35mcT7ZG/A+Bl2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692220861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6m3T0CEHSiwA6AoWlyxVwouiuf5+wAI8hbMvWWQtrKs=;
 b=5Lo/2oLkN6JODziMoiAsG2IunuPjSt1JLwOdq0xDBDBfqMe736ehQ3U2w9KVkFU0ING0wx
 tbwvRdw5t9xmJ1BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4524133F2;
 Wed, 16 Aug 2023 21:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fpCtG7w93WSHOgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 16 Aug 2023 21:21:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Wei Wang
 <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v4 8/8] migration: Add a wrapper to cleanup migration files
In-Reply-To: <ZN0lgcI3Ieksdbv/@x1n>
References: <20230816142510.5637-1-farosas@suse.de>
 <20230816142510.5637-9-farosas@suse.de> <ZNzot6bDD15S3U7u@x1n>
 <87leealt8h.fsf@suse.de> <ZN0k/DFQQIeEpgjl@x1n> <ZN0lgcI3Ieksdbv/@x1n>
Date: Wed, 16 Aug 2023 18:20:58 -0300
Message-ID: <87edk24rb9.fsf@suse.de>
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

> On Wed, Aug 16, 2023 at 03:35:24PM -0400, Peter Xu wrote:
>> On Wed, Aug 16, 2023 at 03:47:26PM -0300, Fabiano Rosas wrote:
>> > Peter Xu <peterx@redhat.com> writes:
>> > 
>> > > On Wed, Aug 16, 2023 at 11:25:10AM -0300, Fabiano Rosas wrote:
>> > >> @@ -2003,6 +1980,8 @@ static int open_return_path_on_source(MigrationState *ms)
>> > >>          return -1;
>> > >>      }
>> > >>  
>> > >> +    migration_ioc_register_yank(qemu_file_get_ioc(ms->rp_state.from_dst_file));
>> > >
>> > > I think I didn't really get why it wasn't paired before yesterday.  My
>> > > fault.
>> > >
>> > > Registering from_dst_file, afaict, will register two identical yank objects
>> > > because the ioc is the same.
>> > >
>> > 
>> > Why do we have two QEMUFiles for the same fd again?
>> 
>> Because qemufile has a "direction" (either read / write)?
>> 
>> > 
>> > We're bound to crash at some point by trying to qemu_fclose() the two
>> > QEMUFiles at the same time.
>> 
>> Even with each qemufile holding a reference on the ioc object?  I thought
>> it won't crash, but if it will please point that out; or fix it would be
>> even better.

You're right, it wouldn't crash. But it's still the same ioc object. If
qio_channel_close() is called twice, then we could potentially close the
fd twice. Which would either error out or close a reused fd. The window
is small though, so probably unlikely to ever happen.

>> 
>> > 
>> > > Should we make migration_file_release() not handle the unregister of
>> > > yank(), but leave that to callers?  Then we keep the rule of only register
>> > > yank for each ioc once.
>> > >
>> > 
>> > We need the unregister to be at migration_file_release() so that it
>> > takes benefit of the locking while checking the file for NULL. If it
>> > moves out then the caller will have to do locking as well. Which
>> > defeats the purpose of the patch.
>> > 
>> > I don't understand why you moved the unregister out of channel_close in
>> > commit 39675ffffb ("migration: Move the yank unregister of channel_close
>> > out"). You called it a "hack" at the time, but looking at the current
>> > situation, it seems like a reasonable thing to do: unregister the yank
>> > when the ioc refcount drops to 1.
>> > 
>> > I would go even further and say that qemu_fclose should also avoid
>> > calling qio_channel_close if the ioc refcnt is elevated.
>> 
>> I'd rather not; I still think it's a hack, always open to be corrected.

It's hard to figure out what you mean by hack at times. Even more when
reading a years-old commit message.

>> 
>> I think the problem is yank can register anything so it's separate from
>> iochannels.  If one would like to have ioc close() automatically
>> unregister, then one should also register yank transparently without the
>> ioc user even aware of yank's existance.

Ok, fair point.

>> 
>> Now the condition is the caller register yank itself, then I think the
>> caller should unreg it.. not iochannel itself, silently.

I think the issue is that we're linking the yank with the QEMUFile for
no reason. The migration_yank_iochannel() performs a
qio_channel_shutdown() which is an operation on the fd. The QEMUFile
just happens to hold a pointer to the ioc.

>
> I just noticed this is not really copying the list.. let me add the cc list
> back, assuming it was just forgotten.

I'm sorry, I hit the wrong key while replying.

> One more thing to mention is, now I kind of agree probably we should
> register yank over each qemufile, as you raised the concern in the other
> thread that otherwise qmp_yank() won't set error for the qemufile, which
> seems to be unexpected.

I haven't made up my mind yet, but I think I'd rather stop setting that
error instead of doing it from other places. A shutdown() is mostly a
benign operation intended to end the connection. The fact that we use it
in some cases to kick the thread out of a possible hang doesn't seem
compelling enough to set -EIO.

Of course we currently have no other way to indicate that the file was
shutdown, so the -EIO will have to stay and that's a discussion for
another day.



