Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C64B7D5432
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 16:40:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvIYP-0001j6-QK; Tue, 24 Oct 2023 10:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvIYM-0001i5-Nc
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:38:42 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvIYK-00039w-NE
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:38:42 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c523ac38fbso67654761fa.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698158319; x=1698763119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3FeRuTW4WxOWZ4DJAIYgBLFmbGMbjfDq3iAhRA6fQM=;
 b=xNry1K8OOI8EIxnQ/aON5LOk/LHzt3NpCiaErHajKCpH98i/rGsA05EEiNwbka1iM+
 A+QF1X14nGuCXyuS6qpJQUdFunuD24kYsBp+WvjupiSDdv9HtrommoVN524efte9g7No
 fhEuJX5L1gzzqATW3ccc3m2vvbKfBpgslsw9tuYjxi5mHIAI3+gJKQaodp7TGT8qOhUb
 mrg/ugwRT17ffbtXPCLFGOJQ2HHukhXH3k3unXUn5yHeAScPLENoilBz2Xkbop+YuZzR
 aKXg1VSs6TumeqlW2m15nH4ACJDxgKM2X3zNh1mTnPIo+Zp/SL5fs4L6vyuIlAnl+QQL
 wzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698158319; x=1698763119;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W3FeRuTW4WxOWZ4DJAIYgBLFmbGMbjfDq3iAhRA6fQM=;
 b=VfEeHqzdAjquE6/GxWO7HNbdtjbDroJiBkiCi6tXfw0yYwdHNFNcHgFy/oSfWQmkM8
 d+0FyE1wl6sBoxL9VmVwBm5ZTNKyn52PQMqYJ3ft0JzSOS1AYVtJOd3it7F+ocAbB8cf
 jUfsRXpjvHYv+lBqT29g9T/TZohNnfdgcxGQaCKYz/44UqwvQtWl2tZp/RHVsGvI8SgC
 BuCquWDpWI8mgxHlySXOo0wZwFgWmjEpiHC6j0wrB5rd6RG+wX6bTzpIp7Cr0TIc9JoD
 abmrQYzNLrc+x+138jkIOM/hyO5GGJDUe7vfrR4Z2Mj5L4gB5r/xvZYWaj16Ba3FaFqE
 oI+Q==
X-Gm-Message-State: AOJu0Yz1T4xyDIbJbXwTU3KwGC/Laur9KriHYZsV3EJdAhbIRgdECZEi
 lR837wv6PZ5IpvdZ77moIcizeQ==
X-Google-Smtp-Source: AGHT+IFAuKakjAObzGzF2dfwI7bDfx1Zt63g5IYSs94vbrHm/M+xLsoB7t/2jVKz9ZuSnCPxS2xyBg==
X-Received: by 2002:a2e:905a:0:b0:2c5:50d:3fc3 with SMTP id
 n26-20020a2e905a000000b002c5050d3fc3mr8255251ljg.7.1698158318719; 
 Tue, 24 Oct 2023 07:38:38 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c228100b0040596352951sm16624391wmf.5.2023.10.24.07.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 07:38:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB56D1FFBB;
 Tue, 24 Oct 2023 15:38:37 +0100 (BST)
References: <878r7t482z.fsf@linaro.org>
 <CAMxuvaw8b6QEZO_Z_-ityoEOFPRuQ7D0pBVwK3BEKBNWX3S3KA@mail.gmail.com>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Leo Yan <leo.yan@linaro.org>, qemu-devel
 <qemu-devel@nongnu.org>
