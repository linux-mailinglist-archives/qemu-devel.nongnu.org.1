Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EFA70E6C9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:43:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Yqi-0001rF-0Q; Tue, 23 May 2023 16:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Yqf-0001qU-FU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:43:13 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1YqQ-00072b-MY
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:43:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64a9335a8e7so3680447b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684874577; x=1687466577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xQbX0QJp/UFA4Uocq4Bao2xItNm6RhrQiuR1i3DCm+c=;
 b=mJE0ItlL69R3pOVhOdTo+x2KOD2EVAJjhvPv11Uh5Q7vc5ruc5CCgm/VeL/cg670/n
 COAueVMATRw8je+FtBOK7yi7u4cdlOh2XYcEffMEKVZcpqAJ24IKoNxPdUqXC/8mJ5hJ
 VverVgCIR2GFAWH7Eq+clBow3vb/QtbNOWxlQNI4vAgrzlrYDb2KEHddhNlIAsu79qzn
 aAVmXJ2CI+2rT9sTLoj60q7LpOUIFFYAZDtZ6GvC7P8Ixtn7FKoEZLFr43kB/OE/Hrsy
 rQh94oz+iWGlmDj/f/FHR50JbDJvFDPXvHeYKnaQJ9ToltVFeMefA9bP1x/fYn2bPet0
 HN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684874577; x=1687466577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xQbX0QJp/UFA4Uocq4Bao2xItNm6RhrQiuR1i3DCm+c=;
 b=kCHgWbD18UQmugXsODjZg+AVJdb31swCv/uA2xZHQOvA0jUDnW5gx93ktrXvS4vE9i
 VEKDLOMxdMFjTIC0bAFP60K4BAM7xxLLtmyz54vq87RW5y/lrqIa+ta2yWMc4uKdPFS5
 3vfSSj+lzb3ZRcJRkPgpaFUqS3RjcNKvFv/OSviit7JZ6Q9HxJx/Hy58csogwM7scqF8
 JDvcrvHsJmssGfifDnvyvIq3xRRmr9ii8I1w0XVRmsuRMRoH+b1EP8PRFrIXVuedVhCj
 a2U9w32CMdd6Ld+SEw65pQb5zpWTvH3ntkY/IVQL/aG6LjPAWW4vCtSB9Y3jkHeY2iez
 lW+w==
X-Gm-Message-State: AC+VfDzYksDkyYpSzai+hvA9mGoBOGzim88simcVm4dtqC7YyjtD+GXV
 OPtIvSThQow66q4DKlVkFl4+8g==
X-Google-Smtp-Source: ACHHUZ6Su98aDD8p9CIKQVSR8O5EjkXQitltL0uB9LLg1tb6Fe2Wdyd1m5ST+IN6PdPgW2iK52uxpw==
X-Received: by 2002:a17:903:234a:b0:1ac:a88a:70b6 with SMTP id
 c10-20020a170903234a00b001aca88a70b6mr20389321plh.31.1684874577020; 
 Tue, 23 May 2023 13:42:57 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a1709028f8200b001ab0159b9edsm7155240plo.250.2023.05.23.13.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 13:42:56 -0700 (PDT)
Message-ID: <e19bb362-572e-25d1-013d-f53ff9e61e58@linaro.org>
Date: Tue, 23 May 2023 13:42:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 6/7] target/riscv: Enable PC-relative translation
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230523135939.299246-1-liweiwei@iscas.ac.cn>
 <20230523135939.299246-7-liweiwei@iscas.ac.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523135939.299246-7-liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/23/23 06:59, Weiwei Li wrote:
> Add a base pc_save for PC-relative translation(CF_PCREL).
> Diable the directly sync pc from tb by riscv_cpu_synchronize_from_tb.
> Use gen_pc_plus_diff to get the pc-relative address.
> Enable CF_PCREL in System mode.
> 
> Signed-off-by: Weiwei Li<liweiwei@iscas.ac.cn>
> Signed-off-by: Junqiang Wang<wangjunqiang@iscas.ac.cn>
> ---
>   target/riscv/cpu.c                        | 31 ++++++++++-----
>   target/riscv/insn_trans/trans_rvi.c.inc   | 12 +++++-
>   target/riscv/insn_trans/trans_rvzce.c.inc |  4 +-
>   target/riscv/translate.c                  | 47 +++++++++++++++++++----
>   4 files changed, 74 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

