Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45820747534
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:22:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhqQ-0000C1-F2; Tue, 04 Jul 2023 11:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGhqP-0000Bb-1d
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:21:33 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGhqN-0001nW-64
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:21:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-314319c0d3eso3308388f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688484089; x=1691076089;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Sgf6RWMR0QG3eTdfaCgHbY5baKorGxnyQ7qpiHVi78=;
 b=s6mao/3+flgHqOHqcbw3wRZywuHkFA9T/uFUdzrr8VqgqvUceagWuM5Z8D/e1EDVol
 t4skeRfweeGb1woJyHdcQO7HOqDAZDIh7J0Ox6rTpbJrKHB6JCILZ8aZF2iZHhbNUocf
 rgnZTDAZT6ZwXO3g39t7ktnN0z1aM4toHQuFXLcSY/sjPHDeZR1RHezZuEbDo2Pffsws
 hNSy6A/Cl5ruq60nVacp2EmbhW7Wy9ubPvTjd1hjDawxoLZ9/pv7wI8wQQ+QfoRSxMMk
 ATYp4Drf28sgYNLBd34ENFVmMekLljumgbGbGUcloOZLipr6swi9Ye/bd3xICSJInmzG
 AmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688484089; x=1691076089;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5Sgf6RWMR0QG3eTdfaCgHbY5baKorGxnyQ7qpiHVi78=;
 b=BEq775cqD15m1q+oa7JXpCJ89FIVRlDmuzBwmG4bkvpbuBJ8tfYsjJAICcWdnNmZLy
 88o2+taDioVF7h3//pPtNfzLydEfUG48RufgMQAUR6qzETly0WFYJLa87JPLS3q+MShS
 BWGYu3tBnPTkIOgf/4aAS13ZRmvo8flkEnCJ4lc6UGDODixxrEMxzQPX93bJPsGOOjGT
 /dRNwbww/vDoQGE2ARrV9+Nnop+muo67mPplNmyNi7ufvK/5QYs1oeRbTf2f0yj4NGSH
 keOKMn+MJtivdVaHan6lwTBZhxpayRnngciBjC8mUfz1y00tgxs/XdHs53tqkt4xZEOH
 MVNQ==
X-Gm-Message-State: ABy/qLYVmbh1o9/QN3IqxgqGbzPFK3ZDWScVIeTjH+RXAMmAnrSht9/K
 LmkMKilqxfNAQyEdmj9QlrFVvg==
X-Google-Smtp-Source: APBJJlHDggF2qQ/G63kZfhrdM9n1PtEIg/mh/g+JIf9cWh7ohB4QLb/CA2jKlT+NXW6i6LYncVvbwg==
X-Received: by 2002:adf:cd86:0:b0:314:36c5:e4c0 with SMTP id
 q6-20020adfcd86000000b0031436c5e4c0mr5818817wrj.11.1688484089084; 
 Tue, 04 Jul 2023 08:21:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m3-20020adff383000000b0031417b0d338sm14212584wro.87.2023.07.04.08.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 08:21:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3B5E61FFBB;
 Tue,  4 Jul 2023 16:21:28 +0100 (BST)
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
 mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com,
 viresh.kumar@linaro.org, takahiro.akashi@linaro.org,
 erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
 mathieu.poirier@linaro.org
Subject: Re: [virtio-dev] [RFC PATCH] docs/interop: define STANDALONE
 protocol feature for vhost-user
Date: Tue, 04 Jul 2023 16:02:42 +0100
In-reply-to: <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
Message-ID: <87o7krg0sn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Stefano Garzarella <sgarzare@redhat.com> writes:

> On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=C3=A9e wrote:
>>Currently QEMU has to know some details about the back-end to be able
>>to setup the guest. While various parts of the setup can be delegated
>>to the backend (for example config handling) this is a very piecemeal
>>approach.
>>
>>This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
>>which the back-end can advertise which allows a probe message to be
>>sent to get all the details QEMU needs to know in one message.
>>
>>Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>>---
>>Initial RFC for discussion. I intend to prototype this work with QEMU
>>and one of the rust-vmm vhost-user daemons.
>
> Thanks for starting this discussion!
>
> I'm comparing with vhost-vdpa IOCTLs, so my questions may be
> superficial, but they help me understand the differences.

I did have a quick read-through to get a handle on vhost-vdpa but the
docs are fairly empty. However I see there is more detail in the linux
commit so after looking at that I do wonder:

 * The kernel commit defines a subset of VIRTIO_F feature flags. Should
   we do the same for this interface?

 * The VDPA GET/SET STATUS and GET/SET CONFIG ioctls are already covered
   by the equivalent VHOST_USER messages?

>>---
>> docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>> hw/virtio/vhost-user.c      |  8 ++++++++
>> 2 files changed, 45 insertions(+)
>>
>>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>>index 5a070adbc1..85b1b1583a 100644
>>--- a/docs/interop/vhost-user.rst
>>+++ b/docs/interop/vhost-user.rst
>>@@ -275,6 +275,21 @@ Inflight description
>>
>> :queue size: a 16-bit size of virtqueues
>>
>>+Backend specifications
>>+^^^^^^^^^^^^^^^^^^^^^^
>>+
>>++-----------+-------------+------------+------------+
>>+| device id | config size |   min_vqs  |   max_vqs  |
>>++-----------+-------------+------------+------------+
>>+
>>+:device id: a 32-bit value holding the VirtIO device ID
>>+
>>+:config size: a 32-bit value holding the config size (see ``VHOST_USER_G=
ET_CONFIG``)
>>+
>>+:min_vqs: a 32-bit value holding the minimum number of vqs supported
>
> Why do we need the minimum?

We need to know the minimum number because some devices have fixed VQs
that must be present.

>
>>+
>>+:max_vqs: a 32-bit value holding the maximum number of vqs supported, mu=
st be >=3D min_vqs
>
> Is this overlap with VHOST_USER_GET_QUEUE_NUM?

Yes it does and I considered implementing a bunch of messages to fill in
around what we already have. However that seemed like it would add a
bunch of complexity to the interface when we could get all the initial
data in one go.

>
>>+
>> C structure
>> -----------
>>
>>@@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with th=
e following struct:
>>           VhostUserConfig config;
>>           VhostUserVringArea area;
>>           VhostUserInflight inflight;
>>+          VhostUserBackendSpecs specs;
>>       };
>>   } QEMU_PACKED VhostUserMsg;
>>
>>@@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
>> * ``VHOST_USER_GET_VRING_BASE``
>> * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>> * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SH=
MFD``)
>>+* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALON=
E``)
>>
>> .. seealso::
>>
>>@@ -885,6 +902,13 @@ Protocol features
>>   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>>   #define VHOST_USER_PROTOCOL_F_STATUS               16
>>   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>>+  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
>>+
>>+Some features are only valid in the presence of other supporting
>>+features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
>>+backend must also support ``VHOST_USER_PROTOCOL_F_CONFIG`` and
>>+``VHOST_USER_PROTOCOL_F_STATUS``.
>>+
>
> What about adding a new section where we will describe what we mean
> with "standalone" devices?
>
> For example that the entire virtio device is emulated in the backend,
> etc.
>
> By the way, I was thinking more about F_FULL_DEVICE, but I'm not good
> with names, so I'll just throw out an idea :-)

Naming things is hard ;-)

I could add a new section although AIUI there is nothing really in
existing daemons which is split between the front-end and back-end. The
stubs are basically boilerplate and ensure DT/PCIe hubs make the device
appear so once things are discovered QEMU never really gets involved
aside from being a dumb relay.

>
> Thanks,
> Stefano
>
>>
>> Front-end message types
>> -----------------------
>>@@ -1440,6 +1464,19 @@ Front-end message types
>>   query the back-end for its device status as defined in the Virtio
>>   specification.
>>
>>+``VHOST_USER_GET_BACKEND_SPECS``
>>+  :id: 41
>>+  :request payload: N/A
>>+  :reply payload: ``Backend specifications``
>>+
>>+  When the ``VHOST_USER_PROTOCOL_F_STANDALONE`` protocol feature has been
>>+  successfully negotiated, this message is submitted by the front-end to
>>+  query the back-end for its capabilities. This is intended to remove
>>+  the need for the front-end to know ahead of time what the VirtIO
>>+  device the backend emulates is.
>>+
>>+  The reply contains the device id, size of the config space and the
>>+  range of VirtQueues the backend supports.
>>
>> Back-end message types
>> ----------------------
>>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>index c4e0cbd702..28b021d5d3 100644
>>--- a/hw/virtio/vhost-user.c
>>+++ b/hw/virtio/vhost-user.c
>>@@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
>>     uint16_t queue_size;
>> } VhostUserInflight;
>>
>>+typedef struct VhostUserBackendSpecs {
>>+    uint32_t device_id;
>>+    uint32_t config_size;
>>+    uint32_t min_vqs;
>>+    uint32_t max_vqs;
>>+} VhostUserBackendSpecs;
>>+
>> typedef struct {
>>     VhostUserRequest request;
>>
>>@@ -226,6 +233,7 @@ typedef union {
>>         VhostUserCryptoSession session;
>>         VhostUserVringArea area;
>>         VhostUserInflight inflight;
>>+        VhostUserBackendSpecs specs;
>> } VhostUserPayload;
>>
>> typedef struct VhostUserMsg {
>> -- 2.39.2
>>
>>
>>---------------------------------------------------------------------
>>To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

