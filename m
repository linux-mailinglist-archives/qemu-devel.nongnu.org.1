Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1CB7BB1AE
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 08:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoeZy-0006qw-JZ; Fri, 06 Oct 2023 02:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qoeZw-0006qh-7C
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:44:52 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qoeZt-0000Om-Bp
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:44:51 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1e1a2e26afcso1127564fac.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696574687; x=1697179487;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U6a/SafZ0qF/auMPTosKcZp6LlkWpp+7A0WUbRm0wlg=;
 b=v9GFxQQ8VDLwPuKizhd4MZZFq9JlGXhB6FUwnvmOibvyAczD5ujCDzUBE0685Ujwef
 IR5071NYn7QTFEqKLoGVEj/AxDs6zrzFeNDFB5ZP1IRR+Fy/3oJuv6j1oNxwzlaELld3
 pf+W7sUnObyVQgmt+LGRUT4QMrFWRKx8yljlnzRrpGqAGH6W0VL/7VL3J+viOHOeIYKC
 JEgROg8aQWrglvGXriAOTmD4/7JB4AQNxUi6XSMIpb83+8x4nouU/YFKjQtBPVkdJjHq
 d+/s6nbz73Q+dVe2cRkUj/YxKWtJV1HKRG7epl8JNgygWT6jvRnd3Yx5lgld10iVmRKq
 D69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696574687; x=1697179487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U6a/SafZ0qF/auMPTosKcZp6LlkWpp+7A0WUbRm0wlg=;
 b=WwfFUkfgoUhoG+NhOO+mj236s4ZrZYpYgiDb3EnSPpoxt1AI5GXDC17T+S8owImnI7
 l28EQlYu2utBlVCfqLqXv6mtLTVWQMxF7i6F4YavVtLXz7+bOZjCEphm0DHOhKE9rFca
 1k9JSVirm7abM5IzVv6MjY/Vy54tdopDtkwbk8HKUSaIx60V6D4qmcJaoZXFtKiheFZm
 bhcHbu5iqX3wk4tNWpzpZDO0lIlgLDZb+sz0UnEwyw9kQPuUtsGXA+wh4fG+pZoGDnOZ
 xbJR68nvpVok6AQQw3dEMt2/xbXJUA8ysdZYGcVeK8gHOgb7y2abXe9Sz2IpEN5AWIZ2
 AhrA==
X-Gm-Message-State: AOJu0YwhXRRCRtyNajrr5WXRpfCmbbzthX7N0Y2SoLerTlYA6wKGyPY6
 68rL6OhoUIacdramJusIvgxrGCaSG7fnfaa2kIvpTw==
X-Google-Smtp-Source: AGHT+IGVLFxDpO3srLoyFVxVjYKp7ynv4klQoTR00si+SWmFUvJXIxMaSIcPGibYngwCv+AVv7QKj846k9zUC1oWq0U=
X-Received: by 2002:a05:6870:71cb:b0:1dc:f539:ad70 with SMTP id
 p11-20020a05687071cb00b001dcf539ad70mr8300247oag.56.1696574687399; Thu, 05
 Oct 2023 23:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230920080622.3600226-1-mnissler@rivosinc.com>
 <20230920080622.3600226-6-mnissler@rivosinc.com>
 <7041B00F-1F3D-4E65-B058-3D9739E58895@oracle.com>
In-Reply-To: <7041B00F-1F3D-4E65-B058-3D9739E58895@oracle.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Fri, 6 Oct 2023 08:44:36 +0200
Message-ID: <CAGNS4TaTdCOp4v-3ewW-WjBB=44EixFXiti1nWqXBk97+rqCrg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] vfio-user: Fix config space access byte order
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
Content-Type: multipart/alternative; boundary="00000000000093e898060706934a"
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x30.google.com
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

--00000000000093e898060706934a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 5, 2023 at 6:30=E2=80=AFPM Jag Raman <jag.raman@oracle.com> wro=
te:

