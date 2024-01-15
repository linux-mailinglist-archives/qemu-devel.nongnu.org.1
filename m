Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 240B282D396
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 05:14:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPELp-00060H-6W; Sun, 14 Jan 2024 23:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPELi-000602-Tk
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:13:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPELg-0004qC-RR
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705291999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tiTbpoNZQuxI7Y2egCbw+5F4P7ijhup4MXkxuVMM1WA=;
 b=ce/u+TIgTyzECa5LX+Y2afYiJVaehwI0sIW1huH8MtCx+A2jtrsuF9hCI3kB96CxtgvcEs
 sYaoZqxsASLhDl3pNZwTzIatyNXDydUlmX9up1Cj7IGwZHapJTn1JkwbllS+7MzpQ8f/Fi
 1frAtTReCTIoMwdXicavY/rJSWEb+hk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-JZT-cOEmOMOf5BS6gB1LRg-1; Sun, 14 Jan 2024 23:13:13 -0500
X-MC-Unique: JZT-cOEmOMOf5BS6gB1LRg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5ce9b15f4ccso940201a12.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 20:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705291992; x=1705896792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiTbpoNZQuxI7Y2egCbw+5F4P7ijhup4MXkxuVMM1WA=;
 b=oBjA1YV7L+z1mXqi6REWnDT6Vgp6DHE999bpOa7jRHpBbPbU48v3E4i16fcSSPYQ1v
 hq4e3joW3TPEu9dNfD0mbxnZBNn61Ct0VTpqusSDhe3jsmMj3pJRWzCz4cZcov9j0o8e
 k00ngBAgu8uz85zvoloI0BaVn+kioKd0DSM8FQF3B59/kTrMRrmuPI88ZiDJAVlwGoQf
 KbWH8tFogswQJyaf/BcOPE4YM28yNMQ5SpC/JsSaBti52BFaiNaYB/IMrv4YFOPr29i8
 6K7QVxU/uotHRadoy3Fu0cH2BG+81Fph9ciMcvtepfeZVTYQTTNizd72noQ+JmLK8BNj
 Izig==
X-Gm-Message-State: AOJu0Yxvh4dmdbbxMryCr6qbVRvcXIe8vx7LTK+ltdgtQ390/t3zGkg9
 QIMZ/51mWHzwsQSb/RIH547l/VfBAB2h6TT6EzoXP6NQnqylnrKfrL1OhhioBMONBbB22M0x76H
 SpLF5YsH4NfihIRo6j47Ii7I=
X-Received: by 2002:a05:6a21:680b:b0:19a:d4d7:57ba with SMTP id
 wr11-20020a056a21680b00b0019ad4d757bamr3919500pzb.6.1705291991874; 
 Sun, 14 Jan 2024 20:13:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvpb4tz4CRp+S653NfjWAPl/3+hK2CvlLgLmrNh3eRQ6LqQNXaY+mX9o+93Md3qIhjvOjoEQ==
X-Received: by 2002:a05:6a21:680b:b0:19a:d4d7:57ba with SMTP id
 wr11-20020a056a21680b00b0019ad4d757bamr3919494pzb.6.1705291991494; 
 Sun, 14 Jan 2024 20:13:11 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 u8-20020a17090282c800b001d5b93560cbsm2844085plz.127.2024.01.14.20.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 20:13:11 -0800 (PST)
Date: Mon, 15 Jan 2024 12:13:00 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] [NOT FOR MERGE] tests/qtest/migration: Adapt
 tests to use older QEMUs
Message-ID: <ZaSwzM95tm24Uqyu@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-5-farosas@suse.de> <ZZuvDREDrQ07HsGs@x1n>
 <877ckj3kfp.fsf@suse.de> <ZZzC1n0GotQZukqJ@x1n>
 <87zfxe7eev.fsf@suse.de> <ZZ4YOw6Cy5EYo_f4@x1n>
 <87zfxd6yid.fsf@suse.de> <ZZ9T2XSy3zaOEu_W@x1n>
 <874jfknf8m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jfknf8m.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 11, 2024 at 10:58:49AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jan 10, 2024 at 11:42:18AM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Tue, Jan 09, 2024 at 11:46:32AM -0300, Fabiano Rosas wrote:
