Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E772BCD9
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8e02-00077K-Qp; Mon, 12 Jun 2023 05:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8dzs-00074u-2d
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:38:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8dzp-00029q-Iy
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:37:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f739ec88b2so29504295e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686562674; x=1689154674;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hkArH+ZpwrHcdflHjSZPYlTdjwXL00PW4I/jIGQYQEA=;
 b=S53wWW6i0F6bNGKMaIXPGzOR7sXvhkrd/wmi5eU2edI0sN885Lr9oyeIxlo77ynikl
 ppZ7CIpQA2dnN8BvuAYOulNaJ6oAsZ78F2wJGgVP4VxFBsHFJuQW8QKXIEIYzUtIJ6PI
 3x1+BEBkebRsvaj6VFUuxvEmzhzb2mY40nLR5AfxjJh3Wdfn2I7VYASwEszB+u29CeSr
 XVN58UtGIAYUjRgzbMi6M5dPV5sQPEHPCBou8usl4uDbrTzcJgWV4FkGlxEe5cv3PtgW
 ckLrvc9bDBWXAPTURr4DwS5g0T9VBPe1pYOkRpCTlRyGtIXq0KHc048dEjUGTxfAPoIe
 s6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686562674; x=1689154674;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hkArH+ZpwrHcdflHjSZPYlTdjwXL00PW4I/jIGQYQEA=;
 b=bUAdazoVDhaNYMtRhEbNpAXgFkQIa5wFQioOJ5rKvVkMK/Zu93zxnvpNGsDozq6GMs
 mF6h9QFWqwCeg0pyAaBQYzxmhPBMS5JgQ6e6/qe5BjO/Yl8jmEKRQrlX2iw3jCnS5qZ6
 6zADY50ZCULBNcFpPOTfeOt21mb0/FnaUFQXs4eNnYa6yoR5l/GFUhufFDUC+ShhB0Gp
 gEGtPqfKgDDz2mCAK0qQ/F0vMb4LYbby0sZO6ovPF8yUhlxto8qNVbV7mfJ2e48LQr3s
 VPqLy5/V66bs2KsUkbBY/EJ/+AuDgW4sOlqg2HaOfG1wQRrfnNQ2Abs+SNX8OlVmP3Bu
 lnXg==
X-Gm-Message-State: AC+VfDzDzCEHHqvAadB8+5Zy+YqhTWi16m+YkkQ/KRYQLKxVIhvMf6DX
 RrkQp8gFx+fgEw7wvSmJrRNROw==
X-Google-Smtp-Source: ACHHUZ5mS//F1Zm4nf7XxqStGQ9ose8u4dmWISvjQRZy1tZY3zk/Np1Zz2WHrL6fyFnJcLicQSfwgA==
X-Received: by 2002:a1c:7203:0:b0:3f7:f584:579b with SMTP id
 n3-20020a1c7203000000b003f7f584579bmr5449564wmc.9.1686562674398; 
 Mon, 12 Jun 2023 02:37:54 -0700 (PDT)
Received: from [192.168.143.175] (17.red-88-29-166.dynamicip.rima-tde.net.
 [88.29.166.17]) by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c220a00b003f735d6fa74sm10835831wml.9.2023.06.12.02.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 02:37:54 -0700 (PDT)
Message-ID: <036a353b-b9ae-8791-0ef4-1c0ae0732d14@linaro.org>
Date: Mon, 12 Jun 2023 11:37:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 06/23] target/arm: Convert barrier insns to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230611160032.274823-1-peter.maydell@linaro.org>
 <20230611160032.274823-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230611160032.274823-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/6/23 18:00, Peter Maydell wrote:
> Convert the insns in the "Barriers" instruction class to
> decodetree: CLREX, DSB, DMB, ISB and SB.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20230602155223.2040685-4-peter.maydell@linaro.org
> ---
>   target/arm/tcg/a64.decode      |  7 +++
>   target/arm/tcg/translate-a64.c | 92 ++++++++++++++--------------------
>   2 files changed, 46 insertions(+), 53 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


