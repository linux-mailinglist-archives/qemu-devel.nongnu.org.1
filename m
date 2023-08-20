Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B7A781C54
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:08:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXZjd-0002xB-1e; Sun, 20 Aug 2023 00:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZjZ-0002u7-FW
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:08:13 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZjX-00059u-5V
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:08:13 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fe1b00fce2so3197566e87.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692504488; x=1693109288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+h/S1NMnIno3c+qjRLgS13fjAsehR1sXLY4gmwaHaLw=;
 b=L46uSaaqzhMXoVtWVMv1UT/OEts2Q+/qJIhGoiVJqXBTMsjhFXXtA43yy0bQxT38tg
 QROCLSTRpUUxTjNsBc/Gx193rcAMdq0l2vl3sPCeQi3A0IuwalW7JiMQQn9oiL9I4yhe
 ggASjHhCjgi/BSG3S7FV43zOGQkIyqFW2Ch+D4DOd6xGUVqKfmtCGmWXSHAh+Lr4FqGa
 7x58COrPAvIogyaqVkJNK5xAy4SCnwg4AW1cFtaEtggoiimxFFbU279IhPNWwJU6Cket
 ++tG/06V8APLgGUGjFMzTfY0Q9rOcAobgMrxhKCn77zUS4LZu8+Cqg8leeN+8d9Bgacg
 DafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692504488; x=1693109288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+h/S1NMnIno3c+qjRLgS13fjAsehR1sXLY4gmwaHaLw=;
 b=hkxjY6YWcZ63DRe66DJI0wW9xjaFZ9OlE92niCgZERpFe1uGsk8W45IVDfwuK90Pgd
 kSmvLjSIat2Vo7P1EDSDxVOIbljsGYGuJ6pvubto8yJulu76vSMse7Vvx5j3TD5DXSZi
 TtNm9a/8Buu8K1kC7g79lbXFpW+tNIdgzw3x6WXLlpja9yMveGIrTOzfpkBPWcwuigkM
 pO9oGqrJeaWhXU86WglN7Udeu6NiE9R50++4fHCMhbhg8RmrrS4pUrvCHWrReakIqXke
 jCzLSIuQY5Dr7Ysjzf5SlEA/wkToYTmzj9WMIRMfnSsIGK7rRsvc2SGjZSMMURdSy0LG
 qUZw==
X-Gm-Message-State: AOJu0YwR5palkKnherOFUsJ6s3yS3nNfKebeT4+xnmOkhJ/qqk5s3EQc
 QIj769AnqCPuWnGYXSjKcsy5yJV6KAoPXWtMyfAaU5JRuayvrc9I
X-Google-Smtp-Source: AGHT+IGTVqihbJNU80EIedgH4OsrwJq7E0yPVWDXYuoHrqiTUSQzQ1uZzt2aHomjPQxeaGNE/bYAKY5vezXT6DxYqIM=
X-Received: by 2002:a05:6512:3ca1:b0:500:7d05:552a with SMTP id
 h33-20020a0565123ca100b005007d05552amr173957lfv.53.1692504488135; Sat, 19 Aug
 2023 21:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-3-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-3-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:08:01 -0600
Message-ID: <CANCZdfo7czz0JPOnq2XwdwE8ntpTfEzHA-12OAjDGdsj87wCww@mail.gmail.com>
Subject: Re: [PATCH 02/22] Implement struct target_shmid_ds
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000cbe31c060352e8c8"
Received-SPF: none client-ip=2a00:1450:4864:20::12b;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12b.google.com
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

--000000000000cbe31c060352e8c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:48=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> index 39a9bc8ed7..074df7bdd6 100644
> --- a/bsd-user/syscall_defs.h
> +++ b/bsd-user/syscall_defs.h
> @@ -72,6 +72,26 @@ struct target_ipc_perm {
>  #define TARGET_IPC_SET  1   /* set options */
>  #define TARGET_IPC_STAT 2   /* get options */
>
> +/*
> + * sys/shm.h
> + */
> +struct target_shmid_ds {
> +    struct  target_ipc_perm shm_perm; /* peration permission structure *=
/
> +    abi_ulong   shm_segsz;  /* size of segment in bytes */
> +    int32_t     shm_lpid;   /* process ID of last shared memory op */
> +    int32_t     shm_cpid;   /* process ID of creator */
> +    int32_t     shm_nattch; /* number of current attaches */
> +    target_time_t shm_atime;  /* time of last shmat() */
> +    target_time_t shm_dtime;  /* time of last shmdt() */
> +    target_time_t shm_ctime;  /* time of last change by shmctl() */
> +};
> +
> +#define N_BSD_SHM_REGIONS   32
> +struct bsd_shm_regions {
> +    abi_long start;
> +    abi_long size;
> +};
> +
>  /*
>   *  sys/mman.h
>   */
> --
> 2.40.0
>
>

--000000000000cbe31c060352e8c8
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
=C2=A0bsd-user/syscall_defs.h | 20 ++++++++++++++++++++<br>
=C2=A01 file changed, 20 insertions(+)<br></blockquote><div><br></div><div>=
Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.c=
om</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h<br>
index 39a9bc8ed7..074df7bdd6 100644<br>
--- a/bsd-user/syscall_defs.h<br>
+++ b/bsd-user/syscall_defs.h<br>
@@ -72,6 +72,26 @@ struct target_ipc_perm {<br>
=C2=A0#define TARGET_IPC_SET=C2=A0 1=C2=A0 =C2=A0/* set options */<br>
=C2=A0#define TARGET_IPC_STAT 2=C2=A0 =C2=A0/* get options */<br>
<br>
+/*<br>
+ * sys/shm.h<br>
+ */<br>
+struct target_shmid_ds {<br>
+=C2=A0 =C2=A0 struct=C2=A0 target_ipc_perm shm_perm; /* peration permissio=
n structure */<br>
+=C2=A0 =C2=A0 abi_ulong=C2=A0 =C2=A0shm_segsz;=C2=A0 /* size of segment in=
 bytes */<br>
+=C2=A0 =C2=A0 int32_t=C2=A0 =C2=A0 =C2=A0shm_lpid;=C2=A0 =C2=A0/* process =
ID of last shared memory op */<br>
+=C2=A0 =C2=A0 int32_t=C2=A0 =C2=A0 =C2=A0shm_cpid;=C2=A0 =C2=A0/* process =
ID of creator */<br>
+=C2=A0 =C2=A0 int32_t=C2=A0 =C2=A0 =C2=A0shm_nattch; /* number of current =
attaches */<br>
+=C2=A0 =C2=A0 target_time_t shm_atime;=C2=A0 /* time of last shmat() */<br=
>
+=C2=A0 =C2=A0 target_time_t shm_dtime;=C2=A0 /* time of last shmdt() */<br=
>
+=C2=A0 =C2=A0 target_time_t shm_ctime;=C2=A0 /* time of last change by shm=
ctl() */<br>
+};<br>
+<br>
+#define N_BSD_SHM_REGIONS=C2=A0 =C2=A032<br>
+struct bsd_shm_regions {<br>
+=C2=A0 =C2=A0 abi_long start;<br>
+=C2=A0 =C2=A0 abi_long size;<br>
+};<br>
+<br>
=C2=A0/*<br>
=C2=A0 *=C2=A0 sys/mman.h<br>
=C2=A0 */<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--000000000000cbe31c060352e8c8--

