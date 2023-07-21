Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E6175C25C
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMm3V-0007sV-Nq; Fri, 21 Jul 2023 05:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMm3S-0007s8-ND
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:04:06 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMm3Q-00054j-6p
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:04:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3144bf65ce9so1314137f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689930241; x=1690535041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=itm0FKyjN5/vxgrrt4I4lgiwaBAR7s/jajZOvEtVBAM=;
 b=w3qNLkztdTr9oesKfz9ZYBrKF1v7c1FzcfzLVUCEblgezisksNx+UZqzy1fvGlVwDu
 YKTsdjt9+qAKT5a+eMH5gJnEihNuylJws9qHbYyAuMiYe4W+1PuQ+QCTIhIvbcWW1pbV
 y1gk7UDcoKUGAOCaY72/aTZB0wvsAweBPtih8R3ll6V0n2orcRxpH5QzzC8fWF8iAQGi
 lQ1JA2949F0N8O4g4rw4/1rsEccRXPxqtuu4NB8GzU3bKuYyK21Yc8zZ/BB26zVqA/MG
 x62DC87Xk7F0GlkSZhjGYVUYYqSqpynLKbEFIya9g4TIAdh72m/2dtVvxNN/KmRJPOFl
 RIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689930241; x=1690535041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=itm0FKyjN5/vxgrrt4I4lgiwaBAR7s/jajZOvEtVBAM=;
 b=Za8wE4sKyZaVAnGRxoKp7L+fDTqGSdMMpY4X9GUxUFckjlIRiKxhPy2bx4u1hCUHmA
 ePI0HExWIcl4cvRIGdUtUzJ19NJctc6TVbCdW/1aDpfXPV9jVGpftmIFzaiHT+IX23yW
 eVYoNCQlypj+wGGX8TAi6oQ9w45gg0+YiDSdaDIYLlHCHJqGCo5xjPep9BQDAoCX9dFR
 kapCKx30V5rV7m/Wh1/oLKNoHvzdbm9SrKufN/SAewue/jYqCgSPzXlprXu1CqUjBOB/
 +zYveH1lBKOHPrE/ay+xeuz6ifV2UxFZBFb8h4jm3deS5czAVpoRP5XWQGlvLNQ/zK7h
 ajlA==
X-Gm-Message-State: ABy/qLa/JfE1pPAFFwwxwEARDvtklD+VSCka6OBPg8a+TRZ3FnkLWRY1
 qL42bkFJEiFvsG8ZzRuYXzXxWg==
X-Google-Smtp-Source: APBJJlFZGaZJ0rgD8nX4hczjrdNxOWJ4qzVS3zFCfRLk3hvdTQk7WLM9hSgJ1XUoIP6GlOLGSXVTEw==
X-Received: by 2002:a5d:6ac8:0:b0:315:998d:6d25 with SMTP id
 u8-20020a5d6ac8000000b00315998d6d25mr1006839wrw.1.1689930241252; 
 Fri, 21 Jul 2023 02:04:01 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.192.5])
 by smtp.gmail.com with ESMTPSA id
 v4-20020adff684000000b0031431fb40fasm3589412wrp.89.2023.07.21.02.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 02:04:00 -0700 (PDT)
Message-ID: <7c8390cd-535a-be6c-2a4c-4e766c180893@linaro.org>
Date: Fri, 21 Jul 2023 11:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 1/4] hw/rtc/m48t59: Use 64-bit arithmetic in
 set_alarm()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <20230720155902.1590362-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230720155902.1590362-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 20/7/23 17:58, Peter Maydell wrote:
> In the m48t59 device we almost always use 64-bit arithmetic when
> dealing with time_t deltas.  The one exception is in set_alarm(),
> which currently uses a plain 'int' to hold the difference between two
> time_t values.  Switch to int64_t instead to avoid any possible
> overflow issues.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/rtc/m48t59.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


