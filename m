Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7543271217E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 09:51:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SCO-0001sf-EO; Fri, 26 May 2023 03:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q2SCM-0001ro-Al
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q2SCK-0008GX-Iz
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685087355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kfbqS1Kld0fYIdHR4XSa7rFC+bosN/HxPJ6cUXkcl+4=;
 b=cWeLIgx5NVxkfCS4O87SMmK+UXXtYYg137HQziFdkrKHPvjWqUR9JoeiGErdCihvL/ByO9
 hnl83/XigvemjwJY7YyLSPGG/ohA4XqlkvrV6OmADwLKrHPJ8QOlscoOXdSsYqsD3lgpT/
 eF+TIih4kgAkOGzhBoyVGFkErEI1KJI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-nc39jF6qMkWadtoF2bB3yg-1; Fri, 26 May 2023 03:49:14 -0400
X-MC-Unique: nc39jF6qMkWadtoF2bB3yg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2533e0cd8f2so474457a91.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 00:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685087353; x=1687679353;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kfbqS1Kld0fYIdHR4XSa7rFC+bosN/HxPJ6cUXkcl+4=;
 b=QfX+nfy84RHsD8WD6+jFE3M9xQ25NHj2mcLbuvqkgD2ZfVKxvx1kJ6g7P8GbHjgKIr
 Jh1cAMWEIbcMIFhdpBw8gSazkJ8vCvwtz++Vle3kO9hEIynM2Wfb90xFiLrs1EajJ0aH
 O3Q09XK8pP/653V2IqdZPiVVmbbC+hymCMHZBq0ekQTANWcydSqBzLsRc9v1PwdDeq2Q
 Iv14Qj4uRO1NyzeyFg3SiOIGNOsSl/YUzDWYrlTq8ABJCB6AlsEKpvDQF7T+EyLPXdX3
 ut76eqs6QMn0+8ZNUyl7uhK9VufBvuPDg0IRsd+rI6MdMsytjGhqBTq8afGjbwO+pKRg
 BF0Q==
X-Gm-Message-State: AC+VfDyABl3yfGvCmLiGTHtW0Kn7JDCmT27J2jg0TXtPauqtAFryI/v4
 PYcj+eJnuJ5ksB9l7cbjuOfrFtRK0/ttT2lM2bDqWtsykbANpx0zN0zMdzzoEXvPf4HeXJTXWY4
 jY2eTG5JK8fUocV5asqPk98mixQBBHzg=
X-Received: by 2002:a17:90a:7a8d:b0:250:b16:f498 with SMTP id
 q13-20020a17090a7a8d00b002500b16f498mr1245037pjf.47.1685087352955; 
 Fri, 26 May 2023 00:49:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7gFGOgcXAfc6jLGOavv5CglChKRk0fRQXZvZ6vqRKqR+/MjuVyqyRWi4VM/R223oHyfECBB9ZRmG3ozutIsoM=
X-Received: by 2002:a17:90a:7a8d:b0:250:b16:f498 with SMTP id
 q13-20020a17090a7a8d00b002500b16f498mr1245020pjf.47.1685087352629; Fri, 26
 May 2023 00:49:12 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 May 2023 03:49:11 -0400
From: Andrea Bolognani <abologna@redhat.com>
References: <20230525164803.17992-1-sunilvl@ventanamicro.com>
 <CABJz62MFZzx3jBgW6TtGFD9emY+DAbbftSybD8ZouC65n3-auA@mail.gmail.com>
 <20230526-b0d8b56e9688dea7ae9d00d5@orel>
MIME-Version: 1.0
In-Reply-To: <20230526-b0d8b56e9688dea7ae9d00d5@orel>
Date: Fri, 26 May 2023 03:49:11 -0400
Message-ID: <CABJz62Nk-U+qHQjn6G2-bN8i9RcMEZWdYTyi7wqC=7BVjDSBWQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] hw/riscv/virt: pflash improvements
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 26, 2023 at 08:39:07AM +0200, Andrew Jones wrote:
> On Thu, May 25, 2023 at 11:03:52AM -0700, Andrea Bolognani wrote:
> > With these patches applied, libvirt built from the master branch,
> > edk2 built from your branch and a JSON firmware descriptor for it
> > installed (attached), it's finally possible to boot an unmodified
> > openSUSE Tumbleweed RISC-V disk image by simply including
> >
> >   <os firmware='efi'>
>
> Hi Andrea,
>
> I'm a bit concerned that we don't also need to add some XML in order to
> disable ACPI right now. RISC-V guest kernels will support ACPI in the
> near future. Ideally a default libvirt VM using edk2 will also use ACPI.
> Will there be a problem with changing that default later? If so, then
> I'd change it now and continue burdening developers a bit longer by
> requiring them to explicitly disable it.

libvirt doesn't enable ACPI by default on any architecture, not even
x86_64. virt-manager will enable it by default if it's advertised as
available on the architecture in the capabilities XML.

However, it looks like the corresponding code in libvirt is not as
dynamic as I would have assumed: instead, we hardcode the list of
architectures that advertise ACPI support available, and at the
moment that list does *not* include RISC-V :)

I think it would make sense to fix this, but I want to make sure I
understand the impact. Is this just an UEFI thing? All my other
RISC-V guests (Fedora, Ubuntu, FreeBSD) boot just fine when I turn
ACPI on. In fact, even the openSUSE one works with ACPI on, as long
as the UEFI implementation used is the U-Boot one rather than edk2.

So, are edk2 users the only ones who would (temporarily) need to
manually turn ACPI off if virt-manager started enabling it by
default?

-- 
Andrea Bolognani / Red Hat / Virtualization


