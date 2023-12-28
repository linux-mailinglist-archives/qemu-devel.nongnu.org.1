Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FFE81F37C
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 01:51:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIebk-0007h1-N8; Wed, 27 Dec 2023 19:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIebi-0007fq-ID
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:50:42 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIebh-0000dl-0N
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:50:42 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bbd11b2f95so85269b6e.0
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 16:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703724639; x=1704329439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vp+Cm8HKjEyUq3bujwbmIxuUl7dQekI6ibEjoDWkgRc=;
 b=xz88+UlSgMIV7uc28Q8dChMZfeetUt2Mz5TczyASdII0I2qVEtT8tLGT2fQ3Ashs+c
 R8P7HCUhXdXjn7edvrABIGTXMhfm8FOc+WPi6cpVmtlDubJjxtncSuVJLk60j4QRN0Ov
 fxpFS9yXgtUW0hhG7Ka2IVK2Fru36XpMYEZHkdtEHHpHwcAIFUbouorq8O7UwuwiyaUY
 V0tAVKpJXrDI/6Tx+vykvAHOfciWWW6g4S0IochxadZJ3nj5V69PPho1zkFzR6CTumFN
 co0/uZLV13ETyWd4bKEk6k7AxZ5XFU124zHWkuplnNqDKfrQGxopxkLOHiUf37GAYGxn
 2+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703724639; x=1704329439;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vp+Cm8HKjEyUq3bujwbmIxuUl7dQekI6ibEjoDWkgRc=;
 b=wXzVfb94Hw1toPQRQgTqmCeFir4BRQFbarKO2Wu8Y25pYUaEI5wUXpJSzWlScpTUT8
 P6OD7jwTZ4fhVgxgdji9j/T+WoTx2k6KDUabbNjP+SfxPHIkPrpOSyCy34K9IMWckMXg
 gE5/WuSiKvNa9FAwJMag0HxLAF815AzYcIEwiloL7luGUS+mmHNtYtfcGx3JjNQ+iIuE
 2Oow6Rm9cLeD3Q6HWymzCH8m11OaneEen8/87zwnmKViahnCQKF3SJYTPehBXRIcIdc8
 QEw1hujJSIoLw54b6sypAIZDG5GvTU6c+aj7xo8OR/l2DyuR/bmQ6J6nOdqpE0kMYjT0
 oAvQ==
X-Gm-Message-State: AOJu0YyPvJHBnSVfIgS2uQsAPMLaKEEpMEPhuWrbLXmGxQQldqp02h9W
 J/rGrsf5WInG6De9qTfmeLSKFdZpVwm4sg==
X-Google-Smtp-Source: AGHT+IG6pBupztEkpNroKtROZXBhJSZdM335a4cmxravjXyhYyhddoUrJ8G6dsoUat4lq7/7XAwG+g==
X-Received: by 2002:a05:6808:300e:b0:3bb:d118:155a with SMTP id
 ay14-20020a056808300e00b003bbd118155amr243874oib.1.1703724639647; 
 Wed, 27 Dec 2023 16:50:39 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 c13-20020aa781cd000000b006d9fd64fdcasm2057422pfn.37.2023.12.27.16.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 16:50:39 -0800 (PST)
Message-ID: <dd1c1304-1866-4b40-8948-483005cbe6d1@linaro.org>
Date: Thu, 28 Dec 2023 11:50:33 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/35] target/arm: Mark up VNCR offsets (offsets >= 0x200, 
 except GIC)
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-32-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-32-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/18/23 22:33, Peter Maydell wrote:
> Mark up the cpreginfo structs to indicate offsets for system
> registers from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ in
> the Arm ARM.  This covers all the remaining offsets at 0x200 and
> above, except for the GIC ICH_* registers.
> 
> (Note that because we don't implement FEAT_SPE, FEAT_TRF,
> FEAT_MPAM, FEAT_BRBE or FEAT_AMUv1p1 we don't implement any
> of the registers that use offsets at 0x800 and above.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

