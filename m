Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8578C7110CF
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 18:20:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2DgU-0007ev-BX; Thu, 25 May 2023 12:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q2DgO-0007dE-Ut
 for qemu-devel@nongnu.org; Thu, 25 May 2023 12:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q2DgL-0006kU-RE
 for qemu-devel@nongnu.org; Thu, 25 May 2023 12:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685031556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JNYP9SOltQneIi9s/jsPF2x3y5hZPkfpFVxAZ9GC424=;
 b=KHQwBBRZxTmcQ9MM8EtRDWzx5Hvg0VJRjVxbNUe0uB3a0XrVDYd/p5kDcKE+2tQbsSWRQ7
 V3kENykrD0SbHdGnh1SgLyfZXJ/D/0hbaJv/gm1XnyHJouK55FDXx2cCQGeP7uhYZcNGVj
 bKk0dnp7Thyb9/X2ZmpWDsCuNTwhEBI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-PQ-ecl_IPte3FHqYb0OmlA-1; Thu, 25 May 2023 12:19:15 -0400
X-MC-Unique: PQ-ecl_IPte3FHqYb0OmlA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1ae4c498f0cso16299875ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 09:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685031554; x=1687623554;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JNYP9SOltQneIi9s/jsPF2x3y5hZPkfpFVxAZ9GC424=;
 b=i+p0LFZJXscOX8tIbWtN8H32C6LNagRcAZ09vxc0/bTcuGahOJG5z8Uwfwc+IDnGAI
 y3YCOVQKiev6qXRuMMvDR7Ga6AYeLOoqwjeJnjvX/umb1kMqEBU8uHWTE/dJ6kGZNRUV
 hMOJDPKgNeepCwPQfIaqXhbpKe48vGWL4r4ZyAsVGfgrUFuUjk2OM5ex5np2TDIba7j3
 qypCRJKNShqNCf/x93t9slMYTlToPICAjXU0cryF9rSRvx7PcraysnKElaTUpQNYc9Ej
 o1EopTvpm3HXfJN7mwJ9PHzGNRLoG9MYyugbx7bPgmLY2wi3YT6pPthZEAWl558+s93s
 4MWg==
X-Gm-Message-State: AC+VfDwSrIk+S+gQlyvw/DE7b07+5VSG/ApoMt1NVF8k8g5x11xm85HU
 nDIU1+oHNxlv0HCH5I33H5q4HBr2TqLcje2al/bBaYMydRuwnixxtN5vp2KltnhQASo5kHt/U++
 yXsHCFNT/qvaYO9EZBIa2rthM8atAyWk=
X-Received: by 2002:a17:902:db07:b0:1ab:797:afbe with SMTP id
 m7-20020a170902db0700b001ab0797afbemr2941945plx.8.1685031554169; 
 Thu, 25 May 2023 09:19:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53fIciQR1uP3iCNNZLBoAVcJZ6PcmNKONco4QqSkkcVJv2QLO5fcW7bYzAid2xkHcwTjiDI2cUbhhHQ5d5G/o=
X-Received: by 2002:a17:902:db07:b0:1ab:797:afbe with SMTP id
 m7-20020a170902db0700b001ab0797afbemr2941918plx.8.1685031553850; Thu, 25 May
 2023 09:19:13 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 May 2023 16:19:12 +0000
From: Andrea Bolognani <abologna@redhat.com>
References: <20230523102805.100160-1-sunilvl@ventanamicro.com>
 <CABJz62MQ5uRHUP4LLKt=AxTf-Sz0aTEOLWDz=9ftK=H3tZ9JUg@mail.gmail.com>
 <ZG5KgLQ4H/leWKJi@sunil-laptop>
 <CABJz62NHXrBKkc3Gux0TXOjUCO4up-OunwJ6UO94ts+rTgVsAg@mail.gmail.com>
 <ZG94lvAYggnRBfLQ@sunil-laptop>
MIME-Version: 1.0
In-Reply-To: <ZG94lvAYggnRBfLQ@sunil-laptop>
Date: Thu, 25 May 2023 16:19:12 +0000
Message-ID: <CABJz62NUpY35u2ykPXVHp8a_RUyjCnC1_DpWsYNuSBftHe4qBQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/riscv: virt: Assume M-mode FW in pflash0 only when
 "-bios none"
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, May 25, 2023 at 08:32:46PM +0530, Sunil V L wrote:
> On Thu, May 25, 2023 at 01:43:28PM +0000, Andrea Bolognani wrote:
> > I have also tried booting an openSUSE Tumbleweed "JeOS" image, since
> > that's the only distro I'm aware of that uses UEFI boot on RISC-V at
> > this point - though they use U-Boot's UEFI support rather than edk2.
> >
> > During that attempt, I ended up in the edk2 shell. Running
> >
> >   fs0:\efi\boot\bootriscv64.efi
> >
> > brings up GRUB just fine, but selecting the default boot entry
> > results in
> >
> >   Loading Linux 6.3.2-1-default ...
> >   Loading initial ramdisk ...
> >   EFI stub: Booting Linux Kernel...
> >   EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> >   EFI stub: Generating empty DTB
> >   EFI stub: Exiting boot services...
> >
> > being printed, after which it's back to OpenSBI and from there to
> > edk2 again.
>
> Thanks!. Please add -machine acpi=off in qemu command to boot the
> kernel.

Yup, that worked! It booted all the way to the login prompt :)

Note that libvirt automatically adds acpi=off, so that won't be a
concern for libvirt users.

> > > > Going further and testing libvirt integration. After hacking around
> > > > other issues, I finally stumbled upon this error:
> > > >
> > > >   qemu-system-riscv64: Property 'virt-machine.pflash0' not found
> > >
> > > Thanks!. This needs some investigation. Let me look into supporting
> > > this.
> >
> > Yes please! It's critical to libvirt integration. Feel free to CC me
> > when you post patches and I'll gladly test them.
>
> Sure, I have the fix ready. I need to convert this into a patch series
> now. Will send it soon and thanks in advance for helping with testing.

Excellent! Looking forward to it :)

-- 
Andrea Bolognani / Red Hat / Virtualization


