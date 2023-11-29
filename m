Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2AD7FDB25
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 16:24:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8MPx-0008Mx-Rv; Wed, 29 Nov 2023 10:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8MPt-0008Mn-2O
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:23:57 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8MPo-0004Hz-Ag
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:23:56 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3330d64958aso1405025f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 07:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701271429; x=1701876229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGlsB2LZA5RKGZ02RWenBBFwblUkMkQ82E+LuQnwsaY=;
 b=se7DRdimaDHqijQQO54rWOzawzTZRMbd5KnER4T6HI6Xhg6arbV886YEx5dlTRMGb6
 mJ2zwnzSPbpabR7plzFhlzd3o7F08GYNnRZopAivmI9qqNfDuX5/UxoVYyEU9mTYjh84
 AxWfVM8PTba17GOCvozrDiEUz+gSnJCk2QFc9BE8oPpgNGj28qrmvsSU/mvwb+Mz4pie
 LEgaBrr9Nsblkn+3q6Cc0agjd43LS0nfyXozMA9IdYYOagMVfk2N8stX3GxHb9TtfN3X
 8PZ26ReNe2es1bJPXgyKd+D4BFSEraqa9hxIS29lDE1Npz4FTXzZmif/fpG9doHvWxf6
 YK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701271429; x=1701876229;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iGlsB2LZA5RKGZ02RWenBBFwblUkMkQ82E+LuQnwsaY=;
 b=kqOH23vT/ov+RgA3OBfX8KI8T+VTiy8rtL/PdZknFyPCLq/UPTCetgxMpTqc8v+Xpa
 Co+ytCr02c4iC+b9PgNH/6CtC65J+RvetLVqv5EHRwqGAXakzD8JeG4E7I+l732jiSku
 bd7V7VUUf3d3A1RlWj0n5WRtpXvXxMIEp2Jtm3QZ/aAW44AHiEtCpjcKirGXXcfXlRX7
 znq+b5Rr+zxP3oNBS6zlD/pmxuOkFXmYcJSty2WGdWRjTeS+6t/JxIhSDv+4qDW7nkIO
 +O5XNpqgSR77XXboeDa1WP7uoFq9ueXABEpDqPvGwiPnV9XFY36aybfpKQw0156xt20X
 IvUg==
X-Gm-Message-State: AOJu0YzfV7Nc/C22oc5q8bJeoRQN9odmA1u9xU/tNNV3Iq/GT9LTDw6B
 WnwTw4LDC723qkCq/WEOZ9O7+DGHVL6gTZN+J9vGWA==
X-Google-Smtp-Source: AGHT+IGiWI6pjQ6ch0sYGiyomr4nNX0fEGwT9Yn/rZgV971GVauyCbsY3PBM2fAuEq6ntG8Oqf2/+Q==
X-Received: by 2002:adf:f809:0:b0:332:fce8:4c49 with SMTP id
 s9-20020adff809000000b00332fce84c49mr8328674wrp.20.1701271428398; 
 Wed, 29 Nov 2023 07:23:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l9-20020adffe89000000b003330a1d35a8sm5473697wrr.43.2023.11.29.07.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 07:23:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A885C5F7AF;
 Wed, 29 Nov 2023 15:23:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v3 01/20] mcdstub: initial file structure for new
 mcdstub created. -mcd QEMU startup option added. Functions for
 initializing the mcdstub added. Basic helper functions for processes/cpus
 in the mcdstub added
In-Reply-To: <20231107130323.4126-2-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Tue, 7 Nov 2023 14:03:04 +0100")
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
 <20231107130323.4126-2-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Wed, 29 Nov 2023 15:23:47 +0000
Message-ID: <87v89ka8ho.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

I think you need to ensure an extra line in you git commit messages
because currently the whole commit runs into your subject.

  foo/bar: summary of change made

  longer description of the problem and how the patch solves it. This can
  continue to be multiple lines of text.

  Signed-off-by: Name <email>

> ---
>  include/mcdstub/arm_mcdstub.h    |  10 +
>  include/mcdstub/mcdstub.h        | 239 +++++++++++++++++++
>  include/mcdstub/mcdstub_common.h |   7 +
>  mcdstub/mcdstub.c                | 383 +++++++++++++++++++++++++++++++
>  qemu-options.hx                  |  18 ++
>  system/vl.c                      |  13 ++
>  6 files changed, 670 insertions(+)
>  create mode 100644 include/mcdstub/arm_mcdstub.h
>  create mode 100644 include/mcdstub/mcdstub.h
>  create mode 100644 include/mcdstub/mcdstub_common.h
>  create mode 100644 mcdstub/mcdstub.c
>
> diff --git a/include/mcdstub/arm_mcdstub.h b/include/mcdstub/arm_mcdstub.h
> new file mode 100644
> index 0000000000..a57aa8e9f2
> --- /dev/null
> +++ b/include/mcdstub/arm_mcdstub.h
> @@ -0,0 +1,10 @@
> +#ifndef ARM_MCDSTUB_H
> +#define ARM_MCDSTUB_H
> +
> +#include "hw/core/cpu.h"
> +#include "mcdstub_common.h"
> +/* just used for the register xml files */
> +#include "exec/gdbstub.h"
> +
> +
> +#endif /* ARM_MCDSTUB_H */
> diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
> new file mode 100644
> index 0000000000..36058157ae
> --- /dev/null
> +++ b/include/mcdstub/mcdstub.h
> @@ -0,0 +1,239 @@
> +#ifndef MCDSTUB_INTERNALS_H
> +#define MCDSTUB_INTERNALS_H
> +
> +#include "exec/cpu-common.h"
> +#include "chardev/char.h"
> +#include "hw/core/cpu.h"
> +#include "mcdstub_common.h"
> +
> +#define MAX_PACKET_LENGTH 1024
> +/* misc */
> +#define QUERY_TOTAL_NUMBER 12
> +#define CMD_SCHEMA_LENGTH 6
> +#define MCD_SYSTEM_NAME "qemu-system"
> +
> +/* supported architectures */
> +#define MCDSTUB_ARCH_ARM "arm"
> +
> +/* tcp query packet values templates */
> +#define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
> +
> +typedef struct MCDProcess {
> +    uint32_t pid;
> +    bool attached;
> +
> +    char target_xml[1024];

Is this even used?

> +} MCDProcess;
> +
> +#define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
> +
> +enum RSState {
> +    RS_INACTIVE,
> +    RS_IDLE,
> +    RS_GETLINE,
> +    RS_DATAEND,
> +};
> +
> +typedef struct MCDState {
> +    bool init;       /* have we been initialised? */
> +    CPUState *c_cpu; /* current CPU for everything */
> +    enum RSState state; /* parsing state */
> +    char line_buf[MAX_PACKET_LENGTH];
> +    int line_buf_index;
> +    int line_sum; /* running checksum */
> +    int line_csum; /* checksum at the end of the packet */
> +    GByteArray *last_packet;
> +    int signal;
> +
> +    MCDProcess *processes;
> +    int process_num;
> +    GString *str_buf;
> +    GByteArray *mem_buf;
> +    int sstep_flags;
> +    int supported_sstep_flags;
> +
> +    uint32_t query_cpu_id;
> +    GList *all_memspaces;
> +    GList *all_reggroups;
> +    GList *all_registers;
> +    GList *all_breakpoints;
> +    GArray *resets;
> +    mcd_trigger_into_st trigger;
> +    mcd_cpu_state_st cpu_state;
> +    MCDCmdParseEntry mcd_query_cmds_table[QUERY_TOTAL_NUMBER];
> +} MCDState;

Hmm this doesn't even compile:

  cc -m64 -mcx16 -Ilibcommon.fa.p -I../../common-user/host/x86_64 -I../../l=
inux-user/include/host/x86_64 -I../../linux-user/include -Iui -I../../ui -I=
/usr/include/capstone -I/usr/include/p11-kit-1 -I/usr/include/pixman-1 -I/u=
sr/include/libpng16 -I/usr/include/spice-server -I/usr/include/spice-1 -I/u=
sr/include/libusb-1.0 -I/usr/include/SDL2 -I/usr/include/glib-2.0 -I/usr/li=
b/x86_64-linux-gnu/glib-2.0/include -I/usr/include/libmount -I/usr/include/=
blkid -I/usr/include/gio-unix-2.0 -I/usr/include/slirp -I/usr/include/gtk-3=
.0 -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/freetype=
2 -I/usr/include/fribidi -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0=
 -I/usr/include/x86_64-linux-gnu -I/usr/include/atk-1.0 -I/usr/include/at-s=
pi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/x8=
6_64-linux-gnu/dbus-1.0/include -I/usr/include/vte-2.91 -I/usr/include/virg=
l -I/usr/include/cacard -I/usr/include/nss -I/usr/include/nspr -I/usr/inclu=
de/PCSC -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11=
 -O2 -g -fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototyp=
