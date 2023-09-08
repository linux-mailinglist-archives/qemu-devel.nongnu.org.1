Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F9798580
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 12:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYTN-000758-PU; Fri, 08 Sep 2023 06:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeYSw-0006s2-5o
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:11:57 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeYSe-0001QF-Tj
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:11:39 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-573249e73f8so1161052eaf.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694167895; x=1694772695; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dJXsh2h3f6ZvVNkFWwLgjtH7/xSeduXM+RKGt0gfYQ=;
 b=Xj48k1ZXnyXh3UayNF34OzdP6oWCNXPMO3nnDabndloiZzVzCD5rt8RO14wDQFEhYg
 t1apFaA+D1uf71apC9dZUO6MBAxhT6vlH590u2Cn20ICjlgRZHjs9e+54Gopdr83D+gU
 0tYKYfqbuyPGe/VbpTVb5y1t9DQ/GvOxpeCqGe2955drJfXTRarmcea9fUAjqF+MSOY2
 VYUGBZrMCGEulLPG2LyTHBIq+KErlXaAnNCvR72Jo9jhp6g4in6BKJgWtQS/b7C7qcgJ
 EaGdD4hKWeKW4/tn2TJwUGzHCdUVpEnjFoZdhAHdlOU877gepB/BNZ8XcMRMoPIkrPA7
 2/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694167895; x=1694772695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5dJXsh2h3f6ZvVNkFWwLgjtH7/xSeduXM+RKGt0gfYQ=;
 b=WP56Gh1db/9VxuSvAwmpfJdmNfMv/aM6Q8TWQpXl51TH48EYnPsA9UJbOk13xSuSFv
 TcZleXw4TKIPVLVjGUUiJdyIcEuHtT71A1ao09Iq/GL4+K7YWXRN3jX/sZ9x+X7Gi9tn
 /0GfDXEvUWvgJOmkjXZx/IZpyApeTYy1WBOvODjUOxMhdeIEfjl4lclVtbm63mMSzwTs
 7tXfQXeRKhDcf3ki9Ej0ueRorRJGQcmLcsZPLk/vJHGMv50GYKFoNfck8oMhDncEuYnn
 nHkY6hU2ExPZ1PCXvW26MhCJt1vetRszX6nsZrQ9W1QifbgwnWg7LVQ281dXLXlDsDQR
 ropQ==
X-Gm-Message-State: AOJu0YzWDOjuLH5PsrTZ82v4Xa3m98vLAXF6iWSR8C9fRmyqHQ4R1Hoa
 XisJ1w4hHXvaIWyV49eFYOoAfcSRDiKz/5Ww4M8=
X-Google-Smtp-Source: AGHT+IF0ONa5B+vlNDq3ECtKj10d5SdbY8FiUcMDiJKghoPREPvCtTN3ss1cdjKViAnI7ERJTb3hHIfCouNZX9ByU64=
X-Received: by 2002:a4a:d297:0:b0:571:28d5:2c72 with SMTP id
 h23-20020a4ad297000000b0057128d52c72mr1957726oos.7.1694167894710; Fri, 08 Sep
 2023 03:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230901110018.3704459-1-alex.bennee@linaro.org>
 <CADSE00LiE6c8UhZ-KXTRuTc-yJQ==c=3teTcs8Wyx2k1CmUGQg@mail.gmail.com>
 <87y1hlgdl4.fsf@linaro.org> <20230907192913.GD1560640@fedora>
 <87h6o517yh.fsf@linaro.org>
In-Reply-To: <87h6o517yh.fsf@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Sep 2023 06:11:22 -0400
Message-ID: <CAJSP0QW_ZFweKH5KTEyr61Scn7VL91+-PiTUfxkMwx8+ZmiU2w@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH v2] docs/interop: define PROBE feature
 for vhost-user VirtIO devices
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 slp@redhat.com, 
 mst@redhat.com, marcandre.lureau@redhat.com, viresh.kumar@linaro.org, 
 sgarzare@redhat.com, takahiro.akashi@linaro.org, erik.schilling@linaro.org, 
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org, 
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, 
 virtio-comment@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2d.google.com
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

