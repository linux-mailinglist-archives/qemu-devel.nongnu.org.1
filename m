Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA107771E2
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 09:48:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU0OE-00071g-UY; Thu, 10 Aug 2023 03:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qU0O4-00070d-QK
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 03:47:16 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qU0O3-0004tc-79
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 03:47:16 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99c1f6f3884so93659566b.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 00:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691653633; x=1692258433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pVU9GmaLP9YMZK19YgyoTNHTGqRtDjFo7X9L6/f6nYA=;
 b=ftvIxxuBiP9V3cPvn3XDaj1Iw88nAu5v4NW+oreUc1vJBFbzG9fRIF8Bx/SRUd7dSn
 AoDS9Toc39wgqyisJ2BnXFm9D3E3uMv1EXwOqdUPdXhGaWCxRENzDhkD2cJ7xff2TbJt
 p17A+16Xf4e3bTtD1hANtMA15f43ueN841LupJMQG3kr2pEnskazZkyVF9AC1aC3+hZN
 kKWXuiOodooU4hVYNYVNjU/O3usVuGCBdU8MSaSbLFI53sfjhwIa9hJHBjYXYUlK+hUj
 vGGDw3Gk8a8LSa80wUQpvfneRIBmkbDxZaNZr2kYa7n1Mdb9xMaxPGQiwWonhpy/40oI
 Geug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691653633; x=1692258433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVU9GmaLP9YMZK19YgyoTNHTGqRtDjFo7X9L6/f6nYA=;
 b=DJzyjAFa3fn3SVWnbjeSoFj1/1U0NX/V/R7jx+7AJ+uZORR6+9t4tVUUnesmcyhnaa
 x+uboj2Ma0zgpFNmo3mUSQwEjvVDOomqNSBlZUDiTMHqvJj+Ur7a3pTUi7CRJSNoYQrg
 wKFaYwa1Np7jzk6HLzJhF9cgJIfuiNSun62axdWfY7XGB04ADYoKUJ7Yt+4IxmgQukGm
 LYtKBRm1fwKarE11aAqoxPdjI+p5BqEEtCToXuq+XVCO1ZUq3czHBjA86kWfeVR9ygcn
 6CPjzcFsqF3YXi21beYSfHYqOzxVsk6BDw6K9dQNti/uRU4Fuq/2V28yqzygWJWm+7ao
 psZw==
X-Gm-Message-State: AOJu0YwpD3+gaS1YLStz74q63tRp1TMKfm3yqEcV0UVWYw9KrWofFbgL
 0PyGQfI5/MijZqoOQntNNoPp+A==
X-Google-Smtp-Source: AGHT+IGBwHe4aJnPYdtpcrjDH/j1KdGE2i3CbWxjGoCAU87oGN60llCNtiecv/TgUAZb1OwLgpCekA==
X-Received: by 2002:a17:906:cc1:b0:99c:ae35:8cd with SMTP id
 l1-20020a1709060cc100b0099cae3508cdmr1115990ejh.43.1691653632832; 
 Thu, 10 Aug 2023 00:47:12 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 qh28-20020a170906ecbc00b0099ce188be7fsm561334ejb.3.2023.08.10.00.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 00:47:12 -0700 (PDT)
Date: Thu, 10 Aug 2023 09:47:11 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH] target/riscv/kvm.c: fix mvendorid size in
 vcpu_set_machine_ids()
Message-ID: <20230810-d6727b594103fdc73eebbe09@orel>
References: <20230802180058.281385-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802180058.281385-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 02, 2023 at 03:00:58PM -0300, Daniel Henrique Barboza wrote:
> cpu->cfg.mvendorid is a 32 bit field and kvm_set_one_reg() always write
> a target_ulong val, i.e. a 64 bit field in a 64 bit host.
> 
> Given that we're passing a pointer to the mvendorid field, the reg is
> reading 64 bits starting from mvendorid and going 32 bits in the next
> field, marchid. Here's an example:
> 
> $ ./qemu-system-riscv64 -machine virt,accel=kvm -m 2G -smp 1 \
>    -cpu rv64,marchid=0xab,mvendorid=0xcd,mimpid=0xef(...)
> 
> (inside the guest)
>  # cat /proc/cpuinfo
> processor	: 0
> hart		: 0
> isa		: rv64imafdc_zicbom_zicboz_zihintpause_zbb_sstc
> mmu		: sv57
> mvendorid	: 0xab000000cd
> marchid		: 0xab
> mimpid		: 0xef
> 
> 'mvendorid' was written as a combination of 0xab (the value from the
> adjacent field, marchid) and its intended value 0xcd.
> 
> Fix it by assigning cpu->cfg.mvendorid to a target_ulong var 'reg' and
> use it as input for kvm_set_one_reg(). Here's the result with this patch
> applied and using the same QEMU command line:
> 
>  # cat /proc/cpuinfo
> processor	: 0
> hart		: 0
> isa		: rv64imafdc_zicbom_zicboz_zihintpause_zbb_sstc
> mmu		: sv57
> mvendorid	: 0xcd
> marchid		: 0xab
> mimpid		: 0xef
> 
> This bug affects only the generic (rv64) CPUs when running with KVM in a
> 64 bit env since the 'host' CPU does not allow the machine IDs to be
> changed via command line.
> 
> Fixes: 1fb5a622f7 ("target/riscv: handle mvendorid/marchid/mimpid for KVM CPUs")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 9d8a8982f9..b1fd2233c0 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -852,12 +852,19 @@ void kvm_arch_init_irq_routing(KVMState *s)
>  static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
>  {
>      CPURISCVState *env = &cpu->env;
> +    target_ulong reg;
>      uint64_t id;
>      int ret;
>  
>      id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
>                            KVM_REG_RISCV_CONFIG_REG(mvendorid));
> -    ret = kvm_set_one_reg(cs, id, &cpu->cfg.mvendorid);
> +    /*
> +     * cfg.mvendorid is an uint32 but a target_ulong will
> +     * be written. Assign it to a target_ulong var to avoid
> +     * writing pieces of other cpu->cfg fields in the reg.
> +     */
> +    reg = cpu->cfg.mvendorid;
> +    ret = kvm_set_one_reg(cs, id, &reg);
>      if (ret != 0) {
>          return ret;
>      }
> -- 
> 2.41.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

