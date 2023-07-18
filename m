Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B2757178
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 03:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLZle-0002C9-2f; Mon, 17 Jul 2023 21:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qLZlb-0002AN-4V
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 21:44:43 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qLZlY-0000M3-DT
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 21:44:42 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-263374f2f17so2741100a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 18:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1689644556; x=1692236556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xijtYuiXZr2OnGXXZtkkwchrojmKNQOW9xcDgOAysis=;
 b=yh767cGE85R8E7i0gdhCWchswBwuMX4RC1q+3wydDW0ee4/fFbKufcQNMKHU5Adn0m
 +e0PmyR0L7XRUYY/ljMcSoGxg0uK3VMKbFsXhCF27WPpB0iIBWPmYn5IRNmeHCprJMUn
 suCTWnlzTMxx8uJRmdOEmY2yg4jmNRmrgXjLmhY3zVkGfQEE8BZHtK3RG+2SI/BVhdo6
 ziWIFEEmlvjQU1soXcGtdcwe1NTK7wjFqy0uGcyo0RLX+ntBurUqW+O1iHYiMEmJgxcP
 h7AtJDauqoT4XDKSgwGO95DWbNshbOnhgiuYs4gBVtIXAszom7uS+40VSlsMpo/qYY3p
 2sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689644556; x=1692236556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xijtYuiXZr2OnGXXZtkkwchrojmKNQOW9xcDgOAysis=;
 b=fCgdAdghIAaKLvqLQUx8K9uR10h3yJ0VxiC6to4qvWok9ahFhRmTJJw7AZffdNxd50
 Q/Jd09mvN7AdqG0ikgqHz1t5Kz9xHeje9rCAQR6nzv0vaD452cwl7t3i02aiZzlWHQs7
 OHkkwBbAyDNFULaJ6lNQtIAqbCllf4NuQL73n7F/reXmR5mUGoTxreLLrffdATvydZCg
 SsmxvcGjKrNqCSwPL13q19x++Gerj7P7iYwFE1XylKAgMu6RrW7X25SiZk6qnJ7TkmK4
 Z5maC6j8KGgz4J1cda6Jg6WIvx/mmWwCUo3qrc0uwZngc0TVIPfhIlWKmHJoHJSLVFAV
 fomQ==
X-Gm-Message-State: ABy/qLbGffERkuVP2qabjKGmj2Cw4cDzE6YFukjjNGmgrST43T7+LjD3
 nE/W6ELcUx6RpVTtKLmqwGjtnSYR49KJGVvNx0xkoA==
X-Google-Smtp-Source: APBJJlEkIgpap2nt/Q7wgUS0TRc9bA2CCYdajxLT5zFfETXovRSugRPDhgd5qPh+n0jTevDUxME5XlM5quWvve27mMM=
X-Received: by 2002:a17:90a:db06:b0:263:8eec:550f with SMTP id
 g6-20020a17090adb0600b002638eec550fmr10435362pjv.10.1689644555705; Mon, 17
 Jul 2023 18:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <168870305868.29142.5121604177475325995-4@git.sr.ht>
 <875y6oj80i.fsf@pond.sub.org>
In-Reply-To: <875y6oj80i.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 18 Jul 2023 09:42:19 +0800
Message-ID: <CAK9dgmZ73F2qrD-iM-EBSiARRmwGPPorsLdt8NqmkOSyYaRCVw@mail.gmail.com>
Subject: Re: [PATCH QEMU v8 4/9] migration: Introduce dirty-limit capability
To: Markus Armbruster <armbru@redhat.com>
Cc: "~hyman" <hyman@git.sr.ht>, qemu-devel <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008a34970600b90754"
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1032.google.com
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

