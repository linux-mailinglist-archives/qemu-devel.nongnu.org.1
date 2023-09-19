Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2797A6866
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 17:56:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qid47-0000Q9-NK; Tue, 19 Sep 2023 11:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qid42-0000Po-Hh
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:55:02 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qid40-0007h8-Iw
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:55:02 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5731fe1d2bfso3084927eaf.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695138897; x=1695743697;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neNhIJRIq7NDpCcB1VHri0O6K+ddFKUJNmDvwkLac4I=;
 b=Pt/ohk8okvYeddsyEbGQ1obKhiFDYeJ6udOY2dIL4mwjVnQmzmuHQ48chEuE45Of15
 AvuL/VnUectFD+J3WElH4KXLeF/+XRZxDOmGncw+sd4c0IzFAUHly/CQZp49a0VmB8eu
 /iNd/5SoaFZpVGgcUr5i2ROTCQYPnCohBvwjUZGskIoo6SkAITDcDoIDfQhRlJcGCZnZ
 4EO3QmORJyCwerChq837cdODBHhwAoDF2jzdH/TUZPn1kTlm7fTjc2XpnB8wpBGLqxGQ
 TSc/ITBh989qZo+gF8s0UItLU11OXBuXQjO1wis3FHokwqcqvp/OUlju769WGrIffjrr
 v3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695138897; x=1695743697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=neNhIJRIq7NDpCcB1VHri0O6K+ddFKUJNmDvwkLac4I=;
 b=X78S+bKGEy+8LzuDYJvlfVL2Rq+kCt83LgQuRtMd+TTrbpGXxeac4hEtxtJmfVKk69
 Qpf9bP8R8wCiZ0lA5A+TQpdeU55mSXOxQhV4pvmIwFjNL66b+bJyxtep5WmJGqmxQKDH
 skCsw17A6/vs1ydBvmcsmZxLMnh/NwclFUkAcHvV4qYoXanBxXF9R+oIZ+rGXZgICLGt
 znkLNaRX8Li8pKD/2qSxnEwzdjAA7r8s9ZViPCkSNrJNoTi30L89+CbDs7xd1iTpwOVM
 BafxIaxrkLTjmJ4n6650ASOY8O8ZJCz/u61ca9IFwfg9ds2eQKUqi+d5tL5YUB0Lbs5R
 RXug==
X-Gm-Message-State: AOJu0YwqpU/F36a5oGFJMvZBn/5Mu/ULMgvnhThZ8EYe69B0rUM5y7J+
 UX0r4LqiNTzqtzHoOATgVXzO6mlmVT50kdZ/zWLnYA==
X-Google-Smtp-Source: AGHT+IFHUoAdtDiMM+3zhjlZsvJYB+9IBKYkLpUlH9/LhxjDOwv6AEuMkiRszcePgDdapkd4InU2+FNXXdgQqruiXT4=
X-Received: by 2002:a05:6820:1c44:b0:57b:2703:3060 with SMTP id
 cm4-20020a0568201c4400b0057b27033060mr877267oob.1.1695138897355; Tue, 19 Sep
 2023 08:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-2-mnissler@rivosinc.com> <ZQH/1pRzHhaXbl+E@x1n>
 <CAGNS4TYLqUogVTAxR1eBzbukp5YLDHzVJDqEwvp0sxg9dFWogw@mail.gmail.com>
In-Reply-To: <CAGNS4TYLqUogVTAxR1eBzbukp5YLDHzVJDqEwvp0sxg9dFWogw@mail.gmail.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Tue, 19 Sep 2023 17:54:46 +0200
Message-ID: <CAGNS4Tb457NXTXRAzne2FdXH-xatMoDVSFYD8CEoxCDZpvFNNQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] softmmu: Per-AddressSpace bounce buffering
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc2a.google.com
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

On Fri, Sep 15, 2023 at 10:37=E2=80=AFAM Mattias Nissler <mnissler@rivosinc=
.com> wrote:
>
> On Wed, Sep 13, 2023 at 8:30=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Thu, Sep 07, 2023 at 06:04:06AM -0700, Mattias Nissler wrote:
> > > @@ -3105,6 +3105,9 @@ void address_space_init(AddressSpace *as, Memor=
yRegion *root, const char *name)
> > >      as->ioeventfds =3D NULL;
> > >      QTAILQ_INIT(&as->listeners);
> > >      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
> > > +    as->bounce.in_use =3D false;
> > > +    qemu_mutex_init(&as->map_client_list_lock);
> > > +    QLIST_INIT(&as->map_client_list);
> > >      as->name =3D g_strdup(name ? name : "anonymous");
> > >      address_space_update_topology(as);
> > >      address_space_update_ioeventfds(as);
> >
> > Missing the counterpart in do_address_space_destroy()?
>
> Of course, thanks for pointing this out.
>
> >
> > Perhaps we should assert on having no one using the buffer, or on the
> > client list too.
>
> I agree it makes sense to put these assertions, but let me dig a bit
> and do some experiments to see whether these hold true in practice.

To close the loop here: I've experimented a bit to try whether I can
get the shutdown path to trigger the assertions by terminating the
qemu process with mappings present. I tried xhci (for usb_packet_map),
e1000e (for net_tx_pkt_add_raw_fragment_pci), and nvme (for
dma-helpers), and some of them with hacked Linux kernels in attempts
to create problematic situations. I found that cleanup of mappings
seems to work correctly already, I wasn't able to trigger the
assertions I added in do_address_space_destroy. That doesn't prove
absence of a code path that would trigger them, but then that would
just indicate a bug in device model cleanup code that should be fixed
anyways.

>
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >

