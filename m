Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF324781C50
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:05:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXZfY-0001jb-Pg; Sun, 20 Aug 2023 00:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZfW-0001jT-Ov
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:04:02 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZfS-0003zs-2Z
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:04:02 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fe1b00fce2so3195579e87.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692504234; x=1693109034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sNEvcITXLWrRvuCWkyR+gShFhqNzMRuDU6uZwyClZJk=;
 b=5rH4HKKMrZdLaBwjhJYyRw+Q5b3ZjHVqlrTTKKOv79OsUEYgHTGYsMXPI5jYnslvZw
 Yeuo66zeYz/iI2+dQzmuTcJezBEnQM51Sl3hQ4QiBBQ5aMN8S41L0GeAnd2BBO2BTlYX
 Vh74WXAIcn1LEUyBvyylhJJq4IYMj8cIohiO1NpBvBvShTSacVQm0Cb0e9GJcd7KavD9
 4DHp7zVyOlL8bv2Q9Ok4wOQfUrjxmwFb0lRxt5UhrWev0s1WnYJSDoKJooL7l2YZ6bFk
 bJGVZo0REqOsyjw1HPDatjSG123F1eXO4pfxE5umODoXlUzbR2/+MlrZHYpgsyuvgbQi
 27sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692504234; x=1693109034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sNEvcITXLWrRvuCWkyR+gShFhqNzMRuDU6uZwyClZJk=;
 b=j7KN4b0t5RmINmHy3HNMqQRvyOdxth/wKmLWzfxzH2UWXwH0My95skgkTC+92PZ+DD
 nzKczV5xm7AoJhbq8vKnOFOK5rKnksEoJZ+ZqoViYJamkg+9pLDNaeSCSCSMTt/Z5MiP
 8yhnn83o3ZILih9K0o/pzZ5aQd+OxsfLPVRy1EZ8TrSE4+czlodHE7w3OEfD/R86zRDR
 /k0CVRVIDSG07JG0NcS091roB/PUezFjIr9IIry8zVCweLi01fGvIxvbHgbGCzrem6UP
 oU4QINPf+ojMIhbqHLdWCIGvfZ+von60Mqv03n2pBIlzhBFQ5wohzP7gkhPqW0RXvzU9
 pvJQ==
X-Gm-Message-State: AOJu0YyI6flBsXQeDVaNfst6a7cRTxwgQP2u8b06QiCs10X9lhAgG/ot
 bbPxYkfDSC27ef0HAX2K1TLBlZl2RhlLBrfaBbrvVA==
X-Google-Smtp-Source: AGHT+IGcqQPRLZyNTRqLCrO+dZgDHKk7T9Pgu6ZBWX2EB2dt47YEabSWQtD1y/JEqJHEOH3gehxdG9H2c/Qn/MeMwzk=
X-Received: by 2002:a19:791d:0:b0:4fe:347d:7c4b with SMTP id
 u29-20020a19791d000000b004fe347d7c4bmr1885546lfc.7.1692504233784; Sat, 19 Aug
 2023 21:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:03:46 -0600
Message-ID: <CANCZdfobR-qnOwC9V_SUVcbZG9dT2r4w8NYK2QT6AXBCXu4chw@mail.gmail.com>
Subject: Re: [PATCH v3 00/32] Implement the stat system calls for FreeBSD.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a2d53d060352d978"
Received-SPF: none client-ip=2a00:1450:4864:20::133;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x133.google.com
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

--000000000000a2d53d060352d978
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2023 at 1:43=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> Upstream the implementation of the stat system calls from the
> qemu-bsd-user fork, the following system calls are implemented:
> stat(2), lstat(2), fstat(2), fstatat(2), nstat, nfstat, nlstat
> getfh(2), lgetfh(2), fhopen(2), fhstat(2), fhstatfs(2), statfs(2)
> fstatfs(2), getfsstat(2), getdents(2), getdirentries(2), fcntl(2)
>

The changes themselves look good (although i had to apply
the safe_fcntl one by hand, it was trivial, but next time i'll ask
you to redo things).

I also needed to tweak the commit messages in three ways:
(1) I had to add 'bsd-user: ' to the front of the first line of each
of the commits (2) I had to reword a few of them to make them
unique and (3) I had to wrap the lines at 80 columns in a few
places. The best way to check on this is to make sure each
of the lines with 'git log --oneline master..' is different. Next
time I'll try to flag them at the review stage.

checkpatches.pl passes with minor warnings (all expected
and OK).

And these patches seem to match bsd-user fork blitz.

And my acceptance test works, so long as I don't add '-strace'
which hits this bug documented in strace.c:
                /* XXX: this format system is broken because it uses



                   host types and host pointers for strings */
