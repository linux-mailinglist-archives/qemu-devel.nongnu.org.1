Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1718263F3
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 12:53:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMRhC-0000AF-AN; Sun, 07 Jan 2024 06:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRh9-0000A3-IR
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 06:51:59 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRh7-0002yI-28
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 06:51:59 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-429931ed461so1055491cf.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 03:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704628193; x=1705232993;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J2vVAeIVQt43YnIwy95YaSFW1BZqQtX1zQ6jzGpmrko=;
 b=Cho3bXZbaMXerwNXi7+Izd0Tk56Lkm0c8dEiFY0PsdE1aPfWJ2f1mZbkhJZQcGL/Jg
 2PCZS5zjQoJkhxpvB2GHUjXDNZhasCuZyyiRbWI7TCUyQ3Q5wKJAb6R0hIYHwTJXqt8L
 rnLt6AmrdDGnoVR+LgoyvNecmQvZS/a+zKUzzjuJW5FPhom8U6WqWDMtm3S0cn6h2Iim
 2qj93u1x/EJim8Sj127SOFyr1VFezB2hGKuBjR5ANbKNIHa6dBHqPMKj72SDOFaV/Cqq
 DolCFAi/ASb7jy+1NEYjzdbJn/GLO4VOmBxGInPLf08S1Bs8dYtIhnKzw6i2+eUeZnw7
 o0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704628193; x=1705232993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J2vVAeIVQt43YnIwy95YaSFW1BZqQtX1zQ6jzGpmrko=;
 b=LT4ySv4qqDgGXNgxHajuXTx8HQxuJb/TH8WJ+KBPi0y0EXnwPFBAmWgJOr18hQKwRS
 XhB90NE3ArZ2A+YEJYBHkkvokWautTSJVfrRptjnvc0ARWW2B5qWiTm84oSltLN+vEwn
 81IiH0zvkGmV5Awe7W02WmyM+OPa5irIBxnb8qbPbAzBPxpEnLQttV/GJ144wL5/ugDU
 fXSQprasOEP4R2U0/u89h0bnmdrwETE4HtsajTnXHlMBJQ3uIvgOIwgLVlsciDB/9eBp
 ixPc7Oe0ihiNOK/YUWlXtAz+u92qakUBxekchuBbvcwrvHRdsgHdkFrFa+8WQzSJKA6k
 eHiw==
X-Gm-Message-State: AOJu0YwBYbRhP6Hhoqu4TeBl4Ky83tOfOJpewNhfZZpK4NSOmoNCDt2h
 016iOn9BVvmLUGspuJjN69jxcdVns53CoWozIAxWD7dyiKXVBQ==
X-Google-Smtp-Source: AGHT+IFY5Q1Cq9E9ZI8MQwQZ0tpCHkm1/J3/DWlPL+tO6Ys+ySLRiem08oLjBPAu2ZOjM0MRu6AUluQjzlTD2qCWpOM=
X-Received: by 2002:a05:622a:11d4:b0:428:3aa9:4aa9 with SMTP id
 n20-20020a05622a11d400b004283aa94aa9mr4468970qtk.20.1704628192553; Sun, 07
 Jan 2024 03:49:52 -0800 (PST)
MIME-Version: 1.0
References: <c5033954155dfe256f650fc9ca2084c688356317.1704469721.git.yong.huang@smartx.com>
 <87wmsneno0.fsf@draig.linaro.org>
In-Reply-To: <87wmsneno0.fsf@draig.linaro.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Sun, 7 Jan 2024 19:49:36 +0800
Message-ID: <CAK9dgmZ5GzOzuxxKqEQ33mCtjBkNMCJAShPbKAxNYGnf_MeC0w@mail.gmail.com>
Subject: Re: [PATCH] i386/sev: Nitpick at the error message's output
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e44309060e59ad59"
Received-SPF: none client-ip=2607:f8b0:4864:20::82a;
 envelope-from=yong.huang@smartx.com; helo=mail-qt1-x82a.google.com
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

