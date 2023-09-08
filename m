Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 644CA7986DE
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:11:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaK4-0001rk-R1; Fri, 08 Sep 2023 08:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qeaJf-0001Lp-4P
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:10:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qeaJQ-0002uH-PV
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:10:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso21482595e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 05:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694175008; x=1694779808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfL/UoyVLI6YDhR0TmqNb/6pYYMn0kE4Lx8j5Pk7WXs=;
 b=cxBJjiEuiAVVMwSP5sO+DYQgJhOa4SE4RoS+vOI7kEeftYquAuG8QHyxC1sKaY9Gv6
 0f1aBf3L8iWTwEOBbU8TEHP1/HY+s6FIX3FwKv7+k+mTFi98ceMtZKS+Zv2k4xqzyU4L
 xWmO5LELUJd8Hi1PLS/jgSE++r5oi7hVXSVQLWSn3C6ic5tkl/ODOC8OZfRIAEehYK0W
 Lb/qvoVGwg1gpEy3LQ25PCGhkjbZq9+ij1n0UoJX4/FU6VgfbQBCuajcjxDYmTDlhUJk
 /pp5JX7EnTxurnkoflyZm6tROjZt5ZHMTYF/jDNME6/G1wM4ztCiJHrvq5iVV9kLReAH
 5+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694175008; x=1694779808;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vfL/UoyVLI6YDhR0TmqNb/6pYYMn0kE4Lx8j5Pk7WXs=;
 b=opZlg+/Kff+HayZz8/0mMB/tdBG4o4jY0RTEGdTbmvrWApqLI/zhBvFEngkk9+OEMm
 NuW4U85GTM8kJqBSpxaV9bTsa8lMxXraiaXt54JOsxin91WMF895kjUd1BktYgzQCKOA
 iydU+wON1t2CT7RIsOuM6XvsgUqXV4rE5cYwNDlvKKdxXdnJ7JDj56hkBlRtTui0cjeg
 5mJEWBD99F6dq575IgQOZrPBCMS0rxniEWFjkkxZ5rYQav7o2HniwtNpCRpFkKDFg/5+
 s2PeA/klQBkyDmwcTiV/9uRsRFYpZLvi21w8b6PPAQpY5zMIVhq0D5Npm8O3Rrp0T5cO
 qbOw==
X-Gm-Message-State: AOJu0Yyh9Tel9TPe9ouDW1u4EVY7smnVauBSPzK6ldaIaFE7vjHYYfzm
 816uJj3I4CDDzRqI7xHn/LwhxQ==
X-Google-Smtp-Source: AGHT+IEKTrzAAZtHNqG1/BxuWLsIJEgsFw7c9MEPcrE/GeM7KoHdp+YkxfE45oHgYx0gpQNi4qqDPA==
X-Received: by 2002:a7b:c8d1:0:b0:400:f6f2:66b9 with SMTP id
 f17-20020a7bc8d1000000b00400f6f266b9mr2082682wml.12.1694175008130; 
 Fri, 08 Sep 2023 05:10:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a1c4c14000000b00402e942561fsm5045424wmf.38.2023.09.08.05.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 05:10:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 193F71FFBB;
 Fri,  8 Sep 2023 13:10:07 +0100 (BST)
References: <20230901110018.3704459-1-alex.bennee@linaro.org>
 <20230907192259.GC1560640@fedora>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: slp@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com, takahiro.akashi@linaro.org,
 erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
 mathieu.poirier@linaro.org, qemu-devel@nongnu.org,
 virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Subject: Re: [RFC PATCH v2] docs/interop: define PROBE feature for
 vhost-user VirtIO devices
