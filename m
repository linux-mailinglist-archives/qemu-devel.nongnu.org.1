Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 117AE781E59
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 16:44:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjex-0005jK-O9; Sun, 20 Aug 2023 10:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjev-0005it-Cc
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:44:05 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjet-0001dG-5y
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:44:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a3c555378so540522b3a.2
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692542642; x=1693147442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ym4HCUZ/enpGumG5sHGUTcfP57BLYfqtv+Zw8m93K0E=;
 b=fmmQukcsyPWcRL8c15clB45FuOJbaPmicQI/etrNANSLe8/JtkBTdXP43xaqJs/CPI
 dkSBOhy3GVENXn9zANxalod7k/dkyggOb7Ug2MNp/F18NKO/TULq7SlwbpWqP5QLDmAp
 2zc6+FxhEnSridhjHJ0JZ8owOgiIfI3hUD1woXmOulCKMpi02dblhdv6j0DXMETxcEC6
 vB8ANfFh2vZbuLNfNqlPI3twk6EmoGyUPvLXCp8Zg8DqDghXdNxU9mxyNkvcI8fnaan+
 9QA55LVsvC4GVmVKi7f0OK+uSC5Vf+40/WJd08a8ogL/DInKtcK4ReEGpWtuXSu/S1nd
 2j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692542642; x=1693147442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ym4HCUZ/enpGumG5sHGUTcfP57BLYfqtv+Zw8m93K0E=;
 b=HYtMi6z8q+MX8ssRQDf4pb3ODpZY+WLfeJeDxicrw9yzgQZNRMM+R2u40acc3yct/p
 mQuZgzTb4QU/s4Lpt+9kjT1L2NXVQTvULDT90YnMvjY7RDTffSqxEUoTv9SianVQ6KeD
 +uf26KTdUo4wcrnKCUtjRyHICwtokcV/kX+PwX5Vkir5jG1xZswbgRb3U8m/TT9sJVqk
 rxdG9m2rt6wKHFh/GFXAhmO0SjwqYINdhbzIokhRWJss6GoP/HHHao4TpCrfz6LtOMo1
 N1WgPBHrvBBX3N9xqFep2by/cL6h6yCff+gq5dDlbdixt5WG2JQXLVC/VqzbewgBFV4O
 Hc9w==
X-Gm-Message-State: AOJu0YwgsMB1Y0fR+hrOHUkjcwUYyb4Lgn7tykBjpeEpOUPLEECkoBjq
 tyDCiJXitqoFr6RnBvEWziYdLt24D4DHk9Wpvbs=
X-Google-Smtp-Source: AGHT+IG5mEsVpFqFxhoAW3IUY1utO1uZyoloM5I3NZtezlkCd38CketjfkhcQivl4TEqQJy74ZSkUQ==
X-Received: by 2002:a05:6a21:6da5:b0:138:64d4:b055 with SMTP id
 wl37-20020a056a216da500b0013864d4b055mr6200071pzb.55.1692542641762; 
 Sun, 20 Aug 2023 07:44:01 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a63aa0b000000b00566095dac12sm4768303pgf.19.2023.08.20.07.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 07:44:01 -0700 (PDT)
Message-ID: <413ed4db-0908-4197-ecb7-1069a152c74f@linaro.org>
Date: Sun, 20 Aug 2023 07:43:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/22] Implement mlock(2), munlock(2), mlockall(2),
 munlockall(2), madvise(2), minherit(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-16-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-16-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:47, Karim Taha wrote:
> +static inline abi_long do_bsd_mlock(abi_long arg1, abi_long arg2)
> +{
> +    return get_errno(mlock(g2h_untagged(arg1), arg2));
> +}
> +
> +/* munlock(2) */
> +static inline abi_long do_bsd_munlock(abi_long arg1, abi_long arg2)
> +{
> +    return get_errno(munlock(g2h_untagged(arg1), arg2));
> +}

I think these two need guest_range_valid_untagged.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

