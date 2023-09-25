Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F20827AD43E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 11:10:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhbk-0001xl-5B; Mon, 25 Sep 2023 05:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkhbg-0001ri-1I
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:10:20 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkhbZ-0003sy-FC
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:10:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c60f1a2652so12312995ad.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 02:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695633012; x=1696237812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O38GvyaXHhJBPd7xO5xDy5lq5AXI2yQBS/AUzdXdE0Q=;
 b=RDHkXLN5JR9RBMwnfORcRhIQOtrM/mPYPWzaD7VYTHc61dC+oWkUCqxWCj+KiTvYeB
 tiaf0n1KQoUPJYfza1JcjsnuBwUFg06iGWDVlU8wHkgYItt7fuwdWj2qwU5WQ4XoMAhz
 gee72XUXNhDXQK1M3fInvqIBpRamINESQN9CUjK1zelf+rj8WPPQScfptSHPoVd3e6lt
 tpb655yV4DsK4v1L/21pXE3PWQ1qBxQEPbjHSf1Y23Szl0XGkZ4hB8vA0rmabopNtjwI
 mA2zn1p7PKJxm2NAdNHv7eYpgm/77jca7VWnJo8AuqDQ3teU5SsxEEUhQKKyOC8t6b9K
 nR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695633012; x=1696237812;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O38GvyaXHhJBPd7xO5xDy5lq5AXI2yQBS/AUzdXdE0Q=;
 b=IhTkfb/tERerepLHmJ8yQXi7jbS1t7nsuyFSGRrEQVctzzNLbJCmENkQQJqJ+61PNU
 AQMdWdwUpeJRmPBzNMnSLRck/BVOWNIlyH9g4DEqEkH5qgW1zw8rQcQm+fphz+oGwPoj
 2jcRmc9m29JRY04oBz8Sd2Pif0o6P3hMmyWqg9lBqY1aP88ujRq27QkaJEraJ6jIF/XR
 eySjyJ+sDPUSm+xsn9i5peuVkjPGZHCvi6DDC6U5RQJZrRPBRmHsNUBSOxopmJ8ndi14
 Oq8BNa09FXTtm9XY6fiOoMz5NnIiTfPliWpzM+tnF1jHPVp5Ps+JcnOCFeBCLjK7WIil
 xtMg==
X-Gm-Message-State: AOJu0YyXy2R6Xd7N5sgU5LtwmGHzTL8I9RyMjRELI71drOX8J0MxoGcs
 gbU/R2tQCXrovKFhXRiRKy2FQg==
X-Google-Smtp-Source: AGHT+IGwKH7fHBLly4Jd8DJu+PqInZw7sZXmmkjHk6aeUJHfa+lSIyKNKqZvQ7xCprsoMWLKhXrz4g==
X-Received: by 2002:a17:902:da8e:b0:1bc:1e17:6d70 with SMTP id
 j14-20020a170902da8e00b001bc1e176d70mr11371777plx.24.1695633011976; 
 Mon, 25 Sep 2023 02:10:11 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.42.59])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a170902748800b001b895336435sm1958426pll.21.2023.09.25.02.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 02:10:11 -0700 (PDT)
Message-ID: <592ab03d-3849-5075-c755-55125382e58c@ventanamicro.com>
Date: Mon, 25 Sep 2023 06:10:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] softmmu/device_tree: Fixup local variables shadowing
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: bmeng.cn@gmail.com, alistair.francis@wdc.com,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, palmer@dabbelt.com,
 liweiwei@iscas.ac.cn, Bin Meng <bin.meng@windriver.com>
References: <20230925043023.71448-1-alistair.francis@wdc.com>
 <20230925043023.71448-5-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230925043023.71448-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 9/25/23 01:30, Alistair Francis wrote:
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Bugs love to hide in such code.
> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
> on polling error".
> 
> This patch removes the local variable shadowing. Tested by adding:
> 
>      --extra-cflags='-Wshadow=local -Wno-error=shadow=local -Wno-error=shadow=compatible-local'
> 
> To configure
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   softmmu/device_tree.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/softmmu/device_tree.c b/softmmu/device_tree.c
> index 30aa3aea9f..eb5166ca36 100644
> --- a/softmmu/device_tree.c
> +++ b/softmmu/device_tree.c
> @@ -418,9 +418,9 @@ int qemu_fdt_setprop_string_array(void *fdt, const char *node_path,
>       }
>       p = str = g_malloc0(total_len);
>       for (i = 0; i < len; i++) {
> -        int len = strlen(array[i]) + 1;
> -        pstrcpy(p, len, array[i]);
> -        p += len;
> +        int offset = strlen(array[i]) + 1;
> +        pstrcpy(p, offset, array[i]);
> +        p += offset;
>       }
>   
>       ret = qemu_fdt_setprop(fdt, node_path, prop, str, total_len);

