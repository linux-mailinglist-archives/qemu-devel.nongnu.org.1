Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAFA975BDE
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 22:39:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soU6Q-0003Jj-Qd; Wed, 11 Sep 2024 16:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soU6L-0003J9-NR
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 16:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soU6I-0006dD-W1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 16:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726087084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tc98jv/dNqMzj3rxpwSFCUvva+Qaw++yugHRtISXi1E=;
 b=QapkDjKB2uidCJ6SFshsHsHerRNJwiU8yUhK717JGtSBLutq9SrVFaqyPKJBFQrZCmSamJ
 HVY2voFGsZZOwEn+aE74DkYaUi3mWDCI8takf24LhJlGkvvDLmymPpkbNTykLFzTbEqiKE
 6lU+i8mR0C1ap/mY+2qz6Fiq5n20AYE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-afQDSXSqNjSjFthFzLggoA-1; Wed, 11 Sep 2024 16:38:03 -0400
X-MC-Unique: afQDSXSqNjSjFthFzLggoA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c353a05885so2589206d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 13:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726087083; x=1726691883;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tc98jv/dNqMzj3rxpwSFCUvva+Qaw++yugHRtISXi1E=;
 b=EyFiTfpBJprcMMME4i4kBc/Gv2RjaUnWOVyVX0+Q1EhwYBdcgBbP4mvpeCv0Z4oCGR
 +g/N35KEG8PPadCv2x68w6EHuYlT4xe+ojYuVbdZMR/a75eXU5kmKGyFxXAOA3JTKKI6
 5DODUJzqIVY4HdWJEs3U22Pavg8yAhwGnfGwy8nXRyjJ3Ks2Up3HdEZCF4JUampi2a90
 9Yk9eOY4iPUbZqAFPi/GWMT1sAL2n9HauQb9IWJSxu2JDl8HXbwudW+GjH1Jf7ph/ahD
 DGn7wPuURmdCnqgnMHJY3bXURC0xpZbYay1koPJDVPlmh0qVukvkeWHYnYCC42cjdOsO
 95hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPde0TKRReynpxBqNaoVruFrJwjTQfV+I4O8IqjGJhccERfZ/bzfk6wUpcldLIbGxzDBi5r6elb/lY@nongnu.org
X-Gm-Message-State: AOJu0YxSJtMfghKPzybIi7bqY4pxWh2vyAWXsw6lKeoOdBmrFhGKbweB
 ciE8hTeSv68fcqB48MlyKULQn4xRNKGxQW48TEib9A4O30MKVs/GIFmdhmpzvyvjAOs0G0xa6Vp
 PL4YVKT9Z44o7L3kV8lCBNn7S01Tukztk/aoYLz+/5DEivCR+NOPb
X-Received: by 2002:a05:6214:588a:b0:6c3:6de3:fa06 with SMTP id
 6a1803df08f44-6c57350c8d2mr9899956d6.9.1726087082569; 
 Wed, 11 Sep 2024 13:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9t60/58VzyNtkvMbVc5fMVd9A52A/oEPO3Vhw95qyY0Z4oqk1elEO0bON0JOgtAAc8QI0tA==
X-Received: by 2002:a05:6214:588a:b0:6c3:6de3:fa06 with SMTP id
 6a1803df08f44-6c57350c8d2mr9899466d6.9.1726087082003; 
 Wed, 11 Sep 2024 13:38:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53474d749sm46012376d6.92.2024.09.11.13.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 13:38:01 -0700 (PDT)
Date: Wed, 11 Sep 2024 16:37:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
Message-ID: <ZuH_pvnTCumKuXTh@x1n>
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
 <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
 <Zt8H6pC2yQ2DD7DV@x1n> <87frq8lcgp.fsf@suse.de>
 <ZuC4pYT-atQwWePv@x1n> <87seu7qhao.fsf@suse.de>
 <ZuG-SijLg8Q27boE@x1n> <87ed5qq8e2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ed5qq8e2.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 11, 2024 at 04:48:21PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Sep 10, 2024 at 07:23:43PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Mon, Sep 09, 2024 at 06:54:46PM -0300, Fabiano Rosas wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> 
