Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7D37867F7
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 09:00:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ4It-0003un-7g; Thu, 24 Aug 2023 02:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qZ4Ir-0003uL-3U
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 02:58:49 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qZ4Il-0004nq-Tu
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 02:58:47 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1c4f4d67f5bso4043875fac.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 23:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692860322; x=1693465122; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GCTw3xxuKq919Gd8wMbWXgfdfxm6b75/GjO2B3rfbTg=;
 b=u71ZEzZr/WWjHvsSnb5kIyAV+9fxbYDUg7b5wTp2nZ6NM7gKEO33+V2XHZJ1V9yDDp
 FWqwKOeNZYgqVB+wWvUl9ahGy5DqJHkV+eX9iA2jzCZweGUTiSuKPBAsn16XRgdkVXMI
 kgS/uSA5wkJFj3i8ZhrxlfiZV/HnarnycmwcXUct5L7FV6pemVT9HohLpJNOskpgUC7B
 Bfxys5D7BWbu9kZbJCgJ4M713he2wmKREs6FYEDfk5NXvZBclmNDhd5foSbVdRfNd6os
 8z2X4X33embb8gS5nPvNE+okru8hYJPS+hPoRxRhyc32fBgQGbWVXuKiiAabYS/AsuXs
 nkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692860322; x=1693465122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCTw3xxuKq919Gd8wMbWXgfdfxm6b75/GjO2B3rfbTg=;
 b=h68mGbqcw9AX/vSo6LLr0spn6jL2pD9NiuqhpXE4fO254/ke0BlvS/VU1JbwJ7Tgds
 govdgBB9AhIoMl2abnZePBhV9tqRuwBfsCIHBFHYU0AFs1lv+4rHushSBoXFUBh67Ze3
 SxeooeaWk7W+jxjsOCDI3HbCCMB8ky+3EjFF+BiAmKaMwkD5yCoG6CBwtaZbNvJQutB4
 EG3NMOemZs3bULdpkx8iADsFuhioOXL9q6yuQU1Be6J+cPb0vpsUtfTF4HypDxqnvNh5
 MLbGwhtAzwffS5wICSq1hASKLdRtW4qy1ay2ubOi8h2i7tDfX1zG33zdic9HenNwtR7R
 RjVQ==
X-Gm-Message-State: AOJu0YxjCCRflCjv6AHHgGPnmAy53LPgPWaLSizRRmqnSfB8PPammF5/
 tz74aERTRBlTCe6IAZDbWm33qiTP6hz/9TCmwDMDKg==
X-Google-Smtp-Source: AGHT+IGu7puH7V3NIsKBZqnm3vH08LJhIfAmr/NnLvn+u9PxfwyTcymPRuUtqxF8d7Q73PJDYQT2qw83zMpIVoKmCx8=
X-Received: by 2002:a05:6870:3928:b0:1c4:db12:8752 with SMTP id
 b40-20020a056870392800b001c4db128752mr14977985oap.35.1692860321953; Wed, 23
 Aug 2023 23:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230823092905.2259418-1-mnissler@rivosinc.com>
 <20230823092905.2259418-2-mnissler@rivosinc.com> <ZOZDQVgboMaiZ4x6@x1n>
 <CAGNS4TY2-scz3pu16tUF1bA-FEk+pe86QsgjW8L=qjidw5TqOQ@mail.gmail.com>
 <ZOZx7vMqFRfaIwSp@x1n>
In-Reply-To: <ZOZx7vMqFRfaIwSp@x1n>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Thu, 24 Aug 2023 08:58:30 +0200
Message-ID: <CAGNS4TYOiXsuTP12+OL0NE3J_RYft12t6-v=RkTK+EqffO4Z2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] softmmu: Support concurrent bounce buffers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com, stefanha@redhat.com, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
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

On Wed, Aug 23, 2023 at 10:54=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Wed, Aug 23, 2023 at 10:08:08PM +0200, Mattias Nissler wrote:
> > Peter, thanks for taking a look and providing feedback!
> >
> > On Wed, Aug 23, 2023 at 7:35=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > On Wed, Aug 23, 2023 at 02:29:02AM -0700, Mattias Nissler wrote:
> > > > When DMA memory can't be directly accessed, as is the case when
> > > > running the device model in a separate process without shareable DM=
A
> > > > file descriptors, bounce buffering is used.
> > > >
> > > > It is not uncommon for device models to request mapping of several =
DMA
> > > > regions at the same time. Examples include:
> > > >  * net devices, e.g. when transmitting a packet that is split acros=
s
> > > >    several TX descriptors (observed with igb)
> > > >  * USB host controllers, when handling a packet with multiple data =
TRBs
> > > >    (observed with xhci)
> > > >
> > > > Previously, qemu only provided a single bounce buffer and would fai=
l DMA
> > > > map requests while the buffer was already in use. In turn, this wou=
ld
> > > > cause DMA failures that ultimately manifest as hardware errors from=
 the