--0000000000008a34970600b90754
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 8:44=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
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
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index e43371955a..031832cde5 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -497,6 +497,15 @@
> >  #     are present.  'return-path' capability must be enabled to use
> >  #     it.  (since 8.1)
> >  #
> > +# @dirty-limit: If enabled, migration will use the dirty-limit
> > +#     algorithm to throttle down guest instead of auto-converge
> > +#     algorithm. This algorithm only works when vCPU's dirtyrate
>
> Two spaces after sentence-ending punctuation, please.
>
> "dirty rate" with a space, because that's how we spell it elsewhere.
>
> > +#     greater than 'vcpu-dirty-limit', read processes in guest os
> > +#     aren't penalized any more, so the algorithm can improve
> > +#     performance of vCPU during live migration. This is an optional
> > +#     performance feature and should not affect the correctness of the
> > +#     existing auto-converge algorithm. (since 8.1)
> > +#
>
> I'm still confused.
>
> The text suggests there are two separate algorithms "to throttle down
> guest": "auto converge" and "dirty limit", and we get to pick one.
> Correct?
>
Yes, indeed !

>
> If it is correct, then the last sentence feels redundant: picking
> another algorithm can't affect the algorithm we're *not* using.  What
> are you trying to express here?
>
What i want to express is that the new algorithm implementation does
not affect the original algorithm, leaving it in the comments seems
redundant indeed.  I'll drop this in the next version.

>
> When do we use "auto converge", and when do we use "dirty limit"?
>
> What does the user really need to know about these algorithms?  Enough
> to pick one, I guess.  That means advantages and disadvantages of the
> two algorithms.  Which are?

1. The implementation of dirty-limit is based on dirty-ring, which is
qualified
   to big systems with huge memories and can improve huge guest VM
    responsiveness remarkably during live migration. As a consequence,
dirty-limit
    is recommended on platforms with huge guest VMs as is the way with
dirty-ring.
2. dirty-limit convergence algorithm does not affect the "read-process" in
guest
   VM, so guest VM gains the equal read performance nearly as it runs on
host
   during the live migration. As a result, dirty-limit is recommended if
the guest
    VM requires a stable read performance.
The above explanation is about the recommendation of dirty-limit, please
review,
if it's ok, i'll place it in the comment of the dirty-limit capability.

>
> >  # Features:
> >  #
> >  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> > @@ -512,7 +521,8 @@
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
> Thank Markus again for the attention to this patchset. :)
Yong
--=20
Best regards

--0000000000008a34970600b90754
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 13, 2023=
 at 8:44=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.c=
om">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-st=
yle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">~hyman &lt;<=
a href=3D"mailto:hyman@git.sr.ht" target=3D"_blank">hyman@git.sr.ht</a>&gt;=
 writes:<br>
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
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index e43371955a..031832cde5 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
&gt; @@ -497,6 +497,15 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0are present.=C2=A0 &#39;return-path&#39; ca=
pability must be enabled to use<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0it.=C2=A0 (since 8.1)<br>
&gt;=C2=A0 #<br>
&gt; +# @dirty-limit: If enabled, migration will use the dirty-limit<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0algorithm to throttle down guest instead of auto=
-converge<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0algorithm. This algorithm only works when vCPU&#=
39;s dirtyrate<br>
<br>
Two spaces after sentence-ending punctuation, please.<br>
<br>
&quot;dirty rate&quot; with a space, because that&#39;s how we spell it els=
ewhere.<br>
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0greater than &#39;vcpu-dirty-limit&#39;, read pr=
ocesses in guest os<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0aren&#39;t penalized any more, so the algorithm =
can improve<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0performance of vCPU during live migration. This =
is an optional<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0performance feature and should not affect the co=
rrectness of the<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0existing auto-converge algorithm. (since 8.1)<br=
>
&gt; +#<br>
<br>
I&#39;m still confused.<br>
<br>
The text suggests there are two separate algorithms &quot;to throttle down<=
br>
guest&quot;: &quot;auto converge&quot; and &quot;dirty limit&quot;, and we =
get to pick one.<br>
Correct?<br></blockquote><div class=3D"gmail_default" style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif">Yes, indeed !</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
If it is correct, then the last sentence feels redundant: picking<br>
another algorithm can&#39;t affect the algorithm we&#39;re *not* using.=C2=
=A0 What<br>
are you trying to express here?<br></blockquote><div class=3D"gmail_default=
" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">What i want to=
 express is that the new algorithm implementation does</div><div class=3D"g=