>
>
> > On Sep 20, 2023, at 4:06 AM, Mattias Nissler <mnissler@rivosinc.com>
> wrote:
> >
> > PCI config space is little-endian, so on a big-endian host we need to
> > perform byte swaps for values as they are passed to and received from
> > the generic PCI config space access machinery.
> >
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > ---
> > hw/remote/vfio-user-obj.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> > index 6a561f7969..6043a91b11 100644
> > --- a/hw/remote/vfio-user-obj.c
> > +++ b/hw/remote/vfio-user-obj.c
> > @@ -281,7 +281,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t
> *vfu_ctx, char * const buf,
> >     while (bytes > 0) {
> >         len =3D (bytes > pci_access_width) ? pci_access_width : bytes;
> >         if (is_write) {
> > -            memcpy(&val, ptr, len);
> > +            val =3D ldn_le_p(ptr, len);
> >             pci_host_config_write_common(o->pci_dev, offset,
> >                                          pci_config_size(o->pci_dev),
> >                                          val, len);
> > @@ -289,7 +289,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t
> *vfu_ctx, char * const buf,
> >         } else {
> >             val =3D pci_host_config_read_common(o->pci_dev, offset,
> >
>  pci_config_size(o->pci_dev), len);
> > -            memcpy(ptr, &val, len);
> > +            stn_le_p(ptr, len, val);
> >             trace_vfu_cfg_read(offset, val);
> >         }
> >         offset +=3D len;
> > --
> > 2.34.1
> >
>
> Hey,
>
> When you tested on s390x, could you see the correct values for the config
> space in the Kernel? For example, were any known device's vendor and devi=
ce
> IDs valid?
>

I don't exactly remember whether I checked vendor and device IDs, but I've
done something more comprehensive: I set up a qemu vfio-user server
exposing an nvme device and then connected a qemu client (with the
vfio-user client patches from the oracle qemu github repo). Linux running
in the client probes the nvme device successfully and I've mounted a file
system on it. Both qemu binaries are s390x.


>
> I'm asking because flatview_read_continue() / flatview_write_continue()
> does endianness adjustment. So, I want to confirm that the endianness
> adjustment in your code also makes sense from Kernel's perspective.
>

The conversion in the flatview access path is adjusting from the endianness
of the memory region to what the emulated CPU needs. Since the PCI config
space memory region is little-endian (see pci_host_data_le_ops), we're
doing a swap there. The code I'm changing is backing the memory region, so
incoming/outgoing data for writes/reads must be in little-endian to adhere
to the endianness declared by the memory region.


>
> I'm trying to access a big-endian system, but no luck.
>

Btw. I don't have access to big-endian hardware either, but it was
surprisingly straightforward to make my x86 ubuntu machine run s390x
binaries via multiarch + qemu user mode (qemu turtles all the way down :-D)


>
> #0  0x0000555555b97a30 in vfio_user_io_region_read
> (vbasedev=3D0x555557802c80, index=3D7 '\a', off=3D4, size=3D2, data=3D0x7=
fff6cfb945c)
> at ../hw/vfio/user.c:1985
> #1  0x0000555555b8dcfb in vfio_pci_read_config (pdev=3D0x555557802250,
> addr=3D4, len=3D2) at ../hw/vfio/pci.c:1202
> #2  0x000055555599d3f9 in pci_host_config_read_common
> (pci_dev=3D0x555557802250, addr=3Daddr@entry=3D4, limit=3D<optimized out>=
,
> limit@entry=3D256, len=3Dlen@entry=3D2) at ../hw/pci/pci_host.c:107
> #3  0x000055555599d74a in pci_data_read (s=3D<optimized out>,
> addr=3D2147493892, len=3D2) at ../hw/pci/pci_host.c:143
> #4  0x000055555599d84f in pci_host_data_read (opaque=3D<optimized out>,
> addr=3D<optimized out>, len=3D<optimized out>) at ../hw/pci/pci_host.c:18=
8
> #5  0x0000555555bc3c4d in memory_region_read_accessor (mr=3Dmr@entry=3D0x=
5555569de370,
> addr=3D0, value=3Dvalue@entry=3D0x7fff6cfb9710, size=3Dsize@entry=3D2, sh=
ift=3D0,
> mask=3Dmask@entry=3D65535, attrs=3D...) at ../softmmu/memory.c:441
> #6  0x0000555555bc3fce in access_with_adjusted_size (addr=3Daddr@entry=3D=
0,
> value=3Dvalue@entry=3D0x7fff6cfb9710, size=3Dsize@entry=3D2,
> access_size_min=3D<optimized out>, access_size_max=3D<optimized out>,
> access_fn=3D0x555555bc3c10 <memory_region_read_accessor>, mr=3D0x5555569d=
e370,
> attrs=3D...) at ../softmmu/memory.c:569
> #7  0x0000555555bc41a1 in memory_region_dispatch_read1 (attrs=3D..., size=
=3D2,
> pval=3D0x7fff6cfb9710, addr=3D<optimized out>, mr=3D<optimized out>) at
> ../softmmu/memory.c:1443
> #8  0x0000555555bc41a1 in memory_region_dispatch_read (mr=3Dmr@entry=3D0x=
5555569de370,
> addr=3D<optimized out>, pval=3Dpval@entry=3D0x7fff6cfb9710, op=3DMO_16,
> attrs=3Dattrs@entry=3D...) at ../softmmu/memory.c:1476
> #9  0x0000555555bce13b in flatview_read_continue (fv=3Dfv@entry=3D0x7fff6=
861e120,
> addr=3Daddr@entry=3D3324, attrs=3D..., ptr=3Dptr@entry=3D0x7ffff7fdf000,
> len=3Dlen@entry=3D2, addr1=3D<optimized out>, l=3D<optimized out>,
> mr=3D0x5555569de370) at /home/github/oracle/qemu/include/qemu/host-utils.=
h:219
> #10 0x0000555555bce2f7 in flatview_read (fv=3D0x7fff6861e120, addr=3Daddr=
@entry=3D3324,
> attrs=3Dattrs@entry=3D..., buf=3Dbuf@entry=3D0x7ffff7fdf000, len=3Dlen@en=
try=3D2) at
> ../softmmu/physmem.c:2762
> #11 0x0000555555bce448 in address_space_read_full (as=3D0x555556671620
> <address_space_io>, addr=3D3324, attrs=3D..., buf=3D0x7ffff7fdf000, len=
=3D2) at
> ../softmmu/physmem.c:2775
> #12 0x0000555555bce595 in address_space_rw (as=3Das@entry=3D0x55555667162=
0
> <address_space_io>, addr=3Daddr@entry=3D3324, attrs=3D..., attrs@entry=3D=
...,
> buf=3D<optimized out>, len=3Dlen@entry=3D2, is_write=3Dis_write@entry=3Df=
alse) at
> ../softmmu/physmem.c:2803
> #13 0x0000555555c1973f in kvm_handle_io (count=3D1, size=3D2,
> direction=3D<optimized out>, data=3D<optimized out>, attrs=3D..., port=3D=
3324) at
> ../accel/kvm/kvm-all.c:2778
> #14 0x0000555555c1973f in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x5555569ab390)=
 at
