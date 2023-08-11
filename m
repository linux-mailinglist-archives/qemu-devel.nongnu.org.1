Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6F67793C5
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUYz-0004aE-8X; Fri, 11 Aug 2023 12:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUYq-0004YU-UZ
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:00:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUYp-00084S-69
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:00:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bb84194bf3so14656065ad.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691769620; x=1692374420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fa1lIFhs/aw4bLGE0OKA8/gu8et3hzVukf2KvK4rErA=;
 b=LZlDNqlDuczwAb2bynUpbFHUkm3JZsR74NP2Ec4F9A4D0rcTpiL1rO9q3NVyoP10cR
 BF6r8pqy6/VNIBGculHkuh6Ung0uhZkPEkJHy64lbTPbFzksvjAZPZ0mKQxR4GRv1ouV
 nCRXEnBUiz6ZSCBUWgC87oyjIAwH1gnuA1xIlQN5hMGUwTJP+M8W3Hyux3JKdra34Afk
 gIXH5VofpX8t+jIKSo9gfwZfDdLd9LiB6vwkz6wjDYPDHULdaeqVQP86I5Mi7Ve0B6gh
 6o6IlrOU0QmCW36Q9z//uXGYjR4Nn4Lb+LxtaSFhiLTmttj+au/Qa9IC4Klulym/UCx9
 JvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691769620; x=1692374420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fa1lIFhs/aw4bLGE0OKA8/gu8et3hzVukf2KvK4rErA=;
 b=C17QLDRVoq1/qCvVav7y5PSGjkL+e22KwTNvEZS/JZrdA4Coun+mU98oFxLEREfghd
 Us3sfmTGhINz+oyNoY2fjfvEeV5mt0tu/LTAqLP+3M/YhTXoxCyCVbrYC8SanbROwWZf
 f5M3Tg0IpG3flepZC6m6EpsgMKiEGBUCxgxItWYQrvzWMKeGqFw+k+/GsUrXv85VgGHU
 SBEHKX5OQVCgR31axiGVvXoo3Nw2xbqWkTrhO3LKrOdRNA2/ZWo++LwybSy3B2yn4Ft9
 Vfe6/eJdPdgfxnGOFosXyE6Pk961m7KSJ1nLXknobiaD1dQOKb4CcRfhy+77bsl4ndfk
 MK8Q==
X-Gm-Message-State: AOJu0YzXFtXVOqHCjdn2ImrUZqftX7dUAYiuLk5Mtu76RtdiNApsTpyI
 6qVYGgWieuq17B83HyrGc51l/A==
X-Google-Smtp-Source: AGHT+IEstrEItUMa9mzYFV8yiORlcbPBQ/zwtUjuksXZydONmALZnI8YOeGp6+nPrT7RjJ0lKQlbxA==
X-Received: by 2002:a17:902:74c2:b0:1b8:17e8:5475 with SMTP id
 f2-20020a17090274c200b001b817e85475mr2243219plt.24.1691769619776; 
 Fri, 11 Aug 2023 09:00:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:e773:351d:2db2:8a8a?
 ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a170902e31400b001afd821c057sm4108963plc.58.2023.08.11.09.00.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 09:00:19 -0700 (PDT)
Message-ID: <3d151e82-f431-37b3-dae2-e111ee3946eb@linaro.org>
Date: Fri, 11 Aug 2023 09:00:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/8] target/loongarch: Add avail_64 to check la64-only
 instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn, c@jia.je
References: <20230811100208.271649-1-gaosong@loongson.cn>
 <20230811100208.271649-4-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230811100208.271649-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 8/11/23 03:02, Song Gao wrote:
> The la32 manual from [1], and it is not the final version.
> 
> [1]: https://www.loongson.cn/uploads/images/2023041918122813624.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%8432%E4%BD%8D%E7%B2%BE%E7%AE%80%E7%89%88%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C_r1p03.pdf

I really hope this manual will be changed before final.


> -TRANS(pcaddi, ALL, gen_pc, gen_pcaddi)
> -TRANS(pcalau12i, ALL, gen_pc, gen_pcalau12i)
> +TRANS(pcaddi, 64, gen_pc, gen_pcaddi)
> +TRANS(pcalau12i, 64, gen_pc, gen_pcalau12i)
>   TRANS(pcaddu12i, ALL, gen_pc, gen_pcaddu12i)
> -TRANS(pcaddu18i, ALL, gen_pc, gen_pcaddu18i)
> +TRANS(pcaddu18i, 64, gen_pc, gen_pcaddu18i)

For the compiler, PCALAU12I is much more useful than PCADDU12I.

Because PCALAU12I produces zeros in the lower 12 bits, the high-part pc-relative 
relocation does not need to be paired with a corresponding low-part pc-relative relocation.

Whereas PCADDU12I produces a full 32-bit result, and the low-part pc-relative relocation 
needs to know where the high-part was produced in order to compensate.  This fundamental 
error was made by the RISC-V ISA, and their toolchain is still paying the price.


> @@ -69,6 +77,10 @@ static bool trans_cpucfg(DisasContext *ctx, arg_cpucfg *a)
>       TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>   
> +    if (!avail_64(ctx)) {
> +        return false;
> +    }

For the operating system running on LA32, lack of CPUCFG means that you now have to 
provide the cpu configuration in another way:

(1) Via compilation options, such that one operating system build will only run on a 
single cpu.

(2) Via external data, like device tree.

Either option complicates the usage of LA32.

I would hope that a few words of rom for CPUCFG to read is not too expensive to 
incorporate in even the smallest cpu implementation.


r~

