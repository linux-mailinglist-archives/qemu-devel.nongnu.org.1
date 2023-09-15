Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B307A1A9D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:34:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5Bz-0006Cx-8h; Fri, 15 Sep 2023 05:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh5Bv-0006AJ-TW
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:32:47 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh5Bs-0007Px-Ns
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:32:47 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1c4c5375329so1083825fac.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694770363; x=1695375163;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGZXjBPnKfo75/jAh2RTMR5USixA5SaasLOIoUSwwck=;
 b=eJactbyX+JdcUQ/QmeyCYCTE/6ttnT69UJHtl1XwYJxvetN4bXKgn8G2I+jj2CV2OT
 4zQO6MnC3k1UTunXUQ6FEBwPPRpJ3yHV/4giUcj6vl27YnI8cLlBGzGCYX0iZmu4tfz6
 oDMcJQg4GkCJFAvl++HSebUrK/SrUTvehZAMx6NRGYfUwk5UDraIqSJMEBVA5HO9D4ft
 IRC9V+vdiVxYHnwvzgHAg24Aa6DX+nNyTGhSNeOTx+HlkFtAWZpBcjPfN0PxLfPyKfm6
 VmJ9tZjvbdTfUdYNQJYOoUUa5OsPgpJLOZ0MoaSo0sRamJ3rz8vk1VSel48XTKcOzSiA
 r7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694770363; x=1695375163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGZXjBPnKfo75/jAh2RTMR5USixA5SaasLOIoUSwwck=;
 b=Ipd4seAC76g55+tTi3a/f2ivutNmHRHh5/RZx63GLzvsGVHdlxYpXtGFG9yfy4yLat
 +Y8mfOmd5H8esR8a0yboZkmYjdHQ8fDqbzujBNM15wCJwS+/WeEBVX+mPyLXzCTnGOwR
 xaZ0/wGispQmKUlDBcBZ0F6+d381P5em2WVNlQoXmmmaDi8InHJ3qc1f8WCfI0+t50/L
 A4481PPQJTuhI9eMk9XK7F5KII+zml7AiQvOTDkJO5rf12xBfmDdGPgjsgOe8Jt6OPuW
 MTR5nTzNwTyU7t2h5Odq2fhangx8Wz39TDLe5wo69dt4seGxP3FlNj60FKcXH84Tn1zs
 F5Tw==
X-Gm-Message-State: AOJu0YwNgAcJeI04dHCvIu2hVM+wtd/WjtGYshNL99fH8z6sMBK3au4j
 Jtuuv7x6mo7jEnjUYv+Qd0rfQdbbfCn0jfs0jBqMnA==
X-Google-Smtp-Source: AGHT+IFWaiGrJoibeHWkPyVRnu5Ie13VJl+qCw20uyf6kTDEz+adPXNpcbn7cnWLjYXj8wmcjMX8Ut6ISVGf/eCQ078=
X-Received: by 2002:a05:6870:328f:b0:1d5:aa87:69fe with SMTP id
 q15-20020a056870328f00b001d5aa8769femr1488288oac.32.1694770363052; Fri, 15
 Sep 2023 02:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-3-mnissler@rivosinc.com> <ZQIJeaZPnzSAMZyk@x1n>
In-Reply-To: <ZQIJeaZPnzSAMZyk@x1n>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Fri, 15 Sep 2023 11:32:31 +0200
Message-ID: <CAGNS4TYKVesUYepbwsLPi_-ST=c-2+=QDf5oHKhJp_UGLbXhrg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] softmmu: Support concurrent bounce buffers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, stefanha@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x33.google.com
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

On Wed, Sep 13, 2023 at 9:11=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
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
>
> Instead of hard-code this 4k again (besides the pci property), maybe we c=
an
> have address_space_init_with_bouncebuffer() and always pass it in from pc=
i
> do_realize?  Then by default no bounce buffer supported for the AS only i=
f
> requested.

I haven't verified in a running configuration, but I believe bounce
buffering is also used with non-PCI code, for example
sysbus_ahci_realize grabs &address_space_memory. So, IMO it makes
sense to keep at the old default for non-PCI address spaces, unless we
create additional knobs to set the limit for these?


>
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
> > +        }
> > +
> > +        if (l =3D=3D 0) {
> >              *plen =3D 0;
> >              return NULL;
>
> MR refcount leak?

Oops, fixing.

>
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
>
> Would assert() be better here? So that when trigger we can have the user
> stack already.

Yes, and it's something in the should-never-happen bucket, so assert
is more appropriate. Changing.

>
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
>
> Can there be race condition that someone just temporarily boosted
> bounce_buffer_size, so that it won't exactly equal to max but actually
> larger (but we should still notify)?

Ah, yes, we may have overshot in the allocation path. So this should
be >=3D then, but see below...

>
> If the current context has already a bounce buffer and is going to unmap =
it
> (len>0), IIUC it means we should always notify because there will
> definitely be some space left, and the requesters can retry to see whethe=
r
> the size fit.

The current semantics are actually more awkward: If the requested size
doesn't fit, a caller currently gets a mapping for the portion that is
below the limit, with an adjusted *plen value. So a caller that wants
more would then register their callback and get a callback when more
space frees up. I carried this over from the existing code, but I find
it extremely obscure and error-prone. I would rather change it to the
semantics you suggest, namely rejecting the entire request, but that's
a breaking API change that's hard to validate. So, maybe it's best to
do what you suggest and notify unconditionally when we free up space
and leave it to the caller to deal with whatever situation they find
(which is already the case). So, I'll drop the condition here for now,
let me know if you have a better suggestion.

>
> > +            /* Write bounce_buffer_size before reading map_client_list=
. */
> > +            smp_mb();
>
> I know it comes from the old code.. but I don't know why this is needed;
> mutex lock should contain an mb() already before the list iterations late=
r.
> Just to raise it up, maybe Paolo would like to comment.

Hm, are you sure that qemu_mutex_lock includes a full memory barrier?
The atomics docs say that pthread_mutex_lock is guaranteed to have
acquire semantics, but that doesn't guarantee that previous writes are
visible elsewhere. We need a release of bounce_buffer_size and an
acquire of map_client_list. The latter is implied by qemu_mutex_lock,
so I could arguably change this to smp_wmb().

(I hope this makes sense, memory fencing isn't my forte)

>
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
>
> --
> Peter Xu
>

