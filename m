Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 220C87AFEDC
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 10:45:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlQ9E-0005PA-Rf; Wed, 27 Sep 2023 04:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qlQ9A-0005On-Ou
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qlQ98-0003Y7-NJ
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695804228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YdQjkHxV47evYgQAbNnCrofpfAhEm8fu5/U7TxZXwNg=;
 b=ejT/pXLNVW0FESy8iTK961C1LFx5b+q/vQ3pxEsZpl/bg9m6+yX1ZsEp7GRWLcpIbU5u/Y
 3yotNETYdQMqsJ7CoB+G82ciiqPBFArqpDDaeG8uF4MGSkM9z93uHJel4zM8NmwKNiUJp8
 Se/Dqiq2Owl410lFKbisCZdn7yxNKiU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-nPsbRJ6pN_2LMgvlpKu1pQ-1; Wed, 27 Sep 2023 04:43:46 -0400
X-MC-Unique: nPsbRJ6pN_2LMgvlpKu1pQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50318e9067eso16303875e87.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 01:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695804220; x=1696409020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YdQjkHxV47evYgQAbNnCrofpfAhEm8fu5/U7TxZXwNg=;
 b=A5DudjEUxvGy1S/UO/IBiiCpaqCjOcjys2tFUHNtdD8XcefnqjYpaRE3vk46tV48GC
 LsbT0GGSjJF3aHjcZFvjoFZRfbB9tP/+e6a9NspaPr6nsfSgWAWJp9v8+mUPAMu0reZG
 ns1SG1yE1fujjkFWFR4/qvaZlq/7zTqzCmw5igviL3dM7LmAaKFsXTu8YfueV2EQLciM
 0msGHna09Y2YV/UnLsOdKl17jKFc7ijUicLRfdF5vURrvYzsx8E0VnjqAi1Z79EoXbaW
 Gfupl3Lytf6k+7GmRaH/5MZaOH27aMk8TwRfAhrXN8egbD8ew2nJsYXkJSnXEZa5ubPV
 UWbg==
X-Gm-Message-State: AOJu0YzWFHAwq9kNVN5RnK554jFhWqmTWv+m0e4wleTRA4z5xPehEdqy
 qn1FmYz6ev8tTRC6urgXn5kBOhCqXxE8pvYVBEXQhVv64xGH7bS8B62sh21w3DpksNVcCGgeNfI
 v0LEcvVTo5JRKW9GSux/sO86g3FLlxYQ=
X-Received: by 2002:a05:6512:400c:b0:500:b828:7a04 with SMTP id
 br12-20020a056512400c00b00500b8287a04mr1320702lfb.18.1695804220297; 
 Wed, 27 Sep 2023 01:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwRIqu2fL0lR+UlBZMXZBaoOcJoitHwTr2xPnqefOMhhKnZLhzAc10RVDz6HZsT1tRRu0lPm5WggBbb32dfcY=
X-Received: by 2002:a05:6512:400c:b0:500:b828:7a04 with SMTP id
 br12-20020a056512400c00b00500b8287a04mr1320685lfb.18.1695804219823; Wed, 27
 Sep 2023 01:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695034158.git.dxu@dxuuu.xyz>
 <604ef5fd5bda8acdb837b5d28ec405e9fb0332a3.1695034158.git.dxu@dxuuu.xyz>
 <ZQhpZ+2doxD7vaR8@redhat.com>
 <qelgz7ljf5ooc6mkdzeikodf35cc77anowtm34b6rhgr4qpdcz@zdvjnj67jyfo>
In-Reply-To: <qelgz7ljf5ooc6mkdzeikodf35cc77anowtm34b6rhgr4qpdcz@zdvjnj67jyfo>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 27 Sep 2023 11:43:28 +0300
Message-ID: <CAPMcbCojC=R0mr5dMqdoJUzw5-RoeydsK0io3vpzO_qo-A27Yw@mail.gmail.com>
Subject: Re: [PATCH 2/3] qga: Add optional stream-output argument to guest-exec
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 michael.roth@amd.com, qemu-devel@nongnu.org, hmodi@aviatrix.com, 
 Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000021b01106065330bb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000021b01106065330bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

