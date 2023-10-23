Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CEE7D3C7A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:29:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxmt-00061G-1d; Mon, 23 Oct 2023 12:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1quxmj-00060x-HJ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:28:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1quxmh-0004x4-Mj
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:28:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so29052445e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698078486; x=1698683286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:user-agent:from:to:cc:subject:date:message-id:reply-to;
 bh=naTE7Hy9ICRd+wxIu16V4jsm8CfjTcKLRXG90dWKMp4=;
 b=HZ8UbTCzNNCLzlZxex9bw/PPxxqQIIFRvntln9nrwHGQN5SiXePcTvpDqImzgsChXm
 Vn3kGDJcrYJ0kUSwsSt26v55aID5Z4LgekQD+7TO6WPafyI74RvOrRwojAgPXPpZ7HdN
 Sg+MMnpAYZfUALju9s7Li1+PWHUAWVki/OGd1tY9RWytCH2/uz2dPZB1X/ySr3JJ6Psr
 z/EbEd1MZRBLeoYvsq2g505mvKSq1NXxXWX1UVVRFSxvDN/yGjxcU1aRbIvlolDCRAMj
 P3Z12JcREzpt6eBldm2X9GTvMRfFtIBYRcZrnSn+cjN2jGmRYD/URIaMFpGqSLHPPhHe
 XbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698078486; x=1698683286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:user-agent:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naTE7Hy9ICRd+wxIu16V4jsm8CfjTcKLRXG90dWKMp4=;
 b=cvm3xQW1WdRqCRSt+Kyvj7F8B0oDpmQZ0st+uHucMcKBClZMqx1ViH204Gygg1Whhx
 5jYZKmVLPkjFzWVtjUcIll/EwtFiO3mZi6n2J7oBnGdW+t7AXLVWZRnZTXk1XbgiMIWI
 h1Nri6BhubLWmyigtbxV0HkZsxyDNmPxK2TP2/FB0B4+w63UAEuoOWRN181L8uCE0B7w
 PxS46+O8+MFLQnmOwmBFMIMW7xIGp7ZRdMP/QnDBjl5oZtBG2q0m6MFyfw9RKCjqOmKm
 oV5UDWZYA2zU56+0RFIy2GPuT4kzrw50ZM0fr4Uzg4nCR7MfE8g5Cm7zjwBKjpwMQrNR
 mGTg==
X-Gm-Message-State: AOJu0Yydvseh4GK9W+iVFLOQt4sTTAOIymp2HAJM6++yQgVuYBPfZ9wC
 nETRcT8v5yR+80nuX5USuSo3RQ==
X-Google-Smtp-Source: AGHT+IFvAT8mSvvzx91QdzLWcqBJWEN+//xNH+0JYAoC/z1zS5bf96inYyvMtBbmTelEr9F0yS1yyw==
X-Received: by 2002:a05:600c:5112:b0:408:57bb:ef96 with SMTP id
 o18-20020a05600c511200b0040857bbef96mr5716548wms.30.1698078485731; 
 Mon, 23 Oct 2023 09:28:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c4e0e00b0040607da271asm14644975wmq.31.2023.10.23.09.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:28:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E25381FFBB;
 Mon, 23 Oct 2023 17:28:04 +0100 (BST)
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, Michael S. Tsirkin <mst@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Subject: State of contrib/vhost-user-input?
Date: Mon, 23 Oct 2023 17:18:24 +0100
Message-ID: <878r7t482z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


Hi,

I'm trying to get the contrib/vhost-user-input working but it exits
during the boot up sequence:

  =E2=9E=9C  gdb --args ./vhost-user-input -p /dev/input/event22 -s /tmp/mo=
use.sock
  GNU gdb (GDB) 15.0.50.20231012-git
  <snip>
  Reading symbols from ./vhost-user-input...
  (gdb) b map_ring
  Breakpoint 1 at 0x7634c: file ../../subprojects/libvhost-user/libvhost-us=
er.c, line 618.
  (gdb) r
  Starting program: /home/alex/lsrc/qemu.git/builds/arm.debug/contrib/vhost=
