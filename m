Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40658799C44
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 03:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf9b5-0000RU-8h; Sat, 09 Sep 2023 21:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf9b0-0000R2-B1
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:50:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf9ay-0000Gi-79
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:50:42 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf57366ccdso30232475ad.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694310638; x=1694915438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T44U6wfn7xqLA0hQKzFtK1CDiKbi+HJ69WlSnbdRz00=;
 b=Jwwl13u4Tn3qUSketB4IUHIT/+DLwC/kBvwwCyxVDUKl749o4Z1sDj2bd2o2Jg87tF
 c8s4NfY5/ka9ZJzb/AOuuC3fO5zM7ApjivMng2t6VMj8h+wa2PHhHUh0e2Dd1dTUbF3+
 eg+f3Nf16XzTspT1mDuPKjZ8gW9QZ4WoFPLs8u65E37vXfUe0//adb/d4yCS9E5/x/tT
 5vLfAi5eEmzaTRKOE+Cnj6n1Fbog+EQ3C+xAuZ1JfLBVaxU145OZooYFbgLuUXSIiNmD
 Zd/a9R4ypJrAzWgV1tfbqwwjaxz0itv1dNfjl2shH49hvmWoBkyjK7podfgAwoVBIHQg
 nsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694310638; x=1694915438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T44U6wfn7xqLA0hQKzFtK1CDiKbi+HJ69WlSnbdRz00=;
 b=ij58wDfLa2ay6vGlDPSmW18oRrQhHa7f0pjVXuZejMQoca/dbbLKAKUjOmZU/k1OMa
 81qrj5Zw9/qR30RSkwDDQQcrLlAR/sKYx9MjKGz4KSvKD9obYMAstje0nKzzw/NTLJcO
 oQXJ5cpRe2MlWu4BZtFWJiVpCJeJhdTGscq+Acnm3Z51+Tvd4Cy5Z5kjwfcqkCZqbZfd
 ZF6A9Wd9Td2YBEpdJJQPrZaCS3EBAcxv02rXl58FwlPGuQY3bsjxpG9CfocOZXgN1fDT
 5tJzrLBVUJ2Vf0zKqLB7rxWX4x+XhAbVPRQ5yDriXQKS8sVAu6Rc5hq+f4Bc3cAEftNP
 n+hg==
X-Gm-Message-State: AOJu0YywJIyQQW9G/WPY1BSeJPj84rCRXNH/q33B1WyAmSBcMCN72mZ5
 oNuxyxo7Ixtw+kxDqJuD2lERUBe7IMTu8bTxigQ=
X-Google-Smtp-Source: AGHT+IGIokJOnE9/JR4ifv0SESDBfFlZVTf3e2ianOiJ/+rlExjQpcg4BoRygh/VCucRJP8m/HsVCw==
X-Received: by 2002:a17:902:ecd0:b0:1c3:76c4:7242 with SMTP id
 a16-20020a170902ecd000b001c376c47242mr8057154plh.22.1694310638376; 
 Sat, 09 Sep 2023 18:50:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a17090322c300b001b81a97860asm3847009plg.27.2023.09.09.18.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 18:50:37 -0700 (PDT)
Message-ID: <ef3e4bc5-e79e-7831-1084-5c8741ccc7ab@linaro.org>
Date: Sat, 9 Sep 2023 18:50:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 16/57] target/loongarch: Implement xvaddi/xvsubi
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-17-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-17-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 01:31, Song Gao wrote:
> +static bool gvec_xx_i(DisasContext *ctx, arg_vv_i *a, MemOp mop,
> +                      void (*func)(unsigned, uint32_t, uint32_t,
> +                                   int64_t, uint32_t, uint32_t))
> +{
> +    if (!check_vec(ctx, 32)) {
> +        return true;
> +    }
> +
> +    return gvec_vv_i_vl(ctx,a, 32, mop, func);

Move check_vec into gvec_vv_i_vl.

> +static bool gvec_xsubi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
> +{
> +    if (!check_vec(ctx, 32)) {
> +        return true;
> +    }
> +
> +    return gvec_subi_vl(ctx, a, 32, mop);

Likewise.


r~

