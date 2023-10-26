Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8D57D7E81
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvvjs-0001eo-KA; Thu, 26 Oct 2023 04:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qvvjo-0001eX-Su
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qvvjm-0002fa-JP
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698308946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94K/R5Wh12/vVslVVY2/DSbdBnS+wY3GdP+M3600Ih4=;
 b=eSqqUf/nkHvtqPWB/GjRCKe8ORGBtuJMizr+16ZU5nHZCei63QEy2MlzEf8qEfJRZIfDJP
 Vkj7fw/OHBfgYj9su/j20W8tQrjPKELpTaeCNHRCtGL65wSczfOpCK5yK5Z8cFnkP/RsFP
 YydorhJ0OF3nltOgJqwFTpO2F6BbbVg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-AsbODFx0P36rd3oY1wrIwA-1; Thu, 26 Oct 2023 04:29:03 -0400
X-MC-Unique: AsbODFx0P36rd3oY1wrIwA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079fd97838so613917e87.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 01:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698308942; x=1698913742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=94K/R5Wh12/vVslVVY2/DSbdBnS+wY3GdP+M3600Ih4=;
 b=H3g7uvlpUFDAJKxZ25KbbdoLLIwy2J5oJqEWHirK5D2dy8cybgIfW9++pnUH3EtsVK
 LcBo5UCegoEyhtrBFZpdxCLGFnXkq0+H2aIzUacgHT25oV7Rdi65Kikqt7c65en/jOtT
 YibfNKQT7i/gGibxVuK2JFoXBXr89R6oOg0BX26s44G6iEff/dtFhf4fV6+B/tqaHcvn
 3w769eM1qc2QvOciKGKcS34rwqvKDJlb9L68lztCLG57s81I9RZZu2KGXdZIgIf8IaXu
 +OjuFP8bfUkfomPsHMbM5PsUmS8rKfyg/iIYUeDHIGoQdhTunGKFxFBvniefnjB8yTIu
 Dj9g==
X-Gm-Message-State: AOJu0YzRtQR1lo4xmCfCltS694Bw3FvNqfGVfiJQFSDk9Dt5DNhlEQ6W
 187ZpiwekGvYbwVsQWXwdK5Xr8XaxxCGsyfCTWziR1YJFh4dQBvVXQ1DomU8uyr1p81rNsxWeCb
 GU90sC9PK87zeUSyYQeNbK2bfkLVFgmY=
X-Received: by 2002:ac2:5ec3:0:b0:503:a82:b371 with SMTP id
 d3-20020ac25ec3000000b005030a82b371mr12151239lfq.4.1698308942415; 
 Thu, 26 Oct 2023 01:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbB/rREBwTBgyHtIIZoTKrgud15FPMtM4IT66bzL4PXcDCBbXXDZIA1Go4DHhSE6IqXo0rjBd0HOfG44+8H/I=
X-Received: by 2002:ac2:5ec3:0:b0:503:a82:b371 with SMTP id
 d3-20020ac25ec3000000b005030a82b371mr12151231lfq.4.1698308942009; Thu, 26 Oct
 2023 01:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
 <20231025140058.113376-3-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20231025140058.113376-3-alexander.ivanov@virtuozzo.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 26 Oct 2023 11:28:51 +0300
Message-ID: <CAPMcbCq+4-=+jFGQH37oR25+J5tC-uGuE21aGMxHZdrq6qr2Dw@mail.gmail.com>
Subject: Re: [PATCH 2/6] qga: Move command execution code to a separate
 function
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, michael.roth@amd.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="00000000000035364d06089a5db8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000035364d06089a5db8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 5:01=E2=80=AFPM Alexander Ivanov <
alexander.ivanov@virtuozzo.com> wrote:

