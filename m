Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45807798289
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVDM-0002eN-Dh; Fri, 08 Sep 2023 02:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qeVD0-0002Yt-Es
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:43:16 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qeVCt-0001A7-H2
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:43:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso18727805e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694155383; x=1694760183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7LLsEoR2AyF4nBokP0NUiPf1uvD0ov7mz/3htwnB5E=;
 b=q4XwU4G7xs7oR0KP8qOzER8LPCgvjZ+gEjdEvNa0G+tMEHJmXHSWYEFbGuJ8CRuB1c
 5RIBJt8aHdVNMlc+vgehghS7Af0x3rP4K+OgigQdPEDtfY8LnGfVh6eSvuW7cniBgnS2
 28VazbR8PksWMPlQyEQ3fOsT3EX7x6yNFhNJFTZTKJvQLNTC/8WQFwZHd/lXtxFgk9+1
 W1hjKReSRxKjmS8H3b996waarUEyuMD/QSrAvcI/ucaMTDxol9dDyvgK+xPW2m0kbBQd
 ATvwyjDeAgWgsZPuflVsrCV96DWaAl0oBvg8hpZqQs3YhGGD3l2CSRid+74AtjlK1H/y
 PbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694155383; x=1694760183;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B7LLsEoR2AyF4nBokP0NUiPf1uvD0ov7mz/3htwnB5E=;
 b=SUHgC4rx4gTXHLqVLvWkTiUeOWLIRL0iHR466stV2Bmj3LcQ6kphsopomgiINbbU87
 3W9NsT81/fuD/lfo0UkBM7iGdb3dJeMF8vMGFf3ea466yqS1YlrO8cQxCOSPsPd15//o
 HkrmJXWgDrMmvsyeem4LpbqZYLN99snOsRqaG6xHt1iZzO9OpsD8llrHWxEm+7CVv2+k
 vstGZsW63uIGVSR9UaL4nGlnPU+CGO7q56tbSKLD1THg0aD+EaYDMWVYMTGcaURp6yg8
 6FeDFME56DPVbLeWHexZmZYyxOsWETJP+OM1Sbz6Och8cl+ly2dRxXlAC0TEfbswTQe9
 vuuw==
X-Gm-Message-State: AOJu0Yxai5UhfpepJ03VqUQERkr7Z0hkLiIxDH2UpNF2r8V6obfZ06HC
 NuoxBpWLydcS2RVU7bVQUF0CxQ==
X-Google-Smtp-Source: AGHT+IHKGEaNkXspxoYkNP41zKYJK2njXkan6EXwWxIYxtjIWgk1+WsiVx3lKTUZO9ym/VynTBXe7w==
X-Received: by 2002:adf:e189:0:b0:31a:dc27:dfd with SMTP id
 az9-20020adfe189000000b0031adc270dfdmr1517021wrb.6.1694155383146; 
 Thu, 07 Sep 2023 23:43:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y1-20020adff6c1000000b0031ad2663ed0sm1213712wrp.66.2023.09.07.23.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:43:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3DF751FFBB;
 Fri,  8 Sep 2023 07:43:02 +0100 (BST)
References: <20230901110018.3704459-1-alex.bennee@linaro.org>
 <CADSE00LiE6c8UhZ-KXTRuTc-yJQ==c=3teTcs8Wyx2k1CmUGQg@mail.gmail.com>
 <87y1hlgdl4.fsf@linaro.org> <20230907192913.GD1560640@fedora>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, slp@redhat.com, mst@redhat.com,
 marcandre.lureau@redhat.com, viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org,
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Subject: Re: [virtio-dev] [RFC PATCH v2] docs/interop: define PROBE feature
 for vhost-user VirtIO devices
