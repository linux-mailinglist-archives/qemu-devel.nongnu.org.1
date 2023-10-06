Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D079B7BB2BD
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 09:57:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofhp-0006QD-6g; Fri, 06 Oct 2023 03:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qofhn-0006Pw-4q
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:57:03 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qofhk-0000Yc-E2
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:57:02 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1dcdfeb7e44so1216462fac.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 00:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696579019; x=1697183819;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qHfS8t5XyWr6hYLmpcu3ooH3RvYTVIWETqkY3yUV0YE=;
 b=wVNFSPvM4keEHL7vPJdAEEsvii/BXycuzkxFEKzrZvoZUcO5AOypRMqtjo5wB3DpBB
 6FeSqm80rrKdN2+QHSmlgwdLusQs76KgPdLQ4lNm6HLAsjmyNOVpLq5GGJYrCfcE3gmR
 67F7/Z4qtzsmxFyJWYmVw3jASbyCdRCXcKV2iwH1g/rHMH7ARgS+oCdc/UrkTbheOMd2
 0/A9euXnBfnb4N6M0X9qlWjjMfnUjUGFl3ivLHkPaIBmkZaXs+FUZLuBD2NwgvKguXiS
 QqKlGByoYW17+4AijJ23I3v1In+VvIvgj75qJR/IXUnx/75/JlsgMj0OJXyTis2TQagX
 /eAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696579019; x=1697183819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qHfS8t5XyWr6hYLmpcu3ooH3RvYTVIWETqkY3yUV0YE=;
 b=KYvY8Pq1vPv04bJ8Bxo44gQzEzWPXrtpWni4iWcWwoPB42s8i75QqfrTd+NzlJ/Bwf
 WyClitEdlRMGbcfiNHA7i1nagdarzg39FR74Z4EnVKNNduzzvck+qKRRcC0ZCp4X1YCe
 nvyMDsfRN03yMw/drEoU8l6RRLjV41bG+J+4WG0n/LOgyX2sW6gGCQ2QELNUMXuylejc
 HQWKHvKoy1dHrLVdr6DVRDxIuSpm8NcB8dA+Y2uYeSKFAi2UhDFcVN+Dbm2KDWmta0Ji
 w3C1kpwt9Jlz3T+EmvHuBYEQrZoyblDsRELSD+73dLQ7t6mLa8I6t0pctHehnf5tjnxx
 5j9w==
X-Gm-Message-State: AOJu0Yx00C2CCyZLFa+grM/ZbZ7LcTZ/fHnzLQuPNCqOyubEy+2pWX9H
 ULLdEeon+2UtHj44YPpkNWojWalQXkKQgl6XIv/BkA==
X-Google-Smtp-Source: AGHT+IHQjrKBN2W/XTUGjgDUFuvUK7AZ3rxBm9K5sILylu3ekkRnk9QIAkZ52paB+tE91Bkdrp94By2Pqo1QJn2nk5o=
X-Received: by 2002:a05:6871:725:b0:1b7:2edd:df6d with SMTP id
 f37-20020a056871072500b001b72edddf6dmr8019331oap.10.1696579018998; Fri, 06
 Oct 2023 00:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230920080622.3600226-1-mnissler@rivosinc.com>
 <20230920080622.3600226-5-mnissler@rivosinc.com>
 <A72E08FA-53B4-43A3-978B-7E5771588597@oracle.com>
In-Reply-To: <A72E08FA-53B4-43A3-978B-7E5771588597@oracle.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Fri, 6 Oct 2023 09:56:46 +0200
Message-ID: <CAGNS4TZ7J=L3eVDVmWkqNYqT-AQoDoivOYQJSGJF6MSSq2J7Vg@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] vfio-user: Message-based DMA support
To: Jag Raman <jag.raman@oracle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "john.levon@nutanix.com" <john.levon@nutanix.com>,
 "peterx@redhat.com" <peterx@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c2dc73060707957a"
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000c2dc73060707957a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 4, 2023 at 4:54=E2=80=AFPM Jag Raman <jag.raman@oracle.com> wro=
te:

