Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5706D7853EE
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:29:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkA0-0003RN-NB; Wed, 23 Aug 2023 05:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYk9w-0003RF-Md
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:28:16 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYk9s-0006UM-R7
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:28:15 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3a76d882080so3906341b6e.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692782890; x=1693387690; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuQHKwX/JSe7XeMa8aAHVVp5WUuEud7PlmzP9hlIUJU=;
 b=OIq43wbRwkgzd2pTDej8APWvPauB7gRFV3i8nfpaJ0B56Yk3le0q1TnfXvJ1GhytnQ
 cmHKwcfWmyVqRk2tI/5ydqa2BAZWvFUohDfDKhuKWZAqKnP+L7GspqmM5Vwa/ZHQXc3W
 3C/F0QlAQSQHkVo7FWyakuq85Sfmf9VM9xHd49yFzQh2UWKerLFbYJd8eTbfCf4pnFwe
 ycn7dco2NWdaNr4Bb20F2G2KP7JW300nKzHdWA+Z9e4BoAH8ljIv6ZBg7MpTGFQ24h/6
 UE6bpvFfsxROpOstKQfnDZJ17zvKGZ97OnaUPaSrPkgE7ceJUW1OYPd3TuPAmfQM02Ov
 1k9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692782890; x=1693387690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZuQHKwX/JSe7XeMa8aAHVVp5WUuEud7PlmzP9hlIUJU=;
 b=MWc+6HV0XdP9d3G0ALqEB4sHbL4EzkK7AJtcZtVeisTVqy9qlMZ0qgaKHRJUATKNJ2
 Zlg8T3u5VX1NTQmyFtRTxAWT2+F4MzFafHUSd0SKXzhVe6yjKfcqein7L73NphEZv+Gz
 /DkoPNSpys9CAXmoJSN139OhN4D1Cob8JRegzt3ZrWbcbHbugb+sZ1BVE81q7K/r6Srn
 vC/pTWzY9DGWMuKjZt/QNH4GjeO1ie6CnOs5KkGA0UbBrobRGmzH1YL2bylhWIkbTQks
 fXfVcJuGHCbP0NNdI22wwDMuWvJzLJYru/vhkcUzOfzg9R/92I1UhWbP6oV5mPBU7lvI
 kajw==
X-Gm-Message-State: AOJu0YzgyAGM408rkQWEVRRdPE+RGG/zUluJ3HQBe0Huh4cXK5RDBStG
 Lb/2JKSLLnsbr45xGXxGA1Ro/6UI1EiGmd/JcYWl1g==
X-Google-Smtp-Source: AGHT+IH+gaDv2i917zdY8y9O/Xi0Gq5Te9qbowFSLIc25QnA+2OoQgsON4aRZU5hqLjVJkMFpBoZbOsjCsBx/MKogiM=
X-Received: by 2002:a05:6808:4283:b0:3a7:65cc:f19d with SMTP id
 dq3-20020a056808428300b003a765ccf19dmr12785619oib.34.1692782890707; Wed, 23
 Aug 2023 02:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230704080628.852525-1-mnissler@rivosinc.com>
 <20230704080628.852525-2-mnissler@rivosinc.com>
 <20230720181014.GA210977@fedora>
In-Reply-To: <20230720181014.GA210977@fedora>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Wed, 23 Aug 2023 11:27:59 +0200
Message-ID: <CAGNS4TY8b+jcAmovCjUBrvnGVms32TC3HejH3MuqYGvw2DbO_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] softmmu: Support concurrent bounce buffers
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, john.levon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x229.google.com
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

On Thu, Jul 20, 2023 at 8:10=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Jul 04, 2023 at 01:06:25AM -0700, Mattias Nissler wrote:
> > It is not uncommon for device models to request mapping of several DMA
> > regions at the same time. An example is igb (and probably other net
> > devices as well) when a packet is spread across multiple descriptors.
> >
> > In order to support this when indirect DMA is used, as is the case when
> > running the device model in a vfio-server process without mmap()-ed DMA=
,
> > this change allocates DMA bounce buffers dynamically instead of
> > supporting only a single buffer.
> >
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > ---
> >  softmmu/physmem.c | 74 ++++++++++++++++++++++-------------------------
> >  1 file changed, 35 insertions(+), 39 deletions(-)
>
> Is this a functional change or purely a performance optimization? If
> it's a performance optimization, please include benchmark results to
> justify this change.


It's a functional change in the sense that it fixes qemu to make some
hardware models actually work with bounce-buffered DMA. Right now, the
device models attempt to perform DMA accesses, receive an error due to
bounce buffer contention and then just bail, which the guest will
observe as a timeout and/or hardware error. I ran into this with igb
and xhci.

>
>
> QEMU memory allocations must be bounded so that an untrusted guest
> cannot cause QEMU to exhaust host memory. There must be a limit to the
> amount of bounce buffer memory.

Ah, makes sense. I will add code to track the total bounce buffer size
and enforce a limit. Since the amount of buffer space depends a lot on
the workload (I have observed xhci + usb-storage + Linux to use 1MB
buffer sizes by default), I'll make the limit configurable.