> >> >> > On Mon, Sep 09, 2024 at 03:02:57PM +0100, Peter Maydell wrote:
> >> >> >> On Mon, 9 Sept 2024 at 14:51, Hyman Huang <yong.huang@smartx.com> wrote:
> >> >> >> >
> >> >> >> > Despite the fact that the responsive CPU throttle is enabled,
> >> >> >> > the dirty sync count may not always increase because this is
> >> >> >> > an optimization that might not happen in any situation.
> >> >> >> >
> >> >> >> > This test case just making sure it doesn't interfere with any
> >> >> >> > current functionality.
> >> >> >> >
> >> >> >> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> >> >> >> 
> >> >> >> tests/qtest/migration-test already runs 75 different
> >> >> >> subtests, takes up a massive chunk of our "make check"
> >> >> >> time, and is very commonly a "times out" test on some
> >> >> >> of our CI jobs. It runs on five different guest CPU
> >> >> >> architectures, each one of which takes between 2 and
> >> >> >> 5 minutes to complete the full migration-test.
> >> >> >> 
> >> >> >> Do we really need to make it even bigger?
> >> >> >
> >> >> > I'll try to find some time in the next few weeks looking into this to see
> >> >> > whether we can further shrink migration test times after previous attemps
> >> >> > from Dan.  At least a low hanging fruit is we should indeed put some more
> >> >> > tests into g_test_slow(), and this new test could also be a candidate (then
> >> >> > we can run "-m slow" for migration PRs only).
> >> >> 
> >> >> I think we could (using -m slow or any other method) separate tests
> >> >> that are generic enough that every CI run should benefit from them
> >> >> vs. tests that are only useful once someone starts touching migration
> >> >> code. I'd say very few in the former category and most of them in the
> >> >> latter.
> >> >> 
> >> >> For an idea of where migration bugs lie, I took a look at what was
> >> >> fixed since 2022:
> >> >> 
> >> >> # bugs | device/subsystem/arch
> >> >> ----------------------------------
> >> >>     54 | migration
> >> >>     10 | vfio
> >> >>      6 | ppc
> >> >>      3 | virtio-gpu
> >> >>      2 | pcie_sriov, tpm_emulator,
> >> >>           vdpa, virtio-rng-pci
> >> >>      1 | arm, block, gpio, lasi,
> >> >>           pci, s390, scsi-disk,
> >> >>           virtio-mem, TCG
> >> >
> >> > Just curious; how did you collect these?
> >> 
> >> git log --since=2022 and then squinted at it. I wrote a warning to take
> >> this with a grain of salt, but it missed the final version.
> >> 
> >> >
> >> >> 
> >> >> From these, ignoring the migration bugs, the migration-tests cover some
> >> >> of: arm, ppc, s390, TCG. The device_opts[1] patch hasn't merged yet, but
> >> >> once it is, then virtio-gpu would be covered and we could investigate
> >> >> adding some of the others.
> >> >> 
> >> >> For actual migration code issues:
> >> >> 
> >> >> # bugs | (sub)subsystem | kind
> >> >> ----------------------------------------------
> >> >>     13 | multifd        | correctness/races
> >> >>      8 | ram            | correctness
> >> >>      8 | rdma:          | general programming
> >> >
> >> > 8 rdma bugs??? ouch..
> >> 
> >> Mostly caught by a cleanup from Markus. Silly stuff like of mixed signed
> >> integer comparisons and bugs in error handling. I don't even want to
> >> look too much at it.
> >> 
> >> ...hopefully this release we'll manage to resolve that situation.
> >> 
> >> >
> >> >>      7 | qmp            | new api bugs
> >> >>      5 | postcopy       | races
> >> >>      4 | file:          | leaks
> >> >>      3 | return path    | races
> >> >>      3 | fd_cleanup     | races
> >> >>      2 | savevm, aio/coroutines
> >> >>      1 | xbzrle, colo, dirtyrate, exec:,
> >> >>           windows, iochannel, qemufile,
> >> >>           arch (ppc64le)
> >> >> 
> >> >> Here, the migration-tests cover well: multifd, ram, qmp, postcopy,
> >> >> file, rp, fd_cleanup, iochannel, qemufile, xbzrle.
> >> >> 
> >> >> My suggestion is we run per arch:
> >> >> 
> >> >> "/precopy/tcp/plain"
> >> >> "/precopy/tcp/tls/psk/match",
> >> >> "/postcopy/plain"
> >> >> "/postcopy/preempt/plain"
> >> >> "/postcopy/preempt/recovery/plain"
> >> >> "/multifd/tcp/plain/cancel"
> >> >> "/multifd/tcp/uri/plain/none"
> >> >
> >> > Don't you want to still keep a few multifd / file tests?
> >> 
> >> Not really, but I won't object if you want to add some more in there. To
> >> be honest, I want to get out of people's way as much as I can because
> >> having to revisit this every couple of months is stressful to me.
> >
> > I hope migration tests are not too obstructive yet so far :) - this
> > discussion is still within a context where we might add one more slow test
> > in CI, and we probably simply should make it a -m slow test.
> >
> >> 
> >> My rationale for those is:
> >> 
> >> "/precopy/tcp/plain":
> >>  Smoke test, the most common migration
> >
> > E.g. unix is missing, and I'm not sure which we use for e.g. kubevirt.
> >
> > And note that even if unix shares the socket iochannel with tcp, it may not
> > work the same.  For example, if you remember I mentioned I was looking at
> > threadify the dest qemu receive side, i have a draft there but currently it
> > has a bug to hang a unix migration, not tcp..
> 
> Ok, let's add a unix one, no problem.
> 
> >
> > So IMHO it's not easy to justify which we can simply drop, if we still want
> > to provide some good gating in CI.
> 
> It's not exactly about dropping, it's about which ones need to be run at
> *every* invocation of make check (x5 because of the multiple archs) and

