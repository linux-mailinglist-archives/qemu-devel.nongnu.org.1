Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8EF737F7A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:22:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuxd-0005R9-P6; Wed, 21 Jun 2023 06:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBuxb-0005Ll-Tz
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:21:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBuxZ-0001e7-FT
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:21:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3094910b150so5801547f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 03:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687342868; x=1689934868;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uw8tlsqBxsF7ULGNj0VdZTxHIeQNGmgRoIchpvVq6a4=;
 b=o1uOEG/Sn6+E5DMno5gCMM7B0MRzL51r4wu/D6AoNpMVenCTL8S3LlZujBBbFN+1nl
 UmBZkuBLp4PYQohV8FcVpuyBquBwkS2X96nhKGGrsxsj/l7lIsFPRtT0cIrUhJX8I69q
 pmJeWeTdSl+6d8IaCLSB6USHsqwwBlVLtBno5MCgD+fyBqCnzr1j16bw5EY/rprT7FJO
 EGNWFXf/qf4Go6NpXojKlc/bt6EN5mHNXV2FyMy6HyYedGi9+I/Oyekc1cKNHrFGZNIS
 VSpF9cydlnVlbFlMJdjnpAvZYZq2RXXOzPsier9G7cjp2aVj06zPw0f1k+WOadv4aXCg
 mztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687342868; x=1689934868;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uw8tlsqBxsF7ULGNj0VdZTxHIeQNGmgRoIchpvVq6a4=;
 b=jta7fJEK4MINyuYW4lKcA9IoOPmoTi2fiQusrseMcS7rDoR09c4LHUTkMLVqV34PRn
 m5lVtmTv/ZELa3xDT6sBCf2nsPuNUQ+/M2kSiY0+AMuu4wyRSr8R+RvRq7K0ay21odaM
 p55TGTInF4ev9tRZcwinay0DfdYrWW8Cb1sz8n/6GIyQygGPUDjGcqq4pLVybU658k+k
 j5yQNX8+wWGQ7nCRPG8DCgDIPfUA2Oor3QWazGYI1AH8pAdPYEYVzZatNrhE7V+Pnkoo
 lZ044yezC6rGoEA64NDAVrnzT7P+WluKYoP8U4LlWib9bno+f/izPVXOX++m3kJbypGu
 6GsA==
X-Gm-Message-State: AC+VfDyFxqmzt3e1xM0PntAxo3NInTBN+Ko98SbOphyXWEzPLNWxMcVz
 RpIl2igAFtk53pLrGsL5/pX94A==
X-Google-Smtp-Source: ACHHUZ5hBIP1cnyuAdM3VwADFdW48kp5qzfLiaPTrSpIKq2xTAgf0KkocRxi2HRyGwQQwVgxg+UjFA==
X-Received: by 2002:adf:e507:0:b0:30f:bc98:ede1 with SMTP id
 j7-20020adfe507000000b0030fbc98ede1mr12847546wrm.8.1687342867803; 
 Wed, 21 Jun 2023 03:21:07 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d4c4b000000b003113ccbf388sm4139773wrt.13.2023.06.21.03.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 03:21:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D8EB71FFBB;
 Wed, 21 Jun 2023 11:21:06 +0100 (BST)
References: <20230606132743.1386003-1-iii@linux.ibm.com>
 <20230606132743.1386003-7-iii@linux.ibm.com>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, Dominik 'Disconnect3d'
 Czarnota <dominik.b.czarnota@gmail.com>