> >> >> Hm, it would be better to avoid the extra maintenance task at the start
> >> >> of every release, no? It also blocks us from doing n-2 even
> >> >> experimentally.
> >> >
> >> > See my other reply, on whether we can use "n-1" for migration-test.  If
> >> > that can work for us, then IIUC we can avoid either "since:" or any
> >> > relevant flag, neither do we need to unmask tests after each releases.  All
> >> > old tests should always "just work" with a new qemu binary.
> >> 
> >> Hmm.. There are some assumptions here:
> >> 
> >> 1) New code will always be compatible with old tests. E.g. some
> >>    patchseries changed code and changed a test to match the new
> >>    code. Then we'd need a flag like 'since' anyway to mark that the new
> >>    QEMU cannot be used with the old test.
> >> 
> >>    (if new QEMU is not compatible with old tests without any good
> >>    reason, then that's just a regression I think)
> >
> > Exactly what you are saying here.  We can't make new QEMU not working on
> > old tests.
> 
> Ok, so we need to forbid breaking changes to tests from now on. I'll try
> to add some words in the docs about this.
> 
> >
> > One way to simplify the understanding is, we can imagine the old tests as
> > "some user currently using the old QEMU, and who would like to migrate to
> > the master QEMU binary".  Such user only uses exactly the same cmdline we
> > used for testing migration-test in exactly that n-1 qemu release binary.
> >
> > If we fail that old test, it means we can already fail such an user.
> > That's destined a regression to me, no?  Or, do you have a solid example?
> 
> For instance, we used to not issue the SETUP event on incoming. If a
> test (or user app) expected to see the ACTIVE or FAILED states, then
> would it be a regression to now start issuing the SETUP event at the
> proper place?

Valid example.  And it's a tricky example in that it actually breaks the
ABI even though slightly, however events are just normally more flexible in
this case, so we didn't care.

I think it means we didn't care any program expecting no SETUP before
ACTIVE, or such user already crashes.

Our migration-test is compatible with such change, right?

I think the trick here is we shouldn't make migration-test to ever contain
any "assumption" of the internals of QEMU.  It should only behave strictly
as what an user can use QEMU, and that should always be guaranteed to work
on newer qemu binaries.  Then breaking old migration-test will be the same
as breaking an user, and it'll naturally fit in this model too of using n-1
version of migration-test.

> 
> Anyway, it's pointless to give examples because we either allow old
> tests to be changed or we don't. If we don't then that's solved. If we
> do, we'll always have space for the situation I mentioned in 1) above.

IMHO we should allow any changes to old tests, IMHO.  It won't apply to n-1
test anyway, not until the next release.  It may depend on how you define
"changed" in this case.

> 
> > The only thing I can think of is, when we want to e.g. obsolete a QEMU
> > cmdline that is used in migration-test.  But then that cmdline needs to be
> > declared obsolete first for a few releases (let's say, 4), and before that
> > deadline we should already rewrite migration-test to not use it, and as
> > long as we do it in 3 releases I suppose nothing will be affected.
> >
> >> 
> >> 2) There would not be issues when fixing bugs/refactoring
> >>    tests. E.g. old tests had a bug that is now fixed, but since we're
> >>    not using the new tests, the bug is always there until next
> >>    release. This could block the entire test suite, specially with
> >>    concurrency bugs which can start triggering due to changes in timing.
> >
> > Yes this might be a problem.  Note that the old tests we're using will be
> > exactly the same test we released previous QEMU.  I am "assuming" that the
> > test case is as stable as the released QEMU, since we kept running it for
> > all pulls in CI runs.  If we see anything flaky, we should mark it
> > especially right before the release, then the released tests will be
> > considerably stable.
> 
> It's not just the test case. The whole test infrastructure could change
> entirely. But let's maybe cross that bridge when we get to it.
> 
> >
> > The worst case is we still keep a knob in the CI file, and we can turn off
> > n-1 -> n tests for the CI for some release if there's some unfortunate
> > accident. But I hope in reality that can be avoided.
> >
> >> 
> >> 3) New code that can only be reached via new tests cannot cause
> >>    regressions. E.g. new code is added but is kept under a machine
> >>    property or migration capability. That code will only show the
> >>    regression after the new test enables that cap/property. At that
> >>    point it's too late because it was already released.
> >
> > I can't say I fully get the point here.  New code, if with a new cap with
> > it, should run exactly like the old code if the cap is not turned on.  I
> > suppose that's the case for when we only run n-1 version of migration-test.
> > IMHO it's the same issue as 1) above, that we just should not break it, and
> > if we do, that's exactly what we want to capture and fix in master, not n-1
> > branch.
> >
> > But as I said, perhaps I didn't really get the issue you wanted to describe..
> 
> if (cap_foo()) {
>    <do something bad>
> }
> 
> This^ only executes once we have a test that enables cap_foo. If the
> "something bad" is something that breaks compatibility, then we'll miss
> it when using n-1 migration-test.

IMHO the n-1 tests are not for this.  The new FOO cap can only be enabled
in n+ versions anyway, so something like above should be covered by the
normal migration test that anyone would like to propose the new FOO cap.
The n-1 test we're discussing is extra tests on top of that.  So:

  - Same binary test: we (of course) keep running migration-test for
    master, covers FOO

  - Cross binary testA: we (hopefully since 9.0?) runs n-1 migration-test
    for previous release

Then after n boosts, the new FOO test (that will enable FOO) will become
part of n-1 tests.

> 
> Now that I think about it, should we parameterize the CI so we can
> actually switch between old migration-tests and new migration-tests? So
> we make the default what you suggest, but still have the ability to
> trigger a job every once in a while that uses the new tests.

Certainly. Such a knob will never hurt, I assume.  It's just that I'd
expect new migration-test could constantly fail the cross-binary test as
long as we introduce new features.  Maybe it's a matter of whether we would
like migration-test itself to understand the "version" idea.

What I was saying above is trying to reduce our burden to teach
migration-test to understand any version concept.  So migration-test always
applies only to the master branch (and newer; due to migration's strict
ABI), no need to detect any cap as long as master supports it.

-- 
Peter Xu


