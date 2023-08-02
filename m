Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B9A76C1DA
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 03:04:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR0Gs-0001CM-JE; Tue, 01 Aug 2023 21:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qR0Gq-0001CB-Sc
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 21:03:24 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qR0Gn-0006oe-M8
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 21:03:24 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-563dae89bc9so3671442a12.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 18:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690938077; x=1691542877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sXhYQ9kXQM8Oy+iujyfdDpbkINn6Of5re2slthVGUwU=;
 b=zmrZbNhA8CvPNLEQUYkAsvztrjAXWWsO5VRZGHN7Ck8zQOyp7hfinO/rMm8V+46Lvu
 GvjlauaMcopCc+tTbxXKVzWb8XI6vOZhMjixmNlJVzX5JVEiSQviWpm81x6a8upCqXev
 jEGBxlMz+HU6f6+T/z5XGwhGJ92gSH798FX56TXopxUpk2M6YO0z0DMn9WJ8qgTIDuAk
 iwZvDG01AVc+h7FZs6iZsd3+GR4khPy2RgDbzPG3nSpKu5ym+P43Q0VQJzVoZcW8gM13
 BPW79AFG6jW1+5cU41S3J7eVDDFEV/fbacBk7eWomQ9MveWq85uqL1ufHSe0H3R5i2N0
 IrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690938077; x=1691542877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sXhYQ9kXQM8Oy+iujyfdDpbkINn6Of5re2slthVGUwU=;
 b=Wv1O2EF5OCXPOSTIaUrl0Kb6XkOlHrRuJrI6AIKhSWT7d5dfifJM2NoWlq9RUiLrz4
 5IpIB+OzMxfctHcK5TiZS/XJ1oH4EHlSbKsXPZ1oFLbXC66Zwpjs0Y/Av9+a4avzF7mi
 XgJ/e4lo6iWtL7f/Knm6FBOgJgHAVxoaL0rNgEeJjs87LL01vrxu8d1PEUXctgGbr7fw
 dyOJUu4wLScG3hSFHiGdIQRPh/Z3pmvgNzboeMUv13GXgsCNy+Y6CZus3dt/p/4lRzyj
 YutMbaiO66Ds53bC25iuxUSRlZhEN/SuEZwB6+Sc2/9kTEhOWXSRbXEPK/2OAzNnggYg
 a2hA==
X-Gm-Message-State: ABy/qLYj+PRgfpKSghfC39D8sBlTg10NOI+CON2qXgdP4w9/syiZSXwG
 OMizOhPs90fG9XxbklBGw4q/9XNz2pD9pxdfZKS3VQ==
X-Google-Smtp-Source: APBJJlFXNtIDCPhcFOR9kvbPjwzNyGJ7VeIERFooacuMhw8PwepR3mFNe4DSwpu+W23ZFPlERgUS54je5Fyxq7bwTk0=
X-Received: by 2002:a17:90b:3807:b0:262:f579:41db with SMTP id
 mq7-20020a17090b380700b00262f57941dbmr12045775pjb.6.1690938077273; Tue, 01
 Aug 2023 18:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <169040075240.21656.5651891935411754498-1@git.sr.ht>
 <87y1j0lblv.fsf@pond.sub.org>
 <CAK9dgmaWfHyPDKneJVEo2TDehZ9PX0a-YLSp2x+Z=kYeJohmOQ@mail.gmail.com>
 <87o7jr0woh.fsf@pond.sub.org>
In-Reply-To: <87o7jr0woh.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 2 Aug 2023 09:01:01 +0800
Message-ID: <CAK9dgmasHP3EJNR4FL146sEcxutXqm_o3W8Jkf7Q9bq8OkrxUw@mail.gmail.com>
Subject: Re: [PATCH QEMU 1/2] qapi: Reformat and craft the migration doc
 comments
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006ef8c00601e633ca"
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52e.google.com
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

