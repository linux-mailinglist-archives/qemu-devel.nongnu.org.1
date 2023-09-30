Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587647B41D8
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 17:48:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmcBB-00081c-Ju; Sat, 30 Sep 2023 11:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmcB7-00081B-CS
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 11:46:49 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmcB4-0004TD-TU
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 11:46:48 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c3d6d88231so114372345ad.0
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696088805; x=1696693605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4i/dVky4GQ65lLYWZ6jft2bDIFtC58OGTh7f/UnV+lI=;
 b=b2Jrz3QdvSxxv8YyPQC96pxoH3cTe5tMmty6Wc52KWpwNW7sx9GWZp8NuL5NOHwbcW
 YZ4g5IrupdQz76MUD64a1oBuxC+HZJq1+g3ZV2Ej9ec2ALiD1/VDs21ZteEGCi+jXmx+
 FRCyBX3QfF3E5CTqysNmoEqPbXg/fE8VcDe8CISM1sRA0b7zLwGrxSKlslsJNmzR3m2x
 y44P0ngalgxERl5K/qoU6elwfCTu8yCj7GQ5Xu+QDWzm+Yt34Ebm3e0rSE/1XBNgghyw
 AQODrmxGIQ1fN8wOBSZ3Oy8kzvqqOab2t6TFeM7FqJK4m3XV2X2z9GbDnCRnKYnG9Rru
 8qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696088805; x=1696693605;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4i/dVky4GQ65lLYWZ6jft2bDIFtC58OGTh7f/UnV+lI=;
 b=c9v7IQKFDW7V09EQfIyG5dhriKtS4v1AuuOt0TD7VK2bp1S11ezFpXVPQoTnKuxhCv
 svTH2jBTQqgNXsjyBcrtsdI2PW+VH+i7zUlH0fnVemODgNUjkACJvEdTvHGXejzTY29B
 5YQHpqGYIsTiT3OTPW0K65YzTmBPeOKlvFv1L6sHl7kXiYYIndcg4QTWlWvGCRW5Pv1b
 xReaU6b477/HSYJz5Fy86J6kPDHwjpMc+9E8dtRQQB/1henOpAAUg+ImoQW975Dh9D5X
 GUrFszkYy0+B85K8tY4knPxP+a7OaH6IR8RHf6CFw/iCjhaHY50K59yO7GZDjzhySfh8
 JsVQ==
X-Gm-Message-State: AOJu0YzVCM6K3dMTJJuXbrUKzB/vZwaPSwTWI157GeXs0Z7qSvJQGily
 Le/NltSmw0CioWzG9CxTzzJE+A==
X-Google-Smtp-Source: AGHT+IHWt+K+x017X5EQkY6upYF7ibdqq+vbUGhBasq3V72uWZkXGf4biCFC5Ob/HRXcpU/ChjyMzA==
X-Received: by 2002:a17:902:ea0a:b0:1c5:634e:e12c with SMTP id
 s10-20020a170902ea0a00b001c5634ee12cmr7912864plg.37.1696088804886; 
 Sat, 30 Sep 2023 08:46:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ee8600b001c55db80b14sm3026445pld.221.2023.09.30.08.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Sep 2023 08:46:44 -0700 (PDT)
Message-ID: <8c7e0e7f-9196-cc91-be1e-ce0b02fb4db9@linaro.org>
Date: Sat, 30 Sep 2023 08:46:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/loongarch: fix ASXE flag conflict
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230930112837.1871691-1-c@jia.je>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230930112837.1871691-1-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.587,
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

On 9/30/23 04:28, Jiajie Chen wrote:
> HW_FLAGS_EUEN_ASXE acccidentally conflicts with HW_FLAGS_CRMD_PG,
> enabling LASX instructions even when CSR_EUEN.ASXE=0.
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/1907
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   target/loongarch/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index f125a8e49b..79ad79a289 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -462,7 +462,7 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
>   #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
>   #define HW_FLAGS_EUEN_FPE   0x04
>   #define HW_FLAGS_EUEN_SXE   0x08
> -#define HW_FLAGS_EUEN_ASXE  0x10
> +#define HW_FLAGS_EUEN_ASXE  0x40
>   #define HW_FLAGS_VA32       0x20
>   
>   static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,

Better to put all defines in bit order, otherwise it will be easy to make the same mistake 
again.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

