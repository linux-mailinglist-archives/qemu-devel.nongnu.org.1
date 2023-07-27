Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EF4765464
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 14:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0Ab-0002GG-FB; Thu, 27 Jul 2023 08:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qP0AE-0002C3-R9
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 08:32:20 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qP0AD-0002fx-7n
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 08:32:18 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2680a031283so539180a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690461135; x=1691065935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zIdwfgWq+zPXtz7uG9D1x7QB8jEPgnzU4g7wLDf2u98=;
 b=VwLsaDN2IUL2b7OcZScHL6JXD25OM8ZeMAoY66mrIWit5kyg9JBQgwtaNGP+61vR+C
 dnUxJvcvVh1SNWBcs8GOj/AKpgcx6GngUsvQ5OEWPDR1/G6LeFZz8DG/Dsp3Qq3bJnND
 djHvZhisr8OQ47cBg0KnDaaEkUsKSDuk82wQKULQW549e2Dv0hGKUCIO2Tcp7KgHBC7A
 9vgv935iIaGGKM0VaJ3qg2IhcFPrscDaz0lYBjoXbZ2TEMklH/cb/kD9dYezuHjU3Vtf
 F0JgGg03XMM4HAZ76zMODFR9iSbKF07jE/071KdwInx0kBWUHjxHf2kBqp1n6z6ZJB6h
 oxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690461135; x=1691065935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIdwfgWq+zPXtz7uG9D1x7QB8jEPgnzU4g7wLDf2u98=;
 b=M4FFwftP6XP3rd/PlZJyrWWnOEnOCuZlEu489TmW0JanCa///HOaxeRIt+LslQ9utg
 GB6s1QmevtB3qCBATqkOIECs/BY+Ay/UrfSBIP6ZrQELWTr+UXLfLn3quviAc1CfgDZH
 9mtSmn9Cd+KBGTfghS9hfxRMzPFnxs+oJLx+ApRmOC/Y9W2s5tUPjaLHUTwTAYIrig3q
 dcqJjMSqVyTCNO1QM6humDWXAYKJKT2ZnzLVMuOZ43Y8056qbEjyG68jTjHKxKpiDcX0
 jqEumaFqAwchHGvykcQaFkBIfFwLFPDS4ik9TXy14SX4YEZusDLAES7+nT0DiGSj4Tgw
 NQfA==
X-Gm-Message-State: ABy/qLZII6f3UUdP0D/QBLzjVdfWFi/lVLujMf7pmfDuscUTurlQ5zgu
 f8CXyZ1SfP4mGfIMCayi4563yg==
X-Google-Smtp-Source: APBJJlFdtqsl/rcqw3r3/yGIQ0tmqXAsoKHUTrOpzUDDcd+Efb5zi+rPGdctmXFXNNsUANUmnNTPlA==
X-Received: by 2002:a17:90a:e2ca:b0:268:2f2:cc88 with SMTP id
 fr10-20020a17090ae2ca00b0026802f2cc88mr4012232pjb.12.1690461135363; 
 Thu, 27 Jul 2023 05:32:15 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.25]) by smtp.gmail.com with ESMTPSA id
 26-20020a17090a035a00b0025bd4db25f0sm1169440pjf.53.2023.07.27.05.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 05:32:14 -0700 (PDT)
Date: Thu, 27 Jul 2023 18:02:05 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH 04/10] hw/riscv: virt: Add PCIe HIGHMEM in memmap
Message-ID: <ZMJjxfYMgdVZpRPp@sunil-laptop>
References: <20230712163943.98994-1-sunilvl@ventanamicro.com>
 <20230712163943.98994-5-sunilvl@ventanamicro.com>
 <20230724173254.3423a204@imammedo.users.ipa.redhat.com>
 <ZMJOB7qZGqzbvACZ@sunil-laptop>
 <20230727140446.14f4c9f0@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727140446.14f4c9f0@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Jul 27, 2023 at 02:04:46PM +0200, Igor Mammedov wrote:
> On Thu, 27 Jul 2023 16:29:19 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > On Mon, Jul 24, 2023 at 05:32:54PM +0200, Igor Mammedov wrote:
> > > On Wed, 12 Jul 2023 22:09:37 +0530
> > > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > >   
> > > > PCIe High MMIO base is actually dynamic and fixed at
> > > > run time based on the RAM configured. Currently, this is
> > > > not part of the memmap and kept in separate static variable
> > > > in virt.c. However, ACPI code also needs this information
> > > > to populate DSDT. So, once the base is discovered, merge
> > > > this into the final memmap which can be used to create
> > > > ACPI tables later.  
> > > 
> > > can ACPI code fetch virt_high_pcie_memmap at runtime from
> > > host bridge (like we do in pc/q35)?
> > >   
> > Hi Igor,
> > 
> > Looking at the current design of virt machines (arm/loongarch/riscv),
> > getting this directly from the memmap looks simpler. ARM ACPI also uses
> > the memmap to get the pcie_high space. It appears to me we need some
> > more infrastructure code if ACPI needs to fetch from host bridge. I am
> > not sure why that would be beneficial.
> 
> Sure it's possible to directly hardcode access, but it becomes machine
> specific and hard to generalize/reuse (defaults might belong to machine,
> but ACPI shall pickup these from actual owner - hostbridge).
> 
> And no extra infrastructure is need, x86 manages to do that by
> using properties on host bridge (one can pre-program values on host bridge
> during it's creation, firmware can also change them later when initializing PCI).
> Then DSDT generator picks up uptodate values from hostbridge
> (which is actual owner of these values) via properties.
> (basically copy pc/q35 approach). 
> 
Ahh OK. Thanks!. Let me update.

Thanks,
Sunil

