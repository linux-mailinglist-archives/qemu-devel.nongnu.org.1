Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2741799C45
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 03:52:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf9c9-0001pn-Np; Sat, 09 Sep 2023 21:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf9c7-0001kP-6h
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:51:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf9c4-0000QT-Vx
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:51:50 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so22313455ad.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 18:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694310707; x=1694915507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f5bKUdBh65WQvPHIihmjR5IAPl7Af7GWsFIxUZTJqm8=;
 b=Pmk7QAk7VJuFNHBt66QYx2cHkyZkMy3kR07m5DkLTlfkKjlT9KG2g650x1hLCMuDxF
 tBcS5dAFZHW8KuEeAvZOZHmHMa34bZPF4W54iS2WMZhgTdfDi5BFQVg1ncZMc75giw/y
 oSb7M/0HKK1RAghU9R/hQT3hAAG7f4z4+CU49qiCbEnFROQ6hfQ5c33oE/l4mrTmdn90
 VZG5Oi6Jw/5nEAgVa5Zxp68SHactg+DrQsj/Jy+4c0p/kkZYOjGyw8JDooq7PH7ENEB8
 /6e3bqVSbI3rP0LFniFyARvhMnpX+WdfsX9cp+ihlBP0iI67fPMWoEckyRNNJew5Z4/E
 6IUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694310707; x=1694915507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f5bKUdBh65WQvPHIihmjR5IAPl7Af7GWsFIxUZTJqm8=;
 b=W0NC0bVxwNnhYKMRp0lSyUYYqW//M/cLxsa33clwy8L0SiX71BWCfbVyI8E0tUIcXa
 z+o/wamEjrbVnWteDp/4R16EirWBWv06rpqDT7Q4M8VY6OyJ73Zx/9CshWX06hZ0bEhd
 d+/vaNk9BB43KQkcYA0UScOsawDtMhEyaVu3bQezfsK4qpQuX/lwIfm1lq5IWh81XbWp
 4f+KJYEZg488Jih9Ex1C0pR6j6qo4xRPz5IoJFENNddsZojUP9ImQ9wZ4m+ygl/F7wef
 xGvoMX/TlrCpOST33gC09zkfJIpYL5yJwCEvoaxA9JyQh7BuioZR0Mg+GHX8MP2KNU0/
 SipQ==
X-Gm-Message-State: AOJu0YzVPqS4JmB3pLTEH5WAfZoI0de0ZWMTRnWN3FRgX7C3W0g9PvMp
 EPKI54ZLYcq9TtgqzeM90ZgQiQ==
X-Google-Smtp-Source: AGHT+IFPd0xk6i2fZbs6yVuEl9to1//Fu/yM7AN+4c7MHnJsu6rqchdC44jPN1Ck/3gKePXSnKOARw==
X-Received: by 2002:a17:902:e80f:b0:1c1:e818:1e76 with SMTP id
 u15-20020a170902e80f00b001c1e8181e76mr8437010plg.6.1694310707510; 
 Sat, 09 Sep 2023 18:51:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a1709027c8d00b001a98f844e60sm3795793pll.263.2023.09.09.18.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 18:51:47 -0700 (PDT)
Message-ID: <8afb57db-bc8a-1e71-4e08-1190c3be57bb@linaro.org>
Date: Sat, 9 Sep 2023 18:51:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 17/57] target/loongarch: Implement xvneg
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-18-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-18-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
> +static bool gvec_xx(DisasContext *ctx, arg_vv *a, MemOp mop,
> +                    void (*func)(unsigned, uint32_t, uint32_t,
> +                                 uint32_t, uint32_t))
> +{
> +    if (!check_vec(ctx, 32)) {
> +        return true;
> +    }
> +
> +    return gvec_vv_vl(ctx, a, 32, mop, func);

Move check_vec.


r~

