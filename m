Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F4179D92F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:54:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8VO-0002yA-Ba; Tue, 12 Sep 2023 14:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg8VL-0002xt-VI
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:52:55 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg8VJ-00064v-9l
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:52:55 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1c4cd0f6cb2so86788fac.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694544772; x=1695149572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miDYP6HgxDn8yu7Whcb7lZzYSppWF66NKk5ZhUw4L0c=;
 b=KoIH1hn04JB6JvF2SLc5VoW+hdXBDQBUk0NPitw+jzdLDvhbJSMaF1H3Qnm2FvcHuz
 SYnrUgq45L9IGrUXXyeHl+oPzbmEDiqyGQxP7ZZAPGAt8nTKXkTaRg9wU0WlR/cbnhN3
 1Nti7Imby7h4ezHBQFvP55fNjmj5JPFywl/90NAk9efIPaE5AB0y/YcObq3GoNVbaPmG
 8OoMRdNoAcTFlLBhS5CQup1+w/qZUa5Z032xYYyUThvtNGctsV4l6f1aFVsH4YHvjjax
 BrZdp1IV5MuHgYhp0mUXdypSxU0/4YlC70JBWMJS80DPsGgZYlrtMM2qBynO1Jn62oVp
 8K3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694544772; x=1695149572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=miDYP6HgxDn8yu7Whcb7lZzYSppWF66NKk5ZhUw4L0c=;
 b=HjTzHUQv3gj9L5cbLbRZHOMw5UoaMKbbaKzR4A3b5vYyblm8dqW70FKPMsNNQldx9J
 DjcByR8nWLZX4ggYLc4uriNDUaqCBILGRkNoRu9QHxjIeNg8EcAxNCbydJ++m3CMEfX6
 jsrL3frAl4LHnMN/hnWq6xaXEw55fQL/Sp8RrdWCJpfVAjExmSdYRArZrkKj0RT585pz
 TOIgK6OPKlqjwB/X+GoUmrIpcLC7ZHp9L8IFm6mfZp298koASNA6T2IPNt6rjs1qpxrT
 zBxX0iK8JNs4fMKGqTcCjALEcprPkGh5+7Tp4/UR989/gAhjXaeYfn+YJQcmwDsuWmCw
 plmA==
X-Gm-Message-State: AOJu0YznjYVQgozeF7ifM9Sy7L4vol0Lnoy8VVkR2Eaut/CgVU0r1jMT
 UXfn/l+k9WN05nHr7JXJtU1dC85mPPeYPyqEAsI=
X-Google-Smtp-Source: AGHT+IGhhJQwh29ScMLWoAKq+GUEgI1XiW4cWO+iA6xnWT9VdMYalvdB4ThXZv8SdLJpbQ/M8oFra0o/qKQrYaoX8jo=
X-Received: by 2002:a05:6870:860a:b0:1d5:cdf7:bdbc with SMTP id
 h10-20020a056870860a00b001d5cdf7bdbcmr377185oal.2.1694544772126; Tue, 12 Sep
 2023 11:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230912150611.70676-1-stefanha@redhat.com>
 <ZQCBoCI6lvJqhsbd@redhat.com>
 <8734zjv0ph.fsf@linaro.org> <ZQCOTJMyMCgNCu3l@redhat.com>
 <CAJSP0QX09DUU1GQNLBW2ZkAsiR2HNC03+ZohmOZpwJDq04fz3Q@mail.gmail.com>
 <87y1hbtf09.fsf@linaro.org>
In-Reply-To: <87y1hbtf09.fsf@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 14:52:40 -0400
Message-ID: <CAJSP0QUDtVStEx-u8k5akeG-_XdOpyWi221Xo4RGaQDwTe6Qhg@mail.gmail.com>
Subject: Re: [PATCH] gitlab: remove unreliable avocado CI jobs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 12 Sept 2023 at 14:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
> > On Tue, Sep 12, 2023, 12:14 Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >
> >  On Tue, Sep 12, 2023 at 05:01:26PM +0100, Alex Benn=C3=A9e wrote:
> >  >
> >  > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >  >
> >  > > On Tue, Sep 12, 2023 at 11:06:11AM -0400, Stefan Hajnoczi wrote:
> >  > >> The avocado-system-alpine, avocado-system-fedora, and
> >  > >> avocado-system-ubuntu jobs are unreliable. I identified them whil=
e
> >  > >> looking over CI failures from the past week:
> >  > >> https://gitlab.com/qemu-project/qemu/-/jobs/5058610614
> >  > >> https://gitlab.com/qemu-project/qemu/-/jobs/5058610654
> >  > >> https://gitlab.com/qemu-project/qemu/-/jobs/5030428571
> >  > >>
> >  > >> Thomas Huth suggest on IRC today that there may be a legitimate f=
ailure
> >  > >> in there:
> >  > >>
> >  > >>   th_huth: f4bug, yes, seems like it does not start at all correc=
tly on
> >  > >>   alpine anymore ... and it's broken since ~ 2 weeks already, so =
if nobody
> >  > >>   noticed this by now, this is worrying
> >  > >>
> >  > >> It crept in because the jobs were already unreliable.
> >  > >>
> >  > >> I don't know how to interpret the job output, so all I can do is =
to
> >  > >> propose removing these jobs. A useful CI job has two outcomes: pa=
ss or
> >  > >> fail. Timeouts and other in-between states are not useful because=
 they
