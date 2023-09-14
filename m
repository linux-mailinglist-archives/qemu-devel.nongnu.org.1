Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3179F884
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:04:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcd3-0002QZ-0P; Wed, 13 Sep 2023 23:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgccz-0002QQ-6Z
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:02:49 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgccx-0005SP-Jn
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:02:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fb71ded6dso380562b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 20:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694660566; x=1695265366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6WaXcshO9LheQl7jvOccWwzmOJ79QVe80wvS9jBKDvg=;
 b=aTnl6QRVcRhLcbDWZKreQ+ZBnc55SFnmVr8LRcLNdb7fjHcS53NYqgg2x6Nqrn/mG+
 7BY56jVNeanus12ZYjDXpUqoj4WO1Vd1wJSyHiejHpYFJp5k6wc1ThP/HQ0VXLmGXWuk
 hyCsP5+05G1wCLEJn0XG0m7DEa8tjGkuSAG+E+XainIkSUnvP1MK6Rs+2uFDprQyA445
 jqEVGmOmyHt3bcV4YqRxvTapPhVY28TvOpP0707MghcdH+phpiOBiQ5CW0MkbudwLeNn
 fe6AxPNVVPE+lDp+eVfUaHZkE9ETaMWLbrdpy45ZAJGcdFHCyB5YTLTKcX5kByOyc0+R
 /Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694660566; x=1695265366;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6WaXcshO9LheQl7jvOccWwzmOJ79QVe80wvS9jBKDvg=;
 b=CvWkM6hWQXe0mCPFo4U1BOcmNKSsSI2MJeXfRoPKF4keyn7crKOHBbZEeX/5Ml6fKd
 lGE4jbh8st3QryUssDfjuJMJXPnzbsneqlMSnDSYphXyV+Qr8rGJyJ4ualp3TQOy8w71
 /nB7UbqC2QWagH2CP5EPIexLaY8XGcJLEZ2HaXSueT2kHk92+5XUr+QOnSPVQVSX1/gQ
 3P5PJ+mnN40fm0eft6NEfbixlx1DWlcM+sdw06UveaMTN40MJ0LZo2Ug/MbDsHdjnhJd
 gZxLPUpxp8zROMDh7PQugdz1Ztxv1GgmFPk0LCMMiijD1wnxyKTYYFU+o9hZvHDLP0+M
 BzVQ==
X-Gm-Message-State: AOJu0YzFT3w0Hs2tjKo+RKVX17eU13mkNiaE/2tMHdRgUialga0Od9pw
 L9qsje4ODFykh1bdWf07L4oYObqzb3/2C9AIxdI=
X-Google-Smtp-Source: AGHT+IFRo/gHEKk9oT3vjgX6CLxfzVdt/vbYagWEOl7jwszuWWerurEaDoEcDg+75lruvk7Ae+lWNg==
X-Received: by 2002:a05:6a00:1504:b0:68e:2f6e:b4c0 with SMTP id
 q4-20020a056a00150400b0068e2f6eb4c0mr5276926pfu.28.1694660565875; 
 Wed, 13 Sep 2023 20:02:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa78dc4000000b00686fe7b7b48sm252474pfr.121.2023.09.13.20.02.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 20:02:45 -0700 (PDT)
Message-ID: <2643cbdb-e73e-644a-3052-5a1867434b5b@linaro.org>
Date: Wed, 13 Sep 2023 20:02:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 51/57] target/loongarch: Implement xvinsgr2vr
 xvpickve2gr
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230914022645.1151356-1-gaosong@loongson.cn>
 <20230914022645.1151356-52-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230914022645.1151356-52-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 9/13/23 19:26, Song Gao wrote:
> +static inline int vec_reg_offset(int regno, int index, MemOp mop)
> +{
> +    const uint8_t size = 1 << mop;
> +    int offs = index * size;
> +
> +#if HOST_BIG_ENDIAN
> +    if (size < 8 ) {
> +        offs ^ = (8 - size);
> +    }
> +#endif
> +    return offs + vec_full_offset(regno);
> +}

Merge the #if into the if:

    if (HOST_BIG_ENDIAN && size < 8)

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

