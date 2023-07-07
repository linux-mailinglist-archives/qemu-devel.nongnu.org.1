Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B6D74A999
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 06:00:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHccF-00071u-Hv; Thu, 06 Jul 2023 23:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qHccC-00071j-TN
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 23:58:40 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qHcc8-00067w-K3
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 23:58:40 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b6c5ede714so32527481fa.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 20:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1688702192; x=1691294192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V9PiSRYhxDcNekpKzswKT4Jz37NmCms/x3JYJ+dF0kg=;
 b=kNSYsueMApxkDR3OgA8zXlj8yDskxQwT/6NFpII4hEl+tfeVEKkCdz1utwvfU/FjOf
 8iNWWEhzfP2L+ygkgAsx7ChYSYP3EiG6YWiOFsTh7A3osqtB62XA1EVMgXYqNiYvNMsF
 HF7RCPT1wfNx0yT7/iyZRSJopzaN0HWCL47QnNd6ucb5xvzO83B1OrBWAWKgSFZVK9a0
 t5VeovqeHPcBzLNUXcKXlqwlIXMSH2MR9Ju55l5AcNJ5/kNCT5td49VSdYbljXCDOcHq
 rtgj9PO2w0lS/GykzkTwK1Ns5jGJjUd7reB1QPCD1POLPNrhhTgRFsD/cPJqeOqFTKT8
 p4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688702192; x=1691294192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V9PiSRYhxDcNekpKzswKT4Jz37NmCms/x3JYJ+dF0kg=;
 b=Vikb+f4jN3VFJt/zbq27rmYoWZpwjU3sxAH6Hz4VMORWFViC/bJxC93JOj9BBlYCid
 97klcpxTgK5P9pBljrqGOlOsosNI1dbfVN6ZXtXjJKNLVgtjFk3O1hdeogzsOGiICZOw
 l79oR9xmHjHsWnuDdeI1wSqBrwQUnxDcrpfGCE6na5QA4GoBR1JS6bMzePtEO6/w6ck8
 nopq2TcBCc6GoD2Cw62fi4D5WyKcXEFamLFvmJ21Zf1he2y8+E/8fvZkBJcwxxPwn1Az
 CXLtolASSFsf7JKlaU3YXtY/VxCa9UPevEvAeKpgiKCfg40ygXDm4e+UFpwUUfXSMJPj
 XxSw==
X-Gm-Message-State: ABy/qLbN0Bs2E7R/mEjrRewCFiYXi1NZn3XUOq3VypJUYLj6QLOtapVZ
 W5tpQ5ibXK4I/1O4d61AJAdqY7PAkEACgQR6q3hlbQ==
X-Google-Smtp-Source: APBJJlGwZJ0oeyArmjW7EiUKE9ugIvfovmZp+V7wgmuV8F63wd5HBhYew+PclwLxnvGHiIVca2fb4RmCUc7YH+26va4=
X-Received: by 2002:a05:651c:482:b0:2b6:98c2:6378 with SMTP id
 s2-20020a05651c048200b002b698c26378mr2833265ljc.2.1688702192210; Thu, 06 Jul
 2023 20:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <168853615963.17240.15832775267134683267-4@git.sr.ht>
 <877crdozls.fsf@pond.sub.org>
In-Reply-To: <877crdozls.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 7 Jul 2023 11:56:15 +0800
Message-ID: <CAK9dgmaunZwAKNU40GpGK=AP5kqvsQMxM3q63Z_h4U8r6P8uaA@mail.gmail.com>
Subject: Re: [PATCH QEMU v7 4/9] migration: Introduce dirty-limit capability
To: Markus Armbruster <armbru@redhat.com>
Cc: "~hyman" <hyman@git.sr.ht>, qemu-devel <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004c66ff05ffdd9ecd"
Received-SPF: none client-ip=2a00:1450:4864:20::232;
 envelope-from=yong.huang@smartx.com; helo=mail-lj1-x232.google.com
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

