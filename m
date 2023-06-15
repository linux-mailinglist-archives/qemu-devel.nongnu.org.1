Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F256A731A16
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 15:35:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9n7N-0008Oj-2j; Thu, 15 Jun 2023 09:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1q9jyi-0006st-CA
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:13:24 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1q9jyf-0004f6-87
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:13:20 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-39a505b901dso4682320b6e.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1686823994; x=1689415994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PaSqevC+d57LNLHXFi5Bt7ZRuwojxy8DW7Pqvd0xai4=;
 b=PCbiojSwCulbxY90kV3DkWBK2LT9CqnxmuhuPvWEhOLBgc3+GlYWXrDQs0CfWSdfk5
 GFwDtI35BHggbNBZrW2H09/6XIZbEJJh+od3t5VtXT3yo6+hwhelNCYS9oRnwZlxY8Co
 ReZEIr4b9HPiSWvW/o7S9uHbF78ZZs9O1/jQET3r8e1ahK+Cyt5bVgFiXnxwiSH0/5ry
 0kZJwII/pH58oEXPtLrRijL/ftDALsqaYjqk5CNdhVruzQw4nR0Cuz5gr1AFO4uSxY7c
 wVsK94i0PWFghDsDW9m18H9SKeKqY8zBs3Cu2md2LvnzOF5jtTmwi6BrO8S2MHllE6XK
 qAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686823994; x=1689415994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PaSqevC+d57LNLHXFi5Bt7ZRuwojxy8DW7Pqvd0xai4=;
 b=a31xcPMBxqDCyeNz3/Q4ULzQYwC/aCozDTujRxxInmYiDa/C8rqsZhuu+MWQVWfAts
 Ieguy+cwaJxKzaKh4wVZd9q7gHB0gu8zI6V++iTwAvyPSBaOcIsi1sSLmihFkwDeBQEr
 g/99ImnlicudAJE500os478u7KEupnTFlpoAAWrNkJB5bQcUM9TpLnpnjL+RNlmTEe41
 PWSUZLtY+D5Xd8nPG1ZiT4yfMXR6KhlQtvxzoaF8/8XkU6Ip6YK4Jw+9t89PdP9Ph7lO
 L4HGF6L4DEKCLgmuj1IYBnVCwG4yWllfejFpYPlUWcJXc0hVwb9as4uJxuiqRlXU4B5k
 5sFQ==
X-Gm-Message-State: AC+VfDxmkBpCgUTPbZDN3cYiZO6G9qXeNk48JlZF1waNjk19oGpVGBp2
 iJYWTtaPlOs3weBt9kP8Xy3Q+N5sU3LCPJD4epUqUg==
X-Google-Smtp-Source: ACHHUZ7lWSJw+yH38vP2wGgUfP9ddMkj3e392aEmgpdmmIC7r54TAYCwNxCGJo+vMF6hKQcPNzU3Bhf0MZ6Ok50x7fQ=
X-Received: by 2002:a05:6808:1405:b0:398:5893:f0c5 with SMTP id
 w5-20020a056808140500b003985893f0c5mr17038132oiv.37.1686823994136; Thu, 15
 Jun 2023 03:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <168618975839.6361.17407633874747688653-6@git.sr.ht>
 <87ttvbckv3.fsf@secure.mitica>
In-Reply-To: <87ttvbckv3.fsf@secure.mitica>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 15 Jun 2023 18:12:57 +0800
Message-ID: <CAK9dgmZ4NhVOY5uxXbNVpgHT9HcW5kbOeLHsMe73uP_MeMxT-g@mail.gmail.com>
Subject: Re: [PATCH QEMU v5 6/8] migration: Implement dirty-limit convergence
 algo
To: quintela@redhat.com
Cc: "~hyman" <hyman@git.sr.ht>, qemu-devel <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f8328a05fe285028"
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
X-Mailman-Approved-At: Thu, 15 Jun 2023 09:34:24 -0400
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

--000000000000f8328a05fe285028
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 1:50=E2=80=AFAM Juan Quintela <quintela@redhat.com>=
 wrote:

