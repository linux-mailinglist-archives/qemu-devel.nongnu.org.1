Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 004A67A284C
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 22:42:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhFcv-0003hY-5t; Fri, 15 Sep 2023 16:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qhFcr-0003h0-Q1
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 16:41:17 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qhFch-0004SA-QC
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 16:41:17 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5739972accdso1955509eaf.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694810464; x=1695415264; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jorJSsYe5Li8tqYg3dNFt09lJEfO5Ur5Jg6AT8dgLDg=;
 b=Jcky3l3Dd/opUuUngXlY5SkL/ylt08uB0mepj0dUfs+LPh702mP7qzoCcJwlud4ia4
 lTvF/lmNNASlsEWeyUhbO98rOZpMeLVGznN/vq5ayIK7JQwqtSo27kOrik0wWxJLb+eX
 WR4KNc1PkqD4JnTQCEIeA4nXSk97Yf7CuFcCmcJkkt2Yw0PqkJu5enWSYiooTavtuae1
 MSKr5MvcuRDHR8jnq/NIXEkLxK/7rY0hYY+ve6GEAodCvaJXQ7BK4zcV7Z6ateVHsacJ
 U4s2arkfdunjqLB8MBFHcf799NHhSiOdLiC5C8nS10e3OMVblt1M+g/GbgbxRe8NPZvk
 aQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694810464; x=1695415264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jorJSsYe5Li8tqYg3dNFt09lJEfO5Ur5Jg6AT8dgLDg=;
 b=otGehZiW9i48kpV1K9JZcqUhZBelOVTFUS/pRNdWOaKZyAd9pI+c3mX///kPLpOHXu
 p1EOcpnRbifOdO4t1bWq6ZhD027gbWQY1Cp+MGl8IUwvtI/emNRXXm6WyLWa7IkQXEzG
 U9ZWDEMx9mD5Rn1qAuFJtj1eDLgGGh4WCxAa3s6wVwHY3/pzVKjXVXqRB0coILqolbLv
 pCVf8R4cJ9bMeenrY34A+NeGDsGi/qY/jyj4w0vQHe3qf1GBBBqqWDeNmA3nxSTIoDSU
 TfIfb82iXlKY3/0q4YsUeTZNIN5JTlz95WKc/AwiCJZQXmPs6Fq9IAmcBWVnG04FPNIz
 vcWw==
X-Gm-Message-State: AOJu0YzA4y17nLiSIqGvQk92kIm5okkaAVLq01+7CU/05ol9cai+kNc+
 ++yX9iZo/CBV0DsMocLIu4RIMdrCSkEaNob8bXk=
X-Google-Smtp-Source: AGHT+IGnHoNE2MDdJaeHrdMONN0MUpgdLx7nyQErzMWBtaLOxfJxHbA3tht/SV/u4EAytNfqC6mtnWW2CdPtWtuTxfI=
X-Received: by 2002:a05:6870:e40c:b0:1b0:4166:8c19 with SMTP id
 n12-20020a056870e40c00b001b041668c19mr4527658oag.14.1694810464144; Fri, 15
 Sep 2023 13:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-3-mnissler@rivosinc.com>
 <20230914184916.GB1066211@fedora>
 <CAGNS4TY25pDuopFTkkzNSrBu+5Q23-evsv_+65XWCte7ba64uw@mail.gmail.com>
