Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E47A0DD2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 21:05:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgreA-0005Zi-5q; Thu, 14 Sep 2023 15:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgre8-0005ZH-HF
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgre6-0000uJ-C8
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694718296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8T7kZ6D+Vga8tU2SkxPIvB2DiizYeBdyoGyS8dsBCqo=;
 b=fptM41DDmZZ1H5hhAoal4e7fXSZeaJ8AkAMXSPIXfdrhwsvp0xeTWA+pim7r4NKwLpCjV1
 42d0gh5IH8MHWN6GRCXIoKiBn6xdDsWzVusJIf+ZQ1ervz7VjcOtpcXSGyZAXs6nspu26w
 jyZ5wgE22nVtoLCeFzCTmaynPz0ZiDE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-nvwVX7roPHW9QXkx6E2J-A-1; Thu, 14 Sep 2023 15:04:51 -0400
X-MC-Unique: nvwVX7roPHW9QXkx6E2J-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA919857A9E;
 Thu, 14 Sep 2023 19:04:50 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33DEA40F2D4C;
 Thu, 14 Sep 2023 19:04:50 +0000 (UTC)
Date: Thu, 14 Sep 2023 15:04:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/5] vfio-user: Message-based DMA support
Message-ID: <20230914190448.GC1066211@fedora>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-5-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lTFQxu/QaX2zm2N6"
Content-Disposition: inline
In-Reply-To: <20230907130410.498935-5-mnissler@rivosinc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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


--lTFQxu/QaX2zm2N6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 06:04:09AM -0700, Mattias Nissler wrote:
> Wire up support for DMA for the case where the vfio-user client does not
> provide mmap()-able file descriptors, but DMA requests must be performed
> via the VFIO-user protocol. This installs an indirect memory region,
> which already works for pci_dma_{read,write}, and pci_dma_map works
> thanks to the existing DMA bounce buffering support.
>=20
> Note that while simple scenarios work with this patch, there's a known
> race condition in libvfio-user that will mess up the communication
> channel. See https://github.com/nutanix/libvfio-user/issues/279 for
> details as well as a proposed fix.
>=20
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>  hw/remote/trace-events    |  2 +
>  hw/remote/vfio-user-obj.c | 84 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 79 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/remote/trace-events b/hw/remote/trace-events
> index 0d1b7d56a5..358a68fb34 100644
> --- a/hw/remote/trace-events
> +++ b/hw/remote/trace-events
> @@ -9,6 +9,8 @@ vfu_cfg_read(uint32_t offset, uint32_t val) "vfu: cfg: 0x=
%x -> 0x%x"
>  vfu_cfg_write(uint32_t offset, uint32_t val) "vfu: cfg: 0x%x <- 0x%x"
>  vfu_dma_register(uint64_t gpa, size_t len) "vfu: registering GPA 0x%"PRI=
x64", %zu bytes"
>  vfu_dma_unregister(uint64_t gpa) "vfu: unregistering GPA 0x%"PRIx64""
> +vfu_dma_read(uint64_t gpa, size_t len) "vfu: DMA read 0x%"PRIx64", %zu b=
ytes"
> +vfu_dma_write(uint64_t gpa, size_t len) "vfu: DMA write 0x%"PRIx64", %zu=
 bytes"
>  vfu_bar_register(int i, uint64_t addr, uint64_t size) "vfu: BAR %d: addr=
 0x%"PRIx64" size 0x%"PRIx64""
>  vfu_bar_rw_enter(const char *op, uint64_t addr) "vfu: %s request for BAR=
 address 0x%"PRIx64""