--0000000000006ef8c00601e633ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 1, 2023 at 8:33=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> Yong Huang <yong.huang@smartx.com> writes:
>
> > On Fri, Jul 28, 2023 at 3:49=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> ~hyman <hyman@git.sr.ht> writes:
> >>
> >> > From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> >> >
> >> > Reformat migration doc comments to conform to current conventions
> >> > as commit a937b6aa739 (qapi: Reformat doc comments to conform to
> >> > current conventions).
> >> >
> >> > Also, craft the dirty-limit capability comment.
> >>
> >> Split into two patches?
> >>
> > Ok.
> >
> >>
> >> > Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.co=
m>
> >> > ---
> >> >  qapi/migration.json | 66
> +++++++++++++++++++++------------------------
> >> >  1 file changed, 31 insertions(+), 35 deletions(-)
> >> >
> >> > diff --git a/qapi/migration.json b/qapi/migration.json
> >> > index 6b49593d2f..5d5649c885 100644
> >> > --- a/qapi/migration.json
> >> > +++ b/qapi/migration.json
> >> > @@ -258,17 +258,17 @@
> >> >  #     blocked.  Present and non-empty when migration is blocked.
> >> >  #     (since 6.0)
> >> >  #
> >> > -# @dirty-limit-throttle-time-per-round: Maximum throttle time
> (inmicroseconds) of virtual
> >> > -#                                       CPUs each dirty ring
> fullround, which shows how
> >> > -#                                       MigrationCapability
> dirty-limitaffects the guest
> >> > -#                                       during live migration.
> (since8.1)
> >> > -#
> >> > -# @dirty-limit-ring-full-time: Estimated average dirty ring full
> time(in microseconds)
> >> > -#                              each dirty ring full round, note
> thatthe value equals
> >> > -#                              dirty ring memory size divided
> byaverage dirty page rate
> >> > -#                              of virtual CPU, which can be used
> toobserve the average
> >> > -#                              memory load of virtual CPU
> indirectly.Note that zero
> >> > -#                              means guest doesn't dirty memory
> (since8.1)
> >> > +# @dirty-limit-throttle-time-per-round: Maximum throttle time
> >> > +#     (in microseconds) of virtual CPUs each dirty ring full round,
> >> > +#     which shows how MigrationCapability dirty-limit affects the
> >>
> >> Perhaps "for each ... round"?
> >>
> >> Remind me, what's a "dirty ring full round"?
> >>
> > Every time the x86 PML buffer is filled with gpa, hardware throws an
> > exception and
> > guest exits to kvm, then to qemu. Qemu will handle the exception with
> > reaping the
> > dirty ring and get the dirty page info, then enter the kvm, empty the P=
ML
> > buffer and
> > enter guests again, i call this "dirty ring full round", but it seems n=
ot
> > straightforward,
> > please help me describe that,  thanks.
>
> "x86 PML" is page modification logging, right?
>
Yes.

The dirty ring full round may be actually imprecise indeed. I'll try to
refactor the
comment in the next version, hoping to do better.

