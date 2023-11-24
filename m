Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F52B7F7283
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:14:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6U8X-0003IF-Jf; Fri, 24 Nov 2023 06:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6U85-0003Gk-Re
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:13:50 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6U83-0000i1-Vi
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:13:49 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50aab0ca90aso2483792e87.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700824426; x=1701429226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6+UijP2w7HrDC1htNvYP7h8A8gfV2VKjFTCH2egyNL0=;
 b=JRytT1C/j6FmgFOmUYfzkgp1C7eyGyjRFuvhI4vSf9kLvhPIglHBtA7XHnvjgZwbHC
 BcwJtF2GD8pRObHcE3JrSq+/eaNu7Acdar2bcEjHvu1gozJIBdStuC4Fkd/5eJJyh2r4
 ILEshj2RQ5mGTM5ytELXInHK41xRpBjkc6UN4vo5M66szsE4kjW0lqziDH9SJUQ2xiDt
 sAjQ+onn8m8Ckvp0O9fd7rJ+3pOgt/nJ+QS5hO92fGh12++tLulbqXjM+ztMU60byfZe
 nJRU3IfJRPkPc/6b6eSezQRKBn5hmQZx8GmSjdfawZvwItMeIS/rzlKpGHg1ti5CYHP7
 U8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700824426; x=1701429226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6+UijP2w7HrDC1htNvYP7h8A8gfV2VKjFTCH2egyNL0=;
 b=fbGeW2EsJLDhaJh7KkhizOtUR+mJrqquzaqrnFZWoVWJ00dqpVDuJUnFUEp4/vX3Jn
 NEmoxlnyjYgwaBM1uWXF8wOdbQyQzzw7Jy+C9zGG4pXVdvQ8WHTfkYKD4WEsPMGhzg0b
 uoowvcTdCqCfN+0QkPL5k1eSceyQ9tXvoOSI9PSnDU09R5VNFtQUdcsaoBkiHede3sfk
 sED8d0h+ZMLhdPEPp5GhQqlwK+EBWOKgOfK9z1Sf58xHhqadmBiDSB1P5Va3h5YkHhkn
 SOvmlcAcfFHcUcOS41tXfDzUXQDsoKuFsDu8X6q0rl3Thp2W1mIpRUe0ER8OuQXgyD/x
 /abA==
X-Gm-Message-State: AOJu0YyR9LlobbPGs6CDj/lthnSFatCvvORAcTYC1ilYXs4Fz7ffyy/W
 uOaR8xcif2rb4hTD0ORNFmiTvg==
X-Google-Smtp-Source: AGHT+IFjcVv5JXtwtDuRB1r9XOTjyqeGPNFLEthF1e6Mr0i6xFQSM7+NjWyBEYzHDSo68cMyn2mXcA==
X-Received: by 2002:a05:6512:3a84:b0:500:9a29:bcb8 with SMTP id
 q4-20020a0565123a8400b005009a29bcb8mr2181913lfu.4.1700824425980; 
 Fri, 24 Nov 2023 03:13:45 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05600c34c500b0040b349c91acsm5486221wmq.16.2023.11.24.03.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:13:45 -0800 (PST)
Message-ID: <7a6585f6-18bb-4e05-9d7e-4fb346bfe0ab@linaro.org>
Date: Fri, 24 Nov 2023 12:13:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/1] target/hppa: Update SeaBIOS-hppa to version 13
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20231121222625.131341-1-deller@kernel.org>
 <20231121222625.131341-2-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231121222625.131341-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

On 21/11/23 23:26, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> SeaBIOS-hppa version 13 fixes a system reboot crash as reported
> in https://gitlab.com/qemu-project/qemu/-/issues/1991
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   pc-bios/hppa-firmware.img | Bin 681332 -> 681388 bytes
>   roms/seabios-hppa         |   2 +-
>   2 files changed, 1 insertion(+), 1 deletion(-)

One day it'd be nice to have a reproducible setup for firmware
blobs. The binaries built locally or on CI should have the same
crypto hash.

But I know, we are not quite there yet...

