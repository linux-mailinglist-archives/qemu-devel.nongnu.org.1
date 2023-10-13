Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB127C8A15
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 18:09:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKiC-0003zs-4U; Fri, 13 Oct 2023 12:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKi8-0003zK-HE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:08:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKi3-0001Oh-16
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:08:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4065dea9a33so23138915e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697213296; x=1697818096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yceGXSNOqAMzE7ulKmOV4wFyZ1teT7cC1MzXL9/Y7Ks=;
 b=fNUhtmiIYnYHxGseflmqKamkJ5ip0rKUEynuTQ9c7wqjUA9atgXm7GGLQfNDLwPpJs
 81RqtMgjSxxKM88fytchSrq3w1MduPOClSw1+efV3p86F0YFuqsRiti0nxjVfsXQlEfO
 iBxHq8neIQrnEbvA3K9wJliTzxGC9+jBeuRjRSrJSH1O8t3D6XSXNf8QWsF0M7ZoJQGf
 hmX05ogd7ZsKzdhOwrmRQxOgGFyIHCGoUnoO1YgmjfPsVxZXoknL80dzOvPonexOoOzq
 POuuDRKzuhBwhQ9hxNtBQ5Ft4tAmbeIrtecAHKk4/EOeJukp+nSaQywU+reecLFZGgdt
 zjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697213296; x=1697818096;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yceGXSNOqAMzE7ulKmOV4wFyZ1teT7cC1MzXL9/Y7Ks=;
 b=bfpXoobhhMKhup5/kk1uG4uL8NfaMqVT6QkeMhF9geS3KGWC6wa9bDPYVK19d1JEUy
 qZIZG65q/kBAV7R+/FWIwNIFDpH6FnDklvnSTjZaM3svTf6cPskyPXUlosAtfRw4i13g
 ZDzLbQGcvdtHoIRjex7Gt9xcs3zPgGHEkVfnrJmrB5JZ//ESsEn2YkxLB4i9+MmXM5w/
 S1yWbFMwte7eEe2eTTgDPSsX5y16qPD+Z9VZXL2NM5XvpQG/XjqdQlXLT+OgmtKAYBtN
 012dtLniCFxOomxKnXwqjW2cNVeg0qu8/M5BTzzl1vTN2GWtVOGRwdFOV0FWL/zF0mw+
 /cIA==
X-Gm-Message-State: AOJu0YyrTE2HtY6K43BZax41viGwzDlPTtbu0g/JVHvp1ZS0U3+SXFqJ
 wKSR6GkPAxQDtox4t4cssboF3Q==
X-Google-Smtp-Source: AGHT+IEcpPzMpXy5WIe7Hl6cfXMgxB3wgcMeZLOnL8PpLICWwnMNW07ndWUtQYLODF27Q/CDQM9bdg==
X-Received: by 2002:a05:600c:299:b0:405:3e92:76db with SMTP id
 25-20020a05600c029900b004053e9276dbmr23265571wmk.5.1697213295999; 
 Fri, 13 Oct 2023 09:08:15 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 be3-20020a05600c1e8300b0040644e699a0sm505575wmb.45.2023.10.13.09.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:08:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E8EAD1FFBB;
 Fri, 13 Oct 2023 17:08:14 +0100 (BST)
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
 <20231006090610.26171-2-nicolas.eder@lauterbach.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian.Boenig@lauterbach.com
Subject: Re: [PATCH v2 01/29] mcdstub initial commit, mcdstub file structure
 added
Date: Fri, 13 Oct 2023 16:51:59 +0100
In-reply-to: <20231006090610.26171-2-nicolas.eder@lauterbach.com>
Message-ID: <87h6mumro1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> From: neder <nicolas.eder@lauterbach.com>
>
> ---
>  include/exec/mcdstub.h   | 31 +++++++++++++
>  mcdstub/mcd_softmmu.c    | 85 +++++++++++++++++++++++++++++++++++
>  mcdstub/mcd_syscalls.c   |  0
>  mcdstub/mcd_tcp_server.c | 95 ++++++++++++++++++++++++++++++++++++++++
>  mcdstub/mcdstub.c        |  0
>  softmmu/vl.c             |  4 ++