> ../accel/kvm/kvm-all.c:3029
> #15 0x0000555555c1a8dd in kvm_vcpu_thread_fn (arg=3Darg@entry=3D0x5555569=
ab390)
> at ../accel/kvm/kvm-accel-ops.c:51
> #16 0x0000555555d8f4fb in qemu_thread_start (args=3D<optimized out>) at
> ../util/qemu-thread-posix.c:541
> #17 0x00007ffff577dea5 in start_thread () at /lib64/libpthread.so.0
> #18 0x00007ffff54a6b0d in clone () at /lib64/libc.so.6
>
> FYI, the above is the stack trace from the client.
> vfio_user_io_region_read() in the above sends a message to the server, an=
d
> the server ends up calling either vfu_object_cfg_access() or
> vfu_object_bar_rw()  (which also does the endianness correction) dependin=
g
> on the region.
>
> --
> Jag
>
>

--00000000000093e898060706934a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 5, 2023 at 6:30=E2=80=AFP=
M Jag Raman &lt;<a href=3D"mailto:jag.raman@oracle.com">jag.raman@oracle.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><br>
<br>
&gt; On Sep 20, 2023, at 4:06 AM, Mattias Nissler &lt;<a href=3D"mailto:mni=
ssler@rivosinc.com" target=3D"_blank">mnissler@rivosinc.com</a>&gt; wrote:<=
br>
&gt; <br>
&gt; PCI config space is little-endian, so on a big-endian host we need to<=
br>
&gt; perform byte swaps for values as they are passed to and received from<=
br>
&gt; the generic PCI config space access machinery.<br>
&gt; <br>
&gt; Signed-off-by: Mattias Nissler &lt;<a href=3D"mailto:mnissler@rivosinc=
.com" target=3D"_blank">mnissler@rivosinc.com</a>&gt;<br>
&gt; ---<br>
&gt; hw/remote/vfio-user-obj.c | 4 ++--<br>
&gt; 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c<br>
&gt; index 6a561f7969..6043a91b11 100644<br>
&gt; --- a/hw/remote/vfio-user-obj.c<br>
&gt; +++ b/hw/remote/vfio-user-obj.c<br>
&gt; @@ -281,7 +281,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vf=
u_ctx, char * const buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0while (bytes &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D (bytes &gt; pci_access_width)=
 ? pci_access_width : bytes;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_write) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;val, ptr, len);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D ldn_le_p(ptr, len);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_host_config_write_c=
