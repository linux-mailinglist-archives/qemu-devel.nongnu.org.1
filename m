Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB778FCDA
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 14:01:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc2ou-0005oJ-W5; Fri, 01 Sep 2023 08:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qc2os-0005o6-9n
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qc2oo-0001T4-RJ
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693569605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sDTXi/K0Xt5mDFRZ8OR6YrXNoU7vSujHjOOM+uTncdw=;
 b=MK6iHomFtaJ2YJNkdO8e4PKPO1UBSIuzsPoA9K4Pno0V50hf5M/FL04gtzqbrAi3aYOHgW
 Z9NANPRH9fcLPC48uTyHiK1YLscpNwkWlAvcbLbHXeuzt0F9SE7v2oklf3fjEhsZxLOnfH
 +XpfjAdXxP7KD/05uMpyHK/zD9cW2A8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-IKFdCHq0MrG5lCZRNLXHYw-1; Fri, 01 Sep 2023 08:00:02 -0400
X-MC-Unique: IKFdCHq0MrG5lCZRNLXHYw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-26f3fce5b45so2416529a91.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 05:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693569601; x=1694174401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDTXi/K0Xt5mDFRZ8OR6YrXNoU7vSujHjOOM+uTncdw=;
 b=i14t8rq+5dEKZE8wYGTFyuHJfMcSp9K48VpkHZEB5eKQncAuM2+haLscUPBmrv3NNu
 RlJ/TnuVXWu1TbEbrKmHDQpcMAVyz7V7iEy+qGFMljcwQeRp59czyBKHQ1sqveVKFbQd
 qBAWq6RN1d/YXy0hAGIcR4I1D76opuZIfc9E0yb+0Ku2zmsBag4ZgXkpjs8YEn9IQ/Vb
 fGzO/3C1FcSDTrmdEPWUrR15H6/jTMKcLF+X9+JoU7y+jxwWViWNh3VZseWIVTE8+uTB
 mmBT5fjEvpaqQQOYCH4rcOVkorjbteSadNY4mlaByQCljBwCiZ3JfWoPENho/cZLdK8k
 r57g==
X-Gm-Message-State: AOJu0YzSay42ZqSbNNl0rtAGgbuSahjFDmSGLmVnDp2TLHsflWzBYqKp
 fsDg+a0uze1HVnHO3F068KrdaZ0mJCvZca4W//WXr1QVCJR47/dFewr6A7rz4AE03PNrOgnxenP
 MIBNSjq/OBtsBeImQhjgCJM6+29DyGz0=
X-Received: by 2002:a17:90b:1d0c:b0:26c:f9a5:4493 with SMTP id
 on12-20020a17090b1d0c00b0026cf9a54493mr2132634pjb.5.1693569601427; 
 Fri, 01 Sep 2023 05:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoOgilOeN5IWxiONCmaXqMqTUXRM2bZwGHcGubYS/Z0jeqQ4F6oKFG5ypXwIk33p8FLwBb93z3MFj6ivJJXNY=
X-Received: by 2002:a17:90b:1d0c:b0:26c:f9a5:4493 with SMTP id
 on12-20020a17090b1d0c00b0026cf9a54493mr2132617pjb.5.1693569601128; Fri, 01
 Sep 2023 05:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230901110018.3704459-1-alex.bennee@linaro.org>
In-Reply-To: <20230901110018.3704459-1-alex.bennee@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 1 Sep 2023 13:59:49 +0200
Message-ID: <CADSE00LiE6c8UhZ-KXTRuTc-yJQ==c=3teTcs8Wyx2k1CmUGQg@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH v2] docs/interop: define PROBE feature
 for vhost-user VirtIO devices
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: slp@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, 
 stefanha@redhat.com, viresh.kumar@linaro.org, sgarzare@redhat.com, 
 takahiro.akashi@linaro.org, erik.schilling@linaro.org, 
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org, 
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, 
 virtio-comment@lists.oasis-open.org
Content-Type: multipart/alternative; boundary="0000000000007a5f3506044ae6eb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000007a5f3506044ae6eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks great! Thanks for this proposal.

