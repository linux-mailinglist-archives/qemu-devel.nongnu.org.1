Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C4D777C3B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:33:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7dr-0003yG-Kj; Thu, 10 Aug 2023 11:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qU7dg-0003x8-5h
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:31:53 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qU7dd-00026L-UO
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:31:51 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5233deb7cb9so1249134a12.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691681508; x=1692286308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YxqrlqL2dabw4MAMNw9weMs9SAvG9fseBRi2E11WqiU=;
 b=m6DZvxAUrdtSmrT1nzXTlLAGg++JhOuYH0imXjA7lgNzInUd3XWBwflfBZoYDJOBFK
 UnUNl+TP9yExjk2yofj9MKFHCN3+4O4zDQsA+DD8yFDzPZOjobvinx3plZcpjNp/INfm
 iXJsf1QNbvCZD6aLVtfS/zDLM2BkLbL1UAdw1XOQTyibcaGU3A9w1DXKIscvs2nx4wjo
 Gyz7T1njzrr3KTWuDr2hlvAEFmjKy3XHK0/bGiFIXf0qUc3VMP3pccwhcmmxsGbIkW7+
 JwJdLv9WDqQRyGvPzLbmhqMCje2ZJr7xeb6wgMVB9dHm2pwobWLG7zN2kXSmXi205b2r
 N1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691681508; x=1692286308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxqrlqL2dabw4MAMNw9weMs9SAvG9fseBRi2E11WqiU=;
 b=KxuFYAToYmS7RXJ+P1srcqrVY9/jMcuVSqYQ56JOo5rEXFQZ4NzZ2SV7AJ8IG3c8us
 kq2Du/1VgNtHUI/Sfhrlk6ncgbHQY7lljnI4FJ+vHSvhxSYa066/nUilrvne2h+nScrD
 2ElsS66gYYDBkw/y8Ud//FA4sRkafRPjX4AD1Rue3DVY28zrrvaWUeRWALkwgrlGxYTH
 YJXC35ppWnxfLvGV8w4B20Zi/AtLvBWYBycRUnBDE5bZqC6YemUcQ2UxWOE7EOMAAIEp
 Afnp3zeUf4IMyWRNNQFWKOcuBsDX5slNSmeDNhOVbsuUxKI74iSr58fqWbsyOQV6mXCj
 2QPg==
X-Gm-Message-State: AOJu0YyB7Y9c9Uuffw3tXoe6l6+XawbNa9uc36A8TROU47Wb4WmvYMDJ
 bRqAZvwy9MFcy2qqlGDzP3qotQ==
X-Google-Smtp-Source: AGHT+IGMMyBbMlIpV+lsycF86IZ8OZX31zj4+MRYhSREnaTjUeh1LDpABSQjLffhv4+c0BPdvFJbBw==
X-Received: by 2002:a17:906:1ce:b0:966:17b2:5b0b with SMTP id
 14-20020a17090601ce00b0096617b25b0bmr2654767ejj.49.1691681508374; 
 Thu, 10 Aug 2023 08:31:48 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 qw25-20020a170906fcb900b009928b4e3b9fsm1073556ejb.114.2023.08.10.08.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 08:31:47 -0700 (PDT)
Date: Thu, 10 Aug 2023 17:31:46 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Richard Bagley <rbagley@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, dbarboza@ventanamicro.com
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
Message-ID: <20230810-c9e1f2783168b48bc07a1aa2@orel>
References: <20230731183320.410922-1-rbagley@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731183320.410922-1-rbagley@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52a.google.com
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

On Mon, Jul 31, 2023 at 11:33:20AM -0700, Richard Bagley wrote:
> The recent commit 36df75a0a9 corrected one aspect of LUI disassembly
> by recovering the immediate argument from the result of LUI with a
> shift right by 12. However, the shift right will left-fill with the
> sign. By applying a mask we recover an unsigned representation of the
> 20-bit field (which includes a sign bit).
> 
> Example:
> 0xfffff000 >> 12 = 0xffffffff
> 0xfffff000 >> 12 & 0xfffff = 0x000fffff
> 
> Fixes: 36df75a0a9 ("riscv/disas: Fix disas output of upper immediates")
> Signed-off-by: Richard Bagley <rbagley@ventanamicro.com>
> ---
>  disas/riscv.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 4023e3fc65..690eb4a1ac 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4723,9 +4723,12 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
>              break;
>          case 'U':
>              fmt++;
> -            snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
> -            append(buf, tmp, buflen);
> -            if (*fmt == 'o') {
> +            if (*fmt == 'i') {
> +                snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12 & 0xfffff);

Why are we correcting LUI's output, but still outputting sign-extended
values for AUIPC?

We can't assemble 'auipc a1, 0xffffffff' or 'auipc a1, -1' without getting

 Error: lui expression not in range 0..1048575

(and additionally for 0xffffffff)

 Error: value of 00000ffffffff000 too large for field of 4 bytes at 0000000000000000

either.

(I see that the assembler's error messages state 'lui', but I was trying
'auipc'.)

I'm using as from gnu binutils 2.40.0.20230214.

(And, FWIW, I agree with Richard Henderson that these instructions should
accept negative values.)

Thanks,
drew


> +                append(buf, tmp, buflen);
> +            } else if (*fmt == 'o') {
> +                snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
> +                append(buf, tmp, buflen);
>                  while (strlen(buf) < tab * 2) {
>                      append(buf, " ", buflen);
>                  }
> -- 
> 2.34.1
> 
> 

