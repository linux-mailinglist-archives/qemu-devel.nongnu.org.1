Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFF47AF957
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 06:27:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlM74-0004mn-Mq; Wed, 27 Sep 2023 00:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qlM6v-0004mc-JQ
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 00:25:18 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qlM6t-0006Bn-2w
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 00:25:17 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-533c8f8f91dso8877074a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 21:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695788712; x=1696393512;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ft0yljxfviLHAaT9q8afTcFLeMcgJ1AGTsYb4y2TLE=;
 b=QF209uuN43ZalvOrIruGOEKwOw+j613Spf+S7Y7Gg21Qssx4CgXp3Q93/7I1x0EEjV
 4/4+cH0+LTMuqGi5jxD5DcoTUhRK4AmcEjK895U7dZRGTpxCz2jTPFi648OmVeHPuypL
 Vl1T05ltYOc6JzswScQ3SWllzt3kiH5ZxDw7YAMzg0MRbWSxwMbN4s8ntEwinBja/zqj
 b2LAlP8jYI5CXcHIXw6zsDyfVPuRTUSF3d09Lkrb8B8fjab0/LAFAkEbrGCVrLWZWMVu
 IyXW1xWA0QNkJO+tFo8j7lNbao2owkfEU9Cmo6Zj1aENuVAQmrBtvM+MP1sZGdjjLT2E
 wD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695788712; x=1696393512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ft0yljxfviLHAaT9q8afTcFLeMcgJ1AGTsYb4y2TLE=;
 b=Y3tJliXfQZ8wgn3of3DXQIQR1CmsmnEIYwMlZqiiK2HjZZPMqhljCVRQW4ayybX7nH
 0+I6wQCMXoi8O8AXdvhMW5DQEHnlZSwmHnfA/8nWTS1QibeevDH49LrJL+H1XaXWc/q5
 RNspgVJAqTQBm9FJlIQxH+ebaq66N+JLSIBiAgu4YBA/mZ+RjbL1jArdOe5VbPjxgwDd
 KixW/mHtTTs6OJ8FY9mhPIP/nSO1SWnOcAzvbB4rDxkJWBPWb7ctfK3RHOc+bNG7xS4N
 GB6Ag9cqsD4QZ+NWnWMg7s3jxGL2i5Tu9Xe7CTiluWtanR7wugqKFulmO1DjiT9GOPJk
 k9ng==
X-Gm-Message-State: AOJu0YwKzNHUOoxDoxthavT0N8OSIHoSSm8Diw63yNI2TcgOTphH25Tq
 D5f4zmG2PMoG7jjYTdCQAfgnGR4jC0Xe4jZuG4oKIg==
X-Google-Smtp-Source: AGHT+IHiE83QCjH6PUq4i/2QMNdSpcqffthPrEHXa7uenb8/+uJo31OVLa1hu6JaPhPP9Vw5vjmzrxMjCF07iD+h5ao=
X-Received: by 2002:aa7:cd51:0:b0:533:efc3:91b6 with SMTP id
 v17-20020aa7cd51000000b00533efc391b6mr1070536edw.11.1695788712366; Tue, 26
 Sep 2023 21:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 26 Sep 2023 22:25:02 -0600
Message-ID: <CANCZdfo-BbsJwpZKwp6uZkwdE+HpUs0gs3bYAU0yiCvmWcTP5w@mail.gmail.com>
Subject: Re: [PATCH v5 00/28] bsd-user: Implement freebsd process related
 system calls.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d0a92906064f9367"
Received-SPF: none client-ip=2a00:1450:4864:20::530;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x530.google.com
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

--000000000000d0a92906064f9367
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 12:25=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

>
>
> Karim Taha (3):
>   bsd-user: define TARGET_RFSPAWN for rfork to use vfork(2) semantics,
>     and fix RLIM_INFINITY
>   bsd-user: Implement get_filename_from_fd.
>   bsd-user: Implement execve(2) and fexecve(2) system calls.
>
> Kyle Evans (1):
>   bsd-user: Get number of cpus.
>
> Stacey Son (24):
>   bsd-user: Define procctl(2) related structs
>   bsd-user: Implement host_to_target_siginfo.
>   bsd-user: Add freebsd_exec_common and do_freebsd_procctl to qemu.h.
>   bsd-user: add extern declarations for bsd-proc.c conversion functions
>   bsd-user: Implement target_to_host_resource conversion function
>   bsd-user: Implement target_to_host_rlim and host_to_target_rlim
>     conversion.
>   bsd-user: Implement host_to_target_rusage and host_to_target_wrusage.
>   bsd-user: Implement host_to_target_waitstatus conversion.
>   bsd-user: Implement getgroups(2) and setgroups(2) system calls.
>   bsd-user: Implement umask(2), setlogin(2) and getlogin(2)
>   bsd-user: Implement getrusage(2).
>   bsd-user: Implement getrlimit(2) and setrlimit(2)
>   bsd-user: Implement several get/set system calls:
>   bsd-user: Implement get/set[resuid/resgid/sid] and issetugid.
>   bsd-user: Add stubs for profil(2), ktrace(2), utrace(2) and ptrace(2).
>   bsd-user: Implement getpriority(2) and setpriority(2).
>   bsd-user: Implement freebsd_exec_common, used in implementing
>     execve/fexecve.
>   bsd-user: Implement procctl(2) along with necessary conversion
>     functions.
>   bsd-user: Implement wait4(2) and wait6(2) system calls.
>   bsd-user: Implement setloginclass(2) and getloginclass(2) system
>     calls.
>   bsd-user: Implement pdgetpid(2) and the undocumented setugid.
>   bsd-user: Implement fork(2) and vfork(2) system calls.
>   bsd-user: Implement rfork(2) system call.
>   bsd-user: Implement pdfork(2) system call.
>
>  bsd-user/bsd-proc.c           | 145 ++++++++++
>  bsd-user/bsd-proc.h           | 379 +++++++++++++++++++++++++++
>  bsd-user/freebsd/meson.build  |   1 +
>  bsd-user/freebsd/os-proc.c    | 479 ++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-proc.h    | 293 +++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 206 ++++++++++++++-
>  bsd-user/main.c               |   2 +-
>  bsd-user/meson.build          |   6 +
>  bsd-user/qemu-bsd.h           |  38 +++
>  bsd-user/qemu.h               |   7 +
>  bsd-user/signal-common.h      |   1 +
>  bsd-user/signal.c             |   6 +
>  bsd-user/syscall_defs.h       |  50 +++-
>  13 files changed, 1607 insertions(+), 6 deletions(-)
>  create mode 100644 bsd-user/bsd-proc.c
>  create mode 100644 bsd-user/freebsd/os-proc.c
>  create mode 100644 bsd-user/freebsd/os-proc.h
>  create mode 100644 bsd-user/qemu-bsd.h
>

