Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2071A79D8C9
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:37:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8G5-0001z6-2z; Tue, 12 Sep 2023 14:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qg8G2-0001ye-Gi
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:37:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qg8Fz-0000fy-N7
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:37:06 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so5594806f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 11:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694543815; x=1695148615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48LTsRCisHnBhWvEgWJoGT8ScULA8r7Liu/73Z80Puc=;
 b=MfWpV8RwuLXuNcGuZyY/0VUORTyVTNLaqqNNOmTBZSGhTvZ6nHG4KXq7O2G5EJPXBx
 pFPM3Lx2NB+gcveOB9TPPiSivOqiRLmBi7z9bfdlLl4ckwhvraUyg4sg5Pge0miZevAa
 Q+QSs/bC44ZcHhng5fiYqnichVE4tuDSTPUlxtLF5rGu54RnQfaw58U6UIWTqOs7QoDk
 bIv5GTwGCbCd0pCPmAa9MSuGbYE2Kpo+k0Y0QdDXoeK7QqhSztCmrfllTgWAsMmRjWbD
 IZU3I7ca9+TmAS1+YnLn7OAS5kpdST1e+D6r7/53/qicP0ihP6/1UFHG6IdCP6ma9y0A
 3JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694543815; x=1695148615;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=48LTsRCisHnBhWvEgWJoGT8ScULA8r7Liu/73Z80Puc=;
 b=bWZ6f9UDBHZ8FL8pDqJ1y13+KkPt/5TPBggzB0HnIOQgEVTl1sYCaEFmkkWPiVpA6I
 nBXC56l0IyGfCxFbhyYfYk3z0fV+v4SXS8Rx380oxDW4GyP/QjpsIBdTWKIGBGAEBsgK
 2u3Yn5k4kDM5c0Ib+HrbjjHakBwqYyF6/p7lX0JLKJYBQ5lV5KpjQ6o6dZhp8Q2EXelp
 ivPWovBkjRKflZJWDzDJea+farvsF3yyL3MLAzpQP8nsMoUudL4eQe9IXToKbLSFH+AX
 L/yDVLJhyHwazXmCPxB/DFw3J+4haKGJLgSVOD9FLN/jFvpf3k74Y+po7FV05JMExgIE
 smPg==
X-Gm-Message-State: AOJu0YxEZo37XNbdePv3PH4YlikC5L2DULC/DnXCdu0gYIOEPgDYMosV
 InuSupCboYY/lQPcXGISKqpE5A==
X-Google-Smtp-Source: AGHT+IHAdUs6k41sET5dMq/9NBUD9YTbfD27EZvvhTGVeHeEeRINTQASkLlzmbPRUf7X7cjbOBf+Zg==
X-Received: by 2002:a5d:6b41:0:b0:319:6caa:ada2 with SMTP id
 x1-20020a5d6b41000000b003196caaada2mr231084wrw.47.1694543815375; 
 Tue, 12 Sep 2023 11:36:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a5d6751000000b003140f47224csm13437017wrw.15.2023.09.12.11.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 11:36:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 46A021FFBB;
 Tue, 12 Sep 2023 19:36:54 +0100 (BST)
References: <20230912150611.70676-1-stefanha@redhat.com>
 <ZQCBoCI6lvJqhsbd@redhat.com> <8734zjv0ph.fsf@linaro.org>
 <ZQCOTJMyMCgNCu3l@redhat.com>
 <CAJSP0QX09DUU1GQNLBW2ZkAsiR2HNC03+ZohmOZpwJDq04fz3Q@mail.gmail.com>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Stefan
 Hajnoczi
 <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PATCH] gitlab: remove unreliable avocado CI jobs
Date: Tue, 12 Sep 2023 18:39:29 +0100
In-reply-to: <CAJSP0QX09DUU1GQNLBW2ZkAsiR2HNC03+ZohmOZpwJDq04fz3Q@mail.gmail.com>
Message-ID: <87y1hbtf09.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Sep 12, 2023, 12:14 Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
>  On Tue, Sep 12, 2023 at 05:01:26PM +0100, Alex Benn=C3=A9e wrote:
>  >=20
>  > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>  >=20
>  > > On Tue, Sep 12, 2023 at 11:06:11AM -0400, Stefan Hajnoczi wrote:
>  > >> The avocado-system-alpine, avocado-system-fedora, and
>  > >> avocado-system-ubuntu jobs are unreliable. I identified them while
>  > >> looking over CI failures from the past week:
>  > >> https://gitlab.com/qemu-project/qemu/-/jobs/5058610614
>  > >> https://gitlab.com/qemu-project/qemu/-/jobs/5058610654
>  > >> https://gitlab.com/qemu-project/qemu/-/jobs/5030428571
>  > >>=20
>  > >> Thomas Huth suggest on IRC today that there may be a legitimate fai=
lure
>  > >> in there:
>  > >>=20
>  > >>   th_huth: f4bug, yes, seems like it does not start at all correctl=
y on
>  > >>   alpine anymore ... and it's broken since ~ 2 weeks already, so if=
 nobody
