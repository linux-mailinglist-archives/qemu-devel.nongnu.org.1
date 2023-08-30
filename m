Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B0878E126
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 23:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbSNn-0005d0-AF; Wed, 30 Aug 2023 17:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbSNk-0005ca-Ee
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 17:05:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbSNh-0006gH-BB
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 17:05:43 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686be3cbea0so921322b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693429539; x=1694034339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DsLXIsBXD6oXEMxQCfRfTOByE9woxL4AbrG+SHCNWp0=;
 b=O8HtEcq7Z5OpV3O9F2sh3zbr7T0qD21KVTQeKg9uJeNpC2YzSvi9PHswuv7TjksheS
 ZXqhzOgTUTWbbB4z8CRAhIHnw+medzMGLo8o04atfoSOH3lqs2/gx2Ak6pkTJ4EC+eSP
 jQcOkUZZoNBGqUnaNVbEqrbY3g/eh31aQPmEb+KcLpcxSlWUfnhk/V7UKd9aCPfsjuJP
 97t8tPQiCLfb4qX+q9SmTxE9N0D8r/yp8xR5hcQ7VJhv0iwZg7vzIiB8QHSr9KOyfwV6
 XPdji7S3A3lxnbwanZeJBGOjpi1wsxBv5Etmgf2nf3tTJczgUEOMNhFz8J+GIHDLl5IW
 FpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693429539; x=1694034339;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DsLXIsBXD6oXEMxQCfRfTOByE9woxL4AbrG+SHCNWp0=;
 b=kXhAT7hVWoXRwx9GMG/ml50ujwBkVR0rDKFBtrZy/o5GJF3YhJbsfAdyX7UR2abylx
 Vp2ws5BT54k2MGeWExLhscaDqg+fc2Z880sdFTAhZMepwp5Lk/DWjCSq49l+XyZss5/B
 Zfjy0bSBVE1WK96B2rm3h3WdXT88MZS80ODrFoIdWajLC3qjdFXVSNdG9M9+d7tLESro
 t/IoXlK8NYoQdlxRZYZlcrnOwtLiE6d6C2xQYR5uZqvvfcPhFQZSCM7ADPmNiEBil1zM
 I7G0gEVbVl5/10yCkvEooftYmKHIa3yfZ4+AG6kr7aT5ASNDKuGbLjOsSlAXLGTAIAcO
 FWUw==
X-Gm-Message-State: AOJu0Yxr70IZZE1pY5VgrE98UbZtZr8NDDKAR44IKWkNX6IYjx//kT+M
 IkUH5pZEXqsF9G//aEWrWm+ySzJ3ggD7UVd8BN0=
X-Google-Smtp-Source: AGHT+IFSF/5Tx6vnRhKCxY7hcnPnjSSywtzPpXwq/+ySNGLXktXKCksij30C5iZzWX25dQvcKXTXMQ==
X-Received: by 2002:a05:6a21:9991:b0:140:61f8:53f6 with SMTP id
 ve17-20020a056a21999100b0014061f853f6mr1044895pzb.29.1693429539478; 
 Wed, 30 Aug 2023 14:05:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 e25-20020aa78c59000000b00666912d8a52sm8657pfd.197.2023.08.30.14.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 14:05:38 -0700 (PDT)
Message-ID: <86f50969-45fb-03f5-01b8-8f96cd96c4c1@linaro.org>
Date: Wed, 30 Aug 2023 14:05:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 18/48] target/loongarch: Implement
 xvmadd/xvmsub/xvmaddw{ev/od}
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-19-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-19-gaosong@loongson.cn>
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
> - XVMADD.{B/H/W/D};
> - XVMSUB.{B/H/W/D};
> - XVMADDW{EV/OD}.{H.B/W.H/D.W/Q.D}[U];
> - XVMADDW{EV/OD}.{H.BU.B/W.HU.H/D.WU.W/Q.DU.D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/vec.h                       |   3 +
>   target/loongarch/insns.decode                |  34 ++++++
>   target/loongarch/disas.c                     |  34 ++++++
>   target/loongarch/vec_helper.c                | 113 ++++++++++---------
>   target/loongarch/insn_trans/trans_lasx.c.inc |  38 +++++++
>   target/loongarch/insn_trans/trans_lsx.c.inc  |  72 ++++++------
>   6 files changed, 203 insertions(+), 91 deletions(-)
> 
> diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
> index 6fc84c8c5a..06c8d7e314 100644
> --- a/target/loongarch/vec.h
> +++ b/target/loongarch/vec.h
> @@ -62,4 +62,7 @@
>   
>   #define DO_MUL(a, b)    (a * b)
>   
> +#define DO_MADD(a, b, c)  (a + b * c)
> +#define DO_MSUB(a, b, c)  (a - b * c)
> +

Aside from this movement,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

