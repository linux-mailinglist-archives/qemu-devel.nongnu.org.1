Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15E8D245E
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 21:16:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC2I7-0006Lv-N2; Tue, 28 May 2024 15:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sC2Hz-0006K0-Ht
 for qemu-devel@nongnu.org; Tue, 28 May 2024 15:15:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sC2Hi-0001OI-MS
 for qemu-devel@nongnu.org; Tue, 28 May 2024 15:15:12 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6269885572so21003666b.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716923696; x=1717528496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JVCqlSarwinZ9Xl7YXiz4zoBlFBMtzypmFHhrn3vK64=;
 b=UIUUQVAKfrq/3zxhEP7479i92OJKXviwwjSFRkbi9D7/UsuiDSt2NBvVxR4Ommdf8/
 Ap6uo+dg4G3MJnlFi0YUFHPrlAQ8Kj2j2TFAJr/XGS7dT7SLCHIId2ta4pW/Bzv+VhW7
 x1itkvQcPUPQvVjRDSFSpQlc1XbB8yIoi+yJfVikcuc6vVeH1UerEXhg1jo1b23wYHum
 fre31URbQn6DNFHpZXFtVjN745ODCFC+O7zkvMwDVznJjDoGGB6CWZXwuWh1oZwKQ61N
 3gL+zIcV9j121A6sAyPpLQfTpHsJOa/I6W+8uDgABmGeDEN5gUTUTBR4lTMz2n61U4ZW
 ORDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716923696; x=1717528496;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVCqlSarwinZ9Xl7YXiz4zoBlFBMtzypmFHhrn3vK64=;
 b=GbxAN/XibfMg6R4T1b/b6Q233B57ayGYt9cIfh6AWANLDt2V6Goa0T5MIlnAMD3Do1
 VVYISMAIXRdJwXm/ZfW4THKPWxezJbZG8Pxex7wpmKa7+PePNeBmcLuysiVCC3KxWF/g
 F4iKTMn008zX4YgB00RL6HTvvoBGHOWKaYwxBnn+ynkRqXyj9NNJu22nV5FgpZAj0ZNW
 pVqOF3r7g3th+V4IzTZHTQYJq3sCgx+yKSq0a0bXAi7DOOcQIMtifBlWscwjXEZ5TqOy
 PtMGP2BmNaURd/kZxO9r8vOmanP+Qg0gBye+DNUfLOLoTN3zAopPCEE8BiOn9suqXAF9
 fuCg==
X-Gm-Message-State: AOJu0YzVyyzv7emM7BejjWaJCwLmedlJZ++KAaBvY/8Ww/UImhDODRj9
 /p6c3btm5hIpDTxh7KLUdF+JtVreGAq1XnjgwTvpqlI4NKRt6KgLhxoYuMpy7yw=
X-Google-Smtp-Source: AGHT+IGOyhmyNebV57F8MxWWjqBsFWObx/u15G9XaaPgqNDwpMAEYQbX9yIgRDLMWYZ+pwSHfh+srA==
X-Received: by 2002:a17:906:3989:b0:a63:560d:fe0f with SMTP id
 a640c23a62f3a-a642d37e307mr1300166b.14.1716923695559; 
 Tue, 28 May 2024 12:14:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8e295sm639753066b.185.2024.05.28.12.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 12:14:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 708965F88D;
 Tue, 28 May 2024 20:14:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] contrib/plugins: add ips plugin example for cost
 modeling
In-Reply-To: <20240516222047.1853459-6-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 16 May 2024 15:20:47 -0700")
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
 <20240516222047.1853459-6-pierrick.bouvier@linaro.org>
