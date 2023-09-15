Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D132F7A1B7E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:58:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5ai-0007XT-Pd; Fri, 15 Sep 2023 05:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh5ac-0007X5-Lh
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:58:19 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh5aa-0005NX-OL
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:58:18 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3a76d882052so1138064b6e.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694771895; x=1695376695;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG2C4ZZZXHoi1zVkI4FoMzNmxDnY5ldeST7q5wnHIk0=;
 b=XR+RU+a7uzV014JDEdJP4TjrkNZNvb7IRMezkcKISi1X4KMZm/kf4rS8fXwJrShE3/
 M0SMKd9PmEqVoS8oDPtqFKR1+rr61rAOS9sWAVtAFUrQgAGwSFwnRk5pg1DtTux0diOE
 jnt6kShlMQ9ITwSENsp+ebihU7j501IipRUQP2rjREuMrJkA2/RbJQQBasrz0/5hhbvG
 TWtRiuJ2tfw7QtaVQjTT7HxKMe0lkzyhQoHeRzBSz1Ao1C8Y14ALStajwz34KzcM/15+
 7IUOkLev7F31sxxOSPoird16Jx4d8+fWjNftlFYoHUaMQLePqf64I3cQPl+pSExJrCn5
 6cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694771895; x=1695376695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aG2C4ZZZXHoi1zVkI4FoMzNmxDnY5ldeST7q5wnHIk0=;
 b=iY3NhkVSuCVN/EKPlNIzJ4htL7Liz4Bl0v5MapMV6jFyBZSUlk3BKNMnEecf6yP0VX
 jOtQLlN2owB1q2uFmuZ5ud8qI1+pCDIFEw3ki9MJrQYimn4L97/byRKMCydNFfLZzoHW
 YJEgNN1qa3NOhiv2oB1zCMMa9GhjuXFXgOaXZ0nF36wzrWixI+sH5UdslGZvvUTh6pIA
 JlKF7cJ6bQrLSZHujlVXKkIzfc7bQu+nJ4moSIi6ThcL8pINqLbahCgNTN1EXcIgyDXm
 xrqaT3Lzco0p0cKTBsmMSqfbfr9b1RTjikI4IT4bRafnA2qKYHc14/CDgGDGeKZLgqqC
 Crkw==
X-Gm-Message-State: AOJu0YyQlEu0Clagti3L/EnDZR+1N4ym7bB0qcQ3lniELwRmRFUVMbqZ
 ySW+1JOtYLG9WSg6j3Y71D/uSE7F6NKlFJIFUEl4cQ==
X-Google-Smtp-Source: AGHT+IHVL6/QEwcG+KeyIcFgsYSzdwtJcdgfjXBU8wmeAowDM4pSCsE5jPEVvcNmPy2Q4EYLt1/2L0w6/wZvqEI+z4U=
X-Received: by 2002:a05:6870:b009:b0:1d5:c919:bf5e with SMTP id
 y9-20020a056870b00900b001d5c919bf5emr1068424oae.54.1694771895445; Fri, 15 Sep
 2023 02:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-5-mnissler@rivosinc.com>
 <20230914190448.GC1066211@fedora>
In-Reply-To: <20230914190448.GC1066211@fedora>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Fri, 15 Sep 2023 11:58:04 +0200
Message-ID: <CAGNS4TbH+dYrj3uf_DXktfxbqNuZXkhQGaOkoFR_Wf1pCg_YEw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] vfio-user: Message-based DMA support
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

On Thu, Sep 14, 2023 at 9:04=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Thu, Sep 07, 2023 at 06:04:09AM -0700, Mattias Nissler wrote:
> > Wire up support for DMA for the case where the vfio-user client does no=
t
> > provide mmap()-able file descriptors, but DMA requests must be performe=
d
> > via the VFIO-user protocol. This installs an indirect memory region,
> > which already works for pci_dma_{read,write}, and pci_dma_map works
> > thanks to the existing DMA bounce buffering support.
> >
> > Note that while simple scenarios work with this patch, there's a known
> > race condition in libvfio-user that will mess up the communication
> > channel. See https://github.com/nutanix/libvfio-user/issues/279 for
> > details as well as a proposed fix.
> >
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > ---
> >  hw/remote/trace-events    |  2 +
> >  hw/remote/vfio-user-obj.c | 84 +++++++++++++++++++++++++++++++++++----
> >  2 files changed, 79 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/remote/trace-events b/hw/remote/trace-events
> > index 0d1b7d56a5..358a68fb34 100644
> > --- a/hw/remote/trace-events
> > +++ b/hw/remote/trace-events
> > @@ -9,6 +9,8 @@ vfu_cfg_read(uint32_t offset, uint32_t val) "vfu: cfg: =
0x%x -> 0x%x"
> >  vfu_cfg_write(uint32_t offset, uint32_t val) "vfu: cfg: 0x%x <- 0x%x"
> >  vfu_dma_register(uint64_t gpa, size_t len) "vfu: registering GPA 0x%"P=
RIx64", %zu bytes"
> >  vfu_dma_unregister(uint64_t gpa) "vfu: unregistering GPA 0x%"PRIx64""
> > +vfu_dma_read(uint64_t gpa, size_t len) "vfu: DMA read 0x%"PRIx64", %zu=
 bytes"