ommon(o-&gt;pci_dev, offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pci_config_size(o-&gt;pci_dev),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 val, len);<br>
&gt; @@ -289,7 +289,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vf=
u_ctx, char * const buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D pci_host_config=
_read_common(o-&gt;pci_dev, offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0pci_config_size(o-&gt;pci_dev), len);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(ptr, &amp;val, len);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_le_p(ptr, len, val);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vfu_cfg_read(offs=
et, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset +=3D len;<br>
&gt; -- <br>
&gt; 2.34.1<br>
&gt; <br>
<br>
Hey,<br>
<br>
When you tested on s390x, could you see the correct values for the config s=
pace in the Kernel? For example, were any known device&#39;s vendor and dev=
ice IDs valid?<br></blockquote><div><br></div><div>I don&#39;t exactly reme=
mber whether I checked vendor and device IDs, but I&#39;ve done something m=
ore comprehensive: I set up a qemu vfio-user server exposing an nvme device=
 and then connected a qemu client (with the vfio-user client patches from t=
he oracle qemu github repo). Linux running in the client probes the nvme de=
vice successfully and I&#39;ve mounted a file system on it. Both qemu binar=
ies are s390x.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
I&#39;m asking because flatview_read_continue() / flatview_write_continue()=
 does endianness adjustment. So, I want to confirm that the endianness adju=
stment in your code also makes sense from Kernel&#39;s perspective.<br></bl=
ockquote><div><br></div><div>The conversion in the flatview access path is =
adjusting from the endianness of the memory region to what the emulated CPU=
 needs. Since the PCI config space memory region is little-endian (see pci_=
host_data_le_ops), we&#39;re doing a swap there. The code I&#39;m changing =
is backing the memory region, so incoming/outgoing data for writes/reads mu=
st be in little-endian to adhere to the endianness declared by the memory r=
egion.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
I&#39;m trying to access a big-endian system, but no luck.<br></blockquote>=
<div><br></div><div>Btw. I don&#39;t have access to big-endian hardware eit=
her, but it was surprisingly
 straightforward to make my x86 ubuntu machine run s390x binaries via multi=
arch + qemu user mode (qemu turtles all the way down :-D)</div><div>=C2=A0<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
#0=C2=A0 0x0000555555b97a30 in vfio_user_io_region_read (vbasedev=3D0x55555=
7802c80, index=3D7 &#39;\a&#39;, off=3D4, size=3D2, data=3D0x7fff6cfb945c) =
at ../hw/vfio/user.c:1985<br>
#1=C2=A0 0x0000555555b8dcfb in vfio_pci_read_config (pdev=3D0x555557802250,=
 addr=3D4, len=3D2) at ../hw/vfio/pci.c:1202<br>