es -Wstrict-prototypes -Wredundant-decls -Wold-style-declaration -Wold-styl=
e-definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -Wign=
ored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to=
-defined -Wimplicit-fallthrough=3D2 -Wmissing-format-attribute -Wno-missing=
-include-dirs -Wno-shift-negative-value -Wno-psabi -Wshadow=3Dlocal -isyste=
m /home/alex/lsrc/qemu.git/linux-headers -isystem linux-headers -iquote . -=
iquote /home/alex/lsrc/qemu.git -iquote /home/alex/lsrc/qemu.git/include -i=
quote /home/alex/lsrc/qemu.git/host/include/x86_64 -iquote /home/alex/lsrc/=
qemu.git/host/include/generic -iquote /home/alex/lsrc/qemu.git/tcg/i386 -pt=
hread -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-stric=
t-aliasing -fno-common -fwrapv -fPIE -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D60=
0 -DNCURSES_WIDECHAR=3D1 -D_REENTRANT -DSTRUCT_IOVEC_DEFINED -MD -MQ libcom=
mon.fa.p/system_vl.c.o -MF libcommon.fa.p/system_vl.c.o.d -o libcommon.fa.p=
/system_vl.c.o -c ../../system/vl.c
  In file included from ../../system/vl.c:71:
  /home/alex/lsrc/qemu.git/include/mcdstub/mcdstub.h:61:5: error: unknown t=
ype name =E2=80=98mcd_trigger_into_st=E2=80=99
     61 |     mcd_trigger_into_st trigger;
        |     ^~~~~~~~~~~~~~~~~~~
  /home/alex/lsrc/qemu.git/include/mcdstub/mcdstub.h:62:5: error: unknown t=
ype name =E2=80=98mcd_cpu_state_st=E2=80=99
     62 |     mcd_cpu_state_st cpu_state;
        |     ^~~~~~~~~~~~~~~~
  /home/alex/lsrc/qemu.git/include/mcdstub/mcdstub.h:63:5: error: unknown t=
ype name =E2=80=98MCDCmdParseEntry=E2=80=99
     63 |     MCDCmdParseEntry mcd_query_cmds_table[QUERY_TOTAL_NUMBER];
        |     ^~~~~~~~~~~~~~~~
  /home/alex/lsrc/qemu.git/include/mcdstub/mcdstub.h:96:28: error: unknown =
type name =E2=80=98MCDCmdParseEntry=E2=80=99
     96 | void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table=
);
        |                            ^~~~~~~~~~~~~~~~
  /home/alex/lsrc/qemu.git/include/mcdstub/mcdstub.h:1: error: unterminated=
 #ifndef
      1 | #ifndef MCDSTUB_INTERNALS_H
        |=20

Each patch in the series should be able to compile cleanly for the
purposes of bisection.

If we need external headers you'll need to tweak configure/meson to make
sure they are available and gate the feature if its not.

> +
> +/* lives in main mcdstub.c */
> +extern MCDState mcdserver_state;
> +
> +#ifndef _WIN32
> +void mcd_sigterm_handler(int signal);
> +#endif
> +
> +/**
> + * mcdserver_start() - initializes the mcdstub and opens a TCP port
> + * @device: TCP port (e.g. tcp::1235)
> + */
> +int mcdserver_start(const char *device);
> +
> +/**
> + * mcd_init_mcdserver_state() - Initializes the mcdserver_state struct.
> + *
> + * This function allocates memory for the mcdserver_state struct and sets
> + * all of its members to their inital values. This includes setting the
> + * cpu_state to halted and initializing the query functions with
> + * :c:func:`init_query_cmds_table`.
> + */
> +void mcd_init_mcdserver_state(void);
> +
> +/**
> + * init_query_cmds_table() - Initializes all query functions.
> + *
> + * This function adds all query functions to the mcd_query_cmds_table. T=
his
> + * includes their command string, handler function and parameter schema.
> + * @mcd_query_cmds_table: Lookup table with all query commands.
> + */
> +void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table);

No MCDCmdParseEntry defined. However this doesn't seem to be an exported
function. If it was it should be prefixed.

> +/**
> + * create_processes() - Sorts all processes and calls
> + * :c:func:`mcd_create_default_process`.
> + *
> + * This function sorts all connected processes with the qsort function.
> + * Afterwards, it creates a new process with
> + * :c:func:`mcd_create_default_process`.
> + * @s: A MCDState object.
> + */
> +void create_processes(MCDState *s);

this is definitely internal.

> +
> +/**
> + * mcd_create_default_process() - Creates a default process for debuggin=
g.
> + *
> + * This function creates a new, not yet attached, process with an ID one=
 above
> + * the previous maximum ID.
> + * @s: A MCDState object.
> + */
> +void mcd_create_default_process(MCDState *s);
> +
> +/**
> + * find_cpu_clusters() - Returns the CPU cluster of the child object.
> + *
> + * @param[in] child Object with unknown CPU cluster.
> + * @param[in] opaque Pointer to an MCDState object.
> + */
> +int find_cpu_clusters(Object *child, void *opaque);
> +
> +/**
> + * pid_order() - Compares process IDs.
> + *
> + * This function returns -1 if process "a" has a ower process ID than "b=
".
> + * If "b" has a lower ID than "a" 1 is returned and if they are qual 0 is
> + * returned.
> + * @a: Process a.
> + * @b: Process b.
> + */
> +int pid_order(const void *a, const void *b);
> +
> +/**
> + * mcd_chr_can_receive() - Returns the maximum packet length of a TCP pa=
cket.
> + */
> +int mcd_chr_can_receive(void *opaque);
> +
> +/**
> + * mcd_chr_receive() - Handles receiving a TCP packet.
> + *
> + * This function gets called by QEMU when a TCP packet is received.
> + * It iterates over that packet an calls :c:func:`mcd_read_byte` for eac=
h char
> + * of the packet.
> + * @buf: Content of the packet.
> + * @size: Length of the packet.
> + */
> +void mcd_chr_receive(void *opaque, const uint8_t *buf, int size);
> +
> +/**
> + * mcd_chr_event() - Handles a TCP client connect.
> + *
> + * This function gets called by QEMU when a TCP cliet connects to the op=
ened
> + * TCP port. It attaches the first process. From here on TCP packets can=
 be
> + * exchanged.
> + * @event: Type of event.
> + */
> +void mcd_chr_event(void *opaque, QEMUChrEvent event);
> +
> +/**
> + * mcd_supports_guest_debug() - Returns true if debugging the selected
> + * accelerator is supported.
> + */
> +bool mcd_supports_guest_debug(void);
> +
> +/**
> + * mcd_vm_state_change() - Handles a state change of the QEMU VM.
> + *
> + * This function is called when the QEMU VM goes through a state transit=
ion.
> + * It stores the runstate the CPU is in to the cpu_state and when in
> + * RUN_STATE_DEBUG it collects additional data on what watchpoint was hi=
t.
> + * This function also resets the singlestep behavior.
> + * @running: True if he VM is running.
> + * @state: The new (and active) VM run state.
> + */
> +void mcd_vm_state_change(void *opaque, bool running, RunState state);
> +/**
> + * mcd_get_cpu_process() - Returns the process of the provided CPU.
> + *
> + * @cpu: The CPU state.
> + */
> +MCDProcess *mcd_get_cpu_process(CPUState *cpu);
> +
> +/**
> + * mcd_set_stop_cpu() - Sets c_cpu to the just stopped CPU.
> + *
> + * @cpu: The CPU state.
> + */
> +void mcd_set_stop_cpu(CPUState *cpu);
> +
> +/**
> + * mcd_get_cpu_pid() - Returns the process ID of the provided CPU.
> + *
> + * @cpu: The CPU state.
> + */
> +uint32_t mcd_get_cpu_pid(CPUState *cpu);
> +
> +/**
> + * mcd_get_process() - Returns the process of the provided pid.
> + *
> + * @pid: The process ID.
> + */
> +MCDProcess *mcd_get_process(uint32_t pid);
> +
> +/**
> + * mcd_first_attached_cpu() - Returns the first CPU with an attached pro=
cess.
> + */
> +CPUState *mcd_first_attached_cpu(void);
> +
> +/**
> + * mcd_next_attached_cpu() - Returns the first CPU with an attached proc=
ess
> + * starting after the
> + * provided cpu.
> + *
> + * @cpu: The CPU to start from.
> + */
> +CPUState *mcd_next_attached_cpu(CPUState *cpu);
> +
> +/**
> + * mcd_get_cpu() - Returns the CPU the index i_cpu_index.
> + *
> + * @cpu_index: Index of the desired CPU.
> + */
> +CPUState *mcd_get_cpu(uint32_t cpu_index);
> +/**
> + * get_first_cpu_in_process() - Returns the first CPU in the provided pr=
ocess.
> + *
> + * @process: The process to look in.
> + */
> +CPUState *get_first_cpu_in_process(MCDProcess *process);
> +
> +/**
> + * find_cpu() - Returns the CPU with an index equal to the thread_id.
> + *
> + * @thread_id: ID of the desired CPU.
> + */
> +CPUState *find_cpu(uint32_t thread_id);
> diff --git a/include/mcdstub/mcdstub_common.h b/include/mcdstub/mcdstub_c=
ommon.h
> new file mode 100644
> index 0000000000..3bae2c3b6f
> --- /dev/null
> +++ b/include/mcdstub/mcdstub_common.h
> @@ -0,0 +1,7 @@
> +#ifndef MCDSTUB_COMMON_H
> +#define MCDSTUB_COMMON_H
> +
> +#define ARGUMENT_STRING_LENGTH 64
> +#define TCP_CONFIG_STRING_LENGTH 128
> +
> +#endif /* MCDSTUB_COMMON_H */
> diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
> new file mode 100644
> index 0000000000..4cdf2e42ed
> --- /dev/null
> +++ b/mcdstub/mcdstub.c
> @@ -0,0 +1,383 @@
> +/*
> + * This is the main mcdstub.
> + */

