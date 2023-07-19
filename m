Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B0B7591BD
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3ZF-0007NT-RA; Wed, 19 Jul 2023 05:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qM3Yx-0007BS-4S
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:33:39 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qM3Ys-0004bJ-1H
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:33:38 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3486eeb5c43so34830125ab.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1689759087; x=1692351087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G2NEs9Fua67pxU9uSok/ze5Z+99RmSOpGz9w8rbAAfM=;
 b=5LrJFx3SQdWUEpMNdhET1koD9TF/tbDlKYNnU8gB4nDsJ2KIezKAOqM74FVv0t445W
 ZeVamhARlefS3xuGCJsmjk0m1be+9L031QwMGTEeBdrws5M0d9Wy2OdH0Tjin6QyIQzq
 1/Eh2dodK2xXTHNLnplIua/zw4SdURwFx2LpfXlH9P/Kjp6ahRtZZu69mPxgs+lIn2oG
 IDkzogV+H9nir5AxQ+Ue9apBJLeozFqAQY7GFLMpI3kPyYisYaM9knApY7YUnY+JJz/l
 rgz3ILUxntjtSTdY4SK4a1X9Flzdv/Gl+pg5Wt5jYh4RHkvAWjSVtl7nCStXnfEOlqu3
 Qx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689759087; x=1692351087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G2NEs9Fua67pxU9uSok/ze5Z+99RmSOpGz9w8rbAAfM=;
 b=XfTKm4YPw+uq4RRq3bjsJ/BnBcw5uai6FPJaV8HHEJcGeLECTgvBFEddMyiFTIYhDy
 DfYLRwlB9cZDpCVMESvct7xdASu5goZAqdwVqwAWlGmx+4TKtoU6aNdDm0oSObSub55f
 q6ceNekIAfg/rnyNbp4f27tSXX/Sws/RIz7RZ1J/8ymqX8xFb30cV5cCr0NfF0/5qWch
 EvzvRAAyUmbi45yItTKBUL3WvNgcqNJXUJ5xT/eIuirYPTYtk48aPYiZBtUmhznAZU0I
 R+NeEiQoQed7Ny34JRveLUCoDzDWwaxqmCGthNEPD+1NUymJegS59vpTD1dHIc6F37Wp
 BWzg==
X-Gm-Message-State: ABy/qLYRX1aAsdSURY78N8IJXaFiJtK0GnRGF8yhWUzs4dz+6BRYWsTt
 Ji3ZJ12GsY4yDG/NW8mnVSfYZJ5nfq7IrL3+EeHgmA==
X-Google-Smtp-Source: APBJJlGKiFyvzpceZRKGCpW6daIVcDP+in63uXEWOqwmUYU28UAiN2rWlvsWyf004AEJWNeqhYIDJJwvP+0185co5wI=
X-Received: by 2002:a05:6e02:1566:b0:345:d0c1:12b5 with SMTP id
 k6-20020a056e02156600b00345d0c112b5mr2487426ilu.26.1689759087724; Wed, 19 Jul
 2023 02:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <168870305868.29142.5121604177475325995-4@git.sr.ht>
 <875y6oj80i.fsf@pond.sub.org>
 <CAK9dgmZ73F2qrD-iM-EBSiARRmwGPPorsLdt8NqmkOSyYaRCVw@mail.gmail.com>
 <87zg3tjxb2.fsf@pond.sub.org>
 <CAK9dgmYyxZC_6CPZcgudXVpRXKcdd6kXTsYLhZ_PTiOh=c4-2g@mail.gmail.com>
 <87a5vsh3p3.fsf@pond.sub.org>
 <CAK9dgmZeJL0M9Lc4S6o5R=GvtyXmKvBeHmTBbcfPiYE7w=uTXQ@mail.gmail.com>
 <87bkg8ff2s.fsf@pond.sub.org>
In-Reply-To: <87bkg8ff2s.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 19 Jul 2023 17:31:11 +0800
Message-ID: <CAK9dgmZVun5ifzV3G0JnP1EULcH3qar9Hq-Mm_riziMmcefkMQ@mail.gmail.com>
Subject: Re: [PATCH QEMU v8 4/9] migration: Introduce dirty-limit capability
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002e24920600d3b277"
Received-SPF: none client-ip=2607:f8b0:4864:20::12b;
 envelope-from=yong.huang@smartx.com; helo=mail-il1-x12b.google.com
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