On Fri, Sep 1, 2023 at 1:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> Currently QEMU has to know some details about the VirtIO device
> supported by a vhost-user daemon to be able to setup the guest. This
> makes it hard for QEMU to add support for additional vhost-user
> daemons without adding specific stubs for each additional VirtIO
> device.
>
> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE)
> which the back-end can advertise which allows a probe message to be
> sent to get all the details QEMU needs to know in one message.
>
> Together with the existing features VHOST_USER_PROTOCOL_F_STATUS and
> VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
> daemons which are capable of handling all aspects of the VirtIO
> transactions with only a generic stub on the QEMU side. These daemons
> can also be used without QEMU in situations where there isn't a full
> VMM managing their setup.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
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
>
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
> @@ -27,17 +28,31 @@ The protocol defines 2 sides of the communication,
> *front-end* and
>  *back-end*. The *front-end* is the application that shares its
> virtqueues, in
>  our case QEMU. The *back-end* is the consumer of the virtqueues.
>
> -In the current implementation QEMU is the *front-end*, and the *back-end=
*
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
>
>  The *front-end* and *back-end* can be either a client (i.e. connecting) =
or
>  server (listening) in the socket communication.
>
> +Probing device details
> +----------------------
> +
> +Traditionally the vhost-user daemon *back-end* shares configuration
> +responsibilities with the VMM *front-end* which needs to know certain
> +key bits of information about the device. This means the VMM needs to
> +define at least a minimal stub for each VirtIO device it wants to
> +support. If the daemon supports the right set of protocol features the
> +VMM can probe the daemon for the information it needs to setup the
> +device. See :ref:`Probing features for standalone daemons
> +<probing_features>` for more details.
> +
> +
>  Support for platforms other than Linux
>  --------------------------------------
>
> @@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
>  * ``VHOST_USER_GET_VRING_BASE``
>  * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>  * ``VHOST_USER_GET_INFLIGHT_FD`` (if
> ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
> +* ``VHOST_USER_GET_BACKEND_SPECS`` (if
> ``VHOST_USER_PROTOCOL_F_STANDALONE``)
>
>  .. seealso::
>
> @@ -396,9 +412,10 @@ must support changing some configuration aspects on
> the fly.
>  Multiple queue support
>  ----------------------
>
> -Many devices have a fixed number of virtqueues.  In this case the
> front-end
> -already knows the number of available virtqueues without communicating
> with the
> -back-end.
> +Many devices have a fixed number of virtqueues. In this case the
> +*front-end* usually already knows the number of available virtqueues
> +without communicating with the back-end. For standalone daemons this
> +number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` message.
>
>  Some devices do not have a fixed number of virtqueues.  Instead the
> maximum
>  number of virtqueues is chosen by the back-end.  The number can depend o=
n
> host
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
>
>  Front-end message types
>  -----------------------
> @@ -1440,6 +1474,42 @@ Front-end message types
>    query the back-end for its device status as defined in the Virtio
>    specification.
>
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
>
>
Maybe I lack some background, but not sure what min_vq is here?
This looks like quering the number of VQs the backend requires/uses.
Which, in case of MQ, it may be bigger (which is where I assume comes the
`min`
part, if we consider `VHOST_USER_GET_QUEUE_NUM` the `max`).

Couldn't we reuse the `VHOST_USER_GET_QUEUE_NUM` type for this?


>  Back-end message types
>  ----------------------
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 8dcf049d42..4d433cdf2b 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
>
> +typedef struct VhostUserBackendSpecs {
> +    uint32_t device_id;
> +    uint32_t config_size;
> +    uint32_t min_vqs;
> +    uint32_t max_vqs;
> +} VhostUserBackendSpecs;
> +
>  typedef struct {
>      VhostUserRequest request;
>
> @@ -226,6 +233,7 @@ typedef union {
>          VhostUserCryptoSession session;
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
> +        VhostUserBackendSpecs specs;
>  } VhostUserPayload;
>
>  typedef struct VhostUserMsg {
> --
> 2.39.2
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

--0000000000007a5f3506044ae6eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div>This looks great! Thanks for this proposal.</div></div></div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Fri, Sep 1, 2023 at 1:00=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Currently QEMU has to know s=
ome details about the VirtIO device<br>
supported by a vhost-user daemon to be able to setup the guest. This<br>
makes it hard for QEMU to add support for additional vhost-user<br>
daemons without adding specific stubs for each additional VirtIO<br>
device.<br>
<br>
This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE)<br>
which the back-end can advertise which allows a probe message to be<br>
sent to get all the details QEMU needs to know in one message.<br>
<br>
Together with the existing features VHOST_USER_PROTOCOL_F_STATUS and<br>
VHOST_USER_PROTOCOL_F_CONFIG we can create &quot;standalone&quot; vhost-use=
r<br>
daemons which are capable of handling all aspects of the VirtIO<br>
transactions with only a generic stub on the QEMU side. These daemons<br>
can also be used without QEMU in situations where there isn&#39;t a full<br=
>
VMM managing their setup.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br>
---<br>
v2<br>
=C2=A0 - dropped F_STANDALONE in favour of F_PROBE<br>
=C2=A0 - split probe details across several messages<br>
=C2=A0 - probe messages don&#39;t automatically imply a standalone daemon<b=
r>
=C2=A0 - add wording where probe details interact (F_MQ/F_CONFIG)<br>
=C2=A0 - define VMM and make clear QEMU is only one of many potential VMMs<=
br>
=C2=A0 - reword commit message<br>
---<br>
=C2=A0docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++++----=
-<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++++<br>
=C2=A02 files changed, 88 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst<br>
index 5a070adbc1..ba3b5e07b7 100644<br>
--- a/docs/interop/vhost-user.rst<br>
+++ b/docs/interop/vhost-user.rst<br>
@@ -7,6 +7,7 @@ Vhost-user Protocol<br>
=C2=A0..<br>
=C2=A0 =C2=A0Copyright 2014 Virtual Open Systems Sarl.<br>
=C2=A0 =C2=A0Copyright 2019 Intel Corporation<br>
+=C2=A0 Copyright 2023 Linaro Ltd<br>
=C2=A0 =C2=A0Licence: This work is licensed under the terms of the GNU GPL,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 version 2 or later. See the COPYI=
NG file in the top-level<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 directory.<br>
@@ -27,17 +28,31 @@ The protocol defines 2 sides of the communication, *fro=
nt-end* and<br>
=C2=A0*back-end*. The *front-end* is the application that shares its virtqu=
eues, in<br>
=C2=A0our case QEMU. The *back-end* is the consumer of the virtqueues.<br>
<br>
-In the current implementation QEMU is the *front-end*, and the *back-end*<=
br>
-is the external process consuming the virtio queues, for example a<br>
-software Ethernet switch running in user space, such as Snabbswitch,<br>
-or a block device back-end processing read &amp; write to a virtual<br>
-disk. In order to facilitate interoperability between various back-end<br>
-implementations, it is recommended to follow the :ref:`Backend program<br>
-conventions &lt;backend_conventions&gt;`.<br>
+In the current implementation a Virtual Machine Manager (VMM) such as<br>
+QEMU is the *front-end*, and the *back-end* is the external process<br>
+consuming the virtio queues, for example a software Ethernet switch<br>
+running in user space, such as Snabbswitch, or a block device back-end<br>
+processing read &amp; write to a virtual disk. In order to facilitate<br>
+interoperability between various back-end implementations, it is<br>
+recommended to follow the :ref:`Backend program conventions<br>
+&lt;backend_conventions&gt;`.<br>
<br>
=C2=A0The *front-end* and *back-end* can be either a client (i.e. connectin=
g) or<br>
=C2=A0server (listening) in the socket communication.<br>
<br>
+Probing device details<br>
+----------------------<br>
+<br>
+Traditionally the vhost-user daemon *back-end* shares configuration<br>
+responsibilities with the VMM *front-end* which needs to know certain<br>
+key bits of information about the device. This means the VMM needs to<br>
+define at least a minimal stub for each VirtIO device it wants to<br>
+support. If the daemon supports the right set of protocol features the<br>
+VMM can probe the daemon for the information it needs to setup the<br>
+device. See :ref:`Probing features for standalone daemons<br>
+&lt;probing_features&gt;` for more details.<br>
+<br>
+<br>
=C2=A0Support for platforms other than Linux<br>
=C2=A0--------------------------------------<br>
<br>
@@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:<br>
=C2=A0* ``VHOST_USER_GET_VRING_BASE``<br>
=C2=A0* ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``=
)<br>
=C2=A0* ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT=
_SHMFD``)<br>
+* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE`=
`)<br>
<br>
=C2=A0.. seealso::<br>
<br>
@@ -396,9 +412,10 @@ must support changing some configuration aspects on th=
e fly.<br>
=C2=A0Multiple queue support<br>
=C2=A0----------------------<br>
<br>
-Many devices have a fixed number of virtqueues.=C2=A0 In this case the fro=
nt-end<br>
-already knows the number of available virtqueues without communicating wit=
h the<br>
-back-end.<br>
+Many devices have a fixed number of virtqueues. In this case the<br>
+*front-end* usually already knows the number of available virtqueues<br>
+without communicating with the back-end. For standalone daemons this<br>
+number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` message.<br=
>
<br>
=C2=A0Some devices do not have a fixed number of virtqueues.=C2=A0 Instead =
the maximum<br>
=C2=A0number of virtqueues is chosen by the back-end.=C2=A0 The number can =
depend on host<br>
@@ -885,6 +902,23 @@ Protocol features<br>
=C2=A0 =C2=A0#define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS=C2=A0 15<br>
=C2=A0 =C2=A0#define VHOST_USER_PROTOCOL_F_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016<br>
=C2=A0 =C2=A0#define VHOST_USER_PROTOCOL_F_XEN_MMAP=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A017<br>
+=C2=A0 #define VHOST_USER_PROTOCOL_F_PROBE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 18<br>
+<br>
+.. _probing_features:<br>
+<br>
+Probing features for standalone daemons<br>
+---------------------------------------<br>
+<br>
+The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a number<br>
+of additional messages which allow the *front-end* to probe details<br>
+about the VirtIO device from the *back-end*. However for a *back-end*<br>
+to be described as standalone it must also support:<br>
+<br>
+=C2=A0 * ``VHOST_USER_PROTOCOL_F_STATUS``<br>
+=C2=A0 * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)<br>
+<br>
+which are required to ensure the *back-end* daemon can operate<br>
+without the *front-end* managing some aspects of its configuration.<br>
<br>
=C2=A0Front-end message types<br>
=C2=A0-----------------------<br>
@@ -1440,6 +1474,42 @@ Front-end message types<br>
=C2=A0 =C2=A0query the back-end for its device status as defined in the Vir=
tio<br>
=C2=A0 =C2=A0specification.<br>
<br>
+``VHOST_USER_GET_DEVICE_ID``<br>
+=C2=A0 :id: 41<br>
+=C2=A0 :request payload: N/A<br>
+=C2=A0 :reply payload: ``u32``<br>
+<br>
+=C2=A0 When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been<=
br>
+=C2=A0 successfully negotiated, this message is submitted by the front-end=
<br>
+=C2=A0 to query what VirtIO device the back-end support. This is intended<=
br>
+=C2=A0 to remove the need for the front-end to know ahead of time what the=
<br>
+=C2=A0 VirtIO device the backend emulates is.<br>
+<br>
+``VHOST_USER_GET_CONFIG_SIZE``<br>
+=C2=A0 :id: 42<br>
+=C2=A0 :request payload: N/A<br>
+=C2=A0 :reply payload: ``u32``<br>
+<br>
+=C2=A0 When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been<=
br>
+=C2=A0 successfully negotiated, this message is submitted by the front-end=
<br>
+=C2=A0 to query the size of the VirtIO device&#39;s config space. This is<=
br>
+=C2=A0 intended to remove the need for the front-end to know ahead of time=
<br>
+=C2=A0 what the size is. Replying with 0 when<br>
+=C2=A0 ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would indicate=
<br>
+=C2=A0 an bug.<br>
+<br>
+``VHOST_USER_GET_MIN_VQ``<br>
+=C2=A0 :id: 43<br>
+=C2=A0 :request payload: N/A<br>
+=C2=A0 :reply payload: ``u32``<br>
+<br>
+=C2=A0 When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been<=
br>
+=C2=A0 successfully negotiated, this message is submitted by the front-end=
 to<br>
