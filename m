Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685B79F1C7
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 21:12:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgVHR-0001mZ-Ni; Wed, 13 Sep 2023 15:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgVHP-0001mQ-RX
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgVHM-0008Sh-S0
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694632318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBTA5wiySKmVRgeKv9TVKhYF4yr/jAdvfk2DDVx5t3c=;
 b=fImn0JAZxNFCUq4WhImkwSj0FmwXsTFFRXKjkcYvEMtsXLMSdfc0xP9eoi8kqV9fuw6uBw
 9PQVG2L1nH44UOOq67L7CEaUbIYkF9Fge73iuvS5Q+RrZR+9c6nVOJg7E3QEDmEKRiR3kU
 zJs910OrhkIQUinQOEpcNjRuqfUdxxU=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-nAxZv8xsNJudyLH9lCH3yg-1; Wed, 13 Sep 2023 15:11:57 -0400
X-MC-Unique: nAxZv8xsNJudyLH9lCH3yg-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7a287a3a71cso25645241.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 12:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694632317; x=1695237117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBTA5wiySKmVRgeKv9TVKhYF4yr/jAdvfk2DDVx5t3c=;
 b=sdM3A5KbrqGfgd+bD5cKGFBy3t+JVTScqEVw3RI1fDf9P7sWF3HE4RQnj8skgFa+XJ
 lTRvrLcjjz2TZapQrhyMJINyHbip6Z1gOsFqvhW49dgEB5sJ7tLynHllXvNp0RCSUlWg
 saKEuR961hUdRQegcupE6tDhK2zOFSUBeepPRMDuYUIzp4kbbQpkI12gveiRofxjgE1b
 6yFcmvCM0/upDgh/0lnBsef/jOvAjkTYggOBzTvwuNfjHGDF0FVUTRANppGQmf3mJkg5
 oKpEipCh5JAzxoyCyP7X/ERVSMjZjvw8IjkkDAOoMQH0YhlpEOiG+BGjg4s1uD0XIeO3
 PYMA==
X-Gm-Message-State: AOJu0YxtDEnW6UTFNYYz8/1F9FBJ94A9KPzxw6eS5bZyMEEiQHll3U7d
 4W+jMdwx5+V7ct/p68sjrcBOSaguJdIc+21LRMiL9cBDoghg7lR60EqLOlIqCNC8xcBnnsiycT/
 nZ8nH3mCH499CHnI=
X-Received: by 2002:a05:6102:3e90:b0:450:8198:adaa with SMTP id
 m16-20020a0561023e9000b004508198adaamr2227995vsv.2.1694632315672; 
 Wed, 13 Sep 2023 12:11:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1ZMUMksFWNOMd+tmVIaHxCILkT0/730q37Q1KI228a5gBgUtpQzukByyTBUb+lQ7T2ry2wg==
X-Received: by 2002:a05:6102:3e90:b0:450:8198:adaa with SMTP id
 m16-20020a0561023e9000b004508198adaamr2227977vsv.2.1694632315264; 
 Wed, 13 Sep 2023 12:11:55 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d13-20020a0cf0cd000000b0063fbfbde4adsm4602032qvl.129.2023.09.13.12.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 12:11:55 -0700 (PDT)
