Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B73FB762FCE
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 10:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOZqH-0005zW-IA; Wed, 26 Jul 2023 04:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qOZqC-0005z1-Ni
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qOZqB-0004Ss-8l
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690359950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwVkhMb9iRcIIGT4ohZ6/VrshuYku0zY90Oa9pu3Adk=;
 b=fkAn/ofZw7XSBYgGbta7bL9bQ8H786R8b7YIkoNFa9/mOqtqrEvnQSmfbXZk70HtM/XeZM
 Qd5MaUymNkzHshOITclj9mOE4mWBZATWTUHvWKmRpdoUgpXU1wW627jl0LZ5tn6GiIBM6+
 Gk+wxwfs2nme4Gh+KOkwlZuFmS0Iq/0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-vG9HiWczPfCLVgT908q3aQ-1; Wed, 26 Jul 2023 04:25:49 -0400
X-MC-Unique: vG9HiWczPfCLVgT908q3aQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-993d5006993so513581366b.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 01:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690359948; x=1690964748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwVkhMb9iRcIIGT4ohZ6/VrshuYku0zY90Oa9pu3Adk=;
 b=bQc8MVdPUi4objgcmimHUC3bclMYs3Roo398ARN65PdzPwkkyScZkO6mnQKC7pJ1FR
 Wdkk8a4760Ctq4Fgm+RmZzKL4odHogL8J2BQPT0OW3akhvUWMQ8nuDn0EsQV5CpX9ywP
 1qpv2w6ut6iZ3hMm/HlNuSDaemukWO+KbmufBpqqIH46Nhncactb9QjdYDXf8rzVtWqN
 3BeIvG2oPdHG6qAMD5xjXa0hn84TURr881QV2Lr/kocnm8m1NHXv3sGjd5KYmqp7OmP5
 7E3Q9JS3kOct94sHGRJYimGasKRi0Gg30i8QUzLtGBqeOXq18VugnEsydjeyV3VHSa2t
 86sw==
X-Gm-Message-State: ABy/qLYgIM7qUaJ+TOAr4IzJg7yfHxnZ4VAK6mCE0nFoOn26KyRC+/7q
 J4xisEuyF7xC4ku/iHn88D7smUbbLZF/tjRB06086Sd315ykhsXYR/GYMmwJTO6tHNUcdsr18tf
 DO0IURah4A/bqfaY=
X-Received: by 2002:a17:906:220c:b0:99b:4a6f:9c72 with SMTP id
 s12-20020a170906220c00b0099b4a6f9c72mr1176692ejs.72.1690359948027; 
 Wed, 26 Jul 2023 01:25:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8ikUs9v9iol5ln0FAWMH0hEUqc5ma6ruKgQDHbyA5VQxDplxvwsifTEw9ASgH7b4gbFIsHg==
X-Received: by 2002:a17:906:220c:b0:99b:4a6f:9c72 with SMTP id
 s12-20020a170906220c00b0099b4a6f9c72mr1176672ejs.72.1690359947763; 
 Wed, 26 Jul 2023 01:25:47 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 q15-20020a17090622cf00b0098e42bef732sm631390eja.183.2023.07.26.01.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 01:25:47 -0700 (PDT)
Date: Wed, 26 Jul 2023 10:25:46 +0200
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
Subject: Re: [PATCH 01/10] hw/arm/virt-acpi-build.c: Move fw_cfg and virtio
 to common location
Message-ID: <20230726102546.1cad6113@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZL/9XO47yEnaNzyN@sunil-laptop>
References: <20230712163943.98994-1-sunilvl@ventanamicro.com>
 <20230712163943.98994-2-sunilvl@ventanamicro.com>
 <20230724171859.212fec62@imammedo.users.ipa.redhat.com>
 <ZL/9XO47yEnaNzyN@sunil-laptop>
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

On Tue, 25 Jul 2023 22:20:36 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> On Mon, Jul 24, 2023 at 05:18:59PM +0200, Igor Mammedov wrote:
> > On Wed, 12 Jul 2023 22:09:34 +0530
> > Sunil V L <sunilvl@ventanamicro.com> wrote:
> >   
> > > The functions which add fw_cfg and virtio to DSDT are same for ARM
> > > and RISC-V. So, instead of duplicating in RISC-V, move them from
> > > hw/arm/virt-acpi-build.c to common aml-build.c.
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > ---
> > >  hw/acpi/aml-build.c         | 41 ++++++++++++++++++++++++++++++++++++
> > >  hw/arm/virt-acpi-build.c    | 42 -------------------------------------
> > >  hw/riscv/virt-acpi-build.c  | 16 --------------
> > >  include/hw/acpi/aml-build.h |  6 ++++++
> > >  4 files changed, 47 insertions(+), 58 deletions(-)
> > > 
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c  
> > 
> > patch looks fine modulo,
> > I'd put these into respective device files instead of generic
> > aml-build.c which was intended for basic AML primitives
> > (it 's got polluted over time with device specific functions
> > but that's not the reason to continue doing that).
> > 
> > Also having those functions along with devices models
> > goes along with self enumerating ACPI devices (currently
> > it works for x86 PCI/ISA device but there is no reason
> > that it can't work with other types as well when
> > I get there)
> >   
> Thanks!, Igor. Let me add them to device specific files as per your
> recommendation.
just be careful and build test other targets (while disabling the rest)
at least no to regress them due to build deps. (I'd pick 2 with ACPI
support that use and not uses affected code) and 1 that  uses device
model but doesn't use ACPI at all (if such exists)

> 
> Thanks!
> Sunil
> 