On Fri, 8 Sept 2023 at 02:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>
> > On Tue, Sep 05, 2023 at 10:34:11AM +0100, Alex Benn=C3=A9e wrote:
> >>
> >> Albert Esteve <aesteve@redhat.com> writes:
> >>
> >> > This looks great! Thanks for this proposal.
> >> >
> >> > On Fri, Sep 1, 2023 at 1:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee=
@linaro.org> wrote:
> >> >
> >> >  Currently QEMU has to know some details about the VirtIO device
> >> >  supported by a vhost-user daemon to be able to setup the guest. Thi=
s
> >> >  makes it hard for QEMU to add support for additional vhost-user
> >> >  daemons without adding specific stubs for each additional VirtIO
> >> >  device.
> >> >
> >> >  This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE=
)
> >> >  which the back-end can advertise which allows a probe message to be
> >> >  sent to get all the details QEMU needs to know in one message.
> >> >
> >> >  Together with the existing features VHOST_USER_PROTOCOL_F_STATUS an=
d
> >> >  VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
> >> >  daemons which are capable of handling all aspects of the VirtIO
> >> >  transactions with only a generic stub on the QEMU side. These daemo=
ns
> >> >  can also be used without QEMU in situations where there isn't a ful=
l
> >> >  VMM managing their setup.
> >> >
> >> >  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> >
> >> >  ---
> >> >  v2
> >> >    - dropped F_STANDALONE in favour of F_PROBE
> >> >    - split probe details across several messages
> >> >    - probe messages don't automatically imply a standalone daemon
> >> >    - add wording where probe details interact (F_MQ/F_CONFIG)
> >> >    - define VMM and make clear QEMU is only one of many potential VM=
Ms
> >> >    - reword commit message
> >> >  ---
> >> >   docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++++-=
----
> >> >   hw/virtio/vhost-user.c      |  8 ++++
> >> >   2 files changed, 88 insertions(+), 10 deletions(-)
> >> >
> >> >  diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.=
rst
> >> >  index 5a070adbc1..ba3b5e07b7 100644
> >> >  --- a/docs/interop/vhost-user.rst
> >> >  +++ b/docs/interop/vhost-user.rst
> >> >  @@ -7,6 +7,7 @@ Vhost-user Protocol
> >> >   ..
> >> >     Copyright 2014 Virtual Open Systems Sarl.
> >> >     Copyright 2019 Intel Corporation
> >> >  +  Copyright 2023 Linaro Ltd
> >> >     Licence: This work is licensed under the terms of the GNU GPL,
> >> >              version 2 or later. See the COPYING file in the top-lev=
el
> >> >              directory.
> >> >  @@ -27,17 +28,31 @@ The protocol defines 2 sides of the communicati=
on, *front-end* and
> >> >   *back-end*. The *front-end* is the application that shares its vir=
tqueues, in
> >> >   our case QEMU. The *back-end* is the consumer of the virtqueues.
> >> >
> >> >  -In the current implementation QEMU is the *front-end*, and the *ba=
ck-end*
> >> >  -is the external process consuming the virtio queues, for example a
> >> >  -software Ethernet switch running in user space, such as Snabbswitc=
h,
> >> >  -or a block device back-end processing read & write to a virtual
> >> >  -disk. In order to facilitate interoperability between various back=
-end
> >> >  -implementations, it is recommended to follow the :ref:`Backend pro=
gram
> >> >  -conventions <backend_conventions>`.
> >> >  +In the current implementation a Virtual Machine Manager (VMM) such=
 as
