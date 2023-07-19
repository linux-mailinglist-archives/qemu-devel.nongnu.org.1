Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD98F758C6E
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 06:14:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLyYI-0004hm-Bx; Wed, 19 Jul 2023 00:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qLyYD-0004ha-Lu
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:12:34 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qLyYA-0002nM-DY
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:12:33 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55b0e7efb1cso3728706a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 21:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1689739825; x=1692331825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O6K5fX3OjRRYgFKlEncKJrxJkPy+sf8umA1OGHh6XM4=;
 b=hQWsvNLwGOQftZrlY5NV2eO6r+ZF9vVcE8VQiZX/kddJ+fwiit2+0JS+F0uiFLF8cf
 zw1K9GmC+nv+UmseM4PFDYaj2fmfpf/R55ENhDQb54L2tAloynlIfnfrrN9CcvItMx3A
 mGxkefQHsmqMIeXh7erw4Ij6VQos133KP1KePrP4F8jNUlnNEWJQPvjHl+Ckr4ma/UMB
 rbZEJK13Wi7Lc2Ul/uOFTE1UjmZZwDbDxOH1LFmmR2o/2da8kZcn2gbiVYoDMpkPIXXW
 eD9bQuyzRtQ6P94zBRvVtBM8JsrcByvwpSQBfH358yuzebOkIN7FaC0T7wLKIE9tPmu8
 Pr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689739825; x=1692331825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6K5fX3OjRRYgFKlEncKJrxJkPy+sf8umA1OGHh6XM4=;
 b=idZbbns2LsLbkBIUto++SzW2HQHGYexK5+QRAx/skeUf+PGtdTQQHkULCeTzxFlOap
 wWDC/YdmC3D6ndluHrO19wH9f6ANvdOivHHTLwvbFBI0xTJ+yP0JDDQgaii4/zH2OEZe
 ZPetPkob4J5WrnLHjSvad7S7pErlKI0OHvk7Hr08f771/ssplBplSPwTP5ieYE5WUmsR
 9uP/4bYqeNJHUEwsn0Ftfyf4W1lA0UVE3LdKP+Lle0H5SiUeWDbpqw4GATzu0sM2hyDj
 F4tOEpir2QbTkzeouuNnbJPj3kndB8W8tf52pGM28Oib4XmIKbGDaL9/Y+hyDk3Pwfvs
 lX8w==
X-Gm-Message-State: ABy/qLbX5/K+/41rskUaT71MAxDBy1CDFVXdAO37KA/1VgJ6qV59FSEZ
 WEP1iMG2xBTcxhPKtLs4bsg/jOveyzYCivy4wpZkfQ==
X-Google-Smtp-Source: APBJJlHkzpta2J8MfxMeqrZVzF9Qp6cWif0voDILIu1uQk9Xrq6VMVvFUeYIL7gm46MfBNFzXg4LidMFL/LIjFXMsZQ=
X-Received: by 2002:a17:90b:1c0e:b0:25d:eca9:1621 with SMTP id
 oc14-20020a17090b1c0e00b0025deca91621mr13853816pjb.6.1689739825274; Tue, 18
 Jul 2023 21:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <168870305868.29142.5121604177475325995-4@git.sr.ht>
 <875y6oj80i.fsf@pond.sub.org>
 <CAK9dgmZ73F2qrD-iM-EBSiARRmwGPPorsLdt8NqmkOSyYaRCVw@mail.gmail.com>
 <87zg3tjxb2.fsf@pond.sub.org>
In-Reply-To: <87zg3tjxb2.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 19 Jul 2023 12:10:09 +0800
Message-ID: <CAK9dgmYyxZC_6CPZcgudXVpRXKcdd6kXTsYLhZ_PTiOh=c4-2g@mail.gmail.com>
Subject: Re: [PATCH QEMU v8 4/9] migration: Introduce dirty-limit capability
To: Markus Armbruster <armbru@redhat.com>
Cc: "~hyman" <hyman@git.sr.ht>, qemu-devel <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000c76d90600cf3678"
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52b.google.com
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

