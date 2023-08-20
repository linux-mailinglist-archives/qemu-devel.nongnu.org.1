Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBAE781C60
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:25:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXa0S-0001K2-OR; Sun, 20 Aug 2023 00:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXa0N-0001Je-Is
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:25:36 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXa0K-0007ko-UC
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:25:34 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52683da3f5cso2678687a12.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692505531; x=1693110331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IBDRJd8hg7Hz8YRoEsm4QD6D7iUoHYr9ssufWFhK4qw=;
 b=kE2ASh4HcD77N6pXE4KbdN95Hhk3PguiyU00Yr0VM1SfnDg4dMJWtR0t+/ZMEsvVgm
 bGIkcWsbMyQw1uEzY9pjsBvHciqKO6LQS5L9jSpHXXvp/7defUB4ydqku5+y9MwXVnYM
 6oca5ZVV1+Ejh+KFwR+yIwTB7WTC86H+yGxFCP4b+t4CpT2qE5fC0AlgeziGk/7cy0Xn
 am4+ogUqN6nT18wmAnrpf+/kKAnRg4ZPmDPj+9J5JkDOcVYtYSaqcviwPUOOiYT7NjjY
 blMJMoBCPp75YYS125IyYO/zMh+lINYx8aKgRoe0/nbEAeEUpSGZSoVIpj/VBtoAMihv
 FujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692505531; x=1693110331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IBDRJd8hg7Hz8YRoEsm4QD6D7iUoHYr9ssufWFhK4qw=;
 b=byd9ovMw4e7IjSr3knlkh+sgruSBJy/2+YJE5b6dFeZzIRdLfFB6UVo2THQM4pluwJ
 ptZa6hism+JL9aHw++t6D6DMLCc683eIUV1VrI+kEH1142SFPcJeQoWdiHdJigmGaR65
 sKg4qh0JBsx5g/vbSOY+LTeO9nv0qdeQ2ibapz/7Vbvj6lHwL1oMQw8ZBUIwwbMCSTyx
 R/jnfG4/oeKDMYuy5gsqrUGxrbBhvB095ZKZm3vHepacLGlivqehbuGd1TaIKVU6wHPB
 LIQP1cYN2WCjefatsj4DBkuv8rAXaIAMOMJSUGFQIz9kalYw9/O7/I/BvJ7I6k8XJgcU
 SKOQ==
X-Gm-Message-State: AOJu0YydxvwIOuLFkwyzGhNVT+GZU94hGcXZv3ztg/Gja18MfVoye+Aa
 EYk8kN2LnkbctYjgKQK4NIM5GWloINgTIU2ebR5mzxtA80/bXu6npIs=
X-Google-Smtp-Source: AGHT+IH/APNDrmVc6eykUwcg+NJ6Od39CB5/g/KQB22Bl1NKspSB70nensaS46khFuTWwGupEkh1IQJNC0N9hDVGuvY=
X-Received: by 2002:aa7:ccc9:0:b0:51e:362d:b172 with SMTP id
 y9-20020aa7ccc9000000b0051e362db172mr2302069edt.32.1692505531354; Sat, 19 Aug
 2023 21:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-11-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-11-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:25:24 -0600
Message-ID: <CANCZdfpudvR6+g8Vp9xqhCXrJSwNzdUac8MiE4wFbkuMSswk=A@mail.gmail.com>
Subject: Re: [PATCH 10/22] Implement shmid_ds conversion between host and
 target.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000fa21fd060353267b"
Received-SPF: none client-ip=2a00:1450:4864:20::533;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x533.google.com
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

