Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C558781FFF
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 22:43:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXpFi-0003fb-Ox; Sun, 20 Aug 2023 16:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXpFg-0003fJ-DB
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:42:24 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXpFd-0007N5-7r
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:42:24 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2bcc187e0b5so1647801fa.1
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692564138; x=1693168938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zON/STvBxOLO8n7uKuCTtgRMekv+sjm7cuxlGtw8pM0=;
 b=Db1Ikr/HuoJozFAwsjtCDGJwODaQhmjoQD8uNPwY24bsIlsx1CcmNUmb75Fjm17XHb
 RVZc/6tSigN/cNEdKXAUgVRFmpftperjyy/AIBKhR8GngLGGyiSP+d1Qg/mbHOs/Nf7/
 PjLOl6oCYFMYLpyN1D0ykAAO31ilK1bajyZYlm0fCWrmFV+9sIg0XSuOQIJYfY2XL7g1
 7l9q24QlVhrleJhtXwUloEqaFT4jA6FYh9ms2K32Y/AAQEFEkDFHeZyXEPBYAmGQVF8P
 2R+4nF+yqaI7V+oNosBcm6MjKlQM/XFmlvybbDbNl1lLPbAjmZvY6BmhogbVSE2M6qOf
 F2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692564138; x=1693168938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zON/STvBxOLO8n7uKuCTtgRMekv+sjm7cuxlGtw8pM0=;
 b=XPVbAO7GTByE39rYe7pFdLPvbN1TzpIuXpg8/p3LSjtDBC4G5Xc1Qqtq+UU/+zxAMj
 f08/rA7Xd8u/wlQMWPz5sPrkcSjfclaqvjHVoZZZRG/idtv4wKBa9L1cvVA9Z72mUujU
 hcoXOz1cAJLXZjVIcBOfCnuuqrA0VfE+m21ZZerf44w65snYfjcKVC5w7KJo6LXnhHaw
 4sCCn7D/l4upGA4BKqIht7PtgshQzO2H7nnIZ+N2WxQY55/jei/g7+aQZ/TaD4vcr8Ip
 cn3GOLoNCLAw4C93Qw+DJgUP5RIU5nM+81tkIXXfPW5sUMBiAMbc0IoxxeVr45aHXRjA
 0hxA==
X-Gm-Message-State: AOJu0YwHfCFcjwTSpTNI01iq0Z7NgGDoF18NT2GQY33NNpLDuGgPLo1c
 BUTwwlKbacJ6li1FkA9A+usa0hORJ9BEtQZnTy1PTg==
X-Google-Smtp-Source: AGHT+IEhQICgK9kWd1/Wf5HPY4dMBP/MyzmkTJ9vJFBmmPw9yfHrkcUIdocQjuGwxuFiqPAFNnwUL6JMdRy4nU5Z5mM=
X-Received: by 2002:a2e:8e97:0:b0:2b6:a08d:e142 with SMTP id
 z23-20020a2e8e97000000b002b6a08de142mr3383773ljk.7.1692564137650; Sun, 20 Aug
 2023 13:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-23-kariem.taha2.7@gmail.com>
 <a19d1f1d-c303-c413-86ad-7edfb237cb7f@linaro.org>
In-Reply-To: <a19d1f1d-c303-c413-86ad-7edfb237cb7f@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 20 Aug 2023 14:42:06 -0600
Message-ID: <CANCZdfpr8=cf2gDg8Ex84ExhZcLgKXcWUOQ=nrCbeDm77Xyo1A@mail.gmail.com>
Subject: Re: [PATCH 22/22] Add stubs for vadvise(), sbrk() and sstk()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000002f4635060360cc4f"
Received-SPF: none client-ip=2a00:1450:4864:20::230;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x230.google.com
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

--0000000000002f4635060360cc4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 9:35=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/19/23 02:48, Karim Taha wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > The above system calls are not supported by qemu.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> > ---
> >   bsd-user/bsd-mem.h            | 21 +++++++++++++++++++++
> >   bsd-user/freebsd/os-syscall.c | 12 ++++++++++++
> >   2 files changed, 33 insertions(+)
> >
> > diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> > index f737b94885..274178bef7 100644
> > --- a/bsd-user/bsd-mem.h
> > +++ b/bsd-user/bsd-mem.h
> > @@ -407,4 +407,25 @@ static inline abi_long do_bsd_shmdt(abi_ulong
> shmaddr)
> >       return get_errno(shmdt(g2h_untagged(shmaddr)));
> >   }
> >
> > +static inline abi_long do_bsd_vadvise(void)
> > +{
> > +    /* See sys_ovadvise() in vm_unix.c */
> > +    qemu_log("qemu: Unsupported syscall vadvise()\n");
> > +    return -TARGET_ENOSYS;
> > +}
>
> I see EINVAL not ENOSYS.
>

