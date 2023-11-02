Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA5F7DEEF7
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 10:33:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyU4C-0002lJ-Ly; Thu, 02 Nov 2023 05:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qyU3w-0002g4-Bh
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 05:32:34 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qyU3u-0004H4-N2
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 05:32:28 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso1109016a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698917544; x=1699522344; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SnPPCvpi2vM2hqljmGDoKiz5OCbFVPkaNK+CiwKpp2Q=;
 b=TjNCG0zvlpDX2Kf2X0RqVEGjDw3aT1ISVU8FpjW1a5cacDcvIC8Xq0S2vPc4PEvSnL
 aktKFipTa+hYn2iv0FhKf6AulHLTt/k4NjcYUjeFRgVNqYlFiDjMfptxABtHuoZgljka
 P0kbDdEVZc6NKMG56QHqCvtNLaQ5+9ZeNfc8g0Ct9dyRzL5Ce1GPRVdN9Hq3r1BBOolI
 tV7j5a8UKRiOxfeygKXHrPuxq9ACHWXLsnLpsvcVDV9RSVG6az9GGIuLgbbEQlWGveKL
 O0RhBfP29eavPfKaKdeRkvEKRaKVJMYugzUErx0doTIU+kZDHfeK5n6ahGBHGGNiQZ4O
 pM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698917544; x=1699522344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnPPCvpi2vM2hqljmGDoKiz5OCbFVPkaNK+CiwKpp2Q=;
 b=sc7qHPNduXTw8ig8eZ6N+LYTG6D7sFlqo+E4hfviP1oL/YFY/1R1uKotLrUPz2Ndug
 kdKVxWvY3PLlXo5JnsKHTu7gsyg1WCo2DVuckyWxXvhoGQA1yFW9ogTd/+32WeA3n7mW
 PIYTJNHIeZNe0T2C9k23uF0GcdBLWuzj4pBct9fzaurvyP6q7Vn6c9ArQIipYZRlYM/r
 L+uyVn6HnmbBuZDV0G0DuWA87gN3wijgHJaMe9Z8THznt01E12TJ3r3fJ6d4ilhPmBI0
 cKlrjv9JSWOxY3DP+7q0IX7+dUA6V8MjPyNCDLAtjdxq4XduZKTvlAGV1mTaJbPWJf+X
 OkEw==
X-Gm-Message-State: AOJu0YzaVU1vf96zHoqLP83HOjoWIisJ+/QnkrYQePqO0tad80mwJyK/
 ar/jzWHHXmCN7YYDgThLmzFECNFP0HcGhmD0f0U=
X-Google-Smtp-Source: AGHT+IEnhEXS9++c4LlsYMVsr4HrFOIYcr5RbyhqOdgFEeX362IleAGyOux1hHQFiMzSoPVuQ0YrFg==
X-Received: by 2002:a17:906:ef0e:b0:9d0:4b8f:3da7 with SMTP id
 f14-20020a170906ef0e00b009d04b8f3da7mr4020887ejs.29.1698917544130; 
 Thu, 02 Nov 2023 02:32:24 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 e24-20020a1709062c1800b009d268e3b801sm902377ejh.37.2023.11.02.02.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 02:32:23 -0700 (PDT)
Date: Thu, 2 Nov 2023 10:32:22 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v8 04/19] target/riscv/cpu.c: set satp_mode_max MBARE
 during satp_finalize()
Message-ID: <20231102-30bfbfa066e5b09632fb068e@orel>
References: <20231101204204.345470-1-dbarboza@ventanamicro.com>
 <20231101204204.345470-5-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101204204.345470-5-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x533.google.com
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

On Wed, Nov 01, 2023 at 05:41:49PM -0300, Daniel Henrique Barboza wrote:
> KVM CPUs can handle "cpu->cfg.satp_mode.supported == 0" because KVM will
> make it do internally, not requiring the current SATP support from TCG.
> 
> But other TCG CPUs doesn't deal well with it. We'll assert out before
> OpenSBI if the CPU doesn't set a default:
> 
> ERROR:../target/riscv/cpu.c:317:satp_mode_max_from_map: assertion failed: (map > 0)
> Bail out! ERROR:../target/riscv/cpu.c:317:satp_mode_max_from_map: assertion failed: (map > 0)
> 
> This will be thrown by target/riscv/csr.c, write_satp(), when stepping
> in validate_vm().
> 
> There's no current CPUs affected by it, but next patch will add a new
> CPU that doesn't have defaults and this assert will be hit.
> 
> Change riscv_cpu_satp_mode_finalize() to set satp_mode_max_supported()
> to MBARE if the CPU happens to not have a max mode set yet.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9f6837ecb7..f7c1989d14 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -942,9 +942,19 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
>      bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
>      uint8_t satp_mode_map_max, satp_mode_supported_max;
>  
> -    /* The CPU wants the OS to decide which satp mode to use */
>      if (cpu->cfg.satp_mode.supported == 0) {
> -        return;
> +        if (kvm_enabled()) {
> +            /* The CPU wants the OS to decide which satp mode to use */
> +            return;
> +        }
> +
> +        /*
> +         * We do not handle cpu->cfg.satp_mode.supported == 0
> +         * with TCG yet. Set to MBARE.
> +         */
> +        if (tcg_enabled()) {
> +            set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
> +        }
>      }
>  
>      satp_mode_supported_max =
> -- 
> 2.41.0
>

This patch should no longer be necessary if the suggestion I made in the
previous patch works the way I think it should. But, regarding this patch,
I do like that the "The CPU wants the OS to decide which satp mode to use"
comment became specific to KVM, which makes more sense to me. Maybe we
should just change that comment to something like

/*
 * With some accelerators, such as KVM, the OS dictates which satp mode to
 * use. For those cases, satp_mode.supported is zero and there's nothing
 * to do here.
 */

Thanks,
drew

