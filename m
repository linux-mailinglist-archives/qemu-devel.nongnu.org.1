Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B2798643
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:06:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZHs-0002KF-RA; Fri, 08 Sep 2023 07:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeZHj-0002Jc-5h; Fri, 08 Sep 2023 07:04:23 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeZHS-0001tx-LW; Fri, 08 Sep 2023 07:04:22 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57325fcd970so1154212eaf.1; 
 Fri, 08 Sep 2023 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694171045; x=1694775845; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M/BGf/hqM1xaZas1e+ExMHl6xUYwDiGdRO4Z8lZ9kNQ=;
 b=LOyAPa8N/MVly4i9UEfAxj/PWq+K820JSYNeIbrDz5Pd5Wr9ii+0QqI2qPpJbd+bm2
 Yjk3IAy2SscL5JwJiss3q6nWfNx8z7pTIHyslfSWSCuUxgNv5dCsCBw6dtuqOJ4ezdKl
 gZ0hxZz2YzQS415kr9U6eUUhOVcuxdp/R7iQen+30HBLdPis2UA8haelPE5+dXvbGZ2o
 d3lD7CslJ5vifLMT7hDsENnwNG9I/jmdyp5rO8EZBm8Cj/WyR1oM7TLcywwXZQ1zZa+H
 QlWNL2zBm0vMToHFup6s6Oh68YA1rvqVCbq4Ki3O52Bl8BwMu4zjNAhF9J+nJJemej+Q
 DMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694171045; x=1694775845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/BGf/hqM1xaZas1e+ExMHl6xUYwDiGdRO4Z8lZ9kNQ=;
 b=kyqQ9EzApnNf0tV0NUxdcGPoMbTFSIfpS+9e8auwSahAbKe9QGAH+cXLI7OJGwkClS
 NHe2f9IXyG+jig/oWr1BgGNGymNQXpD33V2rSBtAQtr4yXyVVAi4lmGTFaeEaOQjv4wE
 YRyNXlpekyNih1kISNErKtKOiZ1D8Lbo9VyNQVVgOln5jY4WpMkx3imBvXIOTA1VGZll
 0P/1iJYIM/4rHnSklTAycTbVCOV+3g8/TK4RQaCrkCFwV0J8FiB7lp6zXE048yTtBVm6
 yln9yXZQcLQM9/zevS4ytGIdE8OmHlGawEJz7gkpl6Bb8obLbpH0J7znrSZ6wZLXavEG
 3iHA==
X-Gm-Message-State: AOJu0YxZUKCQVxT44MisJCBdjiMUGr9rrawwA85OmtOrG4uF5VhkJgfP
 q4dThdu1xFtdT4hdONXM2cmIgduTBfu7kb8UoPk=
X-Google-Smtp-Source: AGHT+IGzV4YGWh4S1ZyrdHrKJMruOCeeOdwCNs/piyeOojQJMFJYILUY8O6egWZNWGCUlwNOVhcZ8JAVBJhlAIclNCg=
X-Received: by 2002:a4a:8111:0:b0:571:28d5:2c77 with SMTP id
 b17-20020a4a8111000000b0057128d52c77mr2108762oog.5.1694171044986; Fri, 08 Sep
 2023 04:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230908013535.990731-15-eblake@redhat.com>
 <20230908013535.990731-27-eblake@redhat.com>
In-Reply-To: <20230908013535.990731-27-eblake@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Sep 2023 07:03:52 -0400
Message-ID: <CAJSP0QWYDPU-26Jt7-SN4s-hyL1jg4-_eXz+9huCfzO+nL8D=w@mail.gmail.com>
Subject: Re: [PULL 12/13] qemu-nbd: Restore "qemu-nbd -v --fork" output
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, 
 Mike Maslenkin <mike.maslenkin@gmail.com>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Please resolve the following CI failure:

https://gitlab.com/qemu-project/qemu/-/jobs/5045998355

