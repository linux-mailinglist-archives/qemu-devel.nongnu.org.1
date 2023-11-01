Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EADB67DDEAF
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 10:49:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy7pN-0007pm-KB; Wed, 01 Nov 2023 05:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy7pH-0007pL-8t
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:47:51 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy7p9-0006Va-24
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:47:49 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9d2d8343dc4so534057766b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698832060; x=1699436860; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oXLs3Xqwu3EQGMhzh0IBLELUWzR+kAm8cZuXw221QVk=;
 b=CFkj438YDtOd8mcB0ppQs7etEG/9pqbOMPRsqGCBdgxxr/vOXYD4pQxWR63W7n2mSJ
 tc+oDO+IVkHbvzrbO/XZaYKXbld0aj2adxBNqupof52xdi5+QZ1Cp09wCr1mcHVl/ZER
 kp5r+41i+VNUjDIEu6kP3u1YNvrtv2cI2cpaUCaD3+TDRsQFLdu9OMskdm2aAd+qAEUV
 mdd5YrBGW2pyiiCNyKy8kXLcbeYt3aEkVjN+RXIv8+mjLaIeQrHoAqGOA4pnktRknUgb
 EhY2fZlI/ReqcHEGvJ3Zw7Cck8D6FGbasIJpCIWnV7IXJnjVBRp/v2utkgWYLioRH+xs
 dTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698832060; x=1699436860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXLs3Xqwu3EQGMhzh0IBLELUWzR+kAm8cZuXw221QVk=;
 b=B7yydxtnm7vesUTn8jMXjBQvPeAhZyZB74W0UYQEsi3YemAhTo09jhZVpjOev90CSr
 mtG0ojNVvEUlOptH5ECIFU4RYtG6z1IIjTbLHJLy9LdXRBleitVbi3FLwcQ/OSBLBDcu
 4cO4676R3rLeydHAVFQKk/2eTdITxKxO/XHcPF17Nfxw1Tz87f0KUmlsj+R3Hy1IF0HV
 ndf6RMElnh5rbgHwP4x/ksXuPXblDo8W5aS0AU596+DN9l8PYIpYO9ZSzg3xOHSvwYko
 2wLZUwQguPfBS32WvMRANaG4Ned30w8giyMM1kjN6j+HJZv/CSm19CmGmrLCxZXts/oc
 t0/Q==
X-Gm-Message-State: AOJu0YywWwRWZeEexduO7IQOrgJ1jEgKehtSoLkGdbjqzhADsRo4bL21
 9doCuJ8DkPjVWncZBoVFP+6p5w==
X-Google-Smtp-Source: AGHT+IGvSVo6kNsWc+6DovWmER4P1xtEO8j2OJcL9RImazcykKg+9sPxSWRnenyg9yI4mwOPUyGW0g==
X-Received: by 2002:a17:907:1b0c:b0:9cf:18ce:95e6 with SMTP id
 mp12-20020a1709071b0c00b009cf18ce95e6mr1780773ejc.62.1698832059782; 
 Wed, 01 Nov 2023 02:47:39 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a1709065f8c00b0099bd5d28dc4sm2197666eju.195.2023.11.01.02.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 02:47:39 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:47:38 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v7 03/16] target/riscv: add rv64i CPU
Message-ID: <20231101-7790a66535f1b97cd3a6f439@orel>
References: <20231031203916.197332-1-dbarboza@ventanamicro.com>
 <20231031203916.197332-4-dbarboza@ventanamicro.com>
 <20231101-f72b888f87063028f40c6e7a@orel>
 <5162c752-7907-458f-a976-b89f6623f9e7@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5162c752-7907-458f-a976-b89f6623f9e7@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x634.google.com
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

