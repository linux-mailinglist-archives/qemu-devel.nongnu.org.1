Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC277A1B64
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:55:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5Wu-0003nR-K7; Fri, 15 Sep 2023 05:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh5Wl-0003fE-L7
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:54:20 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh5Wj-0004GJ-6o
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:54:19 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1d5a8cb70d3so1115797fac.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694771655; x=1695376455;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0CWu5tCXVg6Y4VGrUovgPdQBDcCc51WrMDMfWirxX0=;
 b=SzaaJnPnle5NLPRv/eimbpHZQhULN0zSOEHid036bWG9QvBvYn9cO9SFi07JFWMg70
 Kje87L6a5rnDj6gAuce0CpH5WAFt/9uWJl0KyqtOgUMlLI7E1UJBUEo9EO+Bra3RPgmU
 OBz/bGtUoaXAw5tttXteed+X53+SaAAKSrOg7NaVqDMZ05M3gyNVOok0k2614x4UXfQV
 q4JxTbdRkjkx37LxnKK4HhcFHtcMitY3yP9y9uDZLmYv9t32rB+8ycIKIusTKmjXJGZ1
 RMRkumHYg8r/i2sERyoku5TvxXaxBmFgodcPnukUekf07745h3qudJUz3Kgllk4jdMXv
 d/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694771655; x=1695376455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0CWu5tCXVg6Y4VGrUovgPdQBDcCc51WrMDMfWirxX0=;
 b=AjEftuNkjwRJMscsVRjT3EKCUHSWktp5hwk48xJIg938gYqw9EWFi94yPZcXVehozH
 DZLBU9vti4ov0AyUTo+6ygLAWw/SNeQD1B9hk+NwXJmbk96PkSczBWUhGPI70BQyE/O7
 CdTXx+wsbn99ka/TQmqhFQESFqoLeOrFpZD/p99qAmaq/WAFkpGNvYJGc5hoZduHGEwH
 FmK/3hnHH2N4OaH0OYslBRkwqUskbn7qBND2x9z6wosvXuR0ZlU8nfiyGYN1pkOdMgCF
 yELTXTJUwfH9Ue4BU4PTXoqdccOk9e2mRtz/3hpDFtTzJcz9GT/TpzeTkaUh3mVSbfYm
 Zy4A==
X-Gm-Message-State: AOJu0YxOlN4H3rTiX9YxUWIgcrdH7fgqPtTjPn8IPe3pRlmT2wZwtJHr
 R2TGUYfKD5rdrVckF+ObcD2pF8bl2Hk+/Vu7c9Lt8g==
X-Google-Smtp-Source: AGHT+IG+yWftOIA8Py55T6nUwlZO5Bq1iOCz1sSo51RgI+qMzT8hf2sGV2P1uLynd8FgtX1U/Vu1FIPe90zjZfJgI6M=
X-Received: by 2002:a05:6871:592:b0:1d5:5659:4730 with SMTP id
 u18-20020a056871059200b001d556594730mr1421270oan.37.1694771655319; Fri, 15
 Sep 2023 02:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-3-mnissler@rivosinc.com>
 <20230914184916.GB1066211@fedora>
