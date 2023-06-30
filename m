Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59997743D27
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 16:04:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEia-00027y-PJ; Fri, 30 Jun 2023 10:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFEiY-00027N-6i
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:03:22 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFEiV-0004ZO-SK
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:03:21 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-313e1c27476so1692125f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688133798; x=1690725798;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JjOovlwcCV2yDttkbGy8I5PveRSxsCy1Ojfp3YMRiVA=;
 b=tLQJmH2k0lVeETIzcsDrYttzf4XASVEVWqhBjPQLQaKk1fCqyGdvwRcZX0SzhrN+Jc
 BUnAxPAV6rDulyxObcq4xMKwkMznUrcIJnKWF9vl1/wfa9OhIzptb4UFeGzu3cbPU8pZ
 dhzosIw+5HmB2nMfnxdKJ4UB4r3tFkw6aNWXRIbz/+EkJY3Ub7j0oEJCfPcdbN3N9Zz2
 npjsyKZoShGcegkt4Z/bYW5btmuFi+w1IIhPTZaaetRrMRzvJV+gnejXBPs5VDZV4Pyc
 NOBQcKlo5vaF9iIYSHlpeyM9f6Wa+/KDXt5XFZOgy3SVhtZup72N9EgmOBSD3ccVjkSO
 kTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688133798; x=1690725798;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjOovlwcCV2yDttkbGy8I5PveRSxsCy1Ojfp3YMRiVA=;
 b=liWcV6eEeQjwkvFXB60TMS7SQx7zeAMvTdykRn5MwqiyAbZObxxJlf9lmZcwYYIi/A
 WNcnlZ7esOam5Yr3aIFCNt6+eJNlQhx+Fn6jgq6JfQMFM0NMWGMYACLsX97gy7ar1+3d
 hwHDNPmsa41Jij8y636HqWUIJ5iIZLVfegNRUTy6x+QbaDCH3Do559J5Juqsxd0/LGCt
 Th9RuEDt2lvx+KqEbYOf2TL/84kQLD/HRaeRNzbeDMrlx3NjocEry6/AkeoV19szeGaW
 qRyn4sGc8Rc0vaCuQMpQgDIBrCSavHcbxYomrzEKnNNSW7uMhJNJacYIf7KemQlyUhzu
 XjXw==
X-Gm-Message-State: AC+VfDzdjHYU5KfbMJmbGF54b2QbzSNUSpfPAKBYTLabIjBAinutuU3g
 S3EL5JGEJhuKaGiqqZvgQfsNwg==
X-Google-Smtp-Source: ACHHUZ50wubOxQyS5QSJUqIzDI4+3w5Js/aBTg/vjXgZfenzA/ULFLbOOIYgWXMbzb8NBE/bIB3M2A==
X-Received: by 2002:a5d:4244:0:b0:313:e88d:e6d3 with SMTP id
 s4-20020a5d4244000000b00313e88de6d3mr7147840wrr.14.1688133797704; 
 Fri, 30 Jun 2023 07:03:17 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a5d504a000000b00313e8dc7facsm16639964wrt.116.2023.06.30.07.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 07:03:17 -0700 (PDT)
Message-ID: <55279432-e4fe-7309-ac6f-5e2a4b86f47c@linaro.org>
Date: Fri, 30 Jun 2023 16:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5] riscv: Add support for the Zfa extension
Content-Language: en-US
To: Christoph Muellner <christoph.muellner@vrull.eu>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Jeff Law <jeffreyalaw@gmail.com>, Tsukasa OI <research_trasio@irq.a4lg.com>,
 liweiwei@iscas.ac.cn, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Rob Bradford <rbradford@rivosinc.com>
References: <20230630115239.1920012-1-christoph.muellner@vrull.eu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630115239.1920012-1-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/30/23 13:52, Christoph Muellner wrote:
> +bool trans_fmvh_x_d(DisasContext *ctx, arg_fmvh_x_d *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_ZFA(ctx);
> +    REQUIRE_EXT(ctx, RVD);
> +    REQUIRE_32BIT(ctx);
> +
> +    TCGv dst = dest_gpr(ctx, a->rd);
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +
> +    tcg_gen_extract_i64(t1, cpu_fpr[a->rs1], 32, 32);
> +    tcg_gen_trunc_i64_tl(dst, t1);
> +    gen_set_gpr(ctx, a->rd, dst);

I think you would prefer

   tcg_gen_srai_tl(t1, cpu_fpr[rs1], 32);

so that dst is sign-extended to begin, instead of zero-extended.  You don't see an error 
because gen_set_gpr, for MXL_RV32, sign-extends the stored value.

However, the tcg optimizer would elide the second sign-extend if it can see that the value 
is already sign-extended.  So this could reduce to 1 operation instead of 2.


r~

