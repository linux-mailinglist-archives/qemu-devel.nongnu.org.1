Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5309176C19F
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 02:50:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR02p-00033x-Tm; Tue, 01 Aug 2023 20:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qR02m-00033o-To
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 20:48:52 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qR02j-0007Wt-N6
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 20:48:52 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a3373211a1so4132331b6e.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 17:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690937206; x=1691542006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PXzEa2zXoxvVs3grq3giN8mrCSQUKE4HikZlrAUTT+M=;
 b=dkgOlG/RSF02ayjXcR4QH+WJXuilmOq8TFS+/0XXFnpdlx//3rnTrEEH83P2xwuo91
 lbx793aNfqjrpaX1dGJz/RMyVBekUkT+dNebPKq/Y8ulcEACfIDUZhsboK3DDYhPboop
 TOjXcoGTbtbKVUHJOuvINVn6gE8uJ3lIO5IX1ZW0TKL1NpzKUWc2vL61msISNMYQ98k/
 kBRgnpZ5hLEXU7kmYNqrMr2qGDr1rJav6sEp9GSWGPIiLkuaypYXdnNI9cKO5jAwSu9B
 be/PYhzl+D4QKEPy5hVOmFZ/nIMEnipmfvxKdzUJSoZ/hUoRiommW/lhROd2o9tr0UeV
 Gb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690937206; x=1691542006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PXzEa2zXoxvVs3grq3giN8mrCSQUKE4HikZlrAUTT+M=;
 b=ArUf9eKQ6GqkcmqdLEHqlzwMagmPrXUtvrg+T/Dxj64NUETBwA5j3GSppJGVPakEIy
 aZwdGSDIeVMnKk22i56hb/sII08JaJVGTMP1BsNgwWcahq4JLw2SEXtnu1E/KpVJkw+/
 BNsNrFRC5mOLRDa1q/yGlEMS8T0puoYakSBqFBKexUbmDTwBnmeoLBjBp3T2H0Qzyq6P
 XqwiRZW+7AGBON4DsfxPAiUGV0BdvHMOGDZobF1VTdrh0mXjX/gYS43tccgqULSzmwpP
 2CuZT/2plCEl6dt2oALs+N3O7pwvjAaMac3UhYeqsGmisQ4F9U3UnNa4qSJP1NSJWoaB
 J8Tw==
X-Gm-Message-State: ABy/qLYZIMC/kS2avhuUc5Mna6e/mPKX0GAQOljjNrKf54X3VEYcHQP1
 okcH6OFLoej0EgzC/DrxGvpRDU6RCn7A9Pb7qvISeA==
X-Google-Smtp-Source: APBJJlHVS6m49lhpEpP914NTjXGfkfFd1uUCq4alWt9vtqOsQ1+4aeBUd3mkFcyWoZJhbI3ItxUTEPvq37UHhHcO/zc=
X-Received: by 2002:aca:280f:0:b0:3a3:7fd6:aa63 with SMTP id
 15-20020aca280f000000b003a37fd6aa63mr12881422oix.29.1690937205671; Tue, 01
 Aug 2023 17:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <169073570563.19893.2928364761104733482-1@git.sr.ht>
 <87mszb0wm4.fsf@pond.sub.org>
In-Reply-To: <87mszb0wm4.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 2 Aug 2023 08:46:29 +0800
Message-ID: <CAK9dgmYuQKGvUAt=_xYY_a-9Fjo1Je3XS5U=Gw2hTe8hqwUeLA@mail.gmail.com>
Subject: Re: [PATCH QEMU v3 1/3] qapi: Reformat the dirty-limit migration doc
 comments
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007b60900601e5ffab"
Received-SPF: none client-ip=2607:f8b0:4864:20::234;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x234.google.com
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

--0000000000007b60900601e5ffab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 1, 2023 at 8:34=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> ~hyman <hyman@git.sr.ht> writes:
>
> > From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> >
> > Reformat the dirty-limit migration doc comments to conform
> > to current conventions as commit a937b6aa739 (qapi: Reformat
> > doc comments to conform to current conventions).
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Unexpected S-o-b.  Accident?
>
Yes, I'll fix that

