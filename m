Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C5A784934
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 20:04:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYVix-0006ii-Lf; Tue, 22 Aug 2023 14:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qYViv-0006iV-H1
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:03:25 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qYVis-0006Vu-GI
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:03:25 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50078eba7afso4529613e87.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692727400; x=1693332200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x8jTfNlzysu0aRFMrH9TuGYjcLddZyK4arPK8JqvBT4=;
 b=gRm/WteQrK/s2xe54FeHhQkgrPHP0TyWuaEftpCCfQ1eDnDp7E3Ss1+N+NBtf2Kmtt
 U1Af0Pb6EkoPx1ojVp2U937ZxZi37lRgC0GeLzN8e2m+mHqAhSRpF0DOBgikDE3FvIaa
 rE1NYPggFoHORRSuavkRKhrFoNcsQVLkM7kep305aBOAAYF7IfW7LsVkf4FEB5R8uPtt
 IXqEvdTKSXP8R7LC31C2UmUsEWq7dA+BGxMRZqRIldlQwdi/6IEsNYQ6EDCW3X9aRXVQ
 mRgSA2uswAzcE+ddiBabEcbqHCx784BsbtYUXBzZn3P0nGPVyR4tBAxG0fvQW8a5Hm8R
 oT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692727400; x=1693332200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x8jTfNlzysu0aRFMrH9TuGYjcLddZyK4arPK8JqvBT4=;
 b=mD8uReuYmveIBSUQ5rnBWdTdLNCseCzS6qMUWdPajf+8zKQmajIjMXKdMEJQWq5C+Z
 PTc164qWTL3rjOfjVc+UqkMvsK8OLfIUdsNneF/WbLWKngjLoEOoPI850xIYIaGZzOQP
 SgWrxP0YM5NktzBNJ6kj2qzkdMvcV3LoF+/EZpwaw3e06QARfobhSQyZDX9ZIzs5DNk6
 CuLMTDp04eEMO3TK5lRzLJCSgYHQ3bVDCBJBWmJIeL15osHFHIDoxzc8JRsn3tCb3/AU
 eJR72XVsIQBy+Yw37ZrbQ+dkQoJzUE0zRuuWH0gDD7uR6I9B6LvK5t0QcRGAlItyZkQc
 RhvQ==
X-Gm-Message-State: AOJu0YyMAYqA8t3YdRb3CMVs19GPnlA7HYNVnIo0qkyVdGUNt1X9cLjd
 gW051zZZsjOcvts0Vc2D8lOPx8wSUJPP0vXEtWOUxg==
X-Google-Smtp-Source: AGHT+IHfxqIQaaZLzKNpwy/ilg5qIl8d/SMkM1OxdK8muxGn+bIK7/X+8OeJPonsCAZW6jfuiF/C6DpswxNs/2taZqQ=
X-Received: by 2002:a05:6512:3dac:b0:500:8249:161a with SMTP id
 k44-20020a0565123dac00b005008249161amr5687436lfv.19.1692727397857; Tue, 22
 Aug 2023 11:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-22-kariem.taha2.7@gmail.com>
 <eb0506c6-f9bd-5a1f-870b-b6d07dd337ea@linaro.org>
In-Reply-To: <eb0506c6-f9bd-5a1f-870b-b6d07dd337ea@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 22 Aug 2023 12:03:07 -0600
Message-ID: <CANCZdfrmw6c9kxFTUrWegaU78SHBjqVMEHuO8VVsPN=7hGQb0Q@mail.gmail.com>
Subject: Re: [PATCH 21/22] Implement shmat(2) and shmdt(2)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000405d09060386cf22"
Received-SPF: none client-ip=2a00:1450:4864:20::12a;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12a.google.com
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

