Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB4D7B69E2
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 15:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnf8g-0004GT-No; Tue, 03 Oct 2023 09:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnf8Z-0004FP-4k
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:08:31 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnf8X-0007y6-LB
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:08:30 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57bb0f5d00aso554995eaf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696338508; x=1696943308; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8AqUpc7x1XC4iM53qntn9MUGF1kqyxrEvTOtd8Lbz4A=;
 b=dLg5wAqwjFO6vqmFwf2znrXzw5RmHORBH4KbeyEOXUratmq5mM2/5fAzF6dC2nKh2u
 FhICmsdWvH8e2Sdo793Xr1j0AX7MXdKjtZAkEsw5FqdH6E9NUDEhmx+S26ruuaE3NMsm
 Eo2H9gtkn4i5/ZverARQEUKdnuZK6ML6HjbOlT2U0aBCVOMZIODotptQOdJPra8AOcOE
 2e4CJSA79ac9JwxKMVGtRq9UimVOoscO91xLj+4jOS4OJH790k0GAA+u8bBo3PZq7ZvI
 nZyIlT/kOPwTfzdJIohWLjVhJ0+2uak6O2pR4OGneguu+u8dHeKExTDzeBKHMgl9LdnV
 +k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696338508; x=1696943308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8AqUpc7x1XC4iM53qntn9MUGF1kqyxrEvTOtd8Lbz4A=;
 b=Pa2uYhiD4BHer8nOU0v9pHCPJaV2lZli2Uury3An+fJmE9ujP472l7hK3oPGn/3kiT
 Y42tgkwjNbfYkFJQz5fRWgK77Qlm/JLfaDCdjG2Qm8wJAxqrcPa53U4+KLefozhJzx9T
 8sGYULZadutXS6gVh/SfPVFfGbkOSBWLGPkQq9x1b0sFtToRy4YnImBkpFXNerP5r0N+
 KE3gw5bIeWoY36r88JmZiYAqvQwYUvCsO2p6D1e+IJu1D6J0/mFX5Qu8sigCl8X2I6Cc
 8Wh5MjcEibNb4oqTFV7xuT5ccznioEDBkKvUzO0huoH+QT3rZNN3sgQN7p1JNa3GPKw0
 VKug==
X-Gm-Message-State: AOJu0Yz5uCdDuTmIlfLhFeYoJx6ala7Ll53wtYJcmy9AnYvtoOWDP3W2
 H+sFh/34KjL3JWP2t5gSRelY34YA+m7blj18MRs=
X-Google-Smtp-Source: AGHT+IEWNRLxnl88VZACvLbABys/X1GInVsljx2xupqiW5pb2bTC7R+q8JEAUI3bhbksmgap1LGqTlgnwJbf4PzEfe0=
X-Received: by 2002:a4a:6c02:0:b0:56e:466c:7393 with SMTP id
 q2-20020a4a6c02000000b0056e466c7393mr13765697ooc.5.1696338508357; Tue, 03 Oct
 2023 06:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <20231002015259-mutt-send-email-mst@kernel.org>
 <CAJSP0QXgWsULW_61-MScvuWAiE3c4brYRyFc6q_==Sj6aLE8SQ@mail.gmail.com>
 <CAJSP0QU3jzFGnJ35Zbabf70Tbf+rPA_fvrA_eNxZ8TxOXQxZXA@mail.gmail.com>
 <20231002183627-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231002183627-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Oct 2023 09:08:15 -0400
Message-ID: <CAJSP0QWTRc6Ai+bM9_UwrpgXXmgvN=rMD248nqoGv0PiOd_2Sg@mail.gmail.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
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

On Tue, 3 Oct 2023 at 08:27, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 02, 2023 at 05:13:26PM -0400, Stefan Hajnoczi wrote:
> > One more question:
> >
> > Why is the disabled state not needed by regular (non-vhost) virtio-net devices?
>
> Tap does the same - it purges queued packets:
>
> int tap_disable(NetClientState *nc)
> {
>     TAPState *s = DO_UPCAST(TAPState, nc, nc);
>     int ret;
>
>     if (s->enabled == 0) {
>         return 0;
>     } else {
>         ret = tap_fd_disable(s->fd);
>         if (ret == 0) {
>             qemu_purge_queued_packets(nc);
>             s->enabled = false;
>             tap_update_fd_handler(s);
>         }
>         return ret;
>     }
> }

tap_disable() is not equivalent to the vhost-user "started but
disabled" ring state. tap_disable() is a synchronous one-time action,
while "started but disabled" is a continuous state.

The "started but disabled" ring state isn't needed to achieve this.
The back-end can just drop tx buffers upon receiving
VHOST_USER_SET_VRING_ENABLE .num=0.

The history of the spec is curious. VHOST_USER_SET_VRING_ENABLE was
introduced before the the "started but disabled" state was defined,
and it explicitly mentions tap attach/detach:

commit 7263a0ad7899994b719ebed736a1119cc2e08110
Author: Changchun Ouyang <changchun.ouyang@intel.com>
Date:   Wed Sep 23 12:20:01 2015 +0800

    vhost-user: add a new message to disable/enable a specific virt queue.

    Add a new message, VHOST_USER_SET_VRING_ENABLE, to enable or disable
    a specific virt queue, which is similar to attach/detach queue for
    tap device.

and then later:

commit c61f09ed855b5009f816242ce281fd01586d4646
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Mon Nov 23 12:48:52 2015 +0200

    vhost-user: clarify start and enable

>
> what about non tap backends? I suspect they just aren't
> used widely with multiqueue so no one noticed.

I still don't understand why "started but disabled" is needed instead
of just two ring states: enabled and disabled.

It seems like the cleanest path going forward is to keep the "ignore
rx, discard tx" semantics for virtio-net devices but to clarify in the
spec that other device types do not process the ring:

"
* started but disabled: the back-end must not process the ring. For legacy
  reasons there is an exception for the networking device, where the
  back-end must process and discard any TX packets and not process
  other rings.
"

What do you think?

Stefan