ninja: job failed: cc -m64 -mcx16 -Iqemu-nbd.p -I. -I.. -Iqapi -Itrace
-Iui -Iui/shader -I/usr/include/p11-kit-1 -I/usr/include/glib-2.0
-I/usr/lib/glib-2.0/include -fdiagnostics-color=auto -Wall
-Winvalid-pch -Werror -std=gnu11 -O2 -g -fstack-protector-strong
-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -Wundef -Wwrite-strings
-Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls
-Wold-style-declaration -Wold-style-definition -Wtype-limits
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
-Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
-Wimplicit-fallthrough=2 -Wmissing-format-attribute
-Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
-isystem /builds/qemu-project/qemu/linux-headers -isystem
linux-headers -iquote . -iquote /builds/qemu-project/qemu -iquote
/builds/qemu-project/qemu/include -iquote
/builds/qemu-project/qemu/host/include/x86_64 -iquote
/builds/qemu-project/qemu/host/include/generic -iquote
/builds/qemu-project/qemu/tcg/i386 -pthread -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
-fno-common -fwrapv -fPIE -MD -MQ qemu-nbd.p/qemu-nbd.c.o -MF
qemu-nbd.p/qemu-nbd.c.o.d -o qemu-nbd.p/qemu-nbd.c.o -c ../qemu-nbd.c
In file included from /usr/include/fortify/stdio.h:23,
from ../include/qemu/osdep.h:110,
from ../qemu-nbd.c:19:
../qemu-nbd.c: In function 'nbd_client_thread':
../qemu-nbd.c:340:39: error: expected identifier before '(' token
340 | nbd_client_release_pipe(opts->stderr);
| ^~~~~~
../qemu-nbd.c: In function 'main':
../qemu-nbd.c:605:10: error: expected identifier before '(' token
605 | .stderr = STDOUT_FILENO,
| ^~~~~~
../qemu-nbd.c:962:22: error: expected identifier before '(' token
962 | opts.stderr = dup(STDERR_FILENO);
| ^~~~~~
../qemu-nbd.c:963:26: error: expected identifier before '(' token
963 | if (opts.stderr < 0) {
| ^~~~~~
../qemu-nbd.c:1200:38: error: expected identifier before '(' token
1200 | nbd_client_release_pipe(opts.stderr);
| ^~~~~~

On Thu, 7 Sept 2023 at 21:37, Eric Blake <eblake@redhat.com> wrote:
>
> From: "Denis V. Lunev" <den@openvz.org>
>
> Closing stderr earlier is good for daemonized qemu-nbd under ssh
> earlier, but breaks the case where -v is being used to track what is
> happening in the server, as in iotest 233.
>
> When we know we are verbose, we should preserve original stderr and
> restore it once the setup stage is done. This commit restores the
> original behavior with -v option. In this case original output
> inside the test is kept intact.
>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Mike Maslenkin <mike.maslenkin@gmail.com>
> Fixes: 5c56dd27a2 ("qemu-nbd: fix regression with qemu-nbd --fork run over ssh")
> Message-ID: <20230906093210.339585-7-den@openvz.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Tested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-nbd.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 7c4e22def17..1cdc41ed292 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -255,18 +255,23 @@ struct NbdClientOpts {
>      char *device;
>      char *srcpath;
>      SocketAddress *saddr;
> +    int stderr;
>      bool fork_process;
>      bool verbose;
>  };
>
> -static void nbd_client_release_pipe(void)
> +static void nbd_client_release_pipe(int old_stderr)
>  {
>      /* Close stderr so that the qemu-nbd process exits.  */
> -    if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
> +    if (dup2(old_stderr, STDERR_FILENO) < 0) {
>          error_report("Could not release pipe to parent: %s",
>                       strerror(errno));
>          exit(EXIT_FAILURE);
>      }
> +    if (old_stderr != STDOUT_FILENO && close(old_stderr) < 0) {
> +        error_report("Could not release qemu-nbd: %s", strerror(errno));
> +        exit(EXIT_FAILURE);
> +    }
>  }
>
>  #if HAVE_NBD_DEVICE
> @@ -332,7 +337,7 @@ static void *nbd_client_thread(void *arg)
>          fprintf(stderr, "NBD device %s is now connected to %s\n",
>                  opts->device, opts->srcpath);
>      } else {
> -        nbd_client_release_pipe();
> +        nbd_client_release_pipe(opts->stderr);
>      }
>
>      if (nbd_client(fd) < 0) {
> @@ -597,6 +602,7 @@ int main(int argc, char **argv)
>          .device = NULL,
>          .srcpath = NULL,
>          .saddr = NULL,
> +        .stderr = STDOUT_FILENO,
>      };
>
>  #ifdef CONFIG_POSIX
> @@ -951,6 +957,16 @@ int main(int argc, char **argv)
>
>              close(stderr_fd[0]);
>
> +            /* Remember parent's stderr if we will be restoring it. */
> +            if (opts.verbose /* fork_process is set */) {
> +                opts.stderr = dup(STDERR_FILENO);
> +                if (opts.stderr < 0) {
> +                    error_report("Could not dup original stderr: %s",
> +                                 strerror(errno));
> +                    exit(EXIT_FAILURE);
> +                }
> +            }
> +
>              ret = qemu_daemon(1, 0);
>              saved_errno = errno;    /* dup2 will overwrite error below */
>
> @@ -1181,7 +1197,7 @@ int main(int argc, char **argv)
>      }
>
>      if (opts.fork_process) {
> -        nbd_client_release_pipe();
> +        nbd_client_release_pipe(opts.stderr);
>      }
>
>      state = RUNNING;
> --
> 2.41.0
>
>

