Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D727433C5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 06:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF67X-0000oS-7F; Fri, 30 Jun 2023 00:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF67U-0000o7-Vh
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 00:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF67T-0005XW-3F
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 00:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688100749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxfsUcSD7c3FFnuk7BufI9QDxF8LZu0znMXP0FGbkQM=;
 b=EHLNQZFOlHF/xtYSkx2jeh7U8FKOY3pcFcJjtoo0I8lqw+CcaYpdC7+jRpYlOyiiwKzvjU
 kA8hIwX3SJy6kF5w8oYk+/NqnpF0uyiOlW9GE2Pb9A6iAP1n7M3jLawbrMvvap+1eeu6FE
 gC18RW2gD9LO/5R21qE97n8pq546+oY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-4wAFsDzFOnmObp6TyzDSTg-1; Fri, 30 Jun 2023 00:52:27 -0400
X-MC-Unique: 4wAFsDzFOnmObp6TyzDSTg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b69dcf0d73so16192001fa.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 21:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688100746; x=1690692746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LxfsUcSD7c3FFnuk7BufI9QDxF8LZu0znMXP0FGbkQM=;
 b=Axan9mg32Hp8Ywt5JrkkFJBHTkTvCzvhfCng59fu6sNaX3BQ/GfTW7IbmV6LIa+ZBE
 0LMXzYT9IYNeFtMdH3uqvdqYgDeYtL6KO7vqe+nADv/YbdiDPVpvlYjkyjeai0yFSl8C
 0qe8oml0Pb53FF2jgIX0KfUGZMwOGuKQczMVQyVmeRR0RNrFpLubPCA6CZ4wvyBiNhdn
 NfBddpklxXoNlKzaBsNmHgHdWurhTZtER3QSNdu8eDWVPxw93q3btzM1bUqV3qSBa+J/
 2fcD9wuFVJHaN9+A7/Rqer2Sc6dp0Z5/+yLQCpBRlR3ZQDpVhYpmkB/VV+Zhr7oMXhlP
 lWRg==
X-Gm-Message-State: ABy/qLaNnNWMM8m1hxxvJddTRi1maiqqM+zwmOEdT54dVi2V+ejhGFef
 1l8DIvEjdlWo2clTVVlvqrhT3+6UfG95X03ysqp9C20Zyk3dcpX61s8cMPxUoJKx2Fm+R42p/hz
 O6cGAQvHzC6QMxlDvK3SvGGJw482dF/Y=
X-Received: by 2002:a2e:3315:0:b0:2b4:70c1:b484 with SMTP id
 d21-20020a2e3315000000b002b470c1b484mr1102047ljc.38.1688100746113; 
 Thu, 29 Jun 2023 21:52:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPG/opP9obYpqKSZc/0BfkxJ5nLo5rFVIp2jyrT/m+PDqP2vmi4oEFZdVzv4nmiTeqCm/5hQw+p0pttX7WTtA=
X-Received: by 2002:a2e:3315:0:b0:2b4:70c1:b484 with SMTP id
 d21-20020a2e3315000000b002b470c1b484mr1102040ljc.38.1688100745749; Thu, 29
 Jun 2023 21:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230628152726.110295-1-bmeng@tinylab.org>
 <20230628152726.110295-7-bmeng@tinylab.org>
In-Reply-To: <20230628152726.110295-7-bmeng@tinylab.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jun 2023 12:52:14 +0800
Message-ID: <CACGkMEu_h4-DMMOY+=wmL0LeTWAELeQPiBjucEEG=ud4EtuLSw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] net: tap: Use qemu_close_range() to close fds
To: Bin Meng <bmeng@tinylab.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Zhangjin Wu <falcon@tinylab.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 28, 2023 at 11:29=E2=80=AFPM Bin Meng <bmeng@tinylab.org> wrote=
:
>
> From: Zhangjin Wu <falcon@tinylab.org>
>
> Current codes using a brute-force traversal of all file descriptors
> do not scale on a system where the maximum number of file descriptors
> is set to a very large value (e.g.: in a Docker container of Manjaro
> distribution it is set to 1073741816). QEMU just looks frozen during
> start-up.
>
> The close-on-exec flag (O_CLOEXEC) was introduced since Linux kernel
> 2.6.23, FreeBSD 8.3, OpenBSD 5.0, Solaris 11. While it's true QEMU
> doesn't need to manually close the fds for child process as the proper
> O_CLOEXEC flag should have been set properly on files with its own
> codes, QEMU uses a huge number of 3rd party libraries and we don't
> trust them to reliably be using O_CLOEXEC on everything they open.
>
> Modern Linux and BSDs have the close_range() call we can use to do the
> job, and on Linux we have one more way to walk through /proc/self/fd
> to complete the task efficiently, which is what qemu_close_range() does.
>
> Reported-by: Zhangjin Wu <falcon@tinylab.org>
> Co-developed-by: Bin Meng <bmeng@tinylab.org>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Patch looks good but I'm not sure using helper scripts is good for the
production environment since it increases attack surfaces. Passing TAP
fd should be a better way.

Thanks

>
> ---
>
> Changes in v4:
> - put fd on its own line
>
> Changes in v2:
> - Change to use qemu_close_range() to close fds for child process efficie=
ntly
> - v1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bme=
ng@tinylab.org/
>
>  net/tap.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index 1bf085d422..9f080215f0 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -446,13 +446,13 @@ static void launch_script(const char *setup_script,=
 const char *ifname,
>          return;
>      }
>      if (pid =3D=3D 0) {
> -        int open_max =3D sysconf(_SC_OPEN_MAX), i;
> +        unsigned int last_fd =3D sysconf(_SC_OPEN_MAX) - 1;
> +
> +        /* skip stdin, stdout and stderr */
> +        qemu_close_range(3, fd - 1);
> +        /* skip the currently used fd */
> +        qemu_close_range(fd + 1, last_fd);
>
> -        for (i =3D 3; i < open_max; i++) {
> -            if (i !=3D fd) {
> -                close(i);
> -            }
> -        }
>          parg =3D args;
>          *parg++ =3D (char *)setup_script;
>          *parg++ =3D (char *)ifname;
> @@ -536,16 +536,16 @@ static int net_bridge_run_helper(const char *helper=
, const char *bridge,
>          return -1;
>      }
>      if (pid =3D=3D 0) {
> -        int open_max =3D sysconf(_SC_OPEN_MAX), i;
> +        unsigned int last_fd =3D sysconf(_SC_OPEN_MAX) - 1;
> +        unsigned int fd =3D sv[1];
>          char *fd_buf =3D NULL;
>          char *br_buf =3D NULL;
>          char *helper_cmd =3D NULL;
>
> -        for (i =3D 3; i < open_max; i++) {
> -            if (i !=3D sv[1]) {
> -                close(i);
> -            }
> -        }
> +        /* skip stdin, stdout and stderr */
> +        qemu_close_range(3, fd - 1);
> +        /* skip the currently used fd */
> +        qemu_close_range(fd + 1, last_fd);
>
>          fd_buf =3D g_strdup_printf("%s%d", "--fd=3D", sv[1]);
>
> --
> 2.34.1
>


