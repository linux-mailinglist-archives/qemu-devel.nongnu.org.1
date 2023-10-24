Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F967D47CF
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 08:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvBLB-0005RW-Hf; Tue, 24 Oct 2023 02:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvBL8-0005R5-TL
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:56:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvBL4-0000PA-RG
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:56:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32d81864e3fso2779178f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698130586; x=1698735386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lKsHxJ9UGLhndcbZ+ldBg9PWjGIpNn5jd7CJwuYj/TU=;
 b=l+BmdNBxHHjcQKpRCNgNjxsy6RYxQUJjh+mr1VIT4gicyHkKYad53XaHmc0QovNpR6
 rhb4wmpehnhk/zQYnljzngquXqxwCxir383MWfkj5qIIxH5DQMr29Tp5r1pfn0eFPwGB
 q+daa3yW0GobEtTHzrl1uDmZmcn9aUYSgggYUrPx3j9hy10p07xUY3NSJp0E7eerHBJm
 oryhzEdCFsCPtvEoJgMBeABaYXA2PP/VCTezgpigyxXgq9XnEX/OLtTL0dJXnWTWTvzX
 2jfnVo/u+y7WbTcdkjy16tm8M7QFLre/JdZI/YY+hWQv2U9ijvPkFWgCDCwP1jNdj2Aa
 myuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698130586; x=1698735386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lKsHxJ9UGLhndcbZ+ldBg9PWjGIpNn5jd7CJwuYj/TU=;
 b=Tbbjo1e8Fpr7TszPbIKejQ+P1Kdf+7XWupFIivemNPjbgjW5rXhx3BOyKILnj7yMfr
 Y/iDaOCPT01A3JHJ/TaJ8voDmYlmV5kSiozid/xqnTKowxvRjlSZF23Ong7vGJHpDPmS
 QJ5qTSkseHOR97GAVy0eDNyvl+CPnc/dO3VK2rKHXRObkZnIVoBgn55mT1/ZovtdaK59
 fwOBorrtm/23bCG+a4ik+FyQswRyVuXYhrr44sjhCuKAOC3p6Iw54T/fQG2+PaV3LEx7
 38/ARwGOGkERv9OBALXfi0K82GwSa9a/JflbHCrUoD4xQKiA26dq0Xf+XVb9HKgnaIKY
 ZqkQ==
X-Gm-Message-State: AOJu0Yz05Dcqz9BMNf/74gksqLeP8UNUv6QOPglPYQ8KSsoicSTIfLJH
 0pZl+uY1bGBPyfFjEKdXKy5gGA==
X-Google-Smtp-Source: AGHT+IHsMDcLUSZrkmTb2bPZMq9vzWBmO4fb/G5Bkss4bLTOUfL3mJI4CV7gpJhd23XFbqlkWg3NjA==
X-Received: by 2002:adf:cf02:0:b0:32d:8da0:48d0 with SMTP id
 o2-20020adfcf02000000b0032d8da048d0mr7662746wrj.68.1698130585678; 
 Mon, 23 Oct 2023 23:56:25 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 dk18-20020a0560000b5200b0032dbf6bf7a2sm9301353wrb.97.2023.10.23.23.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 23:56:25 -0700 (PDT)
Message-ID: <a6f97523-a1df-eca4-93bb-eb865d03598e@linaro.org>
Date: Tue, 24 Oct 2023 08:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] hw/arm/virt: Rename VIRT_UART and VIRT_SECURE_UART to
 VIRT_UART[01]
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Axel Heider <axel.heider@hensoldt.net>, Laszlo Ersek <lersek@redhat.com>, 
 Ard Biesheuvel <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20231023161532.2729084-1-peter.maydell@linaro.org>
 <20231023161532.2729084-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231023161532.2729084-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 23/10/23 18:15, Peter Maydell wrote:
> We're going to make the second UART not always a secure-only device.
> Rename the constants VIRT_UART and VIRT_SECURE_UART to VIRT_UART0
> and VIRT_UART1 accordingly.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/virt.h    |  4 ++--
>   hw/arm/virt-acpi-build.c | 12 ++++++------
>   hw/arm/virt.c            | 14 +++++++-------
>   3 files changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