>
> >> > +#     guest during live migration.  (Since 8.1)
> >> > +#
> >> > +# @dirty-limit-ring-full-time: Estimated average dirty ring full
> >> > +#     time (in microseconds) each dirty ring full round. The value
> >>
> >> Likewise.
> >>
> >> > +#     equals dirty ring memory size divided by average dirty page
> >>
> >> "the dirty ring memory size divided by the average ..."
> >>
> >> > +#     rate of the virtual CPU, which can be used to observe the
> >> > +#     average memory load of the virtual CPU indirectly. Note that
> >> > +#     zero means guest doesn't dirty memory.  (Since 8.1)
> >>
> >> Two spaces between sentences for consistency.
> >>
> >> >  #
> >> >  # Since: 0.14
> >> >  ##
> >> > @@ -519,15 +519,11 @@
> >> >  #     are present.  'return-path' capability must be enabled to use
> >> >  #     it.  (since 8.1)
> >> >  #
> >> > -# @dirty-limit: If enabled, migration will use the dirty-limit algo
> to
> >> > -#               throttle down guest instead of auto-converge algo.
> >> > -#               Throttle algo only works when vCPU's dirtyrate
> greater
> >> > -#               than 'vcpu-dirty-limit', read processes in guest os
> >> > -#               aren't penalized any more, so this algo can improve
> >> > -#               performance of vCPU during live migration. This is =
an
> >> > -#               optional performance feature and should not affect
> the
> >> > -#               correctness of the existing auto-converge algo.
> >> > -#               (since 8.1)
> >> > +# @dirty-limit: If enabled, migration will throttle vCPUs as needed
> to
> >> > +#     keep their dirty page rate within @vcpu-dirty-limit.  This ca=
n
> >> > +#     improve responsiveness of large guests during live migration,
> >> > +#     and can result in more stable read performance.  Requires KVM
> >> > +#     with accelerator property "dirty-ring-size" set.  (Since 8.1)
> >> >  #
> >> >  # Features:
> >> >  #
> >> > @@ -822,17 +818,17 @@
> >> >  #     Nodes are mapped to their block device name if there is one,
> and
> >> >  #     to their node name otherwise.  (Since 5.2)
> >> >  #
> >> > -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of
> dirtylimit during
> >> > -#                             live migration. Should be in the rang=
e
> 1to 1000ms,
> >> > -#                             defaults to 1000ms. (Since 8.1)
> >> > +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of
> dirty
> >> > +#     limit during  live migration. Should be in the range 1 to
> 1000ms,
> >>
> >> Single space in "during live", and two space between sentences, please=
.
> >>
> >> > +#     defaults to 1000ms.  (Since 8.1)
> >>
> >> I dislike that we mix milli- and microseconds.  Too late to fix, I'm
> >> afraid.
> >>
> >> Remind me, what't the "periodic time of dirty limit during live
> >> migration"?
> >>
> > It is the period to calculate the dirty page rate for each vCPU.
> > So Qemu will use it to compare with the dirty-limit value.
> > If the period is too short, cpu overhead is increasing and if
> > it is too long, the result may not be precise. So we make it
> > configurable.
>
> The limited migration knowledge I have wasn't enough to review the doc
> part of your QAPI schema patch with reasonable effort and within a
> reasonable time.  You had to answer a lot of fairly basic questions.
> Thanks for your patience.
>
Not at all, feel free to comment on the patch set. I'll try my best to
reply.

>
> Perhaps I should've given up and left the docs to the migration
> maintainers.
>
> I believe what I've been missing is an overview of the dirty limit
> algorithm to throttle guests being live-migrated.
>
> Could we have that in docs/devel/migration.rst?
>
No problem, I'll do that and request for comments in the next version.

>
> Apropos migration.rst: not a peep on compression.  Juan, Peter,
> Leonardo, should it be covered there?
>
> [...]
>
>

--=20
Best regards