On Wed, Nov 01, 2023 at 06:27:02AM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 11/1/23 06:02, Andrew Jones wrote:
> > On Tue, Oct 31, 2023 at 05:39:03PM -0300, Daniel Henrique Barboza wrote:
> > > We don't have any form of a 'bare bones' CPU. rv64, our default CPUs,
> > > comes with a lot of defaults. This is fine for most regular uses but
> > > it's not suitable when more control of what is actually loaded in the
> > > CPU is required.
> > > 
> > > A bare-bones CPU would be annoying to deal with if not by profile
> > > support, a way to load a multitude of extensions with a single flag. Profile
> > > support is going to be implemented shortly, so let's add a CPU for it.
> > > 
> > > The new 'rv64i' CPU will have only RVI loaded. It is inspired in the
> > > profile specification that dictates, for RVA22U64 [1]:
> > > 
> > > "RVA22U64 Mandatory Base
> > >   RV64I is the mandatory base ISA for RVA22U64"
> > > 
> > > And so it seems that RV64I is the mandatory base ISA for all profiles
> > > listed in [1], making it an ideal CPU to use with profile support.
> > > 
> > > rv64i is a CPU of type TYPE_RISCV_BARE_CPU. It has a mix of features
> > > from pre-existent CPUs:
> > > 
> > > - it allows extensions to be enabled, like generic CPUs;
> > > - it will not inherit extension defaults, like vendor CPUs.
> > > 
> > > This is the minimum extension set to boot OpenSBI and buildroot using
> > > rv64i:
> > > 
> > > ./build/qemu-system-riscv64 -nographic -M virt \
> > >      -cpu rv64i,g=true,c=true,s=true,u=true
> > > 
> > > Our minimal riscv,isa in this case will be:
> > > 
> > >   # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> > > rv64imafdc_zicntr_zicsr_zifencei_zihpm_zca_zcd#
> > > 
> > > [1] https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc
> > > 
> > > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > ---
> > >   target/riscv/cpu-qom.h |  2 ++
> > >   target/riscv/cpu.c     | 25 +++++++++++++++++++++++++
> > >   2 files changed, 27 insertions(+)
> > > 
> > > diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> > > index 7831e86d37..ea9a752280 100644
> > > --- a/target/riscv/cpu-qom.h
> > > +++ b/target/riscv/cpu-qom.h
> > > @@ -25,6 +25,7 @@
> > >   #define TYPE_RISCV_CPU "riscv-cpu"
> > >   #define TYPE_RISCV_DYNAMIC_CPU "riscv-dynamic-cpu"
> > >   #define TYPE_RISCV_VENDOR_CPU "riscv-vendor-cpu"
> > > +#define TYPE_RISCV_BARE_CPU "riscv-bare-cpu"
> > >   #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
> > >   #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
> > > @@ -35,6 +36,7 @@
> > >   #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
> > >   #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
> > >   #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
> > > +#define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
> > >   #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
> > >   #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
> > >   #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index 822970345c..98b2a4061a 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -544,6 +544,18 @@ static void rv128_base_cpu_init(Object *obj)
> > >       set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
> > >   #endif
> > >   }
> > > +
> > > +static void rv64i_bare_cpu_init(Object *obj)
> > > +{
> > > +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> > > +    riscv_cpu_set_misa(env, MXL_RV64, RVI);
> > > +
> > > +    /* Set latest version of privileged specification */
> > > +    env->priv_ver = PRIV_VERSION_LATEST;
> > 
> > The beauty of rv64i is we'll finally know exactly what we're configuring
> > when we select it and some set of extensions. With that in mind I think
> > we should also be explicit about which version of the priv spec is
> > implemented, but we can't just pick a version now, since we may need to
> > update it later. I think we have the following options:
> > 
> >   1. Expose priv version properties (v1_10_0, ...) and either require the
> >      user to select one or default to the latest. (Any versions we don't
> >      want to support for rv64i would error out if selected.)
> 
> This is already the case but it's a string property instead of booleans:
> 
> $ ./build/qemu-system-riscv64 -M virt -cpu rv64i,priv_spec="v1.11.0"
> $ ./build/qemu-system-riscv64 -M virt -cpu rv64i,priv_spec="v1.10.0"
> $ ./build/qemu-system-riscv64 -M virt -cpu rv64i,priv_spec="not_valid"
> qemu-system-riscv64: Unsupported privilege spec version 'not_valid'
> 
> If users set 'priv_spec' we'll use it, otherwise rv64i will default to 'latest'.

I think I'd prefer we don't have a default, but maybe in practice it'll be
OK, since once we have S-mode profiles (which will most likely always be
used with rv64i) then they'll override the default anyway.

> 
> In case we do not want string values (and yeah, it's extra work to parse it, check
> if it's the right val and so on) then we can add priv spec bools that users would
> set on or off. We would need to deprecate "priv_spec" as it is.

Yes, we should switch to booleans for cpu-model-expansion. I suppose we
should keep the priv_ver default until we switch to booleans, though, in
order to avoid encouraging more deprecated priv_spec usage in the
meantime.

> 
> This can be done outside of this work (we would need a RFC first probably).

I can live with that.

Thanks,
drew

