Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE1778EF80
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 16:21:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbiXc-0005yL-Tx; Thu, 31 Aug 2023 10:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbiXb-0005xp-KL
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:20:59 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbiXX-0003im-Pm
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:20:59 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99c1d03e124so94310166b.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693491654; x=1694096454; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lUalRt3I1SH5kjcoaEknbJr1EIX5m4PZ35rZljle5nQ=;
 b=PBBuPSKpmffz/CxoIKCDEAnh4FLJlm6kfgZi5+twZSCUaNMk9gWocR5++imkN/5Liv
 jDNsEah9QvnYzbt8zpKqCSPZZ0OAZsm0JJt8SeMkLhuJhth4U8xBQRxpmivdgFY25aNR
 AuwL9SLBWSE+Yx/gt/Rr/qxS7wLR0DQZHumh3GrQr1Fqif7R7A3J1plBoPj1OKgKbWmX
 SczIdGyViS7qz0Q968b7/etVXT67A+Mo/5E5j0wrfJDd7bNA9XNTDLLevBJ753vLcicT
 MP7dmvXARZXlYskioWFEpLtNLUf466J1LJ/bXcElg+makUCrFuEMgxoQzMtZmqh2xc0t
 5n+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693491654; x=1694096454;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lUalRt3I1SH5kjcoaEknbJr1EIX5m4PZ35rZljle5nQ=;
 b=OSmb/PMBOhxLC2WtOwCOGq+tUmOKdRE6kCOqHaO86MqY8ZOmGDi9SrAgZeuH31h4cs
 FySEOwJJGtn3XP4YlJuIdPYEjY3QlKxKBHw2xJxkscQsrCSQWSdjLKF04P9kZbuvXcoR
 h6+s1GTMuMC8wYnqfXO6VTs06dCwcMT+w7rb8L/+R5eBDghJpgywwVBR+nfQEYtDtDVI
 E0tPwQfHR9KUHCA6MID3k9r0R3zxc5YtZ7Zi143X1/YcwhqpmIs6Sgo4e8jvT7RDXJoZ
 jx7ngb6ese6sBUr3gmlzrwGHfZd7yjxniQg076S478twJWy0ieX7wiMUWubyJE6dsOKn
 Ay9g==
X-Gm-Message-State: AOJu0YxRzINa9o54kbQV24bYLKF9eNKsPI8OV7cXnU4Kkp+cnbD5XzjS
 MfPXXnBrmOMLaGX9C0fniK2TPQ==
X-Google-Smtp-Source: AGHT+IGCyCKjjq14vkakCxbXgx02kwLFeNoQJzUo4CZRXZSIigP6gh9kQYW2U37Y4RqX5O5CjmLZsg==
X-Received: by 2002:a17:906:5dc1:b0:9a2:86a:f9b7 with SMTP id
 p1-20020a1709065dc100b009a2086af9b7mr3868930ejv.59.1693491653944; 
 Thu, 31 Aug 2023 07:20:53 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a170906715000b00993cc1242d4sm803993ejj.151.2023.08.31.07.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 07:20:53 -0700 (PDT)
Date: Thu, 31 Aug 2023 16:20:52 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 1/2] hw/riscv/virt.c: fix non-KVM --enable-debug build
Message-ID: <20230831-4c17ab943dde8c265d615aaa@orel>
References: <20230830133503.711138-1-dbarboza@ventanamicro.com>
 <20230830133503.711138-2-dbarboza@ventanamicro.com>
 <20230831-d3b40182209cb9054ceaed62@orel>
 <292f8ac7-402f-0da1-2f4e-40d5391c861a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <292f8ac7-402f-0da1-2f4e-40d5391c861a@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Aug 31, 2023 at 02:47:54PM +0200, Philippe Mathieu-Daud� wrote:
> On 31/8/23 10:42, Andrew Jones wrote:
> > On Wed, Aug 30, 2023 at 10:35:02AM -0300, Daniel Henrique Barboza wrote:
> > > A build with --enable-debug and without KVM will fail as follows:
> > > 
> > > /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_riscv_virt.c.o: in function `virt_machine_init':
> > > ./qemu/build/../hw/riscv/virt.c:1465: undefined reference to `kvm_riscv_aia_create'
> > > 
> > > This happens because the code block with "if virt_use_kvm_aia(s)" isn't
> > > being ignored by the debug build, resulting in an undefined reference to
> > > a KVM only function.
> > > 
> > > Add a 'kvm_enabled()' conditional together with virt_use_kvm_aia() will
> > > make the compiler crop the kvm_riscv_aia_create() call entirely from a
> > > non-KVM build. Note that adding the 'kvm_enabled()' conditional inside
> > > virt_use_kvm_aia() won't fix the build because this function would need
> > > to be inlined multiple times to make the compiler zero out the entire
> > > block.
> > > 
> > > While we're at it, use kvm_enabled() in all instances where
> > > virt_use_kvm_aia() is checked to allow the compiler to elide these other
> > > kvm-only instances as well.
> > > 
> > > Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> > > Fixes: dbdb99948e ("target/riscv: select KVM AIA in riscv virt machine")
> > > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > ---
> > >   hw/riscv/virt.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> 
> > I think I'd prefer
> > 
> >   /* We need this inlined for debug (-O0) builds */
> >   static inline QEMU_ALWAYS_INLINE bool virt_use_kvm_aia(RISCVVirtState *s)
> >   {
> >      return kvm_enabled() && kvm_irqchip_in_kernel() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
> 
> Generally we should know whether KVM is enabled or not _before_
> calling any foo_kvm() code, not after.

That's reasonable and makes me want to suggest squashing the diff below
into the second patch.


diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 592c3ce76828..f712699a4040 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -816,7 +816,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
     uint32_t i;
     RISCVAPLICState *aplic = RISCV_APLIC(dev);
 
-    if (!is_kvm_aia(aplic->msimode)) {
+    if (!kvm_enabled() || !is_kvm_aia(aplic->msimode)) {
         aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
         aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
         aplic->state = g_new0(uint32_t, aplic->num_irqs);
@@ -980,7 +980,7 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    if (!is_kvm_aia(msimode)) {
+    if (!kvm_enabled() || !is_kvm_aia(msimode)) {
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     }