>  > >>   noticed this by now, this is worrying
>  > >>=20
>  > >> It crept in because the jobs were already unreliable.
>  > >>=20
>  > >> I don't know how to interpret the job output, so all I can do is to
>  > >> propose removing these jobs. A useful CI job has two outcomes: pass=
 or
>  > >> fail. Timeouts and other in-between states are not useful because t=
hey
>  > >> require constant triaging by someone who understands the details of=
 the
>  > >> tests and they can occur when run against pull requests that have
>  > >> nothing to do with the area covered by the test.
>  > >>=20
>  > >> Hopefully test owners will be able to identify the root causes and =
solve
>  > >> them so that these jobs can stay. In their current state the jobs a=
re
>  > >> not useful since I cannot cannot tell whether job failures are real=
 or
>  > >> just intermittent when merging qemu.git pull requests.
>  > >>=20
>  > >> If you are a test owner, please take a look.
>  > >>=20
>  > >> It is likely that other avocado-system-* CI jobs have similar failu=
res
>  > >> from time to time, but I'll leave them as long as they are passing.
>  > >>=20
>  > >> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1884
>  > >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>  > >> ---
>  > >>  .gitlab-ci.d/buildtest.yml | 27 ---------------------------
>  > >>  1 file changed, 27 deletions(-)
>  > >>=20
>  > >> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>  > >> index aee9101507..83ce448c4d 100644
>  > >> --- a/.gitlab-ci.d/buildtest.yml
>  > >> +++ b/.gitlab-ci.d/buildtest.yml
>  > >> @@ -22,15 +22,6 @@ check-system-alpine:
>  > >>      IMAGE: alpine
>  > >>      MAKE_CHECK_ARGS: check-unit check-qtest
>  > >>=20=20
>  > >> -avocado-system-alpine:
>  > >> -  extends: .avocado_test_job_template
>  > >> -  needs:
>  > >> -    - job: build-system-alpine
>  > >> -      artifacts: true
>  > >> -  variables:
>  > >> -    IMAGE: alpine
>  > >> -    MAKE_CHECK_ARGS: check-avocado
>  > >
>  > > Instead of entirely deleting, I'd suggest adding
>  > >
>  > >    # Disabled due to frequent random failures
>  > >    # https://gitlab.com/qemu-project/qemu/-/issues/1884
>  > >    when: manual
>  > >
>  > > See example: https://docs.gitlab.com/ee/ci/yaml/#when
>  > >
>  > > This disables the job from running unless someone explicitly
>  > > tells it to run
>  >=20
>  > What I don't understand is why we didn't gate the release back when th=
ey
>  > first tripped. We should have noticed between:
>  >=20
>  >   https://gitlab.com/qemu-project/qemu/-/pipelines/956543770
>  >=20
>  > and
>  >=20
>  >   https://gitlab.com/qemu-project/qemu/-/pipelines/957154381
>  >=20
>  > that the system tests where regressing. Yet we merged the changes
>  > anyway.
>
>  I think that green series is misleading, based on Richard's
>  mail on list wrt the TCG pull series:
>
>    https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg04014.html
>
>    "It's some sort of timing issue, which sometimes goes away
>     when re-run. I was re-running tests *a lot* in order to
>     get them to go green while running the 8.1 release. "

But I think in that actual case a change exposed a race condition which
has only recently been fixed - however we've had additional regresssions
since.

Rather than kill the system tests we can disable the flaky individual
tests in avocado.=20

>
>  Essentially I'd put this down to the tests being soo non-deterministic
>  that we've given up trusting them.
>
> Yes.
>
> Stefan
>
>  With regards,
>  Daniel
>  --=20
>  |: https://berrange.com      -o-    https://www.flickr.com/photos/dberra=
nge :|
>  |: https://libvirt.org         -o-            https://fstop138.berrange.=
com :|
>  |: https://entangle-photo.org    -o-    https://www.instagram.com/dberra=
nge :|


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