Subject: Re: [PATCH v3 6/8] gdbstub: Add support for info proc mappings
Date: Wed, 21 Jun 2023 11:19:45 +0100
In-reply-to: <20230606132743.1386003-7-iii@linux.ibm.com>
Message-ID: <87pm5pglpp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Currently the GDB's generate-core-file command doesn't work well with
> qemu-user: the resulting dumps are huge [1] and at the same time
> incomplete (argv and envp are missing). The reason is that GDB has no
> access to proc mappings and therefore has to fall back to using
> heuristics for discovering them. This is, in turn, because qemu-user
> does not implement the Host I/O feature of the GDB Remote Serial
> Protocol.
>
> Implement vFile:{open,close,pread,readlink} and also
> qXfer:exec-file:read+. With that, generate-core-file begins to work on
> aarch64 and s390x.
>
> [1] https://sourceware.org/pipermail/gdb-patches/2023-May/199432.html
>
> Co-developed-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmai=
l.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  gdbstub/gdbstub.c     |  45 +++++++++++++-
>  gdbstub/internals.h   |   5 ++
>  gdbstub/user-target.c | 139 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index c7e3ee71f2f..d2efefd3528 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1337,6 +1337,36 @@ static const GdbCmdParseEntry gdb_v_commands_table=
[] =3D {
>          .cmd =3D "Kill;",
>          .cmd_startswith =3D 1
>      },
> +#ifdef CONFIG_USER_ONLY
> +    /*
> +     * Host I/O Packets. See [1] for details.
> +     * [1] https://sourceware.org/gdb/onlinedocs/gdb/Host-I_002fO-Packet=
s.html
> +     */
> +    {
> +        .handler =3D gdb_handle_v_file_open,
> +        .cmd =3D "File:open:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s,L,L0"
> +    },
> +    {
> +        .handler =3D gdb_handle_v_file_close,
> +        .cmd =3D "File:close:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l0"
> +    },
> +    {
> +        .handler =3D gdb_handle_v_file_pread,
> +        .cmd =3D "File:pread:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l,L,L0"
> +    },
> +    {
> +        .handler =3D gdb_handle_v_file_readlink,
> +        .cmd =3D "File:readlink:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s0"
> +    },
> +#endif
>  };
>=20=20
>  static void handle_v_commands(GArray *params, void *user_ctx)
> @@ -1482,11 +1512,14 @@ static void handle_query_supported(GArray *params=
, void *user_ctx)
>              ";ReverseStep+;ReverseContinue+");
>      }
>=20=20
> -#if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
> +#if defined(CONFIG_USER_ONLY)
> +#if defined(CONFIG_LINUX)
>      if (gdbserver_state.c_cpu->opaque) {
>          g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
>      }
>  #endif
> +    g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
> +#endif
>=20=20
>      if (params->len &&
>          strstr(get_param(params, 0)->data, "multiprocess+")) {
> @@ -1625,13 +1658,21 @@ static const GdbCmdParseEntry gdb_gen_query_table=
[] =3D {
>          .cmd_startswith =3D 1,
>          .schema =3D "s:l,l0"
>      },
> -#if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
> +#if defined(CONFIG_USER_ONLY)
> +#if defined(CONFIG_LINUX)
>      {
>          .handler =3D gdb_handle_query_xfer_auxv,
>          .cmd =3D "Xfer:auxv:read::",
>          .cmd_startswith =3D 1,
>          .schema =3D "l,l0"
>      },
> +#endif
> +    {
> +        .handler =3D gdb_handle_query_xfer_exec_file,
> +        .cmd =3D "Xfer:exec-file:read:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l:l,l0"
> +    },
>  #endif
>      {
>          .handler =3D gdb_handle_query_attached,
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 25e4d5eeaa6..f2b46cce412 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -189,6 +189,11 @@ typedef union GdbCmdVariant {
>  void gdb_handle_query_rcmd(GArray *params, void *user_ctx); /* softmmu */
>  void gdb_handle_query_offsets(GArray *params, void *user_ctx); /* user */
>  void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx); /*user =
*/
> +void gdb_handle_v_file_open(GArray *params, void *user_ctx); /* user */
> +void gdb_handle_v_file_close(GArray *params, void *user_ctx); /* user */
> +void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
> +void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user=
 */
> +void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /*=
 user */
>=20=20
>  void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both =
*/
>=20=20
> diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
> index fa0e59ec9a5..aa64a8b9440 100644
> --- a/gdbstub/user-target.c
> +++ b/gdbstub/user-target.c
> @@ -11,6 +11,10 @@
>  #include "exec/gdbstub.h"
>  #include "qemu.h"
>  #include "internals.h"
> +#ifdef CONFIG_LINUX
> +#include "linux-user/loader.h"
> +#include "linux-user/qemu.h"
> +#endif
>=20=20
>  /*
>   * Map target signal numbers to GDB protocol signal numbers and vice
> @@ -281,3 +285,138 @@ void gdb_handle_query_xfer_auxv(GArray *params, voi=
d *user_ctx)
>                        gdbserver_state.str_buf->len, true);
>  }
>  #endif
> +
> +static const char *get_filename_param(GArray *params, int i)
> +{
> +    const char *hex_filename =3D get_param(params, i)->data;
> +    gdb_hextomem(gdbserver_state.mem_buf, hex_filename,
> +                 strlen(hex_filename) / 2);
> +    g_byte_array_append(gdbserver_state.mem_buf, (const guint8 *)"", 1);
> +    return (const char *)gdbserver_state.mem_buf->data;
> +}
> +
> +static void hostio_reply_with_data(const void *buf, size_t n)
> +{
> +    g_string_printf(gdbserver_state.str_buf, "F%lx;", n);
> +    gdb_memtox(gdbserver_state.str_buf, buf, n);
> +    gdb_put_packet_binary(gdbserver_state.str_buf->str,
> +                          gdbserver_state.str_buf->len, true);
> +}

This fails on 64/32 builds:

  ../gdbstub/user-target.c: In function =E2=80=98hostio_reply_with_data=E2=
=80=99:
  ../gdbstub/user-target.c:300:50: error: format =E2=80=98%lx=E2=80=99 expe=
cts argument of type =E2=80=98long unsigned int=E2=80=99, but argument 3 ha=
s type =E2=80=98size_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} [-Werr=
or=3Dformat=3D]
    300 |     g_string_printf(gdbserver_state.str_buf, "F%lx;", n);
        |                                                ~~^    ~
        |                                                  |    |
        |                                                  |    size_t {aka=
 unsigned int}
        |                                                  long unsigned int
        |                                                %x
  cc1: all warnings being treated as errors

I think "%zx" is the portable format string you want.


> +void gdb_handle_v_file_open(GArray *params, void *user_ctx)
> +{
> +    const char *filename =3D get_filename_param(params, 0);
> +    uint64_t flags =3D get_param(params, 1)->val_ull;
> +    uint64_t mode =3D get_param(params, 2)->val_ull;
> +
> +#ifdef CONFIG_LINUX
> +    int fd =3D do_guest_openat(gdbserver_state.g_cpu->env_ptr, 0, filena=
me,
> +                             flags, mode, false);
> +#else
> +    int fd =3D open(filename, flags, mode);
> +#endif
> +    if (fd < 0) {
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
> +    } else {
> +        g_string_printf(gdbserver_state.str_buf, "F%d", fd);
> +    }
> +    gdb_put_strbuf();
> +}
> +
> +void gdb_handle_v_file_close(GArray *params, void *user_ctx)
> +{
> +    int fd =3D get_param(params, 0)->val_ul;
> +
> +    if (close(fd) =3D=3D -1) {
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
> +        gdb_put_strbuf();
> +        return;
> +    }
> +
> +    gdb_put_packet("F00");
> +}
> +
> +#define BUFSIZ 8192
> +
> +void gdb_handle_v_file_pread(GArray *params, void *user_ctx)
> +{
> +    int fd =3D get_param(params, 0)->val_ul;
> +    size_t count =3D get_param(params, 1)->val_ull;
> +    off_t offset =3D get_param(params, 2)->val_ull;
> +
> +    size_t bufsiz =3D MIN(count, BUFSIZ);
> +    g_autofree char *buf =3D g_try_malloc(bufsiz);
> +    if (buf =3D=3D NULL) {
> +        gdb_put_packet("E12");
> +        return;
> +    }
> +
> +    ssize_t n =3D pread(fd, buf, bufsiz, offset);
> +    if (n < 0) {
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
> +        gdb_put_strbuf();
> +        return;
> +    }
> +    hostio_reply_with_data(buf, n);
> +}
> +
> +void gdb_handle_v_file_readlink(GArray *params, void *user_ctx)
> +{
> +    const char *filename =3D get_filename_param(params, 0);
> +
> +    g_autofree char *buf =3D g_try_malloc(BUFSIZ);
> +    if (buf =3D=3D NULL) {
> +        gdb_put_packet("E12");
> +        return;
> +    }
> +
> +#ifdef CONFIG_LINUX
> +    ssize_t n =3D do_guest_readlink(filename, buf, BUFSIZ);
> +#else
> +    ssize_t n =3D readlink(filename, buf, BUFSIZ);
> +#endif
> +    if (n < 0) {
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
> +        gdb_put_strbuf();
> +        return;
> +    }
> +    hostio_reply_with_data(buf, n);
> +}
> +
> +void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx)
> +{
> +    uint32_t pid =3D get_param(params, 0)->val_ul;
> +    uint32_t offset =3D get_param(params, 1)->val_ul;
> +    uint32_t length =3D get_param(params, 2)->val_ul;
> +
> +    GDBProcess *process =3D gdb_get_process(pid);
> +    if (!process) {
> +        gdb_put_packet("E00");
> +        return;
> +    }
> +
> +    CPUState *cpu =3D gdb_get_first_cpu_in_process(process);
> +    if (!cpu) {
> +        gdb_put_packet("E00");
> +        return;
> +    }
> +
> +    TaskState *ts =3D cpu->opaque;
> +    if (!ts || !ts->bprm || !ts->bprm->filename) {
> +        gdb_put_packet("E00");
> +        return;
> +    }
> +
> +    size_t total_length =3D strlen(ts->bprm->filename);
> +    if (offset > total_length) {
> +        gdb_put_packet("E00");
> +        return;
> +    }
> +    if (offset + length > total_length) {
> +        length =3D total_length - offset;
> +    }
> +
> +    g_string_printf(gdbserver_state.str_buf, "l%.*s", length,
> +                    ts->bprm->filename + offset);
> +    gdb_put_strbuf();
> +}


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