#2=C2=A0 0x000055555599d3f9 in pci_host_config_read_common (pci_dev=3D0x555=
557802250, addr=3Daddr@entry=3D4, limit=3D&lt;optimized out&gt;, limit@entr=
y=3D256, len=3Dlen@entry=3D2) at ../hw/pci/pci_host.c:107<br>
#3=C2=A0 0x000055555599d74a in pci_data_read (s=3D&lt;optimized out&gt;, ad=
dr=3D2147493892, len=3D2) at ../hw/pci/pci_host.c:143<br>
#4=C2=A0 0x000055555599d84f in pci_host_data_read (opaque=3D&lt;optimized o=
ut&gt;, addr=3D&lt;optimized out&gt;, len=3D&lt;optimized out&gt;) at ../hw=
/pci/pci_host.c:188<br>
#5=C2=A0 0x0000555555bc3c4d in memory_region_read_accessor (mr=3Dmr@entry=
=3D0x5555569de370, addr=3D0, value=3Dvalue@entry=3D0x7fff6cfb9710, size=3Ds=
ize@entry=3D2, shift=3D0, mask=3Dmask@entry=3D65535, attrs=3D...) at ../sof=
tmmu/memory.c:441<br>
#6=C2=A0 0x0000555555bc3fce in access_with_adjusted_size (addr=3Daddr@entry=
=3D0, value=3Dvalue@entry=3D0x7fff6cfb9710, size=3Dsize@entry=3D2, access_s=
ize_min=3D&lt;optimized out&gt;, access_size_max=3D&lt;optimized out&gt;, a=
ccess_fn=3D0x555555bc3c10 &lt;memory_region_read_accessor&gt;, mr=3D0x55555=
69de370, attrs=3D...) at ../softmmu/memory.c:569<br>
#7=C2=A0 0x0000555555bc41a1 in memory_region_dispatch_read1 (attrs=3D..., s=
ize=3D2, pval=3D0x7fff6cfb9710, addr=3D&lt;optimized out&gt;, mr=3D&lt;opti=
mized out&gt;) at ../softmmu/memory.c:1443<br>
#8=C2=A0 0x0000555555bc41a1 in memory_region_dispatch_read (mr=3Dmr@entry=
=3D0x5555569de370, addr=3D&lt;optimized out&gt;, pval=3Dpval@entry=3D0x7fff=
6cfb9710, op=3DMO_16, attrs=3Dattrs@entry=3D...) at ../softmmu/memory.c:147=
6<br>
#9=C2=A0 0x0000555555bce13b in flatview_read_continue (fv=3Dfv@entry=3D0x7f=
ff6861e120, addr=3Daddr@entry=3D3324, attrs=3D..., ptr=3Dptr@entry=3D0x7fff=
f7fdf000, len=3Dlen@entry=3D2, addr1=3D&lt;optimized out&gt;, l=3D&lt;optim=
ized out&gt;, mr=3D0x5555569de370) at /home/github/oracle/qemu/include/qemu=
/host-utils.h:219<br>
#10 0x0000555555bce2f7 in flatview_read (fv=3D0x7fff6861e120, addr=3Daddr@e=
ntry=3D3324, attrs=3Dattrs@entry=3D..., buf=3Dbuf@entry=3D0x7ffff7fdf000, l=
en=3Dlen@entry=3D2) at ../softmmu/physmem.c:2762<br>
#11 0x0000555555bce448 in address_space_read_full (as=3D0x555556671620 &lt;=
address_space_io&gt;, addr=3D3324, attrs=3D..., buf=3D0x7ffff7fdf000, len=
=3D2) at ../softmmu/physmem.c:2775<br>
#12 0x0000555555bce595 in address_space_rw (as=3Das@entry=3D0x555556671620 =
&lt;address_space_io&gt;, addr=3Daddr@entry=3D3324, attrs=3D..., attrs@entr=
y=3D..., buf=3D&lt;optimized out&gt;, len=3Dlen@entry=3D2, is_write=3Dis_wr=
ite@entry=3Dfalse) at ../softmmu/physmem.c:2803<br>
#13 0x0000555555c1973f in kvm_handle_io (count=3D1, size=3D2, direction=3D&=
lt;optimized out&gt;, data=3D&lt;optimized out&gt;, attrs=3D..., port=3D332=
4) at ../accel/kvm/kvm-all.c:2778<br>
#14 0x0000555555c1973f in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x5555569ab390) a=
t ../accel/kvm/kvm-all.c:3029<br>
#15 0x0000555555c1a8dd in kvm_vcpu_thread_fn (arg=3Darg@entry=3D0x5555569ab=
390) at ../accel/kvm/kvm-accel-ops.c:51<br>
#16 0x0000555555d8f4fb in qemu_thread_start (args=3D&lt;optimized out&gt;) =
at ../util/qemu-thread-posix.c:541<br>
#17 0x00007ffff577dea5 in start_thread () at /lib64/libpthread.so.0<br>
#18 0x00007ffff54a6b0d in clone () at /lib64/libc.so.6<br>
<br>
FYI, the above is the stack trace from the client. vfio_user_io_region_read=
() in the above sends a message to the server, and the server ends up calli=
ng either vfu_object_cfg_access() or vfu_object_bar_rw()=C2=A0 (which also =
does the endianness correction) depending on the region.<br>
<br>
--<br>
Jag<br>
<br>
</blockquote></div></div>

--00000000000093e898060706934a--

