Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA6D79872D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:40:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeal7-0005ss-Hf; Fri, 08 Sep 2023 08:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeal5-0005s8-6R
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:38:47 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeal2-00031R-7S
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:38:46 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-573249e73f8so1228150eaf.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694176722; x=1694781522; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmer+ov8lKRXRX+UMJ/9BG0zW253MEHSJwuRVFdpQXU=;
 b=FOMLzG3BCRfg4RrYvRnqHhCcuNYJ96C2inLNrfbXMrfoZsiEEN6Y4xza4Eu+NPkIxn
 9Q3XOQcjYaOOgNXNyXRfCgaVtRO0pakH4PfX+smW/a3l5Ze7oAX66DMluMB1xHeGaj+1
 RCeR6atOCMRyQjpV74agzvIu6c5wGCPNhstkMMdIupRJ6/XHIyBcDBgrzsopkoCHpZrr
 gbMeg2BnuY4PXFmyLmtOo6CuNFSbcqD3rLpzpDe2fF0cFjPQWvnCG4EQ7vCsdhUMAPGr
 Iy64Os5c1tERx9wt0JXmzzeTjLonRUOKWkWs263nlzB+8rn+fZp/r1cHrRIrC8xnWo0R
 wLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694176722; x=1694781522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmer+ov8lKRXRX+UMJ/9BG0zW253MEHSJwuRVFdpQXU=;
 b=fHEQwQP9JxKW9U59BViR/te+xfAOrb9B4j8xj6w2fqgMwatU7x2F/DDXhJUFVAohmk
 Pit7srNdo5aP+P9fIdKELf5LtVbPu3tixcjYCKueygBJR+Nub8qYCTs2WN/zk4rt69qz
 Qg04126V04e3osuqKAMFx7z412NVofKS3/L5TlHBpUufkTjAgUAq+63d6J6vQpmopIRK
 omyr4Z4l5HTOOxqkuCfQHo4VxwSqnQ9ILvhdiLVHwnhC/uM/xXldAbI3kaoWJCJ2hq+d
 Tnc1VORLrL3O+Zi5AbAb8FXuV/BeDhUtLpE4sV0o65PYx9kJKoxSi47WHzK2uVtB9Rge
 cXFA==
X-Gm-Message-State: AOJu0YzE0u/WBuGqGXFlYP5OHfquiqLdQRE+QuZjqG+kdgftMEUA7X1t
 awp9/8O3Md7+D+AtenchXNn5VbNuVybKycAZ8OE=
X-Google-Smtp-Source: AGHT+IGsH2boqGuKW6B/P/hZYQAkIMLQ1KSdVS5ZUkfVNIBQvhC7IWX4fAQFEyepj4oq9FzQBScQWVrhZiMO/DGiNYI=
X-Received: by 2002:a05:6870:f225:b0:1ba:2a58:b15e with SMTP id
 t37-20020a056870f22500b001ba2a58b15emr2796470oao.2.1694176722245; Fri, 08 Sep
 2023 05:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230901110018.3704459-1-alex.bennee@linaro.org>
 <CADSE00LiE6c8UhZ-KXTRuTc-yJQ==c=3teTcs8Wyx2k1CmUGQg@mail.gmail.com>
 <87y1hlgdl4.fsf@linaro.org> <20230907192913.GD1560640@fedora>
 <87h6o517yh.fsf@linaro.org>
 <CAJSP0QW_ZFweKH5KTEyr61Scn7VL91+-PiTUfxkMwx8+ZmiU2w@mail.gmail.com>
 <87zg1wzxca.fsf@linaro.org>
In-Reply-To: <87zg1wzxca.fsf@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Sep 2023 08:38:29 -0400
Message-ID: <CAJSP0QU14SCCTMbL3WC-A00-=HV1wV-=my5nVXDSzMncbB5Mig@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2b.google.com
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

A QEMU built-in VIRTIO device will also call virtio_add_queue() for
the maximum number of virtqueues.

I'm not sure what the concern is about adding as few virtqueues as possible=
?