--0000000000002e24920600d3b277
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 5:03=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Yong Huang <yong.huang@smartx.com> writes:
>
> > On Wed, Jul 19, 2023 at 1:26=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> Yong Huang <yong.huang@smartx.com> writes:
> >>
> >> > On Tue, Jul 18, 2023 at 7:04=E2=80=AFPM Markus Armbruster <armbru@re=
dhat.com>
> >> wrote:
> >> >
> >> >> Yong Huang <yong.huang@smartx.com> writes:
> >> >>
> >> >> > On Thu, Jul 13, 2023 at 8:44=E2=80=AFPM Markus Armbruster <
> armbru@redhat.com> wrote:
>
> [...]
>
> >> >> Yes, please.  But before that, I have still more questions.  "This
> >> >> algorithm only works when vCPU's dirtyrate greater than
> >> >> 'vcpu-dirty-limit'" is a condition: "FEATURE only works when
> CONDITION".
> >> >>
> >> > I failed to express my meaning again : ( .  "Throttle algo only work=
s
> when
> >> > vCPU's  dirtyrate greater than 'vcpu-dirty-limit' " should change to
> >> > "vCPU throttle only works when vCPU's dirtyrate greater than
> >> > 'vcpu-dirty-limit'".
> >> > Not the whole "algo" !
> >>
> >> Let me paraphrase to make sure I got it...  The vCPU is throttled as
> >> needed to keep its dirty rate within the limit set with
> >> set-vcpu-dirty-limit.  Correct?
> >>
> > Yes. Actually set with the internal function qmp_set_vcpu_dirty_limit.
> >
> > And a parameter called "vcpu-dirty-limit"  of migration provided by
> > dirty-limit
> > aims to be the argument of qmp_set_vcpu_dirty_limit.
>
> Alright, let me try to craft some documentation:
>
>   # @dirty-limit: If enabled, migration will throttle vCPUs as needed to
>   #     keep their dirty page rate within @vcpu-dirty-limit.  This can
>   #     improve responsiveness of large guests during live migration,
>   #     and can result in more stable read performance.  Requires KVM
>   #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>
> What do you think?
>
I feel ok, it seems clear and concise.
I'll use this comment in the next version. Thanks a lot. :)

>
> >> What happens when I enable the dirty limit convergence algorithm witho=
ut
> >> setting a limit with set-vcpu-dirty-limit?
> >>
> > dirty-limit will use the default value which is defined
> > in migration/options.c:
> > #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
> >
> > So the default of the dirty-limit is 1MB/s.
>
> Is this default documented in the QAPI schema?  Hmm, looks like it isn't
> before this series, but PATCH 3 fixes it.  Okay.
>
> >> >> What happens when the condition is not met?  How can the user ensur=
e
> the
> >> >> condition is met?
> >> >>
> >> >> [...]
>
>

--=20
Best regards

--0000000000002e24920600d3b277
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 19, 20=
23 at 5:03=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Yong Huang=
 &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@=
smartx.com</a>&gt; writes:<br>
<br>
&gt; On Wed, Jul 19, 2023 at 1:26=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"=
_blank">yong.huang@smartx.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Tue, Jul 18, 2023 at 7:04=E2=80=AFPM Markus Armbruster &lt=
;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</=
a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" t=
arget=3D"_blank">yong.huang@smartx.com</a>&gt; writes:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; On Thu, Jul 13, 2023 at 8:44=E2=80=AFPM Markus Armbr=
uster &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@red=
hat.com</a>&gt; wrote:<br>
<br>
[...]<br>
<br>
&gt;&gt; &gt;&gt; Yes, please.=C2=A0 But before that, I have still more que=
stions.=C2=A0 &quot;This<br>
&gt;&gt; &gt;&gt; algorithm only works when vCPU&#39;s dirtyrate greater th=
an<br>
&gt;&gt; &gt;&gt; &#39;vcpu-dirty-limit&#39;&quot; is a condition: &quot;FE=
ATURE only works when CONDITION&quot;.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt; I failed to express my meaning again : ( .=C2=A0 &quot;Thrott=
le algo only works when<br>
&gt;&gt; &gt; vCPU&#39;s=C2=A0 dirtyrate greater than &#39;vcpu-dirty-limit=
&#39; &quot; should change to<br>
&gt;&gt; &gt; &quot;vCPU throttle only works when vCPU&#39;s dirtyrate grea=
ter than<br>
&gt;&gt; &gt; &#39;vcpu-dirty-limit&#39;&quot;.<br>
&gt;&gt; &gt; Not the whole &quot;algo&quot; !<br>
&gt;&gt;<br>
&gt;&gt; Let me paraphrase to make sure I got it...=C2=A0 The vCPU is throt=
tled as<br>
&gt;&gt; needed to keep its dirty rate within the limit set with<br>
&gt;&gt; set-vcpu-dirty-limit.=C2=A0 Correct?<br>
&gt;&gt;<br>
&gt; Yes. Actually set with the internal function qmp_set_vcpu_dirty_limit.=
<br>
&gt;<br>
&gt; And a parameter called &quot;vcpu-dirty-limit&quot;=C2=A0 of migration=
 provided by<br>
&gt; dirty-limit<br>
&gt; aims to be the argument of qmp_set_vcpu_dirty_limit.<br>
<br>
Alright, let me try to craft some documentation:<br>
<br>
=C2=A0 # @dirty-limit: If enabled, migration will throttle vCPUs as needed =
to<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0keep their dirty page rate within @vcpu-dirty-l=
imit.=C2=A0 This can<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0improve responsiveness of large guests during l=
ive migration,<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0and can result in more stable read performance.=
=C2=A0 Requires KVM<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0with accelerator property &quot;dirty-ring-size=
&quot; set.=C2=A0 (Since 8.1)<br>
<br>
What do you think?<br></blockquote><div class=3D"gmail_default" style=3D"fo=
nt-family:&quot;comic sans ms&quot;,sans-serif">I feel ok, it seems clear a=
nd concise.=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:&q=
uot;comic sans ms&quot;,sans-serif">I&#39;ll use this comment in the next v=
ersion. Thanks a lot. :)</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border=
-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; What happens when I enable the dirty limit convergence algorithm w=
ithout<br>
&gt;&gt; setting a limit with set-vcpu-dirty-limit?<br>
&gt;&gt;<br>
&gt; dirty-limit will use the default value which is defined<br>
&gt; in migration/options.c:<br>
&gt; #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0/* MB/s */<br>
&gt;<br>
&gt; So the default of the dirty-limit is 1MB/s.<br>
<br>
Is this default documented in the QAPI schema?=C2=A0 Hmm, looks like it isn=
&#39;t<br>
before this series, but PATCH 3 fixes it.=C2=A0 Okay.<br>
<br>
&gt;&gt; &gt;&gt; What happens when the condition is not met?=C2=A0 How can=
 the user ensure the<br>
&gt;&gt; &gt;&gt; condition is met?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; [...]<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000002e24920600d3b277--