Date: Tue, 28 May 2024 20:14:54 +0100
Message-ID: <874jahg34h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This plugin uses the new time control interface to make decisions
> about the state of time during the emulation. The algorithm is
> currently very simple. The user specifies an ips rate which applies
> per core. If the core runs ahead of its allocated execution time the
> plugin sleeps for a bit to let real time catch up. Either way time is
> updated for the emulation as a function of total executed instructions
> with some adjustments for cores that idle.
>
> Examples
> --------
>
> Slow down execution of /bin/true:
> $ num_insn=3D$(./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.s=
o -d plugin /bin/true |& grep total | sed -e 's/.*: //')
> $ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips.so,ips=
=3D$(($num_insn/4)) /bin/true
> real 4.000s
>
> Boot a Linux kernel simulating a 250MHz cpu:
> $ /build/qemu-system-x86_64 -kernel /boot/vmlinuz-6.1.0-21-amd64 -append =
"console=3DttyS0" -plugin ./build/contrib/plugins/libips.so,ips=3D$((250*10=
00*1000)) -smp 1 -m 512
> check time until kernel panic on serial0
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  contrib/plugins/ips.c    | 239 +++++++++++++++++++++++++++++++++++++++
>  contrib/plugins/Makefile |   1 +
>  2 files changed, 240 insertions(+)
>  create mode 100644 contrib/plugins/ips.c
>
> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
> new file mode 100644
> index 00000000000..cf3159df391
> --- /dev/null
> +++ b/contrib/plugins/ips.c
> @@ -0,0 +1,239 @@
> +/*
> + * ips rate limiting plugin.
> + *
> + * This plugin can be used to restrict the execution of a system to a
> + * particular number of Instructions Per Second (ips). This controls
> + * time as seen by the guest so while wall-clock time may be longer
> + * from the guests point of view time will pass at the normal rate.
> + *
> + * This uses the new plugin API which allows the plugin to control
> + * system time.
> + *
> + * Copyright (c) 2023 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdio.h>
> +#include <glib.h>
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
> +/* how many times do we update time per sec */
> +#define NUM_TIME_UPDATE_PER_SEC 10
> +#define NSEC_IN_ONE_SEC (1000 * 1000 * 1000)
> +
> +static GMutex global_state_lock;
> +
> +static uint64_t insn_per_second =3D 1000 * 1000; /* ips per core, per se=
cond */
> +static uint64_t insn_quantum; /* trap every N instructions */
> +static bool precise_execution; /* count every instruction */
> +static int64_t start_time_ns; /* time (ns since epoch) first vCPU starte=
d */
> +static int64_t virtual_time_ns; /* last set virtual time */
> +
> +static const void *time_handle;
> +
> +typedef enum {
> +    UNKNOWN =3D 0,
> +    EXECUTING,
> +    IDLE,
> +    FINISHED
> +} vCPUState;
> +
> +typedef struct {
> +    uint64_t counter;
> +    uint64_t track_insn;
> +    vCPUState state;
> +    /* timestamp when vCPU entered state */
> +    int64_t last_state_time;
> +} vCPUTime;
> +
> +struct qemu_plugin_scoreboard *vcpus;
> +
> +/* return epoch time in ns */
> +static int64_t now_ns(void)
> +{
> +    return g_get_real_time() * 1000;
> +}
> +
> +static uint64_t num_insn_during(int64_t elapsed_ns)
> +{
> +    double num_secs =3D elapsed_ns / (double) NSEC_IN_ONE_SEC;
> +    return num_secs * (double) insn_per_second;
> +}
> +
> +static int64_t time_for_insn(uint64_t num_insn)
> +{
> +    double num_secs =3D (double) num_insn / (double) insn_per_second;
> +    return num_secs * (double) NSEC_IN_ONE_SEC;
> +}
> +
> +static int64_t uptime_ns(void)
> +{
> +    int64_t now =3D now_ns();
> +    g_assert(now >=3D start_time_ns);
> +    return now - start_time_ns;
> +}
> +
> +static void vcpu_set_state(vCPUTime *vcpu, vCPUState new_state)
> +{
> +    vcpu->last_state_time =3D now_ns();
> +    vcpu->state =3D new_state;
> +}
> +
> +static void update_system_time(vCPUTime *vcpu)
> +{
> +    /* flush remaining instructions */
> +    vcpu->counter +=3D vcpu->track_insn;
> +    vcpu->track_insn =3D 0;
> +
> +    int64_t uptime =3D uptime_ns();
> +    uint64_t expected_insn =3D num_insn_during(uptime);
> +
> +    if (vcpu->counter >=3D expected_insn) {
> +        /* this vcpu ran faster than expected, so it has to sleep */
> +        uint64_t insn_advance =3D vcpu->counter - expected_insn;
> +        uint64_t time_advance_ns =3D time_for_insn(insn_advance);
> +        int64_t sleep_us =3D time_advance_ns / 1000;
> +        g_usleep(sleep_us);
> +    }
> +
> +    /* based on number of instructions, what should be the new time? */
> +    int64_t new_virtual_time =3D time_for_insn(vcpu->counter);
> +
> +    g_mutex_lock(&global_state_lock);
> +
> +    /* Time only moves forward. Another vcpu might have updated it alrea=
dy. */
> +    if (new_virtual_time > virtual_time_ns) {
> +        qemu_plugin_update_ns(time_handle, new_virtual_time);
> +        virtual_time_ns =3D new_virtual_time;
> +    }
> +
> +    g_mutex_unlock(&global_state_lock);
> +}
> +
> +static void set_start_time()
> +{
> +    g_mutex_lock(&global_state_lock);
> +    if (!start_time_ns) {
> +        start_time_ns =3D now_ns();
> +    }
> +    g_mutex_unlock(&global_state_lock);
> +}
> +
> +static void vcpu_init(qemu_plugin_id_t id, unsigned int cpu_index)
> +{
> +    vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_index);
> +    /* ensure start time is set first */
> +    set_start_time();
> +    /* start counter from absolute time reference */
> +    vcpu->counter =3D num_insn_during(uptime_ns());
> +    vcpu_set_state(vcpu, EXECUTING);
> +}
> +
> +static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
> +{
> +    vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_index);
> +    vcpu_set_state(vcpu, IDLE);
> +}
> +
> +static void vcpu_resume(qemu_plugin_id_t id, unsigned int cpu_index)
> +{
> +    vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_index);
> +    g_assert(vcpu->state =3D=3D IDLE);