As for me, the idea of using QGA as an interactive shell is not good.
I suggest using virtio-serial as a transport for stdin/stdout of your
process.
Examples:

https://stackoverflow.com/questions/68277557/qemu-virtio-virtconsole-device=
s-explained
    https://fedoraproject.org/wiki/Features/VirtioSerial

Is this solution good for your project?

Best Regards,
Konstantin Kostiuk.


On Mon, Sep 18, 2023 at 8:17=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:

> Hi Daniel,
>
> On Mon, Sep 18, 2023 at 04:14:47PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Sep 18, 2023 at 04:54:22AM -0600, Daniel Xu wrote:
> > > Currently, commands run through guest-exec are "silent" until they
> > > finish running. This is fine for short lived commands. But for comman=
ds
> > > that take a while, this is a bad user experience.
> > >
> > > Usually long running programs know that they will run for a while. To
> > > improve user experience, they will typically print some kind of statu=
s
> > > to output at a regular interval. So that the user knows that their
> > > command isn't just hanging.
> > >
> > > This commit adds support for an optional stream-output parameter to
> > > guest-exec. This causes subsequent calls to guest-exec-status to retu=
rn
> > > all buffered output. This allows downstream applications to be able t=
o
> > > relay "status" to the end user.
> > >
> > > If stream-output is requested, it is up to the guest-exec-status call=
er
> > > to keep track of the last seen output position and slice the returned
> > > output appropriately. This is fairly trivial for a client to do. And =
it
> > > is a more reliable design than having QGA internally keep track of
> > > position -- for the cases that the caller "loses" a response.
> >
> > I can understand why you want this incremental output facility,
> > but at the same time I wonder where we draw the line for QGA
> > with users needing a real shell session instead.
>
> You mean interactive shell, right? If so, I would agree an interactive
> shell is not a good fit for QGA.
>
> But as it stands, a non-interactive shell works quite well (having
> guest-exec run a bash script). I was the one who added the merged output
> stream support a few months back. With merged output streams and this
> streaming support, you can do some really neat things with QGA (see
> below).
>
> The primary reason I'm adding this support is for vmtest [0]. You can
> find code for it here [1]. Basically what leveraging QGA does is allow
> the vmtest implementation to reuse the same code for both kernel-only
> (ie bzImage) and and image targets (eg qcow2).
>
> [0]: https://dxuuu.xyz/vmtest.html
> [1]: https://github.com/danobi/vmtest
>
> >
> > When there is a long lived command, then IMHO it is also likely
> > that there will be a need to kill the background running command
> > too.
> >
> > We quickly end up re-inventing a shell in QGA if we go down this
> > route.
>
> I can understand if you don't want to bloat the QGA feature set, but
> IMHO this change cleanly composes with the current implementation and
> is easily unit testable (and comes with a test).
>
> Per the discussion in the other thread, it could be argued that this
> streaming feature is actually a bug fix -- the documentation seems to
> imply otherwise, which both Markus and I have independently arrived
> at. But I don't think we need to go into semantics like that :) .
>
> But it does kinda imply from first principles that it is a reasonable
> thing for guest-exec-status to provide. Perhaps it's too late to change
> the existing behavior, so a flag is needed.
>
> I hope my reasoning makes sense. And thanks for giving this a look.
>
> Thanks,
> Daniel
>
> [...]
>
>

--00000000000021b01106065330bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<br><br>As for me, the idea of using QGA as an i=
nteractive shell is not good.<br>I suggest using virtio-serial as a transpo=
rt for stdin/stdout of your process. <br>Examples:<br>=C2=A0 =C2=A0 <a href=
=3D"https://stackoverflow.com/questions/68277557/qemu-virtio-virtconsole-de=
vices-explained">https://stackoverflow.com/questions/68277557/qemu-virtio-v=
irtconsole-devices-explained</a><br>=C2=A0 =C2=A0 <a href=3D"https://fedora=
project.org/wiki/Features/VirtioSerial">https://fedoraproject.org/wiki/Feat=
ures/VirtioSerial</a><br><br><div>Is this solution good for your project? <=
br></div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_signature" dat=
a-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><d=
iv>Konstantin Kostiuk.</div></div></div></div><br></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 18, 2023 at 8=
:17=E2=80=AFPM Daniel Xu &lt;<a href=3D"mailto:dxu@dxuuu.xyz">dxu@dxuuu.xyz=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Hi Daniel,<br>
<br>
On Mon, Sep 18, 2023 at 04:14:47PM +0100, Daniel P. Berrang=C3=A9 wrote:<br=
>
&gt; On Mon, Sep 18, 2023 at 04:54:22AM -0600, Daniel Xu wrote:<br>
&gt; &gt; Currently, commands run through guest-exec are &quot;silent&quot;=
 until they<br>
