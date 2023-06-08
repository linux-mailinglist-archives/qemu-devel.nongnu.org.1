Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDEF727708
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 08:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q78je-0003OJ-HO; Thu, 08 Jun 2023 02:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q78jS-0003NO-Kh
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 02:02:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q78jQ-0001uA-Ty
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 02:02:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6d38a140bso1703735e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 23:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686204166; x=1688796166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DAunNoGN/E1C+FW1ht0zgjXYFEivPbwMTD6bGLRmpC8=;
 b=blJSU0FgLZwObgwV4HTl0d9EniDwvXyfmbWSg0hgH6yIyK/wZ49UUxe7mkLcyxTlfa
 4ZnAopB3DM0wIl3UvT9b14j5lINjcAmmGDSTbFM1PqCpiRz5ik5pgwz07lZ+htFJ33Ex
 lbOotSVKsu8E5HjeEQN50qtUZhIFFRr7oxWKVPbHG4sr5ABfoR7PGxDKBIaVruxbLtCz
 pZaFqJbfxfqAwCJyFaQn9g5jos6MMtLtaEhsdyQjyD+BwRSlVhad6SQeC6VWRN/qhpdf
 VAqP6j8xDWyK+nfD3VY3lHMFqjLYvFuWCzcLnuKx5OJ9c3OZnig3zhjxfvOqCiapb2iA
 HskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686204166; x=1688796166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAunNoGN/E1C+FW1ht0zgjXYFEivPbwMTD6bGLRmpC8=;
 b=Qf034hqPyu4XMqPgHbUY1KeoQE8YT9yALoIpFeJgsLxdVB0YfZcF76mkjWLntFCqPW
 IWzy/GepQLDiw10RuRYK7gkPRihgHegf49N2Lh/B8SUYelx9IBrQSMJCkJi/R/eQw0Fj
 j4pRC/v8fJymmleAMNqEZ9beVN7UN/rkCV+vCcxjmVJk9C43BW1F+ebq4yVFKvrkX+pD
 Cmrtxqh30ZXdAlCAxSJ9lSEdlcERla6NSdxP6GZJMPtRT4RrTmamkL9PkxKMqajHDNjm
 I6Oe0SFm/E2YHr2oJxaE8da2eW30wozR2G1dmM945Vc+FmPuKt9hXAdX8pUmXluJok6J
 +2wA==
X-Gm-Message-State: AC+VfDy6GHfuev6Q6+fNOtx5mf1okoziRNA5aoF6jqt1zZZ8JSdoELNS
 NKHRHRMCKR7w+qvp+q+MRV02VA==
X-Google-Smtp-Source: ACHHUZ72LfEe7QYnRbhBg0TMl3zYtm9v4PiHiT+FCGP1VPZQVlVa1w7vL7oRaqd53wkLRu+V6XIYFw==
X-Received: by 2002:a7b:ca58:0:b0:3f7:e660:cdc5 with SMTP id
 m24-20020a7bca58000000b003f7e660cdc5mr367281wml.9.1686204166326; 
 Wed, 07 Jun 2023 23:02:46 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 26-20020a05600c021a00b003f7f475c3c7sm830898wmi.8.2023.06.07.23.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 23:02:45 -0700 (PDT)
Date: Thu, 8 Jun 2023 08:02:44 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 13/16] target/riscv/kvm.c: add multi-letter extension KVM
 properties
Message-ID: <20230608-8a2abef07a078c1eae49cfcd@orel>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-14-dbarboza@ventanamicro.com>
 <20230607-9a499522ac7de9ebcf0c8699@orel>
 <fb74c3a0-9762-92c2-4a1c-9544af822c5a@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb74c3a0-9762-92c2-4a1c-9544af822c5a@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32f.google.com
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

On Wed, Jun 07, 2023 at 04:59:02PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 6/7/23 08:48, Andrew Jones wrote:
> > On Tue, May 30, 2023 at 04:46:20PM -0300, Daniel Henrique Barboza wrote:
> > > Let's add KVM user properties for the multi-letter extensions that KVM
> > > currently supports: zicbom, zicboz, zihintpause, zbb, ssaia, sstc,
> > > svinval and svpbmt.
> > > 
> > > As with the recently added MISA properties we're also going to add a
> > > 'user_set' flag in each of them. The flag will be set only if the user
> > > chose an option that's different from the host and will require extra
> > > handling from the KVM driver.
> > > 
> > > However, multi-letter CPUs have more cases to cover than MISA
> > > extensions, so we're adding an extra 'supported' flag as well. This flag
> > > will reflect if a given extension is supported by KVM, i.e. KVM knows
> > > how to handle it. This is determined during KVM extension discovery in
> > > kvm_riscv_init_multiext_cfg(), where we test for EINVAL errors. Any
> > > other error different from EINVAL will cause an abort.
> > 
> > I wish that was ENOENT, but I suppose that ship sailed.
> > 
> > > 
> > > The 'supported' flag will then be used later on to give an exception for
> > > users that are disabling multi-letter extensions that are unknown to
> > > KVM.
> > > 
> > > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > ---
> > >   target/riscv/kvm.c | 136 +++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 136 insertions(+)
> > > 
> > > diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> > > index bb1dafe263..b4193a10d8 100644
> > > --- a/target/riscv/kvm.c
> > > +++ b/target/riscv/kvm.c
> > > @@ -202,6 +202,99 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
> > >       }
> > >   }
> > > +typedef struct RISCVCPUMultiExtConfig {
> > > +    const char *name;
> > 
> > No description? I'd prefer we use the same cfg struct for single-letter
> > and multi-letter extensions. We can use a union to overlap cpu_cfg_offset
> > and misa_bit.
> 
> multi-letter extensions don't have a 'description' field in TCG. Nothing
> prevents us from adding for KVM though.

KVM can wait for descriptions until after adding them to TCG, and then,
hopefully, figuring out how to share them with KVM.

Thanks,
drew

