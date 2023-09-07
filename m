Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D06797CAB
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 21:24:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeKay-0004bh-RJ; Thu, 07 Sep 2023 15:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeKav-0004bI-7S
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 15:23:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeKas-00051i-D1
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 15:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694114588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/J1NQqaZBW0bC9oJPYQQYHkduldfmz2zvDIjoA97NvI=;
 b=YeHqlvvOCfA2spfm0qucHukDh15fjNhiMEDOqRBMX/dcIQgL5AIDiaa1CyzK86ZHFxiiy3
 EsJjToIvuETq2a+goNxImbfRVx+bO9EOabPx10Un+R+F4RPZ/oiWzE/nAncC0SGsj+b4Y+
 7D4WQm02vCFqOG5bdpJxm7I8NJ6DmHY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-8Z1d3j7iNpqKRZCxesihRg-1; Thu, 07 Sep 2023 15:23:02 -0400
X-MC-Unique: 8Z1d3j7iNpqKRZCxesihRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D79E48164E0;
 Thu,  7 Sep 2023 19:23:01 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 167B41121318;
 Thu,  7 Sep 2023 19:23:00 +0000 (UTC)
Date: Thu, 7 Sep 2023 15:22:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: slp@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org,
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Subject: Re: [RFC PATCH v2] docs/interop: define PROBE feature for vhost-user
 VirtIO devices
Message-ID: <20230907192259.GC1560640@fedora>
References: <20230901110018.3704459-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lgoOqfMumJCnPwrC"
Content-Disposition: inline
In-Reply-To: <20230901110018.3704459-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


--lgoOqfMumJCnPwrC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 12:00:18PM +0100, Alex Benn=E9e wrote:
> Currently QEMU has to know some details about the VirtIO device
> supported by a vhost-user daemon to be able to setup the guest. This
> makes it hard for QEMU to add support for additional vhost-user
> daemons without adding specific stubs for each additional VirtIO
> device.
>=20
> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE)
> which the back-end can advertise which allows a probe message to be
> sent to get all the details QEMU needs to know in one message.
>=20
> Together with the existing features VHOST_USER_PROTOCOL_F_STATUS and
> VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
> daemons which are capable of handling all aspects of the VirtIO
> transactions with only a generic stub on the QEMU side. These daemons
> can also be used without QEMU in situations where there isn't a full
> VMM managing their setup.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

I think the mindset for this change should be "vhost-user is becoming a
VIRTIO Transport". VIRTIO Transports have a reasonably well-defined
feature set in the VIRTIO specification. The goal should be to cover
every VIRTIO Transport operation via vhost-user protocol messages so
that the VIRTIO device model can be fully conveyed over vhost-user.

Anything less is yet another ad-hoc protocol extension that will lead to
more bugs and hacks when it turns out some VIRTIO devices cannot be
expressed due to limitations in the protocol.

This requires going through the VIRTIO spec to find a correspondence
between virtio-pci/virtio-mmio/virtio-ccw's interfaces and vhost-user
protocol messages. In most cases vhost-user already offers messages and
your patch adds more of what is missing. I think this effort is already
very close but missing the final check that it really matches the VIRTIO
spec.

Please do the comparison against the VIRTIO Transports and then adjust
this patch to make it clear that the back-end is becoming a full-fledged
VIRTIO Transport:
- The name of the patch series should reflect that.
- The vhost-user protocol feature should be named F_TRANSPORT.
- The messages added in this patch should have a 1:1 correspondence with
  the VIRTIO spec including using the same terminology for consistency.

Sorry for the hassle, but I think this is a really crucial point where
we have the chance to make vhost-user work smoothly in the future...but
only if we can faithfully expose VIRTIO Transport semantics.

