Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACC179885C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecFZ-0004XP-Id; Fri, 08 Sep 2023 10:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qecFV-0004WU-Vi
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:14:18 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qecFS-00080o-Nr
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:14:17 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52683b68c2fso2896898a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694182453; x=1694787253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZFANwgWtdrBhtj8rBIAo7oBEiXIo//Tfg9jdk/1BPog=;
 b=E0FuEJlz2eFjO92fSz5Qotsj7+LqZ2mynLv1DBdgjalV3AefAx8tX5qBBVm8FhZ9KN
 3TslLHTdY5Zkpw4v2CXem9aZDidcgImW2o/G7kGBbKXzNpjWolGETNwDeUpn8LOE6jXW
 kyO8oGXLm3hsywxGyW5WVgQL2DFBiY0C4ZwIeqzckPVwPOZe6uYQXxZnEzJN3+D+lY0N
 Z7sfN8iwUMEQ0W5YJPL+8/F4HvPBo5C+giHIExX9Hr/VOfmEEogSiYMNvnQE1RyQkfcP
 26lRIgblgvvvFkzo+iaReaW/U85uMcdm75CX9EYpkeMY4fKBzD1iaBMTAxHbTDUhgG5n
 G95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694182453; x=1694787253;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZFANwgWtdrBhtj8rBIAo7oBEiXIo//Tfg9jdk/1BPog=;
 b=nPO807fCt1oekjou78TOQJ1toHQE9BnLh0e3FWQvErOxGVMZQx/poQp3nwkPXEESs1
 yEGIrafSHJSxC2A9kmDQZRys5qb93/sL1O2RYvAN9lrWP+AETWXpGvnKFbwxvvhJZ6/g
 t/veIrVbm7CXAor6uTEGmyqPEWiaIIp6qSU5c+BO9CUvDEnLolmuEPADdBxiSrQjFVKW
 AgNtAH69xbKHLXqJdbK3Kx9Mw4XvN2vGE+Uy+RCJgqK+ERRNxjqT/pgLjgepsEJe3GZM
 QscEuf7pHx1RrOnucoHCgeaOiIZymq1TLFd60dVaJKl+Rv2dUlK/0+6wOS56CCICxj1s
 hz5Q==
X-Gm-Message-State: AOJu0YwvKUsZ7+b8S5EUEUSEAUj8dDxaBUdZZZ0J/33U/Lt3VOoKx1gc
 /S0tqHcdv9QyxnmNfpNMdops7739NRaLG4ELEhs=
X-Google-Smtp-Source: AGHT+IELPklmZ2cIShxOI81GcMBLKYsHBKZ4OG5eC0qlLlI+KOypPby4Ej6/59MqVlk7cWA6PNL7Tg==
X-Received: by 2002:aa7:c3d4:0:b0:523:cfa4:5c3d with SMTP id
 l20-20020aa7c3d4000000b00523cfa45c3dmr2299539edr.13.1694182453111; 
 Fri, 08 Sep 2023 07:14:13 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a50ef15000000b005232ea6a330sm1073164eds.2.2023.09.08.07.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 07:14:12 -0700 (PDT)
Message-ID: <7d4883c0-7d9b-fe5e-4415-5521338a025a@linaro.org>
Date: Fri, 8 Sep 2023 16:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 03/14] target/arm: Add ID_AA64ISAR2_EL1
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907160340.260094-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/9/23 18:03, Peter Maydell wrote:
> From: Aaron Lindsay <aaron@os.amperecomputing.com>
> 
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> [PMM: drop the HVF part of the patch and just comment that
>   we need to do something when the register appears in that API]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h     | 1 +
>   target/arm/helper.c  | 4 ++--
>   target/arm/hvf/hvf.c | 1 +
>   target/arm/kvm64.c   | 2 ++
>   4 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


