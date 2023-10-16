Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6F27CA365
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:05:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJXC-0004ty-CE; Mon, 16 Oct 2023 05:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsJX8-0004tc-Ey
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:05:07 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsJX6-0003u2-Qw
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:05:06 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c17de836fbso50954281fa.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697447103; x=1698051903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/oUluU+u4VJWZ6jYkaUzKo7m5ZIo+wDc0uuINsS0CJI=;
 b=MWsSGdOHACzErl1kf+bGVkl7QwzxtVLtNmdZK4+JZvmsSck0n+Lzl6rDdlxyMBl4+Q
 38zH4U66VKyHqg0Ld8jzrawwFyrZ3E941kUmdoHvCiaAxmUZ+MMvbfEk9MKQVOn/R1FT
 fjkXlakE5hCEyoG2c+EbJrQmh7BydPbbqrTG1UIQj1bNung0YW727e3F9/Hk4q95gxle
 CUfd/c7BdwixlX6XoI+0NStvbBec8ZEpJVt9PGPcOD/lwzQ2s1khS3QqqZUWxySn8XZI
 6GPKedeEI6JXlitF6koUXnRSsmev5vIo6Rppwn7WudlrqPIwdm9aPnvdbDr8QVtd6xli
 eQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697447103; x=1698051903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/oUluU+u4VJWZ6jYkaUzKo7m5ZIo+wDc0uuINsS0CJI=;
 b=HAjPLNec5X/1H+4isJaRudrecRAhZdVL3QsQc8og71zK9qMbXVnWZhsZPdJf14ef6L
 dgS4T87dcBRSvACalx/6h3wkRzvJ2EVvgXes3p8XbcUw4YraaZ3CHRppV6Sy+dyhqSEb
 Sttzq/a0Ckc8StfB+NtXkaRuPz2lkF4eXNWIhSNRfu65A9IkfFmkaIPoIUZb5kr6d3Zi
 8fm5eB/VBBJaQatGxcppHDX8jhrfQebMREI7cQOM83kTb1LZzQvDPdCAP40XWaTZOZI2
 0oTCkbDQOxrXTI9zBzcSQwqOitiEeTaEJahSUcMx4OVa6frinWrT+yDoegA7D1jem1n/
 o4EQ==
X-Gm-Message-State: AOJu0YwtYbJPDsfrYMThHqdZbcPaIXyD2FaOiCnFLiWYeqtpx7SEa6rp
 FseVM0X4BMNFtmm3fgZ5aAvhzvGG0br1HrE9+wU=
X-Google-Smtp-Source: AGHT+IF+dwfiNeIPn4b0ByLsvpcwThKIGYhhUGIDGngy5bHJpwLhHH/Zy9wrGrCpnYHUr4JfM90BHg==
X-Received: by 2002:a2e:bea7:0:b0:2c4:feef:852 with SMTP id
 a39-20020a2ebea7000000b002c4feef0852mr7921646ljr.32.1697447102778; 
 Mon, 16 Oct 2023 02:05:02 -0700 (PDT)
Received: from [192.168.69.115]
 (9r679-h01-176-171-216-136.dsl.sta.abo.bbox.fr. [176.171.216.136])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a7bc84f000000b00406443c8b4fsm6570257wml.19.2023.10.16.02.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:05:02 -0700 (PDT)
Message-ID: <ba385271-bad2-9df2-e3e0-9f7018a77b81@linaro.org>
Date: Mon, 16 Oct 2023 11:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] Move Fuloong2e PCI IRQ mapping to board code
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20230105154440.259361-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230105154440.259361-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 5/1/23 16:44, Bernhard Beschow wrote:

> Bernhard Beschow (2):
>    hw/pci-host/bonito: Inline pci_register_root_bus()
>    hw/pci-host/bonito: Map PCI IRQs in board code

Thanks, queued to mips-next.

