Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A807F8B14
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 14:09:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6sOl-0006EW-GO; Sat, 25 Nov 2023 08:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r6sOi-0006EL-HL
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 08:08:36 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r6sOg-0005kU-HJ
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 08:08:36 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-548d60a4d60so3655356a12.2
 for <qemu-devel@nongnu.org>; Sat, 25 Nov 2023 05:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700917712; x=1701522512; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9SiZ35P0cp5ELjkeKoQUh1yPXB0JWpm8dGVlFOLY+k=;
 b=f3FbpiHbuOoVeiooZZso3uenSEDeNBeNvcjjQTzXf7XIc68ZGtM7I9Wc5y3TlskZLb
 Cqyj91/lKx5LQmY+7vV+6R/iSoEAWijNesWwktqlakXJWasOPYoc9dJiST+6sQ2qm11U
 QASlhiqhG7eE3iE1kzUkhzRVUOluEhgOQJ+LZxiyEWor6CzkqGtYHbC+Rx6Nn3Si1VRA
 FloFQB79+CnAQ75xnhDDhmuONtB/BRKsJxo6OooMACqzyw2/IHQzHWXCRfeXXagwOgMG
 khGMq0eaxKXjzgAo99vhid594kv2tEWtvPDrtepFboUjFA4YlkoovmQK/pD2cKk27ArJ
 ToXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700917712; x=1701522512;
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F9SiZ35P0cp5ELjkeKoQUh1yPXB0JWpm8dGVlFOLY+k=;
 b=hYasXLaL5+SaBHue9XlOXpcB1fvqaHkV10BfZsi7mUjkIJzXGVwEFCidRpTaofzNv8
 ysYfWIXg5IMwNyQQwbHqN97s7jebgMM8u9yDCQcKI/A7fO85KH3k3JDArq0Y0CMXTsHx
 ONgm3k93wSW25f6WyRZRgtZxGKdTleCZw5rHCVlrPYQwMhu2DOHjBXRKf8AS5hh/m0cQ
 kmPD+W3jip0cZJ9TDhb8mwDfCJeov6mBwJntIqeD8YjwN5ZmRZcJhqHqSNnyHTeL6XHz
 ICFfbwfg10Pch+D7Sac/h7WviPtlKRzz33qwXF5zWIdL7kBs0NGMxefIA2LyT77Ktxb5
 FXSw==
X-Gm-Message-State: AOJu0Yy7immUWhQTR1smOYKjvnnLNk3tJbFIl+aqoFfPn+aIWzszC1UY
 kWMzqibNJ24HQtstXJaBS0dy+nR4n3U=
X-Google-Smtp-Source: AGHT+IH3KxtcAN/oak59o0V5YIWdvW9z56jo4O1gr1NoI2SSkavMJiQDqfzAneUB8QKStUqYTtUOjg==
X-Received: by 2002:a50:ed08:0:b0:54b:28e9:6886 with SMTP id
 j8-20020a50ed08000000b0054b28e96886mr1026673eds.3.1700917711800; 
 Sat, 25 Nov 2023 05:08:31 -0800 (PST)
Received: from ?IPV6:2001:1ae9:1e8:b200:ae52:b385:81fe:eeab?
 (2001-1ae9-1e8-b200-ae52-b385-81fe-eeab.ip6.tmcz.cz.
 [2001:1ae9:1e8:b200:ae52:b385:81fe:eeab])
 by smtp.gmail.com with ESMTPSA id
 d21-20020aa7d5d5000000b0054a8eeca8aasm2996380eds.39.2023.11.25.05.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Nov 2023 05:08:31 -0800 (PST)
Message-ID: <79bd7607-7590-4809-9412-7cf7276567d6@gmail.com>
Date: Sat, 25 Nov 2023 14:08:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, cs
From: Petr Cvek <petrcvekcz@gmail.com>
Subject: [BUG] accel/tcg: cpu_exec_longjmp_cleanup: assertion failed: (cpu ==
 current_cpu)
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=petrcvekcz@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

It seems there is a bug in SIGALRM handling when 486 system emulates x86_=
64 code.

This code:=20

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <signal.h>
#include <unistd.h>

pthread_t thread1, thread2;

// Signal handler for SIGALRM
void alarm_handler(int sig) {
    // Do nothing, just wake up the other thread
}

// Thread 1 function
void* thread1_func(void* arg) {
    // Set up the signal handler for SIGALRM
    signal(SIGALRM, alarm_handler);

    // Wait for 5 seconds
    sleep(1);

    // Send SIGALRM signal to thread 2
    pthread_kill(thread2, SIGALRM);

    return NULL;
}

// Thread 2 function
void* thread2_func(void* arg) {
    // Wait for the SIGALRM signal
    pause();

    printf("Thread 2 woke up!\n");

    return NULL;
}

int main() {
    // Create thread 1
    if (pthread_create(&thread1, NULL, thread1_func, NULL) !=3D 0) {
        fprintf(stderr, "Failed to create thread 1\n");
        return 1;
    }

    // Create thread 2
    if (pthread_create(&thread2, NULL, thread2_func, NULL) !=3D 0) {
        fprintf(stderr, "Failed to create thread 2\n");
        return 1;
    }

    // Wait for both threads to finish
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    return 0;
}