+=C2=A0 query minimum number of VQ&#39;s required to support the device. A<=
br>
+=C2=A0 device may support more than this number of VQ&#39;s if it advertis=
es<br>
+=C2=A0 the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting a<br>
+=C2=A0 number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`` woul=
d<br>
+=C2=A0 indicate a bug.<br>
<br></blockquote><div><br></div><div>Maybe I lack some background, but not =
sure what min_vq is here?</div><div>This looks like quering=C2=A0the number=
 of VQs the backend requires/uses.</div><div>Which, in case of MQ, it may b=
e bigger (which is where I assume comes the `min`</div><div>part, if we con=
sider `VHOST_USER_GET_QUEUE_NUM` the `max`).</div><div><br></div><div>Could=
n&#39;t we reuse the `VHOST_USER_GET_QUEUE_NUM` type for this?</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0Back-end message types<br>
=C2=A0----------------------<br>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
index 8dcf049d42..4d433cdf2b 100644<br>
--- a/hw/virtio/vhost-user.c<br>
+++ b/hw/virtio/vhost-user.c<br>
@@ -202,6 +202,13 @@ typedef struct VhostUserInflight {<br>
=C2=A0 =C2=A0 =C2=A0uint16_t queue_size;<br>
=C2=A0} VhostUserInflight;<br>
<br>
+typedef struct VhostUserBackendSpecs {<br>
+=C2=A0 =C2=A0 uint32_t device_id;<br>
+=C2=A0 =C2=A0 uint32_t config_size;<br>
+=C2=A0 =C2=A0 uint32_t min_vqs;<br>
+=C2=A0 =C2=A0 uint32_t max_vqs;<br>
+} VhostUserBackendSpecs;<br>
+<br>
=C2=A0typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0VhostUserRequest request;<br>
<br>
@@ -226,6 +233,7 @@ typedef union {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserCryptoSession session;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserVringArea area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserInflight inflight;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserBackendSpecs specs;<br>
=C2=A0} VhostUserPayload;<br>
<br>
=C2=A0typedef struct VhostUserMsg {<br>
-- <br>
2.39.2<br>
<br>
<br>
---------------------------------------------------------------------<br>
To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasi=
s-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.org</=
a><br>
For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lists.oa=
sis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</a><br=
>
<br>
</blockquote></div></div>

--0000000000007a5f3506044ae6eb--