Date: Fri, 08 Sep 2023 13:03:26 +0100
In-reply-to: <20230907192259.GC1560640@fedora>
Message-ID: <87v8ckzx0g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> On Fri, Sep 01, 2023 at 12:00:18PM +0100, Alex Benn=C3=A9e wrote:
>> Currently QEMU has to know some details about the VirtIO device
>> supported by a vhost-user daemon to be able to setup the guest. This
>> makes it hard for QEMU to add support for additional vhost-user
>> daemons without adding specific stubs for each additional VirtIO
>> device.
>>=20
>> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE)
>> which the back-end can advertise which allows a probe message to be
>> sent to get all the details QEMU needs to know in one message.
>>=20
>> Together with the existing features VHOST_USER_PROTOCOL_F_STATUS and
>> VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
>> daemons which are capable of handling all aspects of the VirtIO
>> transactions with only a generic stub on the QEMU side. These daemons
>> can also be used without QEMU in situations where there isn't a full
>> VMM managing their setup.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> I think the mindset for this change should be "vhost-user is becoming a
> VIRTIO Transport". VIRTIO Transports have a reasonably well-defined
> feature set in the VIRTIO specification. The goal should be to cover
> every VIRTIO Transport operation via vhost-user protocol messages so
> that the VIRTIO device model can be fully conveyed over vhost-user.

Is it though? The transport is a guest visible construct whereas
vhost-user is purely a backend implementation detail that should be
invisible to the guest.

Also the various backends do things a different set of ways. The
differences between MMIO and PCI are mostly around where config space is
and how IRQs are handled. For CCW we do actually have a set of commands
we can look at:

  #define CCW_CMD_SET_VQ 0x13=20
  #define CCW_CMD_VDEV_RESET 0x33=20
  #define CCW_CMD_SET_IND 0x43=20
  #define CCW_CMD_SET_CONF_IND 0x53=20
  #define CCW_CMD_SET_IND_ADAPTER 0x73=20
  #define CCW_CMD_READ_FEAT 0x12=20
  #define CCW_CMD_WRITE_FEAT 0x11=20
  #define CCW_CMD_READ_CONF 0x22=20
  #define CCW_CMD_WRITE_CONF 0x21=20
  #define CCW_CMD_WRITE_STATUS 0x31=20
  #define CCW_CMD_READ_VQ_CONF 0x32=20
  #define CCW_CMD_SET_VIRTIO_REV 0x83=20
  #define CCW_CMD_READ_STATUS 0x72

which I think we already have mappings for.

> Anything less is yet another ad-hoc protocol extension that will lead to
> more bugs and hacks when it turns out some VIRTIO devices cannot be
> expressed due to limitations in the protocol.

I agree we want to do this right.

> This requires going through the VIRTIO spec to find a correspondence
> between virtio-pci/virtio-mmio/virtio-ccw's interfaces and vhost-user
> protocol messages. In most cases vhost-user already offers messages and
> your patch adds more of what is missing. I think this effort is already
> very close but missing the final check that it really matches the VIRTIO
> spec.
>
> Please do the comparison against the VIRTIO Transports and then adjust
> this patch to make it clear that the back-end is becoming a full-fledged
> VIRTIO Transport:
> - The name of the patch series should reflect that.
> - The vhost-user protocol feature should be named F_TRANSPORT.
> - The messages added in this patch should have a 1:1 correspondence with
>   the VIRTIO spec including using the same terminology for consistency.
>
> Sorry for the hassle, but I think this is a really crucial point where
> we have the chance to make vhost-user work smoothly in the future...but
> only if we can faithfully expose VIRTIO Transport semantics.

I wonder if first be handled by cleaning up the VirtIO spec to make it
clear what capabilities each transport needs to support?