If the front-end's implementation is inefficient, then it should be
optimized so that untouched virtqueues don't consume resources. I
don't see the need to try to add a special message to vhost-user to
try to reduce the number of virtqueues.

Stefan

On Fri, 8 Sept 2023 at 08:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
> > On Fri, 8 Sept 2023 at 02:43, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >>
> >> Stefan Hajnoczi <stefanha@redhat.com> writes:
> >>
> >> > On Tue, Sep 05, 2023 at 10:34:11AM +0100, Alex Benn=C3=A9e wrote:
> >> >>
> >> >> Albert Esteve <aesteve@redhat.com> writes:
> >> >>
> >> >> > This looks great! Thanks for this proposal.
> >> >> >
> >> >> > On Fri, Sep 1, 2023 at 1:00=E2=80=AFPM Alex Benn=C3=A9e <alex.ben=
nee@linaro.org> wrote:
> >> >> >
> >> >> >  Currently QEMU has to know some details about the VirtIO device
> >> >> >  supported by a vhost-user daemon to be able to setup the guest. =
This
> >> >> >  makes it hard for QEMU to add support for additional vhost-user
> >> >> >  daemons without adding specific stubs for each additional VirtIO
> >> >> >  device.
> >> >> >
> >> >> >  This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PR=
OBE)
> >> >> >  which the back-end can advertise which allows a probe message to=
 be
> >> >> >  sent to get all the details QEMU needs to know in one message.
> >> >> >
> >> >> >  Together with the existing features VHOST_USER_PROTOCOL_F_STATUS=
 and
> >> >> >  VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-us=
er
> >> >> >  daemons which are capable of handling all aspects of the VirtIO
> >> >> >  transactions with only a generic stub on the QEMU side. These da=
emons
> >> >> >  can also be used without QEMU in situations where there isn't a =
full
> >> >> >  VMM managing their setup.
> >> >> >
> >> >> >  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> >> >
> >> >> >  ---
> >> >> >  v2
> >> >> >    - dropped F_STANDALONE in favour of F_PROBE
> >> >> >    - split probe details across several messages
> >> >> >    - probe messages don't automatically imply a standalone daemon
> >> >> >    - add wording where probe details interact (F_MQ/F_CONFIG)
> >> >> >    - define VMM and make clear QEMU is only one of many potential=
 VMMs