&gt; &gt; finish running. This is fine for short lived commands. But for co=
mmands<br>
&gt; &gt; that take a while, this is a bad user experience.<br>
&gt; &gt; <br>
&gt; &gt; Usually long running programs know that they will run for a while=
. To<br>
&gt; &gt; improve user experience, they will typically print some kind of s=
tatus<br>
&gt; &gt; to output at a regular interval. So that the user knows that thei=
r<br>
&gt; &gt; command isn&#39;t just hanging.<br>
&gt; &gt; <br>
&gt; &gt; This commit adds support for an optional stream-output parameter =
to<br>
&gt; &gt; guest-exec. This causes subsequent calls to guest-exec-status to =
return<br>
&gt; &gt; all buffered output. This allows downstream applications to be ab=
le to<br>
&gt; &gt; relay &quot;status&quot; to the end user.<br>
&gt; &gt; <br>
&gt; &gt; If stream-output is requested, it is up to the guest-exec-status =
caller<br>
&gt; &gt; to keep track of the last seen output position and slice the retu=
rned<br>
&gt; &gt; output appropriately. This is fairly trivial for a client to do. =
And it<br>
&gt; &gt; is a more reliable design than having QGA internally keep track o=
f<br>
&gt; &gt; position -- for the cases that the caller &quot;loses&quot; a res=
ponse.<br>
&gt; <br>
&gt; I can understand why you want this incremental output facility,<br>
&gt; but at the same time I wonder where we draw the line for QGA<br>
&gt; with users needing a real shell session instead.<br>
<br>
You mean interactive shell, right? If so, I would agree an interactive<br>
shell is not a good fit for QGA.<br>
<br>
But as it stands, a non-interactive shell works quite well (having<br>
guest-exec run a bash script). I was the one who added the merged output<br=
>
stream support a few months back. With merged output streams and this<br>
streaming support, you can do some really neat things with QGA (see<br>
below).<br>
<br>
The primary reason I&#39;m adding this support is for vmtest [0]. You can<b=
r>
find code for it here [1]. Basically what leveraging QGA does is allow<br>
the vmtest implementation to reuse the same code for both kernel-only<br>
(ie bzImage) and and image targets (eg qcow2). <br>
<br>
[0]: <a href=3D"https://dxuuu.xyz/vmtest.html" rel=3D"noreferrer" target=3D=
"_blank">https://dxuuu.xyz/vmtest.html</a><br>
[1]: <a href=3D"https://github.com/danobi/vmtest" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/danobi/vmtest</a><br>
<br>
&gt; <br>
&gt; When there is a long lived command, then IMHO it is also likely<br>
&gt; that there will be a need to kill the background running command<br>
&gt; too.<br>
&gt; <br>
&gt; We quickly end up re-inventing a shell in QGA if we go down this<br>
&gt; route.<br>
<br>
I can understand if you don&#39;t want to bloat the QGA feature set, but<br=
>
IMHO this change cleanly composes with the current implementation and<br>
is easily unit testable (and comes with a test).<br>
<br>
Per the discussion in the other thread, it could be argued that this<br>
streaming feature is actually a bug fix -- the documentation seems to<br>
imply otherwise, which both Markus and I have independently arrived<br>
at. But I don&#39;t think we need to go into semantics like that :) .<br>
<br>
But it does kinda imply from first principles that it is a reasonable<br>
thing for guest-exec-status to provide. Perhaps it&#39;s too late to change=
<br>
the existing behavior, so a flag is needed.<br>
<br>
I hope my reasoning makes sense. And thanks for giving this a look.<br>
<br>
Thanks,<br>
Daniel<br>
<br>
[...]<br>
<br>
</blockquote></div>

--00000000000021b01106065330bb--


