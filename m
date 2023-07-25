Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4AA761F8B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 18:52:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOLFM-0000gG-Pu; Tue, 25 Jul 2023 12:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qOLFK-0000f9-Jz
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:50:50 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qOLFI-0001JJ-Bu
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:50:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b9d80e33fbso32907435ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690303846; x=1690908646;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UupfCeLlOPr89U4fvrUq1hDfHjr6/3EmNi9g/vK4Vt4=;
 b=gH9YLatVpoOdgD1crPaqLNzV+tYtmbgMIOHLXnkZFFe68EwzCocbjhskLMgWa67/Pe
 5IPj8gMxfSy6TsMfoaP1PKbwT+QAQxKrSbiz3neEZMqCk+Z2gJJgvWkZ0yOcx9TV55vX
 FeMSpBbI9ogPKl/vb0turq0uXyeAGbOzBBtQ4zVkSMkyK0V/ZocATNs4j7d51PvT+zIn
 9WFJyoSm1wC8uiRx4n5NwKO03t9ff5zuzYQ+lliIVLdmaWE7fHpMULWOOHn0vLy6jYXM
 C2ZJeeT9STFwvlUKia6aOGCdL0Bf03QorjmQYOJJhqNukzp54UcCh5DffX1OqvhqJiA2
 VzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690303846; x=1690908646;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UupfCeLlOPr89U4fvrUq1hDfHjr6/3EmNi9g/vK4Vt4=;
 b=K65ZOQ7Y/DTL94ogYpZ3G6rv0MORWeXFGFw6DYXHiE7NYvgV9PcgtFfVC3DXGfiey9
 vXVho9SucxW5url1q/HBI/oXDF5xa3XKkxaoUHKNKADZENDc9Esu7Jgd5cB7Vrk7WNUB
 +IelB9BpU2x0CWEnGPsCCxUGcuzSy8ENZryo0w1ouwMbCENSztMKl2PRU7HzGyVFuCY/
 33oCvSRxK057gqKnS03HiBwk1b6LSVPLa+QfrZoLS54D0adMsdDfaR5ZuSycQPf+qp9O
 xnI0beg/vHaDFNG1alNWkAoxLWSF6zN1RKaH+KQ/qT1e7vt5GwwMajdB6f0Hi4j7Q2vh
 tcyg==
X-Gm-Message-State: ABy/qLb8c8bXC2qTW1IDBQf2M66SzFFzW56NKvyYMEdPqbU7MLZ+pqWd
 zyzj4LCMZ7JZf0pfSUDz0ulnUw==
X-Google-Smtp-Source: APBJJlEVkETHp4rNjR8WCO6teT6pZXgGpu8gM9FWhaTmi+HUp9qOcHe8dIXhG/viLzLd4+IvqPFVeA==
X-Received: by 2002:a17:903:2342:b0:1b8:b3f9:58eb with SMTP id
 c2-20020a170903234200b001b8b3f958ebmr13680551plh.31.1690303845959; 
 Tue, 25 Jul 2023 09:50:45 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.25]) by smtp.gmail.com with ESMTPSA id
 j4-20020a170902c3c400b001aaecc0b6ffsm11318253plj.160.2023.07.25.09.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 09:50:45 -0700 (PDT)
Date: Tue, 25 Jul 2023 22:20:36 +0530
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
Subject: Re: [PATCH 01/10] hw/arm/virt-acpi-build.c: Move fw_cfg and virtio
 to common location
Message-ID: <ZL/9XO47yEnaNzyN@sunil-laptop>
References: <20230712163943.98994-1-sunilvl@ventanamicro.com>
 <20230712163943.98994-2-sunilvl@ventanamicro.com>
 <20230724171859.212fec62@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724171859.212fec62@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x629.google.com
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

On Mon, Jul 24, 2023 at 05:18:59PM +0200, Igor Mammedov wrote:
> On Wed, 12 Jul 2023 22:09:34 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > The functions which add fw_cfg and virtio to DSDT are same for ARM
> > and RISC-V. So, instead of duplicating in RISC-V, move them from
> > hw/arm/virt-acpi-build.c to common aml-build.c.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  hw/acpi/aml-build.c         | 41 ++++++++++++++++++++++++++++++++++++
> >  hw/arm/virt-acpi-build.c    | 42 -------------------------------------
> >  hw/riscv/virt-acpi-build.c  | 16 --------------
> >  include/hw/acpi/aml-build.h |  6 ++++++
> >  4 files changed, 47 insertions(+), 58 deletions(-)
> > 
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> 
> patch looks fine modulo,
> I'd put these into respective device files instead of generic
> aml-build.c which was intended for basic AML primitives
> (it 's got polluted over time with device specific functions
> but that's not the reason to continue doing that).
> 
> Also having those functions along with devices models
> goes along with self enumerating ACPI devices (currently
> it works for x86 PCI/ISA device but there is no reason
> that it can't work with other types as well when
> I get there)
> 
Thanks!, Igor. Let me add them to device specific files as per your
recommendation.

Thanks!
Sunil

