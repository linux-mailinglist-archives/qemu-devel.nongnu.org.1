Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB577797CB3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 21:30:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeKgu-0007Yf-Sl; Thu, 07 Sep 2023 15:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeKgr-0007YK-Ey
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 15:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeKgo-0008K5-NY
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 15:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694114957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MOGN7P67urkBgPJ4FFU7bdQOBoqyka79rGmy+vweAOU=;
 b=GnLGFGm/YvE3Ln0itfrsxmbYGX0ltRIKnKZatFTelWnLEz8BR9vtO3YI3PFLEGgeGTb1yJ
 4XKmQnDHc9JDSKjUMQFHqWcUPfMQoa3e6Mft4O9FcbmMEBfO4EWWIdrZ0YYqerf5P9M8Gt
 RHQ3DMmhkH7Yg2QlB5jbzpvyp4LKGk4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-681-DZDck0syOtiFdg9nkHPTOQ-1; Thu, 07 Sep 2023 15:29:16 -0400
X-MC-Unique: DZDck0syOtiFdg9nkHPTOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C91D63810D50;
 Thu,  7 Sep 2023 19:29:15 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 467C021EE566;
 Thu,  7 Sep 2023 19:29:15 +0000 (UTC)
Date: Thu, 7 Sep 2023 15:29:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Albert Esteve <aesteve@redhat.com>, slp@redhat.com, mst@redhat.com,
 marcandre.lureau@redhat.com, viresh.kumar@linaro.org,
 sgarzare@redhat.com, takahiro.akashi@linaro.org,
 erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
 mathieu.poirier@linaro.org, qemu-devel@nongnu.org,
 virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Subject: Re: [virtio-dev] [RFC PATCH v2] docs/interop: define PROBE feature
 for vhost-user VirtIO devices
Message-ID: <20230907192913.GD1560640@fedora>
References: <20230901110018.3704459-1-alex.bennee@linaro.org>
 <CADSE00LiE6c8UhZ-KXTRuTc-yJQ==c=3teTcs8Wyx2k1CmUGQg@mail.gmail.com>
 <87y1hlgdl4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="97ZShj9gXlIq8P4i"
Content-Disposition: inline
In-Reply-To: <87y1hlgdl4.fsf@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--97ZShj9gXlIq8P4i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 10:34:11AM +0100, Alex Benn=C3=A9e wrote:
>=20
> Albert Esteve <aesteve@redhat.com> writes:
>=20
> > This looks great! Thanks for this proposal.
> >
> > On Fri, Sep 1, 2023 at 1:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@li=
naro.org> wrote:
> >
> >  Currently QEMU has to know some details about the VirtIO device
> >  supported by a vhost-user daemon to be able to setup the guest. This
> >  makes it hard for QEMU to add support for additional vhost-user
> >  daemons without adding specific stubs for each additional VirtIO
> >  device.
> >
> >  This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE)
> >  which the back-end can advertise which allows a probe message to be
> >  sent to get all the details QEMU needs to know in one message.
> >
> >  Together with the existing features VHOST_USER_PROTOCOL_F_STATUS and
> >  VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
> >  daemons which are capable of handling all aspects of the VirtIO
> >  transactions with only a generic stub on the QEMU side. These daemons
> >  can also be used without QEMU in situations where there isn't a full
> >  VMM managing their setup.
> >
> >  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> >  ---
> >  v2
> >    - dropped F_STANDALONE in favour of F_PROBE
> >    - split probe details across several messages
> >    - probe messages don't automatically imply a standalone daemon
> >    - add wording where probe details interact (F_MQ/F_CONFIG)
> >    - define VMM and make clear QEMU is only one of many potential VMMs
> >    - reword commit message
> >  ---
> >   docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++++-----
> >   hw/virtio/vhost-user.c      |  8 ++++
> >   2 files changed, 88 insertions(+), 10 deletions(-)
> >
> >  diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >  index 5a070adbc1..ba3b5e07b7 100644
> >  --- a/docs/interop/vhost-user.rst
> >  +++ b/docs/interop/vhost-user.rst
> >  @@ -7,6 +7,7 @@ Vhost-user Protocol
> >   ..
> >     Copyright 2014 Virtual Open Systems Sarl.
> >     Copyright 2019 Intel Corporation
> >  +  Copyright 2023 Linaro Ltd
> >     Licence: This work is licensed under the terms of the GNU GPL,
> >              version 2 or later. See the COPYING file in the top-level
> >              directory.
> >  @@ -27,17 +28,31 @@ The protocol defines 2 sides of the communication,=
 *front-end* and
