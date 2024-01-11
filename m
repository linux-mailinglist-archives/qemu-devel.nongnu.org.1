Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6039382A619
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 03:36:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNkua-0000ZB-Hs; Wed, 10 Jan 2024 21:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNkuY-0000Yz-MD
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 21:35:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNkuW-0005cK-P3
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 21:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704940511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MaBlF5Lk8/ZMF8qV3YwV9ogFpSDVDnDCCGCeio6u090=;
 b=ZsqqYjtdOk7hM4CWmVg4pXTqrpDXqFgyyecOOct5PNLoZ7kBLgIF1yTyoTeYo5/lmQgQcX
 y4/zB2I5bAZhxugalYkJ9us/SpggTxboEMOxSk8v1q8rt0pEVfTpSmmRBhkIZJyC3WiXfQ
 1K1rMiftKg5xLCmvzYBGn53peb5heu8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-tATRF3wWPAO27PFoxkmS3Q-1; Wed, 10 Jan 2024 21:35:09 -0500
X-MC-Unique: tATRF3wWPAO27PFoxkmS3Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-28bd331cb57so1618325a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 18:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704940509; x=1705545309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaBlF5Lk8/ZMF8qV3YwV9ogFpSDVDnDCCGCeio6u090=;
 b=odArMY0Dpj3Me6so0cx8K7+P5JRgTGo0Mwt4nT+PdtbvZOyQDqzXIuqwVrUBLy0+Bs
 ksZvbj5XrkCwiJ0D/eAbjABnEf+KybUKauP3ypMyJt9EgLtAZ5W3pYV2nNgrPeHfQJOV
 ZVsPOsNAE3eHFlXGyph8JMhu4ypBCAEXqADnT+gsdT0SwSeb5LwqkZHZXfeESp4tl6Or
 MDGVInSEbRvBt5ZbrCJifvPu3BPx4QXiHi8GbwUlqMcshvJFwX1qHEwRIBbynnOSRPz6
 IgjcIY8/e7uZFSYTWm/krqBMcVhiM0qirphEfqeb6NH8NHlycpc8vMLh1JJn79Ia9P3q
 OeDw==
X-Gm-Message-State: AOJu0YxMe1s8CWBu+EmdDSE/weLdnIvwq12afctElY7cXQ+VSwcRKbet
 7mFSsdFJIHeGZShxl8VEZoLkpOrk/9Ca0OqYdmbvqkojmBGjxF1rOPneaXmkwGCqEVWu1A24Qui
 Zvph3+36WCkorbXrb3Tuw1ck=
X-Received: by 2002:a17:90b:3903:b0:28c:fe8c:aa93 with SMTP id
 ob3-20020a17090b390300b0028cfe8caa93mr914906pjb.1.1704940508799; 
 Wed, 10 Jan 2024 18:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2cNWZIs/XeiKAHA9J7gtddOKHaZu4+EBCgRtOmcUxvB4jYPL1ArA1OLD/S9Bn8rXksGQGVA==
X-Received: by 2002:a17:90b:3903:b0:28c:fe8c:aa93 with SMTP id
 ob3-20020a17090b390300b0028cfe8caa93mr914896pjb.1.1704940508434; 
 Wed, 10 Jan 2024 18:35:08 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sd5-20020a17090b514500b0028d573397dcsm2329150pjb.42.2024.01.10.18.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 18:35:07 -0800 (PST)
Date: Thu, 11 Jan 2024 10:35:05 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] [NOT FOR MERGE] tests/qtest/migration: Adapt
 tests to use older QEMUs
Message-ID: <ZZ9T2XSy3zaOEu_W@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-5-farosas@suse.de> <ZZuvDREDrQ07HsGs@x1n>
 <877ckj3kfp.fsf@suse.de> <ZZzC1n0GotQZukqJ@x1n>
 <87zfxe7eev.fsf@suse.de> <ZZ4YOw6Cy5EYo_f4@x1n>
 <87zfxd6yid.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfxd6yid.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 10, 2024 at 11:42:18AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Jan 09, 2024 at 11:46:32AM -0300, Fabiano Rosas wrote:
> >> Hm, it would be better to avoid the extra maintenance task at the start
> >> of every release, no? It also blocks us from doing n-2 even
> >> experimentally.
> >
> > See my other reply, on whether we can use "n-1" for migration-test.  If
> > that can work for us, then IIUC we can avoid either "since:" or any
> > relevant flag, neither do we need to unmask tests after each releases.  All
> > old tests should always "just work" with a new qemu binary.
> 
> Hmm.. There are some assumptions here:
> 
> 1) New code will always be compatible with old tests. E.g. some
>    patchseries changed code and changed a test to match the new
>    code. Then we'd need a flag like 'since' anyway to mark that the new
>    QEMU cannot be used with the old test.
> 
>    (if new QEMU is not compatible with old tests without any good
>    reason, then that's just a regression I think)

Exactly what you are saying here.  We can't make new QEMU not working on
old tests.

One way to simplify the understanding is, we can imagine the old tests as
"some user currently using the old QEMU, and who would like to migrate to
the master QEMU binary".  Such user only uses exactly the same cmdline we
used for testing migration-test in exactly that n-1 qemu release binary.

If we fail that old test, it means we can already fail such an user.
That's destined a regression to me, no?  Or, do you have a solid example?

The only thing I can think of is, when we want to e.g. obsolete a QEMU
cmdline that is used in migration-test.  But then that cmdline needs to be
declared obsolete first for a few releases (let's say, 4), and before that
deadline we should already rewrite migration-test to not use it, and as
long as we do it in 3 releases I suppose nothing will be affected.

> 
> 2) There would not be issues when fixing bugs/refactoring
>    tests. E.g. old tests had a bug that is now fixed, but since we're
>    not using the new tests, the bug is always there until next
>    release. This could block the entire test suite, specially with
>    concurrency bugs which can start triggering due to changes in timing.

Yes this might be a problem.  Note that the old tests we're using will be
exactly the same test we released previous QEMU.  I am "assuming" that the
test case is as stable as the released QEMU, since we kept running it for
all pulls in CI runs.  If we see anything flaky, we should mark it
especially right before the release, then the released tests will be
considerably stable.

The worst case is we still keep a knob in the CI file, and we can turn off
n-1 -> n tests for the CI for some release if there's some unfortunate
accident.  But I hope in reality that can be avoided.

> 
> 3) New code that can only be reached via new tests cannot cause
>    regressions. E.g. new code is added but is kept under a machine
>    property or migration capability. That code will only show the
>    regression after the new test enables that cap/property. At that
>    point it's too late because it was already released.

I can't say I fully get the point here.  New code, if with a new cap with
it, should run exactly like the old code if the cap is not turned on.  I
suppose that's the case for when we only run n-1 version of migration-test.
IMHO it's the same issue as 1) above, that we just should not break it, and
if we do, that's exactly what we want to capture and fix in master, not n-1
branch.

But as I said, perhaps I didn't really get the issue you wanted to describe..

> 
> In general I like the simplicity of your approach, but it would be
> annoying to change this series only to find out we still need some sort
> of flag later. Even worse, #3 would miss the point of this kind of
> testing entirely.
> 
> #1 could be mitigated by a "no changes to tests rule". We'd start
> requiring that new tests be written and an existing test is never
> altered. For #2 and #3 I don't have a solution.
> 

-- 
Peter Xu