>> ---
>> v2
>>   - dropped F_STANDALONE in favour of F_PROBE
>>   - split probe details across several messages
>>   - probe messages don't automatically imply a standalone daemon
>>   - add wording where probe details interact (F_MQ/F_CONFIG)
>>   - define VMM and make clear QEMU is only one of many potential VMMs
>>   - reword commit message
>> ---
>>  docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++++-----
>>  hw/virtio/vhost-user.c      |  8 ++++
>>  2 files changed, 88 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 5a070adbc1..ba3b5e07b7 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -7,6 +7,7 @@ Vhost-user Protocol
>>  ..
>>    Copyright 2014 Virtual Open Systems Sarl.
>>    Copyright 2019 Intel Corporation
>> +  Copyright 2023 Linaro Ltd
>>    Licence: This work is licensed under the terms of the GNU GPL,
>>             version 2 or later. See the COPYING file in the top-level
>>             directory.
>> @@ -27,17 +28,31 @@ The protocol defines 2 sides of the communication, *=
front-end* and
>>  *back-end*. The *front-end* is the application that shares its virtqueu=
es, in
>>  our case QEMU. The *back-end* is the consumer of the virtqueues.
>>=20=20
>> -In the current implementation QEMU is the *front-end*, and the *back-en=
d*
>> -is the external process consuming the virtio queues, for example a
>> -software Ethernet switch running in user space, such as Snabbswitch,
>> -or a block device back-end processing read & write to a virtual
>> -disk. In order to facilitate interoperability between various back-end
>> -implementations, it is recommended to follow the :ref:`Backend program
>> -conventions <backend_conventions>`.
>> +In the current implementation a Virtual Machine Manager (VMM) such as
>> +QEMU is the *front-end*, and the *back-end* is the external process
>> +consuming the virtio queues, for example a software Ethernet switch
>> +running in user space, such as Snabbswitch, or a block device back-end
>> +processing read & write to a virtual disk. In order to facilitate
>> +interoperability between various back-end implementations, it is
>> +recommended to follow the :ref:`Backend program conventions
>> +<backend_conventions>`.
>>=20=20
>>  The *front-end* and *back-end* can be either a client (i.e. connecting)=
 or
>>  server (listening) in the socket communication.
>>=20=20
>> +Probing device details
>> +----------------------
>> +
>> +Traditionally the vhost-user daemon *back-end* shares configuration
>> +responsibilities with the VMM *front-end* which needs to know certain
>> +key bits of information about the device. This means the VMM needs to
>> +define at least a minimal stub for each VirtIO device it wants to
>> +support. If the daemon supports the right set of protocol features the
>> +VMM can probe the daemon for the information it needs to setup the
>> +device.
>
> "... without a per-device stub in the VMM"
>
> This makes it clear that this sentence is describing an alternative
> to the per-device stub in the VMM.
>
>> See :ref:`Probing features for standalone daemons
>> +<probing_features>` for more details.
>
> The current section is named "Probing device details" and one being
> reference is called "Probing features for standalone daemons". Are
> "features" or "device details" two terms for the same thing? Why
> "daemons" and not "back-end"?
>
> I suggest calling this section "Standalone back-ends" and the other
> section "Probing standalone back-ends" to keep the terminology
> consistent.
>
>> +
>> +
>>  Support for platforms other than Linux
>>  --------------------------------------
>>=20=20
>> @@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
>>  * ``VHOST_USER_GET_VRING_BASE``
>>  * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>>  * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_S=
HMFD``)
>> +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALO=
NE``)
>
> F_STANDALONE vs F_PROBE
>
> "SPECS" vs "features" vs "details".
>
> Please be consistent.
>
>>=20=20
>>  .. seealso::
>>=20=20
>> @@ -396,9 +412,10 @@ must support changing some configuration aspects on=
 the fly.
