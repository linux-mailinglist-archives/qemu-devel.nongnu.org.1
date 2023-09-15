Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C187A135B
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 03:58:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgy4Q-0001Bo-Um; Thu, 14 Sep 2023 21:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgy4O-0001Bd-Qr
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 21:56:32 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgy4N-0007W7-1O
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 21:56:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6464B218DF;
 Fri, 15 Sep 2023 01:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694742987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QG8Hd9AANb+Ua9NJ6ImZE7FB1rpMvm23l+0eGlve+Yg=;
 b=qJ3tmrvbY+wdtnYgQzx/Q2+vcYKGfxEq8prUmeH0Pi4R1ahvZDaw86KAKo1o66aoHWqx+Y
 yFrGW7TOa99AtOZiNL2FsEPjPLot/MUaWANftYH4SA8xEoqwIXJYvhNDHNOSnclbo8HYoh
 u5CVpPgRImtAh51avtf+9rzh7CFlIhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694742987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QG8Hd9AANb+Ua9NJ6ImZE7FB1rpMvm23l+0eGlve+Yg=;
 b=DIOUc9gpa2E5TmoGzzwBSKRVvtk4IVkTRPefhsKFlXzlWxu+y9pIcHQs5Oz2IQXGIzY6bR
 HALGPuXoYvp1t4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C464C1358A;
 Fri, 15 Sep 2023 01:56:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cL3DHcq5A2VsEwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 15 Sep 2023 01:56:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
In-Reply-To: <ZQOW4BS1ZcDTN7tK@x1n>
References: <20230913192301.GA917052@fedora> <87r0n1kggo.fsf@suse.de>
 <ZQMfIO3oiqTsawtU@x1n> <87edj0kcz7.fsf@suse.de> <ZQMoUzRH1BZKs39g@x1n>
 <87bke4kasr.fsf@suse.de> <ZQM3SV4eqSltoQSe@x1n> <87led8e9vv.fsf@suse.de>
 <87r0n0nz6u.fsf@suse.de> <ZQOW4BS1ZcDTN7tK@x1n>
Date: Thu, 14 Sep 2023 22:56:23 -0300
Message-ID: <87o7i4nqrc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Thu, Sep 14, 2023 at 07:54:17PM -0300, Fabiano Rosas wrote:
>> Fabiano Rosas <farosas@suse.de> writes:
>> 
>> > Peter Xu <peterx@redhat.com> writes:
>> >
>> >> On Thu, Sep 14, 2023 at 12:57:08PM -0300, Fabiano Rosas wrote:
>> >>> I managed to reproduce it. It's not the return path error. In hindsight
>> >>> that's obvious because that error happens in the 'recovery' test and this
>> >>> one in the 'plain' one. Sorry about the noise.
>> >>
>> >> No worry.  It's good to finally identify that.
>> >>
>> >>> 
>> >>> This one reproduced with just 4 iterations of preempt/plain. I'll
>> >>> investigate.
>> >
>> > It seems that we're getting a tcp disconnect (ECONNRESET) on when doing
>> > that shutdown() on postcopy_qemufile_src. The one from commit 6621883f93
>> > ("migration: Fix potential race on postcopy_qemufile_src").
>> >
>> > I'm trying to determine why that happens when other times it just
>> > returns 0 as expected.
>> >
>> > Could this mean that we're kicking the dest too soon while it is still
>> > receiving valid data?
>> 
>> Looking a bit more into this, what's happening is that
>> postcopy_ram_incoming_cleanup() is shutting the postcopy_qemufile_dst
>> while ram_load_postcopy() is still running.
>> 
>> The postcopy_ram_listen_thread() function waits for the
>> main_thread_load_event, but that only works when not using preempt. With
>> the preempt thread, the event is set right away and we proceed to do the
>> cleanup without waiting.
>> 
>> So the assumption of commit 6621883f93 that the incoming side knows when
>> it has finished migrating is wrong IMO. Without the EOS we're relying on
>> the chance that the shutdown() happens after the last recvmsg has
>> returned and not during it.
>> 
>> Peter, what do you think?
>
> That's a good point.
>
> One thing to verify that (sorry, I still cannot reproduce it myself, which
> is so weirdly... it seems loads won't really help reproducing this) is to
> let the main thread wait for all requested pages to arrive:
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 29aea9456d..df055c51ea 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -597,6 +597,12 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>      trace_postcopy_ram_incoming_cleanup_entry();
>  
>      if (mis->preempt_thread_status == PREEMPT_THREAD_CREATED) {
> +        /*
> +         * NOTE!  it's possible that the preempt thread is still handling
> +         * the last pages to arrive which were requested by faults.  Making
> +         * sure nothing is left behind.
> +         */
> +        while (qatomic_read(&mis->page_requested_count));
>          /* Notify the fast load thread to quit */
>          mis->preempt_thread_status = PREEMPT_THREAD_QUIT;
>          if (mis->postcopy_qemufile_dst) {
>
> If that can work solidly, we can figure out a better way than a dead loop
> here.

Yep, 2000+ iterations so far and no error.

Should we add something that makes ram_load_postcopy return once it's
finished? Then this code could just set PREEMPT_THREAD_QUIT and join the
preempt thread.