>
> > Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> > ---
> >  qapi/migration.json | 69 ++++++++++++++++++++++-----------------------
> >  1 file changed, 34 insertions(+), 35 deletions(-)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 6b49593d2f..a74ade4d72 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -258,17 +258,17 @@
> >  #     blocked.  Present and non-empty when migration is blocked.
> >  #     (since 6.0)
> >  #
> > -# @dirty-limit-throttle-time-per-round: Maximum throttle time (in
> microseconds) of virtual
> > -#                                       CPUs each dirty ring full
> round, which shows how
> > -#                                       MigrationCapability dirty-limi=
t
> affects the guest
> > -#                                       during live migration. (since
> 8.1)
> > -#
> > -# @dirty-limit-ring-full-time: Estimated average dirty ring full time
> (in microseconds)
> > -#                              each dirty ring full round, note that
> the value equals
> > -#                              dirty ring memory size divided by
> average dirty page rate
> > -#                              of virtual CPU, which can be used to
> observe the average
> > -#                              memory load of virtual CPU indirectly.
> Note that zero
> > -#                              means guest doesn't dirty memory (since
> 8.1)
> > +# @dirty-limit-throttle-time-per-round: Maximum throttle time
> > +#     (in microseconds) of virtual CPUs each dirty ring full round,
> > +#     which shows how MigrationCapability dirty-limit affects the
> > +#     guest during live migration.  (Since 8.1)
> > +#
> > +# @dirty-limit-ring-full-time: Estimated average dirty ring full
> > +#     time (in microseconds) for each dirty ring full round. The
>
> Two spaces between sentences for consistency.
>
> > +#     value equals the dirty ring memory size divided by the average
> > +#     dirty page rate of the virtual CPU, which can be used to
> > +#     observe the average memory load of the virtual CPU indirectly.
> > +#     Note that zero means guest doesn't dirty memory.  (Since 8.1)
> >  #
> >  # Since: 0.14
> >  ##
> > @@ -519,15 +519,14 @@
> >  #     are present.  'return-path' capability must be enabled to use
> >  #     it.  (since 8.1)
> >  #
> > -# @dirty-limit: If enabled, migration will use the dirty-limit algo to
> > -#               throttle down guest instead of auto-converge algo.
> > -#               Throttle algo only works when vCPU's dirtyrate greater
> > -#               than 'vcpu-dirty-limit', read processes in guest os
> > -#               aren't penalized any more, so this algo can improve
> > -#               performance of vCPU during live migration. This is an
> > -#               optional performance feature and should not affect the
> > -#               correctness of the existing auto-converge algo.
> > -#               (since 8.1)
> > +# @dirty-limit: If enabled, migration will use the dirty-limit
> > +#     algorithim to throttle down guest instead of auto-converge
> > +#     algorithim. Throttle algorithim only works when vCPU's dirtyrate
> > +#     greater than 'vcpu-dirty-limit', read processes in guest os
> > +#     aren't penalized any more, so this algorithim can improve
> > +#     performance of vCPU during live migration. This is an optional
> > +#     performance feature and should not affect the correctness of the
> > +#     existing auto-converge algorithim.  (Since 8.1)
> >  #
> >  # Features:
> >  #
> > @@ -822,17 +821,17 @@
> >  #     Nodes are mapped to their block device name if there is one, and
> >  #     to their node name otherwise.  (Since 5.2)
> >  #
> > -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> limit during
> > -#                             live migration. Should be in the range 1
> to 1000ms,
> > -#                             defaults to 1000ms. (Since 8.1)
> > +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> > +#     limit during live migration. Should be in the range 1 to 1000ms.
> > +#     Defaults to 1000ms.  (Since 8.1)
>
> Likewise.
>
> >  #
> >  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
> > -#                    Defaults to 1. (Since 8.1)
> > +#     Defaults to 1.  (Since 8.1)
> >  #
> >  # Features:
> >  #
> >  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-perio=
d
> > -#            are experimental.
> > +#     are experimental.
> >  #
> >  # Since: 2.4
> >  ##
> > @@ -988,17 +987,17 @@
> >  #     Nodes are mapped to their block device name if there is one, and
> >  #     to their node name otherwise.  (Since 5.2)
> >  #
> > -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> limit during
> > -#                             live migration. Should be in the range 1
> to 1000ms,
> > -#                             defaults to 1000ms. (Since 8.1)
> > +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> > +#     limit during live migration. Should be in the range 1 to 1000ms.
> > +#     Defaults to 1000ms.  (Since 8.1)
>
> Likewise.
>
> >  #
> >  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
> > -#                    Defaults to 1. (Since 8.1)
> > +#     Defaults to 1.  (Since 8.1)
> >  #
> >  # Features:
> >  #
> >  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-perio=
d
> > -#            are experimental.
> > +#     are experimental.
> >  #
> >  # TODO: either fuse back into MigrationParameters, or make
> >  #     MigrationParameters members mandatory
> > @@ -1191,17 +1190,17 @@
> >  #     Nodes are mapped to their block device name if there is one, and
> >  #     to their node name otherwise.  (Since 5.2)
> >  #
> > -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> limit during
> > -#                             live migration. Should be in the range 1
> to 1000ms,
> > -#                             defaults to 1000ms. (Since 8.1)
> > +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> > +#     limit during live migration. Should be in the range 1 to 1000ms.
> > +#     Defaults to 1000ms.  (Since 8.1)
>
> Likewise.
>
> >  #
> >  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
> > -#                    Defaults to 1. (Since 8.1)
> > +#     Defaults to 1.  (Since 8.1)
> >  #
> >  # Features:
> >  #
> >  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-perio=
d
> > -#            are experimental.
> > +#     are experimental.
> >  #
> >  # Since: 2.4
> >  ##
>
> No need for another respin, I'm happy to tidy up spacing in my tree.
>