Subject: Re: State of contrib/vhost-user-input?
Date: Tue, 24 Oct 2023 15:32:07 +0100
In-reply-to: <CAMxuvaw8b6QEZO_Z_-ityoEOFPRuQ7D0pBVwK3BEKBNWX3S3KA@mail.gmail.com>
Message-ID: <87jzrc2ihe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
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


Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi Alex
>
> On Mon, Oct 23, 2023 at 8:34=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>>
>> Hi,
>>
>> I'm trying to get the contrib/vhost-user-input working but it exits
>> during the boot up sequence:
>>
>>   =E2=9E=9C  gdb --args ./vhost-user-input -p /dev/input/event22 -s /tmp=
/mouse.sock
>>   GNU gdb (GDB) 15.0.50.20231012-git
>>   <snip>
>>   Reading symbols from ./vhost-user-input...
>>   (gdb) b map_ring
>>   Breakpoint 1 at 0x7634c: file ../../subprojects/libvhost-user/libvhost=
-user.c, line 618.
>>   (gdb) r
>>   Starting program: /home/alex/lsrc/qemu.git/builds/arm.debug/contrib/vh=
ost-user-input/vhost-user-input -p /dev/input/event22 -s /tmp/mouse.sock
>>   [Thread debugging using libthread_db enabled]
>>   Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so=
.1".
>>   [New Thread 0x7ffff7afb6c0 (LWP 3807698)]
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_FEATURES (1)
>>   Flags:   0x1
>>   Size:    0
>>   Sending back to guest u64: 0x0000000175000000
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_PROTOCOL_FEATURES (15)
>>   Flags:   0x1
>>   Size:    0
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_SET_PROTOCOL_FEATURES (16)
>>   Flags:   0x1
>>   Size:    8
>>   u64: 0x0000000000008e2b
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_QUEUE_NUM (17)
>>   Flags:   0x1
>>   Size:    0
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_MAX_MEM_SLOTS (36)
>>   Flags:   0x1
>>   Size:    0
>>   u64: 0x0000000000000020
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_SET_BACKEND_REQ_FD (21)
>>   Flags:   0x9
>>   Size:    0
>>   Fds: 6
>>   Got backend_fd: 6
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_SET_OWNER (3)
>>   Flags:   0x1
>>   Size:    0
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_FEATURES (1)
>>   Flags:   0x1
>>   Size:    0
>>   Sending back to guest u64: 0x0000000175000000
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_SET_VRING_CALL (13)
>>   Flags:   0x1
>>   Size:    8
>>   Fds: 7
>>   u64: 0x0000000000000000
>>   Got call_fd: 7 for vq: 0
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_SET_VRING_ERR (14)
>>   Flags:   0x1
>>   Size:    8
>>   Fds: 8
>>   u64: 0x0000000000000000
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_SET_VRING_CALL (13)
>>   Flags:   0x1
>>   Size:    8
>>   Fds: 9
>>   u64: 0x0000000000000001
>>   Got call_fd: 9 for vq: 1
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_SET_VRING_ERR (14)
>>   Flags:   0x1
>>   Size:    8
>>   Fds: 10
>>   u64: 0x0000000000000001
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_GET_CONFIG (24)
>>   Flags:   0x1
>>   Size:    148
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_SET_FEATURES (2)
>>   Flags:   0x1
>>   Size:    8
>>   u64: 0x0000000170000000
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_SET_VRING_NUM (8)
>>   Flags:   0x1
>>   Size:    8
>>   State.index: 0
>>   State.num:   64
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_SET_VRING_BASE (10)
>>   Flags:   0x1
>>   Size:    8
>>   State.index: 0
>>   State.num:   0
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   Request: VHOST_USER_SET_VRING_ADDR (9)
>>   Flags:   0x1
>>   Size:    40
>>   vhost_vring_addr:
>>       index:  0
>>       flags:  0
>>       desc_user_addr:   0x00007f283491a000
>>       used_user_addr:   0x00007f283491a4c0
>>       avail_user_addr:  0x00007f283491a400
>>       log_guest_addr:   0x0000000100b1a4c0
>>
>>   Thread 1 "vhost-user-inpu" hit Breakpoint 1, map_ring (dev=3D0x7ffffff=
fdd60, vq=3D0x555555609ea0) at ../../subprojects/libvhost-user/libvhost-use=
r.c:618
>>   warning: Source file is more recent than executable.
>>   618         vq->vring.desc =3D qva_to_va(dev, vq->vra.desc_user_addr);
>>   (gdb) s
>>   qva_to_va (dev=3D0x7fffffffdd60, qemu_addr=3D139810657378304) at ../..=
/subprojects/libvhost-user/libvhost-user.c:231
>>   231         for (i =3D 0; i < dev->nregions; i++) {
>>   (gdb) p dev->nregions
>>   $1 =3D 0
>>   (gdb) n
>>   240         return NULL;
>>   (gdb)
>>   241     }
>>   (gdb) c
>>   Continuing.
>>   Setting virtq addresses:
>>       vring_desc  at (nil)
>>       vring_used  at (nil)
>>       vring_avail at (nil)
>>
>>   ** (vhost-user-input:3807669): CRITICAL **: 17:16:14.554: Invalid vrin=
g_addr message
>>
>>   [Thread 0x7ffff7afb6c0 (LWP 3807698) exited]
>>   [Inferior 1 (process 3807669) exited with code 01]
>>   (gdb) q
>>
>> Which looks like libvhost-user is expecting
>> VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS to be negotiated and the
>> resulting VHOST_USER_ADD_MEM_REG to be sent. How is this meant to work
>> if the protocol feature isn't negotiated?
>
>
> How did you start QEMU ? Did you forget to use shared memory ?

I had:

       -m 8192 \
       -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don \

Alongside:

       -device virtio-gpu-pci \
       -device qemu-xhci -device usb-kbd \
       -kernel ~/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image.gz -appe=
nd 'console=3DttyAMA0 root=3D/dev/sda2' \
       -display gtk,gl=3Don \
       -chardev socket,id=3Dmouse2,path=3D/tmp/mouse.sock -device vhost-use=
r-input-pci,chardev=3Dmouse2

I even double checked with the generic device I was working with:

       -chardev socket,id=3Dmouse2,path=3D/tmp/mouse.sock -device vhost-use=
r-device-pci,chardev=3Dmouse2,virtio-id=3D18,config_size=3D136,num_vqs=3D2

> We should probably add some error at QEMU level when vhost-user devices
> are used without shared memory!

That would certainly be a good idea.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

