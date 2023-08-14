Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 593A977BDED
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 18:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVaQX-00062F-Ol; Mon, 14 Aug 2023 12:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVaQT-00061v-R4
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVaQS-0003h2-2h
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692030494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CQTmaVo+XbaeN2fnwL/v9BMHq6L+QNI4QkXvbgvxqwo=;
 b=FVsmGLZd4NvzIEU3r8N5uDKziqsVentXAleDBie9Mu9fOPITaQLyyVfIvWW1TWrMI0NQcB
 PTuFPTzMa+obS/TUr8myY7NgVOcxEu2NSnF39KEU3pvddxM7f4ZKisFjEdtWQJS2pRtk6n
 4aeflTD2K/2Zlugs10YdsJQNSrAsfFI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-4T8o2jB2PyySEGj7O3LcyA-1; Mon, 14 Aug 2023 12:28:12 -0400
X-MC-Unique: 4T8o2jB2PyySEGj7O3LcyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 206E12834763;
 Mon, 14 Aug 2023 16:28:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F208140E962;
 Mon, 14 Aug 2023 16:28:11 +0000 (UTC)
Date: Mon, 14 Aug 2023 10:17:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio: don't zero out memory region cache for
 indirect descriptors
Message-ID: <20230814141712.GB3146793@fedora>
References: <20230811143423.3258788-1-i.maximets@ovn.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oszUZKcWzjNmDC3e"
Content-Disposition: inline
In-Reply-To: <20230811143423.3258788-1-i.maximets@ovn.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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


--oszUZKcWzjNmDC3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 04:34:23PM +0200, Ilya Maximets wrote:
> Lots of virtio functions that are on a hot path in data transmission
> are initializing indirect descriptor cache at the point of stack
> allocation.  It's a 112 byte structure that is getting zeroed out on
> each call adding unnecessary overhead.  It's going to be correctly
> initialized later via special init function.  The only reason to
> actually initialize right away is the ability to safely destruct it.
> Replacing a designated initializer with a function to only initialize
> what is necessary.
>=20
> Removal of the unnecessary stack initializations improves throughput
> of virtio-net devices in terms of 64B packets per second by 6-14 %
> depending on the case.  Tested with a proposed af-xdp network backend
> and a dpdk testpmd application in the guest, but should be beneficial
> for other virtio devices as well.
>=20
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>=20
> Version 2:
>=20
>   * Introduced an initialization function, so we don't need to compare
>     pointers in the end. [Stefan]
>   * Removed the now unused macro. [Jason]
>=20
>  hw/virtio/virtio.c    | 20 +++++++++++++++-----
>  include/exec/memory.h | 16 +++++++++++++---
>  2 files changed, 28 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oszUZKcWzjNmDC3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTaN2gACgkQnKSrs4Gr
c8hM8wgAqMhJSPeoLlJ0rIDOOvW32MP3NI9DO4sY3+yhbqGTVQkCHHcwHwMQG65g
5m9z5YM471mkH5DWgdFL8aULiYmdlVt1ytoAvl2KXSVagZxad3wb0XW9m4EvzJkf
Nw1Ze2hMKyZ5Tvx3MW0R7HZA1IDXYFhu7MFzedWWihWWc+xCSUhpVQDjQVNVneQ1
MGOk90r/PeBy7HtZfT0fD3ZYkzvOdKPV967LYeibAkrtBiehgRt+elBWHutrKzUo
315UMxwpTsyKIXAqL0A+IdHt9SLLoKH1YvCkDEClAEQt36GZGHp+ESI9NQea1ti+
HgvQf1MXAFf9G3dEFH1Ja1ZWb+mT3A==
=WKj7
-----END PGP SIGNATURE-----

--oszUZKcWzjNmDC3e--


