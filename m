Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FD676399E
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:54:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfZt-0001wg-3z; Wed, 26 Jul 2023 10:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.schilling@linaro.org>)
 id 1qOfZk-0001rY-Vw
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:33:22 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.schilling@linaro.org>)
 id 1qOfZj-0000Z7-Bt
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:33:16 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b9bd59d465so4143421fa.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690381992; x=1690986792;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pViL/FEWSCvqR77nc27bQATw7ZUyDr29opMEGtl2MNE=;
 b=rXgfJD47yvb0uqKUUFwFvL3YxCIwH5P0s3lpqmU5ze+TWJ0o2OIFZJ1Yv92N1gM2q9
 tupv1uTMiyL7paSSTW/Ecv2B/VNRqf8syXn81YdFmg/lfnPsGze3YJlkP4+cwyEpxqU4
 uszJF5D3mczJMD2dXGNTVwehLnXMw7cVSGPNhUUl2sf/dp960gwikQCJ/ux7dPddOlSj
 vSl7TcAZkGngfUmcsfhvmAkIQR0BtZmagOdJoQIdDkm+NxuLB4vKux/iHl0zdqyX5m8f
 N0Cd79kwv8qwXlUFjw623YA+NCto9PCa70KFaz77q1ZZ2gpAIH6W/gOSgiloFxLCdVsf
 zVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690381992; x=1690986792;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pViL/FEWSCvqR77nc27bQATw7ZUyDr29opMEGtl2MNE=;
 b=D0DvZMsCAyyOu2V5z9AKMG4H/wSdvJFCQCMeA568J7jviPmfvpmNDgyxAxWJrj/GRj
 nwtygwyPvc9PYn+cVF0iWYFChMtsq09fmtnGi+d+KWrgUtH00evUwEeDLb7S2sIuaOQl
 zuq/SwCqIGvTTnIcLcu8vAMGQDQULm9R+6TgJTeHoeeT699W+m6e9Xb8+EoCHBAwItNL
 4bQ7PHnqaFMHxAM7gpVeVvBY0IK8tzqggIpSnNnoVXcgZQ5Y1h/cd959XprekN2wjAKh
 Ag/6rtFn0Xxwf7sBDsOutz15JwKWMdLO01KI0uI6JMinBSA5v/6Bh95kbIQ5kNe0/f19
 3imQ==
X-Gm-Message-State: ABy/qLa0LVT+thfvcdmrU0AiFmyyepBsRCKNimirI3RG005ILkOZ1BVn
 8uAj2nrjEPj0dNYtF9CoONwrtw==
X-Google-Smtp-Source: APBJJlHUwii7W+KwQ1NfDnWhfzW5fkiQbt44ts8vXYSHAEVpMwgMZLaQo2D3Zw2iRalZP+8ruQW+wA==
X-Received: by 2002:a2e:9c82:0:b0:2b6:e623:7b57 with SMTP id
 x2-20020a2e9c82000000b002b6e6237b57mr1557680lji.25.1690381992109; 
 Wed, 26 Jul 2023 07:33:12 -0700 (PDT)
Received: from localhost (i5C7438C1.versanet.de. [92.116.56.193])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a1709062b0f00b0098ce63e36e9sm9749736ejg.16.2023.07.26.07.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 07:33:11 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jul 2023 16:33:10 +0200
Message-Id: <CUC6ELTTA224.2IQJTPDX8NUFJ@fedora>
Subject: Re: [virtio-dev] [RFC PATCH] docs/interop: define STANDALONE
 protocol feature for vhost-user
Cc: <qemu-devel@nongnu.org>, <virtio-dev@lists.oasis-open.org>,
 <slp@redhat.com>, <mst@redhat.com>, <marcandre.lureau@redhat.com>,
 <stefanha@redhat.com>, <viresh.kumar@linaro.org>,
 <takahiro.akashi@linaro.org>, <manos.pitsidianakis@linaro.org>,
 <mathieu.poirier@linaro.org>
To: "Stefano Garzarella" <sgarzare@redhat.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
From: "Erik Schilling" <erik.schilling@linaro.org>
X-Mailer: aerc 0.14.0
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
In-Reply-To: <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=erik.schilling@linaro.org; helo=mail-lj1-x233.google.com
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

On Tue Jul 4, 2023 at 4:54 PM CEST, Stefano Garzarella wrote:
> On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=C3=A9e wrote:
> >Currently QEMU has to know some details about the back-end to be able
> >to setup the guest. While various parts of the setup can be delegated
> >to the backend (for example config handling) this is a very piecemeal
> >approach.
> >
> >This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE=
)
> >which the back-end can advertise which allows a probe message to be
> >sent to get all the details QEMU needs to know in one message.
> >
> >Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> >---
> >Initial RFC for discussion. I intend to prototype this work with QEMU
> >and one of the rust-vmm vhost-user daemons.
>
> Thanks for starting this discussion!
>
> I'm comparing with vhost-vdpa IOCTLs, so my questions may be
> superficial, but they help me understand the differences.
>
> >---
> > docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
> > hw/virtio/vhost-user.c      |  8 ++++++++
> > 2 files changed, 45 insertions(+)
> >
> >diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >index 5a070adbc1..85b1b1583a 100644
> >--- a/docs/interop/vhost-user.rst
> >+++ b/docs/interop/vhost-user.rst
> >@@ -275,6 +275,21 @@ Inflight description
> >
> > :queue size: a 16-bit size of virtqueues
> >
> >+Backend specifications
> >+^^^^^^^^^^^^^^^^^^^^^^
> >+
> >++-----------+-------------+------------+------------+
> >+| device id | config size |   min_vqs  |   max_vqs  |
> >++-----------+-------------+------------+------------+
> >+
> >+:device id: a 32-bit value holding the VirtIO device ID
> >+
> >+:config size: a 32-bit value holding the config size (see ``VHOST_USER_=
GET_CONFIG``)
> >+
> >+:min_vqs: a 32-bit value holding the minimum number of vqs supported
>
> Why do we need the minimum?
>
> >+
> >+:max_vqs: a 32-bit value holding the maximum number of vqs supported, m=
ust be >=3D min_vqs
>
> Is this overlap with VHOST_USER_GET_QUEUE_NUM?

While fiddeling with a rust-vmm implementation of this I wondered:

Would a standalone daemon even need VHOST_USER_PROTOCOL_F_MQ if
VHOST_USER_PROTOCOL_F_CONFIG is required anyway? It looks like
all full virtio devices provide config information that allows to
derive the exact or maximum number of queues already. So wouldn't
VHOST_USER_PROTOCOL_F_MQ just provide a second, redundant way to get
the information? (And this would be a third?)

Am I missing something here? Otherwise, I think we could drop dependency
on VHOST_USER_PROTOCOL_F_MQ and get the info from the device config for
standalone daemons?

- Erik