I'm triggering a weird race here:

  (gdb) b vcpu_init
  Breakpoint 1 at 0x7ffff7fa15f7: file /home/alex/lsrc/qemu.git/contrib/plu=
gins/ips.c, line 127.
  (gdb) r
  The program being debugged has been started already.
  Start it from the beginning? (y or n) y
  Starting program: /home/alex/lsrc/qemu.git/builds/arm.debug/qemu-system-a=
arch64 -machine type=3Dvirt,virtualization=3Don,pflash0=3Drom,pflash1=3Defi=
vars -cpu cortex-a57 -smp 32 -accel tcg -device virtio-net-pci,netdev=3Dune=
t -device virtio-scsi-pci -device scsi-hd,drive=3Dhd -netdev user,id=3Dunet=
,hostfwd=3Dtcp::2222-:22 -blockdev driver=3Draw,node-name=3Dhd,file.driver=
=3Dhost_device,file.filename=3D/dev/zen-ssd2/trixie-arm64,discard=3Dunmap -=
serial mon:stdio -blockdev node-name=3Drom,driver=3Dfile,filename=3D/home/a=
lex/lsrc/qemu.git/builds/arm.debug/pc-bios/edk2-aarch64-code.fd,read-only=
=3Dtrue -blockdev node-name=3Defivars,driver=3Dfile,filename=3D/home/alex/i=
mages/qemu-arm64-efivars -m 8192 -object memory-backend-memfd,id=3Dmem,size=
=3D8G,share=3Don -kernel /home/alex/lsrc/linux.git/builds/arm64/arch/arm64/=
boot/Image -append root=3D/dev/sda2\ console=3DttyAMA0 -plugin contrib/plug=
ins/libips.so,ips=3D1000000000
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
  [New Thread 0x7fffe72006c0 (LWP 360538)]
  [New Thread 0x7fffe68006c0 (LWP 360540)]
  [New Thread 0x7fffe5e006c0 (LWP 360541)]
  [New Thread 0x7fffe54006c0 (LWP 360542)]
  [New Thread 0x7fffe4a006c0 (LWP 360543)]
  [New Thread 0x7fffdfe006c0 (LWP 360544)]
  [New Thread 0x7fffdf4006c0 (LWP 360545)]
  [New Thread 0x7fffdea006c0 (LWP 360546)]
  [Switching to Thread 0x7fffdf4006c0 (LWP 360545)]

  Thread 8 "qemu-system-aar" hit Breakpoint 1, vcpu_init (id=3D104579085693=
52202058, cpu_index=3D0) at /home/alex/lsrc/qemu.git/contrib/plugins/ips.c:=
127
  127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_ind=
ex);
  (gdb) c
  Continuing.
  [New Thread 0x7fffde0006c0 (LWP 360548)]
  [Switching to Thread 0x7fffdea006c0 (LWP 360546)]

  Thread 9 "qemu-system-aar" hit Breakpoint 1, vcpu_init (id=3D104579085693=
52202058, cpu_index=3D1) at /home/alex/lsrc/qemu.git/contrib/plugins/ips.c:=
127
  127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_ind=
ex);
  (gdb)
  Continuing.
  [New Thread 0x7fffdd6006c0 (LWP 360549)]
  [Switching to Thread 0x7fffde0006c0 (LWP 360548)]

  Thread 10 "qemu-system-aar" hit Breakpoint 1, vcpu_init (id=3D10457908569=
352202058, cpu_index=3D2) at /home/alex/lsrc/qemu.git/contrib/plugins/ips.c=
:127
  127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_ind=
ex);
  (gdb)
  Continuing.
  [New Thread 0x7fffdcc006c0 (LWP 360550)]
  [Switching to Thread 0x7fffdd6006c0 (LWP 360549)]

  Thread 11 "qemu-system-aar" hit Breakpoint 1, vcpu_init (id=3D10457908569=
352202058, cpu_index=3D3) at /home/alex/lsrc/qemu.git/contrib/plugins/ips.c=
:127
  127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_ind=
ex);
  (gdb)
  Continuing.
  [New Thread 0x7fffd3e006c0 (LWP 360551)]
  [Switching to Thread 0x7fffdcc006c0 (LWP 360550)]

  Thread 12 "qemu-system-aar" hit Breakpoint 1, vcpu_init (id=3D10457908569=
352202058, cpu_index=3D4) at /home/alex/lsrc/qemu.git/contrib/plugins/ips.c=
:127
  127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_ind=
ex);
  (gdb) n
  129         set_start_time();
  (gdb)
  131         vcpu->counter =3D num_insn_during(uptime_ns());
  (gdb)
  132         vcpu_set_state(vcpu, EXECUTING);
  (gdb)
  133     }
  (gdb) p vcpu->state
  $1 =3D EXECUTING
  (gdb) p &vcpu->state
  $2 =3D (vCPUState *) 0x555557c6b5d0
  (gdb) watch *(vCPUState *) 0x555557c6b5d0
  Hardware watchpoint 2: *(vCPUState *) 0x555557c6b5d0
  (gdb) c
  Continuing.
  [Thread 0x7fffdfe006c0 (LWP 360544) exited]
  [Thread 0x7fffe5e006c0 (LWP 360541) exited]

  Thread 12 "qemu-system-aar" hit Hardware watchpoint 2: *(vCPUState *) 0x5=
