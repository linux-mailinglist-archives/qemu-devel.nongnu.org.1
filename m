Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D02574B873
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 23:05:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsdh-0002r8-Nr; Fri, 07 Jul 2023 17:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsdd-0002p3-Lv
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 17:05:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsda-0003ao-Kc
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 17:05:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so26353425e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688763908; x=1691355908;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wUHzCX1IjeRzwubvLnfFZNGs8r7jB6hAq/T4KfZHZCU=;
 b=W40Uv0yQrW5MncnMdORPxGaVdRkbPx/xn03jmgBzcvUiWT65V1z9+Ut2ZHfKvY/rl2
 tqC5ZyqMDtT6r5lrYoHVb2Hl6WyQ5EvbbW/bAFR03YRsJA4iO4G1/JbIKRNVgZaamnaz
 toZGop9O+2OzVxXrv5Nr7SHNiK00GVGMWH3Yc8gqVvDBQdrsPWSmgFT2UOkHaIwAwoUE
 QMC6sgTNoexqlSOfaldbzrSBmajwimtNcQKvBlffuT9ZRAO0fDSBd++9ZRZEbzeW8tZA
 /21qrfEkEum80/KcTG6/Cy7OqWFoWVmPLUX09XqRt+vnlJ44wdlqalDQm2lfcrZejN8d
 wbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688763908; x=1691355908;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wUHzCX1IjeRzwubvLnfFZNGs8r7jB6hAq/T4KfZHZCU=;
 b=gjfCSfJPXHWuUigwlj9hfBZIWY67X1ryHynvaRSXwDbJtzWbxKhS9JVIYAJIHhz2Be
 xQNR4iB2D3TASgINgyhtjAEGlCwm0owMtKxPUbXQPwKSC/MDu8Sh/JYSQ/yDdzc920rV
 xxxPis1OeZUeBIXL0MhgfR5rhO6eYKZTUx8XySnSw40oP9pAbGsM9MEPfaT8wAuq0DKs
 LSn+j6Q9LzEeQJ7uOw/9IIpPc4qtbXUqY+9brmX57D5uxHxKKGghOZJUmMpeSUwoS7WC
 mipb2jDivEcCJtnmm/4lfzuXZjYkYAqz1ScKixy9//7svgTvUeSwP76TRkrUxc0tYZS7
 sWpg==
X-Gm-Message-State: ABy/qLa51tIZOBAliU9AittKLUzjKEE86BQ1E0IfDdSkccK5URDBAln2
 tIHtaYYElwe/zxjKLgmOZuBwRIPOTh6AitdLybqQFw==
X-Google-Smtp-Source: APBJJlECq/GjA+K03b7VhwtjBtDwGqOxnAhpSKiggadw7vjDE/Bj27oiaFgA2f9MZpWGvPwV7Hhu4g==
X-Received: by 2002:a7b:cc9a:0:b0:3fb:40ff:1cba with SMTP id
 p26-20020a7bcc9a000000b003fb40ff1cbamr5413772wma.6.1688763908496; 
 Fri, 07 Jul 2023 14:05:08 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a05600c218400b003fbfea1afffsm2773913wme.27.2023.07.07.14.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 14:05:08 -0700 (PDT)
Message-ID: <93899cda-7a75-266d-da7b-b76829f1071b@linaro.org>
Date: Fri, 7 Jul 2023 22:05:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 19/46] target/loongarch: Implement xvexth
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-20-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-20-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 6/30/23 08:58, Song Gao wrote:
> +#define VEXTH(NAME, BIT, E1, E2)                            \
> +void HELPER(NAME)(CPULoongArchState *env,                   \
> +                  uint32_t oprsz, uint32_t vd, uint32_t vj) \
> +{                                                           \
> +    int i, max;                                             \
> +    VReg *Vd = &(env->fpr[vd].vreg);                        \
> +    VReg *Vj = &(env->fpr[vj].vreg);                        \
> +                                                            \
> +    max = LSX_LEN / BIT;                                    \
> +    for (i = 0; i < max; i++) {                             \
> +        Vd->E1(i) = Vj->E2(i + max);                        \
> +        if (oprsz == 32) {                                  \
> +            Vd->E1(i + max) = Vj->E2(i + max * 3);          \
> +        }                                                   \
> +    }                                                       \
>   }

Better with void * and uint32_t desc.

So this doesn't expand all in order, similar to x86 AVX and arm SVE.
I believe the way I handled it there was

     ofs = 128 / bit;
     for (i = 0; i < oprsz / (BIT / 8); i += ofs) {
         for (j = 0; j < ofs; j++) {
             E1[i + j] = E2[i + j + ofs];
         }
     }


r~


