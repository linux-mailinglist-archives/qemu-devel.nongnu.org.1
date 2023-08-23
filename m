Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BCC7853ED
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:29:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkAE-0003Uc-8l; Wed, 23 Aug 2023 05:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkAD-0003UN-0h
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:28:33 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkAB-0006VF-9X
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:28:32 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a412653335so3996861b6e.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 02:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692782909; x=1693387709; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CG9aJRjhkpfqqrUU/55WKlKsJgdOWxcnikkKVH0GVA8=;
 b=FldyiyOdNuQjTm0re5fQDEb7Q3FtI+j1wHclJqRx0jaYT530BYLikynJryIEVS8YHV
 18PB1O5ELgBbTIU9J+Utnz1fW7TR6AzUx79BcK7cRIYblG05yG6xSgSJjFzjDJK7UjrB
 NsZPB2ET+30xhEyRscEA3OkXvoMk3wx4azeSn8Bnu0Dkfr9/cap5Zgaqrr+xmRyn8udZ
 YdHZJmJWjWdddW9pDpdFj/eg1+OiTnrJX/01EDV5ifdYfme26C70B0zSQhW4voeHG1hp
 DMBAUT15sl3vb1x1OvNQuaPAtzrnB1Z7sDbhTDrs0lADg5FYbcufAauS/riB7AyU202S
 fjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692782909; x=1693387709;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CG9aJRjhkpfqqrUU/55WKlKsJgdOWxcnikkKVH0GVA8=;
 b=ItPdV5XtSyQswCd29TlwOPLGoNn/GBV8ds7dXVk+CQVGIxJnH0whcePW54N74jeRlb
 3DIIZiQW9zJVKPT+PyZuvA/w18TZMGFU3IwwZRPFLTT6sNBqDMnJCjwXyaqztPSBhQxg
 ZFir6dVmOQUUp2a5QFkgMOq3xbLQrwHKnQ8KWEb/sR1XIhbSIJ81OH49kpS3nYQJX8PP
 k6uk0zxoyq3XtogT9GwliHEmNG8ccburQIRDcdEnBv8FhtfhsSzqCDa0kvLGd8fIkqUh
 Q0DQVOAaWqTtKUSShW6b0b6sQs/Q48jHqJ619+Zc/qOhlKIoQN67a+tRaLtkJPFjtA26
 OEkg==
X-Gm-Message-State: AOJu0Yx0+n0n59z/eB5iobGlNWv+7dtGI21lSlW7ZCgozkXaAyP4gHVO
 PKThhJqj0O8VaqqN44uV/V7LR8PvHhCU5fjyyCl4bQ==
X-Google-Smtp-Source: AGHT+IEl3Bfh6/N7lcjxHvgT9zwCXmY5R/7Qm+tFIf4QOSh0bwDstNo/CZVGSTDejGEdA5NrVCWxR/oJ+093f74j274=
X-Received: by 2002:a05:6808:1997:b0:39c:93ba:cb92 with SMTP id
 bj23-20020a056808199700b0039c93bacb92mr16828278oib.8.1692782909621; Wed, 23
 Aug 2023 02:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230704080628.852525-1-mnissler@rivosinc.com>
 <20230704080628.852525-4-mnissler@rivosinc.com>
 <20230720183206.GD210977@fedora>
In-Reply-To: <20230720183206.GD210977@fedora>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Wed, 23 Aug 2023 11:28:18 +0200
Message-ID: <CAGNS4TZYo_o7gUcWUjLCNQzUwJbFu6mcShQ_qhrSX9u4XbE7iA@mail.gmail.com>
Subject: Re: [PATCH 3/3] vfio-user: Message-based DMA support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, john.levon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x22b.google.com
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

On Thu, Jul 20, 2023 at 8:32=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Jul 04, 2023 at 01:06:27AM -0700, Mattias Nissler wrote:
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
> > channel: https://github.com/nutanix/libvfio-user/issues/279 I intend to
> > contribute a fix for this problem, see discussion on the github issue
> > for more details.
> >
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > ---
> >  hw/remote/vfio-user-obj.c | 62 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 55 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> > index 8b10c32a3c..9799580c77 100644
> > --- a/hw/remote/vfio-user-obj.c
> > +++ b/hw/remote/vfio-user-obj.c
> > @@ -300,6 +300,53 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vf=
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
> > +
> > +    dma_sg_t *sg =3D alloca(dma_sg_size());
> > +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> > +    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_READ) =
< 0 ||
> > +        vfu_sgl_read(o->vfu_ctx, sg, 1, val) !=3D 0) {
>
> Does this work on big-endian host CPUs? It looks like reading 0x12345678
> into uint64_t val would result in *val =3D 0x12345678xxxxxxxx instead of
> 0x12345678.

Ah, good catch, thanks! Confirmed as an issue using a cross-compiled
s390x qemu binary. I will fix this by using ld/st helpers.




>
> > +        return MEMTX_ERROR;
> > +    }
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
> > +
> > +    dma_sg_t *sg =3D alloca(dma_sg_size());
> > +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> > +    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_WRITE)=
 < 0 ||
> > +        vfu_sgl_write(o->vfu_ctx, sg, 1, &val) !=3D 0)  {
>
> Same potential endianness issue here.
>
> Stefan

