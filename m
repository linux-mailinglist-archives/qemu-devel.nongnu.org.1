Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E3763C31
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 18:17:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOgow-0003Bs-NO; Wed, 26 Jul 2023 11:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qOgnv-0002yo-Ps
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:51:59 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qOgnt-0001W2-JM
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:51:59 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1a1fa977667so208fac.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690386716; x=1690991516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WprEqAuAbIJZz871115HsgDY1p6gLyrYtPTiTay5j4=;
 b=HtlVGJsRuVWUgvbpfa9AGCRjtyGuMs0hNE1ZWgFoIbvGmGB8Y2V8XSsNrDmF0zUz8A
 BVL5PA2xJPcRSs3dMghNxBXP8vNLMvyBnQ6e4g91aC8a+uwQqVvnlznWkfVleS8k0MPV
 8r5XPoQ0vIiarj0T8L/Qc8ESQd75CdY3pQbd5+lZyI2GhvKnXqZmRDii5kxk2xA+mGpg
 3u+LsEiiwLYFXJmtA4tyy0cU6ryURmDjpIJqjQmTr/6sxdqZiJdSNKMftUSubhRrHGX0
 I+2zQS7Kg/8ybpL35I+k4sZ3ctUSP3QNS7cycykJiiTb+zwlALObZP702J9tqQiZHpkn
 02NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690386716; x=1690991516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WprEqAuAbIJZz871115HsgDY1p6gLyrYtPTiTay5j4=;
 b=fYBDpnChv0pPZF3rIBcyPoHbqe4ESsdv19VQq2T1Ttta876FoTMrPKWXNANVFYz9XF
 NdpbOjZwb/ICz5xcJCJPJ1F1RQKMpgvMAacnDkl4q9wFK0X2qvBkh2IbMXsvi/z6khZw
 YuC+539gj6ErsrcMloEPqYTyytqH5VYFiehVm9c1e3E7v2+eMZPxY4dYbOwA0tY7q9O8
 CdmkazVOkbARbcQtdRyxxcufBqmFij+H3RIb7tUPHFal7LnR9MOqoPZ5T+bHTJWv4ihB
 NuQ8kagVq/MCCIPiATf8VX1OK/xoZVrb45mraWAFn/mNiZzFjYPD84u6efnR8wSRFfev
 0dmw==
X-Gm-Message-State: ABy/qLYaojYkVBM/Hs/6u7tGvgje34B8TkJsQhRtH01LkR7lElEcR9zd
 VMbBN0TNtfuCOXfE6xtRa42SkIUs/CDmocpWq/w=
X-Google-Smtp-Source: APBJJlGndjJxhr6X5V5vglbVt6Qz0+IAFh3KM+OkTK7zYl5yQwglXkIGyz3qP1Gp4pvLExaSy6mlEfFCf3N2H2FqAPw=
X-Received: by 2002:a05:6870:b621:b0:19f:aee0:e169 with SMTP id
 cm33-20020a056870b62100b0019faee0e169mr3217136oab.30.1690386716239; Wed, 26
 Jul 2023 08:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
 <CUC6ELTTA224.2IQJTPDX8NUFJ@fedora>
In-Reply-To: <CUC6ELTTA224.2IQJTPDX8NUFJ@fedora>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 26 Jul 2023 11:51:43 -0400
Message-ID: <CAJSP0QXU7k3+J=zA=uuSfXjM=tz6wh13pabumbSEdvXFmJ6xMQ@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH] docs/interop: define STANDALONE protocol
 feature for vhost-user
To: Erik Schilling <erik.schilling@linaro.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com, 
 mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, 
 viresh.kumar@linaro.org, takahiro.akashi@linaro.org, 
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 26 Jul 2023 at 11:42, Erik Schilling <erik.schilling@linaro.org> wr=
ote:
>
> On Tue Jul 4, 2023 at 4:54 PM CEST, Stefano Garzarella wrote:
> > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=C3=A9e wrote:
> > >Currently QEMU has to know some details about the back-end to be able
> > >to setup the guest. While various parts of the setup can be delegated
> > >to the backend (for example config handling) this is a very piecemeal
> > >approach.
> > >
> > >This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALO=
NE)
> > >which the back-end can advertise which allows a probe message to be
> > >sent to get all the details QEMU needs to know in one message.
> > >
> > >Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > >
> > >---
> > >Initial RFC for discussion. I intend to prototype this work with QEMU
> > >and one of the rust-vmm vhost-user daemons.
> >
> > Thanks for starting this discussion!
> >
> > I'm comparing with vhost-vdpa IOCTLs, so my questions may be
> > superficial, but they help me understand the differences.
> >
> > >---
> > > docs/interop/vhost-user.rst | 37 ++++++++++++++++++++++++++++++++++++=
+
> > > hw/virtio/vhost-user.c      |  8 ++++++++
> > > 2 files changed, 45 insertions(+)
> > >
> > >diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > >index 5a070adbc1..85b1b1583a 100644
> > >--- a/docs/interop/vhost-user.rst
> > >+++ b/docs/interop/vhost-user.rst
> > >@@ -275,6 +275,21 @@ Inflight description
> > >
> > > :queue size: a 16-bit size of virtqueues
> > >
> > >+Backend specifications
> > >+^^^^^^^^^^^^^^^^^^^^^^
> > >+
> > >++-----------+-------------+------------+------------+
> > >+| device id | config size |   min_vqs  |   max_vqs  |
> > >++-----------+-------------+------------+------------+
> > >+
> > >+:device id: a 32-bit value holding the VirtIO device ID
> > >+
> > >+:config size: a 32-bit value holding the config size (see ``VHOST_USE=
R_GET_CONFIG``)
> > >+
> > >+:min_vqs: a 32-bit value holding the minimum number of vqs supported
> >
> > Why do we need the minimum?
> >
> > >+
> > >+:max_vqs: a 32-bit value holding the maximum number of vqs supported,=
 must be >=3D min_vqs
> >
> > Is this overlap with VHOST_USER_GET_QUEUE_NUM?
>
> While fiddeling with a rust-vmm implementation of this I wondered:
>
> Would a standalone daemon even need VHOST_USER_PROTOCOL_F_MQ if
> VHOST_USER_PROTOCOL_F_CONFIG is required anyway? It looks like
> all full virtio devices provide config information that allows to
> derive the exact or maximum number of queues already. So wouldn't
> VHOST_USER_PROTOCOL_F_MQ just provide a second, redundant way to get
> the information? (And this would be a third?)
>
> Am I missing something here? Otherwise, I think we could drop dependency
> on VHOST_USER_PROTOCOL_F_MQ and get the info from the device config for
> standalone daemons?

vhost (in general and that includes vhost-user) was not designed to be
a full VIRTIO device, just an interface for offloading specific
virtqueues. Now that vhost-user is being extended to support full
VIRTIO devices ("standalone"), some of the vhost-user protocol
features are redundant.

However, actually dropping the redundant features must be done
carefully because they might be used in ways that you don't expect by
existing vhost-user implementations. For example, maybe existing
vhost-user-net code doesn't look at the VIRTIO Configuration Space
field because it queries the number of virtqueues via
VHOST_USER_PROTOCOL_F_MQ + VHOST_USER_GET_QUEUE_NUM. So you might be
forced to keep them for compatibility.

I think the answer to your questions is: yes, but carefully because
you might break existing implementations or make it hard for them to
remain compatible.

Stefan