Date: Wed, 13 Sep 2023 15:11:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/5] softmmu: Support concurrent bounce buffers
Message-ID: <ZQIJeaZPnzSAMZyk@x1n>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-3-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907130410.498935-3-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Sep 07, 2023 at 06:04:07AM -0700, Mattias Nissler wrote:
> When DMA memory can't be directly accessed, as is the case when
> running the device model in a separate process without shareable DMA
> file descriptors, bounce buffering is used.
> 
> It is not uncommon for device models to request mapping of several DMA
> regions at the same time. Examples include:
>  * net devices, e.g. when transmitting a packet that is split across
>    several TX descriptors (observed with igb)
>  * USB host controllers, when handling a packet with multiple data TRBs
>    (observed with xhci)
> 
> Previously, qemu only provided a single bounce buffer per AddressSpace
> and would fail DMA map requests while the buffer was already in use. In
> turn, this would cause DMA failures that ultimately manifest as hardware
> errors from the guest perspective.
> 
> This change allocates DMA bounce buffers dynamically instead of
> supporting only a single buffer. Thus, multiple DMA mappings work
> correctly also when RAM can't be mmap()-ed.
> 
> The total bounce buffer allocation size is limited individually for each
> AddressSpace. The default limit is 4096 bytes, matching the previous
> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> provided to configure the limit for PCI devices.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>  hw/pci/pci.c                |  8 ++++
>  include/exec/memory.h       | 14 ++----
>  include/hw/pci/pci_device.h |  3 ++
>  softmmu/memory.c            |  3 +-
>  softmmu/physmem.c           | 94 +++++++++++++++++++++++++------------
>  5 files changed, 80 insertions(+), 42 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 881d774fb6..8c4541b394 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -85,6 +85,8 @@ static Property pci_props[] = {
>                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> +    DEFINE_PROP_SIZE("x-max-bounce-buffer-size", PCIDevice,
> +                     max_bounce_buffer_size, 4096),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> @@ -1208,6 +1210,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                         "bus master container", UINT64_MAX);
>      address_space_init(&pci_dev->bus_master_as,
>                         &pci_dev->bus_master_container_region, pci_dev->name);
> +    pci_dev->bus_master_as.max_bounce_buffer_size =
> +        pci_dev->max_bounce_buffer_size;
>  
>      if (phase_check(PHASE_MACHINE_READY)) {
>          pci_init_bus_master(pci_dev);
> @@ -2664,6 +2668,10 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
>      k->unrealize = pci_qdev_unrealize;
>      k->bus_type = TYPE_PCI_BUS;
>      device_class_set_props(k, pci_props);
> +    object_class_property_set_description(
> +        klass, "x-max-bounce-buffer-size",
> +        "Maximum buffer size allocated for bounce buffers used for mapped "
> +        "access to indirect DMA memory");
>  }
>  
>  static void pci_device_class_base_init(ObjectClass *klass, void *data)
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 7d68936157..5577542b5e 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1081,14 +1081,6 @@ typedef struct AddressSpaceMapClient {
>      QLIST_ENTRY(AddressSpaceMapClient) link;
>  } AddressSpaceMapClient;
>  
> -typedef struct {
> -    MemoryRegion *mr;
> -    void *buffer;
> -    hwaddr addr;
> -    hwaddr len;
> -    bool in_use;
> -} BounceBuffer;
> -
>  /**
>   * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
>   */
> @@ -1106,8 +1098,10 @@ struct AddressSpace {
>      QTAILQ_HEAD(, MemoryListener) listeners;
>      QTAILQ_ENTRY(AddressSpace) address_spaces_link;
>  
> -    /* Bounce buffer to use for this address space. */
> -    BounceBuffer bounce;
> +    /* Maximum DMA bounce buffer size used for indirect memory map requests */
> +    uint64_t max_bounce_buffer_size;
> +    /* Total size of bounce buffers currently allocated, atomically accessed */
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
> +    /* Maximum DMA bounce buffer size used for indirect memory map requests */
> +    uint64_t max_bounce_buffer_size;
>  };
>  
>  static inline int pci_intx(PCIDevice *pci_dev)
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 5c9622c3d6..e02799359c 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -3105,7 +3105,8 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>      as->ioeventfds = NULL;
>      QTAILQ_INIT(&as->listeners);
>      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
> -    as->bounce.in_use = false;
> +    as->max_bounce_buffer_size = 4096;

Instead of hard-code this 4k again (besides the pci property), maybe we can
have address_space_init_with_bouncebuffer() and always pass it in from pci
do_realize?  Then by default no bounce buffer supported for the AS only if
requested.