-user-input/vhost-user-input -p /dev/input/event22 -s /tmp/mouse.sock
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
  [New Thread 0x7ffff7afb6c0 (LWP 3807698)]
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_FEATURES (1)
  Flags:   0x1
  Size:    0
  Sending back to guest u64: 0x0000000175000000
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_PROTOCOL_FEATURES (15)
  Flags:   0x1
  Size:    0
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_SET_PROTOCOL_FEATURES (16)
  Flags:   0x1
  Size:    8
  u64: 0x0000000000008e2b
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_QUEUE_NUM (17)
  Flags:   0x1
  Size:    0
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_MAX_MEM_SLOTS (36)
  Flags:   0x1
  Size:    0
  u64: 0x0000000000000020
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_SET_BACKEND_REQ_FD (21)
  Flags:   0x9
  Size:    0
  Fds: 6
  Got backend_fd: 6
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_SET_OWNER (3)
  Flags:   0x1
  Size:    0
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_FEATURES (1)
  Flags:   0x1
  Size:    0
  Sending back to guest u64: 0x0000000175000000
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_SET_VRING_CALL (13)
  Flags:   0x1
  Size:    8
  Fds: 7
  u64: 0x0000000000000000
  Got call_fd: 7 for vq: 0
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_SET_VRING_ERR (14)
  Flags:   0x1
  Size:    8
  Fds: 8
  u64: 0x0000000000000000
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_SET_VRING_CALL (13)
  Flags:   0x1
  Size:    8
  Fds: 9
  u64: 0x0000000000000001
  Got call_fd: 9 for vq: 1
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_SET_VRING_ERR (14)
  Flags:   0x1
  Size:    8
  Fds: 10
  u64: 0x0000000000000001
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_GET_CONFIG (24)
  Flags:   0x1
  Size:    148
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_SET_FEATURES (2)
  Flags:   0x1
  Size:    8
  u64: 0x0000000170000000
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_SET_VRING_NUM (8)
  Flags:   0x1
  Size:    8
  State.index: 0
  State.num:   64
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_SET_VRING_BASE (10)
  Flags:   0x1
  Size:    8
  State.index: 0
  State.num:   0
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Request: VHOST_USER_SET_VRING_ADDR (9)
  Flags:   0x1
  Size:    40
  vhost_vring_addr:
      index:  0
      flags:  0
      desc_user_addr:   0x00007f283491a000
      used_user_addr:   0x00007f283491a4c0
      avail_user_addr:  0x00007f283491a400
      log_guest_addr:   0x0000000100b1a4c0

  Thread 1 "vhost-user-inpu" hit Breakpoint 1, map_ring (dev=3D0x7fffffffdd=
60, vq=3D0x555555609ea0) at ../../subprojects/libvhost-user/libvhost-user.c=
:618
  warning: Source file is more recent than executable.
  618         vq->vring.desc =3D qva_to_va(dev, vq->vra.desc_user_addr);
  (gdb) s
  qva_to_va (dev=3D0x7fffffffdd60, qemu_addr=3D139810657378304) at ../../su=
bprojects/libvhost-user/libvhost-user.c:231
  231         for (i =3D 0; i < dev->nregions; i++) {
  (gdb) p dev->nregions
  $1 =3D 0
  (gdb) n
  240         return NULL;
  (gdb)
  241     }
  (gdb) c
  Continuing.
  Setting virtq addresses:
      vring_desc  at (nil)
      vring_used  at (nil)
      vring_avail at (nil)

  ** (vhost-user-input:3807669): CRITICAL **: 17:16:14.554: Invalid vring_a=
ddr message

  [Thread 0x7ffff7afb6c0 (LWP 3807698) exited]
  [Inferior 1 (process 3807669) exited with code 01]
  (gdb) q

Which looks like libvhost-user is expecting
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS to be negotiated and the
resulting VHOST_USER_ADD_MEM_REG to be sent. How is this meant to work
if the protocol feature isn't negotiated?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

