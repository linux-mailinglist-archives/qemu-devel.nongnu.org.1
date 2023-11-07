Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D437E3B14
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:24:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0KC3-0004bb-M2; Tue, 07 Nov 2023 06:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KBz-0004QJ-I3
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:24:23 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KBw-0007tt-Pd
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:24:23 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53f9af41444so9494207a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 03:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699356259; x=1699961059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FBonne8TDnBN5zXma4N4N4nGDVIu81rRxyfquoryPlM=;
 b=V0M96KM5IMgH88zb9FP9BwwzRsVzXkLL7Gp/EKSne7rThLyI8oa6sijNlLyGuuNJb1
 LipdlcUQdSLD/rg0pGBk/zlmlwTw/A2o/2UNhDfpfdDNjpv9DPGf2sh06jdLuwapI1SO
 w4neEG3jk4sOrDV2LASgnq7Sfe9tsZX5uJp5qnrkOLXkbTNSIMzxkxbsOl5GmeHvB8/5
 DDH6WOUgkb3Iq0Yd1jgHSnHuzgjMGaTMOHv5dOpzyAh3IQF9uwkDWnx9WSozbYaW34ya
 liWYB7dnoW0vVJJOwCFWdWGgUeHhP0Z5LxtbeEZ9yec2DRk6ABfhVUhhThYR7sKfyt7/
 IKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699356259; x=1699961059;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FBonne8TDnBN5zXma4N4N4nGDVIu81rRxyfquoryPlM=;
 b=mnKNHfgDgZnBWOUIlMtdbRxGRv44wWmBSfw3Cn9i77iew8MmaOfw69DW4KEeJKDNm8
 D0MPbJFLMy8j3cfi051byyC6b/iYRR/DVlTG5xfwH7gHxjWs/mWcqP9ApQ1Cz38G2A4M
 U7rV6ZO3cIOdQlo1cXAeZbMNu1FdbXlmDWuXY5vJjf0CnWVJlotYB2G9XLkAbyaEPZXg
 qFxXCsrG6I/1natZlw/Bb76bWLMPd/B38gXY5WX8WfN02IK7TsZvan/1s9QoRLyB8bPt
 Tm4w4uct84AQ6dWyCP/Dj1BWuR9IFVZ9PdvcyWFBiydTnQkwiPolRtltTJ0fzCD7p121
 wfIw==
X-Gm-Message-State: AOJu0Yxmxky6OHU/cZVKneJe1W3lZl9eU0yWIqam8RRLxTUGc5/zuCg0
 b45TorwTwh2eb8yLyS/K9Feleg==
X-Google-Smtp-Source: AGHT+IHCmaFubwbEqWkgRNGtp5CiC1oPPOSxIPsOlfYw5XA9bACj1SJu9kAanvIpsrpQB6fJiHqt1g==
X-Received: by 2002:a50:d709:0:b0:544:b880:b316 with SMTP id
 t9-20020a50d709000000b00544b880b316mr3487405edi.30.1699356258906; 
 Tue, 07 Nov 2023 03:24:18 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 b67-20020a509f49000000b0053d9f427a6bsm5488119edf.71.2023.11.07.03.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 03:24:18 -0800 (PST)
Message-ID: <cf12ee11-bf7d-4d05-ab21-5d194a1bcf3f@linaro.org>
Date: Tue, 7 Nov 2023 12:24:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] MAINTAINERS: Extend the Stellaris section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231020060936.524988-1-thuth@redhat.com>
 <20231020060936.524988-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231020060936.524988-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 20/10/23 08:09, Thomas Huth wrote:
> This header include/hw/timer/stellaris-gptm.h obviously belongs to the
> Stellaris machines, so let's add it to the corresponding section.
> 
> And hw/display/ssd0303.c and hw/display/ssd0323.c are only used
> by hw/arm/stellaris.c, so add them to the corresponding section
> in the MAINTAINERS file, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



