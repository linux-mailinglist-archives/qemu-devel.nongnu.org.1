Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E57B796C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:02:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwpM-0002dH-Mk; Wed, 04 Oct 2023 04:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qnwov-00026z-CE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:01:26 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qnwot-0007vM-B6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:01:25 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5347e657a11so2995266a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696406479; x=1697011279; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IQDNTJHInAL8NQ5z6z+JemoEkqqb2N3slY0RBZIIuVM=;
 b=cysvUO086NTEms0B6tjkMq1cBYkd0oRWLkUj3MpStBQSQWlmimwsroM/zO7TAI4o4t
 sWQMOy7SK6U7RMORY5kOYw0Hrw6fhgL+oKwJqsz7Uqc6Ojt+kJ5HtVdHvsFmy743iJ6O
 oATxH4V5CCaLM4F/cvlQAfKyhBK5PrfBBow10oA503+Mn8hkKZ6IbMMMiS7ljQVXXOs3
 JmKbITf8MU/Mk5lhmPUJIRvVunN6DIb/jRXpmd0dr4M9bN48MXuYy0eLV72/ZiYSjjI1
 aDGq/6cEPhrNwxYN+x0iqJIfftUIniYv3K5pu7YddpHWlIBteJVV5CaMNbGnX3hrx9xn
 Sp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696406479; x=1697011279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQDNTJHInAL8NQ5z6z+JemoEkqqb2N3slY0RBZIIuVM=;
 b=BeaN6z53J5IhU88GsG7VgYu8te5Fzwgqf9CdYzFCjf69sjbypakd79+NASGFFbApX/
 tOx5/jwsj8zkjulJ5jocefrtdPKrr8ZSN/0QQdwdyybjZZEmwB7ObLKCGxG2r7Yrvxwt
 QrOCku/+t/ocYWHYPnfYkv08ac0W7HpFxbzfUfb2yWEpz/hgf+CF0WFWdThpYY56Jboh
 wi7kgwt8zj5n+Z/99RyCl3/5DptKE8xM6JJr4iDogyhX1HfGnL42Zm2E3CY6Z7nHwpVB
 8C28hjJ4XbWg2t5k1wAvoEvVpBiOQ0A85seHWZVn+K742jf3Pr96JoV/VUFSQRCkN0pO
 2KVQ==
X-Gm-Message-State: AOJu0Yzr9rzDKLtc/sZY11pB6dxBG5zfx0QEbxMPNQFaIiBx2bBgcFMP
 bK8PAjFJ/zGoBNE87LEc9vphfA==
X-Google-Smtp-Source: AGHT+IHmGoygvfOFS70Xd4ZcqFXNVWXRP53zejxJxQ5ORLSJUUyzFMrOtdv8EHN2ki1R6SNvO/6Yew==
X-Received: by 2002:aa7:dac3:0:b0:52b:d169:b382 with SMTP id
 x3-20020aa7dac3000000b0052bd169b382mr1240971eds.29.1696406478448; 
 Wed, 04 Oct 2023 01:01:18 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 x3-20020aa7d383000000b0051e0be09297sm2014094edq.53.2023.10.04.01.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:01:17 -0700 (PDT)
Date: Wed, 4 Oct 2023 10:01:17 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v2 1/2] target/riscv/kvm: improve 'init_multiext_cfg'
 error msg
Message-ID: <20231004-c1a3df9c09b62729c1fabddd@orel>
References: <20231003132148.797921-1-dbarboza@ventanamicro.com>
 <20231003132148.797921-2-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003132148.797921-2-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x535.google.com
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

On Tue, Oct 03, 2023 at 10:21:47AM -0300, Daniel Henrique Barboza wrote:
> Our error message is returning the value of 'ret', which will be always
> -1 in case of error, and will not be that useful:
> 
> qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error -1
> 
> Improve the error message by outputting 'errno' instead of 'ret'. Use
> strerrorname_np() to output the error name instead of the error code.
> This will give us what we need to know right away:
> 
> qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error code: ENOENT
> 
> Given that we're going to exit(1) in this condition instead of
> attempting to recover, remove the 'kvm_riscv_destroy_scratch_vcpu()'
> call.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index c6615cb807..c3daf74fe9 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -792,8 +792,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>                  val = false;
>              } else {
>                  error_report("Unable to read ISA_EXT KVM register %s, "
> -                             "error %d", multi_ext_cfg->name, ret);
> -                kvm_riscv_destroy_scratch_vcpu(kvmcpu);
> +                             "error code: %s", multi_ext_cfg->name,
> +                             strerrorname_np(errno));
>                  exit(EXIT_FAILURE);
>              }
>          } else {
> -- 
> 2.41.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