> >   *back-end*. The *front-end* is the application that shares its virtqu=
eues, in
> >   our case QEMU. The *back-end* is the consumer of the virtqueues.
> >
> >  -In the current implementation QEMU is the *front-end*, and the *back-=
end*
> >  -is the external process consuming the virtio queues, for example a
> >  -software Ethernet switch running in user space, such as Snabbswitch,
> >  -or a block device back-end processing read & write to a virtual
> >  -disk. In order to facilitate interoperability between various back-end
> >  -implementations, it is recommended to follow the :ref:`Backend program
> >  -conventions <backend_conventions>`.
> >  +In the current implementation a Virtual Machine Manager (VMM) such as
> >  +QEMU is the *front-end*, and the *back-end* is the external process
> >  +consuming the virtio queues, for example a software Ethernet switch
> >  +running in user space, such as Snabbswitch, or a block device back-end
> >  +processing read & write to a virtual disk. In order to facilitate
> >  +interoperability between various back-end implementations, it is
> >  +recommended to follow the :ref:`Backend program conventions
> >  +<backend_conventions>`.
> >
> >   The *front-end* and *back-end* can be either a client (i.e. connectin=
g) or
> >   server (listening) in the socket communication.
> >
> >  +Probing device details
> >  +----------------------
> >  +
> >  +Traditionally the vhost-user daemon *back-end* shares configuration
> >  +responsibilities with the VMM *front-end* which needs to know certain
> >  +key bits of information about the device. This means the VMM needs to
> >  +define at least a minimal stub for each VirtIO device it wants to
> >  +support. If the daemon supports the right set of protocol features the
> >  +VMM can probe the daemon for the information it needs to setup the
> >  +device. See :ref:`Probing features for standalone daemons
> >  +<probing_features>` for more details.
> >  +
> >  +
> >   Support for platforms other than Linux
> >   --------------------------------------
> >
> >  @@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
> >   * ``VHOST_USER_GET_VRING_BASE``
> >   * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
> >   * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT=
_SHMFD``)
> >  +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDA=
LONE``)
> >
> >   .. seealso::
> >
> >  @@ -396,9 +412,10 @@ must support changing some configuration aspects =
on the fly.
> >   Multiple queue support
> >   ----------------------
> >
> >  -Many devices have a fixed number of virtqueues.  In this case the fro=
nt-end
> >  -already knows the number of available virtqueues without communicatin=
g with the
> >  -back-end.
> >  +Many devices have a fixed number of virtqueues. In this case the
> >  +*front-end* usually already knows the number of available virtqueues
> >  +without communicating with the back-end. For standalone daemons this
> >  +number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` messag=
e.
> >
> >   Some devices do not have a fixed number of virtqueues.  Instead the m=
aximum
> >   number of virtqueues is chosen by the back-end.  The number can depen=
d on host
> >  @@ -885,6 +902,23 @@ Protocol features
> >     #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
> >     #define VHOST_USER_PROTOCOL_F_STATUS               16
> >     #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> >  +  #define VHOST_USER_PROTOCOL_F_PROBE                18
> >  +
> >  +.. _probing_features:
> >  +
> >  +Probing features for standalone daemons
> >  +---------------------------------------
> >  +
> >  +The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a number
> >  +of additional messages which allow the *front-end* to probe details
> >  +about the VirtIO device from the *back-end*. However for a *back-end*
> >  +to be described as standalone it must also support:
> >  +
> >  +  * ``VHOST_USER_PROTOCOL_F_STATUS``
> >  +  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)
> >  +
> >  +which are required to ensure the *back-end* daemon can operate
> >  +without the *front-end* managing some aspects of its configuration.
> >
> >   Front-end message types
> >   -----------------------
> >  @@ -1440,6 +1474,42 @@ Front-end message types
> >     query the back-end for its device status as defined in the Virtio
> >     specification.
> >
> >  +``VHOST_USER_GET_DEVICE_ID``
> >  +  :id: 41
> >  +  :request payload: N/A
> >  +  :reply payload: ``u32``
> >  +
> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> >  +  successfully negotiated, this message is submitted by the front-end
> >  +  to query what VirtIO device the back-end support. This is intended
> >  +  to remove the need for the front-end to know ahead of time what the
> >  +  VirtIO device the backend emulates is.
> >  +
> >  +``VHOST_USER_GET_CONFIG_SIZE``
> >  +  :id: 42
> >  +  :request payload: N/A
> >  +  :reply payload: ``u32``
> >  +
> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> >  +  successfully negotiated, this message is submitted by the front-end
> >  +  to query the size of the VirtIO device's config space. This is
> >  +  intended to remove the need for the front-end to know ahead of time
> >  +  what the size is. Replying with 0 when
> >  +  ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would indicate
> >  +  an bug.
> >  +
> >  +``VHOST_USER_GET_MIN_VQ``
> >  +  :id: 43
> >  +  :request payload: N/A
> >  +  :reply payload: ``u32``
> >  +
> >  +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> >  +  successfully negotiated, this message is submitted by the front-end=
 to
> >  +  query minimum number of VQ's required to support the device. A
> >  +  device may support more than this number of VQ's if it advertises
> >  +  the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting a
> >  +  number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`` would
> >  +  indicate a bug.
> >
> > Maybe I lack some background, but not sure what min_vq is here?
>=20
> There will be a minimum number of queues you need to support the device.
> For example the virtio-sound spec specifies you need four queues:
> control, event, tx, rx

I don't understand why the front-end needs to know that? The backend
already reports the number of queues and not all of them need to be
initialized by the driver.

>=20
> > This looks like quering the number of VQs the backend requires/uses.
> > Which, in case of MQ, it may be bigger (which is where I assume comes t=
he `min`
> > part, if we consider `VHOST_USER_GET_QUEUE_NUM` the `max`).
>=20
> The MQ extension is currently used by networking but in theory any
> device could attempt to parallelism by extending the number of virt
> queues needed. So for net you get:
>=20
>   receiveq1
>   transmitq1
>   optional controlq
>=20
> So VHOST_USER_GET_MIN_VQ would report 2 or 3 (if VIRTIO_NET_F_CTRL_VQ is
> negotiated).

I'm confused. VHOST_USER_GET_MIN_VQ comes before VIRTIO Feature Bit
negotiation (VIRTIO_NET_F_CTRL_VQ).

> However VHOST_USER_GET_QUEUE_NUM is only usable if
> VIRTIO_NET_F_MQ has been negotiated and could report more.

I don't understand. This patch adds a new feature and it can require
VHOST_USER_PROTOCOL_F_MQ. There are no existing back-ends that require
backwards compatibility.

Stefan

--97ZShj9gXlIq8P4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT6JIkACgkQnKSrs4Gr
c8iEZAf/cH9nnplt2T+FMJa/QdMpupaWqF+k/yGdmbBO5pyEWCWudEKMb8C/rWtr
O98YlfwfT451OCAuqd8YmVoriNpPhLlWx6IXeldMhYZXQSMProBFYZR+gOyetjHJ
GUEjAlZ6tb2tWeMYF7uPMmPhUQoTwBPVGw36rg5Mlo0/ifdLgs2qMIB7FKAGucdd
XM51zKW0VAa+6N1M+p0LFIScAYU8/Np/ELYFjZcY5g4SGNOvVBJHO5AKo33HspJz
9gTUr9sblmLF9MFQkz5oM1N8Af3o66pqNWGkaefyMJo1oENbHkPW3rsaNtW4uGxX
4rodq1NK+RTAkt6yZNdJ6j4yVR4Xfw==
=dyjr
-----END PGP SIGNATURE-----

--97ZShj9gXlIq8P4i--


