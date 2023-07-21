Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB4175C485
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 12:21:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMnFL-0001Oy-9l; Fri, 21 Jul 2023 06:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMnFD-0001OO-Q4
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:20:19 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMnFC-00065C-BL
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:20:19 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5661e8f4c45so1182222eaf.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689934817; x=1690539617;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jFWkYtetezdFc9lzRYqCl1YXATFrTSOxidKcr8+pxdc=;
 b=YNW7Ks/ffotHrYR+ZxNKV/zI6keGZVTXcVjc2C+tz/8ug7xzsxnlrXpqbxAXAJRtUg
 wBfeLGt2gNwQy2+WQgUqco59vmU0gFj3ghkUOOjNmwQURgreGd3CvRCj+ZFRRi4rSzSC
 CnAVfIALyU+eZSJ9FpTCfxFgIPFMqzVczyKLhsbJhEB1XoEqADg6gm4ohkf9QYzysu4j
 a9r2Gs2B4zAbWQSLDVmgSwxQTdHYwB3LnKrZ4eY/Kt2k3IPEVfq00pA1ru6v6JWfB4OX
 ueIC42EWYs3ZyCZ/CP2vo9+ah5KLj63lKyDG6owPb8aQn6LIjQ8zMYNmrsljGCG2YYpE
 uPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689934817; x=1690539617;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jFWkYtetezdFc9lzRYqCl1YXATFrTSOxidKcr8+pxdc=;
 b=dkP7mU6XvpHMRXrThIkMp9X747Dge054YmokmcA8tNOdlquWPz1Lx7ccI2LbP5umj0
 oI19hfS+2YpCdhqqzZIhEjvLFeNlzYKi/WsLk7KWUOe8LTuJ2n1aYYNJYuIftNEccD3h
 Iy7lYb9u+Koe8C09aUYUQfJqb3FDuw1IHGGm42hDGPkC4A5mqS57ndhlSp+TPmqaQvoH
 T8HskKdYljr4PIaIYU9rKZ2r488KsiI44I/kf5stnnaARlzatlFpogc/qA3DbeWaGO+L
 vbNtVuyrDOdumg0Yul1owy1yQDRKOAURHkPJff6XwpZohVEyxQ0NOuGQpJnPFbnEXt0S
 uG0g==
X-Gm-Message-State: ABy/qLaikOkSr+eqogkG7j+JFXgPp+w+48Hs/s/Or842QdOoMXMs07hm
 V/dM2+6clakKnE//FYRZONNZdWmJUKLL56jkvjDZwA==
X-Google-Smtp-Source: APBJJlET86qVPQf5ZPywJzj0wrqZMa+BwUjyPhvNHsKk5zD0WS1/jqw47GGWs5UOHXttid2Z4jywrQ==
X-Received: by 2002:a05:6808:bc1:b0:3a1:eb47:a943 with SMTP id
 o1-20020a0568080bc100b003a1eb47a943mr1996240oik.10.1689934817277; 
 Fri, 21 Jul 2023 03:20:17 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-211.dial-up.telesp.net.br.
 [201.69.66.211]) by smtp.gmail.com with ESMTPSA id
 d5-20020a05680813c500b003a1e38362b7sm1254585oiw.25.2023.07.21.03.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 03:20:16 -0700 (PDT)
Message-ID: <fcee58c0-0e25-32dc-e6b2-6fda3464a088@ventanamicro.com>
Date: Fri, 21 Jul 2023 07:20:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] hw/char/riscv_htif: Fix the console syscall on big
 endian hosts
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230721094720.902454-1-thuth@redhat.com>
 <20230721094720.902454-3-thuth@redhat.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230721094720.902454-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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



On 7/21/23 06:47, Thomas Huth wrote:
> Values that have been read via cpu_physical_memory_read() from the
> guest's memory have to be swapped in case the host endianess differs
> from the guest.
> 
> Fixes: a6e13e31d5 ("riscv_htif: Support console output via proxy syscall")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/char/riscv_htif.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index f96df40124..40de6b8b77 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -30,6 +30,7 @@
>   #include "qemu/timer.h"
>   #include "qemu/error-report.h"
>   #include "exec/address-spaces.h"
> +#include "exec/tswap.h"
>   #include "sysemu/dma.h"
>   
>   #define RISCV_DEBUG_HTIF 0
> @@ -209,11 +210,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
>               } else {
>                   uint64_t syscall[8];
>                   cpu_physical_memory_read(payload, syscall, sizeof(syscall));
> -                if (syscall[0] == PK_SYS_WRITE &&
> -                    syscall[1] == HTIF_DEV_CONSOLE &&
> -                    syscall[3] == HTIF_CONSOLE_CMD_PUTC) {
> +                if (tswap64(syscall[0]) == PK_SYS_WRITE &&
> +                    tswap64(syscall[1]) == HTIF_DEV_CONSOLE &&
> +                    tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
>                       uint8_t ch;
> -                    cpu_physical_memory_read(syscall[2], &ch, 1);
> +                    cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
>                       qemu_chr_fe_write(&s->chr, &ch, 1);
>                       resp = 0x100 | (uint8_t)payload;
>                   } else {