Yeah, indeed we could consider reducing the number of runs, maybe.  However
I do remember we used to have migration-test bugs only reproduced with some
specific distro, well..

Now I'm looking at the pipelines..

Why 5x, btw?  I saw alphine, centos, debian, fedora, opensuse, ubuntu,
cfi-x86_64, then compat-x86_64.  So that's 8x?  They're for the same arch
(amd64) so far.

Maybe we can skip some indeed.

> at every git branch push in CI (unless -o ci.skip). For gating we don't
> need all the tests. Many of them are testing the same core code with
> just a few differences at the margins.
> 
> >  And I won't be 100% surprised if some
> > other non-migration PR (e.g. io/) changed some slight bit that unix is
> > broken and tcp keeps working, for example, then we loose some CI benefits.
> 
> IMO, these non-migration PRs are exactly what we have to worry
> about. Because migration PRs would run with -m slow and we'd catch the
> issue there.
> 
> >
> >> 
> >> "/precopy/tcp/tls/psk/match":
> >>  Something might change in the distro regarding tls. Such as:
> >>  https://gitlab.com/qemu-project/qemu/-/issues/1937
> >> 
> >> "/postcopy/plain":
> >>  Smoke test for postcopy
> >> 
> >> "/postcopy/preempt/plain":
> >>  Just to exercise the preempt thread
> >> 
> >> "/postcopy/preempt/recovery/plain":
> >>  Recovery has had some issues with races in the past
> >> 
> >> "/multifd/tcp/plain/cancel":
> >>  The MVP of catching concurrency issues
> >> 
> >> "/multifd/tcp/uri/plain/none":
> >>  Smoke test for multifd
> >> 
> >> All in all, these will test basic funcionality and run very often. The
> >> more tests we add to this set, the less return we get in relation to the
> >> time they take.
> >
> > This is true.  We can try to discuss more on which is more important; I
> > still think something might be good to be added on top of above.
> 
> Sure, just add what you think we need.

Let's leave the detailed discussion on what to choose until the patch
phase.  IIUC this can be the last we do.

We've just queued your other patch to "slow down" the two time consuming
tests, we save 40s for each CI kick (total ~90s now locally, so that's 30%
cut already all acrosss!), not so bad as a start.

Then if we can remove some out of 8 (e.g., we can choose 2-3), then if it's
3 system runs, it'll be another 62% cut, a total of:

  1.0 - 9/13 * 3/8 = ~75%

So if we keep removing 5 system running it we can reduce it to only a
quarter time comparing to before for each CI run.

Would that be good enough already for us to live for quite a few more
releases?  They're so far all low hanging fruits.

If we want to move further (and you think we should then start with
reducing test case, rather than profiling the test cases), then feel free
to go ahead and send a patch when you're ready.  But maybe you don't want
to bother after you notice that we can already shrink 75% of runtime even
without dropping anything.  Your call!

> 
> >
> > There's also the other way - at some point, I still want to improve
> > migration-test run speed, and please have a look if you like too at some
> > point: so there's still chance (average is ~2sec as of now), IMHO, we don't
> > lose anything in CI but runs simply faster.
> 
> My only idea, but it requires a bit of work, is to do unit testing on
> the interfaces. Anything before migration_fd_connect(). Then we could
> stop doing a full migration for those.

What I'm thinking is some further profiling, like what Dan used to do.  I
feel like we still have chance, considering what we run as guest image is
simply a loop.. so basically zero boot time logically.

> 
> >
> >> 
> >> >
> >> > IIUC some file ops can still be relevant to archs.  Multifd still has one
> >> > bug that can only reproduce on arm64.. but not x86_64.  I remember it's a
> >> > race condition when migration finishes, and the issue could be memory
> >> > ordering relevant, but maybe not.
> >> 
> >> I'm not aware of anything. I believe the last arm64 bug we had was the
> >> threadinfo stuff[1]. If you remember what it's about, let me know.
> >> 
> >> 1- 01ec0f3a92 ("migration/multifd: Protect accesses to migration_threads").
> >
> > https://issues.redhat.com/browse/RHEL-45628
> 
> Interesting. But if multifd/tcp/plain/cancel doesn't catch this I don't
> think other tests will. Also, we don't have tests for zerocopy AFAIK.