Date: Fri, 08 Sep 2023 07:41:03 +0100
In-reply-to: <20230907192913.GD1560640@fedora>
Message-ID: <87h6o517yh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Tue, Sep 05, 2023 at 10:34:11AM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Albert Esteve <aesteve@redhat.com> writes:
>>=20
>> > This looks great! Thanks for this proposal.
>> >
>> > On Fri, Sep 1, 2023 at 1:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
>> >
>> >  Currently QEMU has to know some details about the VirtIO device
>> >  supported by a vhost-user daemon to be able to setup the guest. This
>> >  makes it hard for QEMU to add support for additional vhost-user
>> >  daemons without adding specific stubs for each additional VirtIO
>> >  device.
>> >
>> >  This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE)
>> >  which the back-end can advertise which allows a probe message to be
>> >  sent to get all the details QEMU needs to know in one message.
>> >
>> >  Together with the existing features VHOST_USER_PROTOCOL_F_STATUS and
>> >  VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
>> >  daemons which are capable of handling all aspects of the VirtIO
>> >  transactions with only a generic stub on the QEMU side. These daemons
>> >  can also be used without QEMU in situations where there isn't a full
>> >  VMM managing their setup.
>> >
>> >  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >
>> >  ---
>> >  v2
>> >    - dropped F_STANDALONE in favour of F_PROBE
>> >    - split probe details across several messages
>> >    - probe messages don't automatically imply a standalone daemon
>> >    - add wording where probe details interact (F_MQ/F_CONFIG)
>> >    - define VMM and make clear QEMU is only one of many potential VMMs
>> >    - reword commit message
>> >  ---
>> >   docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++++---=
--
>> >   hw/virtio/vhost-user.c      |  8 ++++
>> >   2 files changed, 88 insertions(+), 10 deletions(-)
>> >
>> >  diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> >  index 5a070adbc1..ba3b5e07b7 100644
>> >  --- a/docs/interop/vhost-user.rst
>> >  +++ b/docs/interop/vhost-user.rst
>> >  @@ -7,6 +7,7 @@ Vhost-user Protocol
>> >   ..
>> >     Copyright 2014 Virtual Open Systems Sarl.
>> >     Copyright 2019 Intel Corporation
>> >  +  Copyright 2023 Linaro Ltd
>> >     Licence: This work is licensed under the terms of the GNU GPL,
>> >              version 2 or later. See the COPYING file in the top-level
>> >              directory.
>> >  @@ -27,17 +28,31 @@ The protocol defines 2 sides of the communication=
, *front-end* and
>> >   *back-end*. The *front-end* is the application that shares its virtq=
ueues, in
>> >   our case QEMU. The *back-end* is the consumer of the virtqueues.
>> >
>> >  -In the current implementation QEMU is the *front-end*, and the *back=
-end*
>> >  -is the external process consuming the virtio queues, for example a
>> >  -software Ethernet switch running in user space, such as Snabbswitch,
>> >  -or a block device back-end processing read & write to a virtual
>> >  -disk. In order to facilitate interoperability between various back-e=
nd
>> >  -implementations, it is recommended to follow the :ref:`Backend progr=
am
>> >  -conventions <backend_conventions>`.
>> >  +In the current implementation a Virtual Machine Manager (VMM) such as
>> >  +QEMU is the *front-end*, and the *back-end* is the external process
>> >  +consuming the virtio queues, for example a software Ethernet switch
>> >  +running in user space, such as Snabbswitch, or a block device back-e=
nd
>> >  +processing read & write to a virtual disk. In order to facilitate
>> >  +interoperability between various back-end implementations, it is
>> >  +recommended to follow the :ref:`Backend program conventions
>> >  +<backend_conventions>`.
>> >
>> >   The *front-end* and *back-end* can be either a client (i.e. connecti=
ng) or
>> >   server (listening) in the socket communication.
>> >
>> >  +Probing device details
>> >  +----------------------
>> >  +
>> >  +Traditionally the vhost-user daemon *back-end* shares configuration
>> >  +responsibilities with the VMM *front-end* which needs to know certain
>> >  +key bits of information about the device. This means the VMM needs to
>> >  +define at least a minimal stub for each VirtIO device it wants to
>> >  +support. If the daemon supports the right set of protocol features t=
he
>> >  +VMM can probe the daemon for the information it needs to setup the
>> >  +device. See :ref:`Probing features for standalone daemons
>> >  +<probing_features>` for more details.
>> >  +
>> >  +
>> >   Support for platforms other than Linux
>> >   --------------------------------------
>> >
>> >  @@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
>> >   * ``VHOST_USER_GET_VRING_BASE``
>> >   * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD`=
`)
>> >   * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGH=
T_SHMFD``)
>> >  +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STAND=
ALONE``)
>> >
>> >   .. seealso::
>> >
>> >  @@ -396,9 +412,10 @@ must support changing some configuration aspects=
 on the fly.