>>  Multiple queue support
>>  ----------------------
>>=20=20
>> -Many devices have a fixed number of virtqueues.  In this case the front=
-end
>> -already knows the number of available virtqueues without communicating =
with the
>> -back-end.
>> +Many devices have a fixed number of virtqueues. In this case the
>> +*front-end* usually already knows the number of available virtqueues
>> +without communicating with the back-end. For standalone daemons this
>
> "Usually" is vague. It's possible to be precise:
>
>   In this case a front-end that is aware of the device type already
>                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   knows the number of available virtqueues without communicating with
>   the back-end.
>
>> +number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` message.
>
> Then this sentence can be adjusted to:
>
>   When the front-end is not aware of the device type, the number can be
>   probed with the ``VHOST_USER_GET_MIN_VQ`` message.
>
>>=20=20
>>  Some devices do not have a fixed number of virtqueues.  Instead the max=
imum
>>  number of virtqueues is chosen by the back-end.  The number can depend =
on host
>> @@ -885,6 +902,23 @@ Protocol features
>>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>> +  #define VHOST_USER_PROTOCOL_F_PROBE                18
>> +
>> +.. _probing_features:
>> +
>> +Probing features for standalone daemons
>> +---------------------------------------
>> +
>> +The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a number
>> +of additional messages which allow the *front-end* to probe details
>> +about the VirtIO device from the *back-end*. However for a *back-end*
>> +to be described as standalone it must also support:
>> +
>> +  * ``VHOST_USER_PROTOCOL_F_STATUS``
>> +  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)
>> +
>> +which are required to ensure the *back-end* daemon can operate
>> +without the *front-end* managing some aspects of its configuration.
>>=20=20
>>  Front-end message types
>>  -----------------------
>> @@ -1440,6 +1474,42 @@ Front-end message types
>>    query the back-end for its device status as defined in the Virtio
>>    specification.
>>=20=20
>> +``VHOST_USER_GET_DEVICE_ID``
>> +  :id: 41
>> +  :request payload: N/A
>> +  :reply payload: ``u32``
>> +
>> +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
>> +  successfully negotiated, this message is submitted by the front-end
>> +  to query what VirtIO device the back-end support. This is intended
>> +  to remove the need for the front-end to know ahead of time what the
>> +  VirtIO device the backend emulates is.
>
> "... VIRTIO device type that the backend emulates is."
>
> "Device type" is the name used in the VIRTIO spec.
>
>> +
>> +``VHOST_USER_GET_CONFIG_SIZE``
>> +  :id: 42
>> +  :request payload: N/A
>> +  :reply payload: ``u32``
>> +
>> +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
>> +  successfully negotiated, this message is submitted by the front-end
>> +  to query the size of the VirtIO device's config space. This is
>> +  intended to remove the need for the front-end to know ahead of time
>> +  what the size is. Replying with 0 when
>> +  ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would indicate
>> +  an bug.
>
> "a bug"
>
> What is the harm in returning 0 when the device has an empty
> Configuration Space like the Entropy device, the I2C Adapter, the SCMI
> device, etc?
>
>> +
>> +``VHOST_USER_GET_MIN_VQ``
>> +  :id: 43
>> +  :request payload: N/A
>> +  :reply payload: ``u32``
>> +
>> +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
>> +  successfully negotiated, this message is submitted by the front-end to
>> +  query minimum number of VQ's required to support the device. A
>> +  device may support more than this number of VQ's if it advertises
>> +  the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting a
>> +  number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`` would
>> +  indicate a bug.
>
> What is the purpose of this message? I don't see an equivalent in the
> VIRTIO specification.
>
>>=20=20
>>  Back-end message types
>>  ----------------------
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 8dcf049d42..4d433cdf2b 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
>>      uint16_t queue_size;
>>  } VhostUserInflight;
>>=20=20
>> +typedef struct VhostUserBackendSpecs {
>> +    uint32_t device_id;
>> +    uint32_t config_size;
>> +    uint32_t min_vqs;
>> +    uint32_t max_vqs;
>> +} VhostUserBackendSpecs;
>
> This message is undocumented? I think it may be outdated and you split
> it up into individual messages.
>
>> +
>>  typedef struct {
>>      VhostUserRequest request;
>>=20=20
>> @@ -226,6 +233,7 @@ typedef union {
>>          VhostUserCryptoSession session;
>>          VhostUserVringArea area;
>>          VhostUserInflight inflight;
>> +        VhostUserBackendSpecs specs;
>>  } VhostUserPayload;
>>=20=20
>>  typedef struct VhostUserMsg {
>> --=20
>> 2.39.2
>>=20


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

