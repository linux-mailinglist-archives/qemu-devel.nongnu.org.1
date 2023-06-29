Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBDF74248D
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:58:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpLd-0001ne-1U; Thu, 29 Jun 2023 06:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEpLX-0001nB-Oo
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:57:56 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEpLV-000094-D3
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:57:55 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fb77f21c63so802540e87.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688036271; x=1690628271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KRSCGTG8JCbJAakePPjN6awzndENT09h1KFeMkJoEfY=;
 b=xlM3GylsziU1IhyZ981/bFa4wjeCagJXqFmG7f7H6SpUSjdr1ebFpu23noCv9lY/iv
 OoUwAdg9esHCQa4FidwLpLNW8eBEO5kRYtW7zUAYaXzDu5ZzmUaYgli+ep0THd0ni9x/
 v3nKjAWUExP8HLVJwzzByqGiC0OaHKRUW4U12YWnll7aBMLwsYqOBtA+Z7uzGAdgW39F
 kAYiA8WZHotZXyeWq2O3ZDnLCuUWMHck3tOWoaCHp2/YQP9nKiF1WgXPLlAIxJ1ku4/y
 t/EMiHnhRvJXrgBFcb7EFH5uuXNUsfTJ/vL4G7PNr3CLkMg8DoybMSqfNOYV86bib9sb
 PDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688036271; x=1690628271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KRSCGTG8JCbJAakePPjN6awzndENT09h1KFeMkJoEfY=;
 b=QfbaCSAmZCn+yFAqlmpY20nXgbTZw5sn2yd+q8esD3Pujk0PEpCVreR9N6ug5nvjuK
 Dz8cY7hrhpYaJS62nNb0wL5zDTfO/ePUy5yHQdOPmGxLx7JQua7PjJzWxYEUkhxvFjp1
 X2+b3OLJ9LLJhDAWWuLMRrB3T4ESPz15yECzS1otyNyKxDEMa6DZSWTDryWxmhyfnxp0
 Il/dSMaXjHWIph6Xv/KvELgrre93ALk/4gRjpdB35+g8isWBbpoiKJBuurKpf+z6jvnH
 rnJvCHtaL0DefNvuHyUi2UirbyXlrh4FJ2gD/ETTR1lZ2Et0GaKts8UIaClax+n/vDgd
 QhOQ==
X-Gm-Message-State: ABy/qLbJDAd4sieYZk1R1z69N+YJsjyXlt9HHRA6/+tEkSD0yLcJvE+3
 V0hIiTO9O8XiB7YYqsQTlTwR/g==
X-Google-Smtp-Source: ACHHUZ4HCwprOmaML+6th7s1mrXSGIi4kKNYZBVVaiAE5sbFND0igtqdzDijCQZoqj0dBfEYqFPaYA==
X-Received: by 2002:ac2:4c48:0:b0:4fb:9595:15e9 with SMTP id
 o8-20020ac24c48000000b004fb959515e9mr3174888lfk.22.1688036271188; 
 Thu, 29 Jun 2023 03:57:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a7bcb95000000b003faabd8fcb8sm10112133wmi.46.2023.06.29.03.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 03:57:50 -0700 (PDT)
Message-ID: <56b24806-a8c0-6e19-7a15-2cb46a1fd138@linaro.org>
Date: Thu, 29 Jun 2023 12:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 03/12] aspeed: Use the boot_rom region of the fby35
 machine
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Peter Delevoryas <peter@pjd.dev>
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230607043943.1837186-4-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/6/23 06:39, Cédric Le Goater wrote:
> This change completes commits 5aa281d757 ("aspeed: Introduce a
> spi_boot region under the SoC") and 8b744a6a47 ("aspeed: Add a
> boot_rom overlap region in the SoC spi_boot container") which
> introduced a spi_boot container at the SoC level to map the boot rom
> region as an overlap.
> 
> It also fixes a Coverity report (CID 1508061) for a memory leak
> warning when the QEMU process exits by using an bmc_boot_rom
> MemoryRegion available at the machine level.
> 
> Cc: Peter Delevoryas <peter@pjd.dev>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/arm/fby35.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


