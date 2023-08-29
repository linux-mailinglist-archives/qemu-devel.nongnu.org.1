Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D078D081
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nq-0001ZC-Rc; Tue, 29 Aug 2023 19:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb52P-00048t-Q7
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:10:09 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb52M-0000vb-Ap
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:10:09 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso30284325ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693339805; x=1693944605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HlAGwGxAsjXZMRdJZtOIudPajq7mkqZA0jaJ7GPimSU=;
 b=lFyvcxqiIMGdXGMzRCiuoda6PLQBiEWh04qWeJtOjQlVeTcA7yeXD9AxXdulU9JQtV
 s4QOkaCNnl20ep+c9eu3nX13dr96CeO1fvbRLAVxlEe9sw9UGfhc4PhChapRSBeSvZGo
 TVIMoW9a2ADWOYRUN9d2SCBGCEjU0GIyBunyFz1Lnc3JQhGK5ttYDqtWZoqxVnIWt/pg
 v2IvDcY4CpS7JPryE/CUha5rWvhecPiGlXf6raPr+M6L4PiPnBLmXI4RgyZdvuhGNDt5
 CQBwSk5EINZsznFfnJVZiBYpWwDJK9gTP0cYJBln21EQFC6wm5GwbRIeebjPmnoCZzrt
 IJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693339805; x=1693944605;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HlAGwGxAsjXZMRdJZtOIudPajq7mkqZA0jaJ7GPimSU=;
 b=JzsS92I2VJtmiWf5/zleKHWPOcDEXyMEhI9HOd6iaEheA0mMXxY5uBDxThFKBsqXpz
 LQ9JFbcCxr7LAOFv+FdUOlslSg67/Qax0HzzvCS+ZQRKuEpGoPY4c52Ta/ckavfmz8yZ
 ppC+piGtIs24NMRLeC2nUXVnXuV5sheiYpSx/rjgGFlSM5HWYlJ9sYGsq4bnRuBXnG1i
 XD3eIqRcyNmM5k4IpSK/O5g3e1psPewQG/+qhXiT4nGaU+ax+aZ8kAg//5OXVransg3o
 KuIvahAZzk+mnvzuNSs4nW/s7/OcB96yGcIh2D1ExLyfhNSe9+LADcBq+QU8Cloi5Gna
 fh5A==
X-Gm-Message-State: AOJu0YywKVHtMtCpnuaz7mjE9KFB1Vf3H5RnaJZEKVIqjIGCK8XrY+Lz
 lGvOXUTVsMoG6prnBmRKfVeumQ==
X-Google-Smtp-Source: AGHT+IECpaNI+cMF1KT9VBBfdTuMWxal/h5Ec8Aa9jvsbx75HunPc90llwZJmAZREmcDbaHPKci+JQ==
X-Received: by 2002:a17:902:bd45:b0:1bc:2c79:c6b6 with SMTP id
 b5-20020a170902bd4500b001bc2c79c6b6mr132969plx.28.1693339804891; 
 Tue, 29 Aug 2023 13:10:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 ja11-20020a170902efcb00b001c0a4146961sm9816932plb.19.2023.08.29.13.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:10:04 -0700 (PDT)
Message-ID: <f040037b-8f98-98e0-7443-0ca46872e76a@linaro.org>
Date: Tue, 29 Aug 2023 13:10:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 19/32] bsd-user: Implement getpriority(2) and
 setpriority(2).
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-20-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-20-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/27/23 08:57, Karim Taha wrote:
> +static inline abi_long do_bsd_getpriority(abi_long which, abi_long who)
> +{
> +    abi_long ret;
> +    /*
> +     * Note that negative values are valid for getpriority, so we must
> +     * differentiate based on errno settings.
> +     */
> +    errno = 0;
> +    ret = getpriority(which, who);
> +    if (ret == -1 && errno != 0) {
> +        ret = -host_to_target_errno(errno);
> +        return ret;
> +    }
> +    /* Return value is a biased priority to avoid negative numbers. */
> +    ret = 20 - ret;

This appears to be a linux-ism.

There is no such bias in sys/kern/kern_resource.c, kern_getpriority(), but there is in 
sys/compat/linux/linux_misc.c, linux_getpriority().


r~