> > +vfu_dma_write(uint64_t gpa, size_t len) "vfu: DMA write 0x%"PRIx64", %=
zu bytes"
> >  vfu_bar_register(int i, uint64_t addr, uint64_t size) "vfu: BAR %d: ad=
dr 0x%"PRIx64" size 0x%"PRIx64""
> >  vfu_bar_rw_enter(const char *op, uint64_t addr) "vfu: %s request for B=
AR address 0x%"PRIx64""
> >  vfu_bar_rw_exit(const char *op, uint64_t addr) "vfu: Finished %s of BA=
R address 0x%"PRIx64""
> > diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> > index 8b10c32a3c..cee5e615a9 100644
> > --- a/hw/remote/vfio-user-obj.c
> > +++ b/hw/remote/vfio-user-obj.c
> > @@ -300,6 +300,63 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vf=
u_ctx, char * const buf,
> >      return count;
> >  }
> >
> > +static MemTxResult vfu_dma_read(void *opaque, hwaddr addr, uint64_t *v=
al,
> > +                                unsigned size, MemTxAttrs attrs)
> > +{
> > +    MemoryRegion *region =3D opaque;
> > +    VfuObject *o =3D VFU_OBJECT(region->owner);
> > +    uint8_t buf[sizeof(uint64_t)];
> > +
> > +    trace_vfu_dma_read(region->addr + addr, size);
> > +
> > +    dma_sg_t *sg =3D alloca(dma_sg_size());
>
> Variable-length arrays have recently been removed from QEMU and
> alloca(3) is a similar case. An example is commit
> b3c8246750b7077add335559341268f2956f6470 ("hw/nvme: Avoid dynamic stack
> allocation").
>
> libvfio-user returns a sane sizeof(struct dma_sg) value so we don't need
> to worry about bogus values, so the risk is low here.
>
> However, its hard to scan for and forbid the dangerous alloca(3) calls
> when exceptions are made for some alloca(3) uses.
>
> I would avoid alloca(3) and instead use:
>
>   g_autofree dma_sg_t *sg =3D g_new(dma_sg_size(), 1);

Ok, changing. I personally actually dislike alloca, I was just
following libvfio-user's example code. Plus there's really no valid
performance argument here given that the IPC we're doing will dominate
everything.

>
> > +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> > +    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_READ) =
< 0 ||
> > +        vfu_sgl_read(o->vfu_ctx, sg, 1, buf) !=3D 0) {
> > +        return MEMTX_ERROR;
> > +    }
> > +
> > +    *val =3D ldn_he_p(buf, size);
> > +
> > +    return MEMTX_OK;
> > +}
> > +
> > +static MemTxResult vfu_dma_write(void *opaque, hwaddr addr, uint64_t v=
al,
> > +                                 unsigned size, MemTxAttrs attrs)
> > +{
> > +    MemoryRegion *region =3D opaque;
> > +    VfuObject *o =3D VFU_OBJECT(region->owner);
> > +    uint8_t buf[sizeof(uint64_t)];
> > +
> > +    trace_vfu_dma_write(region->addr + addr, size);
> > +
> > +    stn_he_p(buf, size, val);
> > +
> > +    dma_sg_t *sg =3D alloca(dma_sg_size());
>
> Same here.
>
> > +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> > +    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_WRITE)=
 < 0 ||
> > +        vfu_sgl_write(o->vfu_ctx, sg, 1, buf) !=3D 0)  {
> > +        return MEMTX_ERROR;
> > +    }
> > +
> > +    return MEMTX_OK;
> > +}
> > +
> > +static const MemoryRegionOps vfu_dma_ops =3D {
> > +    .read_with_attrs =3D vfu_dma_read,
> > +    .write_with_attrs =3D vfu_dma_write,
> > +    .endianness =3D DEVICE_HOST_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 8,
> > +        .unaligned =3D true,
> > +    },
> > +    .impl =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 8,
> > +    },
> > +};
> > +
> >  static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
> >  {
> >      VfuObject *o =3D vfu_get_private(vfu_ctx);
> > @@ -308,17 +365,30 @@ static void dma_register(vfu_ctx_t *vfu_ctx, vfu_=
dma_info_t *info)
> >      g_autofree char *name =3D NULL;
> >      struct iovec *iov =3D &info->iova;
> >
> > -    if (!info->vaddr) {
> > -        return;
> > -    }
> > -
> >      name =3D g_strdup_printf("mem-%s-%"PRIx64"", o->device,
> > -                           (uint64_t)info->vaddr);
> > +                           (uint64_t)iov->iov_base);
> >
> >      subregion =3D g_new0(MemoryRegion, 1);
> >
> > -    memory_region_init_ram_ptr(subregion, NULL, name,
> > -                               iov->iov_len, info->vaddr);
> > +    if (info->vaddr) {
> > +        memory_region_init_ram_ptr(subregion, OBJECT(o), name,
> > +                                   iov->iov_len, info->vaddr);
> > +    } else {
> > +        /*
> > +         * Note that I/O regions' MemoryRegionOps handle accesses of a=
t most 8
> > +         * bytes at a time, and larger accesses are broken down. Howev=
er,
> > +         * many/most DMA accesses are larger than 8 bytes and VFIO-use=
r can
> > +         * handle large DMA accesses just fine, thus this size restric=
tion
> > +         * unnecessarily hurts performance, in particular given that e=
ach
> > +         * access causes a round trip on the VFIO-user socket.
> > +         *
> > +         * TODO: Investigate how to plumb larger accesses through memo=
ry
> > +         * regions, possibly by amending MemoryRegionOps or by creatin=
g a new
> > +         * memory region type.
> > +         */
> > +        memory_region_init_io(subregion, OBJECT(o), &vfu_dma_ops, subr=
egion,
> > +                              name, iov->iov_len);
> > +    }
> >
> >      dma_as =3D pci_device_iommu_address_space(o->pci_dev);
> >
> > --
> > 2.34.1
> >