I'm afraid you got caught up in some clean-up and this file is now under
the more correctly names:

  system/vl.c

>  6 files changed, 215 insertions(+)
>  create mode 100644 include/exec/mcdstub.h
>  create mode 100644 mcdstub/mcd_softmmu.c
>  create mode 100644 mcdstub/mcd_syscalls.c
>  create mode 100644 mcdstub/mcd_tcp_server.c
>  create mode 100644 mcdstub/mcdstub.c
>
> diff --git a/include/exec/mcdstub.h b/include/exec/mcdstub.h
> new file mode 100644
> index 0000000000..8afbc09367
> --- /dev/null
> +++ b/include/exec/mcdstub.h

include/exec is a bit of a dumping ground. Maybe
include/mcdstub/mcdstub.h to keep it cleaner? For gdbstub we further
divide into user, system and api.h but that might be overkill.

> @@ -0,0 +1,31 @@
> +#ifndef MCDSTUB_H
> +#define MCDSTUB_H
> +
> +#define DEFAULT_MCDSTUB_PORT "1234"
> +
> +/* MCD breakpoint/watchpoint types */
> +#define MCD_BREAKPOINT_SW        0
> +#define MCD_BREAKPOINT_HW        1
> +#define MCD_WATCHPOINT_WRITE     2
> +#define MCD_WATCHPOINT_READ      3
> +#define MCD_WATCHPOINT_ACCESS    4
> +
> +
> +/* Get or set a register.  Returns the size of the register.  */
> +typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int re=
g);
> +typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
> +void gdb_register_coprocessor(CPUState *cpu,
> +                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set=
_reg,
> +                              int num_regs, const char *xml, int
> g_pos);

Why repeat these definitions instead just including gdbstub.h? We can
move the typedefs if you don't want to pollute the include with other
ephemera.

> +
> +/**
> + * mcdserver_start: start the mcd server
> + * @port_or_device: connection spec for mcd
> + *
> + * This is a TCP port
> + */
> +int mcdserver_start(const char *port_or_device);
> +
> +void gdb_set_stop_cpu(CPUState *cpu);
> +
> +#endif
> diff --git a/mcdstub/mcd_softmmu.c b/mcdstub/mcd_softmmu.c
> new file mode 100644
> index 0000000000..17e1d3ca1b
> --- /dev/null
> +++ b/mcdstub/mcd_softmmu.c

rename ;-)

