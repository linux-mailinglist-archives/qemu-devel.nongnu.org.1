Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A546C781C5E
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:24:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXZz0-0000fm-4f; Sun, 20 Aug 2023 00:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZyx-0000fa-JR
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:24:07 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZyv-0007P6-9A
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:24:07 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so915081a12.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692505443; x=1693110243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QhLF90GUNl9OLk4MCaOmVMHpJQGOkzXPOfe5QGKu0KI=;
 b=CFsHNmRFnCRK32srKdIgC75fgDIvhrCYmMUqplSNvFOKUPQzGn32E4L0NAoAqeEMec
 rfzT3CuY1XtPkbC/wU0wsGn0MpU3Awe3oNeF0fPU/M5qf6ABwZR9HV6aTrF/Obc18K5I
 vnCDxLzIf1lEgtA25a8+y9Sc0P49DTNoTh9HVbVX77TNRalJZ7NTTJ9yuYNCuqLYTlLM
 1elPaH6ZrHypDyuDPLomgUg/sTin8j0kluVAdHdh5Perxenor4ASt2yerhFUBxsgjdO8
 eWedU9g8PD70YFPJ8b03+HlEAI0R9a4af2S/tor/jY9YhPi1IlnTUshQVkSQcK0e/Wu2
 G0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692505443; x=1693110243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QhLF90GUNl9OLk4MCaOmVMHpJQGOkzXPOfe5QGKu0KI=;
 b=acvPbdHpoE1EYupm1i2pokZe2vpZQpBNMQ7Okb5wQWSCNFQpjq7ur3x8amSciJ/hGc
 cW+brFHGqWWySgJXLqgK5Rv2P464A2nYWkwSmbddAr50r2goXAUdFxz+16kk2dVkCID/
 oeui8YsqKCVQtNT+hz3ynTtO2jIA+Q+h8+gpOzFcsSXYhyxFtUkdViQDYVQ6O72gsEEw
 ZpZy8XOaMVEn9XV0w8sACKkQUd4vk0vylRBuhliQdgwSxl0j2PE38V01bazdxA4255/K
 TvbWS+eFBXuElZX9ZTLwbW4Qo7mbvFmST44N9ZQ/bdvihOvgLNHaKE7xmKaqax3Jo9nV
 truQ==
X-Gm-Message-State: AOJu0YyUKvjWPmISNWXtS0NLnh/1l6f6Ho9vp0N0qbFjx9WxOIAbJdhv
 fQEQlDIykcWvhswunyo8JZ7J+YFSjcaLUuvJz8atzw==
X-Google-Smtp-Source: AGHT+IEf7Ybjr9IpszJFlltcIcsucp9TCICCRUILyklu1P1Q9JF1ndIGdgS5bRxuGsuGpqK0s5BpsUa4efcrc0VQ+Sk=
X-Received: by 2002:aa7:db4a:0:b0:522:2711:873 with SMTP id
 n10-20020aa7db4a000000b0052227110873mr2718714edt.1.1692505443682; Sat, 19 Aug
 2023 21:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-10-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-10-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:23:56 -0600
Message-ID: <CANCZdfpdB9HHwe_B9c8vDBJLjek3P4cn4mSOV+L4gU=062xrXA@mail.gmail.com>
Subject: Re: [PATCH 09/22] Implement ipc_perm conversion between host and
 target.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000c059dd060353211f"
Received-SPF: none client-ip=2a00:1450:4864:20::52d;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52d.google.com
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