and we pass a target address to a host to do a %s on...
Hopefully all that code will go away, but since this is a
pre-existing bug that you weren't trying to fix, this counts
as a pass. It doesn't fail in the obvious way due to another
bug in qemu-upstream bsd-user, that's fixed in the blitz branch
(it generates a segv, which isn't properly handled sometimes
in qemu upstream). I document it here for others that might
run into it in the future :).

I've queued them to the branch that I'll submit when things
open up...

Warner


> Karim Taha (1):
>   Add os-stat.c to the build
>
> Kyle Evans (2):
>   Disable clang warnings
>   Define safe_fcntl macro in bsd-user/syscall_defs.h
>
> Michal Meloun (8):
>   Add struct target_stat to bsd-user/syscall_defs.h
>   Add struct target_statfs to bsd-user/syscall_defs.h
>   Implement h2t_freebsd_stat and h2t_freebsd_statfs functions
>   Implement freebsd11 stat related syscalls
>   Implement freebsd11 stat related syscalls
>   Implement freebsd11 stat related syscalls
>   Implement freebsd11 stat related syscalls
>   Implement freebsd11 stat related syscalls
>
> Mika=C3=ABl Urankar (1):
>   Implement do_freebsd_realpathat syscall
>
> Stacey Son (13):
>   Declarations of h2t and t2h conversion functions.
>   Add struct target_freebsd11_stat to bsd-user/syscall_defs
>   Add structs target_freebsd11_nstat and target_freebsd11_statfs to
>     bsd-user/syscall_defs.h
>   Add struct target_freebsd_fhandle and fcntl flags to
>     bsd-user/syscall_defs.h
>   Implement h2t_freebsd11_stat h2t_freebsd_nstat
>   Implement h2t_freebsd_fhandle t2h_freebsd_fhandle functions
>   Implement h2t_freebds11_statfs
>   Implement target_to_host_fcntl_cmd
>   Implement stat related syscalls
>   Implement stat related syscalls
>   Implement stat related syscalls
>   Implement stat related syscalls
>   Implement stat related syscalls
>
> Warner Losh (7):
>   Move _WANT_FREEBSD macros to include/qemu/osdep.h
>   Update the definitions of __put_user and __get_user macros
>   Rename target_freebsd_time_t to target_time_t
>   Add glue to call the following syscalls to the freebsd_syscall
>     function:
>   Add glue to call the following syscalls to the freebsd_syscall
>     function:
>   Add glue to call the following syscalls to the freebsd_syscall
>     function:
>   Add glue to call the following syscalls to the freebsd_syscall
>     function:
>
>  bsd-user/freebsd/meson.build  |   1 +
>  bsd-user/freebsd/os-stat.c    | 262 ++++++++++++++
>  bsd-user/freebsd/os-stat.h    | 663 ++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 121 ++++++-
>  bsd-user/freebsd/qemu-os.h    |  50 +++
>  bsd-user/qemu.h               |  82 ++---
>  bsd-user/signal.c             |   5 +-
>  bsd-user/syscall_defs.h       | 221 +++++++++++-
>  include/qemu/compiler.h       |  30 ++
>  include/qemu/osdep.h          |  13 +
>  10 files changed, 1382 insertions(+), 66 deletions(-)
>  create mode 100644 bsd-user/freebsd/os-stat.c
>  create mode 100644 bsd-user/freebsd/os-stat.h
>  create mode 100644 bsd-user/freebsd/qemu-os.h
>
> --
> 2.40.0
>
>

--000000000000a2d53d060352d978
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Aug 13, 2023 at 1:43=E2=80=AF=
PM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Upstream the implementation of the stat system calls from the<br=
>
qemu-bsd-user fork, the following system calls are implemented:<br>
stat(2), lstat(2), fstat(2), fstatat(2), nstat, nfstat, nlstat<br>
getfh(2), lgetfh(2), fhopen(2), fhstat(2), fhstatfs(2), statfs(2)<br>
fstatfs(2), getfsstat(2), getdents(2), getdirentries(2), fcntl(2)<br></bloc=
kquote><div><br></div><div>The changes themselves look good (although i had=
 to apply</div><div>the safe_fcntl one by hand, it was trivial, but next ti=
me i&#39;ll ask</div><div>you to redo things).</div><div><br></div><div>I a=
lso needed to tweak the commit messages in three ways:</div><div>(1) I had =
to add &#39;bsd-user: &#39; to the front of the first line of each</div><di=
v>of the commits (2) I had to reword a few of them to make them</div><div>u=
nique and (3) I had to wrap the lines at 80 columns in a few</div><div>plac=
es. The best way to check on this is to make sure each</div><div>of the lin=
es with &#39;git log --oneline master..&#39; is different. Next</div><div>t=
ime I&#39;ll try to flag them at the review stage.<br></div><div><br></div>=
<div><a href=3D"http://checkpatches.pl">checkpatches.pl</a> passes with min=
or warnings (all expected</div><div>and OK).</div><div><br></div><div>And t=
hese patches seem to match bsd-user fork blitz.</div><div><br></div><div>An=
d my acceptance test works, so long as I don&#39;t add &#39;-strace&#39;</d=
iv><div>which hits this bug documented in strace.c:</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* XXX: this format system is br=
oken because it uses =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0host types and host pointers for strings */</div><div>a=
nd we pass a target address to a host to do a %s on... <br></div><div>Hopef=
ully all that code will go away, but since this is a</div><div>pre-existing=
 bug that you weren&#39;t trying to fix, this counts</div><div>as a pass. I=
t doesn&#39;t fail in the obvious way due to another</div><div>bug in qemu-=
upstream bsd-user, that&#39;s fixed in the blitz branch</div><div>(it gener=
ates a segv, which isn&#39;t properly handled sometimes</div><div>in qemu u=
pstream). I document it here for others that might</div><div>run into it in=
 the future :).<br></div><div><br></div><div>I&#39;ve queued them to the br=
