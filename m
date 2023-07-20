Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC375B80E
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 21:34:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMZOI-0001pn-5V; Thu, 20 Jul 2023 15:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMZOF-0001pI-Eo
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMZOE-0006lY-3M
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689881561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NN9Fw6sJgMeCWsXeEas2cfUu0AU4JllUyt8qnMpKqe4=;
 b=HzdFagP4/ody5jB16fygHEbw2cGm1Cmx6+qtP4GJ3hXyFmLk0zlZV53x+lC1Fu0pYpIjgE
 jryiq7nYY3RxkC94Y8FNG4QylTGAJ9lPsS//ZeWMRTTM/8CiFeMWE6v9mWnxyoolqng7vE
 LiYaEpSi8/MP/1PeGB/SiV8NKqJM4jU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-79x0Q-uAPjSfJMr-Mo7ZOQ-1; Thu, 20 Jul 2023 15:32:37 -0400
X-MC-Unique: 79x0Q-uAPjSfJMr-Mo7ZOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45F0E8F186F;
 Thu, 20 Jul 2023 19:32:36 +0000 (UTC)
Received: from localhost (unknown [10.39.194.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1B112166B25;
 Thu, 20 Jul 2023 19:32:35 +0000 (UTC)
Date: Thu, 20 Jul 2023 15:32:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
 mst@redhat.com, marcandre.lureau@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
Message-ID: <20230720193234.GG210977@fedora>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rMZ6YtjoAS9abvaN"
Content-Disposition: inline
In-Reply-To: <20230704123600.1808604-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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


--rMZ6YtjoAS9abvaN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=E9e wrote:
> Currently QEMU has to know some details about the back-end to be able
> to setup the guest. While various parts of the setup can be delegated
> to the backend (for example config handling) this is a very piecemeal
> approach.
>=20
> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> which the back-end can advertise which allows a probe message to be
> sent to get all the details QEMU needs to know in one message.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> ---
> Initial RFC for discussion. I intend to prototype this work with QEMU
> and one of the rust-vmm vhost-user daemons.
> ---
>  docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/vhost-user.c      |  8 ++++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..85b1b1583a 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -275,6 +275,21 @@ Inflight description
> =20
>  :queue size: a 16-bit size of virtqueues
> =20
> +Backend specifications
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-----------+-------------+------------+------------+
> +| device id | config size |   min_vqs  |   max_vqs  |
> ++-----------+-------------+------------+------------+
> +
> +:device id: a 32-bit value holding the VirtIO device ID
> +
> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_G=
ET_CONFIG``)
> +
> +:min_vqs: a 32-bit value holding the minimum number of vqs supported

What is the purpose of min_vqs? I'm not sure why the front-end needs to
know this.

--rMZ6YtjoAS9abvaN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5i9EACgkQnKSrs4Gr
c8hlaQf+MbQ3pGRCXVnZ2FthmpJQmXxTTV436fhUOR1qKE5SOQrFXu7mDSgXGDiw
QYu+czDiW9kF8mkAqLjIw4+8mnStX4/Ck4OM5VvssbS90SpwNo1SSynskVN75OVb
/mk3ej0dHARZ8CU4YlmkvdgM5E5iaglvyDuYTSL1CkO13VgtGmNn5dEUBE+yxApc
VoEyMTz4IE2leIYp6lTI84X7g1fR6ib+ZzYWPTYuLQvG+OMqjgSwlfjUG6B16Y6a
J9mq7dHxThkLGOtA6gKfKQHpSnlwVsNepC9fomWSa3KpSAfebaLtDNgav8rcYTAQ
azD62I/PzUC/bpIAjVa/gJpFkJMzsQ==
=VjIe
-----END PGP SIGNATURE-----

--rMZ6YtjoAS9abvaN--