--0000000000006ef8c00601e633ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 1, 202=
3 at 8:33=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-s=
tyle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Yong Huang =
&lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@s=
martx.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Jul 28, 2023 at 3:49=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; ~hyman &lt;<a href=3D"mailto:hyman@git.sr.ht" target=3D"_blank">hy=
man@git.sr.ht</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; From: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D"mailto:y=
ong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Reformat migration doc comments to conform to current convent=
ions<br>
&gt;&gt; &gt; as commit a937b6aa739 (qapi: Reformat doc comments to conform=
 to<br>
&gt;&gt; &gt; current conventions).<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Also, craft the dirty-limit capability comment.<br>
&gt;&gt;<br>
&gt;&gt; Split into two patches?<br>
&gt;&gt;<br>
&gt; Ok.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D=
"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&=
gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 qapi/migration.json | 66 +++++++++++++++++++++---------=
---------------<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 31 insertions(+), 35 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt;&gt; &gt; index 6b49593d2f..5d5649c885 100644<br>
&gt;&gt; &gt; --- a/qapi/migration.json<br>
&gt;&gt; &gt; +++ b/qapi/migration.json<br>
&gt;&gt; &gt; @@ -258,17 +258,17 @@<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0blocked.=C2=A0 Present and non-emp=
ty when migration is blocked.<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0(since 6.0)<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; -# @dirty-limit-throttle-time-per-round: Maximum throttle tim=
e (inmicroseconds) of virtual<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0CPUs each dirty ring fullround, which shows how<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0MigrationCapability dirty-limitaffects the guest<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0during live migration. (since8.1)<br>
&gt;&gt; &gt; -#<br>
&gt;&gt; &gt; -# @dirty-limit-ring-full-time: Estimated average dirty ring =
full time(in microseconds)<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 each dirty ring full round, n=
ote thatthe value equals<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dirty ring memory size divide=
d byaverage dirty page rate<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of virtual CPU, which can be =
used toobserve the average<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory load of virtual CPU in=
directly.Note that zero<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 means guest doesn&#39;t dirty=
 memory (since8.1)<br>
&gt;&gt; &gt; +# @dirty-limit-throttle-time-per-round: Maximum throttle tim=
e<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0(in microseconds) of virtual CPUs each =
dirty ring full round,<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0which shows how MigrationCapability dir=
ty-limit affects the<br>
&gt;&gt;<br>
&gt;&gt; Perhaps &quot;for each ... round&quot;?<br>
&gt;&gt;<br>
&gt;&gt; Remind me, what&#39;s a &quot;dirty ring full round&quot;?<br>
&gt;&gt;<br>
&gt; Every time the x86 PML buffer is filled with gpa, hardware throws an<b=
r>
&gt; exception and<br>
&gt; guest exits to kvm, then to qemu. Qemu will handle the exception with<=
br>
&gt; reaping the<br>
&gt; dirty ring and get the dirty page info, then enter the kvm, empty the =
PML<br>
&gt; buffer and<br>
&gt; enter guests again, i call this &quot;dirty ring full round&quot;, but=
 it seems not<br>
&gt; straightforward,<br>
&gt; please help me describe that,=C2=A0 thanks.<br>
<br>
&quot;x86 PML&quot; is page modification logging, right?<br></blockquote><d=
iv class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif">Yes.</div><div class=3D"gmail_default" style=3D"font-family:&quo=
t;comic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:&quot;comic sans ms&quot;,sans-serif">The dirty ring ful=
l round may be actually imprecise indeed. I&#39;ll try to refactor the</div=
><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot=
;,sans-serif">comment in the next version, hoping to do better.</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding=
-left:1ex">
<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0guest during live migration.=C2=A0 (Sin=
ce 8.1)<br>
&gt;&gt; &gt; +#<br>
&gt;&gt; &gt; +# @dirty-limit-ring-full-time: Estimated average dirty ring =
full<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0time (in microseconds) each dirty ring =
full round. The value<br>
&gt;&gt;<br>
&gt;&gt; Likewise.<br>
&gt;&gt;<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0equals dirty ring memory size divided b=
y average dirty page<br>
&gt;&gt;<br>
&gt;&gt; &quot;the dirty ring memory size divided by the average ...&quot;<=
br>
&gt;&gt;<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0rate of the virtual CPU, which can be u=
sed to observe the<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0average memory load of the virtual CPU =
indirectly. Note that<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0zero means guest doesn&#39;t dirty memo=
ry.=C2=A0 (Since 8.1)<br>
&gt;&gt;<br>
&gt;&gt; Two spaces between sentences for consistency.<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt;=C2=A0 # Since: 0.14<br>
&gt;&gt; &gt;=C2=A0 ##<br>
&gt;&gt; &gt; @@ -519,15 +519,11 @@<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0are present.=C2=A0 &#39;return-pat=
h&#39; capability must be enabled to use<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0it.=C2=A0 (since 8.1)<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; -# @dirty-limit: If enabled, migration will use the dirty-lim=
it algo to<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thro=
ttle down guest instead of auto-converge algo.<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Thro=
ttle algo only works when vCPU&#39;s dirtyrate greater<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0than=
 &#39;vcpu-dirty-limit&#39;, read processes in guest os<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aren=
