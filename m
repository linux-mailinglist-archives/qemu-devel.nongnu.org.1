Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960CC737645
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 22:46:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBiE3-0007TU-AD; Tue, 20 Jun 2023 16:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBiDv-0007TG-Pj
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 16:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBiDs-0005fb-Tl
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 16:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687293906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BL6/acRFVscf3QAYVVFI8f3hNoboVDEJ+WDKjJuREL8=;
 b=MNCpDc/yKhgAPelPbcX9ADHD1ieJkTJ87JY6gxj1GEZqSX8yOXAVRmzNVq9znyVOUAzAUU
 bj3Y/b3CFLc5OQJlxws+g7fgo6y9zC5IQZB2KQGzLN49i9tk2jq2dH1nTvs/zrNzbi2F5F
 dTWsuCVmFvQz2h3FxJQ95hdT+S0EdAM=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-IYdGkbO5PDW9rZGZxYpdqw-1; Tue, 20 Jun 2023 16:45:04 -0400
X-MC-Unique: IYdGkbO5PDW9rZGZxYpdqw-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-440bf45dc93so502017137.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 13:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687293904; x=1689885904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BL6/acRFVscf3QAYVVFI8f3hNoboVDEJ+WDKjJuREL8=;
 b=IZo562FswS+ZTaYJQq/oG5t78S3CQGE/2O3XXvAcGuLglkNhWhavaKFDQP3bs7rqjh
 IVmkseRhK5mPnp3Lmr1KPbMDl0yQ1Jkxp9pH6SNvfnafWDnpXC/w8Jdq2t4V48sXUx0I
 RoR/jJWj53Loi1E/9S5phc1vClGkVYPUGm0XocAi9FQ6kYkZezXYwBwxjVamGaU1L5SL
 yyFoZMo+BRSJ/MY8Fk7SLg4zHl/EGcp2aXJOzMDYbxCORoRI1z0xWkNS4UuTnW62sE0d
 0txRyY7yIih37P1VZfF4cm3nc0GLHMToFRCCg9lziy/YrxT8C2TQTV6Bb0fNcjluhG7I
 WSfg==
X-Gm-Message-State: AC+VfDz+ZN5SlUsU7QuU89K57ucWlK/VQT02bPJlZIYoVaodT3mNv6jC
 eFN1cBFcZZL6Wp3UMfVpBs5ve83TC63i+tHWC/E0H4EJVabhZxuW1bh4Cw5kidYsDYWOayoWvG7
 5yf4YxyQPwJafKqRjDxvpaqjOv2s5MYw=
X-Received: by 2002:a05:6102:e44:b0:43c:8aac:19bd with SMTP id
 p4-20020a0561020e4400b0043c8aac19bdmr6046827vst.3.1687293903932; 
 Tue, 20 Jun 2023 13:45:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wIp3Se4cvv9MYpZda5Cg47nkrjIh96sdgxuaQBP7s5G+xbG9m9bgl0KdOfaA605QEiydUcFPLlCz96ZJrKIo=
X-Received: by 2002:a05:6102:e44:b0:43c:8aac:19bd with SMTP id
 p4-20020a0561020e4400b0043c8aac19bdmr6046812vst.3.1687293903630; Tue, 20 Jun
 2023 13:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230618212039.102052-1-pbonzini@redhat.com>
 <d6a79a1d2159e0659cd0ed6ff545bf577c05bad3.camel@linux.ibm.com>
In-Reply-To: <d6a79a1d2159e0659cd0ed6ff545bf577c05bad3.camel@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 Jun 2023 22:44:53 +0200
Message-ID: <CABgObfa8kEiG22MAdsuhgpuWrzWq9yWMeRaFgvWA5x_eoROPUw@mail.gmail.com>
Subject: Re: [PATCH] git-submodule.sh: allow running in validate mode without
 previous update
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c203d205fe95b9e3"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000c203d205fe95b9e3
Content-Type: text/plain; charset="UTF-8"

Il mar 20 giu 2023, 19:35 Nina Schoetterl-Glausch <nsg@linux.ibm.com> ha
scritto:

> > +            modules="$modules $m"
> > +            grep $m $substat > /dev/null 2>&1 || $GIT submodule status
> $module >> $substat
> > +        else
> > +            echo "warn: ignoring non-existent submodule $m"
>
> What is the rational for ignoring non-existing submodules, i.e. how do the
> arguments to
> the script go stale as you say in the patch description?
>

For example when a Makefile calls the script before the Makefile itself is
rebuilt.

I'm asking because the fedora spec file initializes a new git repo in order
> to apply
> patches so the script exits with 0.


You mean it succeeds even if roms/SLOF is empty?

Nothing that cannot be worked around ofc.
>
> > +        fi
> > +    done
> > +else
> > +    modules=$maybe_modules
> >  fi
> >
> > -if test -n "$maybe_modules" && test -z "$GIT"
> > -then
> > -    echo "$0: unexpectedly called with submodules but git binary not
> found"
> > -    exit 1
> > -fi
> > -
> > -modules=""
> > -for m in $maybe_modules
> > -do
> > -    $GIT submodule status $m 1> /dev/null 2>&1
> > -    if test $? = 0
> > -    then
> > -        modules="$modules $m"
> > -    else
> > -        echo "warn: ignoring non-existent submodule $m"
> > -    fi
> > -done
> > -
> >  case "$command" in
> >  status|validate)
> > -    test -f "$substat" || validate_error "$command"
> > -    test -z "$maybe_modules" && exit 0
> >      for module in $modules; do
> > -        check_updated $module || validate_error "$command"
> > +        if is_git; then
> > +            check_updated $module || validate_error "$command"
> > +        elif ! test -d $module; then
>
> archive-source.sh creates an empty directory for e.g. roms/SLOF,
> so this check succeeds even if the submodule sources are unavailable.