> +    as->bounce_buffer_size = 0;
>      qemu_mutex_init(&as->map_client_list_lock);
>      QLIST_INIT(&as->map_client_list);
>      as->name = g_strdup(name ? name : "anonymous");
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index f40cc564b8..e3d1cf5fba 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2926,6 +2926,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
>                                       NULL, len, FLUSH_CACHE);
>  }
>  
> +/*
> + * A magic value stored in the first 8 bytes of the bounce buffer struct. Used
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
> @@ -2953,7 +2967,7 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
>      QLIST_INSERT_HEAD(&as->map_client_list, client, link);
>      /* Write map_client_list before reading bounce_buffer_size.  */
>      smp_mb();
> -    if (!qatomic_read(&as->bounce.in_use)) {
> +    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffer_size) {
>          address_space_notify_map_clients_locked(as);
>      }
>      qemu_mutex_unlock(&as->map_client_list_lock);
> @@ -3081,31 +3095,36 @@ void *address_space_map(AddressSpace *as,
>      RCU_READ_LOCK_GUARD();
>      fv = address_space_to_flatview(as);
>      mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
> +    memory_region_ref(mr);
>  
>      if (!memory_access_is_direct(mr, is_write)) {
> -        if (qatomic_xchg(&as->bounce.in_use, true)) {
> +        size_t size = qatomic_add_fetch(&as->bounce_buffer_size, l);
> +        if (size > as->max_bounce_buffer_size) {
> +            size_t excess = size - as->max_bounce_buffer_size;
> +            l -= excess;
> +            qatomic_sub(&as->bounce_buffer_size, excess);
> +        }
> +
> +        if (l == 0) {
>              *plen = 0;
>              return NULL;

MR refcount leak?

>          }
> -        /* Avoid unbounded allocations */
> -        l = MIN(l, TARGET_PAGE_SIZE);
> -        as->bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
> -        as->bounce.addr = addr;
> -        as->bounce.len = l;
>  
> -        memory_region_ref(mr);
> -        as->bounce.mr = mr;
> +        BounceBuffer *bounce = g_malloc0(l + sizeof(BounceBuffer));
> +        bounce->magic = BOUNCE_BUFFER_MAGIC;
> +        bounce->mr = mr;
> +        bounce->addr = addr;
> +        bounce->len = l;
> +
>          if (!is_write) {
>              flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> -                          as->bounce.buffer, l);
> +                          bounce->buffer, l);
>          }
>  
>          *plen = l;
> -        return as->bounce.buffer;
> +        return bounce->buffer;
>      }
>  
> -
> -    memory_region_ref(mr);
>      *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
>                                          l, is_write, attrs);
>      fuzz_dma_read_cb(addr, *plen, mr);
> @@ -3119,31 +3138,44 @@ void *address_space_map(AddressSpace *as,
>  void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>                           bool is_write, hwaddr access_len)
>  {
> -    if (buffer != as->bounce.buffer) {
> -        MemoryRegion *mr;
> -        ram_addr_t addr1;
> +    MemoryRegion *mr;
> +    ram_addr_t addr1;
> +
> +    mr = memory_region_from_host(buffer, &addr1);
> +    if (mr == NULL) {
> +        BounceBuffer *bounce = container_of(buffer, BounceBuffer, buffer);
> +        if (bounce->magic != BOUNCE_BUFFER_MAGIC) {
> +            error_report(
> +                "Unmap request for %p, which neither corresponds to a memory "
> +                "region, nor looks like a bounce buffer, ignoring!",
> +                buffer);
> +            return;

Would assert() be better here? So that when trigger we can have the user
stack already.

> +        }
>  
> -        mr = memory_region_from_host(buffer, &addr1);
> -        assert(mr != NULL);
>          if (is_write) {
> -            invalidate_and_set_dirty(mr, addr1, access_len);
> +            address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFIED,
> +                                bounce->buffer, access_len);
>          }
> -        if (xen_enabled()) {
> -            xen_invalidate_map_cache_entry(buffer);
> +
> +        memory_region_unref(bounce->mr);
> +        uint64_t previous_buffer_size =
> +            qatomic_fetch_sub(&as->bounce_buffer_size, bounce->len);
> +        if (previous_buffer_size == as->max_bounce_buffer_size) {

Can there be race condition that someone just temporarily boosted
bounce_buffer_size, so that it won't exactly equal to max but actually
larger (but we should still notify)?

If the current context has already a bounce buffer and is going to unmap it
(len>0), IIUC it means we should always notify because there will
definitely be some space left, and the requesters can retry to see whether
the size fit.

> +            /* Write bounce_buffer_size before reading map_client_list. */
> +            smp_mb();

I know it comes from the old code.. but I don't know why this is needed;
mutex lock should contain an mb() already before the list iterations later.
Just to raise it up, maybe Paolo would like to comment.

> +            address_space_notify_map_clients(as);
>          }
> -        memory_region_unref(mr);
> +        bounce->magic = ~BOUNCE_BUFFER_MAGIC;
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
> -    as->bounce.buffer = NULL;
> -    memory_region_unref(as->bounce.mr);
> -    /* Clear in_use before reading map_client_list.  */
> -    qatomic_set_mb(&as->bounce.in_use, false);
> -    address_space_notify_map_clients(as);
> +        invalidate_and_set_dirty(mr, addr1, access_len);
> +    }
>  }
>  
>  void *cpu_physical_memory_map(hwaddr addr,
> -- 
> 2.34.1
> 

-- 
Peter Xu


