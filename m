Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DDD76A264
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:04:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa2i-0001iq-Sl; Mon, 31 Jul 2023 17:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qQa2g-0001eM-8b
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:03:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qQa2e-0006aQ-JY
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:03:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4156A1F893;
 Mon, 31 Jul 2023 21:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690837379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k/NCUUqTB0zGzH1MyqVOJRV2shsIGNsQA78PlRMDLK8=;
 b=1vKRgcYNf80tk9Mr1+P4YslKXO3LEvXHAIIZVd4S1dxLSfw92QAwuF4PuDYfTzT+Sf59jo
 T5tfSZtMULoyxUX/VxmS7XJj+5EvZn1Sdr39ex29SvDRK1ydw1FuTrR0XBOd9U6a/WEdYm
 HxUlfio3qUVYdugWpZq05wHIxmSdfEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690837379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k/NCUUqTB0zGzH1MyqVOJRV2shsIGNsQA78PlRMDLK8=;
 b=FELWculo7xCpdkuPPpC50LCDWMAEE79d531CRmjp+Qjy0YZpGOGYSd5fBBQ6Nu66SdajrR
 4nkuJcDqdJMMPEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8C9C1322C;
 Mon, 31 Jul 2023 21:02:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wBtrJIIhyGSlBwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 31 Jul 2023 21:02:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH 1/3] migration: Stop marking RP bad after shutdown
In-Reply-To: <ZMQ1LbTl5kGmAG21@x1n>
References: <20230728121516.16258-1-farosas@suse.de>
 <20230728121516.16258-2-farosas@suse.de> <ZMQ1LbTl5kGmAG21@x1n>
Date: Mon, 31 Jul 2023 18:02:56 -0300
Message-ID: <87cz07yetb.fsf@suse.de>
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

> On Fri, Jul 28, 2023 at 09:15:14AM -0300, Fabiano Rosas wrote:
>> When waiting for the return path (RP) thread to finish, there is
>> really nothing wrong in the RP if the destination end of the migration
>> stops responding, leaving it stuck.
>> 
>> Stop returning an error at that point and leave it to other parts of
>> the code to catch. One such part is the very next routine run by
>> migration_completion() which checks 'to_dst_file' for an error and fails
>> the migration. Another is the RP thread itself when the recvmsg()
>> returns an error.
>> 
>> With this we stop marking RP bad from outside of the thread and can
>> reuse await_return_path_close_on_source() in the next patches to wait
>> on the thread during a paused migration.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 91bba630a8..051067f8c5 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2049,7 +2049,6 @@ static int await_return_path_close_on_source(MigrationState *ms)
>>           * waiting for the destination.
>>           */
>>          qemu_file_shutdown(ms->rp_state.from_dst_file);
>> -        mark_source_rp_bad(ms);
>>      }
>>      trace_await_return_path_close_on_source_joining();
>>      qemu_thread_join(&ms->rp_state.rp_thread);
>
> The retval of await_return_path_close_on_source() relies on
> ms->rp_state.error.  If mark_source_rp_bad() is dropped, is it possible
> that it'll start to return succeed where it used to return failure?

Yep, as described in the commit message, I think it's ok to do that. The
critical part is doing the shutdown. Other instances of
mark_source_rp_bad() continue existing and we continue returning
rp_state.error.

>
> Maybe not a big deal: I see migration_completion() also has another
> qemu_file_get_error() later to catch errors, but I don't know how solid
> that is.

That is the instance I refer to in the commit message. At
await_return_path_close_on_source() we only call mark_source_rp_bad() if
to_dst_file has an error. That will be caught by this
qemu_file_get_error() anyway.