> >> >  +QEMU is the *front-end*, and the *back-end* is the external proces=
s
> >> >  +consuming the virtio queues, for example a software Ethernet switc=
h
> >> >  +running in user space, such as Snabbswitch, or a block device back=
-end
> >> >  +processing read & write to a virtual disk. In order to facilitate
> >> >  +interoperability between various back-end implementations, it is
> >> >  +recommended to follow the :ref:`Backend program conventions
> >> >  +<backend_conventions>`.
> >> >
> >> >   The *front-end* and *back-end* can be either a client (i.e. connec=
ting) or
> >> >   server (listening) in the socket communication.
> >> >
> >> >  +Probing device details
> >> >  +----------------------
> >> >  +
> >> >  +Traditionally the vhost-user daemon *back-end* shares configuratio=
n
> >> >  +responsibilities with the VMM *front-end* which needs to know cert=
ain
> >> >  +key bits of information about the device. This means the VMM needs=
 to
> >> >  +define at least a minimal stub for each VirtIO device it wants to
> >> >  +support. If the daemon supports the right set of protocol features=
 the
> >> >  +VMM can probe the daemon for the information it needs to setup the
> >> >  +device. See :ref:`Probing features for standalone daemons
> >> >  +<probing_features>` for more details.
> >> >  +
> >> >  +
> >> >   Support for platforms other than Linux
> >> >   --------------------------------------
> >> >
> >> >  @@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
> >> >   * ``VHOST_USER_GET_VRING_BASE``
> >> >   * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMF=
D``)
> >> >   * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLI=
GHT_SHMFD``)
> >> >  +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STA=
NDALONE``)
> >> >
> >> >   .. seealso::
> >> >
> >> >  @@ -396,9 +412,10 @@ must support changing some configuration aspec=
ts on the fly.
> >> >   Multiple queue support
> >> >   ----------------------
> >> >
> >> >  -Many devices have a fixed number of virtqueues.  In this case the =
front-end
> >> >  -already knows the number of available virtqueues without communica=
ting with the
> >> >  -back-end.
> >> >  +Many devices have a fixed number of virtqueues. In this case the
> >> >  +*front-end* usually already knows the number of available virtqueu=
es
> >> >  +without communicating with the back-end. For standalone daemons th=
is
> >> >  +number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` mes=
sage.
> >> >
> >> >   Some devices do not have a fixed number of virtqueues.  Instead th=
e maximum
> >> >   number of virtqueues is chosen by the back-end.  The number can de=
pend on host
> >> >  @@ -885,6 +902,23 @@ Protocol features
> >> >     #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
> >> >     #define VHOST_USER_PROTOCOL_F_STATUS               16
> >> >     #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> >> >  +  #define VHOST_USER_PROTOCOL_F_PROBE                18
> >> >  +
> >> >  +.. _probing_features:
> >> >  +
> >> >  +Probing features for standalone daemons
> >> >  +---------------------------------------
> >> >  +
> >> >  +The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a num=
ber
> >> >  +of additional messages which allow the *front-end* to probe detail=
s
> >> >  +about the VirtIO device from the *back-end*. However for a *back-e=
nd*
> >> >  +to be described as standalone it must also support:
> >> >  +
> >> >  +  * ``VHOST_USER_PROTOCOL_F_STATUS``
> >> >  +  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)
> >> >  +
> >> >  +which are required to ensure the *back-end* daemon can operate
> >> >  +without the *front-end* managing some aspects of its configuration=
.
> >> >
> >> >   Front-end message types
> >> >   -----------------------
> >> >  @@ -1440,6 +1474,42 @@ Front-end message types
> >> >     query the back-end for its device status as defined in the Virti=
o
> >> >     specification.
> >> >
> >> >  +``VHOST_USER_GET_DEVICE_ID``
> >> >  +  :id: 41
> >> >  +  :request payload: N/A
> >> >  +  :reply payload: ``u32``
> >> >  +
> >> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has be=
en
> >> >  +  successfully negotiated, this message is submitted by the front-=
end
> >> >  +  to query what VirtIO device the back-end support. This is intend=
ed
> >> >  +  to remove the need for the front-end to know ahead of time what =
the
> >> >  +  VirtIO device the backend emulates is.
> >> >  +
> >> >  +``VHOST_USER_GET_CONFIG_SIZE``
> >> >  +  :id: 42
> >> >  +  :request payload: N/A
> >> >  +  :reply payload: ``u32``
> >> >  +
> >> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has be=
en
> >> >  +  successfully negotiated, this message is submitted by the front-=
end
> >> >  +  to query the size of the VirtIO device's config space. This is
> >> >  +  intended to remove the need for the front-end to know ahead of t=
ime
> >> >  +  what the size is. Replying with 0 when
> >> >  +  ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would indic=
ate
> >> >  +  an bug.
> >> >  +
> >> >  +``VHOST_USER_GET_MIN_VQ``
> >> >  +  :id: 43
> >> >  +  :request payload: N/A
> >> >  +  :reply payload: ``u32``
> >> >  +
> >> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has be=
en
> >> >  +  successfully negotiated, this message is submitted by the front-=
end to
> >> >  +  query minimum number of VQ's required to support the device. A
> >> >  +  device may support more than this number of VQ's if it advertise=
s
> >> >  +  the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting a
> >> >  +  number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`` w=
ould
> >> >  +  indicate a bug.
> >> >
> >> > Maybe I lack some background, but not sure what min_vq is here?
> >>
> >> There will be a minimum number of queues you need to support the devic=
e.
> >> For example the virtio-sound spec specifies you need four queues:
> >> control, event, tx, rx
> >
> > I don't understand why the front-end needs to know that? The backend
> > already reports the number of queues and not all of them need to be
> > initialized by the driver.
>
> But how many don't need to be initialised? We can't just skip:
>
>     /* Allocate queues */
>     vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
>     for (int i =3D 0; i < vub->num_vqs; i++) {
>         g_ptr_array_add(vub->vqs,
>                         virtio_add_queue(vdev, vub->vq_size, vub_handle_o=
utput));
>     }
>
> Or are you saying just require probe-able backends to support
> VHOST_USER_PROTOCOL_F_MQ and have it always report the minimmum number
> of queues if it is not a MQ capable device?

The front-end should prepare to allow the maximum number of virtqueues
returned by VHOST_USER_GET_QUEUE_NUM (VHOST_USER_PROTOCOL_F_MQ).

VIRTIO Transports have a way to query the maximum number of queues but
not a way to query the minimum number of queues. Why is the minimum
necessary?

Stefan

>
> >> > This looks like quering the number of VQs the backend requires/uses.
> >> > Which, in case of MQ, it may be bigger (which is where I assume come=
s the `min`
> >> > part, if we consider `VHOST_USER_GET_QUEUE_NUM` the `max`).
> >>
> >> The MQ extension is currently used by networking but in theory any
> >> device could attempt to parallelism by extending the number of virt
> >> queues needed. So for net you get:
> >>
> >>   receiveq1
> >>   transmitq1
> >>   optional controlq
> >>
> >> So VHOST_USER_GET_MIN_VQ would report 2 or 3 (if VIRTIO_NET_F_CTRL_VQ =
is
> >> negotiated).
> >
> > I'm confused. VHOST_USER_GET_MIN_VQ comes before VIRTIO Feature Bit
> > negotiation (VIRTIO_NET_F_CTRL_VQ).
> >
> >> However VHOST_USER_GET_QUEUE_NUM is only usable if
> >> VIRTIO_NET_F_MQ has been negotiated and could report more.
> >
> > I don't understand. This patch adds a new feature and it can require
> > VHOST_USER_PROTOCOL_F_MQ. There are no existing back-ends that require
> > backwards compatibility.
> >
> > Stefan
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

