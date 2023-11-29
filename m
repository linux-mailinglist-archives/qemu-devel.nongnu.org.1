Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F2E7FDBF3
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 16:50:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8MpP-0006og-BP; Wed, 29 Nov 2023 10:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1r8MpN-0006oW-NQ
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:50:17 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1r8MpK-0001ql-Dw
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:50:17 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a00ac0101d9so944188166b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 07:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1701273013; x=1701877813;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mo6IPX1rIM1Q6S5J0FWEynoJ6POS8mNv5VnYtM3Gd2I=;
 b=v2JchSFxb44rjz7CLGrnhfRB7umlZwjEAguEX1haw5wsijiP1wVUTK4+XBnLdTxyFE
 rtAWgOEjaIOPfx9Pxbd1KWK4sT2mHp+L0vMSvJneMtZvtjO5pbDtHkUUsLZ21/wmCThY
 viD7/BTFuwsm5FRsd5wEhCa4sK9HgkstpgKq8k9k+dRUmcQbkJXadH3SapoNdt/bueAy
 +QLyWj8AcIIT8ZpXJXxkU20kV2pbUJ4Q0wasUweUONzlJXBt7WAMEBlEA4FRtxY+x+ZF
 3gshqFYLpR7P15za4cXMuNAzzuTYdK/pmZkb9mfrSRdkvXQ0P1KmIsyToOirC4cykKOu
 VY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701273013; x=1701877813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mo6IPX1rIM1Q6S5J0FWEynoJ6POS8mNv5VnYtM3Gd2I=;
 b=pHw9xxSEWRSJUmAbmN0ATlIkYBQYNtcv8KkNLXFZFtLNCRfdjLFVYZPYSlgSuQapS+
 cIPJYCvTbru3B3O0Dy0s9OnT0cxvG1h3kPMqPRNmqRbdXF0B4uak+ZbTbZmZjBNahwYh
 f0otIfJz5kS4bZN602/V9FyE60X2FNNT7blnvijxjwvWxqEFfMddetGR2btjPuwNKUDV
 nNgynjzo3YqWvL3R/Zig9VNAThxx3MUm3MVQkmFtl0SchuF8fV7vk3bJ9ip4q1p5SD6X
 D9nYfw1lVNepFI5tT9AqsryhKzZYeNtvun6A3X5VNW3qvRVk9hPTE4iivYoU/G8UdU++
 /rnQ==
X-Gm-Message-State: AOJu0Yx9tvJowLaK1RkKxAXmt3UVqnK44gO2YMndY451/RrbKOZcISR1
 n6BmkMaEwMFLWGZDiBwZioKiW7ub83mtUxsdqeg93g==
X-Google-Smtp-Source: AGHT+IEwW8cQ0fyx9uH0bVZCd10+nl8ixFtNdcrPUWSl5dGS23py2E+jCZdqAAkhedIuq8kNSTYcYSyxXCtne4fLCcQ=
X-Received: by 2002:a17:906:20de:b0:a01:811c:ce9 with SMTP id
 c30-20020a17090620de00b00a01811c0ce9mr15822127ejc.0.1701273012719; Wed, 29
 Nov 2023 07:50:12 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
 <ZWYsMsgxjDZ_T2zA@redhat.com>
