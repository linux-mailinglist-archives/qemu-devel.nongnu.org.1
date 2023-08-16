Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 561D377E46F
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHxk-0001DX-Gd; Wed, 16 Aug 2023 10:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWHxb-000191-Kk
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:57:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWHxZ-0002so-C9
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:57:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 366431F750;
 Wed, 16 Aug 2023 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692197840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MPHo9MF+6a2oaber3vNqVdtTXntRHec62ngSyqdab5A=;
 b=iogl7gMIrXwlmovmwqGeETiBj5f2kL9AZ92qRctsl/s4RHUChAKbHfPdeInK+L1o9PrTw8
 qj+0/nxF1K2+tfyIcpDu/jDHkzeHwVuywABJIWUPHr59MU9mK5Wfu2eAiOKbhoNgAPKMOx
 0dDu0J98EHcoUI4aMJGpfnMkETlH8SE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692197840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MPHo9MF+6a2oaber3vNqVdtTXntRHec62ngSyqdab5A=;
 b=J47CddLgJJ3/gXLX1A/0m6GuGiNYVmU5lHiQ2nrPDiZ4HtqzbQnOTBQYIyymh8ogch+bdS
 EXImUjiu7GEIzhBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC4D01353E;
 Wed, 16 Aug 2023 14:57:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bjGiIc/j3GT7CQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 16 Aug 2023 14:57:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Wei Wang
 <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>
Subject: Re: [PATCH v3 10/10] migration: Add a wrapper to cleanup migration
 files
In-Reply-To: <ZNzcek7oqn+ccoQ+@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-11-farosas@suse.de> <ZNv4/ndxGPpaIX9H@x1n>
 <875y5glyyn.fsf@suse.de> <ZNzcek7oqn+ccoQ+@x1n>
Date: Wed, 16 Aug 2023 11:57:17 -0300
Message-ID: <87r0o3kpbm.fsf@suse.de>
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Aug 15, 2023 at 07:31:28PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Fri, Aug 11, 2023 at 12:08:36PM -0300, Fabiano Rosas wrote:
>> >> We currently have a pattern for cleaning up a migration QEMUFile:
>> >> 
>> >>   qemu_mutex_lock(&s->qemu_file_lock);
>> >>   file = s->file_name;
>> >>   s->file_name = NULL;
>> >>   qemu_mutex_unlock(&s->qemu_file_lock);
>> >> 
>> >>   migration_ioc_unregister_yank_from_file(file);
>> >>   qemu_file_shutdown(file);
>> >>   qemu_fclose(file);
>> >> 
>> >> There are some considerations for this sequence:
>> >> 
>> >> - we must clear the pointer under the lock, to avoid TOC/TOU bugs;
>> >> - the shutdown() and close() expect be given a non-null parameter;
>> >> - a close() in one thread should not race with a shutdown() in another;
>> >> 
>> >> Create a wrapper function to make sure everything works correctly.
>> >> 
>> >> Note: the return path did not used to call
>> >>       migration_ioc_unregister_yank_from_file(), but I added it
>> >>       nonetheless for uniformity.
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >
>> > This definitely looks cleaner.  Probably can be squashed together with
>> > previous patch?  If you could double check whether we can just drop the
>> > shutdown() all over the places when close() altogether, it'll be even
>> > nicer (I hope I didn't miss any real reasons to explicitly do that).
>> >
>> >> diff --git a/util/yank.c b/util/yank.c
>> >> index abf47c346d..4b6afbf589 100644
>> >> --- a/util/yank.c
>> >> +++ b/util/yank.c
>> >> @@ -146,8 +146,6 @@ void yank_unregister_function(const YankInstance *instance,
>> >>              return;
>> >>          }
>> >>      }
>> >> -
>> >> -    abort();
>> >
>> > I think we can't silently do this.  This check is very strict and I guess
>> > you removed it because you hit a crash.  What's the crash?  Can we just
>> > pair the yank reg/unreg?
>> >
>> 
>> Well, the abort() is the crash. It just means that we looped and didn't
>> find the handler to unregister. It looks harmless to me. I should have
>> mentioned this in the commit message.
>
> Yeah, trust me I wanted to remove that for quite a few times. :) But then I
> normally decided to try harder to find what's missing; and so far indeed I
> found that the cleanest way is always pair the reg/unreg.
>
>> 
>> I could certainly add a yank handler to the rp_state.from_dst_file. But
>> then I have no idea what will happen if we try to yank the return path
>> at a random moment.
>
> I think the idea was it should be registered always when the channel is
> created, and then unregistered when the channel is destroyed.  They should
> just pair, alongside with the channel's lifecycle?
>
>> 
>> Side note: I see that yank does a qio_channel_shutdown() without the
>> controversial setting of -EIO. Which means it is probably succeptible to
>> the same race described in the qemu_file_shutdown() code.
>
> Are you looking outside migration code (I saw nbd_teardown_connection()
> does have one)?
>
> For migration IIUC it's always via migration_ioc_unregister_yank().

I'm talking about the actual yank action, not the unregister.

migration_yank_iochannel() calls qio_channel_shutdown() in the same way
as qemu_file_shutdown(), but unlike the latter, it doesn't set
f->last_error = -EIO. Which means that in theory, we could yank and
still try to use the QEMUFile.

In other words, what commit a555b8092a ("qemu-file: Don't do IO after
shutdown") did does not apply to yank because yank didn't exit at the
time.