> ~hyman <hyman@git.sr.ht> wrote:
> > From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> To speed thinkng up, 1-5 are included on next Migration PULL request.
>

 OK, I'll post the next version only contain the last 3 commits.

>

> Implement dirty-limit convergence algo for live migration,
> > which is kind of like auto-converge algo but using dirty-limit
> > instead of cpu throttle to make migration convergent.
> >
> > Enable dirty page limit if dirty_rate_high_cnt greater than 2
> > when dirty-limit capability enabled, Disable dirty-limit if
> > migration be cancled.
>
> Nit: canceled.



 get it.

> >
> > Note that "set_vcpu_dirty_limit", "cancel_vcpu_dirty_limit"
> > commands are not allowed during dirty-limit live migration.
> >
> > Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>
> > + * Enable dirty-limit to throttle down the guest
> > + */
> > +static void migration_dirty_limit_guest(void)
> > +{
> > +    static int64_t quota_dirtyrate;
>
> quota_dirtyrate deserves at least a comment.
>
> I guess it means the current quota_dirty_rate that is set, but no clue.

 OK. I'll comment it next version.

>
> > +    MigrationState *s =3D migrate_get_current();
> > +
> > +    /*
> > +     * If dirty limit already enabled and migration parameter
> > +     * vcpu-dirty-limit untouched.
> > +     */
> > +    if (dirtylimit_in_service() &&
> > +        quota_dirtyrate =3D=3D s->parameters.vcpu_dirty_limit) {
> > +        return;
> > +    }
> > +
> > +    quota_dirtyrate =3D s->parameters.vcpu_dirty_limit;
> > +
> > +    /* Set or update quota dirty limit */
> > +    qmp_set_vcpu_dirty_limit(false, -1, quota_dirtyrate, NULL);
>
> Care to explain why do we have to "reset" the quota?  Or why we can't
> set it when the user issues the command, only when we throttle the guest?



 Indeed, -1 is misleading, the first parameter means the set all vcpu a
quota dirtyrate, and the second parameter is meaningless if the first
parameter is false.
The comment will be like this next version?
/* Set all vCPU a quota dirtyrate, note that the second parameter will
    be ignored if setting all vCPU for a vm.
*/

> > +    trace_migration_dirty_limit_guest(quota_dirtyrate);
> > +}
> > +
>
> Split this patch in two:
>
> a - the logic change
> b - the introduction of dirty limit.
>
> Ok, get it.

>
> Old code:
>
>     /* During block migration the auto-converge logic incorrectly detects
>      * that ram migration makes no progress. Avoid this by disabling the
>      * throttling logic during the bulk phase of block migration. */
>     if (blk_mig_bulk_active()) {
>         return;
>     }
>
>     if (migrate_auto_converge()) {
>         /* The following detection logic can be refined later. For now:
>            Check to see if the ratio between dirtied bytes and the approx=
.
>            amount of bytes that just got transferred since the last time
>            we were in this routine reaches the threshold. If that happens
>            twice, start or increase throttling. */
>
>         if ((bytes_dirty_period > bytes_dirty_threshold) &&
>             (++rs->dirty_rate_high_cnt >=3D 2)) {
>             trace_migration_throttle();
>             rs->dirty_rate_high_cnt =3D 0;
>             mig_throttle_guest_down(bytes_dirty_period,
>                                     bytes_dirty_threshold);
>         }
>     }
>
> New code:
>     /*
>      * The following detection logic can be refined later. For now:
>      * Check to see if the ratio between dirtied bytes and the approx.
>      * amount of bytes that just got transferred since the last time
>      * we were in this routine reaches the threshold. If that happens
>      * twice, start or increase throttling.
>      */
>
>     if ((bytes_dirty_period > bytes_dirty_threshold) &&
>         (++rs->dirty_rate_high_cnt >=3D 2)) {
>         rs->dirty_rate_high_cnt =3D 0;
>         /*
>          * During block migration the auto-converge logic incorrectly
> detects
>          * that ram migration makes no progress. Avoid this by disabling
> the
>          * throttling logic during the bulk phase of block migration
>          */
>         if (blk_mig_bulk_active()) {
>             return;
>         }
>
>         if (migrate_auto_converge()) {
>             trace_migration_throttle();
>             mig_throttle_guest_down(bytes_dirty_period,
>                                     bytes_dirty_threshold);
>         } else if (migrate_dirty_limit()) {
>             migration_dirty_limit_guest();
>         }
>     }
>
> Questions:
>
> - Why are we changing blk_mig_bulk_active() position?


