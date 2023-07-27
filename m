Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B483D765453
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 14:50:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOzkA-0004NL-BT; Thu, 27 Jul 2023 08:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qOzjk-0004Ka-HY
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 08:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qOzjg-0002QS-7p
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 08:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690459491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppN+bgpvwcevxBHrqVvwwOOCna8g1cmyqgFyZkevYtg=;
 b=AKiytIzw6ha2D6WLYXjPrQ66IS1kuIn2ORKmUavJEhfNvUdkoaYST2migw+U8GrxdYym+3
 PfD0KvqfOflcQwLdbroIlynRMSDtQMF62dOFOsXRNjI2X87uOA1q2fE9q1Lf60bSLdab03
 /8iLbI3bUHj0ADjAisTk4Q/jnhi74Ag=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-gDKJrPXLO5iS4r2ZDUaJdQ-1; Thu, 27 Jul 2023 08:04:49 -0400
X-MC-Unique: gDKJrPXLO5iS4r2ZDUaJdQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99bb70a4b28so49467866b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 05:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690459488; x=1691064288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppN+bgpvwcevxBHrqVvwwOOCna8g1cmyqgFyZkevYtg=;
 b=cfceyS/o+hOrQUJqeDVmaG9pt4SnJq+9Ws00tIDKARWIOro/7bEgGzr/OuzgOuD5xP
 CBnY8+z139LTXPGzCW3nyC4lFtAPOvEpNUYKcnhu7zhUa3XOwzJdEEe2FScbdQ00BWVc
 dqx6T5wQuoeLVE3JaBGwcraabCXjqKMPyZCUMpK19698CmYw2KoqaCc97Ppsudyce40w
 kzWCOBsOYQva3XZBlejkgfmevS50+Y2ffgR6JMZ5UgjaCJqPgQ2ug3Y3uXGzY/sg7o+a
 De3UodStteDQCfpeIGT7YJteWbEsjKVEChKB9cPU+laQ/VHicpn67UAExPsytiV7a7A2
 1Mdw==
X-Gm-Message-State: ABy/qLYHxXckxNNmUkOqviIDKxxcKthDBo+NXTA6+NELsii7UzSizuYP
 vbD/elSO/zV73Rz3HniOvyWRaAccNtsgFho99HWAeMGq6nOyfuCh+z2urz5IbQKipCzqvsKmRT/
 32+p8CRYwQTo2GzU=
X-Received: by 2002:a17:907:75e3:b0:99b:d784:f8f8 with SMTP id
 jz3-20020a17090775e300b0099bd784f8f8mr1465531ejc.69.1690459488077; 
 Thu, 27 Jul 2023 05:04:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGt4j8Ep8PWa+4Fw7QFAwwJbHUP9rNPEKOJTpATmyRRV+yPGjZ8gO0Bq0U3FlaCX0GBpoJEYg==
X-Received: by 2002:a17:907:75e3:b0:99b:d784:f8f8 with SMTP id
 jz3-20020a17090775e300b0099bd784f8f8mr1465510ejc.69.1690459487745; 
 Thu, 27 Jul 2023 05:04:47 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 t10-20020a17090616ca00b0098d486d2bdfsm704106ejd.177.2023.07.27.05.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 05:04:47 -0700 (PDT)
Date: Thu, 27 Jul 2023 14:04:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH 04/10] hw/riscv: virt: Add PCIe HIGHMEM in memmap
Message-ID: <20230727140446.14f4c9f0@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZMJOB7qZGqzbvACZ@sunil-laptop>
References: <20230712163943.98994-1-sunilvl@ventanamicro.com>
 <20230712163943.98994-5-sunilvl@ventanamicro.com>
 <20230724173254.3423a204@imammedo.users.ipa.redhat.com>
 <ZMJOB7qZGqzbvACZ@sunil-laptop>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 27 Jul 2023 16:29:19 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> On Mon, Jul 24, 2023 at 05:32:54PM +0200, Igor Mammedov wrote:
> > On Wed, 12 Jul 2023 22:09:37 +0530
> > Sunil V L <sunilvl@ventanamicro.com> wrote:
> >   
> > > PCIe High MMIO base is actually dynamic and fixed at
> > > run time based on the RAM configured. Currently, this is
> > > not part of the memmap and kept in separate static variable
> > > in virt.c. However, ACPI code also needs this information
> > > to populate DSDT. So, once the base is discovered, merge
> > > this into the final memmap which can be used to create
> > > ACPI tables later.  
> > 
> > can ACPI code fetch virt_high_pcie_memmap at runtime from
> > host bridge (like we do in pc/q35)?
> >   
> Hi Igor,
> 
> Looking at the current design of virt machines (arm/loongarch/riscv),
> getting this directly from the memmap looks simpler. ARM ACPI also uses
> the memmap to get the pcie_high space. It appears to me we need some
> more infrastructure code if ACPI needs to fetch from host bridge. I am
> not sure why that would be beneficial.

Sure it's possible to directly hardcode access, but it becomes machine
specific and hard to generalize/reuse (defaults might belong to machine,
but ACPI shall pickup these from actual owner - hostbridge).

And no extra infrastructure is need, x86 manages to do that by
using properties on host bridge (one can pre-program values on host bridge
during it's creation, firmware can also change them later when initializing PCI).
Then DSDT generator picks up uptodate values from hostbridge
(which is actual owner of these values) via properties.
(basically copy pc/q35 approach). 

> 
> Thanks,
> Sunil
> 