queued to bsd-user-trial

--000000000000d0a92906064f9367
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 25, 2023 at 12:25=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><br>
<br>
Karim Taha (3):<br>
=C2=A0 bsd-user: define TARGET_RFSPAWN for rfork to use vfork(2) semantics,=
<br>
=C2=A0 =C2=A0 and fix RLIM_INFINITY<br>
=C2=A0 bsd-user: Implement get_filename_from_fd.<br>
=C2=A0 bsd-user: Implement execve(2) and fexecve(2) system calls.<br>
<br>
Kyle Evans (1):<br>
=C2=A0 bsd-user: Get number of cpus.<br>
<br>
Stacey Son (24):<br>
=C2=A0 bsd-user: Define procctl(2) related structs<br>
=C2=A0 bsd-user: Implement host_to_target_siginfo.<br>
=C2=A0 bsd-user: Add freebsd_exec_common and do_freebsd_procctl to qemu.h.<=
br>
=C2=A0 bsd-user: add extern declarations for bsd-proc.c conversion function=
s<br>
=C2=A0 bsd-user: Implement target_to_host_resource conversion function<br>
=C2=A0 bsd-user: Implement target_to_host_rlim and host_to_target_rlim<br>
=C2=A0 =C2=A0 conversion.<br>
=C2=A0 bsd-user: Implement host_to_target_rusage and host_to_target_wrusage=
.<br>
=C2=A0 bsd-user: Implement host_to_target_waitstatus conversion.<br>
=C2=A0 bsd-user: Implement getgroups(2) and setgroups(2) system calls.<br>
=C2=A0 bsd-user: Implement umask(2), setlogin(2) and getlogin(2)<br>
=C2=A0 bsd-user: Implement getrusage(2).<br>
=C2=A0 bsd-user: Implement getrlimit(2) and setrlimit(2)<br>
=C2=A0 bsd-user: Implement several get/set system calls:<br>
=C2=A0 bsd-user: Implement get/set[resuid/resgid/sid] and issetugid.<br>
=C2=A0 bsd-user: Add stubs for profil(2), ktrace(2), utrace(2) and ptrace(2=
).<br>
=C2=A0 bsd-user: Implement getpriority(2) and setpriority(2).<br>
=C2=A0 bsd-user: Implement freebsd_exec_common, used in implementing<br>
=C2=A0 =C2=A0 execve/fexecve.<br>
=C2=A0 bsd-user: Implement procctl(2) along with necessary conversion<br>
=C2=A0 =C2=A0 functions.<br>
=C2=A0 bsd-user: Implement wait4(2) and wait6(2) system calls.<br>
=C2=A0 bsd-user: Implement setloginclass(2) and getloginclass(2) system<br>
=C2=A0 =C2=A0 calls.<br>
=C2=A0 bsd-user: Implement pdgetpid(2) and the undocumented setugid.<br>
=C2=A0 bsd-user: Implement fork(2) and vfork(2) system calls.<br>
=C2=A0 bsd-user: Implement rfork(2) system call.<br>
=C2=A0 bsd-user: Implement pdfork(2) system call.<br>
<br>
=C2=A0bsd-user/bsd-proc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 145 +++=
+++++++<br>
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 379 +++=
++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/meson.build=C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0bsd-user/freebsd/os-proc.c=C2=A0 =C2=A0 | 479 +++++++++++++++++++++++=
+++++++++++<br>
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 293 +++++++++++++++++++++<b=
r>
=C2=A0bsd-user/freebsd/os-syscall.c | 206 ++++++++++++++-<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0bsd-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
6 +<br>
=C2=A0bsd-user/qemu-bsd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3=
8 +++<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A07 +<br>
=C2=A0bsd-user/signal-common.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A06 +<br>
=C2=A0bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 50 +++-<br>
=C2=A013 files changed, 1607 insertions(+), 6 deletions(-)<br>
=C2=A0create mode 100644 bsd-user/bsd-proc.c<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-proc.c<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-proc.h<br>
=C2=A0create mode 100644 bsd-user/qemu-bsd.h<br></blockquote><div><br></div=
><div>queued to bsd-user-trial <br></div></div></div>

--000000000000d0a92906064f9367--