>
>
> > On Sep 20, 2023, at 4:06 AM, Mattias Nissler <mnissler@rivosinc.com>
> wrote:
> >
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
> > hw/remote/trace-events    |  2 +
> > hw/remote/vfio-user-obj.c | 84 +++++++++++++++++++++++++++++++++++----
> > 2 files changed, 79 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/remote/trace-events b/hw/remote/trace-events
> > index 0d1b7d56a5..358a68fb34 100644
> > --- a/hw/remote/trace-events
> > +++ b/hw/remote/trace-events
> > @@ -9,6 +9,8 @@ vfu_cfg_read(uint32_t offset, uint32_t val) "vfu: cfg:
> 0x%x -> 0x%x"
> > vfu_cfg_write(uint32_t offset, uint32_t val) "vfu: cfg: 0x%x <- 0x%x"
> > vfu_dma_register(uint64_t gpa, size_t len) "vfu: registering GPA
> 0x%"PRIx64", %zu bytes"
> > vfu_dma_unregister(uint64_t gpa) "vfu: unregistering GPA 0x%"PRIx64""
> > +vfu_dma_read(uint64_t gpa, size_t len) "vfu: DMA read 0x%"PRIx64", %zu
> bytes"
> > +vfu_dma_write(uint64_t gpa, size_t len) "vfu: DMA write 0x%"PRIx64",
> %zu bytes"
> > vfu_bar_register(int i, uint64_t addr, uint64_t size) "vfu: BAR %d: add=
r
> 0x%"PRIx64" size 0x%"PRIx64""
> > vfu_bar_rw_enter(const char *op, uint64_t addr) "vfu: %s request for BA=
R
> address 0x%"PRIx64""
> > vfu_bar_rw_exit(const char *op, uint64_t addr) "vfu: Finished %s of BAR
> address 0x%"PRIx64""
> > diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> > index 8b10c32a3c..6a561f7969 100644
> > --- a/hw/remote/vfio-user-obj.c
> > +++ b/hw/remote/vfio-user-obj.c
> > @@ -300,6 +300,63 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t
> *vfu_ctx, char * const buf,
> >     return count;
> > }
> >
> > +static MemTxResult vfu_dma_read(void *opaque, hwaddr addr, uint64_t
> *val,
> > +                                unsigned size, MemTxAttrs attrs)
> > +{
> > +    MemoryRegion *region =3D opaque;
> > +    vfu_ctx_t *vfu_ctx =3D VFU_OBJECT(region->owner)->vfu_ctx;
> > +    uint8_t buf[sizeof(uint64_t)];
> > +
> > +    trace_vfu_dma_read(region->addr + addr, size);
> > +
> > +    g_autofree dma_sg_t *sg =3D g_malloc0(dma_sg_size());
> > +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> > +    if (vfu_addr_to_sgl(vfu_ctx, vfu_addr, size, sg, 1, PROT_READ) < 0
> ||
> > +        vfu_sgl_read(vfu_ctx, sg, 1, buf) !=3D 0) {
> > +        return MEMTX_ERROR;
> > +    }
> > +
> > +    *val =3D ldn_he_p(buf, size);
> > +
> > +    return MEMTX_OK;
> > +}
> > +
> > +static MemTxResult vfu_dma_write(void *opaque, hwaddr addr, uint64_t
> val,
> > +                                 unsigned size, MemTxAttrs attrs)
> > +{
> > +    MemoryRegion *region =3D opaque;
> > +    vfu_ctx_t *vfu_ctx =3D VFU_OBJECT(region->owner)->vfu_ctx;
> > +    uint8_t buf[sizeof(uint64_t)];
> > +
> > +    trace_vfu_dma_write(region->addr + addr, size);
> > +
> > +    stn_he_p(buf, size, val);
> > +
> > +    g_autofree dma_sg_t *sg =3D g_malloc0(dma_sg_size());
> > +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> > +    if (vfu_addr_to_sgl(vfu_ctx, vfu_addr, size, sg, 1, PROT_WRITE) < =
0
> ||
> > +        vfu_sgl_write(vfu_ctx, sg, 1, buf) !=3D 0) {
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
> > static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
> > {
> >     VfuObject *o =3D vfu_get_private(vfu_ctx);
> > @@ -308,17 +365,30 @@ static void dma_register(vfu_ctx_t *vfu_ctx,
> vfu_dma_info_t *info)
> >     g_autofree char *name =3D NULL;
> >     struct iovec *iov =3D &info->iova;
> >
> > -    if (!info->vaddr) {
> > -        return;
> > -    }
> > -
> >     name =3D g_strdup_printf("mem-%s-%"PRIx64"", o->device,
> > -                           (uint64_t)info->vaddr);
> > +                           (uint64_t)iov->iov_base);
> >
> >     subregion =3D g_new0(MemoryRegion, 1);
> >
> > -    memory_region_init_ram_ptr(subregion, NULL, name,
> > -                               iov->iov_len, info->vaddr);
> > +    if (info->vaddr) {
> > +        memory_region_init_ram_ptr(subregion, OBJECT(o), name,
> > +                                   iov->iov_len, info->vaddr);
> > +    } else {
> > +        /*
> > +         * Note that I/O regions' MemoryRegionOps handle accesses of a=
t
> most 8
> > +         * bytes at a time, and larger accesses are broken down.
> However,
> > +         * many/most DMA accesses are larger than 8 bytes and VFIO-use=
r
> can
> > +         * handle large DMA accesses just fine, thus this size
> restriction
> > +         * unnecessarily hurts performance, in particular given that
> each
> > +         * access causes a round trip on the VFIO-user socket.
> > +         *
> > +         * TODO: Investigate how to plumb larger accesses through memo=
ry
> > +         * regions, possibly by amending MemoryRegionOps or by creatin=
g
> a new
> > +         * memory region type.
> > +         */
> > +        memory_region_init_io(subregion, OBJECT(o), &vfu_dma_ops,
> subregion,
> > +                              name, iov->iov_len);
>
> Hi Mattias,
>
> We should update dma_unregister() to ensure we remove this subregion.
> dma_unregister() presently removes the RAM region, but not this one.
>

Oops. Fixing.


>
> --
> Jag
>
> > +    }
> >
> >     dma_as =3D pci_device_iommu_address_space(o->pci_dev);
> >
> > --
> > 2.34.1
> >
>
>

--000000000000c2dc73060707957a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 4, 2023 at 4:54=E2=80=AFP=
M Jag Raman &lt;<a href=3D"mailto:jag.raman@oracle.com">jag.raman@oracle.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><br>
<br>
&gt; On Sep 20, 2023, at 4:06 AM, Mattias Nissler &lt;<a href=3D"mailto:mni=
ssler@rivosinc.com" target=3D"_blank">mnissler@rivosinc.com</a>&gt; wrote:<=
br>
&gt; <br>
&gt; Wire up support for DMA for the case where the vfio-user client does n=
ot<br>
&gt; provide mmap()-able file descriptors, but DMA requests must be perform=
ed<br>
&gt; via the VFIO-user protocol. This installs an indirect memory region,<b=
r>
&gt; which already works for pci_dma_{read,write}, and pci_dma_map works<br=
>
&gt; thanks to the existing DMA bounce buffering support.<br>
&gt; <br>
&gt; Note that while simple scenarios work with this patch, there&#39;s a k=
nown<br>
&gt; race condition in libvfio-user that will mess up the communication<br>
&gt; channel. See <a href=3D"https://github.com/nutanix/libvfio-user/issues=
/279" rel=3D"noreferrer" target=3D"_blank">https://github.com/nutanix/libvf=
io-user/issues/279</a> for<br>
&gt; details as well as a proposed fix.<br>
&gt; <br>
&gt; Signed-off-by: Mattias Nissler &lt;<a href=3D"mailto:mnissler@rivosinc=
.com" target=3D"_blank">mnissler@rivosinc.com</a>&gt;<br>
&gt; ---<br>
&gt; hw/remote/trace-events=C2=A0 =C2=A0 |=C2=A0 2 +<br>
&gt; hw/remote/vfio-user-obj.c | 84 +++++++++++++++++++++++++++++++++++----=
<br>
&gt; 2 files changed, 79 insertions(+), 7 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/remote/trace-events b/hw/remote/trace-events<br>
&gt; index 0d1b7d56a5..358a68fb34 100644<br>
&gt; --- a/hw/remote/trace-events<br>
&gt; +++ b/hw/remote/trace-events<br>
&gt; @@ -9,6 +9,8 @@ vfu_cfg_read(uint32_t offset, uint32_t val) &quot;vfu:=
 cfg: 0x%x -&gt; 0x%x&quot;<br>
&gt; vfu_cfg_write(uint32_t offset, uint32_t val) &quot;vfu: cfg: 0x%x &lt;=
- 0x%x&quot;<br>
&gt; vfu_dma_register(uint64_t gpa, size_t len) &quot;vfu: registering GPA =
0x%&quot;PRIx64&quot;, %zu bytes&quot;<br>
&gt; vfu_dma_unregister(uint64_t gpa) &quot;vfu: unregistering GPA 0x%&quot=
;PRIx64&quot;&quot;<br>
&gt; +vfu_dma_read(uint64_t gpa, size_t len) &quot;vfu: DMA read 0x%&quot;P=
RIx64&quot;, %zu bytes&quot;<br>
&gt; +vfu_dma_write(uint64_t gpa, size_t len) &quot;vfu: DMA write 0x%&quot=
;PRIx64&quot;, %zu bytes&quot;<br>
&gt; vfu_bar_register(int i, uint64_t addr, uint64_t size) &quot;vfu: BAR %=
d: addr 0x%&quot;PRIx64&quot; size 0x%&quot;PRIx64&quot;&quot;<br>
&gt; vfu_bar_rw_enter(const char *op, uint64_t addr) &quot;vfu: %s request =
for BAR address 0x%&quot;PRIx64&quot;&quot;<br>
&gt; vfu_bar_rw_exit(const char *op, uint64_t addr) &quot;vfu: Finished %s =
of BAR address 0x%&quot;PRIx64&quot;&quot;<br>
&gt; diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c<br>
&gt; index 8b10c32a3c..6a561f7969 100644<br>
&gt; --- a/hw/remote/vfio-user-obj.c<br>
&gt; +++ b/hw/remote/vfio-user-obj.c<br>
&gt; @@ -300,6 +300,63 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *v=
fu_ctx, char * const buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0return count;<br>
&gt; }<br>
&gt; <br>
&gt; +static MemTxResult vfu_dma_read(void *opaque, hwaddr addr, uint64_t *=
val,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size, MemTxAttrs attrs)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *region =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 vfu_ctx_t *vfu_ctx =3D VFU_OBJECT(region-&gt;owner)-&gt=
;vfu_ctx;<br>
&gt; +=C2=A0 =C2=A0 uint8_t buf[sizeof(uint64_t)];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_vfu_dma_read(region-&gt;addr + addr, size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_autofree dma_sg_t *sg =3D g_malloc0(dma_sg_size());<b=
r>
&gt; +=C2=A0 =C2=A0 vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region-&gt=
;addr + addr);<br>
&gt; +=C2=A0 =C2=A0 if (vfu_addr_to_sgl(vfu_ctx, vfu_addr, size, sg, 1, PRO=
T_READ) &lt; 0 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vfu_sgl_read(vfu_ctx, sg, 1, buf) !=3D 0)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ERROR;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *val =3D ldn_he_p(buf, size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return MEMTX_OK;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static MemTxResult vfu_dma_write(void *opaque, hwaddr addr, uint64_t =
val,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned size, MemTxAttrs =
attrs)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *region =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 vfu_ctx_t *vfu_ctx =3D VFU_OBJECT(region-&gt;owner)-&gt=
;vfu_ctx;<br>
&gt; +=C2=A0 =C2=A0 uint8_t buf[sizeof(uint64_t)];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_vfu_dma_write(region-&gt;addr + addr, size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 stn_he_p(buf, size, val);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_autofree dma_sg_t *sg =3D g_malloc0(dma_sg_size());<b=
r>
&gt; +=C2=A0 =C2=A0 vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region-&gt=
;addr + addr);<br>
&gt; +=C2=A0 =C2=A0 if (vfu_addr_to_sgl(vfu_ctx, vfu_addr, size, sg, 1, PRO=
T_WRITE) &lt; 0 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vfu_sgl_write(vfu_ctx, sg, 1, buf) !=3D 0=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ERROR;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return MEMTX_OK;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps vfu_dma_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read_with_attrs =3D vfu_dma_read,<br>
&gt; +=C2=A0 =C2=A0 .write_with_attrs =3D vfu_dma_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_HOST_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .unaligned =3D true,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0VfuObject *o =3D vfu_get_private(vfu_ctx);<br>
&gt; @@ -308,17 +365,30 @@ static void dma_register(vfu_ctx_t *vfu_ctx, vfu=
_dma_info_t *info)<br>
&gt;=C2=A0 =C2=A0 =C2=A0g_autofree char *name =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct iovec *iov =3D &amp;info-&gt;iova;<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 if (!info-&gt;vaddr) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0name =3D g_strdup_printf(&quot;mem-%s-%&quot;PRIx64=
&quot;&quot;, o-&gt;device,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t)info-&gt;vaddr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t)iov-&gt;iov_base);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0subregion =3D g_new0(MemoryRegion, 1);<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 memory_region_init_ram_ptr(subregion, NULL, name,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iov-&gt;iov_len, info-&gt;vaddr);=
<br>
&gt; +=C2=A0 =C2=A0 if (info-&gt;vaddr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_ram_ptr(subregion, OBJ=
ECT(o), name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iov-&gt;iov_len, in=
fo-&gt;vaddr);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Note that I/O regions&#39; Memory=
RegionOps handle accesses of at most 8<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* bytes at a time, and larger acces=
ses are broken down. However,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* many/most DMA accesses are larger=
 than 8 bytes and VFIO-user can<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* handle large DMA accesses just fi=
ne, thus this size restriction<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* unnecessarily hurts performance, =
in particular given that each<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* access causes a round trip on the=
 VFIO-user socket.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: Investigate how to plumb la=
rger accesses through memory<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* regions, possibly by amending Mem=
oryRegionOps or by creating a new<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* memory region type.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_io(subregion, OBJECT(o=
), &amp;vfu_dma_ops, subregion,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name, iov-&gt;iov_len);<br>
<br>
Hi Mattias,<br>
<br>
We should update dma_unregister() to ensure we remove this subregion.<br>
dma_unregister() presently removes the RAM region, but not this one.<br></b=
lockquote><div><br></div><div>Oops. Fixing.</div><div>=C2=A0<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
--<br>
Jag<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0dma_as =3D pci_device_iommu_address_space(o-&gt;pci=
_dev);<br>
&gt; <br>
&gt; -- <br>
&gt; 2.34.1<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000c2dc73060707957a--

