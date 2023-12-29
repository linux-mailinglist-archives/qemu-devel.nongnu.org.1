Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E921781FF45
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 13:00:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJBVd-0004Ql-Uu; Fri, 29 Dec 2023 06:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rJBVc-0004QP-AK
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 06:58:36 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rJBVa-0007w9-Lw
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 06:58:36 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-555936e7018so1371263a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 03:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703851112; x=1704455912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NxTjd/49fScheKuPt1bDUmuncY+gFbOtfV2iJvLDxJ0=;
 b=cdYAsf12BmKPU1XocjhwrNMvjgQsZHj16/lFHJJWal8XTxotsMMUkXFF+gppfznBju
 ikqURiF73AnKxs/XLeUAglMWgMzqt8EOIMtFueW+iDtGclOWKfCz1qAswdzquTdumWWZ
 5ycP+ycxdly32JcU5S4umCu/R7KsB6+HyFUq19ZHQnA6k9LMWPNa+sQjykLgOyPrkHeR
 hi0tRrGlNfmtau8zjR0xC9LaTOSrkMZ0nMZaMIxqUNGciw6CIi8ENWQoPG/t1tz9YqWv
 CYSqjuTDEHwISUeMfuhUcYup8JLhLgfqo1IOFIEjp7XX5doilHjHq91a4UNW2u+pFk2S
 6jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703851112; x=1704455912;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NxTjd/49fScheKuPt1bDUmuncY+gFbOtfV2iJvLDxJ0=;
 b=WcYwPEiDt6x79qOc0xB0h0TMaVDUOcF/Ds00thMTcbgaLoJGm9yLiB2SmvqXHZcIen
 C5rYoHFzxaQrTCYaq78VcRRjV6PIboDbvAZb8fWzM96r5otYhAjzfFEruj/1JowvNMv7
 JOOoMYuzkLqdVhpA6dgLugIYEzKiRzbNlwOgiDFkQAGw++NsSToHAlGvafPR0X4HcVur
 onhWmksahtBgswCC/ApVFZkgKQUfRymocwl42qT/BEFevTud4cCrUpTpQti8IKFsng8o
 5O7mFJtkvJS26MWaOJ/75WNyHWga+WTikguzk/V9e/2ozyAMscH2krLrExCni7ErcMjG
 9iFg==
X-Gm-Message-State: AOJu0YzZnLux+w47McwyOwxzaef9c7wXsP4k6hsA4GcroxWM1yyES8wO
 yUjCnk3LhsXFCjd+0nzbn5A1AtA+GBbJdIyCQzpjyAyS1D8pUCXh
X-Google-Smtp-Source: AGHT+IHRPiqN/xksYmLlQok0mOoUzu+eBJicirV5CFboKgu7cmuDdHrFLE65tjy9bwZ9jfxS5JikAg==
X-Received: by 2002:a17:906:10d7:b0:a27:59f9:5156 with SMTP id
 v23-20020a17090610d700b00a2759f95156mr1557319ejv.132.1703851111886; 
 Fri, 29 Dec 2023 03:58:31 -0800 (PST)
Received: from [192.168.200.206] (83.11.185.71.ipv4.supernova.orange.pl.
 [83.11.185.71]) by smtp.gmail.com with ESMTPSA id
 fg8-20020a1709069c4800b00a26aaad6618sm5004181ejc.35.2023.12.29.03.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 03:58:31 -0800 (PST)
Message-ID: <5bda0a91-5d8e-4c12-8e1e-93644108d723@linaro.org>
Date: Fri, 29 Dec 2023 12:58:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/sbsa-ref: Add cpu-map to device tree
Content-Language: pl-PL, en-GB, en-HK
To: Xiong Yining <xiongyining1480@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org, quic_llindhol@quicinc.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, chenbaozi@phytium.com.cn
References: <20231227120722.1683361-1-xiongyining1480@phytium.com.cn>
 <20231227120722.1683361-3-xiongyining1480@phytium.com.cn>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20231227120722.1683361-3-xiongyining1480@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x531.google.com
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

W dniu 27.12.2023 o 13:07, Xiong Yining pisze:
> From: xiongyining1480 <xiongyining1480@phytium.com.cn>
> 
> Support CPU topology description through device tree.
> 
> Signed-off-by: Xiong Yining <xiongyining1480@phytium.com.cn>
> Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
> ---
>   hw/arm/sbsa-ref.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index e6cd612bc5..a3c851148a 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -283,10 +283,45 @@ static void create_fdt(SBSAMachineState *sms)
>                   ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
>           }
>   
> +        qemu_fdt_setprop_cell(sms->fdt, nodename, "phandle",
> +                        qemu_fdt_alloc_phandle(sms->fdt));
> +
>           g_free(nodename);
>       }
>   
> +
>       sbsa_fdt_add_gic_node(sms);

Can you add vCPU topology code before ^^ line? So code would add /cpus/ 
node and then go for /intc/ node.

> +
> +    /*
> +     * Add vCPU topology description through fdt node cpu-map.

Maybe worth adding pointer to hw/arm/virt.c code for longer description?

> +     */
> +    qemu_fdt_add_subnode(sms->fdt, "/cpus/cpu-map");
> +
> +    for (cpu = sms->smp_cpus - 1; cpu >= 0; cpu--) {
> +        char *cpu_path = g_strdup_printf("/cpus/cpu@%d", cpu);
> +        char *map_path;
> +
> +        if (ms->smp.threads > 1) {
> +            map_path = g_strdup_printf(
> +                "/cpus/cpu-map/socket%d/cluster%d/core%d/thread%d",
> +                cpu / (ms->smp.clusters * ms->smp.cores * ms->smp.threads),
> +                (cpu / (ms->smp.cores * ms->smp.threads)) % ms->smp.clusters,
> +                (cpu / ms->smp.threads) % ms->smp.cores,
> +                cpu % ms->smp.threads);
> +        } else {
> +            map_path = g_strdup_printf(
> +                "/cpus/cpu-map/socket%d/cluster%d/core%d",
> +                cpu / (ms->smp.clusters * ms->smp.cores),
> +                (cpu / ms->smp.cores) % ms->smp.clusters,
> +                cpu % ms->smp.cores);
> +        }
> +        qemu_fdt_add_path(sms->fdt, map_path);
> +        qemu_fdt_setprop_phandle(sms->fdt, map_path, "cpu", cpu_path);
> +
> +        g_free(map_path);
> +        g_free(cpu_path);
> +    }
> +
>   }
>   
>   #define SBSA_FLASH_SECTOR_SIZE (256 * KiB)