--000000000000fa21fd060353267b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:48=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
> index e69250cc0d..4446c94725 100644
> --- a/bsd-user/bsd-mem.c
> +++ b/bsd-user/bsd-mem.c
> @@ -77,3 +77,49 @@ abi_long host_to_target_ipc_perm(abi_ulong target_addr=
,
>      return 0;
>  }
>
> +abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
> +        abi_ulong target_addr)
> +{
> +    struct target_shmid_ds *target_sd;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_sd, target_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    if (target_to_host_ipc_perm(&(host_sd->shm_perm), target_addr)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(host_sd->shm_segsz, &target_sd->shm_segsz);
> +    __get_user(host_sd->shm_lpid, &target_sd->shm_lpid);
> +    __get_user(host_sd->shm_cpid, &target_sd->shm_cpid);
> +    __get_user(host_sd->shm_nattch, &target_sd->shm_nattch);
> +    __get_user(host_sd->shm_atime, &target_sd->shm_atime);
> +    __get_user(host_sd->shm_dtime, &target_sd->shm_dtime);
> +    __get_user(host_sd->shm_ctime, &target_sd->shm_ctime);
> +    unlock_user_struct(target_sd, target_addr, 0);
> +
> +    return 0;
> +}
> +
> +abi_long host_to_target_shmid_ds(abi_ulong target_addr,
> +        struct shmid_ds *host_sd)
> +{
> +    struct target_shmid_ds *target_sd;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    if (host_to_target_ipc_perm(target_addr, &(host_sd->shm_perm))) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(host_sd->shm_segsz, &target_sd->shm_segsz);
> +    __put_user(host_sd->shm_lpid, &target_sd->shm_lpid);
> +    __put_user(host_sd->shm_cpid, &target_sd->shm_cpid);
> +    __put_user(host_sd->shm_nattch, &target_sd->shm_nattch);
> +    __put_user(host_sd->shm_atime, &target_sd->shm_atime);
> +    __put_user(host_sd->shm_dtime, &target_sd->shm_dtime);
> +    __put_user(host_sd->shm_ctime, &target_sd->shm_ctime);
> +    unlock_user_struct(target_sd, target_addr, 1);
> +
> +    return 0;
> +}
> +
> --
> 2.40.0
>
>

--000000000000fa21fd060353267b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:48=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.c | 46 +++++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 46 insertions(+)<br></blockquote><div><br></div><div>=
Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.c=
om</a>&gt;</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c<br>
index e69250cc0d..4446c94725 100644<br>
--- a/bsd-user/bsd-mem.c<br>
+++ b/bsd-user/bsd-mem.c<br>
@@ -77,3 +77,49 @@ abi_long host_to_target_ipc_perm(abi_ulong target_addr,<=
br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
+abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_addr)<br>
+{<br>
+=C2=A0 =C2=A0 struct target_shmid_ds *target_sd;<br>
+<br>
+=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target_sd, target_addr, 1=
)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (target_to_host_ipc_perm(&amp;(host_sd-&gt;shm_perm), tar=
get_addr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 __get_user(host_sd-&gt;shm_segsz, &amp;target_sd-&gt;shm_seg=
sz);<br>
+=C2=A0 =C2=A0 __get_user(host_sd-&gt;shm_lpid, &amp;target_sd-&gt;shm_lpid=
);<br>
+=C2=A0 =C2=A0 __get_user(host_sd-&gt;shm_cpid, &amp;target_sd-&gt;shm_cpid=
);<br>
+=C2=A0 =C2=A0 __get_user(host_sd-&gt;shm_nattch, &amp;target_sd-&gt;shm_na=
ttch);<br>
+=C2=A0 =C2=A0 __get_user(host_sd-&gt;shm_atime, &amp;target_sd-&gt;shm_ati=
me);<br>
+=C2=A0 =C2=A0 __get_user(host_sd-&gt;shm_dtime, &amp;target_sd-&gt;shm_dti=
me);<br>
+=C2=A0 =C2=A0 __get_user(host_sd-&gt;shm_ctime, &amp;target_sd-&gt;shm_cti=
me);<br>
+=C2=A0 =C2=A0 unlock_user_struct(target_sd, target_addr, 0);<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+abi_long host_to_target_shmid_ds(abi_ulong target_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct shmid_ds *host_sd)<br>
+{<br>
+=C2=A0 =C2=A0 struct target_shmid_ds *target_sd;<br>
+<br>
+=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, =
0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (host_to_target_ipc_perm(target_addr, &amp;(host_sd-&gt;s=
hm_perm))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 __put_user(host_sd-&gt;shm_segsz, &amp;target_sd-&gt;shm_seg=
sz);<br>
+=C2=A0 =C2=A0 __put_user(host_sd-&gt;shm_lpid, &amp;target_sd-&gt;shm_lpid=
);<br>
+=C2=A0 =C2=A0 __put_user(host_sd-&gt;shm_cpid, &amp;target_sd-&gt;shm_cpid=
);<br>
+=C2=A0 =C2=A0 __put_user(host_sd-&gt;shm_nattch, &amp;target_sd-&gt;shm_na=
ttch);<br>
+=C2=A0 =C2=A0 __put_user(host_sd-&gt;shm_atime, &amp;target_sd-&gt;shm_ati=
me);<br>
+=C2=A0 =C2=A0 __put_user(host_sd-&gt;shm_dtime, &amp;target_sd-&gt;shm_dti=
me);<br>
+=C2=A0 =C2=A0 __put_user(host_sd-&gt;shm_ctime, &amp;target_sd-&gt;shm_cti=
me);<br>
+=C2=A0 =C2=A0 unlock_user_struct(target_sd, target_addr, 1);<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--000000000000fa21fd060353267b--

