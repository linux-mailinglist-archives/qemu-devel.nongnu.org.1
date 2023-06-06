Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D56C672496E
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 18:43:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ZlQ-0005LK-7d; Tue, 06 Jun 2023 12:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsun@junsun.net>) id 1q6ZlO-0005Kn-25
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:42:30 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jsun@junsun.net>) id 1q6ZlL-0007xs-W7
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:42:29 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-558a79941c6so2168115eaf.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=junsun-net.20221208.gappssmtp.com; s=20221208; t=1686069745; x=1688661745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EthIQ0nQLAxGuvMoyRD7IeQvfVd6uuCZhyUnELXf8/k=;
 b=H2vEq/BKmx/6SMQx6VA+U7WH3RqKrr+4xjIFrzIp3GqEruCqPNLYxIDbn1pQfDpBg3
 UBHf3Ju+3TXP+x+y2bLMQM/APvRi3+oeqt2fK3mQnuTJux/CIRanh7nOVG849odAzt3U
 tVdqNViOwr0BflLPV0k5XNgj1u7huJ7iR1yKuFD7KkQjVC8uEWQ7Osf9RzmfGf7Qu7I8
 zaMzTCGLOy1PMNRvLEDKKmI9R1Kpz7p3pbspV0oLmN1brO36JlJ/Ke2PU6pVfqfDxFzu
 Yc+KshY6PhiNRpKR7e/yIS/t7Tz7wdwOOPVWJ7pzlFytenSPZnfX/LrfHK4yEwT2gWG2
 mAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686069745; x=1688661745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EthIQ0nQLAxGuvMoyRD7IeQvfVd6uuCZhyUnELXf8/k=;
 b=d4DMy822zzv1bVC8zSQHjMMHEu9k4xO/rJnnHqXvCfovk2zcG5NS3Dy0NfYLVSsSug
 64YoYmz15e2p7Z89YBE5sZzngi5r2TUCPSJr4LzVOPArVW2ONVo/dayD6TQf6Z/gQuJv
 keG3Jr1yx4ZGCZR7r182FSAQaaVjLKUQqIhTCb4YsWDsVNabjGdE7qJK4C8ae+HYz8Ce
 rEFFBUceyeDPEQ+Gok43HbUiPawxRzfnWUtnJsqnSQStLOcYrK0pCUREXIugOWZg1OV1
 TExdnMShtPpybKbx31m960TWI4EFNQpqB6foKpoNN+tE+K7sIGUTxlrPvytUnnZqZ7HC
 oS1g==
X-Gm-Message-State: AC+VfDx98AcjJsXI0Ydo1ym75SwoeKyKFMNHEicRTfXwJiZPjAoQJFCI
 j0ovh6iTXI0q0rCFM3Y0U13bo6hzMN+JyM/fOSmwoA==
X-Google-Smtp-Source: ACHHUZ4oFOMHXiPxg1/YyAQjtjar4IUyGyOEgNcFH+cLLVYSLkL6w8ALHa/aYIZL7W944gYDF8Ft8C3q0MBArF0/5iE=
X-Received: by 2002:a4a:e057:0:b0:558:aaae:1dd8 with SMTP id
 v23-20020a4ae057000000b00558aaae1dd8mr1836073oos.0.1686069745534; Tue, 06 Jun
 2023 09:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAP5Nno6LjKpvwmvFXoAo3bNpCSkVJTKe+ENxjGf8kt4ENAEMyg@mail.gmail.com>
 <CAFEAcA-qVPABh-B8D7Ds20NwT_zGq9t_za9xFR-x2mfNjUMuYg@mail.gmail.com>
In-Reply-To: <CAFEAcA-qVPABh-B8D7Ds20NwT_zGq9t_za9xFR-x2mfNjUMuYg@mail.gmail.com>
From: Jun Sun <jsun@junsun.net>
Date: Tue, 6 Jun 2023 09:42:17 -0700
Message-ID: <CAP5Nno76ofD7rsYJxBx9Kv52z0ut=Lz3FS1eXVgVyokX8wNdTg@mail.gmail.com>
Subject: Re: [PATCH risu] --group option to allow all instructions in the
 specified groups.
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003fdcb505fd78b4ca"
Received-SPF: none client-ip=2607:f8b0:4864:20::c33;
 envelope-from=jsun@junsun.net; helo=mail-oo1-xc33.google.com
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

--0000000000003fdcb505fd78b4ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see. I think your suggestion makes sense, i.e., groups specified in one
line means intersection of groups, while multiple --group lines mean union
of groups.

BTW, I have moved along and added many new features to risu, including
generating instructions as shared libraries (instead of raw binary files),
multiple instruction sequence, etc.  If these are interesting to the
community, I will try to find time and submit.  There are a lot of works to
make a proper patch than just making my hack. :)

Jun

On Tue, May 9, 2023 at 5:43=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Wed, 3 May 2023 at 17:35, Jun Sun <jsun@junsun.net> wrote:
> >
> >
> > Current semantic is a little strange when multiple --group options are
> specified.
> > In this case,  only instructions in *all* these groups (i.e.,
> intersection) are used for
> > generation, which is not very useful at all.  This patch changes the
> semantic to
> > include all instructions in these groups (i.e., union) for sequence
> generation.
>
> The commit message which added the --group option specifically
> documents a case where it is useful:
>
>       ./risugen --group v8.2,Cryptographic aarch64.risu v8.2-crypto.bin
>
> where you want to say "only test the v8.2 crypto insns"
> (i.e. not any crypto insns from other architecture versions,
> and not any non-crypto insns).
> Changing the semantics to union would break this.
>
> Being able to specify that you want insns from multiple
> groups seems like it would be useful, but we should add
> it in a way that doesn't break the existing uses.
>
> One idea that occurs to me is that you could allow
> multiple --group options to mean "union of these"
> and multiple groups within a --group to mean "intersection".
> So for instance
>  --group v8.2,Cryptographic --group v8_3_compnum
> would select all the insns that are
>    (v8.2 AND cryptographic) OR v8_3_compnum
>
> (This does technically break some existing commandlines
> because the current code makes "--group A --group B"
> do the same thing as "--group A,B".)
>
> Alex, you added the --group option -- what do you think?
>
> > diff --git a/risugen_arm.pm b/risugen_arm.pm
> > index 2dc144d..dc08ec0 100644
> > --- a/risugen_arm.pm
> > +++ b/risugen_arm.pm
> > @@ -1112,6 +1112,7 @@ sub write_test_code($$$$$$$$$)
> >      }
> >
> >      print "Generating code using patterns: @keys...\n";
> > +    print "Total insn patterns : " . $#keys . "\n";
> >      progress_start(78, $numinsns);
> >
> >      if ($fp_enabled) {
>
> These changes seem unrelated to the --group option.
>
> thanks
> -- PMM
>

--0000000000003fdcb505fd78b4ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I see. I think your suggestion makes sense, i.e., groups s=
pecified in one line means intersection of groups, while multiple --group l=
ines mean union of groups.<div><br></div><div>BTW, I have moved along and a=
dded many new features to risu, including generating instructions as shared=
 libraries=C2=A0(instead of raw binary files), multiple instruction sequenc=
e, etc.=C2=A0 If these are interesting to the community, I will try to find=
 time and submit.=C2=A0 There are a lot of works to make a proper patch tha=
n just making my hack. :)</div><div><br></div><div>Jun</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 9, =
2023 at 5:43=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@l=
inaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Wed, 3 May 2023 at 17:35, Jun Sun &lt=
;<a href=3D"mailto:jsun@junsun.net" target=3D"_blank">jsun@junsun.net</a>&g=
t; wrote:<br>
&gt;<br>
&gt;<br>
&gt; Current semantic is a little strange when multiple --group options are=
 specified.<br>
&gt; In this case,=C2=A0 only instructions in *all* these groups (i.e., int=
ersection) are used for<br>
&gt; generation, which is not very useful at all.=C2=A0 This patch changes =
the semantic to<br>
&gt; include all instructions in these groups (i.e., union) for sequence ge=
neration.<br>
<br>
The commit message which added the --group option specifically<br>
documents a case where it is useful:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 ./risugen --group v8.2,Cryptographic aarch64.risu v8.2=
-crypto.bin<br>
<br>
where you want to say &quot;only test the v8.2 crypto insns&quot;<br>
(i.e. not any crypto insns from other architecture versions,<br>
and not any non-crypto insns).<br>
Changing the semantics to union would break this.<br>
<br>
Being able to specify that you want insns from multiple<br>
groups seems like it would be useful, but we should add<br>
it in a way that doesn&#39;t break the existing uses.<br>
<br>
One idea that occurs to me is that you could allow<br>
multiple --group options to mean &quot;union of these&quot;<br>
and multiple groups within a --group to mean &quot;intersection&quot;.<br>
So for instance<br>
=C2=A0--group v8.2,Cryptographic --group v8_3_compnum<br>
would select all the insns that are<br>
=C2=A0 =C2=A0(v8.2 AND cryptographic) OR v8_3_compnum<br>
<br>
(This does technically break some existing commandlines<br>
because the current code makes &quot;--group A --group B&quot;<br>
do the same thing as &quot;--group A,B&quot;.)<br>
<br>
Alex, you added the --group option -- what do you think?<br>
<br>
&gt; diff --git a/<a href=3D"http://risugen_arm.pm" rel=3D"noreferrer" targ=
et=3D"_blank">risugen_arm.pm</a> b/<a href=3D"http://risugen_arm.pm" rel=3D=
"noreferrer" target=3D"_blank">risugen_arm.pm</a><br>
&gt; index 2dc144d..dc08ec0 100644<br>
&gt; --- a/<a href=3D"http://risugen_arm.pm" rel=3D"noreferrer" target=3D"_=
blank">risugen_arm.pm</a><br>
&gt; +++ b/<a href=3D"http://risugen_arm.pm" rel=3D"noreferrer" target=3D"_=
blank">risugen_arm.pm</a><br>
&gt; @@ -1112,6 +1112,7 @@ sub write_test_code($$$$$$$$$)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 print &quot;Generating code using patterns: @keys.=
..\n&quot;;<br>
&gt; +=C2=A0 =C2=A0 print &quot;Total insn patterns : &quot; . $#keys . &qu=
ot;\n&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 progress_start(78, $numinsns);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if ($fp_enabled) {<br>
<br>
These changes seem unrelated to the --group option.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000003fdcb505fd78b4ca--