> > > > guest perspective.
> > > >
> > > > This change allocates DMA bounce buffers dynamically instead of
> > > > supporting only a single buffer. Thus, multiple DMA mappings work
> > > > correctly also when RAM can't be mmap()-ed.
> > > >
> > > > The total bounce buffer allocation size is limited by a new command=
 line
> > > > parameter. The default is 4096 bytes to match the previous maximum
> > > > buffer size. It is expected that suitable limits will vary quite a =
bit
> > > > in practice depending on device models and workloads.
> > > >
> > > > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > > > ---
> > > >  include/sysemu/sysemu.h |  2 +
> > > >  qemu-options.hx         | 27 +++++++++++++
> > > >  softmmu/globals.c       |  1 +
> > > >  softmmu/physmem.c       | 84 +++++++++++++++++++++++--------------=
----
> > > >  softmmu/vl.c            |  6 +++
> > > >  5 files changed, 83 insertions(+), 37 deletions(-)
> > > >
> > > > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > > > index 25be2a692e..c5dc93cb53 100644
> > > > --- a/include/sysemu/sysemu.h
> > > > +++ b/include/sysemu/sysemu.h
> > > > @@ -61,6 +61,8 @@ extern int nb_option_roms;
> > > >  extern const char *prom_envs[MAX_PROM_ENVS];
> > > >  extern unsigned int nb_prom_envs;
> > > >
> > > > +extern uint64_t max_bounce_buffer_size;
> > > > +
> > > >  /* serial ports */
> > > >
> > > >  /* Return the Chardev for serial port i, or NULL if none */
> > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > index 29b98c3d4c..6071794237 100644
> > > > --- a/qemu-options.hx
> > > > +++ b/qemu-options.hx
> > > > @@ -4959,6 +4959,33 @@ SRST
> > > >  ERST
> > > >  #endif
> > > >
> > > > +DEF("max-bounce-buffer-size", HAS_ARG,
> > > > +    QEMU_OPTION_max_bounce_buffer_size,
> > > > +    "-max-bounce-buffer-size size\n"
> > > > +    "                DMA bounce buffer size limit in bytes (defaul=
t=3D4096)\n",
> > > > +    QEMU_ARCH_ALL)
> > > > +SRST
> > > > +``-max-bounce-buffer-size size``
> > > > +    Set the limit in bytes for DMA bounce buffer allocations.
> > > > +
> > > > +    DMA bounce buffers are used when device models request memory-=
mapped access
> > > > +    to memory regions that can't be directly mapped by the qemu pr=
ocess, so the
> > > > +    memory must read or written to a temporary local buffer for th=
e device
> > > > +    model to work with. This is the case e.g. for I/O memory regio=
ns, and when
> > > > +    running in multi-process mode without shared access to memory.
> > > > +
> > > > +    Whether bounce buffering is necessary depends heavily on the d=
evice model
> > > > +    implementation. Some devices use explicit DMA read and write o=
perations
> > > > +    which do not require bounce buffers. Some devices, notably sto=
rage, will
> > > > +    retry a failed DMA map request after bounce buffer space becom=
es available
> > > > +    again. Most other devices will bail when encountering map requ=
est failures,
> > > > +    which will typically appear to the guest as a hardware error.
> > > > +
> > > > +    Suitable bounce buffer size values depend on the workload and =
guest
> > > > +    configuration. A few kilobytes up to a few megabytes are commo=
n sizes
> > > > +    encountered in practice.
> > >
> > > Does it mean that the default 4K size can still easily fail with some
> > > device setup?
> >
> > Yes. The thing is that the respective device setup is pretty exotic,
> > at least the only setup I'm aware of is multi-process with direct RAM
> > access via shared file descriptors from the device process disabled
> > (which hurts performance, so few people will run this setup). In
> > theory, DMA to an I/O region of some sort would also run into the
> > issue even in single process mode, but I'm not aware of such a
> > situation. Looking at it from a historic perspective, note that the
> > single-bounce-buffer restriction has been present since a decade, and
> > thus the issue has been present for years (since multi-process is a
> > thing), without it hurting anyone enough to get fixed. But don't get
> > me wrong - I don't want to downplay anything and very much would like
> > to see this fixed, but I want to be honest and put things into the
> > right perspective.
> >
> > >
> > > IIUC the whole point of limit here is to make sure the allocation is =
still
> > > bounded, while 4K itself is not a hard limit. Making it bigger would =
be,
> > > IMHO, nice if it should work with known configs which used to be brok=
en.
> >
> > I'd be in favor of bumping the default. Networking should be fine with
> > 64KB, but I've observed a default Linux + xhci + usb_storage setup to
> > use up to 1MB of DMA buffers, we'd probably need to raise it
> > considerably. Would 4MB still be acceptable? That wouldn't allow a
> > single nefarious VM to stage a memory denial of service attack, but
> > what if you're running many VMs?
>
> Could wait and see whether there's any more comments from others.
> Personally 4MB looks fine, as that's not a constant consumption per-vm, b=
ut
> a worst case limit (probably only when there is an attacker).