>   I think that the old code have it in the right place.  Additionally,
>   you just changefd to this version a couple of patches agon.
>
Yes, indeed, this modification make no sense, i'll fix it next version.

>
>
>
>
> >                                   int64_t cpu_index,
> >                                   Error **errp)
> >  {
> > +    MigrationState *ms =3D migrate_get_current();
> > +
> >      if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {
> >          return;
> >      }
> > @@ -453,6 +455,15 @@ void qmp_cancel_vcpu_dirty_limit(bool has_cpu_inde=
x,
> >          return;
> >      }
> >
> > +    if (migration_is_running(ms->state) &&
> > +        (!qemu_thread_is_self(&ms->thread)) &&
> > +        migrate_dirty_limit() &&
> > +        dirtylimit_in_service()) {
> > +        error_setg(errp, "can't cancel dirty page limit while"
> > +                   " migration is running");
>
> Error message is bad or wrong.
> You can cancel the dirty page, you ust need to be on the main thread.
>
> Or I am missing something?
>
> Migration, IMHO, shares the same quota dirty rate stored in the global
variable
"dirtylimit_state ",  if we cancel the dirty limit,  it will make the
throttle not work
and the migration will be affected.

>
>
> > +        return;
> > +    }
> > +
> >      dirtylimit_state_lock();
> >
> >      if (has_cpu_index) {
> > @@ -488,6 +499,8 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
> >                                uint64_t dirty_rate,
> >                                Error **errp)
> >  {
> > +    MigrationState *ms =3D migrate_get_current();
> > +
> >      if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {
> >          error_setg(errp, "dirty page limit feature requires KVM with"
> >                     " accelerator property 'dirty-ring-size' set'")
> > @@ -504,6 +517,15 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
> >          return;
> >      }
> >
> > +    if (migration_is_running(ms->state) &&
> > +        (!qemu_thread_is_self(&ms->thread)) &&
> > +        migrate_dirty_limit() &&
> > +        dirtylimit_in_service()) {
> > +        error_setg(errp, "can't cancel dirty page limit while"
> > +                   " migration is running");
> > +        return;
> > +    }
>
> If you use such a complex expression twice, I think that creating a
> helper function is a good idea.
>
Ok, get it

>
> Later, Juan.
>
>
Hyman

--=20
Best regards

--000000000000f8328a05fe285028
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 14, 20=
23 at 1:50=E2=80=AFAM Juan Quintela &lt;<a href=3D"mailto:quintela@redhat.c=
om">quintela@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">~hyman &lt=
;<a href=3D"mailto:hyman@git.sr.ht" target=3D"_blank">hyman@git.sr.ht</a>&g=
t; wrote:<br>
&gt; From: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D"mailto:yong.huang=
@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
<br>
To speed thinkng up, 1-5 are included on next Migration PULL request.<br>
<span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot=
;,sans-serif"></span>=C2=A0</blockquote><div>=C2=A0<span style=3D"font-fami=
ly:&quot;comic sans ms&quot;,sans-serif">OK, I&#39;ll post the next version=
 only contain the last 3 commits.</span></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-st=
yle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=C2=A0</bloc=
kquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204=
,204);padding-left:1ex">
&gt; Implement dirty-limit convergence algo for live migration,<br>
&gt; which is kind of like auto-converge algo but using dirty-limit<br>
&gt; instead of cpu throttle to make migration convergent.<br>
&gt;<br>
&gt; Enable dirty page limit if dirty_rate_high_cnt greater than 2<br>
&gt; when dirty-limit capability enabled, Disable dirty-limit if<br>
&gt; migration be cancled.<br>
<br>
Nit: canceled.=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;bor=
der-left-color:rgb(204,204,204);padding-left:1ex">=C2=A0</blockquote><div>=
=C2=A0<span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">get =
it.</span></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rg=
b(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Note that &quot;set_vcpu_dirty_limit&quot;, &quot;cancel_vcpu_dirty_li=
mit&quot;<br>
&gt; commands are not allowed during dirty-limit live migration.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D"mailto:y=
ong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.c=
om" target=3D"_blank">armbru@redhat.com</a>&gt;<br>
<br>
<br>
&gt; + * Enable dirty-limit to throttle down the guest<br>
&gt; + */<br>
&gt; +static void migration_dirty_limit_guest(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 static int64_t quota_dirtyrate;<br>
<br>
quota_dirtyrate deserves at least a comment.<br>
<br>
I guess it means the current quota_dirty_rate that is set, but no clue.=C2=
=A0</blockquote><div>=C2=A0<span style=3D"font-family:&quot;comic sans ms&q=
uot;,sans-serif">OK. I&#39;ll comment it next version.</span></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wid=
th:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-l=
eft:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-lef=
t-color:rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 MigrationState *s =3D migrate_get_current();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* If dirty limit already enabled and migration pa=
rameter<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* vcpu-dirty-limit untouched.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (dirtylimit_in_service() &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 quota_dirtyrate =3D=3D s-&gt;parameters.v=
cpu_dirty_limit) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 quota_dirtyrate =3D s-&gt;parameters.vcpu_dirty_limit;<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Set or update quota dirty limit */<br>
&gt; +=C2=A0 =C2=A0 qmp_set_vcpu_dirty_limit(false, -1, quota_dirtyrate, NU=
LL);<br>
<br>
Care to explain why do we have to &quot;reset&quot; the quota?=C2=A0 Or why=
 we can&#39;t<br>
set it when the user issues the command, only when we throttle the guest?=
=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color=
:rgb(204,204,204);padding-left:1ex">=C2=A0<span class=3D"gmail_default" sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif"></span></blockquote=
><div>=C2=A0<span class=3D"gmail_default" style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif">Indeed, -1 is misleading, the first parameter mea=
ns the set all vcpu a</span>=C2=A0</div><div><span class=3D"gmail_default" =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">quota dirtyrate,=
 and the second parameter is meaningless if the first=C2=A0</span></div><di=
v><span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&qu=
ot;,sans-serif">parameter</span>=C2=A0<span class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">is false.</span>=C2=
=A0</div><div><span style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if">The comment will be like this next version?</span></div><div><span clas=
s=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if">/* Set all vCPU a quota dirtyrate, note that the second parameter will=
=C2=A0</span><span style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f"></span></div><div class=3D"gmail_default" style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif"> =C2=A0 =C2=A0 be ignored if setting all vCPU =
for a vm. </div><div class=3D"gmail_default" style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif">*/</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid=
;border-left-color:rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 trace_migration_dirty_limit_guest(quota_dirtyrate);<br>
&gt; +}<br>
&gt; +<br>
<br>
Split this patch in two:<br>
<br>
a - the logic change<br>
b - the introduction of dirty limit.<br>
<br></blockquote><div class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">Ok, get it.</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-s=
tyle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
Old code:<br>
<br>
=C2=A0 =C2=A0 /* During block migration the auto-converge logic incorrectly=
 detects<br>
=C2=A0 =C2=A0 =C2=A0* that ram migration makes no progress. Avoid this by d=
isabling the<br>
=C2=A0 =C2=A0 =C2=A0* throttling logic during the bulk phase of block migra=
tion. */<br>
=C2=A0 =C2=A0 if (blk_mig_bulk_active()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 if (migrate_auto_converge()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The following detection logic can be refined=
 later. For now:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Check to see if the ratio between =
dirtied bytes and the approx.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amount of bytes that just got tran=
sferred since the last time<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0we were in this routine reaches th=
e threshold. If that happens<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0twice, start or increase throttlin=
g. */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((bytes_dirty_period &gt; bytes_dirty_thresh=
old) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (++rs-&gt;dirty_rate_high_cnt &gt=
;=3D 2)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_migration_throttle();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rs-&gt;dirty_rate_high_cnt =3D 0;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mig_throttle_guest_down(bytes_dir=
ty_period,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_dirty_threshold)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }<br>
<br>
New code:<br>
=C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0* The following detection logic can be refined later. F=
or now:<br>
=C2=A0 =C2=A0 =C2=A0* Check to see if the ratio between dirtied bytes and t=
he approx.<br>
=C2=A0 =C2=A0 =C2=A0* amount of bytes that just got transferred since the l=
ast time<br>
=C2=A0 =C2=A0 =C2=A0* we were in this routine reaches the threshold. If tha=
t happens<br>
=C2=A0 =C2=A0 =C2=A0* twice, start or increase throttling.<br>
=C2=A0 =C2=A0 =C2=A0*/<br>
<br>
=C2=A0 =C2=A0 if ((bytes_dirty_period &gt; bytes_dirty_threshold) &amp;&amp=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (++rs-&gt;dirty_rate_high_cnt &gt;=3D 2)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rs-&gt;dirty_rate_high_cnt =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* During block migration the auto-converg=
e logic incorrectly detects<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* that ram migration makes no progress. A=
void this by disabling the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* throttling logic during the bulk phase =
of block migration<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (blk_mig_bulk_active()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (migrate_auto_converge()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_migration_throttle();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mig_throttle_guest_down(bytes_dir=
ty_period,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_dirty_threshold)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (migrate_dirty_limit()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_dirty_limit_guest();<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }<br>
<br>
Questions:<br>
<br>
- Why are we changing blk_mig_bulk_active() position?<span class=3D"gmail_d=
efault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"></span>=
=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color=
:rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 I think that the old code have it in the right place.=C2=A0 Addition=
ally,<br>
=C2=A0 you just changefd to this version a couple of patches agon.<br></blo=
ckquote><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans =
ms&quot;,sans-serif">Yes, indeed, this modification make no sense, i&#39;ll=
 fix it next version.</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-le=
ft-color:rgb(204,204,204);padding-left:1ex">
<br>
<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t cpu_index,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 MigrationState *ms =3D migrate_get_current();<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -453,6 +455,15 @@ void qmp_cancel_vcpu_dirty_limit(bool has_cpu_ind=
ex,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (migration_is_running(ms-&gt;state) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (!qemu_thread_is_self(&amp;ms-&gt;thread)=
) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_dirty_limit() &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dirtylimit_in_service()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;can&#39;t cancel d=
irty page limit while&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot; migration is running&quot;);<br>
<br>
Error message is bad or wrong.<br>
You can cancel the dirty page, you ust need to be on the main thread.<br>
<br>
Or I am missing something?<br>
<br></blockquote><div class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">Migration, IMHO, shares the same quota dirty =
rate stored in the global variable</div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">&quot;dirtylimit_stat=
e &quot;, =C2=A0if we cancel the dirty limit, =C2=A0it will make the thrott=
le not work</div><div class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">and the migration will be affected.</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);paddi=
ng-left:1ex">
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 dirtylimit_state_lock();<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (has_cpu_index) {<br>
&gt; @@ -488,6 +499,8 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t dirty_rate,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 MigrationState *ms =3D migrate_get_current();<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;dirty page li=
mit feature requires KVM with&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot; accelerator property &#39;dirty-ring-size&#39; set&#39;&quot;)=
<br>
&gt; @@ -504,6 +517,15 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (migration_is_running(ms-&gt;state) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (!qemu_thread_is_self(&amp;ms-&gt;thread)=
) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_dirty_limit() &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dirtylimit_in_service()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;can&#39;t cancel d=
irty page limit while&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot; migration is running&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
If you use such a complex expression twice, I think that creating a<br>
helper function is a good idea.<br></blockquote><div class=3D"gmail_default=
" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Ok, get it</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204)=
;padding-left:1ex">
<br>
Later, Juan.<br>
<br>
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Hyman</div><br></div=
><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" clas=
s=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-se=
rif">Best regards</font></div></div></div>

--000000000000f8328a05fe285028--