--000000000000405d09060386cf22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 9:30=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/19/23 02:48, Karim Taha wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> > ---
> >   bsd-user/bsd-mem.h            | 72 ++++++++++++++++++++++++++++++++++=
+
> >   bsd-user/freebsd/os-syscall.c |  8 ++++
> >   2 files changed, 80 insertions(+)
> >
> > diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> > index 221ad76d8c..f737b94885 100644
> > --- a/bsd-user/bsd-mem.h
> > +++ b/bsd-user/bsd-mem.h
> > @@ -335,4 +335,76 @@ static inline abi_long do_bsd_shmctl(abi_long
> shmid, abi_long cmd,
> >       return ret;
> >   }
> >
> > +/* shmat(2) */
> > +static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int
> shmflg)
> > +{
> > +    abi_ulong raddr;
> > +    abi_long ret;
> > +    void *host_raddr;
> > +    struct shmid_ds shm_info;
> > +    int i;
> > +
> > +    /* Find out the length of the shared memory segment. */
> > +    ret =3D get_errno(shmctl(shmid, IPC_STAT, &shm_info));
> > +    if (is_error(ret)) {
> > +        /* Can't get the length */
> > +        return ret;
> > +    }
> > +
> > +    mmap_lock();
> > +
> > +    if (shmaddr) {
> > +        host_raddr =3D shmat(shmid, (void *)g2h_untagged(shmaddr),
> shmflg);
>
> Missing
>
>      if (!guest_range_valid_untagged(shmaddr, shm_info.shm_segsz)) {
>          return -TARGET_EINVAL;
>      }
>
> > +    } else {
> > +        abi_ulong mmap_start;
> > +
> > +        mmap_start =3D mmap_find_vma(0, shm_info.shm_segsz);
> > +
> > +        if (mmap_start =3D=3D -1) {
> > +            errno =3D ENOMEM;
> > +            host_raddr =3D (void *)-1;
> > +        } else {
> > +            host_raddr =3D shmat(shmid, g2h_untagged(mmap_start),
> > +                shmflg); /* | SHM_REMAP XXX WHY? */
>
> With reserved_va, the entire guest address space is mapped PROT_NONE so
> that it is
> reserved, so that the kernel does not use it for something else.  You nee=
d
> the SHM_REMAP
> to replace the reservation mapping.
>
> > +/* shmdt(2) */
> > +static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < N_BSD_SHM_REGIONS; ++i) {
> > +        if (bsd_shm_regions[i].start =3D=3D shmaddr) {
> > +            bsd_shm_regions[i].start =3D 0;
> > +            page_set_flags(shmaddr,
> > +                shmaddr + bsd_shm_regions[i].size, 0);
> > +            break;
> > +        }
> > +    }
> > +
> > +    return get_errno(shmdt(g2h_untagged(shmaddr)));
> > +}
>
> Hmm, bug with linux-user as well, because here we should re-establish the
> reserved_va
> reservation.
>

... of the shared memory region we just detached? Right?


> Also, we should not be using a fixed sized array.  Nothing good happens
> when the array
> fills up.
>

File this as https://github.com/qemu-bsd-user/qemu-bsd-user/issues/47 so we
don't forget.
It's good enough for the moment since the programs we've seen have a very
limited number
of segments... but longer term, it should be dynamic.

Warner

--000000000000405d09060386cf22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Aug 20, 2023 at 9:30=E2=80=AF=
AM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 8/19/23 02:48, Karim Taha wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.c=
om" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 72 +++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 8 ++++<br>
&gt;=C2=A0 =C2=A02 files changed, 80 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
&gt; index 221ad76d8c..f737b94885 100644<br>
&gt; --- a/bsd-user/bsd-mem.h<br>
&gt; +++ b/bsd-user/bsd-mem.h<br>
&gt; @@ -335,4 +335,76 @@ static inline abi_long do_bsd_shmctl(abi_long shm=
id, abi_long cmd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* shmat(2) */<br>
&gt; +static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int=
 shmflg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_ulong raddr;<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 void *host_raddr;<br>
&gt; +=C2=A0 =C2=A0 struct shmid_ds shm_info;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Find out the length of the shared memory segment. */=
<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(shmctl(shmid, IPC_STAT, &amp;shm_info=
));<br>
&gt; +=C2=A0 =C2=A0 if (is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Can&#39;t get the length */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mmap_lock();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (shmaddr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_raddr =3D shmat(shmid, (void *)g2h_u=
ntagged(shmaddr), shmflg);<br>
<br>
Missing<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!guest_range_valid_untagged(shmaddr, shm_info.shm_s=
egsz)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGET_EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong mmap_start;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_start =3D mmap_find_vma(0, shm_info.=
shm_segsz);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mmap_start =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host_raddr =3D (void *)-1;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host_raddr =3D shmat(shmid,=
 g2h_untagged(mmap_start),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shmflg); /* |=
 SHM_REMAP XXX WHY? */<br>
<br>
With reserved_va, the entire guest address space is mapped PROT_NONE so tha=
t it is <br>
reserved, so that the kernel does not use it for something else.=C2=A0 You =
need the SHM_REMAP <br>
to replace the reservation mapping.<br>
<br>
&gt; +/* shmdt(2) */<br>
&gt; +static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; N_BSD_SHM_REGIONS; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bsd_shm_regions[i].start =3D=3D shmad=
dr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bsd_shm_regions[i].start =
=3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 page_set_flags(shmaddr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shmaddr + bsd=
_shm_regions[i].size, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return get_errno(shmdt(g2h_untagged(shmaddr)));<br>
&gt; +}<br>
<br>
Hmm, bug with linux-user as well, because here we should re-establish the r=
eserved_va <br>
reservation.<br></blockquote><div><br></div><div>... of the shared memory r=
egion we just detached? Right?</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
Also, we should not be using a fixed sized array.=C2=A0 Nothing good happen=
s when the array <br>
fills up.<br></blockquote><div><br></div><div>File this as=C2=A0<a href=3D"=
https://github.com/qemu-bsd-user/qemu-bsd-user/issues/47">https://github.co=
m/qemu-bsd-user/qemu-bsd-user/issues/47</a> so we don&#39;t forget.</div><d=
iv>It&#39;s good enough for the moment since the programs we&#39;ve seen ha=
ve a very limited number</div><div>of segments... but longer term, it shoul=
d be dynamic.</div><div><br></div><div>Warner=C2=A0</div></div></div>

--000000000000405d09060386cf22--

