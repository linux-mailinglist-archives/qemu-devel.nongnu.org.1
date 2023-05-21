Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D53F70AD86
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 12:55:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0gi1-0003jp-AK; Sun, 21 May 2023 06:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0ghz-0003jS-DZ
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:54:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0ghl-0000Qa-1E
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:54:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f475366514so32733265e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684666463; x=1687258463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j8+592qdCMoaZlE0TSoLcKETp+/AM2RvWSQ4KMWkHCg=;
 b=figTEWYP7WTxFjab/R4iPLa7q4pbdDlCmgn+PlGK8m7dSMqtTYz7MwKD/821BE5nE5
 7zjzSioXj5lsvmkOkA2WoEY0JgsxSuD7WpqHpcWPvDubXqUtrWSWNlcrGErJgfn6TxqP
 9QY3+lDOb/BEVDCbrXpTRI3lyJ81Rhl6+c1FPdcblsPI4twCEvWHroZ+kaylIbSqe4VN
 qSwNKQUw+K2L5Z70O4oSV6eTnbyXO2bqDuMeiKtOe8wMCWAynXwT56Ox6G8aHG7GT+gI
 R1s09ntcxKd7VH0+A+nZN5e98qUO66Nd+KoXyS5WMr0hktHIIOQzXK0zA6tqVpk0cy0J
 Ys4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684666463; x=1687258463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j8+592qdCMoaZlE0TSoLcKETp+/AM2RvWSQ4KMWkHCg=;
 b=Bo/tOi6MvAiRdgSispxNE+sqRTyRmQ6hNvI8p/CUbyVVUU6wUUdAdQ39JWINmij00E
 NSHHEYgs9nq+7+aZGCshr5ayWcbXonvHQZO5T3PbJAITDygartALGauBoLQYcDOu6gDK
 4n0UdKdTYh+u2F3qobjeMCpestGBo61AsLiC0pc2pekmz2v2rSmbJdrvgGEpX8qeU2oY
 MOJ3tIE+KoLTFcVjDb+jOXiDkIoDR5jR5y6DnQ2SpnoGdLJOclNwILrsfhmYz0bSp6o4
 RJWPqH+ezEVGrZMO0A2VHv77SMyrz9qz1zWAVOrYRRhLtf7PEmfyk7ihfANerqOX0d4q
 +bHg==
X-Gm-Message-State: AC+VfDwLTjWBTvKQJf8972D47NO6JzHmgzXM5nefHL00QXzJVVObwVYp
 qbluRbS2FJ06/Hnm1a8bRSO3IBvgW2xz5Z/cEaw=
X-Google-Smtp-Source: ACHHUZ4quDMUWw2RaiHxpfz1NY+fZ2I3OHosBHc2bSD6M2HKylIINVsa2Noj3OKQq6ZaPFCTR7t+bA==
X-Received: by 2002:a7b:ca44:0:b0:3f4:27ff:7d48 with SMTP id
 m4-20020a7bca44000000b003f427ff7d48mr5245194wml.19.1684666462781; 
 Sun, 21 May 2023 03:54:22 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.152.177])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a7bc4d1000000b003f423a04016sm8081725wmk.18.2023.05.21.03.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 03:54:22 -0700 (PDT)
Message-ID: <6ff38111-2f9b-b025-5dac-8d98b6911199@linaro.org>
Date: Sun, 21 May 2023 12:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 12/27] meson: Fix detect atomic128 support with
 optimization
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230520162634.3991009-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-0.098, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 20/5/23 18:26, Richard Henderson wrote:
> Silly typo: sizeof(16) != 16.
> 
> Fixes: e61f1efeb730 ("meson: Detect atomic128 support with optimization")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 4ffc0d3e59..5e7fc6345f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2555,7 +2555,7 @@ if has_int128
>     # __alignof(unsigned __int128) for the host.
>     atomic_test_128 = '''
>       int main(int ac, char **av) {
> -      unsigned __int128 *p = __builtin_assume_aligned(av[ac - 1], sizeof(16));
> +      unsigned __int128 *p = __builtin_assume_aligned(av[ac - 1], 16);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


