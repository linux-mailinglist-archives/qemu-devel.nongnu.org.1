Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD37668ED
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 11:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPJYJ-0004A2-P2; Fri, 28 Jul 2023 05:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qPJXw-00047i-M9
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:14:05 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qPJXr-000534-6b
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:14:04 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a426e70575so1269487b6e.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690535515; x=1691140315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GpO5xqW1rQSuk5dRZGcuWJHfIDym0MKiw4QbCXYCzOk=;
 b=eE3GpgaXeau9t//PTLRR0kXy+/smzFjPFjDjXW4W94qgV2yR6SI0XTg36fY37svHBk
 kDMx9O4EHH2Nq0zuwn3FZLtZxHWHpGECyX3Gnq1eudtZZOvGVGPwP0VhBOTpCLDyLl9n
 1YC2BA/fr2lU+ig7xvvtB69Rfo9G51owvLiSSu/87tUEEaXLE2fkg6Y97UpvAmaJtNhs
 LgnSQWDbi+0A8L06kAY8TvkrU8R+3zl73PMwTmbE2llZGDgBsES6NhXwJvi8hz8loj8j
 UIy3fP4eZLWQHkYbasolPkG5XJeAT/mDgLnIijlZ5+KJIUJt2sbzar6UVvTJaj3KXY7b
 V0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690535515; x=1691140315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GpO5xqW1rQSuk5dRZGcuWJHfIDym0MKiw4QbCXYCzOk=;
 b=GqKvpLT6/FR2PssWSngZR0E//g0RYJKE0lcxgECZ6p05zqfk6d+v7k7aA9WkrvQHRZ
 IJPru9pDmU2tD2WjxXRd3Ojm/8hWrJK5w5ftKpMRpIpQ2CkNxakpVWoXyjBKmqvatrfL
 6xOpiR8xZ5e1IxdOD0GR8v82Z3KvQyHt8ujCp7yOcTw8V9DOlZrHdsfIWeBQ/uFYwr8o
 ZxBjGT8OszH7iKKwnSEKQvOv85S38LgK/hCuYIJNRTKxPwpjHhpcgRPf6BgnJ+qqUwbx
 7hnPkQvDVFFbx5sVOyWMAGYs+NpyeQ2s29/odAr53z8/nomEtUu5Wx+hL6VD/6tY9yi9
 t6CQ==
X-Gm-Message-State: ABy/qLao7G/cY4UhyzrNLAZ3makSl3mPLHf6OPcU8d8v4jlFibvkytG0
 w7wFg/fAVCGUEOF5opMvObbt3eEKl+OwogwHGaTAeg==
X-Google-Smtp-Source: APBJJlGrCxqR35LXLpRWDO85Buw7qo+5CMoOv7xQre1DqvGMO6x8MXO6LG5Saq6YpK5PVUtXMXj67AZTCNJpCEzRGE8=
X-Received: by 2002:a05:6808:1708:b0:3a4:8a41:c69c with SMTP id
 bc8-20020a056808170800b003a48a41c69cmr2116693oib.13.1690535515053; Fri, 28
 Jul 2023 02:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <169040075240.21656.5651891935411754498-1@git.sr.ht>
 <87y1j0lblv.fsf@pond.sub.org>
In-Reply-To: <87y1j0lblv.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 28 Jul 2023 17:11:38 +0800
Message-ID: <CAK9dgmaWfHyPDKneJVEo2TDehZ9PX0a-YLSp2x+Z=kYeJohmOQ@mail.gmail.com>
Subject: Re: [PATCH QEMU 1/2] qapi: Reformat and craft the migration doc
 comments
To: Markus Armbruster <armbru@redhat.com>
Cc: "~hyman" <hyman@git.sr.ht>, qemu-devel@nongnu.org, 
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000daf76106018878dd"
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x231.google.com
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

--000000000000daf76106018878dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 3:49=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> ~hyman <hyman@git.sr.ht> writes:
>
> > From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> >
> > Reformat migration doc comments to conform to current conventions
> > as commit a937b6aa739 (qapi: Reformat doc comments to conform to
> > current conventions).
> >
> > Also, craft the dirty-limit capability comment.
>
> Split into two patches?
>
Ok.

