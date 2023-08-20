Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99436781C6C
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:45:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXaJV-00012t-Uk; Sun, 20 Aug 2023 00:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaJM-00011g-Ef
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:45:12 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaJG-0002qn-Nl
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:45:10 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso285493566b.2
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692506705; x=1693111505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LVZ1v2U9CWTWSY+BqDVMo+oZl8OhrckMW31gfwziNT4=;
 b=vGNxlgOiLER9JjEd3l0XPMDFIMtGbNxrR7pLGtWqbW7HxNQsMgPknf4QhCNglyGfQE
 p7tz4DAYTsLAGsS56MUI4QmgCSDbI8VWZzi1JM46A0HkJlzBaJFPd0WABfY3uRmTp2me
 bw0QMuJ+KIg8cPEY/4/C6qGdUbPy9gCJ0HjuTpKOa+IKn4w/tCXkax21EllONuMw3Lrm
 /oClSk+8x86SunvVWGN8ykiG1b2kFGjWgH3YtCQ+Hu035bKZn54bV0JRGt6hT9XqkwUZ
 q+5ZLjfgtVuWOPoenHSCj/rhtkg69bh5sv2SKPkfs3L+qV+iioCb/6ZpG9+nR5KcbCBP
 7O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692506705; x=1693111505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LVZ1v2U9CWTWSY+BqDVMo+oZl8OhrckMW31gfwziNT4=;
 b=CKSYbqKw4TLxex+W6BFdGHcIReCDj/qrICOpXNrZ01rvalGFKZ+niUWGJkFysDtwlc
 jq6/SES3Dy0lozoxYinOBgiBP8DNHDc9lZLlhuLldtDlly1QUOZlYZC88U0NP86K3O0M
 gBj6GhUGrMPvtJNo+wcv77pYHXIXzUruypekGNzxGeUXOdBzLJBWJB/xiCuWipakDa8f
 NGFYmmTudfVjHx0zT/nmTDpUz2GJ98priHErI6bgGBX4kGr0mGDDTEhn9S+Xf8BFgJx5
 t+RoSl9jiGWTCl3Ou/vfqY8W+3XgQ35rR4cz2M5th3hynAgYAqYKCm+q39IjyMiEhmRg
 QW3w==
X-Gm-Message-State: AOJu0YwHpckiudd5j/wwPNTbuQdAmr0VHPIAns6EKFCRCot1Pn9WSs4p
 m32DltMbc6HdQlTtg7tRhQQyCQ4SsT1exkDUXPl6kA==
X-Google-Smtp-Source: AGHT+IE7ocb52l/CymoH90UPnqp8VPMaKWFQDdusVw64qCahHEXVihOkW9papwjqOz7j4qkTPYYOqawK3Zen4b1sXrg=
X-Received: by 2002:a17:907:7818:b0:99b:d178:f051 with SMTP id
 la24-20020a170907781800b0099bd178f051mr2552508ejc.64.1692506705083; Sat, 19
 Aug 2023 21:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-22-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-22-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:44:57 -0600
Message-ID: <CANCZdfqHkJDj+y0MBcNCRJhJehXAHrY31qYZL_nnLeExUn1hLw@mail.gmail.com>
Subject: Re: [PATCH 21/22] Implement shmat(2) and shmdt(2)
To: Karim Taha <kariem.taha2.7@gmail.com>, Kyle Evans <kevans@freebsd.org>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000efcbea0603536cee"
Received-SPF: none client-ip=2a00:1450:4864:20::630;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x630.google.com
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

