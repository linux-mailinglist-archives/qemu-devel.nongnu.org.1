Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C9C7BA756
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRqt-000384-SN; Thu, 05 Oct 2023 13:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoRqY-0002z5-TW
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoRqX-0003NB-7b
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696525746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C4OYhYYh6PDU6+Mikb5sio+HPP/8UDtmSicOzQGR2Xk=;
 b=Ztzk+RR1vg42PaFGulQJPyTtUJ/MyeBv/D3DXRp8VljPt+jA4zbVKPPCxNSWcWIyogr+j9
 OORw/tLLbauz7wdgU48dotifzyrHgqUY+RDpXiZf/ipcgtskaxEs+b7cKzqMj10ZNa9h77
 QeZKS1zDtej523BcC3K1SUO+jqKe2a0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-kdkb6T-wNySVes5a0WdR_g-1; Thu, 05 Oct 2023 13:08:55 -0400
X-MC-Unique: kdkb6T-wNySVes5a0WdR_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EACDE3C0FC84;
 Thu,  5 Oct 2023 17:08:54 +0000 (UTC)
Received: from localhost (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4996A140E953;
 Thu,  5 Oct 2023 17:08:54 +0000 (UTC)
Date: Thu, 5 Oct 2023 13:08:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: Re: [PATCH v4 1/8] vhost-user.rst: Deprecate [GS]ET_STATUS
Message-ID: <20231005170852.GB1342722@fedora>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="g2QTlaeqbOs+6JNr"
Content-Disposition: inline
In-Reply-To: <20231004125904.110781-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--g2QTlaeqbOs+6JNr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
> There is no clearly defined purpose for the virtio status byte in
> vhost-user: For resetting, we already have RESET_DEVICE; and for virtio
> feature negotiation, we have [GS]ET_FEATURES.  With the REPLY_ACK
> protocol extension, it is possible for SET_FEATURES to return errors
> (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
>=20
> As for implementations, SET_STATUS is not widely implemented.  dpdk does
> implement it, but only uses it to signal feature negotiation failure.
> While it does log reset requests (SET_STATUS 0) as such, it effectively
> ignores them, in contrast to RESET_OWNER (which is deprecated, and today
> means the same thing as RESET_DEVICE).
>=20
> While qemu superficially has support for [GS]ET_STATUS, it does not
> forward the guest-set status byte, but instead just makes it up
> internally, and actually completely ignores what the back-end returns,
> only using it as the template for a subsequent SET_STATUS to add single
> bits to it.  Notably, after setting FEATURES_OK, it never reads it back
> to see whether the flag is still set, which is the only way in which
> dpdk uses the status byte.
>=20
> As-is, no front-end or back-end can rely on the other side handling this
> field in a useful manner, and it also provides no practical use over
> other mechanisms the vhost-user protocol has, which are more clearly
> defined.  Deprecate it.
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--g2QTlaeqbOs+6JNr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUe7aQACgkQnKSrs4Gr
c8j32wgAtMdUBKzt8i0RX1vm+5YZjCyIkwymLuqS1sgqzwaa7sFTdEzVUD05tPWQ
SCLw+j/yfDHVX0MrCYkMQLuUK6pW9g+tVKVoX34t1p/qYs3L3pikkMzBZARG7iQV
9jLmQJRf5VmXYwkWxfO6KR+sanlLFKgrRQ3rvFJChDMO2nNpuaS5cKtNZYRmlDVe
NrOSBleWq1Fkph6tLtV62dNsxcxf48Hm1LUCecOH72kE/FqhQVlz2GIYOg8cxyZG
xZ5jRzeKrS3UPjDHXfga5NZM2EY8JbOW1mY1JiPbRKu2mjDk1nPA6xC+fmvWsAlm
Er3LNvDvH24xjt9eAP7xXglToQNdyw==
=aZg/
-----END PGP SIGNATURE-----

--g2QTlaeqbOs+6JNr--