That'll be challenging as it requires locked_vm limit.

> 
> >
> > On RH side Bandan is looking at it, but he's during a long holidays
> > recently.
> 
> Good luck to him.
> 
> >
> >> 
> >> >
> >> >> 
> >> >> and x86 gets extra:
> >> >> 
> >> >> "/precopy/unix/suspend/live"
> >> >> "/precopy/unix/suspend/notlive"
> >> >> "/dirty_ring"
> >> >
> >> > dirty ring will be disabled anyway when !x86, so probably not a major
> >> > concern.
> >> >
> >> >> 
> >> >> (the other dirty_* tests are too slow)
> >> >
> >> > These are the 10 slowest tests when I run locally:
> >> >
> >> > /x86_64/migration/multifd/tcp/tls/x509/allow-anon-client 2.41
> >> > /x86_64/migration/postcopy/recovery/plain 2.43
> >> > /x86_64/migration/multifd/tcp/tls/x509/default-host 2.66
> >> > /x86_64/migration/multifd/tcp/tls/x509/override-host 2.86
> >> > /x86_64/migration/postcopy/tls/psk 2.91
> >> > /x86_64/migration/postcopy/preempt/recovery/tls/psk 3.08
> >> > /x86_64/migration/postcopy/preempt/tls/psk 3.30
> >> > /x86_64/migration/postcopy/recovery/tls/psk 3.81
> >> > /x86_64/migration/vcpu_dirty_limit 13.29
> >> > /x86_64/migration/precopy/unix/xbzrle 27.55
> >> >
> >> > Are you aware of people using xbzrle at all?
> >> 
> >> Nope.
> >> 
> >> >
> >> >> 
> >> >> All the rest go behind a knob that people touching migration code will
> >> >> enable.
> >> >> 
> >> >> wdyt?
> >> >
> >> > Agree with the general idea, but I worry above exact list can be too small.
> >> 
> >> We won't stop running the full set of tests. We can run them in our
> >> forks' CI as much as we want. There are no cases of people reporting a
> >> migration bug because their 'make check' caught something that ours
> >> didn't.
> >
> > IIUC it's hard to say - when the test is in CI maintainers can catch them
> > already before sending a formal PR.
> >
> > If the test is run by default in make check, a developer can trigger a
> > migration issue (with his/her patch applied) then one can notice it
> > introduced a bug, fix it, then post the patches.  We won't know whether
> > that happened.
> 
> Good point.
> 
> >
> > So one thing we can do (if you think worthwhile to do it now) is we shrink
> > the default test case a lot as you proposed, then we wait and see what
> > breaks, and then we gradually add tests back when it can be used to find
> > breakages.  But that'll also take time if it really can find such tests,
> > because then we'll need to debug them one by one (instead of developer /
> > maintainer looking into them with their expertise knowledge..).  I'm not
> > sure whether it's worthwhile to do it now, but I don't feel strongly if we
> > can still have a reliable set of default test cases.
> 
> We first need a way to enable them for the migration CI. Do we have a
> variable that CI understands that can be used to enable slow tests?

I'm not aware of.  Yes sounds like we should have one if it doesn't exist.

> 
> >
> >> 
> >> Besides, the main strength of CI is to catch bugs when someone makes a
> >> code change. If people touch migration code, then we'll run it in our CI
> >> anyway. If they touch device code and that device is migrated by default
> >> then any one of the simple tests will catch the issue when it runs via
> >> the migration-compat job. If the device is not enabled by default, then
> >> no tests will catch it.
> >> 
> >> The worst case scenario is they touch some code completely unrelated and
> >> their 'make check' or CI run breaks because of some race in the
> >> migration code. That's not what CI is for, that's just an annoyance for
> >> everyone. I'd rather it breaks in our hands and then we'll go fix it.
> >> 
> >> >
> >> > IMHO we can definitely, at least, move the last two into slow list
> >> > (vcpu_dirty_limit and xbzrle), then it'll already save us 40sec each run..
> >> 
> >> Agreed. I'll send a patch once I get out from under downstream stuff.
> >> 
> >> >
> >> >> 
> >> >> 1- allows adding devices to QEMU cmdline for migration-test
> >> >> https://lore.kernel.org/r/20240523201922.28007-4-farosas@suse.de
> >> >> 
> >> 
> 

-- 
Peter Xu


