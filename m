Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8E0722893
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 16:16:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Ayr-0003Kr-5Y; Mon, 05 Jun 2023 10:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6Ayp-0003Ki-Dy
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6Ayn-00081L-Fa
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685974480;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f03NARX1r24ZzqWz3LBmTiHkWD+33SZNX4M4gtZEDnA=;
 b=YhuySHBZwDm5e8jZlQDmpTWUIvTxY1IWp1Q8xcatL+0+e6llg0F+oUI8HUb9d/cOmIS+aj
 rrAlMDg7jehgTQEpNRNpRJ1LQA7//iXnNO27nAGR5jfpxcB60iO0IpvUeVBBpN/bVQlouf
 mUNFFk1fNwwymkYk1HLP+Ci80RABdWU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-bNjMc34pOO6LwOMDKeUdUQ-1; Mon, 05 Jun 2023 10:14:39 -0400
X-MC-Unique: bNjMc34pOO6LwOMDKeUdUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F12172A59578;
 Mon,  5 Jun 2023 14:14:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EB55140E954;
 Mon,  5 Jun 2023 14:14:37 +0000 (UTC)
Date: Mon, 5 Jun 2023 15:14:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/6] tests: enable meson test timeouts to improve
 debuggability
Message-ID: <ZH3tyx//NRnvKY0m@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
 <a0bb4c2a-92ad-4290-3eb8-4168b8828d76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0bb4c2a-92ad-4290-3eb8-4168b8828d76@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jun 05, 2023 at 04:07:46PM +0200, Thomas Huth wrote:
> On 01/06/2023 18.31, Daniel P. Berrangé wrote:
> > Perhaps the most painful of all the GitLab CI failures we see are
> > the enforced job timeouts:
> > 
> >     "ERROR: Job failed: execution took longer than 1h15m0s seconds"
> > 
> >     https://gitlab.com/qemu-project/qemu/-/jobs/4387047648
> > 
> > when that hits the CI log shows what has *already* run, but figuring
> > out what was currently running (or rather stuck) is an horrendously
> > difficult.
> > 
> > The initial meson port disabled the meson test timeouts, in order to
> > limit the scope for introducing side effects from the port that would
> > complicate adoption.
> > 
> > Now that the meson port is basically finished we can take advantage of
> > more of its improved features. It has the ability to set timeouts for
> > test programs, defaulting to 30 seconds, but overridable per test. This
> > is further helped by fact that we changed the iotests integration so
> > that each iotests was a distinct meson test, instead of having one
> > single giant (slow) test.
> > 
> > We already set overrides for a bunch of tests, but they've not been
> > kept up2date since we had timeouts disabled. So this series first
> > updates the timeout overrides such that all tests pass when run in
> > my test gitlab CI pipeline. Then it enables use of meson timeouts.
> > 
> > We might still hit timeouts due to non-deterministic performance of
> > gitlab CI runners. So we'll probably have to increase a few more
> > timeouts in the short term. Fortunately this is going to be massively
> > easier to diagnose. For example this job during my testing:
> > 
> >     https://gitlab.com/berrange/qemu/-/jobs/4392029495
> > 
> > we can immediately see  the problem tests
> > 
> > Summary of Failures:
> >    6/252 qemu:qtest+qtest-i386 / qtest-i386/bios-tables-test                TIMEOUT        120.02s   killed by signal 15 SIGTERM
> >    7/252 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test          TIMEOUT        120.03s   killed by signal 15 SIGTERM
> >   64/252 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test                  TIMEOUT        300.03s   killed by signal 15 SIGTERM
> > 
> > The full meson testlog.txt will show each individual TAP log output,
> > so we can then see exactly which test case we got stuck on.
> > 
> > NB, the artifacts are missing on the job links above, until this
> > patch merges:
> > 
> >     https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04668.html
> > 
> > NB, this series sets the migration-test timeout to 5 minutes, which
> > is only valid if this series is merged to make the migration test
> > not suck:
> > 
> >    https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg00286.html
> > 
> > without that series, we'll need to set the migration-test timeout to
> > 30 minutes instead.
> > 
> > Daniel P. Berrangé (6):
> >    qtest: bump min meson timeout to 60 seconds
> >    qtest: bump migration-test timeout to 5 minutes
> >    qtest: bump qom-test timeout to 7 minutes
> >    qtest: bump aspeed_smc-test timeout to 2 minutes
> >    qtest: bump bios-table-test timeout to 6 minutes
> >    mtest2make: stop disabling meson test timeouts
> > 
> >   scripts/mtest2make.py   |  3 ++-
> >   tests/qtest/meson.build | 16 ++++++----------
> >   2 files changed, 8 insertions(+), 11 deletions(-)
> 
> FWIW, I now ran this on my rather old laptop with an --enable-debug
> build with "make -j$(nproc) check-qtest" and got these additional
> failures (beside the expected migration-test that still needs its
> final speedup):
> 
>  qtest-aarch64/test-hmp        TIMEOUT   120.07s   killed by signal 15 SIGTERM
>  qtest-aarch64/qom-test        TIMEOUT   420.09s   killed by signal 15 SIGTERM
>  qtest-arm/qom-test            TIMEOUT   420.10s   killed by signal 15 SIGTERM
>  qtest-arm/npcm7xx_pwm-test    TIMEOUT   150.04s   killed by signal 15 SIGTERM
>  qtest-ppc64/pxe-test          TIMEOUT    60.01s   killed by signal 15 SIGTERM
>  qtest-sparc/prom-env-test     TIMEOUT    60.01s   killed by signal 15 SIGTERM
>  qtest-sparc/boot-serial-test  TIMEOUT    60.01s   killed by signal 15 SIGTERM

Did you see any others in the 45-60 second time window, as those would
be candidates for increases too - don't want to have things right below
the 60 second cutoff ?

> When I run them manually without the timeout patch, I get these
> values:
> 
>  qtest-aarch64/test-hmp             OK   168.66s   95 subtests passed
>  qtest-aarch64/qom-test             OK   646.37s   94 subtests passed
>  qtest-arm/qom-test                 OK   621.64s   89 subtests passed
>  qtest-arm/npcm7xx_pwm-test         OK   225.48s   24 subtests passed
>  qtest-ppc64/pxe-test               OK    96.95s   2 subtests passed
>  qtest-sparc/prom-env-test          OK    95.94s   3 subtests passed
>  qtest-sparc/boot-serial-test       OK    92.96s   3 subtests passed
> 
>  HTH,
>   Thomas
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


