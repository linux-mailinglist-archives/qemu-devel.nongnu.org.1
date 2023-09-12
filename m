Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3790879D61F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:21:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg67D-00022X-2F; Tue, 12 Sep 2023 12:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg67A-00022O-TT
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:19:48 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg676-0003Iv-3V
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:19:47 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5739972accdso3563253eaf.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694535582; x=1695140382; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GyrjvnkeqIlMqVWr6lp8JVTUsAKukRWPX2WvyenqiGE=;
 b=cgmSS13+9XgVI+NO7A77TcKUSCEKaXDdJqew2dMvXxDS2Vn87mu1irZNMmrwv81PyI
 ZEH2iMC8/GEf25PgkLizrne4D02JNJfIowAU8bMSCajeE4s4Syn5gdSXhLT4A8nGgq/9
 vvXklR3GV9ps0kMo5fZD8tpM0keYZkogcImWk7L3O2t78AEufsv46VoTpMPfmcjaJeOn
 PRljNnHpwRC4Mc+vZB4/7fGEox36x7TQ6OfX7th32o1S6kDo1BiUnomGU7DV0Hm0gpnE
 MOtCNdj0Y+jCrtWpMf2+kD1dzPkzT4cgS47FtrDqXUbLkc7r9S722Lwi17ldnkKwE4dA
 qrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694535582; x=1695140382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GyrjvnkeqIlMqVWr6lp8JVTUsAKukRWPX2WvyenqiGE=;
 b=GBqcbbS07/Ki1YcJ491dgcXsqryQyxUhz/5oiak1lWojy5LzJe9z07/e5c58dcVIQA
 jBntz1SpaRDiQtin6NPus8WEi8/TCdy/qdy2HD9BOu3oiSLETNVOj4Qv9Y3rg8cWuYJj
 dFf0lcFUcnNqI9BjVsUnTB5yIxBI179EQKNqH7V5s5zoXzOTDhYQj2hJyl/d2vZyc/cq
 GTvqM40+Nk5f2MMii2u9sGKrCGfUtOdzRJ5x1zm3L6lSVm+CBUbzsDck4THPo94U0QCW
 AJjj7TQNKF2q1DYykDawxYgn/b8Z34+lGx6XqHuAawtU2DDCYz61iDTNugrCOPS13wTq
 P2Pg==
X-Gm-Message-State: AOJu0Yzw+sV2R5IroEYINK1dJslCEysf8s1TUmU3bHhvcI34yRrokqMY
 Oucpt5X7YONwPpIUyz7wodRWlP2eMaAS+sIy5uU=
X-Google-Smtp-Source: AGHT+IHsFqh3SljOFg8n9gREybjQQsxcLPR1RqpYVtQ1nCU9gMMS4qfRwC44FQX7jBAjy/Wzip++KsQ4DnBrY7cOfms=
X-Received: by 2002:a05:6870:858b:b0:1b0:45cb:706e with SMTP id
 f11-20020a056870858b00b001b045cb706emr46038oal.28.1694535582329; Tue, 12 Sep
 2023 09:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230912150611.70676-1-stefanha@redhat.com>
 <ZQCBoCI6lvJqhsbd@redhat.com>
 <8734zjv0ph.fsf@linaro.org> <ZQCOTJMyMCgNCu3l@redhat.com>
In-Reply-To: <ZQCOTJMyMCgNCu3l@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 12:19:30 -0400
Message-ID: <CAJSP0QX09DUU1GQNLBW2ZkAsiR2HNC03+ZohmOZpwJDq04fz3Q@mail.gmail.com>
Subject: Re: [PATCH] gitlab: remove unreliable avocado CI jobs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000071b20806052bcf5e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000071b20806052bcf5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023, 12:14 Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:

> On Tue, Sep 12, 2023 at 05:01:26PM +0100, Alex Benn=C3=A9e wrote:
> >
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >
> > > On Tue, Sep 12, 2023 at 11:06:11AM -0400, Stefan Hajnoczi wrote:
> > >> The avocado-system-alpine, avocado-system-fedora, and
> > >> avocado-system-ubuntu jobs are unreliable. I identified them while
> > >> looking over CI failures from the past week:
> > >> https://gitlab.com/qemu-project/qemu/-/jobs/5058610614
> > >> https://gitlab.com/qemu-project/qemu/-/jobs/5058610654
> > >> https://gitlab.com/qemu-project/qemu/-/jobs/5030428571
> > >>
> > >> Thomas Huth suggest on IRC today that there may be a legitimate
> failure
> > >> in there:
> > >>
> > >>   th_huth: f4bug, yes, seems like it does not start at all correctly
> on
> > >>   alpine anymore ... and it's broken since ~ 2 weeks already, so if
> nobody
> > >>   noticed this by now, this is worrying
> > >>
> > >> It crept in because the jobs were already unreliable.
> > >>
> > >> I don't know how to interpret the job output, so all I can do is to
> > >> propose removing these jobs. A useful CI job has two outcomes: pass =
or
> > >> fail. Timeouts and other in-between states are not useful because th=
ey
> > >> require constant triaging by someone who understands the details of
> the
> > >> tests and they can occur when run against pull requests that have
> > >> nothing to do with the area covered by the test.
> > >>
> > >> Hopefully test owners will be able to identify the root causes and
> solve
> > >> them so that these jobs can stay. In their current state the jobs ar=
e
> > >> not useful since I cannot cannot tell whether job failures are real =
or
> > >> just intermittent when merging qemu.git pull requests.
> > >>
> > >> If you are a test owner, please take a look.
> > >>
> > >> It is likely that other avocado-system-* CI jobs have similar failur=
es
> > >> from time to time, but I'll leave them as long as they are passing.
> > >>
> > >> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1884
> > >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >> ---
> > >>  .gitlab-ci.d/buildtest.yml | 27 ---------------------------
> > >>  1 file changed, 27 deletions(-)
> > >>
> > >> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > >> index aee9101507..83ce448c4d 100644
> > >> --- a/.gitlab-ci.d/buildtest.yml
> > >> +++ b/.gitlab-ci.d/buildtest.yml
> > >> @@ -22,15 +22,6 @@ check-system-alpine:
> > >>      IMAGE: alpine
> > >>      MAKE_CHECK_ARGS: check-unit check-qtest
> > >>
> > >> -avocado-system-alpine:
> > >> -  extends: .avocado_test_job_template
> > >> -  needs:
> > >> -    - job: build-system-alpine
> > >> -      artifacts: true
> > >> -  variables:
> > >> -    IMAGE: alpine
> > >> -    MAKE_CHECK_ARGS: check-avocado
> > >
> > > Instead of entirely deleting, I'd suggest adding
> > >
> > >    # Disabled due to frequent random failures
> > >    # https://gitlab.com/qemu-project/qemu/-/issues/1884
> > >    when: manual
> > >
> > > See example: https://docs.gitlab.com/ee/ci/yaml/#when
> > >
> > > This disables the job from running unless someone explicitly
> > > tells it to run
> >
> > What I don't understand is why we didn't gate the release back when the=
y
> > first tripped. We should have noticed between:
> >
> >   https://gitlab.com/qemu-project/qemu/-/pipelines/956543770
> >
> > and
> >
> >   https://gitlab.com/qemu-project/qemu/-/pipelines/957154381
> >
> > that the system tests where regressing. Yet we merged the changes
> > anyway.
>
> I think that green series is misleading, based on Richard's
> mail on list wrt the TCG pull series:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg04014.html
>
>   "It's some sort of timing issue, which sometimes goes away
>    when re-run. I was re-running tests *a lot* in order to
>    get them to go green while running the 8.1 release. "
>
>
> Essentially I'd put this down to the tests being soo non-deterministic
> that we've given up trusting them.
>

Yes.

Stefan


> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>
>

--00000000000071b20806052bcf5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Sep 12, 2023, 12:14 Daniel P. Berrang=C3=A9 &l=
t;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">On Tue, Sep 12, 2023 at 05:01:26PM=
 +0100, Alex Benn=C3=A9e wrote:<br>
&gt; <br>
&gt; Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt; writes:<br>
&gt; <br>
&gt; &gt; On Tue, Sep 12, 2023 at 11:06:11AM -0400, Stefan Hajnoczi wrote:<=
br>
&gt; &gt;&gt; The avocado-system-alpine, avocado-system-fedora, and<br>
&gt; &gt;&gt; avocado-system-ubuntu jobs are unreliable. I identified them =
while<br>
&gt; &gt;&gt; looking over CI failures from the past week:<br>
&gt; &gt;&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/505861=
0614" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qe=
mu-project/qemu/-/jobs/5058610614</a><br>
&gt; &gt;&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/505861=
0654" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qe=
mu-project/qemu/-/jobs/5058610654</a><br>
&gt; &gt;&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/503042=
8571" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qe=
mu-project/qemu/-/jobs/5030428571</a><br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; Thomas Huth suggest on IRC today that there may be a legitima=
te failure<br>
&gt; &gt;&gt; in there:<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt;=C2=A0 =C2=A0th_huth: f4bug, yes, seems like it does not start=
 at all correctly on<br>