> @@ -0,0 +1,85 @@
> +/*
> + * this handeles all system emulation functions for the mcdstub
> + */
> +
> +#include "exec/mcdstub.h"
> +
> +int mcdserver_start(const char *device)
> +{
> +    trace_gdbstub_op_start(device);
> +
> +    char gdbstub_device_name[128];
> +    Chardev *chr =3D NULL;
> +    Chardev *mon_chr;
> +
> +    if (!first_cpu) {
> +        error_report("gdbstub: meaningless to attach gdb to a "
> +                     "machine without any CPU.");
> +        return -1;
> +    }
> +
> +    if (!gdb_supports_guest_debug()) {
> +        error_report("gdbstub: current accelerator doesn't "
> +                     "support guest debugging");
> +        return -1;
> +    }
> +
> +    if (!device) {
> +        return -1;
> +    }
> +    if (strcmp(device, "none") !=3D 0) {
> +        if (strstart(device, "tcp:", NULL)) {
> +            /* enforce required TCP attributes */
> +            snprintf(gdbstub_device_name, sizeof(gdbstub_device_name),
> +                     "%s,wait=3Doff,nodelay=3Don,server=3Don", device);
> +            device =3D gdbstub_device_name;
> +        }
> +#ifndef _WIN32
> +        else if (strcmp(device, "stdio") =3D=3D 0) {
> +            struct sigaction act;
> +
> +            memset(&act, 0, sizeof(act));
> +            act.sa_handler =3D gdb_sigterm_handler;
> +            sigaction(SIGINT, &act, NULL);
> +        }
> +#endif
> +        /*
> +         * FIXME: it's a bit weird to allow using a mux chardev here
> +         * and implicitly setup a monitor. We may want to break this.
> +         */
> +        chr =3D qemu_chr_new_noreplay("gdb", device, true, NULL);
> +        if (!chr) {
> +            return -1;
> +        }
> +    }
> +
> +    if (!gdbserver_state.init) {
> +        gdb_init_gdbserver_state();
> +
> +        qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
> +
> +        /* Initialize a monitor terminal for gdb */
> +        mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
> +                                   NULL, NULL, &error_abort);
> +        monitor_init_hmp(mon_chr, false, &error_abort);
> +    } else {
> +        qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
> +        mon_chr =3D gdbserver_system_state.mon_chr;
> +        reset_gdbserver_state();
> +    }
> +
> +    create_processes(&gdbserver_state);
> +
> +    if (chr) {
> +        qemu_chr_fe_init(&gdbserver_system_state.chr, chr, &error_abort);
> +        qemu_chr_fe_set_handlers(&gdbserver_system_state.chr,
> +                                 gdb_chr_can_receive,
> +                                 gdb_chr_receive, gdb_chr_event,
> +                                 NULL, &gdbserver_state, NULL, true);
> +    }
> +    gdbserver_state.state =3D chr ? RS_IDLE : RS_INACTIVE;
> +    gdbserver_system_state.mon_chr =3D mon_chr;
> +    gdb_syscall_reset();

So this is showing a lot of c&p of the gdbstub but if the intention is
to re-use chunks of gdbstub we should do it properly rather than
duplicating code.

> +
> +    return 0;
> +}
> \ No newline at end of file
> diff --git a/mcdstub/mcd_syscalls.c b/mcdstub/mcd_syscalls.c
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/mcdstub/mcd_tcp_server.c b/mcdstub/mcd_tcp_server.c
> new file mode 100644
> index 0000000000..9a1baea2e4
> --- /dev/null
> +++ b/mcdstub/mcd_tcp_server.c
> @@ -0,0 +1,95 @@
> +#include <stdio.h>
> +#include <netdb.h>
> +#include <netinet/in.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +#include <unistd.h> // read(), write(), close()

#include "qemu/osdep.h" will bring in most of the standard stuff:

  Order include directives as follows:

  .. code-block:: c

      #include "qemu/osdep.h"  /* Always first... */
      #include <...>           /* then system headers... */
      #include "..."           /* and finally QEMU headers. */

  The "qemu/osdep.h" header contains preprocessor macros that affect the be=
havior
  of core system headers like <stdint.h>.  It must be the first include so =
that
  core system headers included by external libraries get the preprocessor m=
acros
  that QEMU depends on.

See https://qemu.readthedocs.io/en/v8.1.0/devel/style.html

Running ./scripts/checkpatch.pl will pick a lot of this up.

> +#define MAX 80
> +#define DEFAULT_MCDSTUB_PORT "1234"
> +#define SA struct sockaddr
> +
> +// Function designed for chat between client and server.

c.f. style

> +void func(int connfd)
> +{
> +	char buff[MAX];
> +	int n;
> +	// infinite loop for chat
> +	for (;;) {
> +		bzero(buff, MAX);
> +
> +		// read the message from client and copy it in buffer
> +		read(connfd, buff, sizeof(buff));
> +		// print buffer which contains the client contents
> +		printf("From client: %s\t To client : ", buff);
> +		bzero(buff, MAX);
> +		n =3D 0;
> +		// copy server message in the buffer
> +		while ((buff[n++] =3D getchar()) !=3D '\n')
> +			;
> +
> +		// and send that buffer to client
> +		write(connfd, buff, sizeof(buff));
> +
> +		// if msg contains "Exit" then server exit and chat ended.
> +		if (strncmp("exit", buff, 4) =3D=3D 0) {
> +			printf("Server Exit...\n");
> +			break;
> +		}
> +	}
> +}
> +
> +// Driver function
> +int main()