In-Reply-To: <ZWYsMsgxjDZ_T2zA@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Nov 2023 08:50:06 -0700
Message-ID: <CANCZdfq6dPArtLjwAbV9MxQnR6pOn6MR+gB7eTogUyw8WuyjCw@mail.gmail.com>
Subject: Re: QEMU Summit Minutes 2023
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000096e469060b4c7d07"
Received-SPF: none client-ip=2a00:1450:4864:20::636;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--00000000000096e469060b4c7d07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:44=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Tue, Nov 28, 2023 at 06:54:42PM +0100, C=C3=A9dric Le Goater wrote:
> > On 11/21/23 18:11, Alex Benn=C3=A9e wrote:
> > > Peter Maydell <peter.maydell@linaro.org> writes:
> > >
> > > > QEMU Summit Minutes 2023
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > >
> > > > As usual, we held a QEMU Summit meeting at KVM Forum.  This is an
> > > > invite-only meeting for the most active maintainers and
> submaintainers
> > > > in the project, and we discuss various project-wide issues, usually
> > > > process stuff. We then post the minutes of the meeting to the list =
as
> > > > a jumping off point for wider discussion and for those who weren't
> > > > able to attend.
> > > >
> > > <snip>
> > > >
> > > > Topic 2: Are we happy with the email workflow?
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > This was a topic to see if there was any consensus among maintainer=
s
> > > > about the long-term acceptability of sticking with email for patch
> > > > submission and review -- in five years' time, if we're still doing =
it
> > > > the same way, how would we feel about it?
> > > >
> > > > One area where we did get consensus was that now that we're doing C=
I
> > > > on gitlab we can change pull requests from maintainers from via-ema=
il
> > > > to gitlab merge requests. This would hopefully mean that instead of
> > > > the release-manager having to tell gitlab to do a merge and then
> > > > reporting back the results of any CI failures, the maintainer
> > > > could directly see the CI results and deal with fixing up failures
> > > > and resubmitting without involving the release manager. (This
> > > > may have the disbenefit that there isn't a single person any
> > > > more who looks at all the CI results and gets a sense of whether
> > > > particular test cases have pre-existing intermittent failures.)
> > >
> > > If we are keen to start processing merge requests for the 9.0 release
> we
> > > really should consider how it is going to work before we open up the
> > > taps post 8.2-final going out.
> > >
> > > Does anyone want to have a go at writing an updated process for
> > > docs/devel/submitting-a-pull-request.rst (or I guess merge-request) s=
o
> > > we can discuss it and be ready early in the cycle? Ideally someone wh=
o
> > > already has experience with the workflow with other gitlab hosted
> > > projects.
>
> If no one else beats me to it, I can try and write up something,
> since I'm pretty familiar with gitlab PR from libvirt & other
> projects.
>
> > Reading the Topic 2 paragraph above, I understand that a maintainer
> > of a subsystem would be able to merge its '-next' branch in the main
> > repository when CI is all green. Correct ?
>
> A maintainer would have their own fork of qemu-project/qemu, under
> their namespace, or if there are maintainers collaborating, they
> might have a separate group nmamespace for their subsystem.
> eg qemu-block-subsys/qemu, or we could use sub-groups perhaps
> so  qemu-project/block-subsys/qemu  for official subsystem
> trees.
>
> Anyway, when a maintainer wants to merge a tree, I would expect to
> have a MR opened against 'master' in qemu-project/qemu.  The CI
> ought to then run and if it is all green, then someone would approve
> it to merge to master.
>
> > It seems to me that we should also have a group of people approving
> > the MR.
>
> Yes, while we could have one designated gate keeper approving all
> MRs, that would defeat some of the benefit of MRs. So likely would
> be good to have a pool, and also setup the config so that the owner
> of an MR is not allow to approve their own MR, to guarantee there
> is always a 2nd pair of eyes as sanity check.
>
> We might also need to consider enabling 'merge trains', so that
> we get a serialized CI run again after hte MR is approved, in
> case 'master' moved onwards since the initial CI pipeline when
> the MR was opened.
>

I'd honestly optimize for 'frequent merges of smaller things' rather than
'infrequent merges of larger things'. The latter has caused most of the
issues for me. It's harder to contribute because the overhead of doing so
is so large you want to batch everything. Let's not optimize for that
workaround for the high-friction submission process we have now. If there's
always smaller bits of work going in all the time, you'll find few commit
races... though the CI pipeline is rather large, so having a ci-staging
branch to land the MRs to that have completed CI, but not CI on the tip,
might not be bad... but the resolution of conflicts can be tricky, though
infrequent, so if a ci-staging branch bounces, all MRs would need to be
manually requeued after humans look at why and think through who needs to
talk to whom, or if it's just a 'other things landed before you could get
yours in and it's not the ci-staging being full of other people's commits
that is at fault.

Warner


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

--00000000000096e469060b4c7d07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 29, 2023 at 8:44=E2=80=AF=
AM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berra=
nge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Tue, Nov 28, 2023 at 06:54:42PM +0100, C=C3=A9dric Le Goat=
er wrote:<br>
&gt; On 11/21/23 18:11, Alex Benn=C3=A9e wrote:<br>
&gt; &gt; Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" tar=
get=3D"_blank">peter.maydell@linaro.org</a>&gt; writes:<br>
&gt; &gt; <br>
&gt; &gt; &gt; QEMU Summit Minutes 2023<br>
&gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; As usual, we held a QEMU Summit meeting at KVM Forum.=C2=A0 =
This is an<br>
&gt; &gt; &gt; invite-only meeting for the most active maintainers and subm=
aintainers<br>
&gt; &gt; &gt; in the project, and we discuss various project-wide issues, =
usually<br>
&gt; &gt; &gt; process stuff. We then post the minutes of the meeting to th=
e list as<br>
&gt; &gt; &gt; a jumping off point for wider discussion and for those who w=
eren&#39;t<br>
&gt; &gt; &gt; able to attend.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &lt;snip&gt;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Topic 2: Are we happy with the email workflow?<br>
&gt; &gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; This was a topic to see if there was any consensus among mai=
ntainers<br>
&gt; &gt; &gt; about the long-term acceptability of sticking with email for=
 patch<br>