>=20
> ---
> v2
>   - dropped F_STANDALONE in favour of F_PROBE
>   - split probe details across several messages
>   - probe messages don't automatically imply a standalone daemon
>   - add wording where probe details interact (F_MQ/F_CONFIG)
>   - define VMM and make clear QEMU is only one of many potential VMMs
>   - reword commit message
> ---
>  docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++++-----
>  hw/virtio/vhost-user.c      |  8 ++++
>  2 files changed, 88 insertions(+), 10 deletions(-)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..ba3b5e07b7 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -7,6 +7,7 @@ Vhost-user Protocol
>  ..
>    Copyright 2014 Virtual Open Systems Sarl.
>    Copyright 2019 Intel Corporation
> +  Copyright 2023 Linaro Ltd
>    Licence: This work is licensed under the terms of the GNU GPL,
>             version 2 or later. See the COPYING file in the top-level
>             directory.
> @@ -27,17 +28,31 @@ The protocol defines 2 sides of the communication, *f=
ront-end* and
>  *back-end*. The *front-end* is the application that shares its virtqueue=
s, in
>  our case QEMU. The *back-end* is the consumer of the virtqueues.
> =20
> -In the current implementation QEMU is the *front-end*, and the *back-end*
> -is the external process consuming the virtio queues, for example a
> -software Ethernet switch running in user space, such as Snabbswitch,
> -or a block device back-end processing read & write to a virtual
> -disk. In order to facilitate interoperability between various back-end
> -implementations, it is recommended to follow the :ref:`Backend program
> -conventions <backend_conventions>`.
> +In the current implementation a Virtual Machine Manager (VMM) such as
> +QEMU is the *front-end*, and the *back-end* is the external process
> +consuming the virtio queues, for example a software Ethernet switch
> +running in user space, such as Snabbswitch, or a block device back-end
> +processing read & write to a virtual disk. In order to facilitate
> +interoperability between various back-end implementations, it is
> +recommended to follow the :ref:`Backend program conventions
> +<backend_conventions>`.
> =20
>  The *front-end* and *back-end* can be either a client (i.e. connecting) =
or
>  server (listening) in the socket communication.
> =20
> +Probing device details
> +----------------------
> +
> +Traditionally the vhost-user daemon *back-end* shares configuration
> +responsibilities with the VMM *front-end* which needs to know certain
> +key bits of information about the device. This means the VMM needs to
> +define at least a minimal stub for each VirtIO device it wants to
> +support. If the daemon supports the right set of protocol features the
> +VMM can probe the daemon for the information it needs to setup the
> +device.

"... without a per-device stub in the VMM"

This makes it clear that this sentence is describing an alternative
to the per-device stub in the VMM.

> See :ref:`Probing features for standalone daemons
> +<probing_features>` for more details.

The current section is named "Probing device details" and one being
reference is called "Probing features for standalone daemons". Are
"features" or "device details" two terms for the same thing? Why
"daemons" and not "back-end"?

I suggest calling this section "Standalone back-ends" and the other
section "Probing standalone back-ends" to keep the terminology
consistent.

> +
> +
>  Support for platforms other than Linux
>  --------------------------------------
> =20
> @@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
>  * ``VHOST_USER_GET_VRING_BASE``
>  * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>  * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SH=
MFD``)
> +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALON=
E``)

F_STANDALONE vs F_PROBE

"SPECS" vs "features" vs "details".

Please be consistent.

> =20
>  .. seealso::
> =20
> @@ -396,9 +412,10 @@ must support changing some configuration aspects on =
the fly.
>  Multiple queue support
>  ----------------------
> =20
> -Many devices have a fixed number of virtqueues.  In this case the front-=
end
> -already knows the number of available virtqueues without communicating w=
ith the
> -back-end.
> +Many devices have a fixed number of virtqueues. In this case the
> +*front-end* usually already knows the number of available virtqueues
> +without communicating with the back-end. For standalone daemons this

"Usually" is vague. It's possible to be precise:

  In this case a front-end that is aware of the device type already
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  knows the number of available virtqueues without communicating with
  the back-end.

