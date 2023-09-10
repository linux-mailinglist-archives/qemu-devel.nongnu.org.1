Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B4F799C40
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 03:45:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf9Uk-0003bR-QG; Sat, 09 Sep 2023 21:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf9Ui-0003U2-H9
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:44:12 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf9Ug-0007OG-DG
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:44:12 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6c0bbbbad81so1887871a34.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 18:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694310249; x=1694915049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z18q1ug+Y8kEKBvkdX8zno2WKu7UiKmhziwdxRtDPnU=;
 b=FTyIIjhvaCk51A17Gi1hv7ihCJlPM97ZxVjAu1l5mX2+D5rRE4FyM0RPD5jfJFlj+M
 ur8soB/RWiImYkmx4BzEay9aAPDCLlIaWr9HMSrQpTW9DfbkvMH39rY/LDiJ4S5dIoHt
 cidFccxOBaezmSSPjPTGCAbqmeGd9e7+tv99D3Hz2bpJDf+iEJj0l6AmdZHQTtYGnizX
 GwsZDIqt4eyaxjdFOZGD5Hto5wq7xdrTWjU7k1FZ+3GxE7/+pOtveiZXMhqBkwzJltTX
 xblY01FNbW/MZ8AGuDwFzdSOnu0k2ezbmKIBnK+GngUJBuKgCHHdbxy4t+CkEd9yzrxm
 9dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694310249; x=1694915049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z18q1ug+Y8kEKBvkdX8zno2WKu7UiKmhziwdxRtDPnU=;
 b=kbxbflBnpMNcPV3tqG/FmUCAM8Vn4Sqo4eTWijKIlRCLU7NNWlzOUJHNPtdeM2P2G6
 7aZexHVxbHXiw5X79Ex9VrCDHkQ0jzAy9zHPsbq+OqcFQZCld39P3zrcvcK715vcTEVd
 QN/j9iM4U8CLs60m5IuakLw/oiDU8FsPK93JF4ClF5iw8tqhkgp56hMT+BgztYWB3BCm
 iCmbu6lO+LWuqBs5tEW9ElEP04WMev9utByMFX2szObIyginl55sm9bDrF5T9YI/m9Bg
 O28rwxBUnQTrIRUVu3BpcJKGUjGk5rt8M9YxVIoPo9xyQS9LTOFPOCmsC6aONI9keEkg
 r44w==
X-Gm-Message-State: AOJu0YzYCM/+KH+Bh75g4ECBKjKtQUrWXwsloYsh0lQIXyUMvAxi/yNC
 5xDgNgY6WT3LIPQkPyg6/Wl1/xV2nGZ7Gvrawlc=
X-Google-Smtp-Source: AGHT+IG9Ke+lPR5n6jdOMgpeuA3Ot3YfFMJnQ6zjdzGpTIziUGQ6/SxXoKemYnsSryfMkRIEPAzkeg==
X-Received: by 2002:a05:6358:52d4:b0:139:d24c:ed28 with SMTP id
 z20-20020a05635852d400b00139d24ced28mr7503539rwz.12.1694310248983; 
 Sat, 09 Sep 2023 18:44:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170902d30300b001a95f632340sm3828891plc.46.2023.09.09.18.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 18:44:08 -0700 (PDT)
Message-ID: <24a9ba29-e6a0-2f97-0b5a-de0adf5680cf@linaro.org>
Date: Sat, 9 Sep 2023 18:44:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 14/57] target/loongarch: Implement xvadd/xvsub
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-15-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-15-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
> --- a/target/loongarch/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/insn_trans/trans_vec.c.inc
> @@ -208,6 +208,16 @@ static bool gvec_vvv(DisasContext *ctx, arg_vvv *a, MemOp mop,
>       return gvec_vvv_vl(ctx, a, 16, mop, func);
>   }
>   
> +static bool gvec_xxx(DisasContext *ctx, arg_vvv *a, MemOp mop,
> +                     void (*func)(unsigned, uint32_t, uint32_t,
> +                                  uint32_t, uint32_t, uint32_t))
> +{
> +    if (!check_vec(ctx, 32)) {
> +        return true;
> +    }
> +
> +    return gvec_vvv_vl(ctx, a, 32, mop, func);
> +}

You can move check_vec into gvec_vvv_vl, removing it from gvec_vvv.

> +static bool gen_vaddsub_q_vl(DisasContext *ctx, arg_vvv *a, uint32_t oprsz,
> +                             void (*func)(TCGv_i64, TCGv_i64, TCGv_i64,
> +                                          TCGv_i64, TCGv_i64, TCGv_i64))
> +{
> +    int i;
> +    TCGv_i64 rh, rl, ah, al, bh, bl;

Have check_vec here ...

> +static bool gen_vaddsub_q(DisasContext *ctx, arg_vvv *a,
> +                          void (*func)(TCGv_i64, TCGv_i64, TCGv_i64,
> +                                       TCGv_i64, TCGv_i64, TCGv_i64))
> +{
> +    if (!check_vec(ctx, 16)) {
> +        return true;
> +    }
> +
> +    return gen_vaddsub_q_vl(ctx, a, 16, func);
> +}
> +
> +static bool gen_xvaddsub_q(DisasContext *ctx, arg_vvv *a,
> +                           void (*func)(TCGv_i64, TCGv_i64, TCGv_i64,
> +                                        TCGv_i64, TCGv_i64, TCGv_i64))
> +{
> +    if (!check_vec(ctx, 32)) {
> +        return true;
> +    }
> +    return gen_vaddsub_q_vl(ctx, a, 16, func);
> +}

... instead of these two places.


r~