>
> > Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> > ---
> >  qapi/migration.json | 66 +++++++++++++++++++++------------------------
> >  1 file changed, 31 insertions(+), 35 deletions(-)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 6b49593d2f..5d5649c885 100644
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
>
> Perhaps "for each ... round"?
>
> Remind me, what's a "dirty ring full round"?
>
Every time the x86 PML buffer is filled with gpa, hardware throws an
exception and
guest exits to kvm, then to qemu. Qemu will handle the exception with
reaping the
dirty ring and get the dirty page info, then enter the kvm, empty the PML
buffer and
enter guests again, i call this "dirty ring full round", but it seems not
straightforward,
please help me describe that,  thanks.


> > +#     guest during live migration.  (Since 8.1)
> > +#
> > +# @dirty-limit-ring-full-time: Estimated average dirty ring full
> > +#     time (in microseconds) each dirty ring full round. The value
>
> Likewise.
>
> > +#     equals dirty ring memory size divided by average dirty page
>
> "the dirty ring memory size divided by the average ..."
>
> > +#     rate of the virtual CPU, which can be used to observe the
> > +#     average memory load of the virtual CPU indirectly. Note that
> > +#     zero means guest doesn't dirty memory.  (Since 8.1)
>
> Two spaces between sentences for consistency.
>
> >  #
> >  # Since: 0.14
> >  ##
> > @@ -519,15 +519,11 @@
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
> > +# @dirty-limit: If enabled, migration will throttle vCPUs as needed to
> > +#     keep their dirty page rate within @vcpu-dirty-limit.  This can
> > +#     improve responsiveness of large guests during live migration,
> > +#     and can result in more stable read performance.  Requires KVM
> > +#     with accelerator property "dirty-ring-size" set.  (Since 8.1)
> >  #
> >  # Features:
> >  #
> > @@ -822,17 +818,17 @@
> >  #     Nodes are mapped to their block device name if there is one, and
> >  #     to their node name otherwise.  (Since 5.2)
> >  #
> > -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> limit during
> > -#                             live migration. Should be in the range 1
> to 1000ms,
> > -#                             defaults to 1000ms. (Since 8.1)
> > +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> > +#     limit during  live migration. Should be in the range 1 to 1000ms=
,
>
> Single space in "during live", and two space between sentences, please.
>
> > +#     defaults to 1000ms.  (Since 8.1)
>
> I dislike that we mix milli- and microseconds.  Too late to fix, I'm
> afraid.
>
> Remind me, what't the "periodic time of dirty limit during live
> migration"?
>
It is the period to calculate the dirty page rate for each vCPU.
So Qemu will use it to compare with the dirty-limit value.
If the period is too short, cpu overhead is increasing and if
it is too long, the result may not be precise. So we make it
configurable.

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
> > @@ -988,17 +984,17 @@
> >  #     Nodes are mapped to their block device name if there is one, and
> >  #     to their node name otherwise.  (Since 5.2)
> >  #
> > -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> limit during
> > -#                             live migration. Should be in the range 1
> to 1000ms,
> > -#                             defaults to 1000ms. (Since 8.1)
> > +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> > +#     limit during live migration. Should be in the range 1 to 1000ms,
>
> Two spaces between sentences.
>
> > +#     defaults to 1000ms.  (Since 8.1)
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
> > @@ -1191,17 +1187,17 @@
> >  #     Nodes are mapped to their block device name if there is one, and
> >  #     to their node name otherwise.  (Since 5.2)
> >  #
> > -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> limit during
> > -#                             live migration. Should be in the range 1
> to 1000ms,
> > -#                             defaults to 1000ms. (Since 8.1)
> > +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> > +#     limit during live migration. Should be in the range 1 to 1000ms,
>
> Two spaces between sentences.
>
> > +#     defaults to 1000ms.  (Since 8.1)
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
>

--=20
Best regards

