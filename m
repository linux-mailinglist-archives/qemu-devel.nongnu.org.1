Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 203C878C9B4
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:34:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1e6-0001sY-FF; Tue, 29 Aug 2023 12:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qb1dw-0001rl-Lr
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:32:43 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qb1dm-00078Z-2R
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:32:39 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-269304c135aso2940688a91.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693326625; x=1693931425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LBrf24xHbMu5zTODEDzyxPnE41m02WMUSig75xWEt4U=;
 b=FWF7F8IlX2MG3U3uA6YEFesSjVvBwAxX4+MTCxzSQy93kbhmHymGp+E2uaqJxulBjv
 nep/h+9bnEhTctfXdqnFmJAV+K48aXVoBhd86i51tbhAYf4bydDUfcPLKkqpQ+5o22wV
 iaZ5vYkMwYYXmSeHMGDawLHWogAJUPYmnFhEEJjEPM8MG6t5hCvb8ivEQ3WOEo8tRKCM
 +dIGpzFfRTx343hco+F8d0eC3Mx5OiTi+vjMSVo1jLa+N9SQ8K6fX5/dnLDhpEweKVV2
 TmyLYnnreiOtiLrO0CNZeaHaWfMN/9pM59bt3Qdo+dx5qZ/joX3dQLOYjxd1Wy9wSK4s
 AqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693326625; x=1693931425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LBrf24xHbMu5zTODEDzyxPnE41m02WMUSig75xWEt4U=;
 b=HL/704n2RIPifqTd351uJbWxpmrgsfoqQVV618KF2waKKeDAFyaO7uVFxZ+OtweoLK
 liQBGY48XgSRFSc/DWbr1dMRO1QtPb86YAMtZBkjackkR2DUm3vMHgktZIFJzLFahqbB
 cJvLzeEssArDKjUKlcM+YnEygO7FGRlDOwgQ0VRAedHZthgcIXYJgQt2YHqs99Fd2hwY
 OukKozAs1aNCsPfvSlQPvmjsp9/xM1stmWtGri8YphP5lnJTIqtZ1MQ/digQp1cUe6fZ
 vKy9I0RuZ7zik/iBI3EU9QO9PJQ3Ey4KdC/nG8ScbWj1iXSrfF+zcwSiGW6sgEUFpJwQ
 aFVA==
X-Gm-Message-State: AOJu0YxyXIVTFZQ8eO8ugQEKz4QVWfP4TBVtrNoC+/MpZeUUn0VNljDq
 EkrUBBlAuXjZagHYKEZV+WFhvM/p9Z+b/g+nk8vI/w==
X-Google-Smtp-Source: AGHT+IFPoIjVQ75nOatvKUdaIZ4Z8RJ2rtBmAgNB5TvA8OZcy2rcPdqOx0mwgHuyfJMFeSlbjxuq6XOKcbA0xVvCUTQ=
X-Received: by 2002:a17:90a:8a95:b0:268:b7a2:62e8 with SMTP id
 x21-20020a17090a8a9500b00268b7a262e8mr27453328pjn.7.1693326625316; Tue, 29
 Aug 2023 09:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693228686.git.yong.huang@smartx.com>
 <CAJSP0QXLticPp0DOS=7bYQf0R0MiYpRXYu_dCRE9JVUbZd2nsw@mail.gmail.com>
In-Reply-To: <CAJSP0QXLticPp0DOS=7bYQf0R0MiYpRXYu_dCRE9JVUbZd2nsw@mail.gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 30 Aug 2023 00:30:07 +0800
Message-ID: <CAK9dgmai9Q0cSYudyM8PBb1AZyxcv6G6BTrRAeJL2EaaR8CNUg@mail.gmail.com>
Subject: Re: [PULL 0/3] Dirty page rate and dirty page limit 20230828 patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Andrei Gudkov <gudkov.andrei@huawei.com>, 
 "alloc . young" <alloc.young@outlook.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fdb63206041253cf"
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000fdb63206041253cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 4:01=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:

> On Mon, 28 Aug 2023 at 10:36, Hyman Huang <yong.huang@smartx.com> wrote:
> >
> > From: Hyman <yong.huang@smartx.com>
> >
> > The following changes since commit
> 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4:
> >
> >   Merge tag 'pull-target-arm-20230824' of
> https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24
> 10:08:33 -0400)
> >
> > are available in the git repository at:
> >
> >   https://github.com/newfriday/qemu.git
> tags/dirtylimit-dirtyrate-fixes-pull-request
>
> Hi,
> This is not a signed tag. Please use "git tag -s" so the tag is signed
> with your GPG key.
>
> I also noticed that this pull request email thread only has a cover
> letter. Please also send the individual patches along with the pull
> request email. This makes it easier for people to reply if they have
> comments about a patch.
>
> After pushing a signed tag, please send the pull request again with
> "PULL v2" in the subject line. Thanks!
>