OK, I'll take a note to change to 4MB for the next version of this
series then, barring any objections from others.

Note to self: Raising the limit will likely also accommodate the ide
test's DMA buffer consumption, which means we'd be losing test
coverage for the map client callback code path. I probably need to
adjust the test or make a new one to make up for that.

>
> Multiple VM does can indeed make it worse, but it means the attacker will
> need to attack all the VMs all success, and the sum up will be 4MB /
> mem_size_average_vm in percentage, irrelevant of numbers; for ~4GB averag=
e
> VM size it's 0.1% memory, and even less if VM is larger - maybe not
> something extremely scary even if happened.
>
> >
> > >
> > > > +ERST
> > > > +
> > > >  DEFHEADING()
> > > >
> > > >  DEFHEADING(Generic object creation:)
> > > > diff --git a/softmmu/globals.c b/softmmu/globals.c
> > > > index e83b5428d1..d3cc010717 100644
> > > > --- a/softmmu/globals.c
> > > > +++ b/softmmu/globals.c
> > > > @@ -54,6 +54,7 @@ const char *prom_envs[MAX_PROM_ENVS];
> > > >  uint8_t *boot_splash_filedata;
> > > >  int only_migratable; /* turn it off unless user states otherwise *=
/
> > > >  int icount_align_option;
> > > > +uint64_t max_bounce_buffer_size =3D 4096;
> > > >
> > > >  /* The bytes in qemu_uuid are in the order specified by RFC4122, _=
not_ in the
> > > >   * little-endian "wire format" described in the SMBIOS 2.6 specifi=
cation.
> > > > diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> > > > index 3df73542e1..9f0fec0c8e 100644
> > > > --- a/softmmu/physmem.c
> > > > +++ b/softmmu/physmem.c
> > > > @@ -50,6 +50,7 @@
> > > >  #include "sysemu/dma.h"
> > > >  #include "sysemu/hostmem.h"
> > > >  #include "sysemu/hw_accel.h"
> > > > +#include "sysemu/sysemu.h"
> > > >  #include "sysemu/xen-mapcache.h"
> > > >  #include "trace/trace-root.h"
> > > >
> > > > @@ -2904,13 +2905,12 @@ void cpu_flush_icache_range(hwaddr start, h=
waddr len)
> > > >
> > > >  typedef struct {
> > > >      MemoryRegion *mr;
> > > > -    void *buffer;
> > > >      hwaddr addr;
> > > > -    hwaddr len;
> > > > -    bool in_use;
> > > > +    size_t len;
> > > > +    uint8_t buffer[];
> > > >  } BounceBuffer;
> > > >
> > > > -static BounceBuffer bounce;
> > > > +static size_t bounce_buffer_size;
> > > >
> > > >  typedef struct MapClient {
> > > >      QEMUBH *bh;
> > > > @@ -2945,9 +2945,9 @@ void cpu_register_map_client(QEMUBH *bh)
> > > >      qemu_mutex_lock(&map_client_list_lock);
> > > >      client->bh =3D bh;
> > > >      QLIST_INSERT_HEAD(&map_client_list, client, link);
> > > > -    /* Write map_client_list before reading in_use.  */
> > > > +    /* Write map_client_list before reading bounce_buffer_size.  *=
/
> > > >      smp_mb();
> > > > -    if (!qatomic_read(&bounce.in_use)) {
> > > > +    if (qatomic_read(&bounce_buffer_size) < max_bounce_buffer_size=
) {
> > > >          cpu_notify_map_clients_locked();
> > > >      }
> > > >      qemu_mutex_unlock(&map_client_list_lock);
> > > > @@ -3076,31 +3076,35 @@ void *address_space_map(AddressSpace *as,
> > > >      RCU_READ_LOCK_GUARD();
> > > >      fv =3D address_space_to_flatview(as);
> > > >      mr =3D flatview_translate(fv, addr, &xlat, &l, is_write, attrs=
);
> > > > +    memory_region_ref(mr);
> > > >
> > > >      if (!memory_access_is_direct(mr, is_write)) {
> > > > -        if (qatomic_xchg(&bounce.in_use, true)) {
> > > > +        size_t size =3D qatomic_add_fetch(&bounce_buffer_size, l);
> > > > +        if (size > max_bounce_buffer_size) {
> > > > +            size_t excess =3D size - max_bounce_buffer_size;
> > > > +            l -=3D excess;
> > > > +            qatomic_sub(&bounce_buffer_size, excess);
> > > > +        }
> > > > +
> > > > +        if (l =3D=3D 0) {
> > > >              *plen =3D 0;
> > > >              return NULL;
> > > >          }
> > > > -        /* Avoid unbounded allocations */
> > > > -        l =3D MIN(l, TARGET_PAGE_SIZE);
> > > > -        bounce.buffer =3D qemu_memalign(TARGET_PAGE_SIZE, l);
> > > > -        bounce.addr =3D addr;
> > > > -        bounce.len =3D l;
> > > >
> > > > -        memory_region_ref(mr);
> > > > -        bounce.mr =3D mr;
> > > > +        BounceBuffer *bounce =3D g_malloc(l + sizeof(BounceBuffer)=
);
> > >
> > > Maybe g_malloc0() would be better?
> >
> > Good point, will change.
> >
> > >
> > > I just checked that we had target page aligned allocations since the =
1st
> > > day (commit 6d16c2f88f2a).  I didn't find any clue showing why it was=
 done
