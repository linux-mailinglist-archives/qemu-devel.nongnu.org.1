Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BE8758DA6
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 08:19:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM0V3-00039R-Og; Wed, 19 Jul 2023 02:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qM0Uo-00036s-D8
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 02:17:11 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qM0Uk-0001Mc-LQ
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 02:17:10 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-26304be177fso3582213a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 23:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1689747302; x=1692339302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GyyBMOErd6EeuTwPQC8uB82OXwLJxFVedS46dVL9Z2Y=;
 b=zj0sriF8ZXf2AlYLED2gFBfYPZfKhgKjgXgYPTWT3/RFJlQjfzOeMW5skhoIrcvDVy
 H+1M98e7i2DTygBJ90i6sTYenCNHYDnPKOV4mFnXI9EwNFNfa78IddgxGavZKE59i9o8
 9RhnmTJhKD/XJHAoFL2pwwTgAOj+wpwFbhHvyXVKVmvw7CM7fpNHTWGZLnZgoPjxq47W
 AJziWwoDCfvuHJuyGjPpW6G9XbK8N0VjPH2SfMlQoNyJK1MXzlkjecDjW4tYzjwBqA00
 dhSN19avbR2MjgcbhM9U8vdvUWsa+lxO2JtzCyOvuQzAHL2szl6/bvtka7i3dCmt8fR8
 el4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689747302; x=1692339302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GyyBMOErd6EeuTwPQC8uB82OXwLJxFVedS46dVL9Z2Y=;
 b=OuSq6GSlZp48KyJ9V/qLHPJyVidfa//W6JggSsRLuhFPBPJFPdQebPozB7DOGvyQVw
 FmsZmL/+Qd601LDi+CsN56lS6ND7DogNSndVFVlpEFcnTpj4fsEetjG4t0+9vOWvDsnD
 ZJuwgqTpOtE8/00kPvgGWtFEr7qJcYTJuzGGP8fpkFPJOKhK7X+a01jFwEiY9rfze0J5
 5syRpgIq0Aec+qyx9MrFO/qINig1JH5+b/OoNnmH4ScqXXSwW3X671XSiH+8AtddhqHk
 cCSnxvGUVQbCbPYij3EwFZSunPyVikSlzKDI573ZeYwQIC5gLpvI8bqHGTNjP2KDs8Qg
 pDrw==
X-Gm-Message-State: ABy/qLaBLsxCAHQufGtHRDgESId9B+9MHyBNEj0SGPntjoVMkPndbt9Z
 xINFwbCFoyqTcAZ52aKGr+NxGBqJMaWMzFW17fzPmg==
X-Google-Smtp-Source: APBJJlHRdufVsWd1BmU5Y+6BqEMKjjt49NpbUsNdkYyLOzRsXl3HlmluV2pE+Ja5sFy8IdeomCc7wy/MpmGQnA9WUew=
X-Received: by 2002:a17:90a:7444:b0:259:10a8:2389 with SMTP id
 o4-20020a17090a744400b0025910a82389mr12826424pjk.35.1689747301945; Tue, 18
 Jul 2023 23:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <168870305868.29142.5121604177475325995-4@git.sr.ht>
 <875y6oj80i.fsf@pond.sub.org>
 <CAK9dgmZ73F2qrD-iM-EBSiARRmwGPPorsLdt8NqmkOSyYaRCVw@mail.gmail.com>
 <87zg3tjxb2.fsf@pond.sub.org>
 <CAK9dgmYyxZC_6CPZcgudXVpRXKcdd6kXTsYLhZ_PTiOh=c4-2g@mail.gmail.com>
 <87a5vsh3p3.fsf@pond.sub.org>
In-Reply-To: <87a5vsh3p3.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 19 Jul 2023 14:14:45 +0800
Message-ID: <CAK9dgmZeJL0M9Lc4S6o5R=GvtyXmKvBeHmTBbcfPiYE7w=uTXQ@mail.gmail.com>
Subject: Re: [PATCH QEMU v8 4/9] migration: Introduce dirty-limit capability
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b16ac50600d0f389"
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1033.google.com
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