--000000000000daf76106018878dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 28, 20=
23 at 3:49=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">~hyman &lt=
;<a href=3D"mailto:hyman@git.sr.ht" target=3D"_blank">hyman@git.sr.ht</a>&g=
t; writes:<br>
<br>
&gt; From: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D"mailto:yong.huang=
@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;<br>
&gt; Reformat migration doc comments to conform to current conventions<br>
&gt; as commit a937b6aa739 (qapi: Reformat doc comments to conform to<br>
&gt; current conventions).<br>
&gt;<br>
&gt; Also, craft the dirty-limit capability comment.<br>
<br>
Split into two patches?<br></blockquote><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Ok.</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D"mailto:y=
ong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/migration.json | 66 +++++++++++++++++++++------------------=
------<br>
&gt;=C2=A0 1 file changed, 31 insertions(+), 35 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index 6b49593d2f..5d5649c885 100644<br>
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
<br>
Perhaps &quot;for each ... round&quot;?<br>
<br>
Remind me, what&#39;s a &quot;dirty ring full round&quot;?<br></blockquote>=
<div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif">Every time the x86 PML buffer is filled with gpa, hardware thr=
ows an exception and</div><div class=3D"gmail_default" style=3D"font-family=
:&quot;comic sans ms&quot;,sans-serif">guest exits to kvm, then to qemu. Qe=
mu will handle the exception with reaping the=C2=A0</div><div class=3D"gmai=
l_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">dirty=
 ring and get the dirty page info, then enter the kvm, empty the PML buffer=
 and</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic san=
s ms&quot;,sans-serif">enter guests again, i call this &quot;dirty ring ful=
l round&quot;, but it seems not straightforward,</div><div class=3D"gmail_d=
efault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">please h=
elp me describe that, =C2=A0thanks.</div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left=
:1ex">
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0guest during live migration.=C2=A0 (Since 8.1)<b=
r>
&gt; +#<br>
&gt; +# @dirty-limit-ring-full-time: Estimated average dirty ring full<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0time (in microseconds) each dirty ring full roun=
d. The value<br>
<br>
Likewise.<br>
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0equals dirty ring memory size divided by average=
 dirty page<br>
<br>
&quot;the dirty ring memory size divided by the average ...&quot;<br>
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0rate of the virtual CPU, which can be used to ob=
serve the<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0average memory load of the virtual CPU indirectl=
y. Note that<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0zero means guest doesn&#39;t dirty memory.=C2=A0=
 (Since 8.1)<br>
<br>
Two spaces between sentences for consistency.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 ##<br>
&gt; @@ -519,15 +519,11 @@<br>
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
&gt; +# @dirty-limit: If enabled, migration will throttle vCPUs as needed t=
o<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0keep their dirty page rate within @vcpu-dirty-li=
mit.=C2=A0 This can<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0improve responsiveness of large guests during li=
ve migration,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0and can result in more stable read performance.=
=C2=A0 Requires KVM<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0with accelerator property &quot;dirty-ring-size&=
quot; set.=C2=A0 (Since 8.1)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Features:<br>
&gt;=C2=A0 #<br>
&gt; @@ -822,17 +818,17 @@<br>
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
&gt; +#=C2=A0 =C2=A0 =C2=A0limit during=C2=A0 live migration. Should be in =
the range 1 to 1000ms,<br>
<br>
Single space in &quot;during live&quot;, and two space between sentences, p=
lease.<br>
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0defaults to 1000ms.=C2=A0 (Since 8.1)<br>
<br>
I dislike that we mix milli- and microseconds.=C2=A0 Too late to fix, I&#39=
;m<br>
afraid.<br>
<br>
Remind me, what&#39;t the &quot;periodic time of dirty limit during live<br=
>
migration&quot;?<br></blockquote><div class=3D"gmail_default" style=3D"font=
-family:&quot;comic sans ms&quot;,sans-serif">It is the period to calculate=
 the dirty page rate for each vCPU.</div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">So Qemu will use it t=
o compare with the dirty-limit value.</div><div class=3D"gmail_default" sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif">If the period is to=
o short, cpu overhead is increasing and if</div><div class=3D"gmail_default=
" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">it is too long=
, the result may not be precise. So we make it</div><div class=3D"gmail_def=
ault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">configurab=
le.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb=
(204,204,204);padding-left:1ex">
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
&gt; @@ -988,17 +984,17 @@<br>
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
nge 1 to 1000ms,<br>
<br>
Two spaces between sentences.<br>
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0defaults to 1000ms.=C2=A0 (Since 8.1)<br>
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
&gt; @@ -1191,17 +1187,17 @@<br>
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
nge 1 to 1000ms,<br>
<br>
Two spaces between sentences.<br>
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0defaults to 1000ms.=C2=A0 (Since 8.1)<br>
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
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000daf76106018878dd--