--0000000000004c66ff05ffdd9ecd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 6, 2023 at 10:59=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> ~hyman <hyman@git.sr.ht> writes:
>
> > From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> >
> > Introduce migration dirty-limit capability, which can
> > be turned on before live migration and limit dirty
> > page rate durty live migration.
> >
> > Introduce migrate_dirty_limit function to help check
> > if dirty-limit capability enabled during live migration.
> >
> > Meanwhile, refactor vcpu_dirty_rate_stat_collect
> > so that period can be configured instead of hardcoded.
> >
> > dirty-limit capability is kind of like auto-converge
> > but using dirty limit instead of traditional cpu-throttle
> > to throttle guest down. To enable this feature, turn on
> > the dirty-limit capability before live migration using
> > migrate-set-capabilities, and set the parameters
> > "x-vcpu-dirty-limit-period", "vcpu-dirty-limit" suitably
> > to speed up convergence.
> >
> > Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> > Acked-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> [...]
>
> > diff --git a/migration/options.h b/migration/options.h
> > index 9aaf363322..b5a950d4e4 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -24,6 +24,7 @@ extern Property migration_properties[];
> >  /* capabilities */
> >
> >  bool migrate_auto_converge(void);
> > +bool migrate_dirty_limit(void);
> >  bool migrate_background_snapshot(void);
> >  bool migrate_block(void);
> >  bool migrate_colo(void);
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index aa590dbf0e..cc51835cdd 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -497,6 +497,16 @@
> >  #     are present.  'return-path' capability must be enabled to use
> >  #     it.  (since 8.1)
> >  #
> > +# @dirty-limit: If enabled, migration will use the dirty-limit algo to
> > +#               throttle down guest instead of auto-converge algo.
> > +#               Throttle algo only works when vCPU's dirtyrate greater
> > +#               than 'vcpu-dirty-limit', read processes in guest os
> > +#               aren't penalized any more, so this algo can improve
> > +#               performance of vCPU during live migration. This is an
> > +#               optional performance feature and should not affect the
> > +#               correctness of the existing auto-converge algo.
> > +#               (since 8.1)
> > +#
>
> Please format like
>
>    # @dirty-limit: If enabled, migration will use the dirty-limit algo to
>    #     throttle down guest instead of auto-converge algo.  Throttle
>    #     algo only works when vCPU's dirtyrate greater than
>    #     'vcpu-dirty-limit', read processes in guest os aren't penalized
>    #     any more, so this algo can improve performance of vCPU during
>    #     live migration.  This is an optional performance feature and
>    #     should not affect the correctness of the existing auto-converge
>    #     algo.  (since 8.1)
>
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).
>
> "Dirty rate" with a space, because that's how we spell it elsewhere.
>
> Moreover, "algo" is not a word, "algorithm" is :)
>
> Is "the dirty-limit algorithm" defined anywhere?
>
> More word-smithing is needed, but I'd like to get the reference to "the
> dirty-limit algorithm" clarified first.
>
Dirty limit algorithm just uses the existing internal implementation
 of qmp api "set-vcpu-dirty-limit" to implement the throttle algorithm
of live migration.  So the capability is named "dirty-limit" :)

More details about dirty-limit algorithm can be referenced as
following two commits:
https://lore.kernel.org/qemu-devel/20220719170221.576190-8-dgilbert@redhat.=
com/
https://lore.kernel.org/qemu-devel/20220719170221.576190-7-dgilbert@redhat.=
com/

>
> >  # Features:
> >  #
> >  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> > @@ -512,7 +522,8 @@
> >             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate=
',
> >             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
> >             'validate-uuid', 'background-snapshot',
> > -           'zero-copy-send', 'postcopy-preempt', 'switchover-ack'] }
> > +           'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> > +           'dirty-limit'] }
> >
> >  ##
> >  # @MigrationCapabilityStatus:
>
> [...]
>
>

--=20
Best regards

--0000000000004c66ff05ffdd9ecd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 6, 202=
3 at 10:59=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">~hyman &lt=
;<a href=3D"mailto:hyman@git.sr.ht" target=3D"_blank">hyman@git.sr.ht</a>&g=
t; writes:<br>
<br>
&gt; From: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D"mailto:yong.huang=
@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;<br>
&gt; Introduce migration dirty-limit capability, which can<br>
&gt; be turned on before live migration and limit dirty<br>
&gt; page rate durty live migration.<br>
&gt;<br>
&gt; Introduce migrate_dirty_limit function to help check<br>
&gt; if dirty-limit capability enabled during live migration.<br>
&gt;<br>
&gt; Meanwhile, refactor vcpu_dirty_rate_stat_collect<br>
&gt; so that period can be configured instead of hardcoded.<br>
&gt;<br>
&gt; dirty-limit capability is kind of like auto-converge<br>
&gt; but using dirty limit instead of traditional cpu-throttle<br>
&gt; to throttle guest down. To enable this feature, turn on<br>
&gt; the dirty-limit capability before live migration using<br>
&gt; migrate-set-capabilities, and set the parameters<br>
&gt; &quot;x-vcpu-dirty-limit-period&quot;, &quot;vcpu-dirty-limit&quot; su=
itably<br>
&gt; to speed up convergence.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) &lt;<a href=3D"mailto:y=
ong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; Acked-by: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"=
_blank">peterx@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Juan Quintela &lt;<a href=3D"mailto:quintela@redhat.com" =
target=3D"_blank">quintela@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/migration/options.h b/migration/options.h<br>
&gt; index 9aaf363322..b5a950d4e4 100644<br>
&gt; --- a/migration/options.h<br>
&gt; +++ b/migration/options.h<br>
&gt; @@ -24,6 +24,7 @@ extern Property migration_properties[];<br>
&gt;=C2=A0 /* capabilities */<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 bool migrate_auto_converge(void);<br>
&gt; +bool migrate_dirty_limit(void);<br>
&gt;=C2=A0 bool migrate_background_snapshot(void);<br>
&gt;=C2=A0 bool migrate_block(void);<br>
&gt;=C2=A0 bool migrate_colo(void);<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index aa590dbf0e..cc51835cdd 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
&gt; @@ -497,6 +497,16 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0are present.=C2=A0 &#39;return-path&#39; ca=
pability must be enabled to use<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0it.=C2=A0 (since 8.1)<br>
&gt;=C2=A0 #<br>
&gt; +# @dirty-limit: If enabled, migration will use the dirty-limit algo t=
o<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0throttle down=
 guest instead of auto-converge algo.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Throttle algo=
 only works when vCPU&#39;s dirtyrate greater<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0than &#39;vcp=