> In qmp_guest_set_user_password() we have a part of code that we can reuse
> in the future commits. Move this code to a separate function.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  qga/commands-posix.c | 139 ++++++++++++++++++++++---------------------
>  1 file changed, 72 insertions(+), 67 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 6169bbf7a0..e7b82aaf37 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2114,20 +2114,78 @@ int64_t
> qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
>  #endif /* __linux__ */
>
>  #if defined(__linux__) || defined(__FreeBSD__)
> -void qmp_guest_set_user_password(const char *username,
> -                                 const char *password,
> -                                 bool crypted,
> -                                 Error **errp)
> +
> +static void run_command(const char *argv[], const char *in_str, Error
> **errp)
>  {
>      Error *local_err =3D NULL;
> -    char *passwd_path =3D NULL;
>      pid_t pid;
> -    int status;
> +    int in_len, status;
>      int datafd[2] =3D { -1, -1 };
> +
> +    if (!g_unix_open_pipe(datafd, FD_CLOEXEC, NULL)) {
> +        error_setg(errp, "cannot create pipe FDs");
> +        goto out;
> +    }
> +
> +    pid =3D fork();
> +    if (pid =3D=3D 0) {
> +        close(datafd[1]);
> +        setsid();
> +        dup2(datafd[0], 0);
> +        reopen_fd_to_null(1);
> +        reopen_fd_to_null(2);
> +
> +        execve(argv[0], (char *const *)argv, environ);
> +        _exit(EXIT_FAILURE);
> +    } else if (pid < 0) {
> +        error_setg_errno(errp, errno, "failed to create child process");
> +        goto out;
> +    }
> +    close(datafd[0]);
> +    datafd[0] =3D -1;
> +
> +    in_len =3D strlen(in_str);
> +
> +    if (qemu_write_full(datafd[1], in_str, in_len) !=3D in_len) {
> +        error_setg_errno(errp, errno, "cannot write new account
> password");
>

As this is a generic `run_command` function, please generalize errors too.


> +        goto out;
> +    }
> +    close(datafd[1]);
> +    datafd[1] =3D -1;
> +
> +    ga_wait_child(pid, &status, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto out;
> +    }
> +
> +    if (!WIFEXITED(status)) {
> +        error_setg(errp, "child process has terminated abnormally");
> +        goto out;
> +    }
> +
> +    if (WEXITSTATUS(status)) {
> +        error_setg(errp, "child process has failed: %s", argv[0]);
> +    }
> +
> +out:
> +    if (datafd[0] !=3D -1) {
> +        close(datafd[0]);
> +    }
> +    if (datafd[1] !=3D -1) {
> +        close(datafd[1]);
> +    }
> +}
> +
> +void qmp_guest_set_user_password(const char *username,
> +                                 const char *password,
> +                                 bool crypted,
> +                                 Error **errp)
> +{
> +    char *passwd_path =3D NULL;
>      char *rawpasswddata =3D NULL;
> -    size_t rawpasswdlen;
>      char *chpasswddata =3D NULL;
> -    size_t chpasswdlen;
> +    size_t rawpasswdlen;
>
>      rawpasswddata =3D (char *)qbase64_decode(password, -1, &rawpasswdlen=
,
> errp);
>      if (!rawpasswddata) {
> @@ -2155,79 +2213,26 @@ void qmp_guest_set_user_password(const char
> *username,
>      passwd_path =3D g_find_program_in_path("chpasswd");
>  #endif
>
> -    chpasswdlen =3D strlen(chpasswddata);
> -
>      if (!passwd_path) {
>          error_setg(errp, "cannot find 'passwd' program in PATH");
>          goto out;
>      }
>
> -    if (!g_unix_open_pipe(datafd, FD_CLOEXEC, NULL)) {
> -        error_setg(errp, "cannot create pipe FDs");
> -        goto out;
> -    }
> -
> -    pid =3D fork();
> -    if (pid =3D=3D 0) {
> -        close(datafd[1]);
> -        /* child */
> -        setsid();
> -        dup2(datafd[0], 0);
> -        reopen_fd_to_null(1);
> -        reopen_fd_to_null(2);
> -
> +    const char *argv[] =3D {
>  #ifdef __FreeBSD__
> -        const char *h_arg;
> -        h_arg =3D (crypted) ? "-H" : "-h";
> -        execl(passwd_path, "pw", "usermod", "-n", username, h_arg, "0",
> NULL);
> +        passwd_path, "pw", "usermod", "-n", username,
> +        (crypted) ? "-H" : "-h", "0", NULL};
>  #else
> -        if (crypted) {
> -            execl(passwd_path, "chpasswd", "-e", NULL);
> -        } else {
> -            execl(passwd_path, "chpasswd", NULL);
> -        }
> +        passwd_path, "chpasswd", (crypted) ? "-e" : NULL, NULL
>  #endif
> -        _exit(EXIT_FAILURE);
> -    } else if (pid < 0) {
> -        error_setg_errno(errp, errno, "failed to create child process");
> -        goto out;
> -    }
> -    close(datafd[0]);
> -    datafd[0] =3D -1;
> +    };
>
> -    if (qemu_write_full(datafd[1], chpasswddata, chpasswdlen) !=3D
> chpasswdlen) {
> -        error_setg_errno(errp, errno, "cannot write new account
> password");
> -        goto out;
> -    }
> -    close(datafd[1]);
> -    datafd[1] =3D -1;
> -
> -    ga_wait_child(pid, &status, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        goto out;
> -    }
> -
> -    if (!WIFEXITED(status)) {
> -        error_setg(errp, "child process has terminated abnormally");
> -        goto out;
> -    }
> -
> -    if (WEXITSTATUS(status)) {
> -        error_setg(errp, "child process has failed to set user password"=
);
> -        goto out;
> -    }
> +    run_command(argv, chpasswddata, errp);
>
>  out:
>      g_free(chpasswddata);
>      g_free(rawpasswddata);
>      g_free(passwd_path);
> -    if (datafd[0] !=3D -1) {
> -        close(datafd[0]);
> -    }
> -    if (datafd[1] !=3D -1) {
> -        close(datafd[1]);
> -    }
>  }
>  #else /* __linux__ || __FreeBSD__ */
>  void qmp_guest_set_user_password(const char *username,
> --
> 2.34.1
>
>

--00000000000035364d06089a5db8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 25, 2023 at 5:01=E2=80=AF=
PM Alexander Ivanov &lt;<a href=3D"mailto:alexander.ivanov@virtuozzo.com">a=
lexander.ivanov@virtuozzo.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">In qmp_guest_set_user_password() we have a par=
t of code that we can reuse<br>
in the future commits. Move this code to a separate function.<br>
<br>
Signed-off-by: Alexander Ivanov &lt;<a href=3D"mailto:alexander.ivanov@virt=
uozzo.com" target=3D"_blank">alexander.ivanov@virtuozzo.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 139 ++++++++++++++++++++++--------------------=
-<br>
=C2=A01 file changed, 72 insertions(+), 67 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 6169bbf7a0..e7b82aaf37 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -2114,20 +2114,78 @@ int64_t qmp_guest_set_vcpus(GuestLogicalProcessorLi=
st *vcpus, Error **errp)<br>
=C2=A0#endif /* __linux__ */<br>
<br>
=C2=A0#if defined(__linux__) || defined(__FreeBSD__)<br>
-void qmp_guest_set_user_password(const char *username,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *password,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool crypted,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+<br>
+static void run_command(const char *argv[], const char *in_str, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
-=C2=A0 =C2=A0 char *passwd_path =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0pid_t pid;<br>
-=C2=A0 =C2=A0 int status;<br>
+=C2=A0 =C2=A0 int in_len, status;<br>
=C2=A0 =C2=A0 =C2=A0int datafd[2] =3D { -1, -1 };<br>
+<br>
+=C2=A0 =C2=A0 if (!g_unix_open_pipe(datafd, FD_CLOEXEC, NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;cannot create pipe FDs&=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 pid =3D fork();<br>
+=C2=A0 =C2=A0 if (pid =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(datafd[1]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 setsid();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dup2(datafd[0], 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reopen_fd_to_null(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reopen_fd_to_null(2);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 execve(argv[0], (char *const *)argv, environ);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 } else if (pid &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;failed to =
create child process&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 close(datafd[0]);<br>
+=C2=A0 =C2=A0 datafd[0] =3D -1;<br>
+<br>
+=C2=A0 =C2=A0 in_len =3D strlen(in_str);<br>
+<br>
+=C2=A0 =C2=A0 if (qemu_write_full(datafd[1], in_str, in_len) !=3D in_len) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;cannot wri=
te new account password&quot;);<br></blockquote><div><br></div><div>As this=
 is a generic `run_command` function, please generalize errors too.<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 close(datafd[1]);<br>
+=C2=A0 =C2=A0 datafd[1] =3D -1;<br>
+<br>
+=C2=A0 =C2=A0 ga_wait_child(pid, &amp;status, &amp;local_err);<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!WIFEXITED(status)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;child process has termi=
nated abnormally&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (WEXITSTATUS(status)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;child process has faile=
d: %s&quot;, argv[0]);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 if (datafd[0] !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(datafd[0]);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (datafd[1] !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(datafd[1]);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+void qmp_guest_set_user_password(const char *username,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *password,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool crypted,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 char *passwd_path =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0char *rawpasswddata =3D NULL;<br>
-=C2=A0 =C2=A0 size_t rawpasswdlen;<br>
=C2=A0 =C2=A0 =C2=A0char *chpasswddata =3D NULL;<br>
-=C2=A0 =C2=A0 size_t chpasswdlen;<br>
+=C2=A0 =C2=A0 size_t rawpasswdlen;<br>
<br>
=C2=A0 =C2=A0 =C2=A0rawpasswddata =3D (char *)qbase64_decode(password, -1, =
&amp;rawpasswdlen, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (!rawpasswddata) {<br>
@@ -2155,79 +2213,26 @@ void qmp_guest_set_user_password(const char *userna=
me,<br>
=C2=A0 =C2=A0 =C2=A0passwd_path =3D g_find_program_in_path(&quot;chpasswd&q=
uot;);<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 chpasswdlen =3D strlen(chpasswddata);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (!passwd_path) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;cannot find &#39;p=
asswd&#39; program in PATH&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!g_unix_open_pipe(datafd, FD_CLOEXEC, NULL)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;cannot create pipe FDs&=
quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 pid =3D fork();<br>
-=C2=A0 =C2=A0 if (pid =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(datafd[1]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* child */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 setsid();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dup2(datafd[0], 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 reopen_fd_to_null(1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 reopen_fd_to_null(2);<br>
-<br>
+=C2=A0 =C2=A0 const char *argv[] =3D {<br>
=C2=A0#ifdef __FreeBSD__<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *h_arg;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 h_arg =3D (crypted) ? &quot;-H&quot; : &quot;-=
h&quot;;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 execl(passwd_path, &quot;pw&quot;, &quot;userm=
od&quot;, &quot;-n&quot;, username, h_arg, &quot;0&quot;, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 passwd_path, &quot;pw&quot;, &quot;usermod&quo=
t;, &quot;-n&quot;, username,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (crypted) ? &quot;-H&quot; : &quot;-h&quot;, &=
quot;0&quot;, NULL};<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (crypted) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 execl(passwd_path, &quot;chpassw=
d&quot;, &quot;-e&quot;, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 execl(passwd_path, &quot;chpassw=
d&quot;, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 passwd_path, &quot;chpasswd&quot;, (crypted) ?=
 &quot;-e&quot; : NULL, NULL<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 _exit(EXIT_FAILURE);<br>
-=C2=A0 =C2=A0 } else if (pid &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;failed to =
create child process&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 close(datafd[0]);<br>
-=C2=A0 =C2=A0 datafd[0] =3D -1;<br>
+=C2=A0 =C2=A0 };<br>
<br>
-=C2=A0 =C2=A0 if (qemu_write_full(datafd[1], chpasswddata, chpasswdlen) !=
=3D chpasswdlen) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;cannot wri=
te new account password&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 close(datafd[1]);<br>
-=C2=A0 =C2=A0 datafd[1] =3D -1;<br>
-<br>
-=C2=A0 =C2=A0 ga_wait_child(pid, &amp;status, &amp;local_err);<br>
-=C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (!WIFEXITED(status)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;child process has termi=
nated abnormally&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (WEXITSTATUS(status)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;child process has faile=
d to set user password&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 run_command(argv, chpasswddata, errp);<br>
<br>
=C2=A0out:<br>
=C2=A0 =C2=A0 =C2=A0g_free(chpasswddata);<br>
=C2=A0 =C2=A0 =C2=A0g_free(rawpasswddata);<br>
=C2=A0 =C2=A0 =C2=A0g_free(passwd_path);<br>
-=C2=A0 =C2=A0 if (datafd[0] !=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(datafd[0]);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (datafd[1] !=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(datafd[1]);<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
=C2=A0#else /* __linux__ || __FreeBSD__ */<br>
=C2=A0void qmp_guest_set_user_password(const char *username,<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--00000000000035364d06089a5db8--