&#39;t penalized any more, so this algo can improve<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perf=
ormance of vCPU during live migration. This is an<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opti=
onal performance feature and should not affect the<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0corr=
ectness of the existing auto-converge algo.<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(sin=
ce 8.1)<br>
&gt;&gt; &gt; +# @dirty-limit: If enabled, migration will throttle vCPUs as=
 needed to<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0keep their dirty page rate within @vcpu=
-dirty-limit.=C2=A0 This can<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0improve responsiveness of large guests =
during live migration,<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0and can result in more stable read perf=
ormance.=C2=A0 Requires KVM<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0with accelerator property &quot;dirty-r=
ing-size&quot; set.=C2=A0 (Since 8.1)<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt;=C2=A0 # Features:<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; @@ -822,17 +818,17 @@<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0Nodes are mapped to their block de=
vice name if there is one, and<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0to their node name otherwise.=C2=
=A0 (Since 5.2)<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds=
) of dirtylimit during<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0live migration. Should be in t=
he range 1to 1000ms,<br>
&gt;&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0defaults to 1000ms. (Since 8.1=
)<br>
&gt;&gt; &gt; +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds=
) of dirty<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0limit during=C2=A0 live migration. Shou=
ld be in the range 1 to 1000ms,<br>
&gt;&gt;<br>
&gt;&gt; Single space in &quot;during live&quot;, and two space between sen=
tences, please.<br>
&gt;&gt;<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0defaults to 1000ms.=C2=A0 (Since 8.1)<b=
r>
&gt;&gt;<br>
&gt;&gt; I dislike that we mix milli- and microseconds.=C2=A0 Too late to f=
ix, I&#39;m<br>
&gt;&gt; afraid.<br>
&gt;&gt;<br>
&gt;&gt; Remind me, what&#39;t the &quot;periodic time of dirty limit durin=
g live<br>
&gt;&gt; migration&quot;?<br>
&gt;&gt;<br>
&gt; It is the period to calculate the dirty page rate for each vCPU.<br>
&gt; So Qemu will use it to compare with the dirty-limit value.<br>
&gt; If the period is too short, cpu overhead is increasing and if<br>
&gt; it is too long, the result may not be precise. So we make it<br>
&gt; configurable.<br>
<br>
The limited migration knowledge I have wasn&#39;t enough to review the doc<=
br>
part of your QAPI schema patch with reasonable effort and within a<br>
reasonable time.=C2=A0 You had to answer a lot of fairly basic questions.<b=
r>
Thanks for your patience.<br></blockquote><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Not at all, feel fre=
e to comment on the patch set. I&#39;ll try my best to</div><div class=3D"g=
mail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">re=
ply.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,=
204,204);padding-left:1ex">
<br>
Perhaps I should&#39;ve given up and left the docs to the migration<br>
maintainers.<br>
<br>
I believe what I&#39;ve been missing is an overview of the dirty limit<br>
algorithm to throttle guests being live-migrated.<br>
<br>
Could we have that in docs/devel/migration.rst?<br></blockquote><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">No problem, I&#39;ll do that and request for comments in the next versio=
n.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,20=
4,204);padding-left:1ex">
<br>
Apropos migration.rst: not a peep on compression.=C2=A0 Juan, Peter,<br>
Leonardo, should it be covered there?<br>
<br>
[...]<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000006ef8c00601e633ca--