--0000000000000c76d90600cf3678
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 7:04=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Yong Huang <yong.huang@smartx.com> writes:
>
> > On Thu, Jul 13, 2023 at 8:44=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> ~hyman <hyman@git.sr.ht> writes:
> >>
> >> > From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> >> >
> >> > Introduce migration dirty-limit capability, which can
> >> > be turned on before live migration and limit dirty
> >> > page rate durty live migration.
> >> >
> >> > Introduce migrate_dirty_limit function to help check
> >> > if dirty-limit capability enabled during live migration.
> >> >
> >> > Meanwhile, refactor vcpu_dirty_rate_stat_collect
> >> > so that period can be configured instead of hardcoded.
> >> >
> >> > dirty-limit capability is kind of like auto-converge
> >> > but using dirty limit instead of traditional cpu-throttle
> >> > to throttle guest down. To enable this feature, turn on
> >> > the dirty-limit capability before live migration using
> >> > migrate-set-capabilities, and set the parameters
> >> > "x-vcpu-dirty-limit-period", "vcpu-dirty-limit" suitably
> >> > to speed up convergence.
> >> >
> >> > Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.co=
m>
> >> > Acked-by: Peter Xu <peterx@redhat.com>
> >> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> >>
> >> [...]
> >>
> >> > diff --git a/qapi/migration.json b/qapi/migration.json
> >> > index e43371955a..031832cde5 100644
> >> > --- a/qapi/migration.json
> >> > +++ b/qapi/migration.json
> >> > @@ -497,6 +497,15 @@
> >> >  #     are present.  'return-path' capability must be enabled to use
> >> >  #     it.  (since 8.1)
> >> >  #
> >> > +# @dirty-limit: If enabled, migration will use the dirty-limit
> >> > +#     algorithm to throttle down guest instead of auto-converge
> >> > +#     algorithm. This algorithm only works when vCPU's dirtyrate
> >>
> >> Two spaces after sentence-ending punctuation, please.
> >>
> >> "dirty rate" with a space, because that's how we spell it elsewhere.
> >>
> >> > +#     greater than 'vcpu-dirty-limit', read processes in guest os
> >> > +#     aren't penalized any more, so the algorithm can improve
> >> > +#     performance of vCPU during live migration. This is an optiona=
l
> >> > +#     performance feature and should not affect the correctness of
> the
> >> > +#     existing auto-converge algorithm. (since 8.1)
> >> > +#
> >>
> >> I'm still confused.
> >>
> >> The text suggests there are two separate algorithms "to throttle down
> >> guest": "auto converge" and "dirty limit", and we get to pick one.
> >> Correct?
> >>
> > Yes, indeed !
> >
> >>
> >> If it is correct, then the last sentence feels redundant: picking
> >> another algorithm can't affect the algorithm we're *not* using.  What
> >> are you trying to express here?
> >>
> > What i want to express is that the new algorithm implementation does
> > not affect the original algorithm, leaving it in the comments seems
> > redundant indeed.  I'll drop this in the next version.
>
> Works for me.
>
> >> When do we use "auto converge", and when do we use "dirty limit"?
> >>
> >> What does the user really need to know about these algorithms?  Enough
> >> to pick one, I guess.  That means advantages and disadvantages of the
> >> two algorithms.  Which are?
> >
> > 1. The implementation of dirty-limit is based on dirty-ring, which is
> > qualified
> >    to big systems with huge memories and can improve huge guest VM
> >     responsiveness remarkably during live migration. As a consequence,
> > dirty-limit
> >     is recommended on platforms with huge guest VMs as is the way with
> > dirty-ring.
> > 2. dirty-limit convergence algorithm does not affect the "read-process"
> in
> > guest
> >    VM, so guest VM gains the equal read performance nearly as it runs o=
n
> > host
> >    during the live migration. As a result, dirty-limit is recommended i=
f
> > the guest
> >     VM requires a stable read performance.
> > The above explanation is about the recommendation of dirty-limit, pleas=
e
> > review,
> > if it's ok, i'll place it in the comment of the dirty-limit capability.
>
> Yes, please.  But before that, I have still more questions.  "This
> algorithm only works when vCPU's dirtyrate greater than
> 'vcpu-dirty-limit'" is a condition: "FEATURE only works when CONDITION".
>
I failed to express my meaning again : ( .  "Throttle algo only works when
vCPU's  dirtyrate greater than 'vcpu-dirty-limit' " should change to
"vCPU throttle only works when vCPU's dirtyrate greater than
'vcpu-dirty-limit'".
Not the whole "algo" !

> What happens when the condition is not met?  How can the user ensure the
> condition is met?
>
> [...]
>
>

--=20
Best regards

--0000000000000c76d90600cf3678
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 18, 20=
23 at 7:04=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Yong Huang=
 &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@=
smartx.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Jul 13, 2023 at 8:44=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; ~hyman &lt;<a href=3D"mailto:hyman@git.sr.ht" target=3D"_blank">hy=
man@git.sr.ht</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; From: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D"mailto:y=
ong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Introduce migration dirty-limit capability, which can<br>
&gt;&gt; &gt; be turned on before live migration and limit dirty<br>
&gt;&gt; &gt; page rate durty live migration.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Introduce migrate_dirty_limit function to help check<br>
&gt;&gt; &gt; if dirty-limit capability enabled during live migration.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Meanwhile, refactor vcpu_dirty_rate_stat_collect<br>
&gt;&gt; &gt; so that period can be configured instead of hardcoded.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; dirty-limit capability is kind of like auto-converge<br>
&gt;&gt; &gt; but using dirty limit instead of traditional cpu-throttle<br>
&gt;&gt; &gt; to throttle guest down. To enable this feature, turn on<br>
&gt;&gt; &gt; the dirty-limit capability before live migration using<br>
&gt;&gt; &gt; migrate-set-capabilities, and set the parameters<br>
&gt;&gt; &gt; &quot;x-vcpu-dirty-limit-period&quot;, &quot;vcpu-dirty-limit=
&quot; suitably<br>
&gt;&gt; &gt; to speed up convergence.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D=
"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&=
gt;<br>
&gt;&gt; &gt; Acked-by: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" t=
arget=3D"_blank">peterx@redhat.com</a>&gt;<br>
&gt;&gt; &gt; Reviewed-by: Juan Quintela &lt;<a href=3D"mailto:quintela@red=
hat.com" target=3D"_blank">quintela@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; [...]<br>
&gt;&gt;<br>
&gt;&gt; &gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt;&gt; &gt; index e43371955a..031832cde5 100644<br>
&gt;&gt; &gt; --- a/qapi/migration.json<br>
&gt;&gt; &gt; +++ b/qapi/migration.json<br>
&gt;&gt; &gt; @@ -497,6 +497,15 @@<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0are present.=C2=A0 &#39;return-pat=
h&#39; capability must be enabled to use<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0it.=C2=A0 (since 8.1)<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; +# @dirty-limit: If enabled, migration will use the dirty-lim=
it<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0algorithm to throttle down guest instea=
d of auto-converge<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0algorithm. This algorithm only works wh=
en vCPU&#39;s dirtyrate<br>
&gt;&gt;<br>
&gt;&gt; Two spaces after sentence-ending punctuation, please.<br>
&gt;&gt;<br>
&gt;&gt; &quot;dirty rate&quot; with a space, because that&#39;s how we spe=
ll it elsewhere.<br>
&gt;&gt;<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0greater than &#39;vcpu-dirty-limit&#39;=
, read processes in guest os<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0aren&#39;t penalized any more, so the a=
lgorithm can improve<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0performance of vCPU during live migrati=
on. This is an optional<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0performance feature and should not affe=
ct the correctness of the<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0existing auto-converge algorithm. (sinc=
e 8.1)<br>
&gt;&gt; &gt; +#<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m still confused.<br>
&gt;&gt;<br>
&gt;&gt; The text suggests there are two separate algorithms &quot;to throt=
tle down<br>
&gt;&gt; guest&quot;: &quot;auto converge&quot; and &quot;dirty limit&quot;=
, and we get to pick one.<br>
&gt;&gt; Correct?<br>
&gt;&gt;<br>
&gt; Yes, indeed !<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; If it is correct, then the last sentence feels redundant: picking<=
br>
&gt;&gt; another algorithm can&#39;t affect the algorithm we&#39;re *not* u=
sing.=C2=A0 What<br>
&gt;&gt; are you trying to express here?<br>
&gt;&gt;<br>
&gt; What i want to express is that the new algorithm implementation does<b=
r>
&gt; not affect the original algorithm, leaving it in the comments seems<br=
>
&gt; redundant indeed.=C2=A0 I&#39;ll drop this in the next version.<br>
<br>
Works for me.<br>
<br>
&gt;&gt; When do we use &quot;auto converge&quot;, and when do we use &quot=
;dirty limit&quot;?<br>
&gt;&gt;<br>
&gt;&gt; What does the user really need to know about these algorithms?=C2=
=A0 Enough<br>
&gt;&gt; to pick one, I guess.=C2=A0 That means advantages and disadvantage=
s of the<br>
&gt;&gt; two algorithms.=C2=A0 Which are?<br>
&gt;<br>
&gt; 1. The implementation of dirty-limit is based on dirty-ring, which is<=
br>
&gt; qualified<br>
&gt;=C2=A0 =C2=A0 to big systems with huge memories and can improve huge gu=
est VM<br>
&gt;=C2=A0 =C2=A0 =C2=A0responsiveness remarkably during live migration. As=
 a consequence,<br>
&gt; dirty-limit<br>
&gt;=C2=A0 =C2=A0 =C2=A0is recommended on platforms with huge guest VMs as =
is the way with<br>
&gt; dirty-ring.<br>
&gt; 2. dirty-limit convergence algorithm does not affect the &quot;read-pr=
ocess&quot; in<br>
&gt; guest<br>
&gt;=C2=A0 =C2=A0 VM, so guest VM gains the equal read performance nearly a=
s it runs on<br>
&gt; host<br>
&gt;=C2=A0 =C2=A0 during the live migration. As a result, dirty-limit is re=
commended if<br>
&gt; the guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0VM requires a stable read performance.<br>
&gt; The above explanation is about the recommendation of dirty-limit, plea=
se<br>
&gt; review,<br>
&gt; if it&#39;s ok, i&#39;ll place it in the comment of the dirty-limit ca=
pability.<br>
<br>
Yes, please.=C2=A0 But before that, I have still more questions.=C2=A0 &quo=
t;This<br>
algorithm only works when vCPU&#39;s dirtyrate greater than<br>
&#39;vcpu-dirty-limit&#39;&quot; is a condition: &quot;FEATURE only works w=
hen CONDITION&quot;.<br></blockquote><div class=3D"gmail_default" style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif">I failed to express my me=
aning again : ( . =C2=A0&quot;Throttle algo only works when=C2=A0</div><div=
 class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif">vCPU&#39;s =C2=A0dirtyrate greater=C2=A0than &#39;vcpu-dirty-limit=
&#39; &quot; should change to=C2=A0</div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">&quot;vCPU throttle o=
nly works when vCPU&#39;s=C2=A0dirtyrate greater=C2=A0than &#39;vcpu-dirty-=
limit&#39;&quot;.</div><div class=3D"gmail_default" style=3D"font-family:&q=
uot;comic sans ms&quot;,sans-serif">Not the whole &quot;algo&quot; !</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pa=
dding-left:1ex">
What happens when the condition is not met?=C2=A0 How can the user ensure t=
he<br>
condition is met?<br>
<br>
[...]<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000000c76d90600cf3678--