> >> >> >    - reword commit message
> >> >> >  ---
> >> >> >   docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++=
++-----
> >> >> >   hw/virtio/vhost-user.c      |  8 ++++
> >> >> >   2 files changed, 88 insertions(+), 10 deletions(-)
> >> >> >
> >> >> >  diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-us=
er.rst
> >> >> >  index 5a070adbc1..ba3b5e07b7 100644
> >> >> >  --- a/docs/interop/vhost-user.rst
> >> >> >  +++ b/docs/interop/vhost-user.rst
> >> >> >  @@ -7,6 +7,7 @@ Vhost-user Protocol
> >> >> >   ..
> >> >> >     Copyright 2014 Virtual Open Systems Sarl.
> >> >> >     Copyright 2019 Intel Corporation
> >> >> >  +  Copyright 2023 Linaro Ltd
> >> >> >     Licence: This work is licensed under the terms of the GNU GPL=
,
> >> >> >              version 2 or later. See the COPYING file in the top-=
level
> >> >> >              directory.
> >> >> >  @@ -27,17 +28,31 @@ The protocol defines 2 sides of the communic=
ation, *front-end* and
> >> >> >   *back-end*. The *front-end* is the application that shares its =
virtqueues, in
> >> >> >   our case QEMU. The *back-end* is the consumer of the virtqueues=
.
> >> >> >
> >> >> >  -In the current implementation QEMU is the *front-end*, and the =
*back-end*
> >> >> >  -is the external process consuming the virtio queues, for exampl=
e a
> >> >> >  -software Ethernet switch running in user space, such as Snabbsw=
itch,
> >> >> >  -or a block device back-end processing read & write to a virtual
> >> >> >  -disk. In order to facilitate interoperability between various b=
ack-end
> >> >> >  -implementations, it is recommended to follow the :ref:`Backend =
program
> >> >> >  -conventions <backend_conventions>`.
> >> >> >  +In the current implementation a Virtual Machine Manager (VMM) s=
uch as
> >> >> >  +QEMU is the *front-end*, and the *back-end* is the external pro=
cess
> >> >> >  +consuming the virtio queues, for example a software Ethernet sw=
itch
> >> >> >  +running in user space, such as Snabbswitch, or a block device b=
ack-end
> >> >> >  +processing read & write to a virtual disk. In order to facilita=
te
> >> >> >  +interoperability between various back-end implementations, it i=
s
> >> >> >  +recommended to follow the :ref:`Backend program conventions
> >> >> >  +<backend_conventions>`.
> >> >> >
> >> >> >   The *front-end* and *back-end* can be either a client (i.e. con=
necting) or
> >> >> >   server (listening) in the socket communication.
> >> >> >
> >> >> >  +Probing device details
> >> >> >  +----------------------
> >> >> >  +
> >> >> >  +Traditionally the vhost-user daemon *back-end* shares configura=
tion
> >> >> >  +responsibilities with the VMM *front-end* which needs to know c=
ertain
> >> >> >  +key bits of information about the device. This means the VMM ne=
eds to
> >> >> >  +define at least a minimal stub for each VirtIO device it wants =
to
> >> >> >  +support. If the daemon supports the right set of protocol featu=
res the
> >> >> >  +VMM can probe the daemon for the information it needs to setup =
the
> >> >> >  +device. See :ref:`Probing features for standalone daemons
> >> >> >  +<probing_features>` for more details.
> >> >> >  +
> >> >> >  +
> >> >> >   Support for platforms other than Linux
> >> >> >   --------------------------------------
> >> >> >
> >> >> >  @@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
> >> >> >   * ``VHOST_USER_GET_VRING_BASE``
> >> >> >   * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_S=
HMFD``)
> >> >> >   * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_IN=
FLIGHT_SHMFD``)
> >> >> >  +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_=
STANDALONE``)
> >> >> >
> >> >> >   .. seealso::
> >> >> >
> >> >> >  @@ -396,9 +412,10 @@ must support changing some configuration as=
pects on the fly.
> >> >> >   Multiple queue support
> >> >> >   ----------------------
> >> >> >
> >> >> >  -Many devices have a fixed number of virtqueues.  In this case t=
he front-end
> >> >> >  -already knows the number of available virtqueues without commun=
icating with the
> >> >> >  -back-end.
> >> >> >  +Many devices have a fixed number of virtqueues. In this case th=
e
> >> >> >  +*front-end* usually already knows the number of available virtq=
ueues
> >> >> >  +without communicating with the back-end. For standalone daemons=
 this
