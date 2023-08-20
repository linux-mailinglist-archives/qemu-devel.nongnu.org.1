Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8425C781C53
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXZiy-0002b8-5l; Sun, 20 Aug 2023 00:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZiu-0002az-Mw
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:07:33 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZis-00055s-Fg
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:07:32 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52557cc5e7bso2742522a12.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692504449; x=1693109249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LzcpmxEFVikEzmzDBIOvQjHE65+YZfOpI7lWlRzA9z8=;
 b=Tp789i6Lmd/iBkaBF3JlIyzJPoi6FnZRhF68brsikZ2q4uMw/yO1dr+dKVVxdZ3CYN
 9MyjBpmDgEDldsfsrrBBZA7vChGLXJ+o/3lEEPjihy1jpALeKcToDUiz1oOG5jPO2AKv
 8tynL9bUGIQgYw9DgzO+pplX/vTAmJ8TImBwgsDGEcSrm14RxSzcTtC1fesFd4ztYkFX
 ScIE88VcK/iohK/UPlu3T9k1se9+IO5ouB/gtBzhdda7EtSVLLCOgvdM0FuBS1ov4FxQ
 g1VKDOftavSzYpiZx1C33Wi3g/En9/K5ABhUFCqRB2WHRes5tJf8FfwcUI+fdhs6/rx1
 ulIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692504449; x=1693109249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LzcpmxEFVikEzmzDBIOvQjHE65+YZfOpI7lWlRzA9z8=;
 b=PM+O+vX3wP6Fibxpsjf98tboiec4KeYF1pUFtKgi8IB1oidFH7GOrdNWsOkYfGkADS
 ldDG8dPbF+p3bUtUB2iO9DNm+RruCDT+ViDRHENJ1ZYXXuo7+v/LHnZJUZC3jUhtOK4x
 NZkMR3N0Ptorw0U00jxwOWzh6ryG6qknT6iDWLJ8kTNMxDp5Zr4n1VuDik+mEQ0UCvjC
 DBmMr+ia+mafKVxlaiBL0tNvay+iADUFhs9mcDXTqPLume7LhH7Ii0K59K0FzkxMW27i
 1PA56C3Hz0LCqxdO+BIiZqkOknYB2o1WKIf6Q8g5uo4+yBKwyi4kYBwo1EJSN02Fu3X0
 51iw==
X-Gm-Message-State: AOJu0Yy8sj+RCAxRJPu03RZjGpEMT9CFzyyUirW6Vsne0E+ZMe0w5+7M
 k+WkMY3AGGEEchZqX7tLbtHubfKXo1KttqWH8Stzbw==
X-Google-Smtp-Source: AGHT+IEYzE12ag0vh3nd9cipehCDOnbibTJxuw0kjwM9dLa2hMM9Jr2RDeg46tjRi1jkEahnssnZZKRHFrSJ38wdCUU=
X-Received: by 2002:aa7:d4cc:0:b0:522:c1b1:8cb0 with SMTP id
 t12-20020aa7d4cc000000b00522c1b18cb0mr2411189edr.33.1692504448650; Sat, 19
 Aug 2023 21:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-2-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-2-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:07:21 -0600
Message-ID: <CANCZdfoVGxZ5Tqom_K7S4s+sJQNXZVihQ0Wbihq-mG98tbV=LQ@mail.gmail.com>
Subject: Re: [PATCH 01/22] Implement struct target_ipc_perm
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000007160f1060352e6f1"
Received-SPF: none client-ip=2a00:1450:4864:20::536;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x536.google.com
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

--0000000000007160f1060352e6f1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One general thing about all the patches in this series. The first line in
the
commit message should start with 'bsd-user: ' which I'll only say once.
You can fix it in v2 easily enough.

On Sat, Aug 19, 2023 at 3:48=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/syscall_defs.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> index e4825f2662..39a9bc8ed7 100644
> --- a/bsd-user/syscall_defs.h
> +++ b/bsd-user/syscall_defs.h
> @@ -55,6 +55,23 @@ struct target_iovec {
>      abi_long iov_len;   /* Number of bytes */
>  };
>
> +/*
> + * sys/ipc.h
> + */
> +struct target_ipc_perm {
> +    uint32_t    cuid;       /* creator user id */
> +    uint32_t    cgid;       /* creator group id */
> +    uint32_t    uid;        /* user id */
> +    uint32_t    gid;        /* group id */
> +    uint16_t    mode;       /* r/w permission */
> +    uint16_t    seq;        /* sequence # */
> +    abi_long    key;        /* user specified msg/sem/shm key */
> +};
> +
> +#define TARGET_IPC_RMID 0   /* remove identifier */
> +#define TARGET_IPC_SET  1   /* set options */
> +#define TARGET_IPC_STAT 2   /* get options */
> +
>  /*
>   *  sys/mman.h
>   */
> --
> 2.40.0
>
>

--0000000000007160f1060352e6f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>One general thing about all the patches in this serie=
s. The first line in the</div><div>commit message should start with &#39;bs=
d-user: &#39; which I&#39;ll only say once.</div><div>You can fix it in v2 =
easily enough.<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:48=E2=80=AFAM Karim Taha &lt;<a=
 href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.7@gmail.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Sta=
cey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/syscall_defs.h | 17 +++++++++++++++++<br>
=C2=A01 file changed, 17 insertions(+)<br></blockquote><div><br></div><div>=
Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.c=
om</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h<br>
index e4825f2662..39a9bc8ed7 100644<br>
--- a/bsd-user/syscall_defs.h<br>
+++ b/bsd-user/syscall_defs.h<br>
@@ -55,6 +55,23 @@ struct target_iovec {<br>
=C2=A0 =C2=A0 =C2=A0abi_long iov_len;=C2=A0 =C2=A0/* Number of bytes */<br>
=C2=A0};<br>
<br>
+/*<br>
+ * sys/ipc.h<br>
+ */<br>
+struct target_ipc_perm {<br>
+=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 cuid;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* cre=
ator user id */<br>
+=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 cgid;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* cre=
ator group id */<br>
+=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 uid;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* use=
r id */<br>
+=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 gid;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* gro=
up id */<br>
+=C2=A0 =C2=A0 uint16_t=C2=A0 =C2=A0 mode;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* r/w=
 permission */<br>
+=C2=A0 =C2=A0 uint16_t=C2=A0 =C2=A0 seq;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* seq=
uence # */<br>
+=C2=A0 =C2=A0 abi_long=C2=A0 =C2=A0 key;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* use=
r specified msg/sem/shm key */<br>
+};<br>
+<br>
+#define TARGET_IPC_RMID 0=C2=A0 =C2=A0/* remove identifier */<br>
+#define TARGET_IPC_SET=C2=A0 1=C2=A0 =C2=A0/* set options */<br>
+#define TARGET_IPC_STAT 2=C2=A0 =C2=A0/* get options */<br>
+<br>
=C2=A0/*<br>
=C2=A0 *=C2=A0 sys/mman.h<br>
=C2=A0 */<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--0000000000007160f1060352e6f1--

