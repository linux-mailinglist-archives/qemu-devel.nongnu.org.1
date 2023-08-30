Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB3A78E349
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 01:30:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbUde-00026w-Lm; Wed, 30 Aug 2023 19:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUda-00026e-VS
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:30:16 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUdX-0000qC-Ff
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:30:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a41035828so162477b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 16:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693438210; x=1694043010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9w4GvrDeirixDT1mIZ4qunLi3ZMzPcB4l5csyHct36U=;
 b=XRt5pA2lBdQkzNBNlUZS4vvnO4djmG/zW21KzlZpHyUNO1Gx0UIzeIZYJn9/tpvVt2
 imgQfHkJkIJ0wOLYaknhyF95zFMQuRuHstOfIQyADSHnyJ2Z9o8ztbGvf5LGmCLPDB/a
 gBhF7NbXQDStDXEfiV1MCSjiolff2+9sRw0zsi7X7TkR3KymSS3UNKtUbNd3wkj3RFDM
 wJjG0T5HQgYSyA8stAhrZjuGBpWxSBp+V+B7SA88w4IlqwytagslhBhUATy5qq9jcm+h
 MdlIcBkRkQRp99L5Mt37STTkU6wWxTin8UmlYnbwJV9vzLsbLd+wOuUyGi2gXtlSYAeR
 f6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438210; x=1694043010;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9w4GvrDeirixDT1mIZ4qunLi3ZMzPcB4l5csyHct36U=;
 b=OJgtL5F1ETD7GKl2aKEn/os3rLPRQqh+5Al6v8HFsokRR1LaKk97fjqnbOPSEWFKwv
 hWd9bTLURFmkVBq2E/y9UOB4WMN1cQ3JbKbJr1h3V9h5996WDIwuGiukJyLfFzSzAnpo
 tld2VClQOCHj/ETVUpErDWPHu/e/201er4LANu88k8zxPoV0xZgcKfU6B3l1Isu3BAGp
 I8zoWSFf/h8Tx3TMmHcW9hlMF/7hi1Vmzbo3a/oZ/dFq6Mrr/9KVQnlsGGvirVCA7QEQ
 HtkebuiYD4M45vdAF5GVOEpOMn4f6/g4PBirriWVdiUxW7TGLXGI0xEHTQMM3Jsp6wYJ
 9wsw==
X-Gm-Message-State: AOJu0YxahR1VuOGgc1fn3rxlZgSMmhxcJ8JIrl4sih/T6LOPmggeksEk
 897D1xMRL7c1fsBXRVP7Yo3Pfw==
X-Google-Smtp-Source: AGHT+IHSheXdZPo3d+uHKKZwV+kmCQoMDQl/ZCc9SFXmcvGZR7uAl/sN7CzIQjn4Od9i2SXP8K1S8Q==
X-Received: by 2002:a05:6a21:3395:b0:13b:a2c9:922e with SMTP id
 yy21-20020a056a21339500b0013ba2c9922emr4336610pzb.27.1693438210047; 
 Wed, 30 Aug 2023 16:30:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x13-20020a656aad000000b0055c558ac4edsm119909pgu.46.2023.08.30.16.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 16:30:09 -0700 (PDT)
Message-ID: <3935609a-9535-8fd4-0679-df0de97af023@linaro.org>
Date: Wed, 30 Aug 2023 16:30:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 36/48] target/loongarch: Implement xvbitclr xvbitset
 xvbitrev
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-37-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-37-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVBITCLR[I].{B/H/W/D};
> - XVBITSET[I].{B/H/W/D};
> - XVBITREV[I].{B/H/W/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/vec.h                       |  4 ++
>   target/loongarch/insns.decode                | 27 +++++++++++
>   target/loongarch/disas.c                     | 25 ++++++++++
>   target/loongarch/vec_helper.c                | 48 ++++++++++----------
>   target/loongarch/insn_trans/trans_lasx.c.inc | 27 +++++++++++
>   5 files changed, 106 insertions(+), 25 deletions(-)
> 
> diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
> index 4497cd4a6d..aae70f9de9 100644
> --- a/target/loongarch/vec.h
> +++ b/target/loongarch/vec.h
> @@ -85,4 +85,8 @@
>   #define DO_CLZ_W(N)  (clz32(N))
>   #define DO_CLZ_D(N)  (clz64(N))
>   
> +#define DO_BITCLR(a, bit) (a & ~(1ull << bit))
> +#define DO_BITSET(a, bit) (a | 1ull << bit)
> +#define DO_BITREV(a, bit) (a ^ (1ull << bit))
> +


Aside from this movement,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

