Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B4C78D1FA
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 04:17:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbAle-0004gW-Ce; Tue, 29 Aug 2023 22:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qbAlV-0004fG-O2
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 22:17:06 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qbAlR-0008KB-L0
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 22:17:05 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1ccb6a69b13so3599777fac.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 19:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693361696; x=1693966496;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kl7DlHQzZDfJ0La3iYBSwHB0/Uq5YxWxP8Vy1m2qofc=;
 b=CRa/nRdKxWghfvHXTU+zurUQvsLUIV+i14UrgOdjw9Tf5DvNGA30XJ+XS8LitejvIZ
 dOznYPxOocfl+AZ1c2xzJldQgFewTrcMudtqJNse+vQcaB/QOAQK7D9Q8/zdysT3Ug9e
 WbJVsZD57We4+9l+6OjkRr+VjmJEJGbAKKVt57ZAqGBiDh7ogLxghwynAWHaRuov1/mJ
 fQeVhG/1EVdY7Si47mAQd+fvVleH+s0aKaDrTwPgqqdL4NfcdgcXJQ/RHUj1nzfphejf
 wx4V3UN2I9DbUVpshkhIsVSoZLcyHqxMD6+IOlWVnjoZDDr9Qg7LfvwthPzsXpIJs7Jo
 A5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693361696; x=1693966496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kl7DlHQzZDfJ0La3iYBSwHB0/Uq5YxWxP8Vy1m2qofc=;
 b=QNqW0YPUrFKZ4Ou0ctpGPVdoPeUKgTp+lmSBTYr5nB8I277nXshVp9gKFJvq+DNXJj
 gx71A3d89CQSOja6zlqYa0+xGS030mjS299mvnNLfLnKLoXLJhO7iSmPsgl0iE1DfLjs
 NXo6mvRHUAHjyXpOz1hpEjXUghYmJcc6dCFAan0G6+Tc+q9TxHMnaAMWlP1xPE2NdVAG
 MgJhr10dmmA/H0AQuoeM+68ncN/c+7oHas8p9fuBRPB8n7i1wYL8rcYKj0xGYsVed5Sx
 MboVJWOjtdc0mYcVPvFzQgxuOCmhSHJznBIsVqgDbj5S9asqdWeBKQXQjX8grRRY2W9T
 qE7Q==
X-Gm-Message-State: AOJu0YxIv2BWdXsvaONi5uWjuPMpkZr6bdlGA8AiNjG7cB38JHZhyLC9
 qSTXgkaCriKHv8bslERpCyLTpKKfYDbDLVtGdvkK5Q==
X-Google-Smtp-Source: AGHT+IGarrPFqQN12agVoycwHsKvO6EBshd0zU7MgfxlhmkmwOefI80fOvlVHwroQY49IAIJGyDCnpL9J/dWf/CrkLc=
X-Received: by 2002:a05:6870:d7a8:b0:1b0:5b04:ebec with SMTP id
 bd40-20020a056870d7a800b001b05b04ebecmr948964oab.59.1693361696226; Tue, 29
 Aug 2023 19:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693228686.git.yong.huang@smartx.com>
 <CAJSP0QXLticPp0DOS=7bYQf0R0MiYpRXYu_dCRE9JVUbZd2nsw@mail.gmail.com>
 <CAK9dgmai9Q0cSYudyM8PBb1AZyxcv6G6BTrRAeJL2EaaR8CNUg@mail.gmail.com>
 <CAJSP0QXa1mn-W9pAhRmFYU0V3Y2C_K4Ca=KXsmaZ-bheiVB_+Q@mail.gmail.com>
In-Reply-To: <CAJSP0QXa1mn-W9pAhRmFYU0V3Y2C_K4Ca=KXsmaZ-bheiVB_+Q@mail.gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 30 Aug 2023 10:14:40 +0800
Message-ID: <CAK9dgmaj02tAoztpycHeVh8TiA-3aqm8eh+sK5B3Gbj78sCZpw@mail.gmail.com>
Subject: Re: [PULL 0/3] Dirty page rate and dirty page limit 20230828 patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Andrei Gudkov <gudkov.andrei@huawei.com>, 
 "alloc . young" <alloc.young@outlook.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006155e606041a7e02"
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2b.google.com
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

--0000000000006155e606041a7e02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 1:31=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:

> On Tue, 29 Aug 2023 at 12:30, Yong Huang <yong.huang@smartx.com> wrote:
> > On Tue, Aug 29, 2023 at 4:01=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail=
.com>
> wrote:
> >>
> >> On Mon, 28 Aug 2023 at 10:36, Hyman Huang <yong.huang@smartx.com>
> wrote:
> >> >
> >> > From: Hyman <yong.huang@smartx.com>
> >> >
> >> > The following changes since commit
> 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4:
> >> >
> >> >   Merge tag 'pull-target-arm-20230824' of
> https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24
> 10:08:33 -0400)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >   https://github.com/newfriday/qemu.git
> tags/dirtylimit-dirtyrate-fixes-pull-request
> >>
> >> Hi,
> >> This is not a signed tag. Please use "git tag -s" so the tag is signed
> >> with your GPG key.
> >>
> >> I also noticed that this pull request email thread only has a cover
> >> letter. Please also send the individual patches along with the pull
> >> request email. This makes it easier for people to reply if they have
> >> comments about a patch.
> >>
> >> After pushing a signed tag, please send the pull request again with
> >> "PULL v2" in the subject line. Thanks!
> >
> >
> > Sorry for not noticing this earlier and I have sent a pull request with
> "PULL"
> > in the subject line instead of "PULL v3" that you mentioned above, plea=
se
> > ping me if PULL request resending is required indeed.
>
> I have applied the pull request. To make it easier to verify future
> pull requests, please publish your public key to a keyserver:
>
>   $ gpg --send-keys DFF223D6B3FECB9C
>

Ok, get it. Thanks.

Yong

>
> Thanks!
>
> Stefan
>


--=20
Best regards

--0000000000006155e606041a7e02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 30, 20=
23 at 1:31=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.=
com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Tue, 29=
 Aug 2023 at 12:30, Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com"=
 target=3D"_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt; On Tue, Aug 29, 2023 at 4:01=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D=
"mailto:stefanha@gmail.com" target=3D"_blank">stefanha@gmail.com</a>&gt; wr=
ote:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, 28 Aug 2023 at 10:36, Hyman Huang &lt;<a href=3D"mailto:yo=
ng.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt; wrote:=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; From: Hyman &lt;<a href=3D"mailto:yong.huang@smartx.com" targ=
et=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The following changes since commit 50e7a40af372ee5931c99ef739=
0f5d3d6fbf6ec4:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0Merge tag &#39;pull-target-arm-20230824&#39; of <=
a href=3D"https://git.linaro.org/people/pmaydell/qemu-arm" rel=3D"noreferre=
r" target=3D"_blank">https://git.linaro.org/people/pmaydell/qemu-arm</a> in=
to staging (2023-08-24 10:08:33 -0400)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; are available in the git repository at:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0<a href=3D"https://github.com/newfriday/qemu.git"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/newfriday/qemu.git=
</a> tags/dirtylimit-dirtyrate-fixes-pull-request<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt; This is not a signed tag. Please use &quot;git tag -s&quot; so the=
 tag is signed<br>
&gt;&gt; with your GPG key.<br>
&gt;&gt;<br>
&gt;&gt; I also noticed that this pull request email thread only has a cove=
r<br>
&gt;&gt; letter. Please also send the individual patches along with the pul=
l<br>
&gt;&gt; request email. This makes it easier for people to reply if they ha=
ve<br>
&gt;&gt; comments about a patch.<br>
&gt;&gt;<br>
&gt;&gt; After pushing a signed tag, please send the pull request again wit=
h<br>
&gt;&gt; &quot;PULL v2&quot; in the subject line. Thanks!<br>
&gt;<br>
&gt;<br>
&gt; Sorry for not noticing this earlier and I have sent a pull request wit=
h &quot;PULL&quot;<br>
&gt; in the subject line instead of &quot;PULL v3&quot; that you mentioned =
above, please<br>
&gt; ping me if PULL request resending is required indeed.<br>
<br>
I have applied the pull request. To make it easier to verify future<br>
pull requests, please publish your public key to a keyserver:<br>
<br>
=C2=A0 $ gpg --send-keys DFF223D6B3FECB9C<br></blockquote><div><br></div><d=
iv class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif">Ok, get it. Thanks.</div><div class=3D"gmail_default" style=3D"f=
ont-family:&quot;comic sans ms&quot;,sans-serif"><br></div><div class=3D"gm=
ail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yon=
g</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204=
,204);padding-left:1ex">
<br>
Thanks!<br>
<br>
Stefan<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000006155e606041a7e02--

