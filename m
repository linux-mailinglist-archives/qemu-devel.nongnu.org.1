Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A57F7A6A85
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 20:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qifFB-0008M0-2Q; Tue, 19 Sep 2023 14:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qifF9-0008LW-6Z
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 14:14:39 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qifF7-0004uX-EQ
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 14:14:38 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1c26bb27feeso3906438fac.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695147276; x=1695752076;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NlOLEND61qWDNjDGFFl3Vk783imTAJfXqIBakX0/Qeg=;
 b=sln7IuU97qUswnSTPDi+0JsBGzZjatI7OTSarAAgy21JJXCd5E3cGLyG86/GWEeNJD
 T8C1VjD77DBaXyU+swLS6vI35r0sOYOrJxf+FxdtWf0uNxvC+l8vgXYzZVBCq1ur8JmL
 gIj4iZuCDzXM4BvmUDAcVfEgkYRIO5opsmQR/Az+IDm/gmPw4z+t73DzK91qXPRaRqut
 xvLGRVYr8TkuHCAJsHGiwvWAjMBTfNlVqIbAejtxgiBU+21axvyTEndKGKwszhiIB5cT
 FkE7O1vhCz/UGt12UuTgTb+QhwJNd6vZc9Wae3aVgTzaTYIVXJvQEcvcF5sFnQqQrxtP
 a4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695147276; x=1695752076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlOLEND61qWDNjDGFFl3Vk783imTAJfXqIBakX0/Qeg=;
 b=MMFyYQGYJjUSZBwv8PAs6up6GI5AlH2eZN8XHuzgB4od/w+uQUx1S+xd5yCkml3Mbx
 WN8rrFG6qI1tlk6HQvU1vem0xnWKy/r4/NVHv2Re+PlY4H5I2Hvm6XwUQYbOGWo6nzWa
 xc+CTpXVtlZgAWIG2mZZSSwIaI/Ep+UsaE0amoC7Om8GnBXHXN/bgg61+p+/+qBmMsL6
 paG+EwrdYvwPzjQp79ocR7McunRb1c0kyFJ3vdKR4cQbYd2hsngueVe/N/zZ35yn8l1N
 642/yXS/rAnE2XK6DktKaQf2ax/HhrFVkwmTdUctXUhtmAj1X+TwSTfetN4Nm38iklO1
 rAsA==
X-Gm-Message-State: AOJu0YyfxJDaKpmSnjsBhaDdFESJFE0OVBAJqxZ0gTIrY36a5nzHoyS7
 qtwCt/4iuWOjdJd30ibSsZ1jfo/Z5YqqcNoOCVf0+A==
X-Google-Smtp-Source: AGHT+IHUFfMUJOyMkSNOsbL39PCXN9Y3f87Da+sVYWD5pOuUdOMQnpSRlr72k/HBKbchptkCziZI6rTxz+EoPeB8pb4=
X-Received: by 2002:a05:6870:970f:b0:1d5:cdf7:bd95 with SMTP id
 n15-20020a056870970f00b001d5cdf7bd95mr286526oaq.16.1695147276018; Tue, 19 Sep
 2023 11:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230919160814.3343727-1-mnissler@rivosinc.com>
 <20230919160814.3343727-3-mnissler@rivosinc.com> <ZQnW4e1wordu4UbM@x1n>
In-Reply-To: <ZQnW4e1wordu4UbM@x1n>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Tue, 19 Sep 2023 20:14:25 +0200
Message-ID: <CAGNS4Tan24b2Yb1BvKC4ycjq6MO+_qYqYQy_KrOw6MWDPB3dJg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] softmmu: Support concurrent bounce buffers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com, stefanha@redhat.com, 
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x2f.google.com
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

On Tue, Sep 19, 2023 at 7:14=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Sep 19, 2023 at 09:08:10AM -0700, Mattias Nissler wrote:
> > @@ -3119,31 +3143,35 @@ void *address_space_map(AddressSpace *as,
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
> > +        assert(bounce->magic =3D=3D BOUNCE_BUFFER_MAGIC);
> >
> > -        mr =3D memory_region_from_host(buffer, &addr1);
> > -        assert(mr !=3D NULL);
> >          if (is_write) {
> > -            invalidate_and_set_dirty(mr, addr1, access_len);
> > -        }
> > -        if (xen_enabled()) {
> > -            xen_invalidate_map_cache_entry(buffer);
> > +            address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFI=
ED,
> > +                                bounce->buffer, access_len);
> >          }
> > -        memory_region_unref(mr);
> > +
> > +        memory_region_unref(bounce->mr);
> > +        qatomic_sub(&as->bounce_buffer_size, bounce->len);
> > +        /* Write bounce_buffer_size before reading map_client_list. */
> > +        smp_mb();
> > +        address_space_notify_map_clients(as);
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
>
> This line needs to be kept?

Yes, good catch. Thanks!

>
> > -    /* Clear in_use before reading map_client_list.  */
> > -    qatomic_set_mb(&as->bounce.in_use, false);
> > -    address_space_notify_map_clients(as);
> > +        invalidate_and_set_dirty(mr, addr1, access_len);
> > +    }
> >  }
>
> --
> Peter Xu
>