Something like
>
>         elif ! test -d $module || test -z "$(ls -A "$module")"; then
>

Or (set "$module"/* && test -e "$1").

Paolo

works.
>
> > +            echo "$0: sources not available for $module and
> $no_git_error"
> > +            validate_error "$command"
> > +        fi
> >      done
> > -    exit 0
> >      ;;
> > +
> >  update)
> > -    test -e $substat || touch $substat
> > -    test -z "$maybe_modules" && exit 0
> > +    is_git || {
> > +        echo "$0: unexpectedly called with submodules but $no_git_error"
> > +        exit 1
> > +    }
> >
> >      $GIT submodule update --init $modules 1>/dev/null
> >      test $? -ne 0 && update_error "failed to update modules"
>
>

--000000000000c203d205fe95b9e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 20 giu 2023, 19:35 Nina Schoetterl-Glausch &lt;=
<a href=3D"mailto:nsg@linux.ibm.com">nsg@linux.ibm.com</a>&gt; ha scritto:<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules=3D&quot;$modules $m=
&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grep $m $substat &gt; /dev/=
null 2&gt;&amp;1 || $GIT submodule status $module &gt;&gt; $substat<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;warn: ignoring n=
on-existent submodule $m&quot;<br>
<br>
What is the rational for ignoring non-existing submodules, i.e. how do the =
arguments to<br>
the script go stale as you say in the patch description?<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">For example when a =
Makefile calls the script before the Makefile itself is rebuilt.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
I&#39;m asking because the fedora spec file initializes a new git repo in o=
rder to apply<br>
patches so the script exits with 0.</blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">You mean it succeeds even if roms/SLOF is em=
pty?</div><div dir=3D"auto"><br></div><div dir=3D"auto"></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Nothing that cannot be worked around ofc.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
&gt; +=C2=A0 =C2=A0 done<br>
&gt; +else<br>
&gt; +=C2=A0 =C2=A0 modules=3D$maybe_modules<br>
&gt;=C2=A0 fi<br>
&gt;=C2=A0 <br>
&gt; -if test -n &quot;$maybe_modules&quot; &amp;&amp; test -z &quot;$GIT&q=
uot;<br>
&gt; -then<br>
&gt; -=C2=A0 =C2=A0 echo &quot;$0: unexpectedly called with submodules but =
git binary not found&quot;<br>
&gt; -=C2=A0 =C2=A0 exit 1<br>
&gt; -fi<br>
&gt; -<br>
&gt; -modules=3D&quot;&quot;<br>
&gt; -for m in $maybe_modules<br>
&gt; -do<br>
&gt; -=C2=A0 =C2=A0 $GIT submodule status $m 1&gt; /dev/null 2&gt;&amp;1<br=
>
&gt; -=C2=A0 =C2=A0 if test $? =3D 0<br>
&gt; -=C2=A0 =C2=A0 then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 modules=3D&quot;$modules $m&quot;<br>
&gt; -=C2=A0 =C2=A0 else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;warn: ignoring non-existent su=
bmodule $m&quot;<br>
&gt; -=C2=A0 =C2=A0 fi<br>
&gt; -done<br>
&gt; -<br>
&gt;=C2=A0 case &quot;$command&quot; in<br>
&gt;=C2=A0 status|validate)<br>
&gt; -=C2=A0 =C2=A0 test -f &quot;$substat&quot; || validate_error &quot;$c=
ommand&quot;<br>
&gt; -=C2=A0 =C2=A0 test -z &quot;$maybe_modules&quot; &amp;&amp; exit 0<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 for module in $modules; do<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_updated $module || validate_error &=
quot;$command&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if is_git; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check_updated $module || va=
lidate_error &quot;$command&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif ! test -d $module; then<br>
<br>
archive-source.sh creates an empty directory for e.g. roms/SLOF,<br>
so this check succeeds even if the submodule sources are unavailable.</bloc=
kquote></div></div><div dir=3D"auto"></div><div dir=3D"auto"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
Something like<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif ! test -d $module || test -z &quot;$(ls -A=
 &quot;$module&quot;)&quot;; then<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Or (set &quot;$module&quot;/* &amp;&amp; t=
est -e &quot;$1&quot;).</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
works.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;$0: sources not =
available for $module and $no_git_error&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 validate_error &quot;$comma=
nd&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 done<br>
&gt; -=C2=A0 =C2=A0 exit 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ;;<br>
&gt; +<br>
&gt;=C2=A0 update)<br>
&gt; -=C2=A0 =C2=A0 test -e $substat || touch $substat<br>
&gt; -=C2=A0 =C2=A0 test -z &quot;$maybe_modules&quot; &amp;&amp; exit 0<br=
>
&gt; +=C2=A0 =C2=A0 is_git || {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;$0: unexpectedly called with s=
ubmodules but $no_git_error&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 $GIT submodule update --init $modules 1&gt;/dev/nu=
ll<br>
&gt;=C2=A0 =C2=A0 =C2=A0 test $? -ne 0 &amp;&amp; update_error &quot;failed=
 to update modules&quot;<br>
<br>
</blockquote></div></div></div>

--000000000000c203d205fe95b9e3--