--000000000000efcbea0603536cee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:49=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.h            | 72 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  8 ++++
>  2 files changed, 80 insertions(+)
>
> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index 221ad76d8c..f737b94885 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -335,4 +335,76 @@ static inline abi_long do_bsd_shmctl(abi_long shmid,
> abi_long cmd,
>      return ret;
>  }
>
> +/* shmat(2) */
> +static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int
> shmflg)
> +{
> +    abi_ulong raddr;
> +    abi_long ret;
> +    void *host_raddr;
> +    struct shmid_ds shm_info;
> +    int i;
> +
> +    /* Find out the length of the shared memory segment. */
> +    ret =3D get_errno(shmctl(shmid, IPC_STAT, &shm_info));
> +    if (is_error(ret)) {
> +        /* Can't get the length */
> +        return ret;
> +    }
> +
> +    mmap_lock();
> +
> +    if (shmaddr) {
> +        host_raddr =3D shmat(shmid, (void *)g2h_untagged(shmaddr), shmfl=
g);
> +    } else {
> +        abi_ulong mmap_start;
> +
> +        mmap_start =3D mmap_find_vma(0, shm_info.shm_segsz);
> +
> +        if (mmap_start =3D=3D -1) {
> +            errno =3D ENOMEM;
> +            host_raddr =3D (void *)-1;
> +        } else {
> +            host_raddr =3D shmat(shmid, g2h_untagged(mmap_start),
> +                shmflg); /* | SHM_REMAP XXX WHY? */
>

I was all set to hit reviewed by on this, but this has me curious. Kyle (or
anybody else) do
you know the back story here. git blame is less than helpful.

Warner


> +        }
> +    }
> +
> +    if (host_raddr =3D=3D (void *)-1) {
> +        mmap_unlock();
> +        return get_errno((long)host_raddr);
> +    }
> +    raddr =3D h2g((unsigned long)host_raddr);
> +
> +    page_set_flags(raddr, raddr + shm_info.shm_segsz,
> +        PAGE_VALID | PAGE_READ | ((shmflg & SHM_RDONLY) ? 0 :
> PAGE_WRITE));
> +
> +    for (i =3D 0; i < N_BSD_SHM_REGIONS; i++) {
> +        if (bsd_shm_regions[i].start =3D=3D 0) {
> +            bsd_shm_regions[i].start =3D raddr;
> +            bsd_shm_regions[i].size =3D shm_info.shm_segsz;
> +            break;
> +        }
> +    }
> +
> +    mmap_unlock();
> +    return raddr;
> +}
> +
> +/* shmdt(2) */
> +static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < N_BSD_SHM_REGIONS; ++i) {
> +        if (bsd_shm_regions[i].start =3D=3D shmaddr) {
> +            bsd_shm_regions[i].start =3D 0;
> +            page_set_flags(shmaddr,
> +                shmaddr + bsd_shm_regions[i].size, 0);
> +            break;
> +        }
> +    }
> +
> +    return get_errno(shmdt(g2h_untagged(shmaddr)));
> +}
> +
>  #endif /* BSD_USER_BSD_MEM_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index 9681c65ce9..f76bc1eb38 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -559,6 +559,14 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          ret =3D do_bsd_shmctl(arg1, arg2, arg3);
>          break;
>
> +    case TARGET_FREEBSD_NR_shmat: /* shmat(2) */
> +        ret =3D do_bsd_shmat(arg1, arg2, arg3);
> +        break;
> +
> +    case TARGET_FREEBSD_NR_shmdt: /* shmdt(2) */
> +        ret =3D do_bsd_shmdt(arg1);
> +        break;
> +
>          /*
>           * Misc
>           */
> --
> 2.40.0
>
>

--000000000000efcbea0603536cee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:49=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 72 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 8 ++++<br>
=C2=A02 files changed, 80 insertions(+)<br>
<br>
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
index 221ad76d8c..f737b94885 100644<br>
--- a/bsd-user/bsd-mem.h<br>
+++ b/bsd-user/bsd-mem.h<br>
@@ -335,4 +335,76 @@ static inline abi_long do_bsd_shmctl(abi_long shmid, a=
bi_long cmd,<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+/* shmat(2) */<br>
+static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int shmf=
lg)<br>
+{<br>
+=C2=A0 =C2=A0 abi_ulong raddr;<br>
+=C2=A0 =C2=A0 abi_long ret;<br>
+=C2=A0 =C2=A0 void *host_raddr;<br>
+=C2=A0 =C2=A0 struct shmid_ds shm_info;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 /* Find out the length of the shared memory segment. */<br>
+=C2=A0 =C2=A0 ret =3D get_errno(shmctl(shmid, IPC_STAT, &amp;shm_info));<b=
r>
+=C2=A0 =C2=A0 if (is_error(ret)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Can&#39;t get the length */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 mmap_lock();<br>
+<br>
+=C2=A0 =C2=A0 if (shmaddr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_raddr =3D shmat(shmid, (void *)g2h_untagg=
ed(shmaddr), shmflg);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong mmap_start;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_start =3D mmap_find_vma(0, shm_info.shm_s=
egsz);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mmap_start =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D ENOMEM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host_raddr =3D (void *)-1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host_raddr =3D shmat(shmid, g2h_=
untagged(mmap_start),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shmflg); /* | SHM_=
REMAP XXX WHY? */<br></blockquote><div><br></div><div>I was all set to hit =
reviewed by on this, but this has me curious. Kyle (or anybody else) do</di=
v><div>you know the back story here. git blame is less than helpful.</div><=
div><br></div><div>Warner<br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (host_raddr =3D=3D (void *)-1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_unlock();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_errno((long)host_raddr);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 raddr =3D h2g((unsigned long)host_raddr);<br>
+<br>
+=C2=A0 =C2=A0 page_set_flags(raddr, raddr + shm_info.shm_segsz,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGE_VALID | PAGE_READ | ((shmflg &amp; SHM_RD=
ONLY) ? 0 : PAGE_WRITE));<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; N_BSD_SHM_REGIONS; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bsd_shm_regions[i].start =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bsd_shm_regions[i].start =3D rad=
dr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bsd_shm_regions[i].size =3D shm_=
info.shm_segsz;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 mmap_unlock();<br>
+=C2=A0 =C2=A0 return raddr;<br>
+}<br>
+<br>
+/* shmdt(2) */<br>
+static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; N_BSD_SHM_REGIONS; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bsd_shm_regions[i].start =3D=3D shmaddr) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bsd_shm_regions[i].start =3D 0;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 page_set_flags(shmaddr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shmaddr + bsd_shm_=
regions[i].size, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return get_errno(shmdt(g2h_untagged(shmaddr)));<br>
+}<br>
+<br>
=C2=A0#endif /* BSD_USER_BSD_MEM_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index 9681c65ce9..f76bc1eb38 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -559,6 +559,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_bsd_shmctl(arg1, arg2, arg3);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_shmat: /* shmat(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_shmat(arg1, arg2, arg3);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_shmdt: /* shmdt(2) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_shmdt(arg1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Misc<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--000000000000efcbea0603536cee--