anch that I&#39;ll submit when things</div><div>open up...</div><div><br></=
div><div>Warner<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
Karim Taha (1):<br>
=C2=A0 Add os-stat.c to the build<br>
<br>
Kyle Evans (2):<br>
=C2=A0 Disable clang warnings<br>
=C2=A0 Define safe_fcntl macro in bsd-user/syscall_defs.h<br>
<br>
Michal Meloun (8):<br>
=C2=A0 Add struct target_stat to bsd-user/syscall_defs.h<br>
=C2=A0 Add struct target_statfs to bsd-user/syscall_defs.h<br>
=C2=A0 Implement h2t_freebsd_stat and h2t_freebsd_statfs functions<br>
=C2=A0 Implement freebsd11 stat related syscalls<br>
=C2=A0 Implement freebsd11 stat related syscalls<br>
=C2=A0 Implement freebsd11 stat related syscalls<br>
=C2=A0 Implement freebsd11 stat related syscalls<br>
=C2=A0 Implement freebsd11 stat related syscalls<br>
<br>
Mika=C3=ABl Urankar (1):<br>
=C2=A0 Implement do_freebsd_realpathat syscall<br>
<br>
Stacey Son (13):<br>
=C2=A0 Declarations of h2t and t2h conversion functions.<br>
=C2=A0 Add struct target_freebsd11_stat to bsd-user/syscall_defs<br>
=C2=A0 Add structs target_freebsd11_nstat and target_freebsd11_statfs to<br=
>
=C2=A0 =C2=A0 bsd-user/syscall_defs.h<br>
=C2=A0 Add struct target_freebsd_fhandle and fcntl flags to<br>
=C2=A0 =C2=A0 bsd-user/syscall_defs.h<br>
=C2=A0 Implement h2t_freebsd11_stat h2t_freebsd_nstat<br>
=C2=A0 Implement h2t_freebsd_fhandle t2h_freebsd_fhandle functions<br>
=C2=A0 Implement h2t_freebds11_statfs<br>
=C2=A0 Implement target_to_host_fcntl_cmd<br>
=C2=A0 Implement stat related syscalls<br>
=C2=A0 Implement stat related syscalls<br>
=C2=A0 Implement stat related syscalls<br>
=C2=A0 Implement stat related syscalls<br>
=C2=A0 Implement stat related syscalls<br>
<br>
Warner Losh (7):<br>
=C2=A0 Move _WANT_FREEBSD macros to include/qemu/osdep.h<br>
=C2=A0 Update the definitions of __put_user and __get_user macros<br>
=C2=A0 Rename target_freebsd_time_t to target_time_t<br>
=C2=A0 Add glue to call the following syscalls to the freebsd_syscall<br>
=C2=A0 =C2=A0 function:<br>
=C2=A0 Add glue to call the following syscalls to the freebsd_syscall<br>
=C2=A0 =C2=A0 function:<br>
=C2=A0 Add glue to call the following syscalls to the freebsd_syscall<br>
=C2=A0 =C2=A0 function:<br>
=C2=A0 Add glue to call the following syscalls to the freebsd_syscall<br>
=C2=A0 =C2=A0 function:<br>
<br>
=C2=A0bsd-user/freebsd/meson.build=C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0bsd-user/freebsd/os-stat.c=C2=A0 =C2=A0 | 262 ++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-stat.h=C2=A0 =C2=A0 | 663 +++++++++++++++++++++++=
+++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 121 ++++++-<br>
=C2=A0bsd-user/freebsd/qemu-os.h=C2=A0 =C2=A0 |=C2=A0 50 +++<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 82 ++---<br>
=C2=A0bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A05 +-<br>
=C2=A0bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 221 +++++++++++-<=
br>
=C2=A0include/qemu/compiler.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 30 ++<br>
=C2=A0include/qemu/osdep.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 13 +<b=
r>
=C2=A010 files changed, 1382 insertions(+), 66 deletions(-)<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-stat.c<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-stat.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/qemu-os.h<br>
<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--000000000000a2d53d060352d978--

