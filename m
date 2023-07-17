Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B675618A
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 13:27:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLMMj-0003qG-Kh; Mon, 17 Jul 2023 07:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1qLMMg-0003pg-W6
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1qLMMd-0005Eq-Do
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689593161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hRrUs2Hkyve85DTSSg2FFoZ584trOokNE0jfUNRpkWE=;
 b=NbUgtRDPHvpUGLzxYyPgUnT7NQnetijwSpt5336u1567XOpciXhbfSTJLxftw1iy7IpJId
 qihD26VTKMXzyPC/k/l96bPP+sMSs6stS4776l6kQ6U7yyVHr+SOnQxx8g3sqoC48zyBMn
 lEtCY6voSOtDlcB/dV8E0QOevpghogk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-AhXmUqncO-mvGKNq-XeHWg-1; Mon, 17 Jul 2023 07:24:43 -0400
X-MC-Unique: AhXmUqncO-mvGKNq-XeHWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4A8B3C025A2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 11:24:42 +0000 (UTC)
Received: from localhost (unknown [10.39.192.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F62040C2063;
 Mon, 17 Jul 2023 11:24:42 +0000 (UTC)
Date: Mon, 17 Jul 2023 13:26:01 +0200
From: Sergio Lopez <slp@redhat.com>
To: Erico Nunes <ernunes@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH 0/3] vhost-user-gpu: support dmabuf modifiers
Message-ID: <azpcbbhbvuy4dfy7fozrnjivqdvfblenmwxvcbxqnhugd3r2nz@32an5mdwndv3>
References: <20230714153900.475857-1-ernunes@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ohkgtn2e44ga5ddl"
Content-Disposition: inline
In-Reply-To: <20230714153900.475857-1-ernunes@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=slp@redhat.com;
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


--ohkgtn2e44ga5ddl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 05:38:57PM +0200, Erico Nunes wrote:
> virglrenderer recently added virgl_renderer_resource_get_info_ext as a
> new api, which gets resource information, including dmabuf modifiers.
> https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1024
>=20
> We have to support dmabuf modifiers since the driver may choose to
> allocate buffers with these modifiers to improve performance, and
> importing buffers without modifiers information may result in completely
> broken rendering.
>=20
> Currently trying to use vhost-user-gpu for rendering backend and using
> the qemu dbus ui as a ui backend results in a broken framebuffer with
> Intel GPUs as the buffer is allocated with a modifier. With this
> patchset, that is fixed.
>=20
>=20
> It is tricky to support since it requires to keep compatibility at the
> same time with:
> (1) build against older virglrenderer which do not provide
> virgl_renderer_resource_get_info_ext;
> (2) runtime between frontend (qemu) and backend (vhost-user-gpu) due to
> increased size and a new field in the VHOST_USER_GPU_DMABUF_SCANOUT
> message.
>=20
> I tried to reach a compromise here by not defining a completely new
> message and duplicate VHOST_USER_GPU_DMABUF_SCANOUT but it still feels
> like a bit of a hack, so I appreciate feedback if there is a better way
> (or naming) to handle it.
>=20
>=20
> Erico Nunes (3):
>   docs: vhost-user-gpu: add protocol changes for dmabuf modifiers
>   contrib/vhost-user-gpu: add support for sending dmabuf modifiers
>   vhost-user-gpu: support dmabuf modifiers
>=20
>  contrib/vhost-user-gpu/vhost-user-gpu.c |  5 ++-
>  contrib/vhost-user-gpu/virgl.c          | 51 +++++++++++++++++++++++--
>  contrib/vhost-user-gpu/vugpu.h          |  9 +++++
>  docs/interop/vhost-user-gpu.rst         | 26 ++++++++++++-
>  hw/display/vhost-user-gpu.c             | 17 ++++++++-
>  5 files changed, 102 insertions(+), 6 deletions(-)

Series:

Reviewed-by: Sergio Lopez <slp@redhat.com>

--ohkgtn2e44ga5ddl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAmS1JTgACgkQ9GknjS8M
AjXThw//S86vche0gT3LEht7Ltg5eLsCd1T5z0rrr2f8GKbyv/1NBq5mbPwqFIGP
574cKIb9FFus59lEPNTOA1gpqphFznF4gZvx7qqlvSCFSMaj8LfmmRAE3GAR6Y0p
QIeCwH9OUur1R5PdfzKDXaT56yfa1TvY0YPCd3s4EzGadop9FlZ+RGshvSJpfy8J
1uDf0a+zAriGTz1V+ePJ2xD6j5dQZUBzFVH7RYZQ9BTTI+D8a2IKtENTZxbu0yXk
bW+invZ/HtQP4yuFVyse6QSH/AjfLfhmbtzYcvg6nLlzVMiUskcR7BLXew9a/F0V
hV5TGwYcv4VFMZV6uWPrMFMO5Giti7WCJT8dA/lhm30qMEpzs8JVFmDlJwzz1Ajs
scuMJ6PmxeHDsGo/k6+nQ4LAjiSjmvlns4OE7sWJdX+H2aDeYPQZky0fvv1pAeZk
a0lH21eNY14y4U4g9GGyZyQG55P50KO5MIiCN3Y40u0eMHPR/qVCSFnVu+HYQZR5
WFD4V1Aoh3zK0po4Ekik+NwWZt53md0N/4n9IiasmvLDdP3RzvyDLcl4k4cSpozV
JxP3HVXamWHi9YBjfp8cPE5hWn5AH8kJ2ylRb36Ixm4vfzxAFStdFPgXO5rKEF38
6cK27psqHBywrudVgCq0xWqKVeBz5HKMtnSKjZhrhyWmI8ZUmgc=
=QKB8
-----END PGP SIGNATURE-----

--ohkgtn2e44ga5ddl--


