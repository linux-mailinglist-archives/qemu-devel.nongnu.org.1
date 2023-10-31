Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 852E27DD0D3
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:46:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqwW-0002jU-1h; Tue, 31 Oct 2023 11:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxqwU-0002j7-NV
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:46:10 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxqwS-0004sQ-Uu
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:46:10 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507bd64814fso7995479e87.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698767167; x=1699371967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g38K/x2M5ougUm2rAdcaGFaHTq202+OYzgtIrGUcmlA=;
 b=DqKt0Ous6C7oJNFSQOL4XM5fNvfpb/8gr3xfwkFi8gLrDjPvMmiz/elLxCF/vcDI4u
 GOI7Z482GUubIP41SfdPwZ8AJF83vG70CB+ISBC6AoV/3Hf7ycyIcf/+oHSN+vJzYwnE
 /FxdPuXUCIMQU2GKKDDnc+xW90pO7u810DJZkZx6N9jBVqHLLZtgwsjHmzmytdj8O2mQ
 4d/9jRqdLeLiOMc35fFDEmPeL5NvWbgGJcIRR/KsHKuIkXUA2qugqcaq5ABH0ds+4l6L
 dqX/TPm1H4TbHG8Etvn7g5aFi7cCl7p3V2ToNDZQCId9dabBeNowNFnO+Y4oqRV7e9eY
 SI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698767167; x=1699371967;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g38K/x2M5ougUm2rAdcaGFaHTq202+OYzgtIrGUcmlA=;
 b=SN3EF74taF4ovIyEfFxvyxQbcsm883JyvgtbVKy5z2mUshjLi6dPC3eVW8RAz8m4Mj
 8tMR/zxAzF/2JzsfLa/7JC0XYBGhNUH4dY5OYX6TmSsf5b1n3Ldgn4J0M6R92SOdiQiw
 F44rBwHWVFetVBdWzoD2auyy7HpjVjJdJyjrtjWVtHcd7YHLsGafBnXpD3cOve7J1kl5
 ZgQWcylu9WMcW1LIpALC2o+e5NAEK/95ogXm8S1as8z+Kj27lO+OvhL59cmQ9zVSLQDA
 EeI+DoHvC+VsC5hu6/roj99dF3TW3kkA2Kr9MeOxzYG7ddkLOo8ZgORRbAAiIRcDENoh
 /Jog==
X-Gm-Message-State: AOJu0YyLaviruK8gRY5008kvZPfjzxiZNCKnq4QP2A+OjnF9xrNzI8Bv
 WcE8GivDtPPBM48yojdoEnqRWw==
X-Google-Smtp-Source: AGHT+IHvxUVPEmBB9Od4Mx/ZyQMCT1TYglrTzSmKj/U5Tn6Qx0PUjlxJH8TY4HLFS+qIqxZhKILDwQ==
X-Received: by 2002:ac2:4a71:0:b0:509:fc7:884a with SMTP id
 q17-20020ac24a71000000b005090fc7884amr6397985lfp.19.1698767167024; 
 Tue, 31 Oct 2023 08:46:07 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 t4-20020adff044000000b0032dbf99bf4fsm1752814wro.89.2023.10.31.08.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 08:46:06 -0700 (PDT)
Message-ID: <04e5c555-1860-1e95-64c6-b9a83f5151df@linaro.org>
Date: Tue, 31 Oct 2023 16:46:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/8] docs/specs/ivshmem-spec: Convert to rST
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230927151205.70930-1-peter.maydell@linaro.org>
 <20230927151205.70930-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230927151205.70930-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
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

On 27/9/23 17:12, Peter Maydell wrote:
> Convert docs/specs/ivshmem-spec.txt to rST format.
> 
> In converting, I have dropped the sections on the device's command
> line interface and usage, as they are already covered by the
> user-facing docs in system/devices/ivshmem.rst.
> 
> I have also removed the reference to Memnic, because the URL is dead
> and a web search suggests that whatever this was it's pretty much
> sunk without trace.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/specs/index.rst                          |  1 +
>   .../{ivshmem-spec.txt => ivshmem-spec.rst}    | 63 +++++++------------
>   docs/specs/pci-ids.rst                        |  2 +-
>   docs/system/devices/ivshmem.rst               |  2 +-
>   4 files changed, 26 insertions(+), 42 deletions(-)
>   rename docs/specs/{ivshmem-spec.txt => ivshmem-spec.rst} (88%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


