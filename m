Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C605782B01D
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:00:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvaR-0006MF-Kh; Thu, 11 Jan 2024 08:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNvaM-0006Lo-1x
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:59:06 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNvaI-0005Ph-Bp
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:59:05 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 442052209F;
 Thu, 11 Jan 2024 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704981532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxXwFcRGsPYRp6cR9Do94J/yHGJNfL7TxNICEM6gg0M=;
 b=KDkN9JPjyxuvNfWx+rm+aJb1/DvpScb4IymqcYNVsQ4DOzknULLtYlFVUeq4FWQHmfPuYD
 bC9WWMrGVM+N+GI8V2sLUSFJWHCqTggmUvdPyhx6KdMxTLTykZqCiAtfOa4XfpAaV/gJoh
 0T5BHjYtA5hmWW1IVK5V8kX/pNMyvyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704981532;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxXwFcRGsPYRp6cR9Do94J/yHGJNfL7TxNICEM6gg0M=;
 b=sQcVZJ+lsEjbqqQ55/5uyW6wWSjyR8M1H71/VbeP2BpSFv6M4xps+YPiryF8/EtOvrMaXl
 irD1ybOzsOOhL4AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704981532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxXwFcRGsPYRp6cR9Do94J/yHGJNfL7TxNICEM6gg0M=;
 b=KDkN9JPjyxuvNfWx+rm+aJb1/DvpScb4IymqcYNVsQ4DOzknULLtYlFVUeq4FWQHmfPuYD
 bC9WWMrGVM+N+GI8V2sLUSFJWHCqTggmUvdPyhx6KdMxTLTykZqCiAtfOa4XfpAaV/gJoh
 0T5BHjYtA5hmWW1IVK5V8kX/pNMyvyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704981532;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxXwFcRGsPYRp6cR9Do94J/yHGJNfL7TxNICEM6gg0M=;
 b=sQcVZJ+lsEjbqqQ55/5uyW6wWSjyR8M1H71/VbeP2BpSFv6M4xps+YPiryF8/EtOvrMaXl
 irD1ybOzsOOhL4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF60B13635;
 Thu, 11 Jan 2024 13:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p58vIRv0n2UROAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Jan 2024 13:58:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] [NOT FOR MERGE] tests/qtest/migration: Adapt
 tests to use older QEMUs
In-Reply-To: <ZZ9T2XSy3zaOEu_W@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-5-farosas@suse.de> <ZZuvDREDrQ07HsGs@x1n>
 <877ckj3kfp.fsf@suse.de> <ZZzC1n0GotQZukqJ@x1n> <87zfxe7eev.fsf@suse.de>
 <ZZ4YOw6Cy5EYo_f4@x1n> <87zfxd6yid.fsf@suse.de> <ZZ9T2XSy3zaOEu_W@x1n>
Date: Thu, 11 Jan 2024 10:58:49 -0300
Message-ID: <874jfknf8m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KDkN9JPj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sQcVZJ+l
X-Spamd-Result: default: False [-5.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 442052209F
X-Spam-Score: -5.31
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Wed, Jan 10, 2024 at 11:42:18AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Tue, Jan 09, 2024 at 11:46:32AM -0300, Fabiano Rosas wrote:
>> >> Hm, it would be better to avoid the extra maintenance task at the start
>> >> of every release, no? It also blocks us from doing n-2 even
>> >> experimentally.
>> >
>> > See my other reply, on whether we can use "n-1" for migration-test.  If
>> > that can work for us, then IIUC we can avoid either "since:" or any
>> > relevant flag, neither do we need to unmask tests after each releases.  All
>> > old tests should always "just work" with a new qemu binary.
>> 
>> Hmm.. There are some assumptions here:
>> 
>> 1) New code will always be compatible with old tests. E.g. some
>>    patchseries changed code and changed a test to match the new
>>    code. Then we'd need a flag like 'since' anyway to mark that the new
>>    QEMU cannot be used with the old test.
>> 
>>    (if new QEMU is not compatible with old tests without any good
>>    reason, then that's just a regression I think)
>
> Exactly what you are saying here.  We can't make new QEMU not working on
> old tests.

Ok, so we need to forbid breaking changes to tests from now on. I'll try
to add some words in the docs about this.

>
> One way to simplify the understanding is, we can imagine the old tests as
> "some user currently using the old QEMU, and who would like to migrate to
> the master QEMU binary".  Such user only uses exactly the same cmdline we
> used for testing migration-test in exactly that n-1 qemu release binary.
>
> If we fail that old test, it means we can already fail such an user.
> That's destined a regression to me, no?  Or, do you have a solid example?

For instance, we used to not issue the SETUP event on incoming. If a
test (or user app) expected to see the ACTIVE or FAILED states, then
would it be a regression to now start issuing the SETUP event at the
proper place?

Anyway, it's pointless to give examples because we either allow old
tests to be changed or we don't. If we don't then that's solved. If we
do, we'll always have space for the situation I mentioned in 1) above.

> The only thing I can think of is, when we want to e.g. obsolete a QEMU
> cmdline that is used in migration-test.  But then that cmdline needs to be
> declared obsolete first for a few releases (let's say, 4), and before that
> deadline we should already rewrite migration-test to not use it, and as
> long as we do it in 3 releases I suppose nothing will be affected.
>
>> 
>> 2) There would not be issues when fixing bugs/refactoring
>>    tests. E.g. old tests had a bug that is now fixed, but since we're
>>    not using the new tests, the bug is always there until next
>>    release. This could block the entire test suite, specially with
>>    concurrency bugs which can start triggering due to changes in timing.
>
> Yes this might be a problem.  Note that the old tests we're using will be
> exactly the same test we released previous QEMU.  I am "assuming" that the
> test case is as stable as the released QEMU, since we kept running it for
> all pulls in CI runs.  If we see anything flaky, we should mark it
> especially right before the release, then the released tests will be
> considerably stable.

It's not just the test case. The whole test infrastructure could change
entirely. But let's maybe cross that bridge when we get to it.

>
> The worst case is we still keep a knob in the CI file, and we can turn off
> n-1 -> n tests for the CI for some release if there's some unfortunate
> accident. But I hope in reality that can be avoided.
>
>> 
>> 3) New code that can only be reached via new tests cannot cause
>>    regressions. E.g. new code is added but is kept under a machine
>>    property or migration capability. That code will only show the
>>    regression after the new test enables that cap/property. At that
>>    point it's too late because it was already released.
>
> I can't say I fully get the point here.  New code, if with a new cap with
> it, should run exactly like the old code if the cap is not turned on.  I
> suppose that's the case for when we only run n-1 version of migration-test.
> IMHO it's the same issue as 1) above, that we just should not break it, and
> if we do, that's exactly what we want to capture and fix in master, not n-1
> branch.
>
> But as I said, perhaps I didn't really get the issue you wanted to describe..

if (cap_foo()) {
   <do something bad>
}

This^ only executes once we have a test that enables cap_foo. If the
"something bad" is something that breaks compatibility, then we'll miss
it when using n-1 migration-test.

Now that I think about it, should we parameterize the CI so we can
actually switch between old migration-tests and new migration-tests? So
we make the default what you suggest, but still have the ability to
trigger a job every once in a while that uses the new tests.