> >  > >> require constant triaging by someone who understands the details =
of the
> >  > >> tests and they can occur when run against pull requests that have
> >  > >> nothing to do with the area covered by the test.
> >  > >>
> >  > >> Hopefully test owners will be able to identify the root causes an=
d solve
> >  > >> them so that these jobs can stay. In their current state the jobs=
 are
> >  > >> not useful since I cannot cannot tell whether job failures are re=
al or
> >  > >> just intermittent when merging qemu.git pull requests.
> >  > >>
> >  > >> If you are a test owner, please take a look.
> >  > >>
> >  > >> It is likely that other avocado-system-* CI jobs have similar fai=
lures
> >  > >> from time to time, but I'll leave them as long as they are passin=
g.
> >  > >>
> >  > >> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1884
> >  > >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >  > >> ---
> >  > >>  .gitlab-ci.d/buildtest.yml | 27 ---------------------------
> >  > >>  1 file changed, 27 deletions(-)
> >  > >>
> >  > >> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.=
yml
> >  > >> index aee9101507..83ce448c4d 100644
> >  > >> --- a/.gitlab-ci.d/buildtest.yml
> >  > >> +++ b/.gitlab-ci.d/buildtest.yml
> >  > >> @@ -22,15 +22,6 @@ check-system-alpine:
> >  > >>      IMAGE: alpine
> >  > >>      MAKE_CHECK_ARGS: check-unit check-qtest
> >  > >>
> >  > >> -avocado-system-alpine:
> >  > >> -  extends: .avocado_test_job_template
> >  > >> -  needs:
> >  > >> -    - job: build-system-alpine
> >  > >> -      artifacts: true
> >  > >> -  variables:
> >  > >> -    IMAGE: alpine
> >  > >> -    MAKE_CHECK_ARGS: check-avocado
> >  > >
> >  > > Instead of entirely deleting, I'd suggest adding
> >  > >
> >  > >    # Disabled due to frequent random failures
> >  > >    # https://gitlab.com/qemu-project/qemu/-/issues/1884
> >  > >    when: manual
> >  > >
> >  > > See example: https://docs.gitlab.com/ee/ci/yaml/#when
> >  > >
> >  > > This disables the job from running unless someone explicitly
> >  > > tells it to run
> >  >
> >  > What I don't understand is why we didn't gate the release back when =
they
> >  > first tripped. We should have noticed between:
> >  >
> >  >   https://gitlab.com/qemu-project/qemu/-/pipelines/956543770
> >  >
> >  > and
> >  >
> >  >   https://gitlab.com/qemu-project/qemu/-/pipelines/957154381
> >  >
> >  > that the system tests where regressing. Yet we merged the changes
> >  > anyway.
> >
> >  I think that green series is misleading, based on Richard's
> >  mail on list wrt the TCG pull series:
> >
> >    https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg04014.html
> >
> >    "It's some sort of timing issue, which sometimes goes away
> >     when re-run. I was re-running tests *a lot* in order to
> >     get them to go green while running the 8.1 release. "
>
> But I think in that actual case a change exposed a race condition which
> has only recently been fixed - however we've had additional regresssions
> since.
>
> Rather than kill the system tests we can disable the flaky individual
> tests in avocado.

That would be nice, please send an alternative patch.

I can't do that myself because there are a bunch of test cases with
suspicious output and I don't know which ones are legitimate failures,
intermittent problems, or expected failures.

Stefan

>
> >
> >  Essentially I'd put this down to the tests being soo non-deterministic
> >  that we've given up trusting them.
> >
> > Yes.
> >
> > Stefan
> >
> >  With regards,
> >  Daniel
> >  --
> >  |: https://berrange.com      -o-    https://www.flickr.com/photos/dber=
range :|
> >  |: https://libvirt.org         -o-            https://fstop138.berrang=
e.com :|
> >  |: https://entangle-photo.org    -o-    https://www.instagram.com/dber=
range :|
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