>> >   Multiple queue support
>> >   ----------------------
>> >
>> >  -Many devices have a fixed number of virtqueues.  In this case the fr=
ont-end
>> >  -already knows the number of available virtqueues without communicati=
ng with the
>> >  -back-end.
>> >  +Many devices have a fixed number of virtqueues. In this case the
>> >  +*front-end* usually already knows the number of available virtqueues
>> >  +without communicating with the back-end. For standalone daemons this
>> >  +number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` messa=
ge.
>> >
>> >   Some devices do not have a fixed number of virtqueues.  Instead the =
maximum
>> >   number of virtqueues is chosen by the back-end.  The number can depe=
nd on host
>> >  @@ -885,6 +902,23 @@ Protocol features
>> >     #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>> >     #define VHOST_USER_PROTOCOL_F_STATUS               16
>> >     #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>> >  +  #define VHOST_USER_PROTOCOL_F_PROBE                18
>> >  +
>> >  +.. _probing_features:
>> >  +
>> >  +Probing features for standalone daemons
>> >  +---------------------------------------
>> >  +
>> >  +The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a number
>> >  +of additional messages which allow the *front-end* to probe details
>> >  +about the VirtIO device from the *back-end*. However for a *back-end*
>> >  +to be described as standalone it must also support:
>> >  +
>> >  +  * ``VHOST_USER_PROTOCOL_F_STATUS``
>> >  +  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)
>> >  +
>> >  +which are required to ensure the *back-end* daemon can operate
>> >  +without the *front-end* managing some aspects of its configuration.
>> >
>> >   Front-end message types
>> >   -----------------------
>> >  @@ -1440,6 +1474,42 @@ Front-end message types
>> >     query the back-end for its device status as defined in the Virtio
>> >     specification.
>> >
>> >  +``VHOST_USER_GET_DEVICE_ID``
>> >  +  :id: 41
>> >  +  :request payload: N/A
>> >  +  :reply payload: ``u32``
>> >  +
>> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
>> >  +  successfully negotiated, this message is submitted by the front-end
>> >  +  to query what VirtIO device the back-end support. This is intended
>> >  +  to remove the need for the front-end to know ahead of time what the
>> >  +  VirtIO device the backend emulates is.
>> >  +
>> >  +``VHOST_USER_GET_CONFIG_SIZE``
>> >  +  :id: 42
>> >  +  :request payload: N/A
>> >  +  :reply payload: ``u32``
>> >  +
>> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
>> >  +  successfully negotiated, this message is submitted by the front-end
>> >  +  to query the size of the VirtIO device's config space. This is
>> >  +  intended to remove the need for the front-end to know ahead of time
>> >  +  what the size is. Replying with 0 when
>> >  +  ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would indicate
>> >  +  an bug.
>> >  +
>> >  +``VHOST_USER_GET_MIN_VQ``
>> >  +  :id: 43
>> >  +  :request payload: N/A
>> >  +  :reply payload: ``u32``
>> >  +
>> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
>> >  +  successfully negotiated, this message is submitted by the front-en=
d to
>> >  +  query minimum number of VQ's required to support the device. A
>> >  +  device may support more than this number of VQ's if it advertises
>> >  +  the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting a
>> >  +  number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`` wou=
ld
>> >  +  indicate a bug.
>> >
>> > Maybe I lack some background, but not sure what min_vq is here?
>>=20
>> There will be a minimum number of queues you need to support the device.
>> For example the virtio-sound spec specifies you need four queues:
>> control, event, tx, rx
>
> I don't understand why the front-end needs to know that? The backend
> already reports the number of queues and not all of them need to be
> initialized by the driver.

But how many don't need to be initialised? We can't just skip:

    /* Allocate queues */
    vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
    for (int i =3D 0; i < vub->num_vqs; i++) {
        g_ptr_array_add(vub->vqs,
                        virtio_add_queue(vdev, vub->vq_size, vub_handle_out=
put));
    }

Or are you saying just require probe-able backends to support
VHOST_USER_PROTOCOL_F_MQ and have it always report the minimmum number
of queues if it is not a MQ capable device?

>> > This looks like quering the number of VQs the backend requires/uses.
>> > Which, in case of MQ, it may be bigger (which is where I assume comes =
the `min`
>> > part, if we consider `VHOST_USER_GET_QUEUE_NUM` the `max`).
>>=20
>> The MQ extension is currently used by networking but in theory any
>> device could attempt to parallelism by extending the number of virt
>> queues needed. So for net you get:
>>=20
>>   receiveq1
>>   transmitq1
>>   optional controlq
>>=20
>> So VHOST_USER_GET_MIN_VQ would report 2 or 3 (if VIRTIO_NET_F_CTRL_VQ is
>> negotiated).
>
> I'm confused. VHOST_USER_GET_MIN_VQ comes before VIRTIO Feature Bit
> negotiation (VIRTIO_NET_F_CTRL_VQ).
>
>> However VHOST_USER_GET_QUEUE_NUM is only usable if
>> VIRTIO_NET_F_MQ has been negotiated and could report more.
>
> I don't understand. This patch adds a new feature and it can require
> VHOST_USER_PROTOCOL_F_MQ. There are no existing back-ends that require
> backwards compatibility.
>
> Stefan


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

