Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB607D4320
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:16:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv48H-0003Hx-LU; Mon, 23 Oct 2023 19:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qv48E-0003HJ-LG
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:14:46 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qv48A-0005cR-Jv
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:14:46 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6cf65093780so583730a34.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698102879; x=1698707679; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vki+PwvM6WBl1v9u4Yr2DW2gzB/24iW4R+ksu60fHo=;
 b=beIaHblHDk+U11mNuLLQwK7V0i31Sbj8UIyzt9k/XUA157V+/K9Mssgovg1T1KYILC
 +6GZ+ROYTpiugAL3wG2mnm/XhIqdbsK/0Vf5+GJFqlXVZY20e1y2myUZ6jFkvvbepc6a
 qtIanRaDFNXb+VypsgLH3La8ZGseVfeFRXR8utjgP0h+RrQjFhVnQSN446VYa71USG9J
 I08U4YVmKQglQnBR6U4j9ZbiU/YwjbsadVQrMJw/w4/281RTLkNWLQfI/voWF204uCib
 ZgTA34zH/PMKhsyrLU4JFHDtlfg3VEQ69Ok2XKf/vsHWFO91OS9SJdqNLnCmGCReqCkl
 py8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698102879; x=1698707679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vki+PwvM6WBl1v9u4Yr2DW2gzB/24iW4R+ksu60fHo=;
 b=MSIIFr4KoDoqcAeveM5YA2GiAiijFo8pohkvg3Yt/v5mINRH7Txq57SlBN9R2tXv1w
 4VyBO8pBJiQUDPq8xd4Pa3/YfXGyFDOSg9VMtutbCUyJ7w+xyWIau2Wi8t3HTTE9LLHy
 13/Ad4CpjlJUc6j0CJOz518vAusxIkUWLwLKA1dO2A0ZwBDHHPQY//Jl24mfLaq5N/w9
 Nc0WdvOzmg4xR2tBAErhc1T1teE5SkiS4FQZL3P1Y8l8J50yFR69afWdd/XGPkjEqWa/
 Xv5Vs1HVFu4ZaesyxVXg9uN2vkpbWmiHeF5DCrG7V5X3QKpWRpye15hMIZ4Iu2Zgf/Bi
 12cg==
X-Gm-Message-State: AOJu0YzkziiIzssY+ajoiNr6pVYXasQzEEvkrhy+x6rzv6TvPi7r8tQV
 +3gki3HXH4fzHON5tRW6wYeJM/mg0hLDXAg/5ro=
X-Google-Smtp-Source: AGHT+IFA34sER9sEFN8tski9d8OSzBGc3T/29kAoYRcP7KsV9uyR5WFBKDfUzpYvX6la09ILFw2q1OXC9vS/YZwRIdM=
X-Received: by 2002:a9d:69cc:0:b0:6b7:43eb:c1a with SMTP id
 v12-20020a9d69cc000000b006b743eb0c1amr10837312oto.36.1698102879155; Mon, 23
 Oct 2023 16:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <878r7t482z.fsf@linaro.org>
In-Reply-To: <878r7t482z.fsf@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 23 Oct 2023 16:14:27 -0700
Message-ID: <CAJSP0QVjoS-8hLe+WoDkJ4AXd2_Q7d-p2JxgbacpiQi4VpHhaQ@mail.gmail.com>
Subject: Re: State of contrib/vhost-user-input?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leo Yan <leo.yan@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, 23 Oct 2023 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Hi,

CCing Gerd for vhost-user-input.