> +number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` message.

Then this sentence can be adjusted to:

  When the front-end is not aware of the device type, the number can be
  probed with the ``VHOST_USER_GET_MIN_VQ`` message.

> =20
>  Some devices do not have a fixed number of virtqueues.  Instead the maxi=
mum
>  number of virtqueues is chosen by the back-end.  The number can depend o=
n host
> @@ -885,6 +902,23 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> +  #define VHOST_USER_PROTOCOL_F_PROBE                18
> +
> +.. _probing_features:
> +
> +Probing features for standalone daemons
> +---------------------------------------
> +
> +The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a number
> +of additional messages which allow the *front-end* to probe details
> +about the VirtIO device from the *back-end*. However for a *back-end*
> +to be described as standalone it must also support:
> +
> +  * ``VHOST_USER_PROTOCOL_F_STATUS``
> +  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)
> +
> +which are required to ensure the *back-end* daemon can operate
> +without the *front-end* managing some aspects of its configuration.
> =20
>  Front-end message types
>  -----------------------
> @@ -1440,6 +1474,42 @@ Front-end message types
>    query the back-end for its device status as defined in the Virtio
>    specification.
> =20
> +``VHOST_USER_GET_DEVICE_ID``
> +  :id: 41
> +  :request payload: N/A
> +  :reply payload: ``u32``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> +  successfully negotiated, this message is submitted by the front-end
> +  to query what VirtIO device the back-end support. This is intended
> +  to remove the need for the front-end to know ahead of time what the
> +  VirtIO device the backend emulates is.

"... VIRTIO device type that the backend emulates is."

"Device type" is the name used in the VIRTIO spec.

> +
> +``VHOST_USER_GET_CONFIG_SIZE``
> +  :id: 42
> +  :request payload: N/A
> +  :reply payload: ``u32``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> +  successfully negotiated, this message is submitted by the front-end
> +  to query the size of the VirtIO device's config space. This is
> +  intended to remove the need for the front-end to know ahead of time
> +  what the size is. Replying with 0 when
> +  ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would indicate
> +  an bug.

"a bug"

What is the harm in returning 0 when the device has an empty
Configuration Space like the Entropy device, the I2C Adapter, the SCMI
device, etc?

> +
> +``VHOST_USER_GET_MIN_VQ``
> +  :id: 43
> +  :request payload: N/A
> +  :reply payload: ``u32``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> +  successfully negotiated, this message is submitted by the front-end to
> +  query minimum number of VQ's required to support the device. A
> +  device may support more than this number of VQ's if it advertises
> +  the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting a
> +  number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`` would
> +  indicate a bug.

What is the purpose of this message? I don't see an equivalent in the
VIRTIO specification.

> =20
>  Back-end message types
>  ----------------------
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 8dcf049d42..4d433cdf2b 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
> =20
> +typedef struct VhostUserBackendSpecs {
> +    uint32_t device_id;
> +    uint32_t config_size;
> +    uint32_t min_vqs;
> +    uint32_t max_vqs;
> +} VhostUserBackendSpecs;

This message is undocumented? I think it may be outdated and you split
it up into individual messages.

> +
>  typedef struct {
>      VhostUserRequest request;
> =20
> @@ -226,6 +233,7 @@ typedef union {
>          VhostUserCryptoSession session;
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
> +        VhostUserBackendSpecs specs;
>  } VhostUserPayload;
> =20
>  typedef struct VhostUserMsg {
> --=20
> 2.39.2
>=20

--lgoOqfMumJCnPwrC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT6IxMACgkQnKSrs4Gr
c8iSjgf+IkWolVeNkg3f2aGMQM2FHN/Q0VIUNrNdUOo7YejI8Sivh0aXa2vI4Gll
XtKbXHGhvs/jPj6830VDtka4pZENZbUAhL59Zg0xNc1/SYMoXxZX39nf+K6lVSbI
S3HvV1bsHqan89BYaUB2Vc6kbPZ7HkIVgKwugVPrn6WnjwJw+QOJqMWGXw9wpDa6
6wVvY6R6yJg+Uv92Gm4G5Xc4SPVOoVmdgySpO2XKFTip9Id4rcEHqGoFS0n37XJd
7yhSWoNfj/h1Z+jcuFnHnMFtIMUk4+0K2wEWV257q2JIe3YgUPWly6XuaebLpT5/
ugc8vv/mM+6mwZ9dmHQ6f0KPbekQug==
=2VvJ
-----END PGP SIGNATURE-----

--lgoOqfMumJCnPwrC--