u-dirty-limit&#39;, read processes in guest os<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aren&#39;t pe=
nalized any more, so this algo can improve<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0performance o=
f vCPU during live migration. This is an<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optional perf=
ormance feature and should not affect the<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0correctness o=
f the existing auto-converge algo.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(since 8.1)<b=
r>
&gt; +#<br>
<br>
Please format like<br>
<br>
=C2=A0 =C2=A0# @dirty-limit: If enabled, migration will use the dirty-limit=
 algo to<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0throttle down guest instead of auto-conve=
rge algo.=C2=A0 Throttle<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0algo only works when vCPU&#39;s dirtyrate=
 greater than<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0&#39;vcpu-dirty-limit&#39;, read processe=
s in guest os aren&#39;t penalized<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0any more, so this algo can improve perfor=
mance of vCPU during<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0live migration.=C2=A0 This is an optional=
 performance feature and<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0should not affect the correctness of the =
existing auto-converge<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0algo.=C2=A0 (since 8.1)<br>
<br>
to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments<br>
to conform to current conventions).<br>
<br>
&quot;Dirty rate&quot; with a space, because that&#39;s how we spell it els=
ewhere.<br>
<br>
Moreover, &quot;algo&quot; is not a word, &quot;algorithm&quot; is :)<br>
<br>
Is &quot;the dirty-limit algorithm&quot; defined anywhere?=C2=A0 <br>
<br>
More word-smithing is needed, but I&#39;d like to get the reference to &quo=
t;the<br>
dirty-limit algorithm&quot; clarified first.<br></blockquote><div class=3D"=
gmail_default"><span style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif"> Dirty limit algorithm just uses the existing internal implementation<=
/span></div><div class=3D"gmail_default"><span style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif">=C2=A0of qmp api &quot;set-vcpu-dirty-limit&=
quot; to implement the throttle algorithm</span></div><div class=3D"gmail_d=
efault"><font face=3D"comic sans ms, sans-serif">of live migration.=C2=A0 S=
o the capability is named &quot;dirty-limit&quot; :)</font></div><div class=
=3D"gmail_default"><font face=3D"comic sans ms, sans-serif"><br></font></di=
v><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">Mor=
e details about dirty-limit algorithm can be referenced as</font></div><div=
 class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">following=
 two commits:</font></div><div class=3D"gmail_default"><a href=3D"https://l=
ore.kernel.org/qemu-devel/20220719170221.576190-8-dgilbert@redhat.com/">htt=
ps://lore.kernel.org/qemu-devel/20220719170221.576190-8-dgilbert@redhat.com=
/</a><font face=3D"comic sans ms, sans-serif"><br></font></div><div class=
=3D"gmail_default"><a href=3D"https://lore.kernel.org/qemu-devel/2022071917=
0221.576190-7-dgilbert@redhat.com/">https://lore.kernel.org/qemu-devel/2022=
0719170221.576190-7-dgilbert@redhat.com/</a><br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border=
-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 # Features:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @unstable: Members @x-colo and @x-ignore-shared are experiment=
al.<br>
&gt; @@ -512,7 +522,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;dirty-bitmaps&#39;=
, &#39;postcopy-blocktime&#39;, &#39;late-block-activate&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &#39;name&#39;: &#39;=
x-ignore-shared&#39;, &#39;features&#39;: [ &#39;unstable&#39; ] },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;validate-uuid&#39;=
, &#39;background-snapshot&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;zero-copy-send&#39;, &#=
39;postcopy-preempt&#39;, &#39;switchover-ack&#39;] }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;zero-copy-send&#39;, &#=
39;postcopy-preempt&#39;, &#39;switchover-ack&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;dirty-limit&#39;] }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @MigrationCapabilityStatus:<br>
<br>
[...]<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000004c66ff05ffdd9ecd--

