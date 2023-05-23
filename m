Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B193F70E4B6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:31:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WmV-00027U-U8; Tue, 23 May 2023 14:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WmP-00026x-7e
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:30:41 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WmM-0004vF-Pj
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:30:41 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ae58e4b295so50813525ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684866637; x=1687458637;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cGiD5oTyFUa2zfSOqU0XUn3zClzSDGZGGLGsC057/8o=;
 b=D9V2N4n6cq6MhNOVIHAzQ2ALOg7UxbYry1jfWoceM1NVujE9gykbFn64rhiF8SlpcI
 pd4sDRPqEuy7kDzONfa+alRjx760nLNQOat0L9R5802YBYdJI1SD3olUuDPfWZgCsQIk
 357Y5lZZhEtB8L24IO20N2cievNdgGfmzHI7yHGGPoqitKbO75UfEA2I/X5sAV1liL6V
 tzwhU3CkB6h4DEWC/fTZ44IIDesQX8WDxH3l5RDBOgZzyjN7mBQC57d5qkjPMcOtW9Vb
 lXlA3dgoFztC06W8YPuWXqnGN6Ydqld3Jf+JN4jQNrYFxEVdkFtE0QLdnHdimB5dkxHS
 Aa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684866637; x=1687458637;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cGiD5oTyFUa2zfSOqU0XUn3zClzSDGZGGLGsC057/8o=;
 b=KdCag95+2oRfulkeGNcKguMustnKrvSY7o+aAho6/5nDybD9fhs7Gxj9hWeAQKyZ0h
 PNV+xhxHJP4skKVyahBdobkOY1Vu4xS7isE/zq964VFWJU6iUnbG2KyHIDCEtkNQiW4A
 R144Ifxi4mJ1oEZpRg6+OHLSiS19OSnI7ID5Wwf8KtaMZqAZF5gKsnduHgyMvBYzoMgT
 1yLz3Ydtf8Oxgkgv7xeR1JWI/W8xYgkFV9K+nHImOaym7hztNGdeNEp0kDMF8V8e/4RV
 Xg075geEFvfAvJM8H7okm0TezFdm0DRoH/Tq1lA5M0ocBs92KhDQWCJLMnb9s6xImPEM
 YN+A==
X-Gm-Message-State: AC+VfDycse6w7fv0vAwTqXI+MluokKUYCJjVR0dVt8DJZT+BfiTTiJBH
 HHvdM/6UnOCbnJolRM0aq+lCRA==
X-Google-Smtp-Source: ACHHUZ7A6VoCxuOUQLsOWgg8GkEPNDjRsbt7lEFNvzqSaebHj39VQ0Qex6vUZRrATnFiQ6k8ZrN79A==
X-Received: by 2002:a17:903:1247:b0:1ae:8b4b:327d with SMTP id
 u7-20020a170903124700b001ae8b4b327dmr16628772plh.42.1684866637202; 
 Tue, 23 May 2023 11:30:37 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a17090282c500b001aafb802efbsm7137140plz.12.2023.05.23.11.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:30:36 -0700 (PDT)
Message-ID: <bc5068c6-502c-8666-ac58-b489498ceb23@linaro.org>
Date: Tue, 23 May 2023 11:30:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] hw/i2c/pmbus_device: Fix modifying QOM class
 internals from instance
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Titus Rwantare <titusr@google.com>, Joel Stanley <joel@jms.id.au>,
 Hao Wu <wuhaotsh@google.com>, Corey Minyard <cminyard@mvista.com>
References: <20230523064408.57941-1-philmd@linaro.org>
 <20230523064408.57941-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523064408.57941-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/22/23 23:44, Philippe Mathieu-Daudé wrote:
> QOM object instance should not modify its class state (because
> all other objects instanciated from this class get affected).
> 
> Instead of modifying the PMBusDeviceClass 'device_num_pages' field
> the first time a instance is initialized (in pmbus_pages_alloc),
> introduce a new pmbus_pages_num() helper which returns the page
> number from the class without modifying the class state.
> 
> The code logic become slighly simplified.
> 
> Inspired-by: Bernhard Beschow<shentey@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i2c/pmbus_device.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