Can we have an author, copyright date and SPDX header for this file
please.

> +
> +#include "qemu/osdep.h"
> +#include "qemu/ctype.h"
> +#include "qemu/cutils.h"
> +#include "qemu/module.h"
> +#include "qemu/error-report.h"
> +#include "qemu/debug.h"
> +#include "hw/cpu/cluster.h"
> +#include "hw/boards.h"
> +#include "sysemu/hw_accel.h"
> +#include "sysemu/runstate.h"
> +#include "exec/replay-core.h"
> +#include "exec/hwaddr.h"
> +#include "qapi/error.h"
> +#include "exec/tb-flush.h"
> +#include "sysemu/cpus.h"
> +#include "sysemu/replay.h"
> +#include "chardev/char.h"
> +#include "chardev/char-fe.h"
> +#include "monitor/monitor.h"
> +#include "cutils.h"

I'm sure half of these includes aren't needed. Try and keep them minimal pl=
ease.

> +
> +/* mcdstub header files */
> +#include "mcdstub/mcd_shared_defines.h"
> +#include "mcdstub/mcdstub.h"
> +
> +/* architecture specific stubs */
> +#include "mcdstub/arm_mcdstub.h"
> +
> +typedef struct {
> +    CharBackend chr;
> +} MCDSystemState;
> +
> +MCDSystemState mcdserver_system_state;
> +
> +MCDState mcdserver_state;
> +
> +void mcd_init_mcdserver_state(void)
> +{
> +    g_assert(!mcdserver_state.init);
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
> +    mcdserver_state.supported_sstep_flags =3D
> +        accel_supported_gdbstub_sstep_flags();
> +    mcdserver_state.sstep_flags =3D SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_N=
OTIMER;
> +    mcdserver_state.sstep_flags &=3D mcdserver_state.supported_sstep_fla=
gs;
> +
> +    /* init query table */
> +    init_query_cmds_table(mcdserver_state.mcd_query_cmds_table);
> +
> +    /* at this time the cpu hans't been started! -> set cpu_state */
> +    mcd_cpu_state_st cpu_state =3D  {
> +            .state =3D CORE_STATE_HALTED,
> +            .info_str =3D STATE_STR_INIT_HALTED,
> +    };
> +    mcdserver_state.cpu_state =3D cpu_state;
> +
> +    /* create new debug object */
> +    mcd_init_debug_class();
> + }
> +
> +void mcd_set_stop_cpu(CPUState *cpu)
> +{
> +    mcdserver_state.c_cpu =3D cpu;
> +}
> +
> +void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
> +{
> +    /* initalizes a list of all query commands */
> +    int cmd_number =3D 0;
> +}
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
> +    char mcd_device_config[TCP_CONFIG_STRING_LENGTH];
> +    char mcd_tcp_port[TCP_CONFIG_STRING_LENGTH];
> +    Chardev *chr =3D NULL;
> +
> +    if (!first_cpu) {
> +        error_report("mcdstub: meaningless to attach to a "
> +                     "machine without any CPU.");
> +        return -1;
> +    }
> +
> +    if (!mcd_supports_guest_debug()) {
> +        error_report("mcdstub: current accelerator doesn't "
> +                     "support guest debugging");
> +        return -1;
> +    }
> +
> +    if (!device) {
> +        return -1;
> +    }
> +
> +    /* if device =3D=3D default -> set tcp_port =3D tcp::<MCD_DEFAULT_TC=
P_PORT> */
> +    if (strcmp(device, "default") =3D=3D 0) {
> +        snprintf(mcd_tcp_port, sizeof(mcd_tcp_port), "tcp::%s",
> +            MCD_DEFAULT_TCP_PORT);
> +        device =3D mcd_tcp_port;
> +    }
> +
> +    if (strcmp(device, "none") !=3D 0) {
> +        if (strstart(device, "tcp:", NULL)) {
> +            /* enforce required TCP attributes */
> +            snprintf(mcd_device_config, sizeof(mcd_device_config),
> +                     "%s,wait=3Doff,nodelay=3Don,server=3Don", device);
> +            device =3D mcd_device_config;
> +        }
> +#ifndef _WIN32
> +        else if (strcmp(device, "stdio") =3D=3D 0) {
> +            struct sigaction act;
> +
> +            memset(&act, 0, sizeof(act));
> +            act.sa_handler =3D mcd_sigterm_handler;
> +            sigaction(SIGINT, &act, NULL);
> +            strcpy(mcd_device_config, device);
> +        }
> +#endif
> +        chr =3D qemu_chr_new_noreplay("mcd", device, true, NULL);
> +        if (!chr) {
> +            return -1;
> +        }
> +    }
> +
> +    if (!mcdserver_state.init) {
> +        mcd_init_mcdserver_state();
> +
> +        qemu_add_vm_change_state_handler(mcd_vm_state_change, NULL);
> +    } else {
> +        qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
> +        reset_mcdserver_state();
> +    }
> +
> +    create_processes(&mcdserver_state);
> +
> +    if (chr) {
> +        qemu_chr_fe_init(&mcdserver_system_state.chr, chr, &error_abort);
> +        qemu_chr_fe_set_handlers(&mcdserver_system_state.chr,
> +                                 mcd_chr_can_receive,
> +                                 mcd_chr_receive, mcd_chr_event,
> +                                 NULL, &mcdserver_state, NULL, true);
> +    }
> +    mcdserver_state.state =3D chr ? RS_IDLE : RS_INACTIVE;
> +
> +    return 0;
> +}
> +
> +int mcd_chr_can_receive(void *opaque)
> +{
> +  return MAX_PACKET_LENGTH;
> +}
> +
> +void mcd_chr_receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < size; i++) {
> +        mcd_read_byte(buf[i]);
> +        if (buf[i] =3D=3D 0) {
> +            break;
> +        }
> +    }
> +}
> +
> +
> +void mcd_chr_event(void *opaque, QEMUChrEvent event)
> +{
> +    int i;
> +    MCDState *s =3D (MCDState *) opaque;
> +
> +    switch (event) {
> +    case CHR_EVENT_OPENED:
> +        /* Start with first process attached, others detached */
> +        for (i =3D 0; i < s->process_num; i++) {
> +            s->processes[i].attached =3D !i;
> +        }
> +
> +        s->c_cpu =3D mcd_first_attached_cpu();
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +bool mcd_supports_guest_debug(void)
> +{
> +    const AccelOpsClass *ops =3D cpus_get_accel();
> +    if (ops->supports_guest_debug) {
> +        return ops->supports_guest_debug();
> +    }
> +    return false;
> +}
> +
> +#ifndef _WIN32
> +void mcd_sigterm_handler(int signal)
> +{
> +    if (runstate_is_running()) {
> +        vm_stop(RUN_STATE_PAUSED);
> +    }
> +}
> +#endif
> +
> +uint32_t mcd_get_cpu_pid(CPUState *cpu)
> +{
> +    if (cpu->cluster_index =3D=3D UNASSIGNED_CLUSTER_INDEX) {
> +        /* Return the default process' PID */
> +        int index =3D mcdserver_state.process_num - 1;
> +        return mcdserver_state.processes[index].pid;
> +    }
> +    return cpu->cluster_index + 1;
> +}
> +
> +MCDProcess *mcd_get_process(uint32_t pid)
> +{
> +    int i;
> +
> +    if (!pid) {
> +        /* 0 means any process, we take the first one */
> +        return &mcdserver_state.processes[0];
> +    }
> +
> +    for (i =3D 0; i < mcdserver_state.process_num; i++) {
> +        if (mcdserver_state.processes[i].pid =3D=3D pid) {
> +            return &mcdserver_state.processes[i];
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +CPUState *mcd_get_cpu(uint32_t cpu_index)
> +{
> +    CPUState *cpu =3D first_cpu;
> +
> +    while (cpu) {
> +        if (cpu->cpu_index =3D=3D cpu_index) {
> +            return cpu;
> +        }
> +        cpu =3D mcd_next_attached_cpu(cpu);
> +    }
> +
> +    return cpu;
> +}
> +
> +CPUState *mcd_first_attached_cpu(void)
> +{
> +    CPUState *cpu =3D first_cpu;
> +    MCDProcess *process =3D mcd_get_cpu_process(cpu);
> +
> +    if (!process->attached) {
> +        return mcd_next_attached_cpu(cpu);
> +    }
> +
> +    return cpu;
> +}
> +
> +CPUState *mcd_next_attached_cpu(CPUState *cpu)
> +{
> +    cpu =3D CPU_NEXT(cpu);
> +
> +    while (cpu) {
> +        if (mcd_get_cpu_process(cpu)->attached) {
> +            break;
> +        }
> +
> +        cpu =3D CPU_NEXT(cpu);
> +    }
> +
> +    return cpu;
> +}
> +
> +int mcd_get_cpu_index(CPUState *cpu)
> +{
> +    return cpu->cpu_index + 1;
> +}
> +
> +CPUState *get_first_cpu_in_process(MCDProcess *process)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        if (mcd_get_cpu_pid(cpu) =3D=3D process->pid) {
> +            return cpu;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +CPUState *find_cpu(uint32_t thread_id)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        if (mcd_get_cpu_index(cpu) =3D=3D thread_id) {
> +            return cpu;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e26230bac5..accf92642c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4430,6 +4430,24 @@ SRST
>      (see the :ref:`GDB usage` chapter in the System Emulation Users Guid=
e).
>  ERST
>=20=20
> +DEF("mcd", HAS_ARG, QEMU_OPTION_mcd, \
> +    "-mcd dev        accept mcd connection on 'dev'. (QEMU defaults to s=
tarting\n"
> +    "                the guest without waiting for a mcd client to conne=
ct; use -S too\n"
> +    "                if you want it to not start execution.)\n"
> +    "                To use the default Port write '-mcd default'\n",
> +    QEMU_ARCH_ALL)
> +SRST
> +``-mcd dev``
> +    Accept a mcd connection on device dev. Note that this option does no=
t pause QEMU
> +    execution -- if you want QEMU to not start the guest until you
> +    connect with mcd and issue a ``run`` command, you will need to
> +    also pass the ``-S`` option to QEMU.
> +
> +    The most usual configuration is to listen on a local TCP socket::
> +
> +        -mcd tcp::1235
> +ERST
> +
>  DEF("d", HAS_ARG, QEMU_OPTION_d, \
>      "-d item1,...    enable logging of specified items (use '-d help' fo=
r a list of log items)\n",
>      QEMU_ARCH_ALL)
> diff --git a/system/vl.c b/system/vl.c
> index 92d29bf521..b657c77ea4 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -68,6 +68,7 @@
>  #include "sysemu/numa.h"
>  #include "sysemu/hostmem.h"
>  #include "exec/gdbstub.h"
> +#include "mcdstub/mcdstub.h"
>  #include "qemu/timer.h"
>  #include "chardev/char.h"
>  #include "qemu/bitmap.h"
> @@ -1266,6 +1267,7 @@ struct device_config {
>          DEV_PARALLEL,  /* -parallel      */
>          DEV_DEBUGCON,  /* -debugcon */
>          DEV_GDB,       /* -gdb, -s */
> +        DEV_MCD,       /* -mcd */
>          DEV_SCLP,      /* s390 sclp */
>      } type;
>      const char *cmdline;
> @@ -2673,6 +2675,14 @@ static void qemu_machine_creation_done(void)
>      if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
>          exit(1);
>      }
> +
> +    if (foreach_device_config(DEV_MCD, mcdserver_start) < 0) {
> +        /*
> +         * starts the mcdserver if the mcd option was set
> +         */
> +        exit(1);
> +    }
> +

More compile failures:

FAILED: qemu-system-alpha=20
cc -m64 -mcx16  -o qemu-system-alpha libcommon.fa.p/hw_core_cpu-common.c.o =
libcommon.fa.p/hw_core_machine-smp.c.o libcommon.fa.p/gdbstub_syscalls.c.o =
libcommon.fa.p/cpu-common.c.o libcommon.fa.p/page-vary-common.c.o libcommon=
.fa.p/disas_alpha.c.o libcommon.fa.p/disas_capstone.c.o libcommon.fa.p/disa=
s_disas.c.o libcommon.fa.p/accel_tcg_cpu-exec-common.c.o libcommon.fa.p/tra=
ce_trace-hmp-cmds.c.o libcommon.fa.p/qom_qom-hmp-cmds.c.o libcommon.fa.p/cr=
ypto_tls-cipher-suites.c.o libcommon.fa.p/ui_clipboard.c.o libcommon.fa.p/u=
i_console.c.o libcommon.fa.p/ui_cursor.c.o libcommon.fa.p/ui_input-keymap.c=
.o libcommon.fa.p/ui_input-legacy.c.o libcommon.fa.p/ui_input-barrier.c.o l=
ibcommon.fa.p/ui_input.c.o libcommon.fa.p/ui_kbd-state.c.o libcommon.fa.p/u=
i_keymaps.c.o libcommon.fa.p/ui_qemu-pixman.c.o libcommon.fa.p/ui_ui-hmp-cm=
ds.c.o libcommon.fa.p/ui_ui-qmp-cmds.c.o libcommon.fa.p/ui_util.c.o libcomm=
on.fa.p/ui_console-vc.c.o libcommon.fa.p/ui_dbus-module.c.o libcommon.fa.p/=
ui_spice-module.c.o libcommon.fa.p/ui_vdagent.c.o libcommon.fa.p/ui_input-l=
inux.c.o libcommon.fa.p/ui_udmabuf.c.o libcommon.fa.p/ui_vnc.c.o libcommon.=
fa.p/ui_vnc-enc-zlib.c.o libcommon.fa.p/ui_vnc-enc-hextile.c.o libcommon.fa=
.p/ui_vnc-enc-tight.c.o libcommon.fa.p/ui_vnc-palette.c.o libcommon.fa.p/ui=
_vnc-enc-zrle.c.o libcommon.fa.p/ui_vnc-auth-vencrypt.c.o libcommon.fa.p/ui=
_vnc-ws.c.o libcommon.fa.p/ui_vnc-jobs.c.o libcommon.fa.p/ui_vnc-clipboard.=
c.o libcommon.fa.p/ui_vnc-auth-sasl.c.o libcommon.fa.p/hw_9pfs_9p-local.c.o=
 libcommon.fa.p/hw_9pfs_9p-posix-acl.c.o libcommon.fa.p/hw_9pfs_9p-proxy.c.=
o libcommon.fa.p/hw_9pfs_9p-synth.c.o libcommon.fa.p/hw_9pfs_9p-xattr-user.=
c.o libcommon.fa.p/hw_9pfs_9p-xattr.c.o libcommon.fa.p/hw_9pfs_9p.c.o libco=
mmon.fa.p/hw_9pfs_codir.c.o libcommon.fa.p/hw_9pfs_cofile.c.o libcommon.fa.=
p/hw_9pfs_cofs.c.o libcommon.fa.p/hw_9pfs_coth.c.o libcommon.fa.p/hw_9pfs_c=
oxattr.c.o libcommon.fa.p/hw_9pfs_9p-util-linux.c.o libcommon.fa.p/hw_acpi_=
acpi-stub.c.o libcommon.fa.p/hw_acpi_aml-build-stub.c.o libcommon.fa.p/hw_a=
cpi_ghes-stub.c.o libcommon.fa.p/hw_acpi_acpi_interface.c.o libcommon.fa.p/=
hw_acpi_pci-bridge-stub.c.o libcommon.fa.p/hw_acpi_acpi-qmp-cmds.c.o libcom=
mon.fa.p/hw_audio_soundhw.c.o libcommon.fa.p/hw_audio_ac97.c.o libcommon.fa=
.p/hw_audio_fmopl.c.o libcommon.fa.p/hw_audio_adlib.c.o libcommon.fa.p/hw_a=
udio_cs4231a.c.o libcommon.fa.p/hw_audio_es1370.c.o libcommon.fa.p/hw_audio=
_gus.c.o libcommon.fa.p/hw_audio_gusemu_hal.c.o libcommon.fa.p/hw_audio_gus=
emu_mixer.c.o libcommon.fa.p/hw_audio_intel-hda.c.o libcommon.fa.p/hw_audio=
_hda-codec.c.o libcommon.fa.p/hw_audio_pcspk.c.o libcommon.fa.p/hw_audio_sb=
16.c.o libcommon.fa.p/hw_audio_virtio-snd.c.o libcommon.fa.p/hw_audio_virti=
o-snd-pci.c.o libcommon.fa.p/hw_block_block.c.o libcommon.fa.p/hw_block_cdr=
om.c.o libcommon.fa.p/hw_block_hd-geometry.c.o libcommon.fa.p/hw_block_fdc.=
c.o libcommon.fa.p/hw_block_fdc-isa.c.o libcommon.fa.p/hw_block_dataplane_v=
irtio-blk.c.o libcommon.fa.p/hw_char_ipoctal232.c.o libcommon.fa.p/hw_char_=
parallel-isa.c.o libcommon.fa.p/hw_char_parallel.c.o libcommon.fa.p/hw_char=
_serial.c.o libcommon.fa.p/hw_char_serial-isa.c.o libcommon.fa.p/hw_char_se=
rial-pci.c.o libcommon.fa.p/hw_char_serial-pci-multi.c.o libcommon.fa.p/hw_=
char_virtio-console.c.o libcommon.fa.p/hw_core_generic-loader.c.o libcommon=
.fa.p/hw_core_guest-loader.c.o libcommon.fa.p/hw_core_cpu-sysemu.c.o libcom=
mon.fa.p/hw_core_fw-path-provider.c.o libcommon.fa.p/hw_core_gpio.c.o libco=
mmon.fa.p/hw_core_loader.c.o libcommon.fa.p/hw_core_machine-hmp-cmds.c.o li=
bcommon.fa.p/hw_core_machine-qmp-cmds.c.o libcommon.fa.p/hw_core_machine.c.=
o libcommon.fa.p/hw_core_nmi.c.o libcommon.fa.p/hw_core_null-machine.c.o li=
bcommon.fa.p/hw_core_numa.c.o libcommon.fa.p/hw_core_qdev-fw.c.o libcommon.=
fa.p/hw_core_qdev-properties-system.c.o libcommon.fa.p/hw_core_sysbus.c.o l=
ibcommon.fa.p/hw_core_vm-change-state-handler.c.o libcommon.fa.p/hw_core_cl=
ock-vmstate.c.o libcommon.fa.p/hw_cpu_core.c.o libcommon.fa.p/hw_cpu_cluste=
r.c.o libcommon.fa.p/hw_cxl_cxl-host-stubs.c.o libcommon.fa.p/hw_display_i2=
c-ddc.c.o libcommon.fa.p/hw_display_edid-generate.c.o libcommon.fa.p/hw_dis=
play_edid-region.c.o libcommon.fa.p/hw_display_cirrus_vga.c.o libcommon.fa.=
p/hw_display_vga-pci.c.o libcommon.fa.p/hw_display_bochs-display.c.o libcom=
mon.fa.p/hw_display_vga.c.o libcommon.fa.p/hw_display_virtio-dmabuf.c.o lib=
common.fa.p/hw_display_acpi-vga-stub.c.o libcommon.fa.p/hw_display_ati.c.o =
libcommon.fa.p/hw_display_ati_2d.c.o libcommon.fa.p/hw_display_ati_dbg.c.o =
libcommon.fa.p/hw_dma_i82374.c.o libcommon.fa.p/hw_dma_i8257.c.o libcommon.=
fa.p/hw_i2c_core.c.o libcommon.fa.p/hw_i2c_bitbang_i2c.c.o libcommon.fa.p/h=
w_ide_ahci.c.o libcommon.fa.p/hw_ide_ich.c.o libcommon.fa.p/hw_ide_cmd646.c=
.o libcommon.fa.p/hw_ide_core.c.o libcommon.fa.p/hw_ide_atapi.c.o libcommon=
.fa.p/hw_ide_pci.c.o libcommon.fa.p/hw_ide_qdev.c.o libcommon.fa.p/hw_input=
_hid.c.o libcommon.fa.p/hw_input_pckbd.c.o libcommon.fa.p/hw_input_ps2.c.o =
libcommon.fa.p/hw_input_virtio-input.c.o libcommon.fa.p/hw_input_virtio-inp=
ut-hid.c.o libcommon.fa.p/hw_input_virtio-input-host.c.o libcommon.fa.p/hw_=
input_vhost-user-input.c.o libcommon.fa.p/hw_intc_intc.c.o libcommon.fa.p/h=
w_intc_i8259_common.c.o libcommon.fa.p/hw_intc_i8259.c.o libcommon.fa.p/hw_=
intc_kvm_irqcount.c.o libcommon.fa.p/hw_ipack_ipack.c.o libcommon.fa.p/hw_i=
pack_tpci200.c.o libcommon.fa.p/hw_isa_i82378.c.o libcommon.fa.p/hw_isa_isa=
-bus.c.o libcommon.fa.p/hw_isa_isa-superio.c.o libcommon.fa.p/hw_isa_smc37c=
669-superio.c.o libcommon.fa.p/hw_mem_cxl_type3_stubs.c.o libcommon.fa.p/hw=
_misc_pc-testdev.c.o libcommon.fa.p/hw_misc_pci-testdev.c.o libcommon.fa.p/=
hw_misc_pvpanic.c.o libcommon.fa.p/hw_misc_pvpanic-pci.c.o libcommon.fa.p/h=
w_misc_i2c-echo.c.o libcommon.fa.p/hw_net_ne2000.c.o libcommon.fa.p/hw_net_=
ne2000-pci.c.o libcommon.fa.p/hw_net_eepro100.c.o libcommon.fa.p/hw_net_pcn=
et-pci.c.o libcommon.fa.p/hw_net_pcnet.c.o libcommon.fa.p/hw_net_e1000.c.o =
libcommon.fa.p/hw_net_e1000x_common.c.o libcommon.fa.p/hw_net_rtl8139.c.o l=
ibcommon.fa.p/hw_net_tulip.c.o libcommon.fa.p/hw_net_net_tx_pkt.c.o libcomm=
on.fa.p/hw_net_net_rx_pkt.c.o libcommon.fa.p/hw_net_vmxnet3.c.o libcommon.f=
a.p/hw_net_ne2000-isa.c.o libcommon.fa.p/hw_net_vhost_net.c.o libcommon.fa.=
p/hw_net_rocker_qmp-norocker.c.o libcommon.fa.p/hw_net_rocker_rocker-hmp-cm=
ds.c.o libcommon.fa.p/hw_net_can_can_sja1000.c.o libcommon.fa.p/hw_net_can_=
can_kvaser_pci.c.o libcommon.fa.p/hw_net_can_can_pcm3680_pci.c.o libcommon.=
fa.p/hw_net_can_can_mioe3680_pci.c.o libcommon.fa.p/hw_net_can_ctucan_core.=
c.o libcommon.fa.p/hw_net_can_ctucan_pci.c.o libcommon.fa.p/hw_nvme_ctrl.c.=
o libcommon.fa.p/hw_nvme_dif.c.o libcommon.fa.p/hw_nvme_ns.c.o libcommon.fa=
.p/hw_nvme_subsys.c.o libcommon.fa.p/hw_nvram_fw_cfg-interface.c.o libcommo=
n.fa.p/hw_nvram_fw_cfg.c.o libcommon.fa.p/hw_nvram_eeprom93xx.c.o libcommon=
.fa.p/hw_pci_msi.c.o libcommon.fa.p/hw_pci_msix.c.o libcommon.fa.p/hw_pci_p=
ci.c.o libcommon.fa.p/hw_pci_pci_bridge.c.o libcommon.fa.p/hw_pci_pci_host.=
c.o libcommon.fa.p/hw_pci_pci-hmp-cmds.c.o libcommon.fa.p/hw_pci_pci-qmp-cm=
ds.c.o libcommon.fa.p/hw_pci_pcie_sriov.c.o libcommon.fa.p/hw_pci_shpc.c.o =
libcommon.fa.p/hw_pci_slotid_cap.c.o libcommon.fa.p/hw_pci_pcie.c.o libcomm=
on.fa.p/hw_pci_pcie_aer.c.o libcommon.fa.p/hw_pci_pcie_doe.c.o libcommon.fa=
.p/hw_pci-bridge_pci_bridge_dev.c.o libcommon.fa.p/hw_pci-bridge_pci_expand=
er_bridge_stubs.c.o libcommon.fa.p/hw_rtc_mc146818rtc.c.o libcommon.fa.p/hw=
_scsi_emulation.c.o libcommon.fa.p/hw_scsi_scsi-bus.c.o libcommon.fa.p/hw_s=
csi_scsi-disk.c.o libcommon.fa.p/hw_scsi_scsi-generic.c.o libcommon.fa.p/hw=
_scsi_esp.c.o libcommon.fa.p/hw_scsi_esp-pci.c.o libcommon.fa.p/hw_scsi_lsi=
53c895a.c.o libcommon.fa.p/hw_scsi_megasas.c.o libcommon.fa.p/hw_scsi_mptsa=
s.c.o libcommon.fa.p/hw_scsi_mptconfig.c.o libcommon.fa.p/hw_scsi_mptendian=
.c.o libcommon.fa.p/hw_scsi_vmw_pvscsi.c.o libcommon.fa.p/hw_scsi_virtio-sc=
si-dataplane.c.o libcommon.fa.p/hw_scsi_vhost-scsi.c.o libcommon.fa.p/hw_sc=
si_vhost-user-scsi.c.o libcommon.fa.p/hw_sd_sd.c.o libcommon.fa.p/hw_sd_cor=
e.c.o libcommon.fa.p/hw_sd_sdmmc-internal.c.o libcommon.fa.p/hw_sd_sdhci.c.=
o libcommon.fa.p/hw_sd_sdhci-pci.c.o libcommon.fa.p/hw_smbios_smbios-stub.c=
.o libcommon.fa.p/hw_timer_i8254_common.c.o libcommon.fa.p/hw_timer_i8254.c=
.o libcommon.fa.p/hw_ufs_ufs.c.o libcommon.fa.p/hw_ufs_lu.c.o libcommon.fa.=
p/hw_usb_bus.c.o libcommon.fa.p/hw_usb_combined-packet.c.o libcommon.fa.p/h=
w_usb_core.c.o libcommon.fa.p/hw_usb_desc.c.o libcommon.fa.p/hw_usb_desc-ms=
os.c.o libcommon.fa.p/hw_usb_libhw.c.o libcommon.fa.p/hw_usb_pcap.c.o libco=
mmon.fa.p/hw_usb_hcd-uhci.c.o libcommon.fa.p/hw_usb_hcd-ohci.c.o libcommon.=
fa.p/hw_usb_hcd-ohci-pci.c.o libcommon.fa.p/hw_usb_hcd-ehci.c.o libcommon.f=
a.p/hw_usb_hcd-ehci-pci.c.o libcommon.fa.p/hw_usb_hcd-xhci.c.o libcommon.fa=
.p/hw_usb_hcd-xhci-pci.c.o libcommon.fa.p/hw_usb_hcd-xhci-nec.c.o libcommon=
.fa.p/hw_usb_imx-usb-phy.c.o libcommon.fa.p/hw_usb_dev-hub.c.o libcommon.fa=
.p/hw_usb_dev-hid.c.o libcommon.fa.p/hw_usb_dev-wacom.c.o libcommon.fa.p/hw=
_usb_dev-storage.c.o libcommon.fa.p/hw_usb_dev-storage-bot.c.o libcommon.fa=
.p/hw_usb_dev-storage-classic.c.o libcommon.fa.p/hw_usb_dev-uas.c.o libcomm=
on.fa.p/hw_usb_dev-audio.c.o libcommon.fa.p/hw_usb_dev-serial.c.o libcommon=
.fa.p/hw_usb_dev-network.c.o libcommon.fa.p/hw_usb_dev-mtp.c.o libcommon.fa=
.p/hw_usb_dev-smartcard-reader.c.o libcommon.fa.p/hw_usb_u2f.c.o libcommon.=
fa.p/hw_usb_u2f-passthru.c.o libcommon.fa.p/hw_virtio_virtio-bus.c.o libcom=
mon.fa.p/hw_virtio_virtio-pci.c.o libcommon.fa.p/hw_virtio_virtio-crypto.c.=
o libcommon.fa.p/hw_virtio_vhost-vsock-common.c.o libcommon.fa.p/hw_virtio_=
virtio-iommu.c.o libcommon.fa.p/hw_virtio_vdpa-dev.c.o libcommon.fa.p/hw_vi=
rtio_vhost.c.o libcommon.fa.p/hw_virtio_vhost-user-device.c.o libcommon.fa.=
p/hw_virtio_vhost-user-device-pci.c.o libcommon.fa.p/hw_virtio_vhost-vdpa.c=
.o libcommon.fa.p/hw_virtio_virtio-hmp-cmds.c.o libcommon.fa.p/hw_watchdog_=
watchdog.c.o libcommon.fa.p/hw_watchdog_wdt_i6300esb.c.o libcommon.fa.p/hw_=
watchdog_wdt_ib700.c.o libcommon.fa.p/audio_audio.c.o libcommon.fa.p/audio_=
audio-hmp-cmds.c.o libcommon.fa.p/audio_mixeng.c.o libcommon.fa.p/audio_noa=
udio.c.o libcommon.fa.p/audio_wavaudio.c.o libcommon.fa.p/audio_wavcapture.=
c.o libcommon.fa.p/chardev_char-hmp-cmds.c.o libcommon.fa.p/chardev_msmouse=
.c.o libcommon.fa.p/chardev_wctablet.c.o libcommon.fa.p/chardev_testdev.c.o=
 libcommon.fa.p/fsdev_qemu-fsdev-opts.c.o libcommon.fa.p/fsdev_qemu-fsdev-t=
hrottle.c.o libcommon.fa.p/fsdev_9p-iov-marshal.c.o libcommon.fa.p/fsdev_9p=
-marshal.c.o libcommon.fa.p/fsdev_qemu-fsdev.c.o libcommon.fa.p/dump_dump.c=
.o libcommon.fa.p/dump_dump-hmp-cmds.c.o libcommon.fa.p/block_blkreplay.c.o=
 libcommon.fa.p/block_block-ram-registrar.c.o libcommon.fa.p/block_qapi-sys=
emu.c.o libcommon.fa.p/block_monitor_block-hmp-cmds.c.o libcommon.fa.p/syst=
em_balloon.c.o libcommon.fa.p/system_bootdevice.c.o libcommon.fa.p/system_c=
pus.c.o libcommon.fa.p/system_cpu-throttle.c.o libcommon.fa.p/system_cpu-ti=
mers.c.o libcommon.fa.p/system_datadir.c.o libcommon.fa.p/system_dirtylimit=
.c.o libcommon.fa.p/system_dma-helpers.c.o libcommon.fa.p/system_globals.c.=
o libcommon.fa.p/system_memory_mapping.c.o libcommon.fa.p/system_qdev-monit=
or.c.o libcommon.fa.p/system_qtest.c.o libcommon.fa.p/system_rtc.c.o libcom=
mon.fa.p/system_runstate-action.c.o libcommon.fa.p/system_runstate-hmp-cmds=
.c.o libcommon.fa.p/system_runstate.c.o libcommon.fa.p/system_tpm-hmp-cmds.=
c.o libcommon.fa.p/system_vl.c.o libcommon.fa.p/system_tpm.c.o libcommon.fa=
.p/system_qemu-seccomp.c.o libcommon.fa.p/system_device_tree.c.o libcommon.=
fa.p/system_async-teardown.c.o libcommon.fa.p/backends_cryptodev-builtin.c.=
o libcommon.fa.p/backends_cryptodev-hmp-cmds.c.o libcommon.fa.p/backends_cr=
yptodev.c.o libcommon.fa.p/backends_hostmem-ram.c.o libcommon.fa.p/backends=
_hostmem.c.o libcommon.fa.p/backends_rng-builtin.c.o libcommon.fa.p/backend=
s_rng-egd.c.o libcommon.fa.p/backends_rng.c.o libcommon.fa.p/backends_confi=
dential-guest-support.c.o libcommon.fa.p/backends_rng-random.c.o libcommon.=
fa.p/backends_hostmem-file.c.o libcommon.fa.p/backends_hostmem-memfd.c.o li=
bcommon.fa.p/backends_vhost-user.c.o libcommon.fa.p/backends_cryptodev-vhos=
t.c.o libcommon.fa.p/backends_cryptodev-vhost-user.c.o libcommon.fa.p/backe=
nds_dbus-vmstate.c.o libcommon.fa.p/backends_tpm_tpm_backend.c.o libcommon.=
fa.p/backends_tpm_tpm_util.c.o libcommon.fa.p/disas_disas-mon.c.o libcommon=
.fa.p/migration_block-dirty-bitmap.c.o libcommon.fa.p/migration_channel.c.o=
 libcommon.fa.p/migration_channel-block.c.o libcommon.fa.p/migration_dirtyr=
ate.c.o libcommon.fa.p/migration_exec.c.o libcommon.fa.p/migration_fd.c.o l=
ibcommon.fa.p/migration_file.c.o libcommon.fa.p/migration_global_state.c.o =
libcommon.fa.p/migration_migration-hmp-cmds.c.o libcommon.fa.p/migration_mi=
gration.c.o libcommon.fa.p/migration_multifd.c.o libcommon.fa.p/migration_m=
ultifd-zlib.c.o libcommon.fa.p/migration_ram-compress.c.o libcommon.fa.p/mi=
gration_options.c.o libcommon.fa.p/migration_postcopy-ram.c.o libcommon.fa.=
p/migration_savevm.c.o libcommon.fa.p/migration_socket.c.o libcommon.fa.p/m=
igration_tls.c.o libcommon.fa.p/migration_threadinfo.c.o libcommon.fa.p/mig=
ration_colo-failover.c.o libcommon.fa.p/migration_colo.c.o libcommon.fa.p/m=
igration_rdma.c.o libcommon.fa.p/migration_block.c.o libcommon.fa.p/migrati=
on_multifd-zstd.c.o libcommon.fa.p/monitor_fds.c.o libcommon.fa.p/monitor_h=
mp-cmds.c.o libcommon.fa.p/monitor_hmp.c.o libcommon.fa.p/monitor_qmp-cmds.=
c.o libcommon.fa.p/net_announce.c.o libcommon.fa.p/net_checksum.c.o libcomm=
on.fa.p/net_dump.c.o libcommon.fa.p/net_eth.c.o libcommon.fa.p/net_filter-b=
uffer.c.o libcommon.fa.p/net_filter-mirror.c.o libcommon.fa.p/net_filter.c.=
o libcommon.fa.p/net_hub.c.o libcommon.fa.p/net_net-hmp-cmds.c.o libcommon.=
fa.p/net_net.c.o libcommon.fa.p/net_queue.c.o libcommon.fa.p/net_socket.c.o=
 libcommon.fa.p/net_stream.c.o libcommon.fa.p/net_dgram.c.o libcommon.fa.p/=
net_util.c.o libcommon.fa.p/net_colo-compare.c.o libcommon.fa.p/net_colo.c.=
o libcommon.fa.p/net_filter-rewriter.c.o libcommon.fa.p/net_filter-replay.c=
.o libcommon.fa.p/net_l2tpv3.c.o libcommon.fa.p/net_slirp.c.o libcommon.fa.=
p/net_vde.c.o libcommon.fa.p/net_vhost-user.c.o libcommon.fa.p/net_tap.c.o =
libcommon.fa.p/net_tap-linux.c.o libcommon.fa.p/net_vhost-vdpa.c.o libcommo=
n.fa.p/net_can_can_core.c.o libcommon.fa.p/net_can_can_host.c.o libcommon.f=
a.p/net_can_can_socketcan.c.o libcommon.fa.p/replay_replay.c.o libcommon.fa=
.p/replay_replay-internal.c.o libcommon.fa.p/replay_replay-events.c.o libco=
mmon.fa.p/replay_replay-time.c.o libcommon.fa.p/replay_replay-input.c.o lib=
common.fa.p/replay_replay-char.c.o libcommon.fa.p/replay_replay-snapshot.c.=
o libcommon.fa.p/replay_replay-net.c.o libcommon.fa.p/replay_replay-audio.c=
.o libcommon.fa.p/replay_replay-random.c.o libcommon.fa.p/replay_replay-deb=
ugging.c.o libcommon.fa.p/stats_stats-hmp-cmds.c.o libcommon.fa.p/stats_sta=
ts-qmp-cmds.c.o libcommon.fa.p/accel_accel-system.c.o libcommon.fa.p/accel_=
accel-blocker.c.o libcommon.fa.p/accel_tcg_icount-common.c.o libcommon.fa.p=
/accel_tcg_monitor.c.o libcommon.fa.p/accel_dummy-cpus.c.o libcommon.fa.p/e=
bpf_ebpf_rss.c.o libcommon.fa.p/ui_curses.c.o libcommon.fa.p/ui_shader.c.o =
libcommon.fa.p/ui_console-gl.c.o libcommon.fa.p/ui_egl-helpers.c.o libcommo=
n.fa.p/ui_egl-context.c.o libcommon.fa.p/ui_egl-headless.c.o libcommon.fa.p=
/ui_dbus-chardev.c.o libcommon.fa.p/ui_dbus-clipboard.c.o libcommon.fa.p/ui=
_dbus-console.c.o libcommon.fa.p/ui_dbus-error.c.o libcommon.fa.p/ui_dbus-l=
istener.c.o libcommon.fa.p/ui_dbus.c.o libcommon.fa.p/ui_gtk.c.o libcommon.=
fa.p/ui_x_keymap.c.o libcommon.fa.p/ui_gtk-gl-area.c.o libcommon.fa.p/ui_gt=
k-egl.c.o libcommon.fa.p/ui_sdl2-2d.c.o libcommon.fa.p/ui_sdl2-input.c.o li=
bcommon.fa.p/ui_sdl2.c.o libcommon.fa.p/ui_sdl2-gl.c.o libcommon.fa.p/ui_sp=
ice-core.c.o libcommon.fa.p/ui_spice-input.c.o libcommon.fa.p/ui_spice-disp=
lay.c.o libcommon.fa.p/ui_spice-app.c.o libcommon.fa.p/hw_display_virtio-gp=
u-base.c.o libcommon.fa.p/hw_display_virtio-gpu.c.o libcommon.fa.p/hw_displ=
ay_virtio-gpu-udmabuf.c.o libcommon.fa.p/hw_display_vhost-user-gpu.c.o libc=
ommon.fa.p/hw_display_virtio-gpu-gl.c.o libcommon.fa.p/hw_display_virtio-gp=
u-virgl.c.o libcommon.fa.p/hw_display_virtio-gpu-pci.c.o libcommon.fa.p/hw_=
display_vhost-user-gpu-pci.c.o libcommon.fa.p/hw_display_virtio-gpu-pci-gl.=
c.o libcommon.fa.p/hw_usb_ccid-card-emulated.c.o libcommon.fa.p/hw_usb_ccid=
-card-passthru.c.o libcommon.fa.p/hw_usb_redirect.c.o libcommon.fa.p/hw_usb=
_quirks.c.o libcommon.fa.p/hw_usb_host-libusb.c.o libcommon.fa.p/audio_alsa=
audio.c.o libcommon.fa.p/audio_ossaudio.c.o libcommon.fa.p/audio_paaudio.c.=
o libcommon.fa.p/audio_sdlaudio.c.o libcommon.fa.p/audio_jackaudio.c.o libc=
ommon.fa.p/audio_sndioaudio.c.o libcommon.fa.p/audio_spiceaudio.c.o libcomm=
on.fa.p/audio_dbusaudio.c.o libcommon.fa.p/chardev_baum.c.o libcommon.fa.p/=
chardev_spice.c.o libqemu-alpha-softmmu.fa.p/target_alpha_machine.c.o libqe=
mu-alpha-softmmu.fa.p/hw_alpha_dp264.c.o libqemu-alpha-softmmu.fa.p/hw_alph=
a_pci.c.o libqemu-alpha-softmmu.fa.p/hw_alpha_typhoon.c.o libqemu-alpha-sof=
tmmu.fa.p/target_alpha_cpu.c.o libqemu-alpha-softmmu.fa.p/target_alpha_fpu_=
helper.c.o libqemu-alpha-softmmu.fa.p/target_alpha_gdbstub.c.o libqemu-alph=
a-softmmu.fa.p/target_alpha_helper.c.o libqemu-alpha-softmmu.fa.p/target_al=
pha_int_helper.c.o libqemu-alpha-softmmu.fa.p/target_alpha_mem_helper.c.o l=
ibqemu-alpha-softmmu.fa.p/target_alpha_sys_helper.c.o libqemu-alpha-softmmu=
.fa.p/target_alpha_translate.c.o libqemu-alpha-softmmu.fa.p/target_alpha_va=
x_helper.c.o libqemu-alpha-softmmu.fa.p/trace_control-target.c.o libqemu-al=
pha-softmmu.fa.p/hw_9pfs_virtio-9p-device.c.o libqemu-alpha-softmmu.fa.p/hw=
_block_virtio-blk.c.o libqemu-alpha-softmmu.fa.p/hw_block_virtio-blk-common=
.c.o libqemu-alpha-softmmu.fa.p/hw_block_vhost-user-blk.c.o libqemu-alpha-s=
oftmmu.fa.p/hw_char_virtio-serial-bus.c.o libqemu-alpha-softmmu.fa.p/hw_hyp=
erv_hv-balloon-stub.c.o libqemu-alpha-softmmu.fa.p/hw_net_virtio-net.c.o li=
bqemu-alpha-softmmu.fa.p/hw_scsi_virtio-scsi.c.o libqemu-alpha-softmmu.fa.p=
/hw_scsi_vhost-scsi-common.c.o libqemu-alpha-softmmu.fa.p/hw_vfio_helpers.c=
.o libqemu-alpha-softmmu.fa.p/hw_vfio_common.c.o libqemu-alpha-softmmu.fa.p=
/hw_vfio_container.c.o libqemu-alpha-softmmu.fa.p/hw_vfio_spapr.c.o libqemu=
-alpha-softmmu.fa.p/hw_vfio_migration.c.o libqemu-alpha-softmmu.fa.p/hw_vfi=
o_display.c.o libqemu-alpha-softmmu.fa.p/hw_vfio_pci-quirks.c.o libqemu-alp=
ha-softmmu.fa.p/hw_vfio_pci.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_virtio=
.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_virtio-config-io.c.o libqemu-alph=
a-softmmu.fa.p/hw_virtio_virtio-qmp.c.o libqemu-alpha-softmmu.fa.p/hw_virti=
o_vhost-backend.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vhost-iova-tree.c.=
o libqemu-alpha-softmmu.fa.p/hw_virtio_vhost-user.c.o libqemu-alpha-softmmu=
.fa.p/hw_virtio_vhost-shadow-virtqueue.c.o libqemu-alpha-softmmu.fa.p/hw_vi=
rtio_virtio-balloon.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vhost-user-fs.=
c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vhost-vsock.c.o libqemu-alpha-soft=
mmu.fa.p/hw_virtio_vhost-user-vsock.c.o libqemu-alpha-softmmu.fa.p/hw_virti=
o_virtio-rng.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vhost-user-i2c.c.o li=
bqemu-alpha-softmmu.fa.p/hw_virtio_vhost-user-rng.c.o libqemu-alpha-softmmu=
.fa.p/hw_virtio_vhost-user-gpio.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vh=
ost-user-gpio-pci.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vhost-user-scmi.=
c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vhost-user-scmi-pci.c.o libqemu-al=
pha-softmmu.fa.p/hw_virtio_vhost-vsock-pci.c.o libqemu-alpha-softmmu.fa.p/h=
w_virtio_vhost-user-vsock-pci.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vhos=
t-user-blk-pci.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vhost-user-i2c-pci.=
c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vhost-user-input-pci.c.o libqemu-a=
lpha-softmmu.fa.p/hw_virtio_vhost-user-rng-pci.c.o libqemu-alpha-softmmu.fa=
.p/hw_virtio_vhost-user-scsi-pci.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_v=
host-scsi-pci.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vhost-user-fs-pci.c.=
o libqemu-alpha-softmmu.fa.p/hw_virtio_virtio-crypto-pci.c.o libqemu-alpha-=
softmmu.fa.p/hw_virtio_virtio-input-host-pci.c.o libqemu-alpha-softmmu.fa.p=
/hw_virtio_virtio-input-pci.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_virtio=
-rng-pci.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_virtio-balloon-pci.c.o li=
bqemu-alpha-softmmu.fa.p/hw_virtio_virtio-9p-pci.c.o libqemu-alpha-softmmu.=
fa.p/hw_virtio_virtio-scsi-pci.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_vir=
tio-blk-pci.c.o libqemu-alpha-softmmu.fa.p/hw_virtio_virtio-net-pci.c.o lib=
qemu-alpha-softmmu.fa.p/hw_virtio_virtio-serial-pci.c.o libqemu-alpha-softm=
mu.fa.p/hw_virtio_virtio-iommu-pci.c.o libqemu-alpha-softmmu.fa.p/hw_virtio=
_vdpa-dev-pci.c.o libqemu-alpha-softmmu.fa.p/hw_i386_kvm_xen-stubs.c.o libq=
emu-alpha-softmmu.fa.p/dump_win_dump.c.o libqemu-alpha-softmmu.fa.p/cpu-tar=
get.c.o libqemu-alpha-softmmu.fa.p/system_arch_init.c.o libqemu-alpha-softm=
mu.fa.p/system_ioport.c.o libqemu-alpha-softmmu.fa.p/system_memory.c.o libq=
emu-alpha-softmmu.fa.p/system_physmem.c.o libqemu-alpha-softmmu.fa.p/system=
_watchpoint.c.o libqemu-alpha-softmmu.fa.p/page-vary-target.c.o libqemu-alp=
ha-softmmu.fa.p/migration_ram.c.o libqemu-alpha-softmmu.fa.p/migration_targ=
et.c.o libqemu-alpha-softmmu.fa.p/monitor_hmp-cmds-target.c.o libqemu-alpha=
-softmmu.fa.p/monitor_hmp-target.c.o libqemu-alpha-softmmu.fa.p/fpu_softflo=
at.c.o libqemu-alpha-softmmu.fa.p/accel_accel-target.c.o libqemu-alpha-soft=
mmu.fa.p/accel_tcg_tcg-all.c.o libqemu-alpha-softmmu.fa.p/accel_tcg_cpu-exe=
c.c.o libqemu-alpha-softmmu.fa.p/accel_tcg_tb-maint.c.o libqemu-alpha-softm=
mu.fa.p/accel_tcg_tcg-runtime-gvec.c.o libqemu-alpha-softmmu.fa.p/accel_tcg=
_tcg-runtime.c.o libqemu-alpha-softmmu.fa.p/accel_tcg_translate-all.c.o lib=
qemu-alpha-softmmu.fa.p/accel_tcg_translator.c.o libqemu-alpha-softmmu.fa.p=
/accel_tcg_plugin-gen.c.o libqemu-alpha-softmmu.fa.p/accel_tcg_perf.c.o lib=
qemu-alpha-softmmu.fa.p/accel_tcg_cputlb.c.o libqemu-alpha-softmmu.fa.p/acc=
el_stubs_xen-stub.c.o libqemu-alpha-softmmu.fa.p/accel_stubs_kvm-stub.c.o l=
ibqemu-alpha-softmmu.fa.p/plugins_loader.c.o libqemu-alpha-softmmu.fa.p/plu=
gins_core.c.o libqemu-alpha-softmmu.fa.p/plugins_api.c.o libqemu-alpha-soft=
mmu.fa.p/accel_tcg_tcg-accel-ops.c.o libqemu-alpha-softmmu.fa.p/accel_tcg_t=
cg-accel-ops-mttcg.c.o libqemu-alpha-softmmu.fa.p/accel_tcg_tcg-accel-ops-i=
count.c.o libqemu-alpha-softmmu.fa.p/accel_tcg_tcg-accel-ops-rr.c.o libqemu=
-alpha-softmmu.fa.p/accel_qtest_qtest.c.o libqemu-alpha-softmmu.fa.p/meson-=
generated_.._qapi_qapi-types-machine-target.c.o libqemu-alpha-softmmu.fa.p/=
meson-generated_.._qapi_qapi-visit-machine-target.c.o libqemu-alpha-softmmu=
.fa.p/meson-generated_.._qapi_qapi-events-machine-target.c.o libqemu-alpha-=
softmmu.fa.p/meson-generated_.._qapi_qapi-commands-machine-target.c.o libqe=
mu-alpha-softmmu.fa.p/meson-generated_.._qapi_qapi-types-misc-target.c.o li=
bqemu-alpha-softmmu.fa.p/meson-generated_.._qapi_qapi-visit-misc-target.c.o=
 libqemu-alpha-softmmu.fa.p/meson-generated_.._qapi_qapi-events-misc-target=
.c.o libqemu-alpha-softmmu.fa.p/meson-generated_.._qapi_qapi-commands-misc-=
target.c.o libqemu-alpha-softmmu.fa.p/meson-generated_.._qapi_qapi-introspe=
ct.c.o libqemu-alpha-softmmu.fa.p/meson-generated_.._qapi_qapi-types.c.o li=
bqemu-alpha-softmmu.fa.p/meson-generated_.._qapi_qapi-visit.c.o libqemu-alp=
ha-softmmu.fa.p/meson-generated_.._qapi_qapi-commands.c.o libqemu-alpha-sof=
tmmu.fa.p/meson-generated_.._qapi_qapi-init-commands.c.o libqemu-alpha-soft=
mmu.fa.p/meson-generated_.._qapi_qapi-events.c.o libqemu-alpha-softmmu.fa.p=
/meson-generated_.._qapi_qapi-emit-events.c.o qemu-system-alpha.p/system_ma=
in.c.o -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libhwcor=
e.fa libqom.fa libevent-loop-base.fa gdbstub/libgdb_system.fa libio.fa libc=
rypto.fa libauthz.fa libblockdev.fa libblock.fa libchardev.fa libqmp.fa -Wl=
,--no-whole-archive -fstack-protector-strong -Wl,-z,relro -Wl,-z,now -Wl,--=
warn-common -Wl,--start-group libqemuutil.a subprojects/libvhost-user/libvh=
ost-user-glib.a subprojects/libvhost-user/libvhost-user.a tcg/libtcg_system=
.fa ui/libdbus-display1.a libmigration.fa libhwcore.fa libqom.fa libevent-l=
oop-base.fa gdbstub/libgdb_system.fa libio.fa libcrypto.fa libauthz.fa libb=
lockdev.fa subprojects/libvduse/libvduse.a libblock.fa libchardev.fa libqmp=
.fa @block.syms @qemu.syms /usr/lib/x86_64-linux-gnu/libpixman-1.so /usr/li=
b/x86_64-linux-gnu/libepoxy.so /usr/lib/x86_64-linux-gnu/libcapstone.so /us=
r/lib/x86_64-linux-gnu/libspice-server.so -Xlinker --dynamic-list=3D/home/a=
lex/lsrc/qemu.git/plugins/qemu-plugins.symbols /usr/lib/x86_64-linux-gnu/li=
bgnutls.so /usr/lib/x86_64-linux-gnu/libpng16.so /usr/lib/x86_64-linux-gnu/=
libz.so /usr/lib/x86_64-linux-gnu/libjpeg.so -lsasl2 -lfdt /usr/lib/x86_64-=
linux-gnu/libudev.so /usr/lib/x86_64-linux-gnu/libSDL2.so /usr/lib/x86_64-l=
inux-gnu/libpmem.so /usr/lib/x86_64-linux-gnu/libseccomp.so -lnuma /usr/lib=
/x86_64-linux-gnu/libgio-2.0.so /usr/lib/x86_64-linux-gnu/libgobject-2.0.so=
 /usr/lib/x86_64-linux-gnu/libglib-2.0.so -lrdmacm -libverbs -libumad /usr/=
lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/libzstd.so /usr/lib/x=
86_64-linux-gnu/libslirp.so -lvdeplug /usr/lib/x86_64-linux-gnu/libbpf.so /=
usr/lib/x86_64-linux-gnu/libncursesw.so /usr/lib/x86_64-linux-gnu/libtinfo.=
so /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so -pthread /usr/lib/x86_64-lin=
ux-gnu/libgbm.so /usr/lib/x86_64-linux-gnu/libgtk-3.so /usr/lib/x86_64-linu=
x-gnu/libgdk-3.so /usr/lib/x86_64-linux-gnu/libpangocairo-1.0.so /usr/lib/x=
86_64-linux-gnu/libpango-1.0.so /usr/lib/x86_64-linux-gnu/libharfbuzz.so /u=
sr/lib/x86_64-linux-gnu/libatk-1.0.so /usr/lib/x86_64-linux-gnu/libcairo-go=
bject.so /usr/lib/x86_64-linux-gnu/libcairo.so /usr/lib/x86_64-linux-gnu/li=
bgdk_pixbuf-2.0.so /usr/lib/x86_64-linux-gnu/libvte-2.91.so /usr/lib/x86_64=
-linux-gnu/libX11.so /usr/lib/x86_64-linux-gnu/libvirglrenderer.so /usr/lib=
/x86_64-linux-gnu/libcacard.so /usr/lib/x86_64-linux-gnu/libusbredirparser.=
so /usr/lib/x86_64-linux-gnu/libusb-1.0.so /usr/lib/x86_64-linux-gnu/libaso=
und.so /usr/lib/x86_64-linux-gnu/libpulse.so /usr/lib/x86_64-linux-gnu/libj=
ack.so -lpthread /usr/lib/x86_64-linux-gnu/libsndio.so -lbrlapi @block.syms=
 -lnuma /usr/lib/x86_64-linux-gnu/liburing.so -lm /usr/lib/x86_64-linux-gnu=
/libfuse3.so /usr/lib/x86_64-linux-gnu/libiscsi.so -laio /usr/lib/x86_64-li=
nux-gnu/libcurl.so /usr/lib/x86_64-linux-gnu/libacl.so /usr/lib/x86_64-linu=
x-gnu/libgfapi.so /usr/lib/x86_64-linux-gnu/libglusterfs.so /usr/lib/x86_64=
-linux-gnu/libgfrpc.so /usr/lib/x86_64-linux-gnu/libgfxdr.so /usr/lib/x86_6=
4-linux-gnu/libuuid.so /usr/lib/x86_64-linux-gnu/libnfs.so /usr/lib/x86_64-=
linux-gnu/libssh.so -lrbd -lrados -lutil -Wl,--end-group
/usr/bin/ld: libcommon.fa.p/system_vl.c.o: in function `foreach_device_conf=
ig':
/home/alex/lsrc/qemu.git/builds/all/../../system/vl.c:1306: undefined refer=
ence to `mcdserver_start'
collect2: error: ld returned 1 exit status

I think because you are missing the meson integration to add this to the
build. Is it in a later patch?

>      if (!vga_interface_created && !default_vga &&
>          vga_interface_type !=3D VGA_NONE) {
>          warn_report("A -vga option was passed but this machine "
> @@ -3028,6 +3038,9 @@ void qemu_init(int argc, char **argv)
>              case QEMU_OPTION_gdb:
>                  add_device_config(DEV_GDB, optarg);
>                  break;
> +            case QEMU_OPTION_mcd:
> +                add_device_config(DEV_MCD, optarg);
> +                break;
>              case QEMU_OPTION_L:
>                  if (is_help_option(optarg)) {
>                      list_data_dirs =3D true;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