--000000000000c059dd060353211f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:48=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
> index 6c123abf04..e69250cc0d 100644
> --- a/bsd-user/bsd-mem.c
> +++ b/bsd-user/bsd-mem.c
> @@ -36,3 +36,44 @@ void target_set_brk(abi_ulong new_brk)
>      bsd_target_original_brk =3D bsd_target_brk =3D HOST_PAGE_ALIGN(new_b=
rk);
>      brk_page =3D HOST_PAGE_ALIGN(bsd_target_brk);
>  }
> +
> +abi_long target_to_host_ipc_perm(struct ipc_perm *host_ip,
> +        abi_ulong target_addr)
> +{
> +    struct target_ipc_perm *target_ip;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_ip, target_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(host_ip->cuid, &target_ip->cuid);
> +    __get_user(host_ip->cgid, &target_ip->cgid);
> +    __get_user(host_ip->uid, &target_ip->uid);
> +    __get_user(host_ip->gid, &target_ip->gid);
> +    __get_user(host_ip->mode, &target_ip->mode);
> +    __get_user(host_ip->seq, &target_ip->seq);
> +    __get_user(host_ip->key, &target_ip->key);
> +    unlock_user_struct(target_ip, target_addr, 0);
> +
> +    return 0;
> +}
> +
> +abi_long host_to_target_ipc_perm(abi_ulong target_addr,
> +        struct ipc_perm *host_ip)
> +{
> +    struct target_ipc_perm *target_ip;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_ip, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(host_ip->cuid, &target_ip->cuid);
> +    __put_user(host_ip->cgid, &target_ip->cgid);
> +    __put_user(host_ip->uid, &target_ip->uid);
> +    __put_user(host_ip->gid, &target_ip->gid);
> +    __put_user(host_ip->mode, &target_ip->mode);
> +    __put_user(host_ip->seq, &target_ip->seq);
> +    __put_user(host_ip->key, &target_ip->key);
> +    unlock_user_struct(target_ip, target_addr, 1);
> +
> +    return 0;
> +}
> +
> --
> 2.40.0
>
>

--000000000000c059dd060353211f
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
=C2=A0bsd-user/bsd-mem.c | 41 +++++++++++++++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 41 insertions(+)<br></blockquote><div><br></div><div>=
Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.c=
om</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c<br>
index 6c123abf04..e69250cc0d 100644<br>
--- a/bsd-user/bsd-mem.c<br>
+++ b/bsd-user/bsd-mem.c<br>
@@ -36,3 +36,44 @@ void target_set_brk(abi_ulong new_brk)<br>
=C2=A0 =C2=A0 =C2=A0bsd_target_original_brk =3D bsd_target_brk =3D HOST_PAG=
E_ALIGN(new_brk);<br>
=C2=A0 =C2=A0 =C2=A0brk_page =3D HOST_PAGE_ALIGN(bsd_target_brk);<br>
=C2=A0}<br>
+<br>
+abi_long target_to_host_ipc_perm(struct ipc_perm *host_ip,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_addr)<br>
+{<br>
+=C2=A0 =C2=A0 struct target_ipc_perm *target_ip;<br>
+<br>
+=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target_ip, target_addr, 1=
)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 __get_user(host_ip-&gt;cuid, &amp;target_ip-&gt;cuid);<br>
+=C2=A0 =C2=A0 __get_user(host_ip-&gt;cgid, &amp;target_ip-&gt;cgid);<br>
+=C2=A0 =C2=A0 __get_user(host_ip-&gt;uid, &amp;target_ip-&gt;uid);<br>
+=C2=A0 =C2=A0 __get_user(host_ip-&gt;gid, &amp;target_ip-&gt;gid);<br>
+=C2=A0 =C2=A0 __get_user(host_ip-&gt;mode, &amp;target_ip-&gt;mode);<br>
+=C2=A0 =C2=A0 __get_user(host_ip-&gt;seq, &amp;target_ip-&gt;seq);<br>
+=C2=A0 =C2=A0 __get_user(host_ip-&gt;key, &amp;target_ip-&gt;key);<br>
+=C2=A0 =C2=A0 unlock_user_struct(target_ip, target_addr, 0);<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+abi_long host_to_target_ipc_perm(abi_ulong target_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ipc_perm *host_ip)<br>
+{<br>
+=C2=A0 =C2=A0 struct target_ipc_perm *target_ip;<br>
+<br>
+=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_ip, target_addr, =
0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 __put_user(host_ip-&gt;cuid, &amp;target_ip-&gt;cuid);<br>
+=C2=A0 =C2=A0 __put_user(host_ip-&gt;cgid, &amp;target_ip-&gt;cgid);<br>
+=C2=A0 =C2=A0 __put_user(host_ip-&gt;uid, &amp;target_ip-&gt;uid);<br>
+=C2=A0 =C2=A0 __put_user(host_ip-&gt;gid, &amp;target_ip-&gt;gid);<br>
+=C2=A0 =C2=A0 __put_user(host_ip-&gt;mode, &amp;target_ip-&gt;mode);<br>
+=C2=A0 =C2=A0 __put_user(host_ip-&gt;seq, &amp;target_ip-&gt;seq);<br>
+=C2=A0 =C2=A0 __put_user(host_ip-&gt;key, &amp;target_ip-&gt;key);<br>
+=C2=A0 =C2=A0 unlock_user_struct(target_ip, target_addr, 1);<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--000000000000c059dd060353211f--

