Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9EB7285E5
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:59:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7IyD-0006Gf-RF; Thu, 08 Jun 2023 12:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7IyB-0006GE-Jj
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:58:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7IyA-0000oh-4W
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:58:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6da07feb2so8038655e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686243520; x=1688835520;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mbl/56nOOSoCxhi3xJo1Po2qXVzIJ7ip3sSulsfy9pU=;
 b=hagU6svHF6s4WeLRO0pFO0AOPxxvGfeO/P/pBSZhMES9mOt41llfJ/pP8IqOUa/vAh
 vyo026iK7oHKsLR0nkC5WbieH3Ij1Ly4X35HCqg9zxoe43pD694PR6fA2hkWrf4cxM4Q
 /43Xc7egAdXdaYe/vL62jO0+WbMSyANhJMnT7eDMgdyFN057F5/6LWjNSQt1OA33eMn1
 tJvGQ45zTnHfnS7M1/Xr+DB2FYbjMnmHkn3/Dr8knPv3Yxe+b92Jz8MDtQ1oZWCVXLIL
 PJtf0a2479NFY9XvZL2dWFzmk3Mh/N6kLrRd8bwFehaR6t4Pbrxl+qu7vNrG5k8Y6cWL
 Jraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686243520; x=1688835520;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mbl/56nOOSoCxhi3xJo1Po2qXVzIJ7ip3sSulsfy9pU=;
 b=EQHGUalMc7ubeV05nbqdlOtuxZbOCwrD9sz9b3gvvlBt6UkbsArJnSbcgukJ101WYY
 dc80jG6SJHuWsmYu1OJTrVAQxWHS0T5pPgTh7LgROGrrg5+uPhnkSbQEQ+v0vJn76hcP
 MNZPeuTp45UaGFuHwVfdEqUkZZ/tTvruuQsyZhpmAIo3yFY3omYZZeY3UGvQlfSrpRzy
 WSfiiDrhF05ut2lCs7XwD2ZBMdYmZpln+NGpUcdkE/Rn6XF++R5GJwXAxWc954TqFNbz
 m6wb7ca2MBHDMpMtGfkudfZjSvbKHvrHOPnDwVeSKYZO+hhZrtpM+ZdhfPLtdNCUt8kY
 ZtTQ==
X-Gm-Message-State: AC+VfDz48Vpj3dCb8SeMzWlWNQo1S0pPWPuCG+pBIRCqlS6WLzdH5OxV
 sYK2K8SkQ228TFkrW9jOBSBV6Q==
X-Google-Smtp-Source: ACHHUZ74K79v7RXQfw5Fk2iMc2mdzl0aRI5Gt0OXqBNAz1pjy5m/VLCaNzCaA/r/DOfoRAe3YBH1ZQ==
X-Received: by 2002:a05:600c:207:b0:3f6:76e:604b with SMTP id
 7-20020a05600c020700b003f6076e604bmr1945790wmi.0.1686243520034; 
 Thu, 08 Jun 2023 09:58:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.169.168])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a7bc3cb000000b003f7ed463954sm155780wmj.25.2023.06.08.09.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jun 2023 09:58:39 -0700 (PDT)
Message-ID: <cb9be1e8-889c-f315-8a8d-18b81dda3f4a@linaro.org>
Date: Thu, 8 Jun 2023 18:58:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] tcg/tci: Fix MemOpIdx operand index for 3-operand memops
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230608162925.677598-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230608162925.677598-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 8/6/23 18:29, Richard Henderson wrote:
> Cut and paste error from the 4-operand memops.
> 
> Fixes: ab64da797740 ("tcg/tci: Adjust passing of MemOpIdx")

I had this patch tagged for review but you were quicker
(not sure I'd have caught the issue although)

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci/tcg-target.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