--=20
Best regards

--0000000000007b60900601e5ffab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 1, 202=
3 at 8:34=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-s=
tyle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">~hyman &lt;=
<a href=3D"mailto:hyman@git.sr.ht" target=3D"_blank">hyman@git.sr.ht</a>&gt=
; writes:<br>
<br>
&gt; From: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D"mailto:yong.huang=
@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;<br>
&gt; Reformat the dirty-limit migration doc comments to conform<br>
&gt; to current conventions as commit a937b6aa739 (qapi: Reformat<br>
&gt; doc comments to conform to current conventions).<br>
&gt;<br>
&gt; Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.c=
om" target=3D"_blank">armbru@redhat.com</a>&gt;<br>
<br>
Unexpected S-o-b.=C2=A0 Accident?<br></blockquote><div class=3D"gmail_defau=
lt" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yes, I&#39;l=
l fix that</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D"mailto:y=
ong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/migration.json | 69 ++++++++++++++++++++++-----------------=
------<br>
&gt;=C2=A0 1 file changed, 34 insertions(+), 35 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index 6b49593d2f..a74ade4d72 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
&gt; @@ -258,17 +258,17 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0blocked.=C2=A0 Present and non-empty when m=
igration is blocked.<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0(since 6.0)<br>
&gt;=C2=A0 #<br>
&gt; -# @dirty-limit-throttle-time-per-round: Maximum throttle time (in mic=
roseconds) of virtual<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CP=
Us each dirty ring full round, which shows how<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mi=
grationCapability dirty-limit affects the guest<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0du=
ring live migration. (since 8.1)<br>
&gt; -#<br>
&gt; -# @dirty-limit-ring-full-time: Estimated average dirty ring full time=
 (in microseconds)<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 each dirty ring full round, note tha=
t the value equals<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dirty ring memory size divided by av=
erage dirty page rate<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of virtual CPU, which can be used to=
 observe the average<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory load of virtual CPU indirectl=
y. Note that zero<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 means guest doesn&#39;t dirty memory=
 (since 8.1)<br>
&gt; +# @dirty-limit-throttle-time-per-round: Maximum throttle time<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0(in microseconds) of virtual CPUs each dirty rin=
g full round,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0which shows how MigrationCapability dirty-limit =
affects the<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0guest during live migration.=C2=A0 (Since 8.1)<b=
r>
&gt; +#<br>
&gt; +# @dirty-limit-ring-full-time: Estimated average dirty ring full<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0time (in microseconds) for each dirty ring full =
round. The<br>
<br>
Two spaces between sentences for consistency.<br>
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0value equals the dirty ring memory size divided =
by the average<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0dirty page rate of the virtual CPU, which can be=
 used to<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0observe the average memory load of the virtual C=