> > > like that, but I do have worry on whether any existing caller that ma=
y
> > > implicitly relying on an address that is target page aligned.  But ma=
ybe
> > > not a major issue; I didn't see anything rely on that yet.
> >
> > I did go through the same exercise when noticing the page alignment
> > and arrived at the same conclusion as you. That makes it two people
> > thinking it's OK, so I feel like we should take the risk here, in
> > particular given that we know this code path is already broken as is.
>
> It'll be more important to see if any one person thinks it's not okay in
> this case, though. :)
>
> If we decide to take the risk, we should merge a patch like this in as
> early stage as possible of the release.

Happy to do so.

However, let me know if you rather want to retain page alignment.
It'll complicate things though, as it'll likely lead to storing the
metadata separate from the buffer allocation, probably using a hash
table / tree / array (as you suggest below) to keep track of all
allocated buffers and locate their metadata by address.

>
> >
> > >
> > > > +        bounce->mr =3D mr;
> > > > +        bounce->addr =3D addr;
> > > > +        bounce->len =3D l;
> > > > +
> > > >          if (!is_write) {
> > > >              flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> > > > -                               bounce.buffer, l);
> > > > +                          bounce->buffer, l);
> > > >          }
> > > >
> > > >          *plen =3D l;
> > > > -        return bounce.buffer;
> > > > +        return bounce->buffer;
> > > >      }
> > > >
> > > > -
> > > > -    memory_region_ref(mr);
> > > >      *plen =3D flatview_extend_translation(fv, addr, len, mr, xlat,
> > > >                                          l, is_write, attrs);
> > > >      fuzz_dma_read_cb(addr, *plen, mr);
> > > > @@ -3114,31 +3118,37 @@ void *address_space_map(AddressSpace *as,
> > > >  void address_space_unmap(AddressSpace *as, void *buffer, hwaddr le=
n,
> > > >                           bool is_write, hwaddr access_len)
> > > >  {
> > > > -    if (buffer !=3D bounce.buffer) {
> > > > -        MemoryRegion *mr;
> > > > -        ram_addr_t addr1;
> > > > +    MemoryRegion *mr;
> > > > +    ram_addr_t addr1;
> > > > +
> > > > +    mr =3D memory_region_from_host(buffer, &addr1);
> > > > +    if (mr =3D=3D NULL) {
> > > > +        /*
> > > > +         * Must be a bounce buffer (unless the caller passed a poi=
nter which
> > > > +         * wasn't returned by address_space_map, which is illegal)=
.
> > >
> > > Is it possible to still have some kind of sanity check to make sure i=
t's a
> > > bounce buffer passed in, just in case of a caller bug?  Or, the failu=
re can
> > > be weird..
> >
> > I was contemplating putting a magic number as the first struct member
> > as a best effort to detect invalid pointers and corruptions, but
> > wasn't sure it's warranted. Since you ask, I'll make that change.
>
> That'll be good, thanks.
>
> I was thinking maybe we can also maintain all the mapped buffers just lik=
e
> before, either in a tree, or a sorted array; the array can be even easier
> and static if the limit applied here will be "maximum number of bounce
> buffer mapped" rather than "maximum bytes of bounce buffer mapped", but
> this whole idea may already be over-complicated to worry on leaked buffer=
s?
> The magic number sounds good enough.
>
> >
> > >
> > > > +         */
> > > > +        BounceBuffer *bounce =3D container_of(buffer, BounceBuffer=
, buffer);
> > > >
> > > > -        mr =3D memory_region_from_host(buffer, &addr1);
> > > > -        assert(mr !=3D NULL);
> > > >          if (is_write) {
> > > > -            invalidate_and_set_dirty(mr, addr1, access_len);
> > > > -        }
> > > > -        if (xen_enabled()) {
> > > > -            xen_invalidate_map_cache_entry(buffer);
> > > > +            address_space_write(as, bounce->addr, MEMTXATTRS_UNSPE=
CIFIED,
> > > > +                                bounce->buffer, access_len);
> > > >          }
> > > > -        memory_region_unref(mr);
> > > > +
> > > > +        memory_region_unref(bounce->mr);
> > > > +        qatomic_sub(&bounce_buffer_size, bounce->len);
> > > > +        /* Write bounce_buffer_size before reading map_client_list=
. */
> > > > +        smp_mb();
> > > > +        cpu_notify_map_clients();
> > > > +        g_free(bounce);
> > > >          return;
> > > >      }
> > > > +
> > > > +    if (xen_enabled()) {
> > > > +        xen_invalidate_map_cache_entry(buffer);
> > > > +    }
> > > >      if (is_write) {
> > > > -        address_space_write(as, bounce.addr, MEMTXATTRS_UNSPECIFIE=
D,
> > > > -                            bounce.buffer, access_len);
> > > > -    }
> > > > -    qemu_vfree(bounce.buffer);
> > > > -    bounce.buffer =3D NULL;
> > > > -    memory_region_unref(bounce.mr);
> > > > -    /* Clear in_use before reading map_client_list.  */
> > > > -    qatomic_set_mb(&bounce.in_use, false);
> > > > -    cpu_notify_map_clients();
> > > > +        invalidate_and_set_dirty(mr, addr1, access_len);
> > > > +    }
> > > >  }
> > > >
> > > >  void *cpu_physical_memory_map(hwaddr addr,
> > > > diff --git a/softmmu/vl.c b/softmmu/vl.c
> > > > index b0b96f67fa..dbe52f5ea1 100644
> > > > --- a/softmmu/vl.c
> > > > +++ b/softmmu/vl.c
> > > > @@ -3469,6 +3469,12 @@ void qemu_init(int argc, char **argv)
> > > >                  exit(1);
> > > >  #endif
> > > >                  break;
> > > > +            case QEMU_OPTION_max_bounce_buffer_size:
> > > > +                if (qemu_strtosz(optarg, NULL, &max_bounce_buffer_=
size) < 0) {
> > > > +                    error_report("invalid -max-ounce-buffer-size v=
alue");
> > > > +                    exit(1);
> > > > +                }
> > > > +                break;
> > >
> > > PS: I had a vague memory that we do not recommend adding more qemu cm=
dline
> > > options, but I don't know enough on the plan to say anything real.
> >
> > I am aware of that, and I'm really not happy with the command line
> > option myself. Consider the command line flag a straw man I put in to
> > see whether any reviewers have better ideas :)
> >
> > More seriously, I actually did look around to see whether I can add
> > the parameter to one of the existing option groupings somewhere, but
> > neither do I have a suitable QOM object that I can attach the
> > parameter to, nor did I find any global option groups that fits: this
> > is not really memory configuration, and it's not really CPU
> > configuration, it's more related to shared device model
> > infrastructure... If you have a good idea for a home for this, I'm all
> > ears.
>
> No good & simple suggestion here, sorry.  We can keep the option there
> until someone jumps in, then the better alternative could also come along=
.
>
> After all I expect if we can choose a sensible enough default value, this
> new option shouldn't be used by anyone for real.
>
> Thanks,
>
> --
> Peter Xu
>

