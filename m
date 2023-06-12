Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7FC72BCE2
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:41:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8e2q-0008Ce-8V; Mon, 12 Jun 2023 05:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8e2P-000848-Ea
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:40:45 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8e2N-0002tQ-NN
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:40:36 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f640e48bc3so4690719e87.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686562834; x=1689154834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zaVKK1pptnGakojauiMMN/tH0F5JMg1T2+g1TMiz5cw=;
 b=FucWZXiimfJ50XXS2d4F4hfKjFSk5r5WfyzWKL8rHRWDHRS7WW4ilM33G+89rK5r0s
 OAzwe5/H+gu7gx94IQRcLWCOnWE2vXMiJhgGaDKFqmv1PysPNmUkBMG0ZhoeMKmTdHAX
 kJ9txRwEO+MUWrR8TFTtJwGi9sW1aJN/aU3HrLfVjRoSG+4aOLQmR22nw9vw5ex4rU3H
 S8GXL6zcGDVyzAYmLd9r3REdD5hK6lXQqe2H5JHNjvvGuxn88CCqIwVPxLdiyUXH1gzj
 J6FA0xxcUT9TA34BnkEgDHGWrBCUFXAlX+LoqyCTcn95ygSPBunLbdM9ceBIxD0KI7BK
 hYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686562834; x=1689154834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zaVKK1pptnGakojauiMMN/tH0F5JMg1T2+g1TMiz5cw=;
 b=lDEvHzAj1NSVTDRUIQhRHPRwopFsLzcjnxHbbfDiHZN68MPrqU12POJOCSJDevDbaF
 VzByYuHkZI/zCjO35c7Dg6DaeI4ploHYexPr7AhSe6yJUB2+XIjFxCMspkZ35a67QYdt
 P05v3a7/hvWlhURguO/sO/hSVxgp1EZC/rITvzZSkT2I1o8smeP+0g2kOp8DdkPt1aaS
 adMlKkNQy+oxGdkVku9/Uhf/GncC4zGXizAiQHjF1nNKuWU0xeh+NCmgA07C1aSnJ2DM
 4jKukPX8kg4hWO1jBk+AwrDmQNwaVM5DdQtAz2kb1r52bLHzrHIJpqh8thDSLttQvXde
 03ZQ==
X-Gm-Message-State: AC+VfDwfiPFK/QmgPuCr504IRYdeEdjniN+ACRgtOLgfIZ5efxelsPTf
 Y2zeBCynic1EtKdGFiW/uC7Jkw==
X-Google-Smtp-Source: ACHHUZ6m+h/JR2v25Bf6k17orkDPjjRleKdsaxSTNT8SEt+dvmsqWwMDB3G/R5cPzaj09YTCS4ctwg==
X-Received: by 2002:a05:6512:539:b0:4f6:1462:9985 with SMTP id
 o25-20020a056512053900b004f614629985mr3238113lfc.21.1686562833812; 
 Mon, 12 Jun 2023 02:40:33 -0700 (PDT)
Received: from [192.168.143.175] (17.red-88-29-166.dynamicip.rima-tde.net.
 [88.29.166.17]) by smtp.gmail.com with ESMTPSA id
 e13-20020adfef0d000000b0030aeb3731d0sm11922083wro.98.2023.06.12.02.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 02:40:33 -0700 (PDT)
Message-ID: <d21d02f6-5070-5565-f025-5b9940e76734@linaro.org>
Date: Mon, 12 Jun 2023 11:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 15/15] hw/i386/pc_piix: Move i440fx' realize near its
 qdev_new()
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-16-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230611103412.12109-16-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 11/6/23 12:34, Bernhard Beschow wrote:
> I440FX realization is currently mixed with PIIX3 creation. Furthermore, it is
> common practice to only set properties between a device's qdev_new() and
> qdev_realize(). Clean up to resolve both issues.
> 
> Since I440FX spawns a PCI bus let's also move the pci_bus initialization there.
> 
> Note that when running `qemu-system-x86_64 -M pc -S` before and after this
> patch, `info mtree` in the QEMU console doesn't show any differences except that
> the ordering is different.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_piix.c | 57 ++++++++++++++++++++++++-----------------------
>   1 file changed, 29 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