Fails with this -strace log (there are also unsupported syscalls 334 and =
435, but it seems it doesn't affect the code much):

=2E..
736 rt_sigaction(SIGALRM,0x000000001123ec20,0x000000001123ecc0) =3D 0
736 clock_nanosleep(CLOCK_REALTIME,0,{tv_sec =3D 1,tv_nsec =3D 0},{tv_sec=
 =3D 1,tv_nsec =3D 0})
736 rt_sigprocmask(SIG_BLOCK,0x00000000109fad20,0x0000000010800b38,8) =3D=
 0
736 Unknown syscall 435
736 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_=
SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID| ...
736 rt_sigprocmask(SIG_SETMASK,0x0000000010800b38,NULL,8)
736 set_robust_list(0x11a419a0,0) =3D -1 errno=3D38 (Function not impleme=
nted)
736 rt_sigprocmask(SIG_SETMASK,0x0000000011a41fb0,NULL,8) =3D 0
 =3D 0
736 pause(0,0,2,277186368,0,295966400)
736 futex(0x000000001123f990,FUTEX_CLOCK_REALTIME|FUTEX_WAIT_BITSET,738,N=
ULL,NULL,0) =3D 0
736 rt_sigprocmask(SIG_BLOCK,0x00000000109fad20,0x000000001123ee88,8) =3D=
 0
736 getpid() =3D 736
736 tgkill(736,739,SIGALRM) =3D 0
 =3D -1 errno=3D4 (Interrupted system call)
--- SIGALRM {si_signo=3DSIGALRM, si_code=3DSI_TKILL, si_pid=3D736, si_uid=
=3D0} ---
0x48874a !=3D 0x3c69e10
736 rt_sigprocmask(SIG_SETMASK,0x000000001123ee88,NULL,8) =3D 0
**
ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion fai=
led: (cpu =3D=3D current_cpu)
Bail out! ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: ass=
ertion failed: (cpu =3D=3D current_cpu)
0x48874a !=3D 0x3c69e10
**
ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion fai=
led: (cpu =3D=3D current_cpu)
Bail out! ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: ass=
ertion failed: (cpu =3D=3D current_cpu)
#=20

The code fails either with or without -singlestep, the command line:

/usr/bin/qemu-x86_64 -L /opt/x86_64 -strace -singlestep  /opt/x86_64/alar=
m.bin

Source code of QEMU 8.1.1 was modified with patch "[PATCH] qemu/timer: Do=
n't use RDTSC on i486" [1],=20
with added few ioctls (not relevant) and cpu_exec_longjmp_cleanup() now p=
rints current pointers of=20
cpu and current_cpu (line "0x48874a !=3D 0x3c69e10").

config.log (built as a part of buildroot, basically the minimal possible =
configuration for running x86_64 on 486):

# Configured with: '/mnt/hd_8tb_p1/p1/home/crossgen/buildroot_486_2/outpu=
t/build/qemu-8.1.1/configure' '--prefix=3D/usr' '--cross-prefix=3D/mnt/hd=
_8tb_p1/p1/home/crossgen/buildroot_486_2/output/host/bin/i486-buildroot-l=
inux-gnu-' '--audio-drv-list=3D' '--python=3D/mnt/hd_8tb_p1/p1/home/cross=
gen/buildroot_486_2/output/host/bin/python3' '--ninja=3D/mnt/hd_8tb_p1/p1=
/home/crossgen/buildroot_486_2/output/host/bin/ninja' '--disable-alsa' '-=
-disable-bpf' '--disable-brlapi' '--disable-bsd-user' '--disable-cap-ng' =
'--disable-capstone' '--disable-containers' '--disable-coreaudio' '--disa=
ble-curl' '--disable-curses' '--disable-dbus-display' '--disable-docs' '-=
-disable-dsound' '--disable-hvf' '--disable-jack' '--disable-libiscsi' '-=
-disable-linux-aio' '--disable-linux-io-uring' '--disable-malloc-trim' '-=
-disable-membarrier' '--disable-mpath' '--disable-netmap' '--disable-open=
gl' '--disable-oss' '--disable-pa' '--disable-rbd' '--disable-sanitizers'=
 '--disable-selinux' '--disable-sparse' '--disable-strip' '--disable-vde'=
 '--disable-vhost-crypto' '--disable-vhost-user-blk-server' '--disable-vi=
rtfs' '--disable-whpx' '--disable-xen' '--disable-attr' '--disable-kvm' '=
--disable-vhost-net' '--disable-download' '--disable-hexagon-idef-parser'=
 '--disable-system' '--enable-linux-user' '--target-list=3Dx86_64-linux-u=
ser' '--disable-vhost-user' '--disable-slirp' '--disable-sdl' '--disable-=
fdt' '--enable-trace-backends=3Dnop' '--disable-tools' '--disable-guest-a=
gent' '--disable-fuse' '--disable-fuse-lseek' '--disable-seccomp' '--disa=
ble-libssh' '--disable-libusb' '--disable-vnc' '--disable-nettle' '--disa=
ble-numa' '--disable-pipewire' '--disable-spice' '--disable-usb-redir' '-=
-disable-install-blobs'

Emulation of the same x86_64 code with qemu 6.2.0 installed on another x8=
6_64 native machine works fine.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg05387.htm=
l

Best regards,
Petr