why main? Is this a helper?

> +{
> +	int sockfd, connfd, len;
> +	struct sockaddr_in servaddr, cli;
> +
> +	// socket create and verification
> +	sockfd =3D socket(AF_INET, SOCK_STREAM, 0);
> +	if (sockfd =3D=3D -1) {
> +		printf("socket creation failed...\n");
> +		exit(0);
> +	}
> +	else
> +		printf("Socket successfully created..\n");
> +	bzero(&servaddr, sizeof(servaddr));
> +
> +	// assign IP, PORT
> +	servaddr.sin_family =3D AF_INET;
> +	servaddr.sin_addr.s_addr =3D htonl(INADDR_ANY);
> +	servaddr.sin_port =3D htons(DEFAULT_MCDSTUB_PORT);
> +
> +	// Binding newly created socket to given IP and verification
> +	if ((bind(sockfd, (SA*)&servaddr, sizeof(servaddr))) !=3D 0) {
> +		printf("socket bind failed...\n");
> +		exit(0);
> +	}
> +	else
> +		printf("Socket successfully binded..\n");
> +
> +	// Now server is ready to listen and verification
> +	if ((listen(sockfd, 5)) !=3D 0) {
> +		printf("Listen failed...\n");
> +		exit(0);
> +	}
> +	else
> +		printf("Server listening..\n");
> +	len =3D sizeof(cli);
> +
> +	// Accept the data packet from client and verification
> +	connfd =3D accept(sockfd, (SA*)&cli, &len);
> +	if (connfd < 0) {
> +		printf("server accept failed...\n");
> +		exit(0);
> +	}
> +	else
> +		printf("server accept the client...\n");
> +
> +	// Function for chatting between client and server
> +	func(connfd);
> +
> +	// After chatting close the socket
> +	close(sockfd);
> +}

I think you need to make a design choice here about if MCD wants to
support *-user and system emulation or just system emulation. The
gdbstub does hand roll its own bind/accept code for *-user because it
doesn't include most of the rest of QEMU. However for system emulation
we use the chardev system which already provides and abstracts a lot of
this stuff. Then the code becomes simpler:

    if (chr) {
        qemu_chr_fe_init(&gdbserver_system_state.chr, chr, &error_abort);
        qemu_chr_fe_set_handlers(&gdbserver_system_state.chr,
                                 gdb_chr_can_receive,
                                 gdb_chr_receive, gdb_chr_event,
                                 NULL, &gdbserver_state, NULL, true);
    }

and you check need to plug in the handlers.

> diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 98e071e63b..3278f204ea 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -1258,6 +1258,7 @@ struct device_config {
>          DEV_PARALLEL,  /* -parallel      */
>          DEV_DEBUGCON,  /* -debugcon */
>          DEV_GDB,       /* -gdb, -s */
> +        DEV_MCD,       /* -mcd */
>          DEV_SCLP,      /* s390 sclp */
>      } type;
>      const char *cmdline;
> @@ -3011,6 +3012,9 @@ void qemu_init(int argc, char **argv)
>              case QEMU_OPTION_gdb:
>                  add_device_config(DEV_GDB, optarg);
>                  break;
> +            case QEMU_OPTION_mcd:
> +                add_device_config(DEV_MCD, optarg);
> +                break;

This breaks the compile because presumably qemu-options.hx hasn't an
entry for this yet.

>              case QEMU_OPTION_L:
>                  if (is_help_option(optarg)) {
>                      list_data_dirs =3D true;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