>
> I'm trying to get the contrib/vhost-user-input working but it exits
> during the boot up sequence:
>
>   =E2=9E=9C  gdb --args ./vhost-user-input -p /dev/input/event22 -s /tmp/=
mouse.sock
>   GNU gdb (GDB) 15.0.50.20231012-git
>   <snip>
>   Reading symbols from ./vhost-user-input...
>   (gdb) b map_ring
>   Breakpoint 1 at 0x7634c: file ../../subprojects/libvhost-user/libvhost-=
user.c, line 618.
>   (gdb) r
>   Starting program: /home/alex/lsrc/qemu.git/builds/arm.debug/contrib/vho=
st-user-input/vhost-user-input -p /dev/input/event22 -s /tmp/mouse.sock
>   [Thread debugging using libthread_db enabled]
>   Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.=
1".
>   [New Thread 0x7ffff7afb6c0 (LWP 3807698)]
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_FEATURES (1)
>   Flags:   0x1
>   Size:    0
>   Sending back to guest u64: 0x0000000175000000
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_PROTOCOL_FEATURES (15)
>   Flags:   0x1
>   Size:    0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_SET_PROTOCOL_FEATURES (16)
>   Flags:   0x1
>   Size:    8
>   u64: 0x0000000000008e2b
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_QUEUE_NUM (17)
>   Flags:   0x1
>   Size:    0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_MAX_MEM_SLOTS (36)
>   Flags:   0x1
>   Size:    0
>   u64: 0x0000000000000020
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_SET_BACKEND_REQ_FD (21)
>   Flags:   0x9
>   Size:    0
>   Fds: 6
>   Got backend_fd: 6
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_SET_OWNER (3)
>   Flags:   0x1
>   Size:    0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_FEATURES (1)
>   Flags:   0x1
>   Size:    0
>   Sending back to guest u64: 0x0000000175000000
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_SET_VRING_CALL (13)
>   Flags:   0x1
>   Size:    8
>   Fds: 7
>   u64: 0x0000000000000000
>   Got call_fd: 7 for vq: 0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_SET_VRING_ERR (14)
>   Flags:   0x1
>   Size:    8
>   Fds: 8
>   u64: 0x0000000000000000
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_SET_VRING_CALL (13)
>   Flags:   0x1
>   Size:    8
>   Fds: 9
>   u64: 0x0000000000000001
>   Got call_fd: 9 for vq: 1
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_SET_VRING_ERR (14)
>   Flags:   0x1
>   Size:    8
>   Fds: 10
>   u64: 0x0000000000000001
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_GET_CONFIG (24)
>   Flags:   0x1
>   Size:    148
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_SET_FEATURES (2)
>   Flags:   0x1
>   Size:    8
>   u64: 0x0000000170000000
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_SET_VRING_NUM (8)
>   Flags:   0x1
>   Size:    8
>   State.index: 0
>   State.num:   64
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_SET_VRING_BASE (10)
>   Flags:   0x1
>   Size:    8
>   State.index: 0
>   State.num:   0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_SET_VRING_ADDR (9)
>   Flags:   0x1
>   Size:    40
>   vhost_vring_addr:
>       index:  0
>       flags:  0
>       desc_user_addr:   0x00007f283491a000
>       used_user_addr:   0x00007f283491a4c0
>       avail_user_addr:  0x00007f283491a400
>       log_guest_addr:   0x0000000100b1a4c0
>
>   Thread 1 "vhost-user-inpu" hit Breakpoint 1, map_ring (dev=3D0x7fffffff=
dd60, vq=3D0x555555609ea0) at ../../subprojects/libvhost-user/libvhost-user=
.c:618
>   warning: Source file is more recent than executable.
>   618         vq->vring.desc =3D qva_to_va(dev, vq->vra.desc_user_addr);
>   (gdb) s
>   qva_to_va (dev=3D0x7fffffffdd60, qemu_addr=3D139810657378304) at ../../=
subprojects/libvhost-user/libvhost-user.c:231
>   231         for (i =3D 0; i < dev->nregions; i++) {
>   (gdb) p dev->nregions
>   $1 =3D 0
>   (gdb) n
>   240         return NULL;
>   (gdb)
>   241     }
>   (gdb) c
>   Continuing.
>   Setting virtq addresses:
>       vring_desc  at (nil)
>       vring_used  at (nil)
>       vring_avail at (nil)
>
>   ** (vhost-user-input:3807669): CRITICAL **: 17:16:14.554: Invalid vring=
_addr message
>
>   [Thread 0x7ffff7afb6c0 (LWP 3807698) exited]
>   [Inferior 1 (process 3807669) exited with code 01]
>   (gdb) q
>
> Which looks like libvhost-user is expecting
> VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS to be negotiated and the
> resulting VHOST_USER_ADD_MEM_REG to be sent. How is this meant to work
> if the protocol feature isn't negotiated?
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

