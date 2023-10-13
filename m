Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EFF7C8AFB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 18:28:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrL1d-0003Sa-25; Fri, 13 Oct 2023 12:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrL1a-0003SR-Rq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:28:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrL1X-0004sx-U5
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:28:30 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so2123154f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697214506; x=1697819306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYbps5h1/XZLSKfpavUAKf2qY2jPxlxZJO0maHEZcL8=;
 b=u0oOh3Ci1ppVVeooeKPfWFnoQC/IZEEraZz9OWX8YMTnBmmbW4UjJJzIw5rbiEJjPe
 tfGqPXBl/qyc3LMSazt2YPTui19pNuLaluyVC+8swmPA8HWVxH2opAQ0+39rooWrRBwL
 qUytOH0+E8GldEJNbe7UILp+MbYwJnXm/kWQA5erbxZL/yfZpRAf1brx+IoEtoXHWXKi
 RSw5QulWgKwfwjymK5tdgBFUN71VpsGKn7ZwFmPdlZnc7epn/Yy/a6JiSf8uNRkhhkNS
 /Uftdzhxrr9+8g2mWdixrtcxtDn05U1iIyCRB/jpec8kMHtNIJplfu0wQDfqLspLP3mw
 celA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697214506; x=1697819306;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sYbps5h1/XZLSKfpavUAKf2qY2jPxlxZJO0maHEZcL8=;
 b=dS1+uMzLBfUJlTg4bljOAEqS8NMO+wv3rJryqftMwzoF3ZSICPzg0Y+9wsV6bSbWLN
 kA+moARNY7c4vYOPHcK5jVd4CVaR1MAjwuWnVZ8t1suZueLCQpB3P3jcT/BcqD9ys31I
 31yixhIu41RxhaZ9dycaQ1iNwaNQxKlRrCJlBPxK/KLkfCPxLR5bGo6EEwXJrkkkBqk0
 9zPU07xhfM9RM1bo4i2URh0FH37syCVu1R+epEA7XD4mGGb2HKwYdJXVO4c8YHIeGy6H
 lHTqanHU5nZmlKJN/IxBw4SkL2LHlgwy5DMkZOaNtWBLKwwbkUhyfmzVq268K4N6QEq3
 dpgw==
X-Gm-Message-State: AOJu0Yx2/4peD8QLkGo/ZJZerrkD2W0JKHmo1rtI8ilfMu2ySxeWfHVU
 A4Bp5e7gS+Oljd4gw8rRRW23Qw==
X-Google-Smtp-Source: AGHT+IHVHx5FNyIWJpLQzQBAp3roBYXChG7uM9tFOysVNYJdxY/55QD2lygpFZiR63/h41VuiPHeaA==
X-Received: by 2002:adf:eac6:0:b0:32d:9a7c:56ed with SMTP id
 o6-20020adfeac6000000b0032d9a7c56edmr2219772wrn.10.1697214505916; 
 Fri, 13 Oct 2023 09:28:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 bu21-20020a056000079500b0032d829e10c0sm8082097wrb.28.2023.10.13.09.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:28:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 204081FFBB;
 Fri, 13 Oct 2023 17:28:25 +0100 (BST)
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
 <20231006090610.26171-3-nicolas.eder@lauterbach.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian.Boenig@lauterbach.com
Subject: Re: [PATCH v2 02/29] TCP chardev added, handshake with TRACE32 working
Date: Fri, 13 Oct 2023 17:15:33 +0100
In-reply-to: <20231006090610.26171-3-nicolas.eder@lauterbach.com>
Message-ID: <87cyximqqe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
>  gdbstub/gdbstub.c          |   2 +-
>  include/exec/mcdstub.h     |  21 +-
>  include/mcdstub/syscalls.h |   6 +
>  mcdstub/internals.h        | 135 ++++++++++
>  mcdstub/mcd_softmmu.c      | 218 +++++++++++-----
>  mcdstub/mcd_syscalls.c     |  20 ++
>  mcdstub/mcd_tcp_server.c   |   2 +-
>  mcdstub/mcdstub.c          | 519 +++++++++++++++++++++++++++++++++++++
>  mcdstub/meson.build        |  25 ++
>  meson.build                |   1 +
>  qemu-options.hx            |  25 ++
>  softmmu/vl.c               |   9 +
>  12 files changed, 901 insertions(+), 82 deletions(-)
>  create mode 100644 include/mcdstub/syscalls.h
>  create mode 100644 mcdstub/internals.h
>  create mode 100644 mcdstub/meson.build
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 349d348c7b..2ff50757bb 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -857,7 +857,7 @@ static int process_string_cmd(const char *data,
>=20=20
>          if (cmd->schema) {
>              if (cmd_parse_params(&data[strlen(cmd->cmd)],
> -                                 cmd->schema, params)) {
> +                                 cmd->schema, params)) {=20
>                  return -1;
>              }
>          }

