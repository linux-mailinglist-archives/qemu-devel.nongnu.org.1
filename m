Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C76E7D4F06
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 13:37:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvFif-0005eG-1D; Tue, 24 Oct 2023 07:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qvFic-0005e5-P4
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qvFia-0004IS-9y
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698147423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0N7aTYbTuxR8RTHWGf/XnnaNswoBqSLAQNC3i/OUYcw=;
 b=bHAi4Ww8U0bEPLt7BkUi+aOITH8Nd2PfCWqz8FdaKfyBL70GDIuPq78ZWB+x2NytLJyhJ7
 AVALCmxiwXXWgWiWO/T2/SAZdjGaEKma5GVgAfQmtBhcgb2pi0DXbQyxH0/mvRm59wavTJ
 lyB+Ac4r3FryKp85sZF+2dsRN8K+Ris=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-CXx2n57zMRWREoDgyq_0qw-1; Tue, 24 Oct 2023 07:37:01 -0400
X-MC-Unique: CXx2n57zMRWREoDgyq_0qw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50798a259c7so4321961e87.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 04:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698147420; x=1698752220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0N7aTYbTuxR8RTHWGf/XnnaNswoBqSLAQNC3i/OUYcw=;
 b=BqsF0Vu5aAaLuYb1Bii4oU80mXdbIbC/8Ou6Cwij5jEVXrXuE1MnQ/6OGmigOEV9wH
 WH9Uf9JO4TeNdtOz3AYgAUjJn4htfmkDikxEg0Vo0LSoydM/SunuctfnIjBA5X1k1z1t
 W6TO0B5jMg0b9VuiGk+k3k8E+JWtGp485vqQah47kd8y6f+WKkpQYYaB4W9IUQ6ME6S/
 BJ4fvV0gzjqs8AVtWuYav+vQFGLOk6eXrTpZliJbduz5JVLlJUGvnG5amABAwO8L53Bq
 +vN2jAxGiEJ/ChRw56UEALGlBM6Cqx8Eok1/CaM+sCX9sdKk6mha3g73n63nIiVhze2s
 m30w==
X-Gm-Message-State: AOJu0YyVMfZ1GuYOIrrpLqNZQ5X0RfKn9Dd6Y/lNadd81inxIfmAq0MU
 CpfzzWd71L/jyh4tP2FuYvanFOSIZkzrdKfHEtu4ULN8NvNZkn52QilPQGVNX2ZkbNh4zrIjycu
 Lci+D9HAwNUaGApv3/aV3wolAjuUJfNs=
X-Received: by 2002:a19:ae17:0:b0:507:c7cc:12d7 with SMTP id
 f23-20020a19ae17000000b00507c7cc12d7mr8138023lfc.4.1698147420340; 
 Tue, 24 Oct 2023 04:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9lFI6qGr69KSFj0mO2bxVDlqsz7fKEY4tgM8M3evH6OPt2xkPic2w13yZOAs41Du8yHZpW1rGjPVumaf9YFA=
X-Received: by 2002:a19:ae17:0:b0:507:c7cc:12d7 with SMTP id
 f23-20020a19ae17000000b00507c7cc12d7mr8138014lfc.4.1698147420002; Tue, 24 Oct
 2023 04:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <878r7t482z.fsf@linaro.org>
In-Reply-To: <878r7t482z.fsf@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 24 Oct 2023 15:36:48 +0400
Message-ID: <CAMxuvaw8b6QEZO_Z_-ityoEOFPRuQ7D0pBVwK3BEKBNWX3S3KA@mail.gmail.com>
Subject: Re: State of contrib/vhost-user-input?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Leo Yan <leo.yan@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Alex

On Mon, Oct 23, 2023 at 8:34=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
>
> Hi,
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


How did you start QEMU ? Did you forget to use shared memory ? We
should probably add some error at QEMU level when vhost-user devices
are used without shared memory!