--000000000000b16ac50600d0f389
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 1:26=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Yong Huang <yong.huang@smartx.com> writes:
>
> > On Tue, Jul 18, 2023 at 7:04=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> Yong Huang <yong.huang@smartx.com> writes:
> >>
> >> > On Thu, Jul 13, 2023 at 8:44=E2=80=AFPM Markus Armbruster <armbru@re=
dhat.com>
> >> wrote:
> >> >
> >> >> ~hyman <hyman@git.sr.ht> writes:
> >> >>
> >> >> > From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> >> >> >
> >> >> > Introduce migration dirty-limit capability, which can
> >> >> > be turned on before live migration and limit dirty
> >> >> > page rate durty live migration.
> >> >> >
> >> >> > Introduce migrate_dirty_limit function to help check
> >> >> > if dirty-limit capability enabled during live migration.
> >> >> >
> >> >> > Meanwhile, refactor vcpu_dirty_rate_stat_collect
> >> >> > so that period can be configured instead of hardcoded.
> >> >> >
> >> >> > dirty-limit capability is kind of like auto-converge
> >> >> > but using dirty limit instead of traditional cpu-throttle
> >> >> > to throttle guest down. To enable this feature, turn on
> >> >> > the dirty-limit capability before live migration using
> >> >> > migrate-set-capabilities, and set the parameters
> >> >> > "x-vcpu-dirty-limit-period", "vcpu-dirty-limit" suitably
> >> >> > to speed up convergence.
> >> >> >
> >> >> > Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx=
.com>
> >> >> > Acked-by: Peter Xu <peterx@redhat.com>
> >> >> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> >> >>
> >> >> [...]
> >> >>
> >> >> > diff --git a/qapi/migration.json b/qapi/migration.json
> >> >> > index e43371955a..031832cde5 100644
> >> >> > --- a/qapi/migration.json
> >> >> > +++ b/qapi/migration.json
> >> >> > @@ -497,6 +497,15 @@
> >> >> >  #     are present.  'return-path' capability must be enabled to
> use
> >> >> >  #     it.  (since 8.1)
> >> >> >  #
> >> >> > +# @dirty-limit: If enabled, migration will use the dirty-limit
> >> >> > +#     algorithm to throttle down guest instead of auto-converge
> >> >> > +#     algorithm. This algorithm only works when vCPU's dirtyrate
> >> >>
> >> >> Two spaces after sentence-ending punctuation, please.
> >> >>
> >> >> "dirty rate" with a space, because that's how we spell it elsewhere=
.
> >> >>
> >> >> > +#     greater than 'vcpu-dirty-limit', read processes in guest o=
s
> >> >> > +#     aren't penalized any more, so the algorithm can improve
> >> >> > +#     performance of vCPU during live migration. This is an
> optional
> >> >> > +#     performance feature and should not affect the correctness =
of
> >> the
> >> >> > +#     existing auto-converge algorithm. (since 8.1)
> >> >> > +#
> >> >>
> >> >> I'm still confused.
> >> >>
> >> >> The text suggests there are two separate algorithms "to throttle do=
wn
> >> >> guest": "auto converge" and "dirty limit", and we get to pick one.
> >> >> Correct?
> >> >>
> >> > Yes, indeed !
> >> >
> >> >>
> >> >> If it is correct, then the last sentence feels redundant: picking
> >> >> another algorithm can't affect the algorithm we're *not* using.  Wh=
at
> >> >> are you trying to express here?
> >> >>
> >> > What i want to express is that the new algorithm implementation does
> >> > not affect the original algorithm, leaving it in the comments seems
> >> > redundant indeed.  I'll drop this in the next version.
> >>
> >> Works for me.
> >>
> >> >> When do we use "auto converge", and when do we use "dirty limit"?
> >> >>
> >> >> What does the user really need to know about these algorithms?
> Enough
> >> >> to pick one, I guess.  That means advantages and disadvantages of t=
he
> >> >> two algorithms.  Which are?
> >> >
> >> > 1. The implementation of dirty-limit is based on dirty-ring, which i=
s
> >> > qualified
> >> >    to big systems with huge memories and can improve huge guest VM
> >> >     responsiveness remarkably during live migration. As a consequenc=
e,
> >> > dirty-limit
> >> >     is recommended on platforms with huge guest VMs as is the way wi=
th
> >> > dirty-ring.
> >> > 2. dirty-limit convergence algorithm does not affect the
> "read-process"
> >> in
> >> > guest
> >> >    VM, so guest VM gains the equal read performance nearly as it run=
s
> on
> >> > host
> >> >    during the live migration. As a result, dirty-limit is recommende=
d
> if
> >> > the guest
> >> >     VM requires a stable read performance.
> >> > The above explanation is about the recommendation of dirty-limit,
> please
> >> > review,
> >> > if it's ok, i'll place it in the comment of the dirty-limit
> capability.
> >>
> >> Yes, please.  But before that, I have still more questions.  "This
> >> algorithm only works when vCPU's dirtyrate greater than
> >> 'vcpu-dirty-limit'" is a condition: "FEATURE only works when CONDITION=
".
> >>
> > I failed to express my meaning again : ( .  "Throttle algo only works
> when
> > vCPU's  dirtyrate greater than 'vcpu-dirty-limit' " should change to
> > "vCPU throttle only works when vCPU's dirtyrate greater than
> > 'vcpu-dirty-limit'".
> > Not the whole "algo" !
>
> Let me paraphrase to make sure I got it...  The vCPU is throttled as
> needed to keep its dirty rate within the limit set with
> set-vcpu-dirty-limit.  Correct?
>
Yes. Actually set with the internal function qmp_set_vcpu_dirty_limit.

And a parameter called "vcpu-dirty-limit"  of migration provided by
dirty-limit
aims to be the argument of qmp_set_vcpu_dirty_limit.


> What happens when I enable the dirty limit convergence algorithm without
> setting a limit with set-vcpu-dirty-limit?
>
dirty-limit will use the default value which is defined
in migration/options.c:
#define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */

So the default of the dirty-limit is 1MB/s.

>
> >> What happens when the condition is not met?  How can the user ensure t=
he
> >> condition is met?
> >>
> >> [...]
> >>
> >>
>
>

--=20
Best regards

--000000000000b16ac50600d0f389
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 19, 20=
23 at 1:26=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Yong Huang=
 &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@=
smartx.com</a>&gt; writes:<br>
<br>
&gt; On Tue, Jul 18, 2023 at 7:04=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"=
_blank">yong.huang@smartx.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Thu, Jul 13, 2023 at 8:44=E2=80=AFPM Markus Armbruster &lt=
;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</=
a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; ~hyman &lt;<a href=3D"mailto:hyman@git.sr.ht" target=3D"_=
blank">hyman@git.sr.ht</a>&gt; writes:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; From: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D=
"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&=
gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Introduce migration dirty-limit capability, which ca=
n<br>
&gt;&gt; &gt;&gt; &gt; be turned on before live migration and limit dirty<b=
r>
&gt;&gt; &gt;&gt; &gt; page rate durty live migration.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Introduce migrate_dirty_limit function to help check=
<br>
&gt;&gt; &gt;&gt; &gt; if dirty-limit capability enabled during live migrat=
ion.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Meanwhile, refactor vcpu_dirty_rate_stat_collect<br>
&gt;&gt; &gt;&gt; &gt; so that period can be configured instead of hardcode=
d.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; dirty-limit capability is kind of like auto-converge=
<br>
&gt;&gt; &gt;&gt; &gt; but using dirty limit instead of traditional cpu-thr=
ottle<br>
&gt;&gt; &gt;&gt; &gt; to throttle guest down. To enable this feature, turn=
 on<br>
&gt;&gt; &gt;&gt; &gt; the dirty-limit capability before live migration usi=
ng<br>
&gt;&gt; &gt;&gt; &gt; migrate-set-capabilities, and set the parameters<br>
&gt;&gt; &gt;&gt; &gt; &quot;x-vcpu-dirty-limit-period&quot;, &quot;vcpu-di=
rty-limit&quot; suitably<br>
&gt;&gt; &gt;&gt; &gt; to speed up convergence.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<=
a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx=
.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt; Acked-by: Peter Xu &lt;<a href=3D"mailto:peterx@redh=
at.com" target=3D"_blank">peterx@redhat.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt; Reviewed-by: Juan Quintela &lt;<a href=3D"mailto:qui=
ntela@redhat.com" target=3D"_blank">quintela@redhat.com</a>&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; [...]<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; diff --git a/qapi/migration.json b/qapi/migration.js=
on<br>
&gt;&gt; &gt;&gt; &gt; index e43371955a..031832cde5 100644<br>
&gt;&gt; &gt;&gt; &gt; --- a/qapi/migration.json<br>
&gt;&gt; &gt;&gt; &gt; +++ b/qapi/migration.json<br>
&gt;&gt; &gt;&gt; &gt; @@ -497,6 +497,15 @@<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0are present.=C2=A0 &#39;r=
eturn-path&#39; capability must be enabled to use<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0it.=C2=A0 (since 8.1)<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt;&gt; &gt; +# @dirty-limit: If enabled, migration will use the =
dirty-limit<br>
&gt;&gt; &gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0algorithm to throttle down gue=
st instead of auto-converge<br>
&gt;&gt; &gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0algorithm. This algorithm only=
 works when vCPU&#39;s dirtyrate<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Two spaces after sentence-ending punctuation, please.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &quot;dirty rate&quot; with a space, because that&#39;s h=
ow we spell it elsewhere.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0greater than &#39;vcpu-dirty-l=
imit&#39;, read processes in guest os<br>
&gt;&gt; &gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0aren&#39;t penalized any more,=
 so the algorithm can improve<br>
&gt;&gt; &gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0performance of vCPU during liv=
e migration. This is an optional<br>
&gt;&gt; &gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0performance feature and should=
 not affect the correctness of<br>
&gt;&gt; the<br>
&gt;&gt; &gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0existing auto-converge algorit=
hm. (since 8.1)<br>
&gt;&gt; &gt;&gt; &gt; +#<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I&#39;m still confused.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; The text suggests there are two separate algorithms &quot=
;to throttle down<br>
&gt;&gt; &gt;&gt; guest&quot;: &quot;auto converge&quot; and &quot;dirty li=
mit&quot;, and we get to pick one.<br>
&gt;&gt; &gt;&gt; Correct?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt; Yes, indeed !<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; If it is correct, then the last sentence feels redundant:=
 picking<br>
&gt;&gt; &gt;&gt; another algorithm can&#39;t affect the algorithm we&#39;r=
e *not* using.=C2=A0 What<br>
&gt;&gt; &gt;&gt; are you trying to express here?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt; What i want to express is that the new algorithm implementati=
on does<br>
&gt;&gt; &gt; not affect the original algorithm, leaving it in the comments=
 seems<br>
&gt;&gt; &gt; redundant indeed.=C2=A0 I&#39;ll drop this in the next versio=
n.<br>
&gt;&gt;<br>
&gt;&gt; Works for me.<br>
&gt;&gt;<br>
&gt;&gt; &gt;&gt; When do we use &quot;auto converge&quot;, and when do we =
use &quot;dirty limit&quot;?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; What does the user really need to know about these algori=
thms?=C2=A0 Enough<br>
&gt;&gt; &gt;&gt; to pick one, I guess.=C2=A0 That means advantages and dis=
advantages of the<br>
&gt;&gt; &gt;&gt; two algorithms.=C2=A0 Which are?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 1. The implementation of dirty-limit is based on dirty-ring, =
which is<br>
&gt;&gt; &gt; qualified<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 to big systems with huge memories and can improv=
e huge guest VM<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0responsiveness remarkably during live migr=
ation. As a consequence,<br>
&gt;&gt; &gt; dirty-limit<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0is recommended on platforms with huge gues=
t VMs as is the way with<br>
&gt;&gt; &gt; dirty-ring.<br>
&gt;&gt; &gt; 2. dirty-limit convergence algorithm does not affect the &quo=
t;read-process&quot;<br>
&gt;&gt; in<br>
&gt;&gt; &gt; guest<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 VM, so guest VM gains the equal read performance=
 nearly as it runs on<br>
&gt;&gt; &gt; host<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 during the live migration. As a result, dirty-li=
mit is recommended if<br>
&gt;&gt; &gt; the guest<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0VM requires a stable read performance.<br>
&gt;&gt; &gt; The above explanation is about the recommendation of dirty-li=
mit, please<br>
&gt;&gt; &gt; review,<br>
&gt;&gt; &gt; if it&#39;s ok, i&#39;ll place it in the comment of the dirty=
-limit capability.<br>
&gt;&gt;<br>
&gt;&gt; Yes, please.=C2=A0 But before that, I have still more questions.=
=C2=A0 &quot;This<br>
&gt;&gt; algorithm only works when vCPU&#39;s dirtyrate greater than<br>
&gt;&gt; &#39;vcpu-dirty-limit&#39;&quot; is a condition: &quot;FEATURE onl=
y works when CONDITION&quot;.<br>
&gt;&gt;<br>
&gt; I failed to express my meaning again : ( .=C2=A0 &quot;Throttle algo o=
nly works when<br>
&gt; vCPU&#39;s=C2=A0 dirtyrate greater than &#39;vcpu-dirty-limit&#39; &qu=
ot; should change to<br>
&gt; &quot;vCPU throttle only works when vCPU&#39;s dirtyrate greater than<=
br>
&gt; &#39;vcpu-dirty-limit&#39;&quot;.<br>
&gt; Not the whole &quot;algo&quot; !<br>
<br>
Let me paraphrase to make sure I got it...=C2=A0 The vCPU is throttled as<b=
r>
needed to keep its dirty rate within the limit set with<br>
set-vcpu-dirty-limit.=C2=A0 Correct?<br></blockquote><div class=3D"gmail_de=
fault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yes. Actu=
ally set with the internal function qmp_set_vcpu_dirty_limit.</div><div cla=
ss=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif"><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;comi=
c sans ms&quot;,sans-serif">And a parameter called &quot;vcpu-dirty-limit&q=
uot; =C2=A0of migration provided by dirty-limit</div><div class=3D"gmail_de=
fault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">aims to b=
e the argument of=C2=A0qmp_set_vcpu_dirty_limit.</div><div class=3D"gmail_d=
efault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204)=
;padding-left:1ex">
<br>
What happens when I enable the dirty limit convergence algorithm without<br=
>
setting a limit with set-vcpu-dirty-limit?<br></blockquote><div class=3D"gm=
ail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">dir=
ty-limit will use the default value which is defined in=C2=A0migration/opti=
ons.c:</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif">#define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 /* MB/s */<br></di=
v><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quo=
t;,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif">So the default of the dirty-limit is =
1MB/s.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:=
rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; What happens when the condition is not met?=C2=A0 How can the user=
 ensure the<br>
&gt;&gt; condition is met?<br>
&gt;&gt;<br>
&gt;&gt; [...]<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000b16ac50600d0f389--

