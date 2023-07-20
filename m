Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 162F875B631
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:11:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMY6d-0002So-1o; Thu, 20 Jul 2023 14:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMY6a-0002Rr-P8
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMY6Y-0002Eg-Ln
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689876621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vjoVUAms732qgiJX+Tmuzw5YOWuU0V/MH6YOSBHqhzk=;
 b=OXHsNnYDNyB9xA1FGCruvH0Z5HiFvmrVTGGeWwnzrWwhbF2vNNUZSMdJk9x09CVDRedGZ2
 EJO7aBhQROAsa0csAZb3Ic/K9LBErwEBHNjqNTLnLACm/WvGZaGpDml/A9bhdrrgjtF1cN
 7/YVLDgO0yJPFHSDyReE9hTub3P2xQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-DHDB_L5yPDWm0NCPuJ40DA-1; Thu, 20 Jul 2023 14:10:17 -0400
X-MC-Unique: DHDB_L5yPDWm0NCPuJ40DA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3445B80123E;
 Thu, 20 Jul 2023 18:10:17 +0000 (UTC)
Received: from localhost (unknown [10.39.194.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B62A200B41D;
 Thu, 20 Jul 2023 18:10:16 +0000 (UTC)
Date: Thu, 20 Jul 2023 14:10:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, john.levon@nutanix.com
Subject: Re: [PATCH 1/3] softmmu: Support concurrent bounce buffers
Message-ID: <20230720181014.GA210977@fedora>
References: <20230704080628.852525-1-mnissler@rivosinc.com>
 <20230704080628.852525-2-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="snxJfucOnYkYHfbc"
Content-Disposition: inline
In-Reply-To: <20230704080628.852525-2-mnissler@rivosinc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--snxJfucOnYkYHfbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 01:06:25AM -0700, Mattias Nissler wrote:
> It is not uncommon for device models to request mapping of several DMA
> regions at the same time. An example is igb (and probably other net
> devices as well) when a packet is spread across multiple descriptors.
>=20
> In order to support this when indirect DMA is used, as is the case when
> running the device model in a vfio-server process without mmap()-ed DMA,
> this change allocates DMA bounce buffers dynamically instead of
> supporting only a single buffer.
>=20
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>  softmmu/physmem.c | 74 ++++++++++++++++++++++-------------------------
>  1 file changed, 35 insertions(+), 39 deletions(-)

Is this a functional change or purely a performance optimization? If
it's a performance optimization, please include benchmark results to
justify this change.

QEMU memory allocations must be bounded so that an untrusted guest
cannot cause QEMU to exhaust host memory. There must be a limit to the
amount of bounce buffer memory.

> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index bda475a719..56130b5a1d 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2904,13 +2904,11 @@ void cpu_flush_icache_range(hwaddr start, hwaddr =
len)
> =20
>  typedef struct {
>      MemoryRegion *mr;
> -    void *buffer;
>      hwaddr addr;
> -    hwaddr len;
> -    bool in_use;
> +    uint8_t buffer[];
>  } BounceBuffer;
> =20
> -static BounceBuffer bounce;
> +static size_t bounce_buffers_in_use;
> =20
>  typedef struct MapClient {
>      QEMUBH *bh;
> @@ -2947,7 +2945,7 @@ void cpu_register_map_client(QEMUBH *bh)
>      QLIST_INSERT_HEAD(&map_client_list, client, link);
>      /* Write map_client_list before reading in_use.  */
>      smp_mb();
> -    if (!qatomic_read(&bounce.in_use)) {
> +    if (qatomic_read(&bounce_buffers_in_use)) {
>          cpu_notify_map_clients_locked();
>      }
>      qemu_mutex_unlock(&map_client_list_lock);
> @@ -3076,31 +3074,24 @@ void *address_space_map(AddressSpace *as,
>      RCU_READ_LOCK_GUARD();
>      fv =3D address_space_to_flatview(as);
>      mr =3D flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
> +    memory_region_ref(mr);
> =20
>      if (!memory_access_is_direct(mr, is_write)) {
> -        if (qatomic_xchg(&bounce.in_use, true)) {
> -            *plen =3D 0;
> -            return NULL;
> -        }
> -        /* Avoid unbounded allocations */
> -        l =3D MIN(l, TARGET_PAGE_SIZE);
> -        bounce.buffer =3D qemu_memalign(TARGET_PAGE_SIZE, l);
> -        bounce.addr =3D addr;
> -        bounce.len =3D l;
> -
> -        memory_region_ref(mr);
> -        bounce.mr =3D mr;
> +        qatomic_inc_fetch(&bounce_buffers_in_use);
> +
> +        BounceBuffer *bounce =3D g_malloc(l + sizeof(BounceBuffer));
> +        bounce->addr =3D addr;
> +        bounce->mr =3D mr;
> +
>          if (!is_write) {
>              flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> -                               bounce.buffer, l);
> +                          bounce->buffer, l);
>          }
> =20
>          *plen =3D l;
> -        return bounce.buffer;
> +        return bounce->buffer;

Bounce buffer allocation always succeeds now. Can the
cpu_notify_map_clients*() be removed now that no one is waiting for
bounce buffers anymore?

>      }
> =20
> -
> -    memory_region_ref(mr);
>      *plen =3D flatview_extend_translation(fv, addr, len, mr, xlat,
>                                          l, is_write, attrs);
>      fuzz_dma_read_cb(addr, *plen, mr);
> @@ -3114,31 +3105,36 @@ void *address_space_map(AddressSpace *as,
>  void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>                           bool is_write, hwaddr access_len)
>  {
> -    if (buffer !=3D bounce.buffer) {
> -        MemoryRegion *mr;
> -        ram_addr_t addr1;
> +    MemoryRegion *mr;
> +    ram_addr_t addr1;
> +
> +    mr =3D memory_region_from_host(buffer, &addr1);
> +    if (mr =3D=3D NULL) {
> +        /*
> +         * Must be a bounce buffer (unless the caller passed a pointer w=
hich
> +         * wasn't returned by address_space_map, which is illegal).
> +         */
> +        BounceBuffer *bounce =3D container_of(buffer, BounceBuffer, buff=
er);
> =20
> -        mr =3D memory_region_from_host(buffer, &addr1);
> -        assert(mr !=3D NULL);
>          if (is_write) {
> -            invalidate_and_set_dirty(mr, addr1, access_len);
> +            address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFIED,
> +                                bounce->buffer, access_len);
>          }
> -        if (xen_enabled()) {
> -            xen_invalidate_map_cache_entry(buffer);
> +        memory_region_unref(bounce->mr);
> +        g_free(bounce);
> +
> +        if (qatomic_dec_fetch(&bounce_buffers_in_use) =3D=3D 1) {
> +            cpu_notify_map_clients();
>          }
> -        memory_region_unref(mr);
>          return;
>      }
> +
> +    if (xen_enabled()) {
> +        xen_invalidate_map_cache_entry(buffer);
> +    }
>      if (is_write) {
> -        address_space_write(as, bounce.addr, MEMTXATTRS_UNSPECIFIED,
> -                            bounce.buffer, access_len);
> -    }
> -    qemu_vfree(bounce.buffer);
> -    bounce.buffer =3D NULL;
> -    memory_region_unref(bounce.mr);
> -    /* Clear in_use before reading map_client_list.  */
> -    qatomic_set_mb(&bounce.in_use, false);
> -    cpu_notify_map_clients();
> +        invalidate_and_set_dirty(mr, addr1, access_len);
> +    }
>  }
> =20
>  void *cpu_physical_memory_map(hwaddr addr,
> --=20
> 2.34.1
>=20

--snxJfucOnYkYHfbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5eIYACgkQnKSrs4Gr
c8iZtQf+O1rv99M7q6j1bIXTou+IGWibVSMv9ePzFISlfARKrvpI6pLQvtg1Bgn7
RX/4keWNn/0o7rriSmU73xxLz1JXAdv+8CKP1yZvNrDPvkGWSRGIWbuRRpHVGhRO
0qQTxOs7omv2hNYXKOOifOmYtNkUbWMRrz1S/CWGiCLMRapfF7OOyJ5kwcyAStBm
DXUOWham/R8mHaEpBlIIVOPS7hWSw81lDy6KyGcXVOVXQSMXbBzdhQs3nonLgEPQ
Qu9HK/tt8MWLjTWMaYJ9eAehe8dyi5vDmWpKpfH27HKXrdjb5me+Tu3upKBf9qOY
Q9WZxUem09uGenlt5aE4gL+aa6oDeQ==
=SGSe
-----END PGP SIGNATURE-----

--snxJfucOnYkYHfbc--


