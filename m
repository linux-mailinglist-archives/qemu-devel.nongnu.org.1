Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 776BB75B6DD
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:33:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYRr-0006JF-HD; Thu, 20 Jul 2023 14:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMYRl-0006Io-T6
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMYRj-0008Ie-4C
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689877933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBeavTAxOKOLO4B17dwQPvsT2H16qoPdb03fwoNwVdQ=;
 b=VpnvO/zj/YTzNV1huxJhD4ck+RDSExKWuZo0jpwZ74GHFBDsKD+AKhgBECUxAMPAnPJ/Ay
 NsLRdBhNT30+rBbuNsOD1mHfoFba7Hh3iEd6u1XDVlyP0abpoxGJTtZ3rT4F9LuQyxP4FG
 BzRkpCjZiSDhBOHkIxW2anPmRpKpJFc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-E8PnX9ygNDiWy_mXZ02daQ-1; Thu, 20 Jul 2023 14:32:09 -0400
X-MC-Unique: E8PnX9ygNDiWy_mXZ02daQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4197538149B3;
 Thu, 20 Jul 2023 18:32:09 +0000 (UTC)
Received: from localhost (unknown [10.39.194.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E0A9492CAC;
 Thu, 20 Jul 2023 18:32:08 +0000 (UTC)
Date: Thu, 20 Jul 2023 14:32:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, john.levon@nutanix.com
Subject: Re: [PATCH 3/3] vfio-user: Message-based DMA support
Message-ID: <20230720183206.GD210977@fedora>
References: <20230704080628.852525-1-mnissler@rivosinc.com>
 <20230704080628.852525-4-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5w7hDItjmNqoVw1W"
Content-Disposition: inline
In-Reply-To: <20230704080628.852525-4-mnissler@rivosinc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--5w7hDItjmNqoVw1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 01:06:27AM -0700, Mattias Nissler wrote:
> Wire up support for DMA for the case where the vfio-user client does not
> provide mmap()-able file descriptors, but DMA requests must be performed
> via the VFIO-user protocol. This installs an indirect memory region,
> which already works for pci_dma_{read,write}, and pci_dma_map works
> thanks to the existing DMA bounce buffering support.
>=20
> Note that while simple scenarios work with this patch, there's a known
> race condition in libvfio-user that will mess up the communication
> channel: https://github.com/nutanix/libvfio-user/issues/279 I intend to
> contribute a fix for this problem, see discussion on the github issue
> for more details.
>=20
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>  hw/remote/vfio-user-obj.c | 62 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 55 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 8b10c32a3c..9799580c77 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -300,6 +300,53 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_=
ctx, char * const buf,
>      return count;
>  }
> =20
> +static MemTxResult vfu_dma_read(void *opaque, hwaddr addr, uint64_t *val,
> +                                unsigned size, MemTxAttrs attrs)
> +{
> +    MemoryRegion *region =3D opaque;
> +    VfuObject *o =3D VFU_OBJECT(region->owner);
> +
> +    dma_sg_t *sg =3D alloca(dma_sg_size());
> +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> +    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_READ) < =
0 ||
> +        vfu_sgl_read(o->vfu_ctx, sg, 1, val) !=3D 0) {

Does this work on big-endian host CPUs? It looks like reading 0x12345678
into uint64_t val would result in *val =3D 0x12345678xxxxxxxx instead of
0x12345678.

> +        return MEMTX_ERROR;
> +    }
> +
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult vfu_dma_write(void *opaque, hwaddr addr, uint64_t val,
> +                                 unsigned size, MemTxAttrs attrs)
> +{
> +    MemoryRegion *region =3D opaque;
> +    VfuObject *o =3D VFU_OBJECT(region->owner);
> +
> +    dma_sg_t *sg =3D alloca(dma_sg_size());
> +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> +    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_WRITE) <=
 0 ||
> +        vfu_sgl_write(o->vfu_ctx, sg, 1, &val) !=3D 0)  {

Same potential endianness issue here.

Stefan

--5w7hDItjmNqoVw1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5faYACgkQnKSrs4Gr
c8ieaAf+IH3Ln9nSIJUKNJwZDysYiAE2Cebd/Z0wRb4BjBb6FSkT6jBQ5Twm1aJz
t1BymxvPUGVPH2VwkEIiQzLXEwLEPpCrcckSF6ta5dKHbpYY7gaIWGNo3DWespZz
PVPOXDHslkHsW0rNUG/3hCuWNPejEHlBghZg7TcG3YOn4t2CxKsPVBSOXdsjS4H0
V57dnSMYed4I+HcsH9fJ/vn1y0hOWDd76lC8e54ihg0WsFsC/T9q3m0fB+hyLsNx
pRFSuJ2PiNhaDc+CGFF2bnF5RDydRDxJTGNrrpQTrjGoXDqhZTX3uLYhd6jHZIds
G7YIbfo0QEExalBbwHrz1cKDCCKpaw==
=8HqA
-----END PGP SIGNATURE-----

--5w7hDItjmNqoVw1W--


