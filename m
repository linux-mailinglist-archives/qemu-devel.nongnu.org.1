Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFAB75B86B
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 22:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMZnk-0000Br-M9; Thu, 20 Jul 2023 15:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMZni-0000BO-J0
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMZnh-0004X2-26
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689883139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HYVMeM6kZVR+OlIn6wXPChfp1WxiF2Vf8eMU13lCAEM=;
 b=avhWMeuYEE+4y9E7lCuNKUJmubPqvZEGkpSPZsm3Pf8I9L+wDc4Gjoa7buR5nIHFYmZMzQ
 dxY+QpQgQZRZAYzk8u24+9ZxXKYjfQvxKibgAD7dT9zpbTKEWqmiABdXMphuCXG/H3ks2G
 hTqFYi0shExmBPx98CfxSy8b0pWWZew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-rOCc9eh6MjmAnkY4mda72A-1; Thu, 20 Jul 2023 15:58:54 -0400
X-MC-Unique: rOCc9eh6MjmAnkY4mda72A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C2BB185A78B;
 Thu, 20 Jul 2023 19:58:40 +0000 (UTC)
Received: from localhost (unknown [10.39.194.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69EB51454142;
 Thu, 20 Jul 2023 19:58:39 +0000 (UTC)
Date: Thu, 20 Jul 2023 15:58:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 slp@redhat.com, marcandre.lureau@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
Message-ID: <20230720195837.GJ210977@fedora>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y3Pyr4rpz3fA5NCs"
Content-Disposition: inline
In-Reply-To: <20230706124347-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--y3Pyr4rpz3fA5NCs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2023 at 12:48:20PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=E9e wrote:
> > Currently QEMU has to know some details about the back-end to be able
> > to setup the guest. While various parts of the setup can be delegated
> > to the backend (for example config handling) this is a very piecemeal
> > approach.
>=20
> > This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALON=
E)
> > which the back-end can advertise which allows a probe message to be
> > sent to get all the details QEMU needs to know in one message.
>=20
> The reason we do piecemeal is that these existing pieces can be reused
> as others evolve or fall by wayside.
>=20
> For example, I can think of instances where you want to connect
> specifically to e.g. networking backend, and specify it
> on command line. Reasons could be many, e.g. for debugging,
> or to prevent connecting to wrong device on wrong channel
> (kind of like type safety).
>=20
> What is the reason to have 1 message? startup latency?
> How about we allow pipelining several messages then?
> Will be easier.

This flag effectively says that the back-end is a full VIRTIO device
with a Device Status Register, Configuration Space, Virtqueues, the
device type, etc. This is different from previous vhost-user devices
which sometimes just offloaded certain virtqueues without providing the
full VIRTIO device (parts were emulated in the VMM).

So for example, a vhost-user-net device does not support the controlq.
Alex's "standalone" device is a mode where the vhost-user protocol is
used but the back-end must implement a full virtio-net device.
Standalone devices are like vDPA device in this respect.

I think it is important to have a protocol feature bit that advertises
that this is a standalone device, since the semantics are different for
traditional vhost-user-net devices.

However, I think having a single message is inflexible and duplicates
existing vhost-user protocol messages like VHOST_USER_GET_QUEUE_NUM. I
would prefer VHOST_USER_GET_DEVICE_ID and other messages.

Stefan

--y3Pyr4rpz3fA5NCs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5ke0ACgkQnKSrs4Gr
c8hj3wf+OxDIxO3gPzNYxNljVy5Q+tGdkNsGXwheOv7mDLm3fRfKUpJLlFbUz7uG
lgx9e/arw5qy885ZkOA9ElHVuAEA283hk2WpnGGhW8oh3pSN9aZHx2p/cNRWBSx/
XsjghkSF0GwDXOWfhACGwVySezmpIU7lmp52XfyPNKn06u6PA6psRBQsJpr1HuHx
wt8Mck6AvhETrpBG9kzJgqFK3EDxdN4sBvbh3Yi1v+Z1AaQfWMNsmWgU1v/B+NYz
0PDGcHAlrBvIBNWRQrE/PcUf7163Mn/5XLDKaavN2udfNi/BUhifTpso9q4Jbd+J
Oezp7UpOgKRdFAcw/JOssBQJ+WfU9w==
=XMod
-----END PGP SIGNATURE-----

--y3Pyr4rpz3fA5NCs--


