Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB87A0D7C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrPS-0003CQ-L5; Thu, 14 Sep 2023 14:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgrPO-0003Bm-Ol
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgrPK-0004jv-Jq
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694717380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8+6tRTCDyH3PXkjPbz0qRLWvkoR1wY5L/rcPQercDmQ=;
 b=IIn8prDuR2AIRxH5Rx+yYmGJA0du3QkY9Ts15rltH4Rm25WsQkcHmU2LkBmZ8h99q6m7oq
 36cMSaxCI1ydO/r4cXc23nCfgKalafFIMGufpSFHuLQIjystTxY83P9z4DKB2qg8E5Yi9O
 yAilrRo1/IYUnLTmanAtOFNdaReB9wg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301--sBBXiH-OguCvIYgBCnsSA-1; Thu, 14 Sep 2023 14:49:34 -0400
X-MC-Unique: -sBBXiH-OguCvIYgBCnsSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 067D4957577;
 Thu, 14 Sep 2023 18:49:19 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB5392026D68;
 Thu, 14 Sep 2023 18:49:17 +0000 (UTC)
Date: Thu, 14 Sep 2023 14:49:16 -0400
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
Subject: Re: [PATCH v3 2/5] softmmu: Support concurrent bounce buffers
Message-ID: <20230914184916.GB1066211@fedora>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-3-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WvN7xSlTqssAzuLa"
Content-Disposition: inline
In-Reply-To: <20230907130410.498935-3-mnissler@rivosinc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--WvN7xSlTqssAzuLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 06:04:07AM -0700, Mattias Nissler wrote:
> When DMA memory can't be directly accessed, as is the case when
> running the device model in a separate process without shareable DMA
> file descriptors, bounce buffering is used.
>=20
> It is not uncommon for device models to request mapping of several DMA
> regions at the same time. Examples include:
>  * net devices, e.g. when transmitting a packet that is split across
>    several TX descriptors (observed with igb)
>  * USB host controllers, when handling a packet with multiple data TRBs
>    (observed with xhci)
>=20
> Previously, qemu only provided a single bounce buffer per AddressSpace
> and would fail DMA map requests while the buffer was already in use. In
> turn, this would cause DMA failures that ultimately manifest as hardware
> errors from the guest perspective.
>=20
> This change allocates DMA bounce buffers dynamically instead of
> supporting only a single buffer. Thus, multiple DMA mappings work
> correctly also when RAM can't be mmap()-ed.
>=20
> The total bounce buffer allocation size is limited individually for each
> AddressSpace. The default limit is 4096 bytes, matching the previous
> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> provided to configure the limit for PCI devices.
>=20
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>  hw/pci/pci.c                |  8 ++++
>  include/exec/memory.h       | 14 ++----
>  include/hw/pci/pci_device.h |  3 ++
>  softmmu/memory.c            |  3 +-
>  softmmu/physmem.c           | 94 +++++++++++++++++++++++++------------
>  5 files changed, 80 insertions(+), 42 deletions(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 881d774fb6..8c4541b394 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -85,6 +85,8 @@ static Property pci_props[] =3D {
>                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> +    DEFINE_PROP_SIZE("x-max-bounce-buffer-size", PCIDevice,
> +                     max_bounce_buffer_size, 4096),
>      DEFINE_PROP_END_OF_LIST()
>  };
> =20
> @@ -1208,6 +1210,8 @@ static PCIDevice *do_pci_register_device(PCIDevice =
*pci_dev,
>                         "bus master container", UINT64_MAX);
>      address_space_init(&pci_dev->bus_master_as,
>                         &pci_dev->bus_master_container_region, pci_dev->n=
ame);
> +    pci_dev->bus_master_as.max_bounce_buffer_size =3D
> +        pci_dev->max_bounce_buffer_size;
> =20
>      if (phase_check(PHASE_MACHINE_READY)) {
>          pci_init_bus_master(pci_dev);
> @@ -2664,6 +2668,10 @@ static void pci_device_class_init(ObjectClass *kla=
ss, void *data)
>      k->unrealize =3D pci_qdev_unrealize;
>      k->bus_type =3D TYPE_PCI_BUS;
>      device_class_set_props(k, pci_props);
> +    object_class_property_set_description(
> +        klass, "x-max-bounce-buffer-size",
> +        "Maximum buffer size allocated for bounce buffers used for mappe=
d "
> +        "access to indirect DMA memory");
>  }
> =20
>  static void pci_device_class_base_init(ObjectClass *klass, void *data)
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 7d68936157..5577542b5e 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1081,14 +1081,6 @@ typedef struct AddressSpaceMapClient {
>      QLIST_ENTRY(AddressSpaceMapClient) link;
>  } AddressSpaceMapClient;
> =20
> -typedef struct {
> -    MemoryRegion *mr;
> -    void *buffer;
> -    hwaddr addr;
> -    hwaddr len;
> -    bool in_use;
> -} BounceBuffer;
> -
>  /**
>   * struct AddressSpace: describes a mapping of addresses to #MemoryRegio=
n objects
>   */
> @@ -1106,8 +1098,10 @@ struct AddressSpace {
>      QTAILQ_HEAD(, MemoryListener) listeners;
>      QTAILQ_ENTRY(AddressSpace) address_spaces_link;
> =20
> -    /* Bounce buffer to use for this address space. */
> -    BounceBuffer bounce;
> +    /* Maximum DMA bounce buffer size used for indirect memory map reque=
sts */
> +    uint64_t max_bounce_buffer_size;
> +    /* Total size of bounce buffers currently allocated, atomically acce=
ssed */
> +    uint64_t bounce_buffer_size;
>      /* List of callbacks to invoke when buffers free up */
>      QemuMutex map_client_list_lock;
>      QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index d3dd0f64b2..f4027c5379 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -160,6 +160,9 @@ struct PCIDevice {
>      /* ID of standby device in net_failover pair */
>      char *failover_pair_id;
>      uint32_t acpi_index;
> +
> +    /* Maximum DMA bounce buffer size used for indirect memory map reque=
sts */
> +    uint64_t max_bounce_buffer_size;
>  };
> =20
>  static inline int pci_intx(PCIDevice *pci_dev)
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 5c9622c3d6..e02799359c 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -3105,7 +3105,8 @@ void address_space_init(AddressSpace *as, MemoryReg=
ion *root, const char *name)
>      as->ioeventfds =3D NULL;
>      QTAILQ_INIT(&as->listeners);
>      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
> -    as->bounce.in_use =3D false;
> +    as->max_bounce_buffer_size =3D 4096;
> +    as->bounce_buffer_size =3D 0;
>      qemu_mutex_init(&as->map_client_list_lock);
>      QLIST_INIT(&as->map_client_list);
>      as->name =3D g_strdup(name ? name : "anonymous");
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index f40cc564b8..e3d1cf5fba 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2926,6 +2926,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr l=
en)
>                                       NULL, len, FLUSH_CACHE);
>  }
> =20
> +/*
> + * A magic value stored in the first 8 bytes of the bounce buffer struct=
=2E Used
> + * to detect illegal pointers passed to address_space_unmap.
> + */
> +#define BOUNCE_BUFFER_MAGIC 0xb4017ceb4ffe12ed
> +
> +typedef struct {
> +    uint64_t magic;
> +    MemoryRegion *mr;
> +    hwaddr addr;
> +    size_t len;
> +    uint8_t buffer[];
> +} BounceBuffer;
> +
>  static void
>  address_space_unregister_map_client_do(AddressSpaceMapClient *client)
>  {
> @@ -2953,7 +2967,7 @@ void address_space_register_map_client(AddressSpace=
 *as, QEMUBH *bh)
>      QLIST_INSERT_HEAD(&as->map_client_list, client, link);
>      /* Write map_client_list before reading bounce_buffer_size.  */
>      smp_mb();
> -    if (!qatomic_read(&as->bounce.in_use)) {
> +    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffer_si=
ze) {
>          address_space_notify_map_clients_locked(as);
>      }
>      qemu_mutex_unlock(&as->map_client_list_lock);
> @@ -3081,31 +3095,36 @@ void *address_space_map(AddressSpace *as,
>      RCU_READ_LOCK_GUARD();
>      fv =3D address_space_to_flatview(as);
>      mr =3D flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
> +    memory_region_ref(mr);
> =20
>      if (!memory_access_is_direct(mr, is_write)) {
> -        if (qatomic_xchg(&as->bounce.in_use, true)) {
> +        size_t size =3D qatomic_add_fetch(&as->bounce_buffer_size, l);
> +        if (size > as->max_bounce_buffer_size) {
> +            size_t excess =3D size - as->max_bounce_buffer_size;
> +            l -=3D excess;
> +            qatomic_sub(&as->bounce_buffer_size, excess);

I think two threads can race here. as->bounce_buffer_size will be
corrupted (smaller than it should be) and l will be wrong as well. A
cmpxchg loop would solve the race.

> +        }
> +
> +        if (l =3D=3D 0) {
>              *plen =3D 0;
>              return NULL;
>          }
> -        /* Avoid unbounded allocations */
> -        l =3D MIN(l, TARGET_PAGE_SIZE);
> -        as->bounce.buffer =3D qemu_memalign(TARGET_PAGE_SIZE, l);
> -        as->bounce.addr =3D addr;
> -        as->bounce.len =3D l;
> =20
> -        memory_region_ref(mr);
> -        as->bounce.mr =3D mr;
> +        BounceBuffer *bounce =3D g_malloc0(l + sizeof(BounceBuffer));
> +        bounce->magic =3D BOUNCE_BUFFER_MAGIC;
> +        bounce->mr =3D mr;
> +        bounce->addr =3D addr;
> +        bounce->len =3D l;
> +
>          if (!is_write) {
>              flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> -                          as->bounce.buffer, l);
> +                          bounce->buffer, l);
>          }
> =20
>          *plen =3D l;
> -        return as->bounce.buffer;
> +        return bounce->buffer;
>      }
> =20
> -
> -    memory_region_ref(mr);
>      *plen =3D flatview_extend_translation(fv, addr, len, mr, xlat,
>                                          l, is_write, attrs);
>      fuzz_dma_read_cb(addr, *plen, mr);
> @@ -3119,31 +3138,44 @@ void *address_space_map(AddressSpace *as,
>  void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>                           bool is_write, hwaddr access_len)
>  {
> -    if (buffer !=3D as->bounce.buffer) {
> -        MemoryRegion *mr;
> -        ram_addr_t addr1;
> +    MemoryRegion *mr;
> +    ram_addr_t addr1;
> +
> +    mr =3D memory_region_from_host(buffer, &addr1);
> +    if (mr =3D=3D NULL) {
> +        BounceBuffer *bounce =3D container_of(buffer, BounceBuffer, buff=
er);
> +        if (bounce->magic !=3D BOUNCE_BUFFER_MAGIC) {
> +            error_report(
> +                "Unmap request for %p, which neither corresponds to a me=
mory "
> +                "region, nor looks like a bounce buffer, ignoring!",
> +                buffer);
> +            return;
> +        }
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
> +
> +        memory_region_unref(bounce->mr);
> +        uint64_t previous_buffer_size =3D
> +            qatomic_fetch_sub(&as->bounce_buffer_size, bounce->len);
> +        if (previous_buffer_size =3D=3D as->max_bounce_buffer_size) {
> +            /* Write bounce_buffer_size before reading map_client_list. =
*/
> +            smp_mb();
> +            address_space_notify_map_clients(as);
>          }
> -        memory_region_unref(mr);
> +        bounce->magic =3D ~BOUNCE_BUFFER_MAGIC;
> +        g_free(bounce);
>          return;
>      }
> +
> +    if (xen_enabled()) {
> +        xen_invalidate_map_cache_entry(buffer);
> +    }
>      if (is_write) {
> -        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
> -                            as->bounce.buffer, access_len);
> -    }
> -    qemu_vfree(as->bounce.buffer);
> -    as->bounce.buffer =3D NULL;
> -    memory_region_unref(as->bounce.mr);
> -    /* Clear in_use before reading map_client_list.  */
> -    qatomic_set_mb(&as->bounce.in_use, false);
> -    address_space_notify_map_clients(as);
> +        invalidate_and_set_dirty(mr, addr1, access_len);
> +    }
>  }
> =20
>  void *cpu_physical_memory_map(hwaddr addr,
> --=20
> 2.34.1
>=20

--WvN7xSlTqssAzuLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUDVawACgkQnKSrs4Gr
c8g/GAgAoNLeDTH3B45uGIOqQdKv+jE37ZkV+c0F4WM1Ed4n/dIaIRBHgGzP27GI
sq7m9wUuq0BPgxXYv+jJiZ0w/ZSQH7nX2FdaTT/42j6URrwESsqqJFjRrTiRtTLq
thwnQoKFdZapEk+ZXHHzYrmG+mGfeNmWXAQesB7gb+A3jkGO4wruZCOgBz0Obv53
mAFlAFcuLRgQxy2Yx1Kl3vUSboHcGpcpl5FgXQo71AA6xJnSAkMIJCEs62CRE3/E
J0KoSowW759KE2lqHj1B37Fk5xlQSN7I64pt3vS4YYu+wXTIN6ljwcclLBQmbBTY
qS2GALsedGeroxjCz9P5uoq8dndapQ==
=W5Zd
-----END PGP SIGNATURE-----

--WvN7xSlTqssAzuLa--


