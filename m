Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C750777CB2
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:51:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7wD-0005Hl-V5; Thu, 10 Aug 2023 11:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qU7wA-0005H4-D9
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qU7w8-0006OT-Ho
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691682654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/RJgkNLqtMXZGLmr4B8A3HlEnfOnYh+ki2/hJgDSDw=;
 b=Sm/peuAvh/nmx5gbCrI7mzvza00nomRphuzNIAX3tyNzgL3OMASJRh9M2cKHlZVX0cPLmu
 dmgn2GL9MBwibezhQ8ZEWh9zsU8zHHbd1ZVBLjSRzyVI9yj0FoW15YdaL4Kn6RHL2soT9q
 59CJbNmKHaj8N039PPpDxndgoFckTqw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-9sN4ueSiPgyblJ2dvmaIcw-1; Thu, 10 Aug 2023 11:50:51 -0400
X-MC-Unique: 9sN4ueSiPgyblJ2dvmaIcw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D1A93C0FCA2;
 Thu, 10 Aug 2023 15:50:51 +0000 (UTC)
Received: from localhost (unknown [10.39.194.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55466492B0F;
 Thu, 10 Aug 2023 15:50:49 +0000 (UTC)
Date: Thu, 10 Aug 2023 11:50:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: don't zero out memory region cache for indirect
 descriptors
Message-ID: <20230810155048.GI2931656@fedora>
References: <20230807222847.2837393-1-i.maximets@ovn.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Jy41rjd18rZTIt9n"
Content-Disposition: inline
In-Reply-To: <20230807222847.2837393-1-i.maximets@ovn.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--Jy41rjd18rZTIt9n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 12:28:47AM +0200, Ilya Maximets wrote:
> Lots of virtio functions that are on a hot path in data transmission
> are initializing indirect descriptor cache at the point of stack
> allocation.  It's a 112 byte structure that is getting zeroed out on
> each call adding unnecessary overhead.  It's going to be correctly
> initialized later via special init function.  The only reason to
> actually initialize right away is the ability to safely destruct it.
> However, we only need to destruct it when it was used, i.e. when a
> desc_cache points to it.
>=20
> Removing these unnecessary stack initializations improves throughput
> of virtio-net devices in terms of 64B packets per second by 6-14 %
> depending on the case.  Tested with a proposed af-xdp network backend
> and a dpdk testpmd application in the guest, but should be beneficial
> for other virtio devices as well.
>=20
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  hw/virtio/virtio.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)

Another option is to create an address_space_cache_init_invalid()
function that only assigns mrs.mr =3D NULL instead of touching all bytes
of the struct like =3D MEMORY_REGION_CACHE_INVALID. There would be less
code and the existing mrs.mr check in address_space_cache_destroy()
would serve the same function as the desc_cache =3D=3D &indirect_desc_cache
check added by this patch.

I'm fine with your approach too:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Jy41rjd18rZTIt9n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTVB1gACgkQnKSrs4Gr
c8jwlQf/YFHODWGJdow6MFwBDSOMQpW9Ww7SF49fzBru0WFgFsu1G48whL+u7Qkc
zvbwqWOUmjZFiPdwhaMGlm/ikVQjTMB6yQOW0ozCiogs8CwhwxadIDIkedq3dp+6
9lOf8NxTWy6CCKRlP8NT5TOlyKXBES2hRqy8wAvlbo7wwMzWvnQtfn2aimBZNHm5
9y4+W6m4b34oIfNhK4PPwzLLSaN3FgssOwFViEEXxT8j328+iiRKSKjlZJB17R0O
I+Gt5UjEXT+sB7Vc0mIzFvmM7sFT0pluO0B653jJnEAtyaXUwJNjl2OqO/wV9qbx
Xn6w2pnUAzopJMrneVWnxXsSnSwYAw==
=givq
-----END PGP SIGNATURE-----

--Jy41rjd18rZTIt9n--