stray whitespace change

> diff --git a/include/exec/mcdstub.h b/include/exec/mcdstub.h
> index 8afbc09367..abf7beb634 100644
> --- a/include/exec/mcdstub.h
> +++ b/include/exec/mcdstub.h
> @@ -1,7 +1,10 @@
>  #ifndef MCDSTUB_H
>  #define MCDSTUB_H
>=20=20
> -#define DEFAULT_MCDSTUB_PORT "1234"
> +#define DEFAULT_MCDSTUB_PORT "1235"

Bring symbols in when you need them to avoid the churn.

> +#define TYPE_CHARDEV_MCD "chardev-mcd"
> +#define MX_INPUT_LENGTH 9
> +#define MCD_TCP_DATALEN 80
>=20=20
>  /* MCD breakpoint/watchpoint types */
>  #define MCD_BREAKPOINT_SW        0
> @@ -10,22 +13,12 @@
>  #define MCD_WATCHPOINT_READ      3
>  #define MCD_WATCHPOINT_ACCESS    4
>=20=20
> -
> -/* Get or set a register.  Returns the size of the register.  */
> -typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int re=
g);
> -typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
> -void gdb_register_coprocessor(CPUState *cpu,
> -                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set=
_reg,
> -                              int num_regs, const char *xml, int g_pos);
> -

ditto don't bring stuff in just to delete it later.

>  /**
> - * mcdserver_start: start the mcd server
> - * @port_or_device: connection spec for mcd
> + * mcd_tcp_server_start: start the tcp server to connect via mcd
> + * @device: connection spec for mcd
>   *
>   * This is a TCP port
>   */
> -int mcdserver_start(const char *port_or_device);
> -
> -void gdb_set_stop_cpu(CPUState *cpu);
> +int mcdserver_start(const char *device);
>=20=20
>  #endif
> diff --git a/include/mcdstub/syscalls.h b/include/mcdstub/syscalls.h
> new file mode 100644
> index 0000000000..1f86634140
> --- /dev/null
> +++ b/include/mcdstub/syscalls.h
> @@ -0,0 +1,6 @@
> +#ifndef _SYSCALLS_H_
> +#define _SYSCALLS_H_
> +
> +typedef void (*gdb_syscall_complete_cb)(CPUState *cpu, uint64_t ret, int=
 err);
> +
> +#endif /* _SYSCALLS_H_ */

again why duplicate?

