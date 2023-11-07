Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3D77E45F4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:25:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Ot1-0007OC-FB; Tue, 07 Nov 2023 11:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0Osz-0007Ns-Ia
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:25:05 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0Osx-00074K-Vb
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:25:05 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6c320a821c4so5219402b3a.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699374302; x=1699979102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jiBMQtFaRAbRZNi1909ketm4O8sZfl8p9AS9bIPRbeo=;
 b=YgeX+JI5YDbczXR68hTqiAwGaqFMX6dAZt6tBh2rx1fnq1A8AlPxeW9xMWm0ZYCxZ1
 h+MjEMAoAxVhMdbfd+cKlldT4HTLSuwmh3dQl54bWwQxa/tSdv6myjyCXyV6rUD1FhH6
 JEMH3onO/ITOag0stHZTsgg3+ZIQ/P7uBuIbBw8M+Eo6NL194SiYdv1ECshUC5Ew6/CW
 NfFFs7e0u09GSEFOjRo9IB1Xv2w8QU3RsGBPTj4klkpnk6NsVtOrT0ZqoJFfJglPhs7v
 tEngoprriq81pHiG/ZtV8CBMO+vCLZ1RwIPPGRcoTnhvxOT2nbjri/1nCIaVXDLqdM5w
 9odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699374302; x=1699979102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jiBMQtFaRAbRZNi1909ketm4O8sZfl8p9AS9bIPRbeo=;
 b=RMDawJMNFD7K9zkBH9PfesB9eZZdjoHtbQAPO5bvg9MeDVZB7nH8foQ5DAFxnxC1r8
 xEDUpCHj+0B4s+Dott+XgtFAlyZqVjSiojuHNoCtOPhU1kbZzaShGubiruglNPXhdsN5
 3Xt1pKBa8UI0JT0mP7rk5E4mBd//4Pr3ySfcDn3bfRwIBEIiOJm0nYEM0+9U6CNS4FxQ
 1sOPlF/I+V2GPz0ngrsZ0vu62ohV8EI7hCPEVWY4rXrxSo6QsbqzdXVhM6bRAGvDLlnd
 Mzr+UrD7+fDRcr3VL7D5ejouIfMEiasyf2/flaIE01CVaV2HapICInHkHoeanDNs45cP
 MaQw==
X-Gm-Message-State: AOJu0YzzQc3njy8HDfTH017XgqBMJmaj8Fn3TG7y4SzTFScchpmTpZnr
 xy+syn9UmEoL9rAfkCvdM1Kp5g==
X-Google-Smtp-Source: AGHT+IGDl7sfUxjHevheZn4B5/jgVFkKXNZK2p9+niM+0FuLUZ2qhMMYTN1xirjIJVTAyduusmKhXw==
X-Received: by 2002:a05:6a00:1311:b0:690:c306:151a with SMTP id
 j17-20020a056a00131100b00690c306151amr27827758pfu.0.1699374302393; 
 Tue, 07 Nov 2023 08:25:02 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 o21-20020a056a001b5500b0068bbe3073b6sm7417176pfv.181.2023.11.07.08.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 08:25:02 -0800 (PST)
Message-ID: <a9d3a43a-6e9b-4463-8f31-ce7083eca818@linaro.org>
Date: Tue, 7 Nov 2023 08:24:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: mark the 32bit alias of PAR when LPAE enabled
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20231107105145.2916124-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231107105145.2916124-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 11/7/23 02:51, Alex Bennée wrote:
> We also mark it ARM_CP_NO_GDB so we avoid duplicate PAR's in the
> system register XML we send to gdb.
> 
> Suggested-by: <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - only set ARM_CP_NO_GDB when no LPAE enabled
>    - also mark as AP_CP_ALIAS
> ---
>   target/arm/helper.c | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
> 

With Peter's comment improvement,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