>
>
> > diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> > index bda475a719..56130b5a1d 100644
> > --- a/softmmu/physmem.c
> > +++ b/softmmu/physmem.c
> > @@ -2904,13 +2904,11 @@ void cpu_flush_icache_range(hwaddr start, hwadd=
r len)
> >
> >  typedef struct {
> >      MemoryRegion *mr;
> > -    void *buffer;
> >      hwaddr addr;
> > -    hwaddr len;
> > -    bool in_use;
> > +    uint8_t buffer[];
> >  } BounceBuffer;
> >
> > -static BounceBuffer bounce;
> > +static size_t bounce_buffers_in_use;
> >
> >  typedef struct MapClient {
> >      QEMUBH *bh;
> > @@ -2947,7 +2945,7 @@ void cpu_register_map_client(QEMUBH *bh)
> >      QLIST_INSERT_HEAD(&map_client_list, client, link);
> >      /* Write map_client_list before reading in_use.  */
> >      smp_mb();
> > -    if (!qatomic_read(&bounce.in_use)) {
> > +    if (qatomic_read(&bounce_buffers_in_use)) {
> >          cpu_notify_map_clients_locked();
> >      }
> >      qemu_mutex_unlock(&map_client_list_lock);
> > @@ -3076,31 +3074,24 @@ void *address_space_map(AddressSpace *as,
> >      RCU_READ_LOCK_GUARD();
> >      fv =3D address_space_to_flatview(as);
> >      mr =3D flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
> > +    memory_region_ref(mr);
> >
> >      if (!memory_access_is_direct(mr, is_write)) {
> > -        if (qatomic_xchg(&bounce.in_use, true)) {
> > -            *plen =3D 0;
> > -            return NULL;
> > -        }
> > -        /* Avoid unbounded allocations */
> > -        l =3D MIN(l, TARGET_PAGE_SIZE);
> > -        bounce.buffer =3D qemu_memalign(TARGET_PAGE_SIZE, l);
> > -        bounce.addr =3D addr;
> > -        bounce.len =3D l;
> > -
> > -        memory_region_ref(mr);
> > -        bounce.mr =3D mr;
> > +        qatomic_inc_fetch(&bounce_buffers_in_use);
> > +
> > +        BounceBuffer *bounce =3D g_malloc(l + sizeof(BounceBuffer));
> > +        bounce->addr =3D addr;
> > +        bounce->mr =3D mr;
> > +
> >          if (!is_write) {
> >              flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> > -                               bounce.buffer, l);
> > +                          bounce->buffer, l);
> >          }
> >
> >          *plen =3D l;
> > -        return bounce.buffer;
> > +        return bounce->buffer;
>
> Bounce buffer allocation always succeeds now. Can the
> cpu_notify_map_clients*() be removed now that no one is waiting for
> bounce buffers anymore?
>
> >      }
> >
> > -
> > -    memory_region_ref(mr);
> >      *plen =3D flatview_extend_translation(fv, addr, len, mr, xlat,
> >                                          l, is_write, attrs);
> >      fuzz_dma_read_cb(addr, *plen, mr);
> > @@ -3114,31 +3105,36 @@ void *address_space_map(AddressSpace *as,
> >  void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
> >                           bool is_write, hwaddr access_len)
> >  {
> > -    if (buffer !=3D bounce.buffer) {
> > -        MemoryRegion *mr;
> > -        ram_addr_t addr1;
> > +    MemoryRegion *mr;
> > +    ram_addr_t addr1;
> > +
> > +    mr =3D memory_region_from_host(buffer, &addr1);
> > +    if (mr =3D=3D NULL) {
> > +        /*
> > +         * Must be a bounce buffer (unless the caller passed a pointer=
 which
> > +         * wasn't returned by address_space_map, which is illegal).
> > +         */
> > +        BounceBuffer *bounce =3D container_of(buffer, BounceBuffer, bu=
ffer);
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
> > +        memory_region_unref(bounce->mr);
> > +        g_free(bounce);
> > +
> > +        if (qatomic_dec_fetch(&bounce_buffers_in_use) =3D=3D 1) {
> > +            cpu_notify_map_clients();
> >          }
> > -        memory_region_unref(mr);
> >          return;
> >      }
> > +
> > +    if (xen_enabled()) {
> > +        xen_invalidate_map_cache_entry(buffer);
> > +    }
> >      if (is_write) {
> > -        address_space_write(as, bounce.addr, MEMTXATTRS_UNSPECIFIED,
> > -                            bounce.buffer, access_len);
> > -    }
> > -    qemu_vfree(bounce.buffer);
> > -    bounce.buffer =3D NULL;
> > -    memory_region_unref(bounce.mr);
> > -    /* Clear in_use before reading map_client_list.  */
> > -    qatomic_set_mb(&bounce.in_use, false);
> > -    cpu_notify_map_clients();
> > +        invalidate_and_set_dirty(mr, addr1, access_len);
> > +    }
> >  }
> >
> >  void *cpu_physical_memory_map(hwaddr addr,
> > --
> > 2.34.1
> >