&gt; &gt; &gt; submission and review -- in five years&#39; time, if we&#39;=
re still doing it<br>
&gt; &gt; &gt; the same way, how would we feel about it?<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; One area where we did get consensus was that now that we&#39=
;re doing CI<br>
&gt; &gt; &gt; on gitlab we can change pull requests from maintainers from =
via-email<br>
&gt; &gt; &gt; to gitlab merge requests. This would hopefully mean that ins=
tead of<br>
&gt; &gt; &gt; the release-manager having to tell gitlab to do a merge and =
then<br>
&gt; &gt; &gt; reporting back the results of any CI failures, the maintaine=
r<br>
&gt; &gt; &gt; could directly see the CI results and deal with fixing up fa=
ilures<br>
&gt; &gt; &gt; and resubmitting without involving the release manager. (Thi=
s<br>
&gt; &gt; &gt; may have the disbenefit that there isn&#39;t a single person=
 any<br>
&gt; &gt; &gt; more who looks at all the CI results and gets a sense of whe=
ther<br>
&gt; &gt; &gt; particular test cases have pre-existing intermittent failure=
s.)<br>
&gt; &gt; <br>
&gt; &gt; If we are keen to start processing merge requests for the 9.0 rel=
ease we<br>
&gt; &gt; really should consider how it is going to work before we open up =
the<br>
&gt; &gt; taps post 8.2-final going out.<br>
&gt; &gt; <br>
&gt; &gt; Does anyone want to have a go at writing an updated process for<b=
r>
&gt; &gt; docs/devel/submitting-a-pull-request.rst (or I guess merge-reques=
t) so<br>
&gt; &gt; we can discuss it and be ready early in the cycle? Ideally someon=
e who<br>
&gt; &gt; already has experience with the workflow with other gitlab hosted=
<br>
&gt; &gt; projects.<br>
<br>
If no one else beats me to it, I can try and write up something,<br>
since I&#39;m pretty familiar with gitlab PR from libvirt &amp; other<br>
projects.<br>
<br>
&gt; Reading the Topic 2 paragraph above, I understand that a maintainer<br=
>
&gt; of a subsystem would be able to merge its &#39;-next&#39; branch in th=
e main<br>
&gt; repository when CI is all green. Correct ?<br>
<br>
A maintainer would have their own fork of qemu-project/qemu, under<br>
their namespace, or if there are maintainers collaborating, they<br>
might have a separate group nmamespace for their subsystem.<br>
eg qemu-block-subsys/qemu, or we could use sub-groups perhaps<br>
so=C2=A0 qemu-project/block-subsys/qemu=C2=A0 for official subsystem<br>
trees.<br>
<br>
Anyway, when a maintainer wants to merge a tree, I would expect to<br>
have a MR opened against &#39;master&#39; in qemu-project/qemu.=C2=A0 The C=
I<br>
ought to then run and if it is all green, then someone would approve<br>
it to merge to master.<br>
<br>
&gt; It seems to me that we should also have a group of people approving<br=
>
&gt; the MR.<br>
<br>
Yes, while we could have one designated gate keeper approving all<br>
MRs, that would defeat some of the benefit of MRs. So likely would<br>
be good to have a pool, and also setup the config so that the owner<br>
of an MR is not allow to approve their own MR, to guarantee there<br>
is always a 2nd pair of eyes as sanity check.<br>
<br>
We might also need to consider enabling &#39;merge trains&#39;, so that<br>
we get a serialized CI run again after hte MR is approved, in<br>
case &#39;master&#39; moved onwards since the initial CI pipeline when<br>
the MR was opened.<br></blockquote><div><br></div><div>I&#39;d honestly opt=
imize for &#39;frequent merges of smaller things&#39; rather than &#39;infr=
equent merges of larger things&#39;. The latter has caused most of the issu=
es for me. It&#39;s harder to contribute because the overhead of doing so i=
s so large you want to batch everything. Let&#39;s not optimize for that wo=
rkaround for the high-friction submission process we have now. If there&#39=
;s always smaller bits of work going in all the time, you&#39;ll find few c=
ommit races... though the CI pipeline is rather large, so having a ci-stagi=
ng branch to land the MRs to that have completed CI, but not CI on the tip,=
 might not be bad... but the resolution of conflicts can be tricky, though =
infrequent, so if a ci-staging branch bounces, all MRs would need to be man=
ually requeued after humans look at why and think through who needs to talk=
 to whom, or if it&#39;s just a &#39;other things landed before you could g=
et yours in and it&#39;s not the ci-staging being full of other people&#39;=
s commits that is at fault.</div><div><br></div><div>Warner<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
<br>
</blockquote></div></div>

--00000000000096e469060b4c7d07--