Sorry for not noticing this earlier and I have sent a pull request with
"PULL"
in the subject line instead of "PULL v3" that you mentioned above, please
ping me if PULL request resending is required indeed.

Yong


> Thanks,
> Stefan
>
> >
> > for you to fetch changes up to e424d9f7e749c84de4a6ce532981271db1c14b23=
:
> >
> >   migration/dirtyrate: Fix precision losses and g_usleep overshoot
> (2023-08-28 21:03:58 +0800)
> >
> > ----------------------------------------------------------------
> > Dirty page limit and dirty page rate PULL request
> >
> > Hi, this is the fix for dirty page limit and dirty page rate.
> >
> > Please apply.
> >
> > Thanks, Yong.
> > ----------------------------------------------------------------
> > Andrei Gudkov (1):
> >       migration/dirtyrate: Fix precision losses and g_usleep overshoot
> >
> > alloc.young (2):
> >       softmmu: Fix dirtylimit memory leak
> >       softmmu/dirtylimit: Convert free to g_free
> >
> >  migration/dirtyrate.c | 10 ++++++++--
> >  softmmu/dirtylimit.c  | 26 ++++++++++++--------------
> >  2 files changed, 20 insertions(+), 16 deletions(-)
> >
> > --
> > 1.8.3.1
> >
> >
>


--=20
Best regards

--000000000000fdb63206041253cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 29, 20=
23 at 4:01=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.=
com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Mon, 28=
 Aug 2023 at 10:36, Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Hyman &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_bl=
ank">yong.huang@smartx.com</a>&gt;<br>
&gt;<br>
&gt; The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fb=
f6ec4:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Merge tag &#39;pull-target-arm-20230824&#39; of <a href=3D=
"https://git.linaro.org/people/pmaydell/qemu-arm" rel=3D"noreferrer" target=
=3D"_blank">https://git.linaro.org/people/pmaydell/qemu-arm</a> into stagin=
g (2023-08-24 10:08:33 -0400)<br>
&gt;<br>
&gt; are available in the git repository at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://github.com/newfriday/qemu.git" rel=3D"n=
oreferrer" target=3D"_blank">https://github.com/newfriday/qemu.git</a> tags=
/dirtylimit-dirtyrate-fixes-pull-request<br>
<br>
Hi,<br>
This is not a signed tag. Please use &quot;git tag -s&quot; so the tag is s=
igned<br>
with your GPG key.<br>
<br>
I also noticed that this pull request email thread only has a cover<br>
letter. Please also send the individual patches along with the pull<br>
request email. This makes it easier for people to reply if they have<br>
comments about a patch.<br>
<br>
After pushing a signed tag, please send the pull request again with<br>
&quot;PULL v2&quot; in the subject line. Thanks!<br></blockquote><div><br><=
/div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&=
quot;,sans-serif">Sorry for not noticing this earlier and I have sent a pul=
l request with &quot;PULL&quot;</div><div><span style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif">in the subject line instead of &quot;PULL v=
3&quot;<span class=3D"gmail_default" style=3D"font-family:&quot;comic sans =
ms&quot;,sans-serif"> that you mentioned=C2=A0above, please</span></span></=
div><div><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><=
span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif">ping me if PULL request resending is required indeed.</span></=
span></div><div><span style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif"><span class=3D"gmail_default" style=3D"font-family:&quot;comic sans m=
s&quot;,sans-serif"><br></span></span></div><div><span style=3D"font-family=
:&quot;comic sans ms&quot;,sans-serif"><span class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yong</span></span></d=
iv><div><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><s=
pan class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,=
sans-serif"><br></span></span></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Stefan<br>
<br>
&gt;<br>
&gt; for you to fetch changes up to e424d9f7e749c84de4a6ce532981271db1c14b2=
3:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0migration/dirtyrate: Fix precision losses and g_usleep ove=
rshoot (2023-08-28 21:03:58 +0800)<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; Dirty page limit and dirty page rate PULL request<br>
&gt;<br>
&gt; Hi, this is the fix for dirty page limit and dirty page rate.<br>
&gt;<br>
&gt; Please apply.<br>
&gt;<br>
&gt; Thanks, Yong.<br>
&gt; ----------------------------------------------------------------<br>
&gt; Andrei Gudkov (1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0migration/dirtyrate: Fix precision losses an=
d g_usleep overshoot<br>
&gt;<br>
&gt; alloc.young (2):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0softmmu: Fix dirtylimit memory leak<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0softmmu/dirtylimit: Convert free to g_free<b=
r>
&gt;<br>
&gt;=C2=A0 migration/dirtyrate.c | 10 ++++++++--<br>
&gt;=C2=A0 softmmu/dirtylimit.c=C2=A0 | 26 ++++++++++++--------------<br>
&gt;=C2=A0 2 files changed, 20 insertions(+), 16 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 1.8.3.1<br>
&gt;<br>
&gt;<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000fdb63206041253cf--