> >> >> >  +number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` =
message.
> >> >> >
> >> >> >   Some devices do not have a fixed number of virtqueues.  Instead=
 the maximum
> >> >> >   number of virtqueues is chosen by the back-end.  The number can=
 depend on host
> >> >> >  @@ -885,6 +902,23 @@ Protocol features
> >> >> >     #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
> >> >> >     #define VHOST_USER_PROTOCOL_F_STATUS               16
> >> >> >     #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> >> >> >  +  #define VHOST_USER_PROTOCOL_F_PROBE                18
> >> >> >  +
> >> >> >  +.. _probing_features:
> >> >> >  +
> >> >> >  +Probing features for standalone daemons
> >> >> >  +---------------------------------------
> >> >> >  +
> >> >> >  +The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a =
number
> >> >> >  +of additional messages which allow the *front-end* to probe det=
ails
> >> >> >  +about the VirtIO device from the *back-end*. However for a *bac=
k-end*
> >> >> >  +to be described as standalone it must also support:
> >> >> >  +
> >> >> >  +  * ``VHOST_USER_PROTOCOL_F_STATUS``
> >> >> >  +  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config spac=
e)
> >> >> >  +
> >> >> >  +which are required to ensure the *back-end* daemon can operate
> >> >> >  +without the *front-end* managing some aspects of its configurat=
ion.
> >> >> >
> >> >> >   Front-end message types
> >> >> >   -----------------------
> >> >> >  @@ -1440,6 +1474,42 @@ Front-end message types
> >> >> >     query the back-end for its device status as defined in the Vi=
rtio
> >> >> >     specification.
> >> >> >
> >> >> >  +``VHOST_USER_GET_DEVICE_ID``
> >> >> >  +  :id: 41
> >> >> >  +  :request payload: N/A
> >> >> >  +  :reply payload: ``u32``
> >> >> >  +
> >> >> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has=
 been
> >> >> >  +  successfully negotiated, this message is submitted by the fro=
nt-end
> >> >> >  +  to query what VirtIO device the back-end support. This is int=
ended
> >> >> >  +  to remove the need for the front-end to know ahead of time wh=
at the
> >> >> >  +  VirtIO device the backend emulates is.
> >> >> >  +
> >> >> >  +``VHOST_USER_GET_CONFIG_SIZE``
> >> >> >  +  :id: 42
> >> >> >  +  :request payload: N/A
> >> >> >  +  :reply payload: ``u32``
> >> >> >  +
> >> >> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has=
 been
> >> >> >  +  successfully negotiated, this message is submitted by the fro=
nt-end
> >> >> >  +  to query the size of the VirtIO device's config space. This i=
s
> >> >> >  +  intended to remove the need for the front-end to know ahead o=
f time
> >> >> >  +  what the size is. Replying with 0 when
> >> >> >  +  ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would in=
dicate
> >> >> >  +  an bug.
> >> >> >  +
> >> >> >  +``VHOST_USER_GET_MIN_VQ``
> >> >> >  +  :id: 43
> >> >> >  +  :request payload: N/A
> >> >> >  +  :reply payload: ``u32``
> >> >> >  +
> >> >> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has=
 been
> >> >> >  +  successfully negotiated, this message is submitted by the fro=
nt-end to
> >> >> >  +  query minimum number of VQ's required to support the device. =
A
> >> >> >  +  device may support more than this number of VQ's if it advert=
ises
> >> >> >  +  the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting =
a
> >> >> >  +  number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`=
` would
> >> >> >  +  indicate a bug.
> >> >> >
> >> >> > Maybe I lack some background, but not sure what min_vq is here?
> >> >>
> >> >> There will be a minimum number of queues you need to support the de=
vice.
> >> >> For example the virtio-sound spec specifies you need four queues:
> >> >> control, event, tx, rx
> >> >
> >> > I don't understand why the front-end needs to know that? The backend
> >> > already reports the number of queues and not all of them need to be
> >> > initialized by the driver.
> >>
> >> But how many don't need to be initialised? We can't just skip:
> >>
> >>     /* Allocate queues */
> >>     vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> >>     for (int i =3D 0; i < vub->num_vqs; i++) {
> >>         g_ptr_array_add(vub->vqs,
> >>                         virtio_add_queue(vdev, vub->vq_size, vub_handl=
e_output));
> >>     }
> >>
> >> Or are you saying just require probe-able backends to support
> >> VHOST_USER_PROTOCOL_F_MQ and have it always report the minimmum number
> >> of queues if it is not a MQ capable device?
> >
> > The front-end should prepare to allow the maximum number of virtqueues
> > returned by VHOST_USER_GET_QUEUE_NUM (VHOST_USER_PROTOCOL_F_MQ).
> >
> > VIRTIO Transports have a way to query the maximum number of queues but
> > not a way to query the minimum number of queues. Why is the minimum
> > necessary?
>
> It seems excessive to automatically create the maximum number of VQs. I
> guess for backends that don't support the MQ feature (i.e. a variable
> number of VQs) we could just say VHOST_USER_GET_QUEUE_NUM =3D=3D min. But
> now we are overloading a different message originally added for
> something else.
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