PU indirectly.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Note that zero means guest doesn&#39;t dirty mem=
ory.=C2=A0 (Since 8.1)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 ##<br>
&gt; @@ -519,15 +519,14 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0are present.=C2=A0 &#39;return-path&#39; ca=
pability must be enabled to use<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0it.=C2=A0 (since 8.1)<br>
&gt;=C2=A0 #<br>
&gt; -# @dirty-limit: If enabled, migration will use the dirty-limit algo t=
o<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0throttle down=
 guest instead of auto-converge algo.<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Throttle algo=
 only works when vCPU&#39;s dirtyrate greater<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0than &#39;vcp=
u-dirty-limit&#39;, read processes in guest os<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aren&#39;t pe=
nalized any more, so this algo can improve<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0performance o=
f vCPU during live migration. This is an<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optional perf=
ormance feature and should not affect the<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0correctness o=
f the existing auto-converge algo.<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(since 8.1)<b=
r>
&gt; +# @dirty-limit: If enabled, migration will use the dirty-limit<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0algorithim to throttle down guest instead of aut=
o-converge<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0algorithim. Throttle algorithim only works when =
vCPU&#39;s dirtyrate<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0greater than &#39;vcpu-dirty-limit&#39;, read pr=
ocesses in guest os<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0aren&#39;t penalized any more, so this algorithi=
m can improve<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0performance of vCPU during live migration. This =
is an optional<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0performance feature and should not affect the co=
rrectness of the<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0existing auto-converge algorithim.=C2=A0 (Since =
8.1)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Features:<br>
&gt;=C2=A0 #<br>
&gt; @@ -822,17 +821,17 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0Nodes are mapped to their block device name=
 if there is one, and<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0to their node name otherwise.=C2=A0 (Since =
5.2)<br>
&gt;=C2=A0 #<br>
&gt; -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirt=
y limit during<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0live migration. Should be in the rang=
e 1 to 1000ms,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0defaults to 1000ms. (Since 8.1)<br>
&gt; +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirt=
y<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0limit during live migration. Should be in the ra=
nge 1 to 1000ms.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Defaults to 1000ms.=C2=A0 (Since 8.1)<br>
<br>
Likewise.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migratio=
n.<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Defaults to 1. (Since 8.1)<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Defaults to 1.=C2=A0 (Since 8.1)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Features:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit=
-period<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 are experimental.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0are experimental.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.4<br>
&gt;=C2=A0 ##<br>
&gt; @@ -988,17 +987,17 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0Nodes are mapped to their block device name=
 if there is one, and<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0to their node name otherwise.=C2=A0 (Since =
5.2)<br>
&gt;=C2=A0 #<br>
&gt; -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirt=
y limit during<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0live migration. Should be in the rang=
e 1 to 1000ms,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0defaults to 1000ms. (Since 8.1)<br>
&gt; +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirt=
y<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0limit during live migration. Should be in the ra=
nge 1 to 1000ms.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Defaults to 1000ms.=C2=A0 (Since 8.1)<br>
<br>
Likewise.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migratio=
n.<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Defaults to 1. (Since 8.1)<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Defaults to 1.=C2=A0 (Since 8.1)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Features:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit=
-period<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 are experimental.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0are experimental.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # TODO: either fuse back into MigrationParameters, or make<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0MigrationParameters members mandatory<br>
&gt; @@ -1191,17 +1190,17 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0Nodes are mapped to their block device name=
 if there is one, and<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0to their node name otherwise.=C2=A0 (Since =
5.2)<br>
&gt;=C2=A0 #<br>
&gt; -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirt=
y limit during<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0live migration. Should be in the rang=
e 1 to 1000ms,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0defaults to 1000ms. (Since 8.1)<br>
&gt; +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirt=
y<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0limit during live migration. Should be in the ra=
nge 1 to 1000ms.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Defaults to 1000ms.=C2=A0 (Since 8.1)<br>
<br>
Likewise.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migratio=
n.<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Defaults to 1. (Since 8.1)<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Defaults to 1.=C2=A0 (Since 8.1)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Features:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit=
-period<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 are experimental.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0are experimental.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.4<br>
&gt;=C2=A0 ##<br>
<br>
No need for another respin, I&#39;m happy to tidy up spacing in my tree.<br=
>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000007b60900601e5ffab--

