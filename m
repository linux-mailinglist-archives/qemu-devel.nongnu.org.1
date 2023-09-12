Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2B579D5FC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:15:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg61s-0007Ik-1H; Tue, 12 Sep 2023 12:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg61p-0007IT-AZ
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg61l-0001L5-0o
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694535251;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2iNQiLHeS7XLMxS5vuFmrlJfPe79VSq3tNN9mNYU2Fs=;
 b=In1jJ3hvr46OXGewP0wKcuDkCdC1c0wu9quqBykj1Y3u2xbE5kuDN4tkCDlhzMQ3ll7o62
 J4C0zQnVM/15bpNgUdRRGBVG8J4I5+AypWPIO64VnxCl6kaR1o0n+gWlG6AA7mcJb6PqrF
 XQ6KqqbufDqQIlYhLorjEengQdbXMr0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-hYHA0Wu7Mwi63soPQhSHkw-1; Tue, 12 Sep 2023 12:14:08 -0400
X-MC-Unique: hYHA0Wu7Mwi63soPQhSHkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A094A3C0D194;
 Tue, 12 Sep 2023 16:14:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 968DF40C6EA8;
 Tue, 12 Sep 2023 16:14:06 +0000 (UTC)
Date: Tue, 12 Sep 2023 17:14:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH] gitlab: remove unreliable avocado CI jobs
Message-ID: <ZQCOTJMyMCgNCu3l@redhat.com>
References: <20230912150611.70676-1-stefanha@redhat.com>
 <ZQCBoCI6lvJqhsbd@redhat.com> <8734zjv0ph.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734zjv0ph.fsf@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 12, 2023 at 05:01:26PM +0100, Alex Bennée wrote:
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Sep 12, 2023 at 11:06:11AM -0400, Stefan Hajnoczi wrote:
> >> The avocado-system-alpine, avocado-system-fedora, and
> >> avocado-system-ubuntu jobs are unreliable. I identified them while
> >> looking over CI failures from the past week:
> >> https://gitlab.com/qemu-project/qemu/-/jobs/5058610614
> >> https://gitlab.com/qemu-project/qemu/-/jobs/5058610654
> >> https://gitlab.com/qemu-project/qemu/-/jobs/5030428571
> >> 
> >> Thomas Huth suggest on IRC today that there may be a legitimate failure
> >> in there:
> >> 
> >>   th_huth: f4bug, yes, seems like it does not start at all correctly on
> >>   alpine anymore ... and it's broken since ~ 2 weeks already, so if nobody
> >>   noticed this by now, this is worrying
> >> 
> >> It crept in because the jobs were already unreliable.
> >> 
> >> I don't know how to interpret the job output, so all I can do is to
> >> propose removing these jobs. A useful CI job has two outcomes: pass or
> >> fail. Timeouts and other in-between states are not useful because they
> >> require constant triaging by someone who understands the details of the
> >> tests and they can occur when run against pull requests that have
> >> nothing to do with the area covered by the test.
> >> 
> >> Hopefully test owners will be able to identify the root causes and solve
> >> them so that these jobs can stay. In their current state the jobs are
> >> not useful since I cannot cannot tell whether job failures are real or
> >> just intermittent when merging qemu.git pull requests.
> >> 
> >> If you are a test owner, please take a look.
> >> 
> >> It is likely that other avocado-system-* CI jobs have similar failures
> >> from time to time, but I'll leave them as long as they are passing.
> >> 
> >> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1884
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> ---
> >>  .gitlab-ci.d/buildtest.yml | 27 ---------------------------
> >>  1 file changed, 27 deletions(-)
> >> 
> >> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> >> index aee9101507..83ce448c4d 100644
> >> --- a/.gitlab-ci.d/buildtest.yml
> >> +++ b/.gitlab-ci.d/buildtest.yml
> >> @@ -22,15 +22,6 @@ check-system-alpine:
> >>      IMAGE: alpine
> >>      MAKE_CHECK_ARGS: check-unit check-qtest
> >>  
> >> -avocado-system-alpine:
> >> -  extends: .avocado_test_job_template
> >> -  needs:
> >> -    - job: build-system-alpine
> >> -      artifacts: true
> >> -  variables:
> >> -    IMAGE: alpine
> >> -    MAKE_CHECK_ARGS: check-avocado
> >
> > Instead of entirely deleting, I'd suggest adding
> >
> >    # Disabled due to frequent random failures
> >    # https://gitlab.com/qemu-project/qemu/-/issues/1884
> >    when: manual
> >
> > See example: https://docs.gitlab.com/ee/ci/yaml/#when
> >
> > This disables the job from running unless someone explicitly
> > tells it to run
> 
> What I don't understand is why we didn't gate the release back when they
> first tripped. We should have noticed between:
> 
>   https://gitlab.com/qemu-project/qemu/-/pipelines/956543770
> 
> and
> 
>   https://gitlab.com/qemu-project/qemu/-/pipelines/957154381
> 
> that the system tests where regressing. Yet we merged the changes
> anyway.

I think that green series is misleading, based on Richard's
mail on list wrt the TCG pull series:

  https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg04014.html

  "It's some sort of timing issue, which sometimes goes away
   when re-run. I was re-running tests *a lot* in order to
   get them to go green while running the 8.1 release. "


Essentially I'd put this down to the tests being soo non-deterministic
that we've given up trusting them.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