55557c6b5d0

  Old value =3D EXECUTING
  New value =3D IDLE
  vcpu_set_state (vcpu=3D0x555557c6b5c0, new_state=3DIDLE) at /home/alex/ls=
rc/qemu.git/contrib/plugins/ips.c:83
  83      }
  (gdb) c
  Continuing.
  [New Thread 0x7fffdfe006c0 (LWP 360591)]
  [New Thread 0x7fffe5e006c0 (LWP 360592)]
  [New Thread 0x7fffd34006c0 (LWP 360593)]
  [Switching to Thread 0x7fffdfe006c0 (LWP 360591)]

  Thread 14 "qemu-system-aar" hit Breakpoint 1, vcpu_init (id=3D10457908569=
352202058, cpu_index=3D6) at /home/alex/lsrc/qemu.git/contrib/plugins/ips.c=
:127
  127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_ind=
ex);
  (gdb)
  Continuing.
  [New Thread 0x7fffd2a006c0 (LWP 360594)]
  **
  ERROR:/home/alex/lsrc/qemu.git/contrib/plugins/ips.c:144:vcpu_resume: ass=
ertion failed: (vcpu->state =3D=3D IDLE)
  Bail out! ERROR:/home/alex/lsrc/qemu.git/contrib/plugins/ips.c:144:vcpu_r=
esume: assertion failed: (vcpu->state =3D=3D IDLE)

  Thread 13 "qemu-system-aar" received signal SIGABRT, Aborted.
  [Switching to Thread 0x7fffd3e006c0 (LWP 360551)]
  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsigno@=
entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
  44      ./nptl/pthread_kill.c: No such file or directory.
  (gdb) bt
  #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsi=
gno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
  #1  0x00007ffff4ca9e8f in __pthread_kill_internal (signo=3D6, threadid=3D=
<optimized out>) at ./nptl/pthread_kill.c:78
  #2  0x00007ffff4c5afb2 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
posix/raise.c:26
  #3  0x00007ffff4c45472 in __GI_abort () at ./stdlib/abort.c:79
  #4  0x00007ffff6e46ec8 in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
  #5  0x00007ffff6ea6e1a in g_assertion_message_expr () at /lib/x86_64-linu=
x-gnu/libglib-2.0.so.0
  #6  0x00007ffff7fa16e2 in vcpu_resume (id=3D10457908569352202058, cpu_ind=
ex=3D5) at /home/alex/lsrc/qemu.git/contrib/plugins/ips.c:144
  #7  0x00005555562c3202 in plugin_vcpu_cb__simple (cpu=3D0x5555583d9540, e=
v=3DQEMU_PLUGIN_EV_VCPU_RESUME) at ../../plugins/core.c:111
  #8  0x00005555562c43f7 in qemu_plugin_vcpu_resume_cb (cpu=3D0x5555583d954=
0) at ../../plugins/core.c:523
  #9  0x0000555555d9150e in qemu_wait_io_event (cpu=3D0x5555583d9540) at ..=
/../system/cpus.c:465
  #10 0x00005555562c67d0 in mttcg_cpu_thread_fn (arg=3D0x5555583d9540) at .=
./../accel/tcg/tcg-accel-ops-mttcg.c:118
  #11 0x00005555565120ff in qemu_thread_start (args=3D0x5555584716e0) at ..=
/../util/qemu-thread-posix.c:541
  #12 0x00007ffff4ca8134 in start_thread (arg=3D<optimized out>) at ./nptl/=
pthread_create.c:442
  #13 0x00007ffff4d287dc in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/=
clone3.S:81
  (gdb)

But I don't understand how we can ever hit the idle callback without
first hitting the init callback.