> \ No newline at end of file
> diff --git a/mcdstub/internals.h b/mcdstub/internals.h
> new file mode 100644
> index 0000000000..7b0f4b0b36
> --- /dev/null
> +++ b/mcdstub/internals.h
> @@ -0,0 +1,135 @@
> +/*
> + * this header includes a lookup table for the transmitted messages over=
 the tcp connection to trace32,
> + * as well as function declarations for all functios used inside the mcd=
stub
> + */
> +
> +#ifndef MCDSTUB_INTERNALS_H
> +#define MCDSTUB_INTERNALS_H
> +
> +#include "exec/cpu-common.h"
> +#include "chardev/char.h"
> +
> +#define MAX_PACKET_LENGTH 1024
> +
> +/*
> + * lookuptable for transmitted signals
> + */
> +
> +enum {
> +    MCD_SIGNAL_HANDSHAKE =3D 0
> +};
> +
> +
> +/*
> + * struct for an MCD Process, each process can establish one connection
> + */
> +
> +typedef struct MCDProcess {
> +    uint32_t pid;
> +    bool attached;
> +
> +    char target_xml[1024];

is mcd using XML or is this a c&p holdover?

> +} MCDProcess;
> +
> +
> +/*
> + * not sure for what this is used exactly
> + */
> +
> +
> +enum RSState {
> +    RS_INACTIVE,
> +    RS_IDLE,
> +    RS_GETLINE,
> +    RS_GETLINE_ESC,
> +    RS_GETLINE_RLE,
> +    RS_CHKSUM1,
> +    RS_CHKSUM2,
> +};
> +
> +typedef struct MCDState {
> +    bool init;       /* have we been initialised? */
> +    CPUState *c_cpu; /* current CPU for step/continue ops */
> +    CPUState *g_cpu; /* current CPU for other ops */
> +    CPUState *query_cpu; /* for q{f|s}ThreadInfo */
> +    enum RSState state; /* parsing state */
> +    char line_buf[MAX_PACKET_LENGTH];
> +    int line_buf_index;
> +    int line_sum; /* running checksum */
> +    int line_csum; /* checksum at the end of the packet */
> +    GByteArray *last_packet;
> +    int signal;
> +    bool multiprocess;
> +    MCDProcess *processes;
> +    int process_num;
> +    GString *str_buf;
> +    GByteArray *mem_buf;
> +    int sstep_flags;
> +    int supported_sstep_flags;
> +} MCDState;
> +
> +/* lives in main mcdstub.c */
> +extern MCDState mcdserver_state;
> +
> +
> +// Inline utility function, convert from int to hex and back

comment style.