In-Reply-To: <CAGNS4TY25pDuopFTkkzNSrBu+5Q23-evsv_+65XWCte7ba64uw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 15 Sep 2023 16:40:52 -0400
Message-ID: <CAJSP0QW6d1QSi3tSGPRhHQWACVc-p+eny2yhz+OXcA-LyGbnjg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] softmmu: Support concurrent bounce buffers
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 john.levon@nutanix.com, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, 15 Sept 2023 at 05:55, Mattias Nissler <mnissler@rivosinc.com> wrot=
e:
>
> On Thu, Sep 14, 2023 at 8:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Thu, Sep 07, 2023 at 06:04:07AM -0700, Mattias Nissler wrote:
> > > When DMA memory can't be directly accessed, as is the case when
> > > running the device model in a separate process without shareable DMA
> > > file descriptors, bounce buffering is used.
> > >
> > > It is not uncommon for device models to request mapping of several DM=
A
> > > regions at the same time. Examples include:
> > >  * net devices, e.g. when transmitting a packet that is split across
> > >    several TX descriptors (observed with igb)
> > >  * USB host controllers, when handling a packet with multiple data TR=
Bs
> > >    (observed with xhci)
> > >
> > > Previously, qemu only provided a single bounce buffer per AddressSpac=
e
> > > and would fail DMA map requests while the buffer was already in use. =
In
> > > turn, this would cause DMA failures that ultimately manifest as hardw=
are
> > > errors from the guest perspective.
> > >
> > > This change allocates DMA bounce buffers dynamically instead of
> > > supporting only a single buffer. Thus, multiple DMA mappings work
> > > correctly also when RAM can't be mmap()-ed.
> > >
> > > The total bounce buffer allocation size is limited individually for e=
ach
> > > AddressSpace. The default limit is 4096 bytes, matching the previous
> > > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > > provided to configure the limit for PCI devices.
> > >
> > > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > > ---
> > >  hw/pci/pci.c                |  8 ++++
> > >  include/exec/memory.h       | 14 ++----
> > >  include/hw/pci/pci_device.h |  3 ++
> > >  softmmu/memory.c            |  3 +-
> > >  softmmu/physmem.c           | 94 +++++++++++++++++++++++++----------=
--
> > >  5 files changed, 80 insertions(+), 42 deletions(-)
> > >
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index 881d774fb6..8c4541b394 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -85,6 +85,8 @@ static Property pci_props[] =3D {
> > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > +    DEFINE_PROP_SIZE("x-max-bounce-buffer-size", PCIDevice,
> > > +                     max_bounce_buffer_size, 4096),
> > >      DEFINE_PROP_END_OF_LIST()
> > >  };
> > >
> > > @@ -1208,6 +1210,8 @@ static PCIDevice *do_pci_register_device(PCIDev=
ice *pci_dev,
> > >                         "bus master container", UINT64_MAX);
> > >      address_space_init(&pci_dev->bus_master_as,
> > >                         &pci_dev->bus_master_container_region, pci_de=
v->name);
> > > +    pci_dev->bus_master_as.max_bounce_buffer_size =3D
> > > +        pci_dev->max_bounce_buffer_size;
> > >
> > >      if (phase_check(PHASE_MACHINE_READY)) {
> > >          pci_init_bus_master(pci_dev);
> > > @@ -2664,6 +2668,10 @@ static void pci_device_class_init(ObjectClass =
*klass, void *data)
> > >      k->unrealize =3D pci_qdev_unrealize;
> > >      k->bus_type =3D TYPE_PCI_BUS;
> > >      device_class_set_props(k, pci_props);
> > > +    object_class_property_set_description(
> > > +        klass, "x-max-bounce-buffer-size",
> > > +        "Maximum buffer size allocated for bounce buffers used for m=
apped "
> > > +        "access to indirect DMA memory");
> > >  }
> > >
> > >  static void pci_device_class_base_init(ObjectClass *klass, void *dat=
a)
> > > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > > index 7d68936157..5577542b5e 100644
> > > --- a/include/exec/memory.h
> > > +++ b/include/exec/memory.h
> > > @@ -1081,14 +1081,6 @@ typedef struct AddressSpaceMapClient {
> > >      QLIST_ENTRY(AddressSpaceMapClient) link;
> > >  } AddressSpaceMapClient;
> > >
> > > -typedef struct {
> > > -    MemoryRegion *mr;
> > > -    void *buffer;
> > > -    hwaddr addr;
> > > -    hwaddr len;
> > > -    bool in_use;
> > > -} BounceBuffer;
> > > -
> > >  /**
> > >   * struct AddressSpace: describes a mapping of addresses to #MemoryR=
egion objects
> > >   */
> > > @@ -1106,8 +1098,10 @@ struct AddressSpace {
> > >      QTAILQ_HEAD(, MemoryListener) listeners;
> > >      QTAILQ_ENTRY(AddressSpace) address_spaces_link;
> > >
> > > -    /* Bounce buffer to use for this address space. */
> > > -    BounceBuffer bounce;
> > > +    /* Maximum DMA bounce buffer size used for indirect memory map r=
equests */
> > > +    uint64_t max_bounce_buffer_size;
> > > +    /* Total size of bounce buffers currently allocated, atomically =
accessed */
> > > +    uint64_t bounce_buffer_size;
> > >      /* List of callbacks to invoke when buffers free up */
> > >      QemuMutex map_client_list_lock;
> > >      QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
> > > diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.=
h
> > > index d3dd0f64b2..f4027c5379 100644
> > > --- a/include/hw/pci/pci_device.h
> > > +++ b/include/hw/pci/pci_device.h
> > > @@ -160,6 +160,9 @@ struct PCIDevice {
> > >      /* ID of standby device in net_failover pair */
> > >      char *failover_pair_id;
> > >      uint32_t acpi_index;
> > > +
> > > +    /* Maximum DMA bounce buffer size used for indirect memory map r=
equests */
> > > +    uint64_t max_bounce_buffer_size;
> > >  };
> > >
> > >  static inline int pci_intx(PCIDevice *pci_dev)
> > > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > > index 5c9622c3d6..e02799359c 100644
> > > --- a/softmmu/memory.c
> > > +++ b/softmmu/memory.c
> > > @@ -3105,7 +3105,8 @@ void address_space_init(AddressSpace *as, Memor=
yRegion *root, const char *name)
> > >      as->ioeventfds =3D NULL;
> > >      QTAILQ_INIT(&as->listeners);
> > >      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
> > > -    as->bounce.in_use =3D false;
> > > +    as->max_bounce_buffer_size =3D 4096;
> > > +    as->bounce_buffer_size =3D 0;
> > >      qemu_mutex_init(&as->map_client_list_lock);
> > >      QLIST_INIT(&as->map_client_list);
> > >      as->name =3D g_strdup(name ? name : "anonymous");
> > > diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> > > index f40cc564b8..e3d1cf5fba 100644
> > > --- a/softmmu/physmem.c
> > > +++ b/softmmu/physmem.c
> > > @@ -2926,6 +2926,20 @@ void cpu_flush_icache_range(hwaddr start, hwad=
dr len)
> > >                                       NULL, len, FLUSH_CACHE);
> > >  }
> > >
> > > +/*
> > > + * A magic value stored in the first 8 bytes of the bounce buffer st=
ruct. Used
> > > + * to detect illegal pointers passed to address_space_unmap.
> > > + */
> > > +#define BOUNCE_BUFFER_MAGIC 0xb4017ceb4ffe12ed
> > > +
> > > +typedef struct {
> > > +    uint64_t magic;
> > > +    MemoryRegion *mr;
> > > +    hwaddr addr;
> > > +    size_t len;
> > > +    uint8_t buffer[];
> > > +} BounceBuffer;
> > > +
> > >  static void
> > >  address_space_unregister_map_client_do(AddressSpaceMapClient *client=
)
> > >  {
> > > @@ -2953,7 +2967,7 @@ void address_space_register_map_client(AddressS=
pace *as, QEMUBH *bh)
> > >      QLIST_INSERT_HEAD(&as->map_client_list, client, link);
> > >      /* Write map_client_list before reading bounce_buffer_size.  */
> > >      smp_mb();
> > > -    if (!qatomic_read(&as->bounce.in_use)) {
> > > +    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffe=
r_size) {
> > >          address_space_notify_map_clients_locked(as);
> > >      }
> > >      qemu_mutex_unlock(&as->map_client_list_lock);
> > > @@ -3081,31 +3095,36 @@ void *address_space_map(AddressSpace *as,
> > >      RCU_READ_LOCK_GUARD();
> > >      fv =3D address_space_to_flatview(as);
> > >      mr =3D flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
> > > +    memory_region_ref(mr);
> > >
> > >      if (!memory_access_is_direct(mr, is_write)) {
> > > -        if (qatomic_xchg(&as->bounce.in_use, true)) {
> > > +        size_t size =3D qatomic_add_fetch(&as->bounce_buffer_size, l=
);
> > > +        if (size > as->max_bounce_buffer_size) {
> > > +            size_t excess =3D size - as->max_bounce_buffer_size;
> > > +            l -=3D excess;
> > > +            qatomic_sub(&as->bounce_buffer_size, excess);
> >
> > I think two threads can race here. as->bounce_buffer_size will be
> > corrupted (smaller than it should be) and l will be wrong as well. A
> > cmpxchg loop would solve the race.
>
> Ah, thanks for pointing this out. I think the case you have in mind is th=
is:
> 1. Thread A bumps the size to be larger than the max
> 2. Thread B bumps the size further
> 3. Thread B now computes an incorrect excess and sutracts more than it ad=
ded.

Yes, that's the case.

> I should be good if I ensure that each thread will only subtract what
> it has previously added to enforce the invariant that additions and
> subtractions for each map/unmap pair cancel each other out. Let me
> know if there's a reason to still prefer the cmpxchg loop.

Cool, it would be nice to avoid the cmpxchg loop.

Stefan

