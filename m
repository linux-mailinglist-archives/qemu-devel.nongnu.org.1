Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FD2712325
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:12:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TSt-0007YL-Ir; Fri, 26 May 2023 05:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q2TSr-0007DI-3A
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:10:25 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q2TSh-000170-Ra
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:10:23 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30ad99fa586so240775f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 02:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685092214; x=1687684214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=59RV8EsFTk7oDgqbS+7335Qu3qcQGpdXbMK8xv0Nw0I=;
 b=czJMbiVesdtMD/jZt2i4lzOw/HcndRyOo1tN/zqoi9vdHOuYbDyxvefI71lw2Sqs12
 RdxORku/WpuhQwbcQzw45VfvFioqSaVQyzvuTDI+H6zFSg7tWPAibTlQM4ABj0S4YF8H
 igaUwfqsXvjopOuEOy8bQjwAS8H2Tiy6Ngn276+MW7EL4QvxWbf5beivHWxXQWF0H+2A
 yDHMYNFixGpIqb/Bi0F0RKZvWVwTqg47fbxirzEytKRQDQ8aAleVsMgKcgIKU44AcCBq
 cK2lskILWG4BHYG0k+6zmgileNv9NKYw2wOe3nR77aty6frOZ119vKnTKS4Ly0t+VMvt
 YKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685092214; x=1687684214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59RV8EsFTk7oDgqbS+7335Qu3qcQGpdXbMK8xv0Nw0I=;
 b=MYA0NxefHnPI8y9+HVnfuz6bqkPbrH7k61eynyXcZ15wzYShDABoTSbuQiNB3FJPN/
 B2eUSIfLXS2gOS6bfKkplIRL3vLD0j9zAgv8/dGWnrEWmYS+/XKlkdSLYqt2xMd61Ule
 PuiD155ZNDR4g2cMmcDNaWyzjT7CsjKwxso8QfEGV7Ftpl8Cb0+QINei6hfZQj0gUCJo
 2km0ToACXsI/VYjzyDmcW0SBf3GVZDlLUVmwPx39fjIVIhzauu3X+5IWZEcK4tB+aJQm
 P1+tZe1/7/BoRS0+jRZ/XAM7+4XETPjeN1aEDYVJQb2/NX6/PeOlfQ6zMxEaPkq38LpK
 HkRg==
X-Gm-Message-State: AC+VfDxGls1PG1kN6cfhFtikwNphGCv5jYzTuQvXpEvy9etr7QscaiXC
 Xkh91LpUd7Snt4zTyHEYeUipJA==
X-Google-Smtp-Source: ACHHUZ6WWTLxVwZnayRB3BeCCk1viKRPujMtoYJL2m+9rhqG9OJ3cvUYI/6EvHLR+RXvGnZAdmDSpQ==
X-Received: by 2002:a5d:6a90:0:b0:309:51c5:3bf6 with SMTP id
 s16-20020a5d6a90000000b0030951c53bf6mr893489wru.23.1685092214234; 
 Fri, 26 May 2023 02:10:14 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a7bc3c7000000b003f6132f95e6sm8119349wmj.35.2023.05.26.02.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 02:10:13 -0700 (PDT)
Date: Fri, 26 May 2023 11:10:12 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 0/3] hw/riscv/virt: pflash improvements
Message-ID: <20230526-cbbe3fe3734dc64264a2ad83@orel>
References: <20230525164803.17992-1-sunilvl@ventanamicro.com>
 <CABJz62MFZzx3jBgW6TtGFD9emY+DAbbftSybD8ZouC65n3-auA@mail.gmail.com>
 <20230526-b0d8b56e9688dea7ae9d00d5@orel>
 <CABJz62Nk-U+qHQjn6G2-bN8i9RcMEZWdYTyi7wqC=7BVjDSBWQ@mail.gmail.com>
 <20230526-e398cfda73f326653323ea68@orel>
 <CABJz62PXvVNEwpqUz0dUUYTAGjmNU4h0NtFf664oubaJmKxwKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABJz62PXvVNEwpqUz0dUUYTAGjmNU4h0NtFf664oubaJmKxwKw@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, May 26, 2023 at 04:42:57AM -0400, Andrea Bolognani wrote:
> On Fri, May 26, 2023 at 10:34:36AM +0200, Andrew Jones wrote:
> > On Fri, May 26, 2023 at 03:49:11AM -0400, Andrea Bolognani wrote:
> > > So, are edk2 users the only ones who would (temporarily) need to
> > > manually turn ACPI off if virt-manager started enabling it by
> > > default?
> >
> > I assume so, but I'm not tracking firmware status. If the firmware
> > doesn't extract the ACPI tables from QEMU and present them to the
> > guest (afaik only edk2 does that), then the guest kernel falls back
> > to DT, which is why it's working for you.
> >
> > I suppose we should wait until Linux merges the ACPI patches, before
> > adding RISC-V to the libvirt capabilities ACPI list.
> 
> That sounds reasonable to me, but note that 1) the libvirt change
> might take a while to propagate to distros and 2) someone will have
> to remind me to prepare such a patch when the time comes ;)

Initial ACPI support will probably be merged for 6.4. So maybe it is
time to get the libvirt side of things going.

> 
> > Then, is it
> > possible to use something like libosinfo to inform virt-manager
> > when it should enable ACPI and when not? Later distro images, with
> > later kernels, will want to use ACPI by default, but older images
> > will still need to use DT.
> 
> Something like that would definitely be possible, but I don't think
> the scaffolding for it exists at the moment, so someone would have to
> wire it up across the stack. Given how relatively immature the RISC-V
> distro ecosystem is at the moment, I think it's fine to do nothing
> and wait for the problem to go away on its own :)

WFM

Thanks,
drew