--000000000000e44309060e59ad59
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 12:43=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Hyman Huang <yong.huang@smartx.com> writes:
>
> > The incorrect error message was produced as a result of
> > the return number being disregarded on the sev_kvm_init
> > failure path.
> >
> > For instance, when a user's failure to launch a SEV guest
> > is caused by an incorrect IOCTL, the following message is
> > reported:
> >
> > kvm: sev_kvm_init: failed to initialize ret=3D-25 fw_error=3D0
> > kvm: failed to initialize kvm: Operation not permitted
> >
> > While the error message's accurate output should be:
> >
> > kvm: sev_kvm_init: failed to initialize ret=3D-25 fw_error=3D0
> > kvm: failed to initialize kvm: Inappropriate ioctl for device
> >
> > Fix this by returning the return number directly on the
> > failure path.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  target/i386/sev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index 9a71246682..4a69ca457c 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> > @@ -1019,7 +1019,7 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs,
> Error **errp)
> >  err:
> >      sev_guest =3D NULL;
> >      ram_block_discard_disable(false);
> > -    return -1;
> > +    return ret;
>
> I don't think this will be correct in all cases because there are other
> legs (e.g. if (host_cbitpos !=3D sev->cbitpos)) where ret may be the
> successful setting of ram_block_discard_disable(true).
>

Indeed, the other failed paths are overlooked by me. I'll try a
commit aiming to sort the error message on all failure paths in
the next version.


> You might want to explore if the function can be re-written with
> explicit return's and utilise autofree to do the clean-up of dynamic
> objects.
>
> I think this entails setting sev_guest at the end of the function just
> before the return 0.
>
> I'm not sure if there is a clean way to handle
> ram_block_discard_disable(false); cleanly for all the failure legs
> though. Maybe someone with more familiarity with the code has some ideas?
>
>
> >  }
> >
> >  int
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>


--=20
Best regards

--000000000000e44309060e59ad59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 6, 202=
4 at 12:43=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@li=
naro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">=
yong.huang@smartx.com</a>&gt; writes:<br>
<br>
&gt; The incorrect error message was produced as a result of<br>
&gt; the return number being disregarded on the sev_kvm_init<br>
&gt; failure path.<br>
&gt;<br>
&gt; For instance, when a user&#39;s failure to launch a SEV guest<br>
&gt; is caused by an incorrect IOCTL, the following message is<br>
&gt; reported:<br>
&gt;<br>
&gt; kvm: sev_kvm_init: failed to initialize ret=3D-25 fw_error=3D0<br>
&gt; kvm: failed to initialize kvm: Operation not permitted<br>
&gt;<br>
&gt; While the error message&#39;s accurate output should be:<br>
&gt;<br>
&gt; kvm: sev_kvm_init: failed to initialize ret=3D-25 fw_error=3D0<br>
&gt; kvm: failed to initialize kvm: Inappropriate ioctl for device<br>
&gt;<br>
&gt; Fix this by returning the return number directly on the<br>
&gt; failure path.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/i386/sev.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/target/i386/sev.c b/target/i386/sev.c<br>
&gt; index 9a71246682..4a69ca457c 100644<br>
&gt; --- a/target/i386/sev.c<br>
&gt; +++ b/target/i386/sev.c<br>
&gt; @@ -1019,7 +1019,7 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, =
Error **errp)<br>
&gt;=C2=A0 err:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sev_guest =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ram_block_discard_disable(false);<br>
&gt; -=C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
<br>
I don&#39;t think this will be correct in all cases because there are other=
<br>
legs (e.g. if (host_cbitpos !=3D sev-&gt;cbitpos)) where ret may be the<br>
successful setting of ram_block_discard_disable(true).<br></blockquote><div=
><br></div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-s=
erif"></font><span style=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms, =
sans-serif">Indeed, the other failed paths are overlooked by me. I&#39;ll t=
ry a</font></span></div><div class=3D"gmail_default"><span style=3D"color:r=
gb(0,0,0)"><font face=3D"comic sans ms, sans-serif">commit aiming to sort t=
he error message on all failure paths in</font></span></div><div class=3D"g=
mail_default"><span style=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms,=
 sans-serif">the next version.=C2=A0</font></span></div><div class=3D"gmail=
_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,20=
4);padding-left:1ex">
<br>
You might want to explore if the function can be re-written with<br>
explicit return&#39;s and utilise autofree to do the clean-up of dynamic<br=
>
objects.<br>
<br>
I think this entails setting sev_guest at the end of the function just<br>
before the return 0.<br>
<br>
I&#39;m not sure if there is a clean way to handle<br>
ram_block_discard_disable(false); cleanly for all the failure legs<br>
though. Maybe someone with more familiarity with the code has some ideas?<b=
r>
<br>
<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000e44309060e59ad59--