> +    int64_t idle_time =3D now_ns() - vcpu->last_state_time;
> +    /* accumulate expected number of instructions */
> +    vcpu->counter +=3D num_insn_during(idle_time);
> +    vcpu_set_state(vcpu, EXECUTING);
> +}
> +
> +static void vcpu_exit(qemu_plugin_id_t id, unsigned int cpu_index)
> +{
> +    vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_index);
> +    vcpu_set_state(vcpu, FINISHED);
> +    update_system_time(vcpu);
> +    vcpu->counter =3D 0;
> +}
> +
> +static void every_insn_quantum(unsigned int cpu_index, void *udata)
> +{
> +    vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_index);
> +    g_assert(vcpu->track_insn >=3D insn_quantum);
> +    update_system_time(vcpu);
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    size_t n_insns =3D qemu_plugin_tb_n_insns(tb);
> +    qemu_plugin_u64 track_insn =3D
> +        qemu_plugin_scoreboard_u64_in_struct(vcpus, vCPUTime, track_insn=
);
> +    if (precise_execution) {
> +        /* count (and eventually trap) on every instruction */
> +        for (int idx =3D 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
> +            struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb=
, idx);
> +            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +                insn, QEMU_PLUGIN_INLINE_ADD_U64, track_insn, 1);
> +            qemu_plugin_register_vcpu_insn_exec_cond_cb(
> +                insn, every_insn_quantum,
> +                QEMU_PLUGIN_CB_NO_REGS, QEMU_PLUGIN_COND_GE,
> +                track_insn, insn_quantum, NULL);
> +        }
> +    } else {
> +        /* count (and eventually trap) once per tb */
> +        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
> +            tb, QEMU_PLUGIN_INLINE_ADD_U64, track_insn, n_insns);
> +        qemu_plugin_register_vcpu_tb_exec_cond_cb(
> +            tb, every_insn_quantum,
> +            QEMU_PLUGIN_CB_NO_REGS, QEMU_PLUGIN_COND_GE,
> +            track_insn, insn_quantum, NULL);
> +    }
> +}
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *udata)
> +{
> +    qemu_plugin_scoreboard_free(vcpus);
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info, int =
argc,
> +                                           char **argv)
> +{
> +    for (int i =3D 0; i < argc; i++) {
> +        char *opt =3D argv[i];
> +        g_auto(GStrv) tokens =3D g_strsplit(opt, "=3D", 2);
> +        if (g_strcmp0(tokens[0], "ips") =3D=3D 0) {
> +            insn_per_second =3D g_ascii_strtoull(tokens[1], NULL, 10);
> +            if (!insn_per_second && errno) {
> +                fprintf(stderr, "%s: couldn't parse %s (%s)\n",
> +                        __func__, tokens[1], g_strerror(errno));
> +                return -1;
> +            }
> +
> +        } else if (g_strcmp0(tokens[0], "precise") =3D=3D 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
> +                                        &precise_execution)) {
> +                fprintf(stderr, "boolean argument parsing failed: %s\n",=
 opt);
> +                return -1;
> +            }
> +        } else {
> +            fprintf(stderr, "option parsing failed: %s\n", opt);
> +            return -1;
> +        }
> +    }
> +
> +    vcpus =3D qemu_plugin_scoreboard_new(sizeof(vCPUTime));
> +    insn_quantum =3D insn_per_second / NUM_TIME_UPDATE_PER_SEC;
> +
> +    time_handle =3D qemu_plugin_request_time_control();
> +    g_assert(time_handle);
> +
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> +    qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
> +    qemu_plugin_register_vcpu_resume_cb(id, vcpu_resume);
> +    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +
> +    return 0;
> +}
> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
> index 0b64d2c1e3a..449ead11305 100644
> --- a/contrib/plugins/Makefile
> +++ b/contrib/plugins/Makefile
> @@ -27,6 +27,7 @@ endif
>  NAMES +=3D hwprofile
>  NAMES +=3D cache
>  NAMES +=3D drcov
> +NAMES +=3D ips
>=20=20
>  ifeq ($(CONFIG_WIN32),y)
>  SO_SUFFIX :=3D .dll

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