In-Reply-To: <20230914184916.GB1066211@fedora>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Fri, 15 Sep 2023 11:54:04 +0200
Message-ID: <CAGNS4TY25pDuopFTkkzNSrBu+5Q23-evsv_+65XWCte7ba64uw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] softmmu: Support concurrent bounce buffers
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 14, 2023 at 8:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Thu, Sep 07, 2023 at 06:04:07AM -0700, Mattias Nissler wrote:
> > When DMA memory can't be directly accessed, as is the case when
> > running the device model in a separate process without shareable DMA
> > file descriptors, bounce buffering is used.
> >
> > It is not uncommon for device models to request mapping of several DMA
> > regions at the same time. Examples include:
> >  * net devices, e.g. when transmitting a packet that is split across
> >    several TX descriptors (observed with igb)
> >  * USB host controllers, when handling a packet with multiple data TRBs
> >    (observed with xhci)
> >
> > Previously, qemu only provided a single bounce buffer per AddressSpace
> > and would fail DMA map requests while the buffer was already in use. In
> > turn, this would cause DMA failures that ultimately manifest as hardwar=
e
> > errors from the guest perspective.
> >
> > This change allocates DMA bounce buffers dynamically instead of
> > supporting only a single buffer. Thus, multiple DMA mappings work
> > correctly also when RAM can't be mmap()-ed.
> >
> > The total bounce buffer allocation size is limited individually for eac=
h
> > AddressSpace. The default limit is 4096 bytes, matching the previous
> > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > provided to configure the limit for PCI devices.
> >
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > ---
> >  hw/pci/pci.c                |  8 ++++
> >  include/exec/memory.h       | 14 ++----
> >  include/hw/pci/pci_device.h |  3 ++
> >  softmmu/memory.c            |  3 +-
> >  softmmu/physmem.c           | 94 +++++++++++++++++++++++++------------
> >  5 files changed, 80 insertions(+), 42 deletions(-)
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 881d774fb6..8c4541b394 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -85,6 +85,8 @@ static Property pci_props[] =3D {
> >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > +    DEFINE_PROP_SIZE("x-max-bounce-buffer-size", PCIDevice,
> > +                     max_bounce_buffer_size, 4096),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >
> > @@ -1208,6 +1210,8 @@ static PCIDevice *do_pci_register_device(PCIDevic=
e *pci_dev,
> >                         "bus master container", UINT64_MAX);
> >      address_space_init(&pci_dev->bus_master_as,
> >                         &pci_dev->bus_master_container_region, pci_dev-=
>name);
> > +    pci_dev->bus_master_as.max_bounce_buffer_size =3D
> > +        pci_dev->max_bounce_buffer_size;
> >
> >      if (phase_check(PHASE_MACHINE_READY)) {
> >          pci_init_bus_master(pci_dev);
> > @@ -2664,6 +2668,10 @@ static void pci_device_class_init(ObjectClass *k=
lass, void *data)
> >      k->unrealize =3D pci_qdev_unrealize;
> >      k->bus_type =3D TYPE_PCI_BUS;
> >      device_class_set_props(k, pci_props);
> > +    object_class_property_set_description(
> > +        klass, "x-max-bounce-buffer-size",
> > +        "Maximum buffer size allocated for bounce buffers used for map=
ped "
> > +        "access to indirect DMA memory");
> >  }
> >
> >  static void pci_device_class_base_init(ObjectClass *klass, void *data)
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 7d68936157..5577542b5e 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -1081,14 +1081,6 @@ typedef struct AddressSpaceMapClient {
> >      QLIST_ENTRY(AddressSpaceMapClient) link;
> >  } AddressSpaceMapClient;
> >
> > -typedef struct {
> > -    MemoryRegion *mr;
> > -    void *buffer;
> > -    hwaddr addr;
> > -    hwaddr len;
> > -    bool in_use;
> > -} BounceBuffer;
> > -
> >  /**
> >   * struct AddressSpace: describes a mapping of addresses to #MemoryReg=
ion objects
> >   */
> > @@ -1106,8 +1098,10 @@ struct AddressSpace {
> >      QTAILQ_HEAD(, MemoryListener) listeners;
> >      QTAILQ_ENTRY(AddressSpace) address_spaces_link;
> >
> > -    /* Bounce buffer to use for this address space. */
> > -    BounceBuffer bounce;
> > +    /* Maximum DMA bounce buffer size used for indirect memory map req=
uests */
> > +    uint64_t max_bounce_buffer_size;
> > +    /* Total size of bounce buffers currently allocated, atomically ac=
cessed */
> > +    uint64_t bounce_buffer_size;
> >      /* List of callbacks to invoke when buffers free up */
> >      QemuMutex map_client_list_lock;
> >      QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
> > diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> > index d3dd0f64b2..f4027c5379 100644
> > --- a/include/hw/pci/pci_device.h
> > +++ b/include/hw/pci/pci_device.h
> > @@ -160,6 +160,9 @@ struct PCIDevice {
> >      /* ID of standby device in net_failover pair */
> >      char *failover_pair_id;
> >      uint32_t acpi_index;
> > +
> > +    /* Maximum DMA bounce buffer size used for indirect memory map req=
uests */
> > +    uint64_t max_bounce_buffer_size;
> >  };
> >
> >  static inline int pci_intx(PCIDevice *pci_dev)
> > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > index 5c9622c3d6..e02799359c 100644
> > --- a/softmmu/memory.c
> > +++ b/softmmu/memory.c
> > @@ -3105,7 +3105,8 @@ void address_space_init(AddressSpace *as, MemoryR=
egion *root, const char *name)
> >      as->ioeventfds =3D NULL;
> >      QTAILQ_INIT(&as->listeners);
> >      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
> > -    as->bounce.in_use =3D false;
> > +    as->max_bounce_buffer_size =3D 4096;
> > +    as->bounce_buffer_size =3D 0;
> >      qemu_mutex_init(&as->map_client_list_lock);
> >      QLIST_INIT(&as->map_client_list);
> >      as->name =3D g_strdup(name ? name : "anonymous");
> > diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> > index f40cc564b8..e3d1cf5fba 100644
> > --- a/softmmu/physmem.c
> > +++ b/softmmu/physmem.c
> > @@ -2926,6 +2926,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr=
 len)
> >                                       NULL, len, FLUSH_CACHE);
> >  }
> >
> > +/*
> > + * A magic value stored in the first 8 bytes of the bounce buffer stru=
ct. Used
> > + * to detect illegal pointers passed to address_space_unmap.
> > + */
> > +#define BOUNCE_BUFFER_MAGIC 0xb4017ceb4ffe12ed
> > +
> > +typedef struct {
> > +    uint64_t magic;
> > +    MemoryRegion *mr;
> > +    hwaddr addr;
> > +    size_t len;
> > +    uint8_t buffer[];
> > +} BounceBuffer;
> > +
> >  static void
> >  address_space_unregister_map_client_do(AddressSpaceMapClient *client)
> >  {
> > @@ -2953,7 +2967,7 @@ void address_space_register_map_client(AddressSpa=
ce *as, QEMUBH *bh)
> >      QLIST_INSERT_HEAD(&as->map_client_list, client, link);
> >      /* Write map_client_list before reading bounce_buffer_size.  */
> >      smp_mb();
> > -    if (!qatomic_read(&as->bounce.in_use)) {
> > +    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffer_=
size) {
> >          address_space_notify_map_clients_locked(as);
> >      }
> >      qemu_mutex_unlock(&as->map_client_list_lock);
> > @@ -3081,31 +3095,36 @@ void *address_space_map(AddressSpace *as,
> >      RCU_READ_LOCK_GUARD();
> >      fv =3D address_space_to_flatview(as);
> >      mr =3D flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
> > +    memory_region_ref(mr);
> >
> >      if (!memory_access_is_direct(mr, is_write)) {
> > -        if (qatomic_xchg(&as->bounce.in_use, true)) {
> > +        size_t size =3D qatomic_add_fetch(&as->bounce_buffer_size, l);
> > +        if (size > as->max_bounce_buffer_size) {
> > +            size_t excess =3D size - as->max_bounce_buffer_size;
> > +            l -=3D excess;
> > +            qatomic_sub(&as->bounce_buffer_size, excess);
>
> I think two threads can race here. as->bounce_buffer_size will be
> corrupted (smaller than it should be) and l will be wrong as well. A
> cmpxchg loop would solve the race.

Ah, thanks for pointing this out. I think the case you have in mind is this=
:
1. Thread A bumps the size to be larger than the max
2. Thread B bumps the size further
3. Thread B now computes an incorrect excess and sutracts more than it adde=
d.

I should be good if I ensure that each thread will only subtract what
it has previously added to enforce the invariant that additions and
subtractions for each map/unmap pair cancel each other out. Let me
know if there's a reason to still prefer the cmpxchg loop.

>
> > +        }
> > +
> > +        if (l =3D=3D 0) {
> >              *plen =3D 0;
> >              return NULL;
> >          }
> > -        /* Avoid unbounded allocations */
> > -        l =3D MIN(l, TARGET_PAGE_SIZE);
> > -        as->bounce.buffer =3D qemu_memalign(TARGET_PAGE_SIZE, l);
> > -        as->bounce.addr =3D addr;
> > -        as->bounce.len =3D l;
> >
> > -        memory_region_ref(mr);
> > -        as->bounce.mr =3D mr;
> > +        BounceBuffer *bounce =3D g_malloc0(l + sizeof(BounceBuffer));
> > +        bounce->magic =3D BOUNCE_BUFFER_MAGIC;
> > +        bounce->mr =3D mr;
> > +        bounce->addr =3D addr;
> > +        bounce->len =3D l;
> > +
> >          if (!is_write) {
> >              flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> > -                          as->bounce.buffer, l);
> > +                          bounce->buffer, l);
> >          }
> >
> >          *plen =3D l;
> > -        return as->bounce.buffer;
> > +        return bounce->buffer;
> >      }
> >
> > -
> > -    memory_region_ref(mr);
> >      *plen =3D flatview_extend_translation(fv, addr, len, mr, xlat,
> >                                          l, is_write, attrs);
> >      fuzz_dma_read_cb(addr, *plen, mr);
> > @@ -3119,31 +3138,44 @@ void *address_space_map(AddressSpace *as,
> >  void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
> >                           bool is_write, hwaddr access_len)
> >  {
> > -    if (buffer !=3D as->bounce.buffer) {
> > -        MemoryRegion *mr;
> > -        ram_addr_t addr1;
> > +    MemoryRegion *mr;
> > +    ram_addr_t addr1;
> > +
> > +    mr =3D memory_region_from_host(buffer, &addr1);
> > +    if (mr =3D=3D NULL) {
> > +        BounceBuffer *bounce =3D container_of(buffer, BounceBuffer, bu=
ffer);
> > +        if (bounce->magic !=3D BOUNCE_BUFFER_MAGIC) {
> > +            error_report(
> > +                "Unmap request for %p, which neither corresponds to a =
memory "
> > +                "region, nor looks like a bounce buffer, ignoring!",
> > +                buffer);
> > +            return;
> > +        }
> >
> > -        mr =3D memory_region_from_host(buffer, &addr1);
> > -        assert(mr !=3D NULL);
> >          if (is_write) {
> > -            invalidate_and_set_dirty(mr, addr1, access_len);
> > +            address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFI=
ED,
> > +                                bounce->buffer, access_len);
> >          }
> > -        if (xen_enabled()) {
> > -            xen_invalidate_map_cache_entry(buffer);
> > +
> > +        memory_region_unref(bounce->mr);
> > +        uint64_t previous_buffer_size =3D
> > +            qatomic_fetch_sub(&as->bounce_buffer_size, bounce->len);
> > +        if (previous_buffer_size =3D=3D as->max_bounce_buffer_size) {
> > +            /* Write bounce_buffer_size before reading map_client_list=
. */
> > +            smp_mb();
> > +            address_space_notify_map_clients(as);
> >          }
> > -        memory_region_unref(mr);
> > +        bounce->magic =3D ~BOUNCE_BUFFER_MAGIC;
> > +        g_free(bounce);
> >          return;
> >      }
> > +
> > +    if (xen_enabled()) {
> > +        xen_invalidate_map_cache_entry(buffer);
> > +    }
> >      if (is_write) {
> > -        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIE=
D,
> > -                            as->bounce.buffer, access_len);
> > -    }
> > -    qemu_vfree(as->bounce.buffer);
> > -    as->bounce.buffer =3D NULL;
> > -    memory_region_unref(as->bounce.mr);
> > -    /* Clear in_use before reading map_client_list.  */
> > -    qatomic_set_mb(&as->bounce.in_use, false);
> > -    address_space_notify_map_clients(as);
> > +        invalidate_and_set_dirty(mr, addr1, access_len);
> > +    }
> >  }
> >
> >  void *cpu_physical_memory_map(hwaddr addr,
> > --
> > 2.34.1
> >

