Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD65A82C762
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:43:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQEh-0007mm-BR; Fri, 12 Jan 2024 17:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOQEe-0007ly-Om
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:42:44 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOQEc-0002jD-Cn
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:42:44 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-28be024282bso4971886a91.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 14:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705099352; x=1705704152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ulDjogcD9U8vNT9lSPrtouvUTbSQHpW66LV5AUgRqdc=;
 b=ouoO91fqGxpMnfav0A2bjmo4A3Ru58eVF3jO9wD9IYYcij7sy83lYnk99z3iiAmCyU
 8McI6AGAm1DD1cK+AGII7BSO5Oalc06amqKB9G1/ihtsJeSVWtU+BaUpDTFZf/FDsQWq
 Kc6ZwPmR6vO1mLHMqq90PBRcn4cK5HWh4novbrnxXkOxLwZDoiiL8xh94D53MTOxiGiq
 xCrzRLeqiAxbijVfA5IkpYj/+YNK8ODugAzE2qW1tO1GPj/t4ix5JkiKv+FrxMRKXATX
 Nqfmy/6xXkdBFHBFsSsFDj7pQb3KZq0d16Vi2DkWjyxsvIW31WRvr9IhIsE8+OeMcZvJ
 cl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705099352; x=1705704152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ulDjogcD9U8vNT9lSPrtouvUTbSQHpW66LV5AUgRqdc=;
 b=GsAkswYb9kpFuOaV86x/ZIXao1Nwd6qF9CPz/+TZD0Ov/6StzJZkWvWxZvBA8p+F4T
 Jm7WsrQn7Y2InrGZXP6peprB+a3KC068+ZEtxtzpCjPL+CqLe0wAIvlaJzEFIoUZdmk7
 BidAUwl2GZJnCKE54PrveYoVnRS4nIR7VrGSXtrHsscSANlW7pciaolUH4a7tZ+ls0Vn
 XPfISQkPO1mSzITNL7XuTNJx+oLmdZq9UB6OLiqLlGMsBBv1Cgp1FZB2I3LWvj1dtduT
 hIS387nKu4zHbkO9dDe/1q+oy4929RXQ7FDjm0Tl0sKdIPXSnqljG84ssOCOP76JFMCK
 4gvw==
X-Gm-Message-State: AOJu0YxJWpV86kd2shdNn5bhFC7k0ojOZTsK2jmP47zmBs/NDW32rZlK
 pJLJxkjMWIamFwSon21leqDoonmvc01AqQ==
X-Google-Smtp-Source: AGHT+IFq2Avk7MCuzOvqijKduI1P26+ha4ylpqVBPK4esAPBjXjxMOquFFR4T1McpEzo3PQyk1xQYA==
X-Received: by 2002:a17:902:fc4e:b0:1d4:3dfd:7e30 with SMTP id
 me14-20020a170902fc4e00b001d43dfd7e30mr1672785plb.122.1705099352225; 
 Fri, 12 Jan 2024 14:42:32 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 jj7-20020a170903048700b001d472670a30sm3695512plb.162.2024.01.12.14.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 14:42:31 -0800 (PST)
Message-ID: <d0cc2c90-e401-460c-8883-7125c0506df7@linaro.org>
Date: Sat, 13 Jan 2024 09:42:26 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/riscv/cpu.h: use 'vlenb' in vext_get_vlmax()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240112213812.173521-1-dbarboza@ventanamicro.com>
 <20240112213812.173521-10-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240112213812.173521-10-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 1/13/24 08:38, Daniel Henrique Barboza wrote:
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 11df226a00..628ef67d5f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -692,7 +692,8 @@ static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
>   {
>       uint8_t sew = FIELD_EX64(vtype, VTYPE, VSEW);
>       int8_t lmul = sextract32(FIELD_EX64(vtype, VTYPE, VLMUL), 0, 3);
> -    return cpu->cfg.vlen >> (sew + 3 - lmul);
> +    /* vlen = vlenb << 3 */
> +    return (cpu->cfg.vlenb << 3) >> (sew + 3 - lmul);
>   }

Better to simplify the arithmetic:

-    return cpu->cfg.vlen >> (sew + 3 - lmul);
+    return cpu->cfg.vlenb >> (sew - lmul);


r~

