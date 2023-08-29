Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D63F78D08E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:28:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7o1-0001ux-8p; Tue, 29 Aug 2023 19:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb62T-0000cA-UC
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:14:20 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb62Q-0004Bv-RO
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:14:17 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99c1d03e124so632701466b.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693343652; x=1693948452;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u6UPXPIoAhAVR22uu9vDmx+zm3ew0X6QqFlB6xZqMjA=;
 b=iIjzSZFO39aRTZMXdo4qv/AUKU8MNck8rD3cB7oMbCFmJ+F73G7uo+5AeUaB+5zuGv
 BpiPUa+f54iOn0hZXHY82P9CimysB1jUyw2ygEasbt9n/wWqvkPHEmkZpVBi+H/QHons
 A90nb6+CFJemzvDyuRsnemJnY+1fog00TcVguqvJqQtqtcJJ9Q6k3YbdZar3RbmhmbBQ
 JFdmLBu3YO9Kf0uX4pE7A2FjAUwIIomDqb3/FEW8nP1JMz8FJfYd+XvR9OuYviWu6IRG
 vm0IbRR05vFhZ9A7xPXy/MIed41L7LtP3dp4hgTjPs2L6xEFCdDz00jAZ0RHcO0CkOYB
 RxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693343652; x=1693948452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u6UPXPIoAhAVR22uu9vDmx+zm3ew0X6QqFlB6xZqMjA=;
 b=bHh5oBred50N8N98t5W3s3WzbKrkDRH3pSthxQv6Fq40B8FdFCnPgOr3dQL3zhZSD0
 sXgHTVrOTpaGalhXlV6I7Hxrno/cCqk9/vwa0p+qUaOBKPyETV5J48MImlPp00u5T8jU
 pJO2ki8QhTI9lMPBd8LWHx7R5G4QFmKbPS3MM1sUJRk0+QXrpxKm0I0dYp4vI51HHOQP
 mcdfrzmgBmSVh6Ci9Qa6GQ4Cf1f1c54m09EG63UvDEQ0TmcH2K9MpAEIeI8M3aMuhYIa
 snnb3YovG4tfsYpDrJ9T0Q1h3JKA51AVHULRBXpZdBVSLhVYROIUhtXbo58NwOrGgCXw
 XfTA==
X-Gm-Message-State: AOJu0YxLZnSHXJ804wWlZDbdoaWGpz4Oh5rnXYJOXD4/Vrrpihfhjupo
 0YD6/cnd61LQlxLVWRbRbr3RYXJ8d774Aq6obnjKlA==
X-Google-Smtp-Source: AGHT+IHq8ck0zK8dTOEchF1gOkJpn76T2/cbabQ9CbrMSJz3bOl9opT8pyAxlbjQHOTn5KYZxmGcDCt2+IoQcxtokuc=
X-Received: by 2002:a17:906:1cf:b0:99d:ec81:df58 with SMTP id
 15-20020a17090601cf00b0099dec81df58mr138207ejj.19.1693343652336; Tue, 29 Aug
 2023 14:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-30-kariem.taha2.7@gmail.com>
 <f2150b44-e20a-2bb2-4764-d0668497708e@linaro.org>
In-Reply-To: <f2150b44-e20a-2bb2-4764-d0668497708e@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 29 Aug 2023 15:14:01 -0600
Message-ID: <CANCZdfpTGsXCs6e2CiSfWfos7BRWg+hn-CMnkE2S_+NA9Scjqw@mail.gmail.com>
Subject: Re: [PATCH 29/32] bsd-user: Implement pdgetpid(2) and the
 undocumented setugid.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000e16a840604164ad4"
Received-SPF: none client-ip=2a00:1450:4864:20::631;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000e16a840604164ad4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 2:36=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/27/23 08:57, Karim Taha wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> > ---
> >   bsd-user/freebsd/os-proc.h    | 23 +++++++++++++++++++++++
> >   bsd-user/freebsd/os-syscall.c |  8 ++++++++
> >   2 files changed, 31 insertions(+)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> > +/* undocumented __setugid */
> > +static inline abi_long do_freebsd___setugid(abi_long arg1)
> > +{
> > +    return get_errno(__setugid(arg1));
> > +}
>
> Given that this is
>
> #ifdef REGRESSION
> ...
> #else /* !REGRESSION */
>          return (ENOSYS);
> #endif /* REGRESSION */
>
> in current freebsd, we could probably just stub this out?
>

I agree...

The REGRESSION kernel option exists only so that the
tools/regression/security/proc_to_proc tests
can run. this is an interesting set of tests, but hasn't been updated since
2004, except for the
usual 'churn' commits required by sweeps for new-compiler things, or
project policy changes.
So it's not even clear if this specific regression test is still
interesting (though there are many
other tests in the tree that are recent and under active development).

So it's irrelevant to the bsd-user emulator, and returning ENOSYS will
match perfectly what almost any
kernel deployed will do.

Warner

--000000000000e16a840604164ad4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 29, 2023 at 2:36=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 8/27/23 08:57, Karim Taha wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.c=
om" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 23 +++++++++++++=
++++++++++<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 8 ++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 31 insertions(+)<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
&gt; +/* undocumented __setugid */<br>
&gt; +static inline abi_long do_freebsd___setugid(abi_long arg1)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return get_errno(__setugid(arg1));<br>
&gt; +}<br>
<br>
Given that this is<br>
<br>
#ifdef REGRESSION<br>
...<br>
#else /* !REGRESSION */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (ENOSYS);<br>
#endif /* REGRESSION */<br>
<br>
in current freebsd, we could probably just stub this out?<br></blockquote><=
div><br></div><div>I agree...</div><div><br></div><div>The REGRESSION kerne=
l option exists only so that the tools/regression/security/proc_to_proc tes=
ts</div><div>can run. this is an interesting set of tests, but hasn&#39;t b=
een updated since 2004, except for the</div><div>usual &#39;churn&#39; comm=
its required by sweeps for new-compiler things, or project policy changes.<=
/div><div>So it&#39;s not even clear if this specific regression test is st=
ill interesting (though there are many</div><div>other tests in the tree th=
at are recent and under active development).</div><div><br></div><div>So it=
&#39;s irrelevant to the bsd-user emulator, and returning ENOSYS will match=
 perfectly what almost any</div><div>kernel deployed will do.</div><div><br=
></div><div>Warner</div></div></div>

--000000000000e16a840604164ad4--