>  vfu_bar_rw_exit(const char *op, uint64_t addr) "vfu: Finished %s of BAR =
address 0x%"PRIx64""
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 8b10c32a3c..cee5e615a9 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -300,6 +300,63 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_=
ctx, char * const buf,
>      return count;
>  }
> =20
> +static MemTxResult vfu_dma_read(void *opaque, hwaddr addr, uint64_t *val,
> +                                unsigned size, MemTxAttrs attrs)
> +{
> +    MemoryRegion *region =3D opaque;
> +    VfuObject *o =3D VFU_OBJECT(region->owner);
> +    uint8_t buf[sizeof(uint64_t)];
> +
> +    trace_vfu_dma_read(region->addr + addr, size);
> +
> +    dma_sg_t *sg =3D alloca(dma_sg_size());

Variable-length arrays have recently been removed from QEMU and
alloca(3) is a similar case. An example is commit
b3c8246750b7077add335559341268f2956f6470 ("hw/nvme: Avoid dynamic stack
allocation").

libvfio-user returns a sane sizeof(struct dma_sg) value so we don't need
to worry about bogus values, so the risk is low here.

However, its hard to scan for and forbid the dangerous alloca(3) calls
when exceptions are made for some alloca(3) uses.

I would avoid alloca(3) and instead use:

  g_autofree dma_sg_t *sg =3D g_new(dma_sg_size(), 1);

> +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> +    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_READ) < =
0 ||
> +        vfu_sgl_read(o->vfu_ctx, sg, 1, buf) !=3D 0) {
> +        return MEMTX_ERROR;
> +    }
> +
> +    *val =3D ldn_he_p(buf, size);
> +
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult vfu_dma_write(void *opaque, hwaddr addr, uint64_t val,
> +                                 unsigned size, MemTxAttrs attrs)
> +{
> +    MemoryRegion *region =3D opaque;
> +    VfuObject *o =3D VFU_OBJECT(region->owner);
> +    uint8_t buf[sizeof(uint64_t)];
> +
> +    trace_vfu_dma_write(region->addr + addr, size);
> +
> +    stn_he_p(buf, size, val);
> +
> +    dma_sg_t *sg =3D alloca(dma_sg_size());

Same here.

> +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> +    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_WRITE) <=
 0 ||
> +        vfu_sgl_write(o->vfu_ctx, sg, 1, buf) !=3D 0)  {
> +        return MEMTX_ERROR;
> +    }
> +
> +    return MEMTX_OK;
> +}
> +
> +static const MemoryRegionOps vfu_dma_ops =3D {
> +    .read_with_attrs =3D vfu_dma_read,
> +    .write_with_attrs =3D vfu_dma_write,
> +    .endianness =3D DEVICE_HOST_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +        .unaligned =3D true,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +};
> +
>  static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
>  {
>      VfuObject *o =3D vfu_get_private(vfu_ctx);
> @@ -308,17 +365,30 @@ static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dm=
a_info_t *info)
>      g_autofree char *name =3D NULL;
>      struct iovec *iov =3D &info->iova;
> =20
> -    if (!info->vaddr) {
> -        return;
> -    }
> -
>      name =3D g_strdup_printf("mem-%s-%"PRIx64"", o->device,
> -                           (uint64_t)info->vaddr);
> +                           (uint64_t)iov->iov_base);
> =20
>      subregion =3D g_new0(MemoryRegion, 1);
> =20
> -    memory_region_init_ram_ptr(subregion, NULL, name,
> -                               iov->iov_len, info->vaddr);
> +    if (info->vaddr) {
> +        memory_region_init_ram_ptr(subregion, OBJECT(o), name,
> +                                   iov->iov_len, info->vaddr);
> +    } else {
> +        /*
> +         * Note that I/O regions' MemoryRegionOps handle accesses of at =
most 8
> +         * bytes at a time, and larger accesses are broken down. However,
> +         * many/most DMA accesses are larger than 8 bytes and VFIO-user =
can
> +         * handle large DMA accesses just fine, thus this size restricti=
on
> +         * unnecessarily hurts performance, in particular given that each
> +         * access causes a round trip on the VFIO-user socket.
> +         *
> +         * TODO: Investigate how to plumb larger accesses through memory
> +         * regions, possibly by amending MemoryRegionOps or by creating =
a new
> +         * memory region type.
> +         */
> +        memory_region_init_io(subregion, OBJECT(o), &vfu_dma_ops, subreg=
ion,
> +                              name, iov->iov_len);
> +    }
> =20
>      dma_as =3D pci_device_iommu_address_space(o->pci_dev);
> =20
> --=20
> 2.34.1
>=20

--lTFQxu/QaX2zm2N6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUDWVAACgkQnKSrs4Gr
c8gX/Qf+LhRWl5h8Iu5iYgp/bwees5LjAEEUithGcQ1M+l3nys6kjhdNpPrXvq37
80DUsMW5emsv8YlBa+q4MiDXI/Sy45aHI/g+hpiWnAFj4wlrF5tecCUld5SwQf9e
odK4yj8oovMwx8PTckG2kSF+zRL1GuppFJWdEA/phrW2WeoB7TIv4nj7LHbJT3MV
zfBee0FdaPpx6leYKApn7QV6UONlTsqmvdV4RUlTUxeYrNRFP4rUKdTfFU+c8eIx
ZbwxHssGaf6GK9K8IymFLTCKbngaCXa4YhgPwZ0X5WA2pS/ytcNNytVgcL1Sb3e5
Ct+G5Ix9RAJk4S/oinIkcv/yjAArcg==
=ePjt
-----END PGP SIGNATURE-----

--lTFQxu/QaX2zm2N6--