When the system call isn't present at all, it's ENOSYS + SIGSYS (I have
patches to implement this
that developers love, but users hate it since many programs cope OK when an
error is returned for
obscure system calls). When it is present, it's implemented as EINVAL. So
maybe the right thing
here is to remove the log and just return EINVAL for the implementation.


> > +static inline abi_long do_bsd_sbrk(void)
> > +{
> > +    /* see sys_sbrk() in vm_mmap.c */
> > +    qemu_log("qemu: Unsupported syscall sbrk()\n");
> > +    return -TARGET_ENOSYS;
> > +}
> > +
> > +static inline abi_long do_bsd_sstk(void)
> > +{
> > +    /* see sys_sstk() in vm_mmap.c */
> > +    qemu_log("qemu: Unsupported syscall sstk()\n");
> > +    return -TARGET_ENOSYS;
> > +}
>
> I see EOPNOTSUPP not ENOSYS.
>

Same comment as above: we should just return EOPNOSUPP and call it
implemented.


> I don't see any point in logging these.
>

Yea, that's a general pattern that we have upstream, but there's a
catch-all 'default' case that does
the logging with the right mask.

Warner

--0000000000002f4635060360cc4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Aug 20, 2023 at 9:35=E2=80=AF=
AM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 8/19/23 02:48, Karim Taha wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; The above system calls are not supported by qemu.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.c=
om" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 21 +++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-syscall.c | 12 ++++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 33 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
&gt; index f737b94885..274178bef7 100644<br>
&gt; --- a/bsd-user/bsd-mem.h<br>
&gt; +++ b/bsd-user/bsd-mem.h<br>
&gt; @@ -407,4 +407,25 @@ static inline abi_long do_bsd_shmdt(abi_ulong shm=
addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return get_errno(shmdt(g2h_untagged(shmaddr)=
));<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static inline abi_long do_bsd_vadvise(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* See sys_ovadvise() in vm_unix.c */<br>
&gt; +=C2=A0 =C2=A0 qemu_log(&quot;qemu: Unsupported syscall vadvise()\n&qu=
ot;);<br>
&gt; +=C2=A0 =C2=A0 return -TARGET_ENOSYS;<br>
&gt; +}<br>
<br>
I see EINVAL not ENOSYS.<br></blockquote><div><br></div><div>When the syste=
m call isn&#39;t present at all, it&#39;s ENOSYS=C2=A0+ SIGSYS (I have patc=
hes to implement this</div><div>that developers love, but users hate it sin=
ce many programs cope OK when an error=C2=A0is returned for</div><div>obscu=
re system calls). When it is present, it&#39;s implemented as EINVAL. So ma=
ybe the right thing</div><div>here is to remove the log and just return EIN=
VAL for the implementation.</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
&gt; +static inline abi_long do_bsd_sbrk(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* see sys_sbrk() in vm_mmap.c */<br>
&gt; +=C2=A0 =C2=A0 qemu_log(&quot;qemu: Unsupported syscall sbrk()\n&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 return -TARGET_ENOSYS;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline abi_long do_bsd_sstk(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* see sys_sstk() in vm_mmap.c */<br>
&gt; +=C2=A0 =C2=A0 qemu_log(&quot;qemu: Unsupported syscall sstk()\n&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 return -TARGET_ENOSYS;<br>
&gt; +}<br>
<br>
I see EOPNOTSUPP not ENOSYS.<br></blockquote><div><br></div><div>Same comme=
nt as above: we should just return EOPNOSUPP=C2=A0and call it implemented.<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
I don&#39;t see any point in logging these.<br></blockquote><div><br></div>=
<div>Yea, that&#39;s a general pattern that we have upstream, but there&#39=
;s a catch-all &#39;default&#39; case that does</div><div>the logging with =
the right mask.</div><div><br></div><div>Warner</div></div></div>

--0000000000002f4635060360cc4f--