> +
> +
> +static inline int fromhex(int v)
> +{
> +    if (v >=3D '0' && v <=3D '9') {
> +        return v - '0';
> +    } else if (v >=3D 'A' && v <=3D 'F') {
> +        return v - 'A' + 10;
> +    } else if (v >=3D 'a' && v <=3D 'f') {
> +        return v - 'a' + 10;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +static inline int tohex(int v)
> +{
> +    if (v < 10) {
> +        return v + '0';
> +    } else {
> +        return v - 10 + 'a';
> +    }
> +}

if this is actually going to be used lets move it to a common header at
least, maybe qemu/include/cutils.h

> +
> +
> +/*old functions
> +void mcd_init_mcdserver_state(void);
> +int mcd_open_tcp_socket(int tcp_port);
> +int mcd_extract_tcp_port_num(const char *in_string, char *out_string);
> +*/
> +#ifndef _WIN32
> +void mcd_sigterm_handler(int signal);
> +#endif
> +
> +void mcd_init_mcdserver_state(void);
> +void reset_mcdserver_state(void);
> +void create_processes(MCDState *s);
> +void mcd_create_default_process(MCDState *s);
> +int find_cpu_clusters(Object *child, void *opaque);
> +int pid_order(const void *a, const void *b);
> +int mcd_chr_can_receive(void *opaque);
> +void mcd_chr_receive(void *opaque, const uint8_t *buf, int size);
> +void mcd_chr_event(void *opaque, QEMUChrEvent event);
> +bool mcd_supports_guest_debug(void);
> +void mcd_vm_state_change(void *opaque, bool running, RunState state);
> +int mcd_put_packet(const char *buf);
> +int mcd_put_packet_binary(const char *buf, int len, bool dump);
> +bool mcd_got_immediate_ack(void);
> +void mcd_put_buffer(const uint8_t *buf, int len);
> +void mcd_set_stop_cpu(CPUState *cpu);
> +MCDProcess *mcd_get_cpu_process(CPUState *cpu);
> +uint32_t mcd_get_cpu_pid(CPUState *cpu);
> +MCDProcess *mcd_get_process(uint32_t pid);
> +CPUState *mcd_first_attached_cpu(void);
> +CPUState *mcd_next_attached_cpu(CPUState *cpu);
> +
> +/* sycall handling */
> +void mcd_syscall_reset(void);
> +
> +#endif /* MCDSTUB_INTERNALS_H */
> diff --git a/mcdstub/mcd_softmmu.c b/mcdstub/mcd_softmmu.c
> index 17e1d3ca1b..52dcb182b2 100644
> --- a/mcdstub/mcd_softmmu.c
> +++ b/mcdstub/mcd_softmmu.c
> @@ -1,85 +1,171 @@
>  /*
> - * this handeles all system emulation functions for the mcdstub
> - */
> +#if defined(WIN32)
> +#ifndef _WIN32_WINNT
> +#define _WIN32_WINNT 0x0600
> +#endif
> +#include <winsock2.h>
> +#include <ws2tcpip.h>
> +//#pragma comment(lib, "Ws2_32.lib")
> +#define ISVALIDSOCKET(s) ((s) !=3D INVALID_SOCKET)
> +#define CLOSESOCKET(s) closesocket(s)
> +#define GETSOCKETERRNO() (WSAGetLastError())
> +#else
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <netdb.h>
> +#include <unistd.h>
> +//#include <errno.h>

osdep.h and don't include commented out lines.

> +#define SOCKET int
> +#define ISVALIDSOCKET(s) ((s) >=3D 0)
> +#define CLOSESOCKET(s) close(s)
> +#define GETSOCKETERRNO() (errno)
> +#endif
>=20=20
> -#include "exec/mcdstub.h"
> +#define SA struct sockaddr
>=20=20
> -int mcdserver_start(const char *device)
> -{
> -    trace_gdbstub_op_start(device);
>=20=20
> -    char gdbstub_device_name[128];
> -    Chardev *chr =3D NULL;
> -    Chardev *mon_chr;
>=20=20
> -    if (!first_cpu) {
> -        error_report("gdbstub: meaningless to attach gdb to a "
> -                     "machine without any CPU.");
> -        return -1;
> -    }
> +#include "exec/mcdstub.h"
> +#include "qemu/osdep.h"

should be at the top.

> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/cutils.h"
> +#include "gdbstub/syscalls.h"
> +#include "exec/hwaddr.h"
> +#include "exec/tb-flush.h"
> +#include "sysemu/cpus.h"
> +#include "sysemu/runstate.h"
> +#include "sysemu/replay.h"
> +#include "hw/core/cpu.h"
> +#include "hw/cpu/cluster.h"
> +#include "hw/boards.h"
> +#include "chardev/char.h"
> +#include "chardev/char-fe.h"
> +#include "monitor/monitor.h"
> +#include "internals.h"
>=20=20
> -    if (!gdb_supports_guest_debug()) {
> -        error_report("gdbstub: current accelerator doesn't "
> -                     "support guest debugging");
> -        return -1;
> -    }
> +//here only deprecated code:
>=20=20
> -    if (!device) {
> +int old_mcdserver_start(const char *device)
> +{
> +    //the device is a char array. if its "default" we use tcp with the d=
efault DEFAULT_MCDSTUB_PORT. Otherwise it has to look like "tcp::<tcpport>"
> +    char tcp_port[MX_INPUT_LENGTH];
> +    int error;
> +    error =3D mcd_extract_tcp_port_num(device, tcp_port);
> +    if (error !=3D 0) {
>          return -1;
>      }
> -    if (strcmp(device, "none") !=3D 0) {
> -        if (strstart(device, "tcp:", NULL)) {
> -            /* enforce required TCP attributes */
> -            snprintf(gdbstub_device_name, sizeof(gdbstub_device_name),
> -                     "%s,wait=3Doff,nodelay=3Don,server=3Don", device);
> -            device =3D gdbstub_device_name;
> -        }
> -#ifndef _WIN32
> -        else if (strcmp(device, "stdio") =3D=3D 0) {
> -            struct sigaction act;
> -
> -            memset(&act, 0, sizeof(act));
> -            act.sa_handler =3D gdb_sigterm_handler;
> -            sigaction(SIGINT, &act, NULL);
> -        }
> -#endif
> -        /*
> -         * FIXME: it's a bit weird to allow using a mux chardev here
> -         * and implicitly setup a monitor. We may want to break this.
> -         */
> -        chr =3D qemu_chr_new_noreplay("gdb", device, true, NULL);
> -        if (!chr) {
> -            return -1;
> -        }
> +    int tcp_port_num =3D atoi(tcp_port);
> +=20=20=20=20=20=20=20=20
> +    if (!mcdserver_state.init) {
> +        mcd_init_mcdserver_state();
>      }
> +    return mcd_open_tcp_socket(tcp_port_num);
> +}
> +
> +int mcd_open_tcp_socket(int tcp_port)
> +//soon to be deprecated (hopefully)
> +{
> +    SOCKET socked_fd, connect_fd;
> +	struct sockaddr_in server_address, client_address;
> +
> +#if defined(WIN32)
> +	WSADATA d;
> +	if (WSAStartup(MAKEWORD(2, 2), &d)) {
> +    	return -1;
> +	}
> +	int len;
> +#else
> +	unsigned int len;
> +#endif
>=20=20
> -    if (!gdbserver_state.init) {
> -        gdb_init_gdbserver_state();
> +	// socket create and verification
> +	socked_fd =3D socket(AF_INET, SOCK_STREAM, 0);
> +	if (!ISVALIDSOCKET(socked_fd)) {
> +		return -1;
> +	}
> +	memset(&server_address, 0, sizeof(server_address));
>=20=20
> -        qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
> +	// assign IP, PORT
> +	server_address.sin_family =3D AF_INET;
> +	server_address.sin_port =3D htons(tcp_port);
> +	server_address.sin_addr.s_addr =3D htonl(INADDR_ANY);
>=20=20
> -        /* Initialize a monitor terminal for gdb */
> -        mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
> -                                   NULL, NULL, &error_abort);
> -        monitor_init_hmp(mon_chr, false, &error_abort);
> -    } else {
> -        qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
> -        mon_chr =3D gdbserver_system_state.mon_chr;
> -        reset_gdbserver_state();
> +	// Binding newly created socket to given IP and verification
> +	if ((bind(socked_fd, (SA*)&server_address, sizeof(server_address))) !=
=3D 0) {
> +		CLOSESOCKET(socked_fd);
> +		return -1;
> +	}
> +
> +	// Now server is ready to listen and verification
> +	if ((listen(socked_fd, 5)) !=3D 0) {
> +		CLOSESOCKET(socked_fd);
> +		return -1;
> +	}
> +	else {
> +		printf("TCP server listening on port %d\n", tcp_port);
> +	}
> +
> +	//accepting connection
> +	len =3D sizeof(client_address);
> +	connect_fd =3D accept(socked_fd, (SA*)&client_address, &len);
> +    if (!ISVALIDSOCKET(connect_fd)) {
> +		CLOSESOCKET(socked_fd);
> +        return -1;
>      }
>=20=20
> -    create_processes(&gdbserver_state);
> +	//lets do the handshake
> +
> +	char buff[MCD_TCP_DATALEN];
> +	char expected_buff[MCD_TCP_DATALEN];
>=20=20
> -    if (chr) {
> -        qemu_chr_fe_init(&gdbserver_system_state.chr, chr, &error_abort);
> -        qemu_chr_fe_set_handlers(&gdbserver_system_state.chr,
> -                                 gdb_chr_can_receive,
> -                                 gdb_chr_receive, gdb_chr_event,
> -                                 NULL, &gdbserver_state, NULL, true);
> +	memset(buff, 0, sizeof(buff));
> +	memset(expected_buff, 0, sizeof(buff));
> +	strcpy((char*)expected_buff, "initializing handshake");
> +
> +    // read the message from client
> +    recv(connect_fd, buff, MCD_TCP_DATALEN, 0);
> +=09
> +	if (strcmp(buff, expected_buff)=3D=3D0) {
> +		strcpy((char*)buff, "shaking your hand");
> +		send(connect_fd, buff, MCD_TCP_DATALEN, 0);
> +		printf("handshake complete\n");
> +		return 0;
> +	}
> +	else {
> +		CLOSESOCKET(socked_fd);
> +		CLOSESOCKET(connect_fd);
> +		return -1;
> +	}
> +}
> +
> +int mcd_extract_tcp_port_num(const char *in_string, char *out_string)
> +{
> +    int string_length =3D strlen(in_string);
> +    if (string_length>MX_INPUT_LENGTH+1) {
> +        return -1;
>      }
> -    gdbserver_state.state =3D chr ? RS_IDLE : RS_INACTIVE;
> -    gdbserver_system_state.mon_chr =3D mon_chr;
> -    gdb_syscall_reset();
>=20=20
> +    const char default_str[] =3D "default";
> +
> +    if ((string_length=3D=3Dstrlen(default_str)) && (strcmp(default_str,=
 in_string)=3D=3D0)) {
> +        strcpy((char*)out_string, DEFAULT_MCDSTUB_PORT);
> +        return 0;
> +    }
> +    else if (strcmp("tcp::", in_string)=3D=3D0) {
> +            for (int index =3D 5; index < string_length; index++) {
> +                if (!isdigit(in_string[index])) {
> +                    return -1;
> +                }
> +            }
> +    }
> +    else {
> +        return -1;
> +    }
> +    strcpy((char*)out_string, in_string+5);
>      return 0;
> -}
> \ No newline at end of file
> +}
> +
> +*/
> \ No newline at end of file
> diff --git a/mcdstub/mcd_syscalls.c b/mcdstub/mcd_syscalls.c
> index e69de29bb2..663ffde1b6 100644
> --- a/mcdstub/mcd_syscalls.c
> +++ b/mcdstub/mcd_syscalls.c
> @@ -0,0 +1,20 @@
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "semihosting/semihost.h"
> +#include "sysemu/runstate.h"
> +#include "mcdstub/syscalls.h"
> +//#include "trace.h"
> +#include "internals.h"
> +
> +typedef struct {
> +    char syscall_buf[256];
> +    //TODO: this needs to be get fixed mcd_syscall_complete_cb
> +    int current_syscall_cb;
> +} MCDSyscallState;
> +
> +static MCDSyscallState mcdserver_syscall_state;
> +
> +void mcd_syscall_reset(void)
> +{
> +    mcdserver_syscall_state.current_syscall_cb =3D 0;
> +}
> \ No newline at end of file
> diff --git a/mcdstub/mcd_tcp_server.c b/mcdstub/mcd_tcp_server.c
> index 9a1baea2e4..558ddcb969 100644
> --- a/mcdstub/mcd_tcp_server.c
> +++ b/mcdstub/mcd_tcp_server.c
> @@ -6,8 +6,8 @@
>  #include <sys/socket.h>
>  #include <sys/types.h>
>  #include <unistd.h> // read(), write(), close()
> +#include "exec/mcdstub.h"
>  #define MAX 80
> -#define DEFAULT_MCDSTUB_PORT "1234"
>  #define SA struct sockaddr
>=20=20
>  // Function designed for chat between client and server.
> diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
> index e69de29bb2..c68cab9391 100644
> --- a/mcdstub/mcdstub.c
> +++ b/mcdstub/mcdstub.c
> @@ -0,0 +1,519 @@
> +/*
> + * This is the main mcdstub. It needs to be complemented by other mcd st=
ubs for each target.
> + */
> +
> +//from original gdbstub.c
> +#include "qemu/osdep.h"
> +#include "qemu/ctype.h"
> +#include "qemu/cutils.h"
> +#include "qemu/module.h"
> +#include "qemu/error-report.h"
> +//#include "trace.h"
> +#include "exec/mcdstub.h"
> +#include "mcdstub/syscalls.h"
> +#include "hw/cpu/cluster.h"
> +#include "hw/boards.h"
> +
> +#include "sysemu/hw_accel.h"
> +#include "sysemu/runstate.h"
> +#include "exec/replay-core.h"
> +#include "exec/hwaddr.h"

I suspect you are over including (for example can MCD handle
record/replay?). Try and keep the includes minimal to what you need.

> +
> +#include "internals.h"
> +
> +//from original softmmu.c (minus what was already here)
> +#include "qapi/error.h"
> +#include "exec/tb-flush.h"
> +#include "sysemu/cpus.h"
> +#include "sysemu/replay.h"
> +#include "hw/core/cpu.h"
> +#include "chardev/char.h"
> +#include "chardev/char-fe.h"
> +#include "monitor/monitor.h"
> +
> +typedef struct {
> +    CharBackend chr;
> +    //Chardev *mon_chr;
> +} MCDSystemState;
> +
> +MCDSystemState mcdserver_system_state;
> +
> +MCDState mcdserver_state;
> +
> +void mcd_init_mcdserver_state(void)
> +{
> +	g_assert(!mcdserver_state.init);
> +    memset(&mcdserver_state, 0, sizeof(MCDState));
> +    mcdserver_state.init =3D true;
> +    mcdserver_state.str_buf =3D g_string_new(NULL);
> +    mcdserver_state.mem_buf =3D g_byte_array_sized_new(MAX_PACKET_LENGTH=
);
> +    mcdserver_state.last_packet =3D g_byte_array_sized_new(MAX_PACKET_LE=
NGTH + 4);
> +
> +    /*
> +     * What single-step modes are supported is accelerator dependent.
> +     * By default try to use no IRQs and no timers while single
> +     * stepping so as to make single stepping like a typical ICE HW step.
> +     */
> +	// TODO:
> +	// this is weird and might be able to sit just like it is here with the=
 same value as for gdb
> +    mcdserver_state.supported_sstep_flags =3D accel_supported_gdbstub_ss=
tep_flags();
> +    mcdserver_state.sstep_flags =3D SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_N=
OTIMER;
> +    mcdserver_state.sstep_flags &=3D mcdserver_state.supported_sstep_fla=
gs;
> +}
> +
> +void reset_mcdserver_state(void)
> +{
> +    g_free(mcdserver_state.processes);
> +    mcdserver_state.processes =3D NULL;
> +    mcdserver_state.process_num =3D 0;
> +}
> +
> +void create_processes(MCDState *s)
> +{
> +    object_child_foreach(object_get_root(), find_cpu_clusters, s);
> +
> +    if (mcdserver_state.processes) {
> +        /* Sort by PID */
> +        qsort(mcdserver_state.processes,
> +              mcdserver_state.process_num,
> +              sizeof(mcdserver_state.processes[0]),
> +              pid_order);
> +    }
> +
> +    mcd_create_default_process(s);
> +}
> +
> +void mcd_create_default_process(MCDState *s)
> +{
> +    MCDProcess *process;
> +    int max_pid =3D 0;
> +
> +    if (mcdserver_state.process_num) {
> +        max_pid =3D s->processes[s->process_num - 1].pid;
> +    }
> +
> +    s->processes =3D g_renew(MCDProcess, s->processes, ++s->process_num);
> +    process =3D &s->processes[s->process_num - 1];
> +
> +    /* We need an available PID slot for this process */
> +    assert(max_pid < UINT32_MAX);
> +
> +    process->pid =3D max_pid + 1;
> +    process->attached =3D false;
> +    process->target_xml[0] =3D '\0';
> +}
> +
> +int find_cpu_clusters(Object *child, void *opaque)
> +{
> +    if (object_dynamic_cast(child, TYPE_CPU_CLUSTER)) {
> +        MCDState *s =3D (MCDState *) opaque;
> +        CPUClusterState *cluster =3D CPU_CLUSTER(child);
> +        MCDProcess *process;
> +
> +        s->processes =3D g_renew(MCDProcess, s->processes, ++s->process_=
num);
> +
> +        process =3D &s->processes[s->process_num - 1];
> +
> +        /*
> +         * GDB process IDs -1 and 0 are reserved. To avoid subtle errors=
 at
> +         * runtime, we enforce here that the machine does not use a clus=
ter ID
> +         * that would lead to PID 0.
> +         */
> +        assert(cluster->cluster_id !=3D UINT32_MAX);
> +        process->pid =3D cluster->cluster_id + 1;
> +        process->attached =3D false;
> +        process->target_xml[0] =3D '\0';
> +
> +        return 0;
> +    }
> +
> +    return object_child_foreach(child, find_cpu_clusters, opaque);
> +}
> +
> +int pid_order(const void *a, const void *b)
> +{
> +    MCDProcess *pa =3D (MCDProcess *) a;
> +    MCDProcess *pb =3D (MCDProcess *) b;
> +
> +    if (pa->pid < pb->pid) {
> +        return -1;
> +    } else if (pa->pid > pb->pid) {
> +        return 1;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +int mcdserver_start(const char *device)
> +{
> +    //might wann add tracing later (no idea for what this is used)
> +    //trace_gdbstub_op_start(device);
> +
> +    char mcdstub_device_name[128];
> +    Chardev *chr =3D NULL;
> +    //Chardev *mon_chr;

I'm going to stop here because there is too much c&p and commenting out
going on. I appreciate you've used the original gdbstub as a template to
build the mcdstub but you need to squash and merge the changes on top
rather than commenting out chunks you didn't need. It makes reviewing
very hard because there is a bunch of legacy code which hasn't been
updated to current standards which the reviewer doesn't know if its
worth looking at because it might get deleted later.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