mail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">no=
t affect the original algorithm, leaving it in the comments seems</div><div=
 class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif">redundant indeed.=C2=A0 I&#39;ll drop this in the next version.</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204=
);padding-left:1ex">
<br>
When do we use &quot;auto converge&quot;, and when do we use &quot;dirty li=
mit&quot;?<br>
<br>
What does the user really need to know about these algorithms?=C2=A0 Enough=
<br>
to pick one, I guess.=C2=A0 That means advantages and disadvantages of the<=
br>
two algorithms.=C2=A0 Which are?</blockquote><span class=3D"gmail_default" =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">1. The implement=
ation of dirty-limit is based on dirty-ring, which is qualified</span></div=
><div class=3D"gmail_quote"><font face=3D"comic sans ms, sans-serif"><span =
class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif"> =C2=A0 =C2=A0to big systems with huge memories and can improve hug=
e guest VM</span></font></div><div class=3D"gmail_quote"><font face=3D"comi=
c sans ms, sans-serif"><span class=3D"gmail_default" style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif">=C2=A0 =C2=A0 responsiveness remarkabl=
y during live migration. As a consequence, dirty-limit</span></font></div><=
div class=3D"gmail_quote"><font face=3D"comic sans ms, sans-serif"><span cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif">=C2=A0 =C2=A0 is recommended on platforms with huge guest VMs as is t=
he way with dirty-ring.</span></font></div><div class=3D"gmail_quote"><font=
 face=3D"comic sans ms, sans-serif"><span class=3D"gmail_default" style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif">2. dirty-limit convergenc=
e algorithm does not affect the &quot;read-process&quot; in guest</span></f=
ont></div><div class=3D"gmail_quote"><font face=3D"comic sans ms, sans-seri=
f"><span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&q=
uot;,sans-serif"> =C2=A0 =C2=A0VM, so guest VM gains the equal read perform=
ance nearly as it runs on host</span></font></div><div class=3D"gmail_quote=
"><font face=3D"comic sans ms, sans-serif"><span class=3D"gmail_default" st=
yle=3D"font-family:&quot;comic sans ms&quot;,sans-serif"> =C2=A0 =C2=A0duri=
ng the live migration. As a result, dirty-limit is recommended if the guest=
</span></font></div><div class=3D"gmail_quote"><font face=3D"comic sans ms,=
 sans-serif"><span class=3D"gmail_default" style=3D"font-family:&quot;comic=
 sans ms&quot;,sans-serif">=C2=A0 =C2=A0 VM requires a stable read performa=
nce.</span></font></div><div class=3D"gmail_quote"><font face=3D"comic sans=
 ms, sans-serif"><span class=3D"gmail_default" style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif">The above explanation is about the recommend=
ation of dirty-limit, please review,</span></font></div><div class=3D"gmail=
_quote"><font face=3D"comic sans ms, sans-serif"><span class=3D"gmail_defau=
lt" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">if it&#39;s =
ok, i&#39;ll place it in the comment of the dirty-limit capability.</span><=
/font></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex"><br>
&gt;=C2=A0 # Features:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @unstable: Members @x-colo and @x-ignore-shared are experiment=
al.<br>
&gt; @@ -512,7 +521,8 @@<br>
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
</blockquote></div><div><div class=3D"gmail_default" style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif">Thank Markus again for the attention t=
o this patchset.  :)</div></div><div><div style=3D"white-space:pre-wrap"><d=
iv class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif"></div><div class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">Yong</div></div></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000008a34970600b90754--

