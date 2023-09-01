Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 442747901B7
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 20:00:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc8Q9-0001lK-5s; Fri, 01 Sep 2023 13:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8Q0-0001l3-GS
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:58:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8Px-0004Jr-G0
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:58:51 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bc83a96067so17645155ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693591127; x=1694195927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VZwJAACfQsKzWAlLssfeF3lrYpXD6sRvpYOClPkV8NE=;
 b=hwFl7X8Mcc5NmAmys934rITG765SNOHpFJBC341rBUP8KdYmTVDtYNVyLigk+Evtvg
 yAik9vItTRAQ+gv5LcN54EUW922aXEDJp893Rue56FxU9NvwWtynEVHqjwy27va9O9Ek
 I+6TFlfnNXF8LSZd8R4QNm1jAfecpf20HigJc/jmwxPftzCTqvwXx4NCRRduFCa1+GuI
 lJ3fgJew+47tX4qCG4XMCMIJR+AyWYbTEHbM9o8Bu33wzx9VO97uIWIJzdZAGgwPV9oA
 Z8RstemGUpxOX4d4BFLzJAySiJPW9E6IkTlksrHP7xnOPzQ83wqEBUTC7aQoi2DfVMo5
 iGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693591127; x=1694195927;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VZwJAACfQsKzWAlLssfeF3lrYpXD6sRvpYOClPkV8NE=;
 b=VSJwIsMsqY5ni570nHV6e0QGBUXQYMi5a7iAlNExDz+QZcOzPMqxYtxoqqw3dsckXs
 fManjMPXWCEomb5VTCkDR2VvbJAcpsRedS8Z6rCZ+yW/HRzcj1sxoVDMuywv2HnyHX5r
 3R9tBivnl1ULlJqUiNWYGIzVeTC5HrKSrs+jlyw2MPrBsNdfJpXZDkva18zyb2gFg1ZT
 +LK3oFgM9vPd76OL97WSH1CACQqgYTrbyu/qeu5lL/P7LIFB42QzKBUFSt0xGRd/vSVz
 Xk9jVyUpQ6NTE67tQv4ebrr1Cdz4ALWOCtSNSjY2WC/GqeiiwvLBCscKwlj/cBhtRFEH
 SE5A==
X-Gm-Message-State: AOJu0YzTJOpfPKpYQiOW6QwkXGWYgxsRJIwQIB50atjoCiwhGiS23/Qa
 Kmd1q1kuL5C2Cn5ClFWxP5k/Sm3NydI5XIZVAPw=
X-Google-Smtp-Source: AGHT+IGss2z0ppEdD5TwmArhPYpMiMjjLTBox2QjG//I/jGryOtMQH8mjGU0kqWrMxk1jGJG7aCW9A==
X-Received: by 2002:a17:902:e808:b0:1bf:70be:ca8b with SMTP id
 u8-20020a170902e80800b001bf70beca8bmr4318430plg.43.1693591127658; 
 Fri, 01 Sep 2023 10:58:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 9-20020a170902c14900b001b8baa83639sm3269063plj.200.2023.09.01.10.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 10:58:47 -0700 (PDT)
Message-ID: <baa586b4-9cca-f0e1-aa85-775cbb02a7bb@linaro.org>
Date: Fri, 1 Sep 2023 10:58:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 04/14] tcg/loongarch64: Lower add/sub_vec to vadd/vsub
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230901093258.942357-1-c@jia.je>
 <20230901093258.942357-5-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230901093258.942357-5-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 9/1/23 02:30, Jiajie Chen wrote:
> Lower the following ops:
> 
> - add_vec
> - sub_vec
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>   tcg/loongarch64/tcg-target.c.inc     | 58 ++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
> 
> diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
> index d04916db25..eaa015e813 100644
> --- a/tcg/loongarch64/tcg-target-con-set.h
> +++ b/tcg/loongarch64/tcg-target-con-set.h
> @@ -31,5 +31,6 @@ C_O1_I2(r, 0, rZ)
>   C_O1_I2(r, rZ, ri)
>   C_O1_I2(r, rZ, rJ)
>   C_O1_I2(r, rZ, rZ)
> +C_O1_I2(w, w, wi)
>   C_O1_I2(w, w, wJ)

Similar comment with respect to the constraint.  I think you may be right that we need to 
improve constant handling for vectors.  I'm willing to work with you to improve that as a 
follow-up.


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