&gt; &gt;&gt;=C2=A0 =C2=A0alpine anymore ... and it&#39;s broken since ~ 2 =
weeks already, so if nobody<br>
&gt; &gt;&gt;=C2=A0 =C2=A0noticed this by now, this is worrying<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; It crept in because the jobs were already unreliable.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; I don&#39;t know how to interpret the job output, so all I ca=
n do is to<br>
&gt; &gt;&gt; propose removing these jobs. A useful CI job has two outcomes=
: pass or<br>
&gt; &gt;&gt; fail. Timeouts and other in-between states are not useful bec=
ause they<br>
&gt; &gt;&gt; require constant triaging by someone who understands the deta=
ils of the<br>
&gt; &gt;&gt; tests and they can occur when run against pull requests that =
have<br>
&gt; &gt;&gt; nothing to do with the area covered by the test.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; Hopefully test owners will be able to identify the root cause=
s and solve<br>
&gt; &gt;&gt; them so that these jobs can stay. In their current state the =
jobs are<br>
&gt; &gt;&gt; not useful since I cannot cannot tell whether job failures ar=
e real or<br>
&gt; &gt;&gt; just intermittent when merging qemu.git pull requests.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; If you are a test owner, please take a look.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; It is likely that other avocado-system-* CI jobs have similar=
 failures<br>
&gt; &gt;&gt; from time to time, but I&#39;ll leave them as long as they ar=
e passing.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; Buglink: <a href=3D"https://gitlab.com/qemu-project/qemu/-/is=
sues/1884" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.c=
om/qemu-project/qemu/-/issues/1884</a><br>
&gt; &gt;&gt; Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha=
@redhat.com" target=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&g=
t;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 .gitlab-ci.d/buildtest.yml | 27 -----------------------=
----<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 27 deletions(-)<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildt=
est.yml<br>
&gt; &gt;&gt; index aee9101507..83ce448c4d 100644<br>
&gt; &gt;&gt; --- a/.gitlab-ci.d/buildtest.yml<br>
&gt; &gt;&gt; +++ b/.gitlab-ci.d/buildtest.yml<br>
&gt; &gt;&gt; @@ -22,15 +22,6 @@ check-system-alpine:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 IMAGE: alpine<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 MAKE_CHECK_ARGS: check-unit check-qtest<b=
r>
&gt; &gt;&gt;=C2=A0 <br>
&gt; &gt;&gt; -avocado-system-alpine:<br>
&gt; &gt;&gt; -=C2=A0 extends: .avocado_test_job_template<br>
&gt; &gt;&gt; -=C2=A0 needs:<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 - job: build-system-alpine<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 artifacts: true<br>
&gt; &gt;&gt; -=C2=A0 variables:<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 IMAGE: alpine<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 MAKE_CHECK_ARGS: check-avocado<br>
&gt; &gt;<br>
&gt; &gt; Instead of entirely deleting, I&#39;d suggest adding<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 # Disabled due to frequent random failures<br>
&gt; &gt;=C2=A0 =C2=A0 # <a href=3D"https://gitlab.com/qemu-project/qemu/-/=
issues/1884" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab=
.com/qemu-project/qemu/-/issues/1884</a><br>
&gt; &gt;=C2=A0 =C2=A0 when: manual<br>
&gt; &gt;<br>
&gt; &gt; See example: <a href=3D"https://docs.gitlab.com/ee/ci/yaml/#when"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://docs.gitlab.com/ee=
/ci/yaml/#when</a><br>
&gt; &gt;<br>
&gt; &gt; This disables the job from running unless someone explicitly<br>
&gt; &gt; tells it to run<br>
&gt; <br>
&gt; What I don&#39;t understand is why we didn&#39;t gate the release back=
 when they<br>
&gt; first tripped. We should have noticed between:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0<a href=3D"https://gitlab.com/qemu-project/qemu/-/pipeline=
s/956543770" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab=
.com/qemu-project/qemu/-/pipelines/956543770</a><br>
&gt; <br>
&gt; and<br>
&gt; <br>
&gt;=C2=A0 =C2=A0<a href=3D"https://gitlab.com/qemu-project/qemu/-/pipeline=
s/957154381" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab=
.com/qemu-project/qemu/-/pipelines/957154381</a><br>
&gt; <br>
&gt; that the system tests where regressing. Yet we merged the changes<br>
&gt; anyway.<br>
<br>
I think that green series is misleading, based on Richard&#39;s<br>
mail on list wrt the TCG pull series:<br>
<br>
=C2=A0 <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg=
04014.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.g=
nu.org/archive/html/qemu-devel/2023-08/msg04014.html</a><br>
<br>
=C2=A0 &quot;It&#39;s some sort of timing issue, which sometimes goes away<=
br>
=C2=A0 =C2=A0when re-run. I was re-running tests *a lot* in order to<br>
=C2=A0 =C2=A0get them to go green while running the 8.1 release. &quot;<br>
<br>
<br>
Essentially I&#39;d put this down to the tests being soo non-deterministic<=
br>
that we&#39;ve given up trusting them.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Yes.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Stefan</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000071b20806052bcf5e--

