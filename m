Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6572F717902
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 09:52:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Gd2-0003Jf-RK; Wed, 31 May 2023 03:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4GcV-0002yj-Pa
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:51:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4GcU-0002cm-7i
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:51:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f60804faf4so39227045e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 00:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685519504; x=1688111504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3qlOK+ftNuBGTiMA3KNZlYphOfstAULPm6xczj/9G8k=;
 b=VrEbZEin11PLbjt45eJ0lA7cMCBVj2WVdKCUvmLfGiWpN1MgXuGRtMDAnDGSt3URNs
 7RF+2gN4qetv4j3uzeh3EWg9IOBYNP0Vi7JQzk24vnpxe8bUyWVYcHL3RACTiGPz4hlU
 HkfdABotE7fxuHDU0Lu/XWSsJOoSj7YFjqRKHGquiNBj8rJx8B+dbUgtXN7IgGpQca3i
 gwRuEMmRq7sj7DdMGOxuFtDmOLYuYGHGSBHNaHu5QtjcGDsYW7mZWhuLe8NDRYkaNhAY
 hIWEqS/DLcwsWPQ9ThfVDRRr6aV7FDeRu5jbnnm4MvwbLZZNisgDkl8rtf34kgRa7GeF
 1ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685519504; x=1688111504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3qlOK+ftNuBGTiMA3KNZlYphOfstAULPm6xczj/9G8k=;
 b=EOFaK7dJufn/ZT3yA2sbOGT0DghZDke2Ga6heAuXPJEnLHRwlFRM02fUJAQIs0SKeH
 u8DMC2zFmg0RZIJGwlSbeMVv61rfpRwE7AJLWFsixbPyAz94wLiLw87XT+Hn8LuZddx4
 4E2Ra9YH1W00rUQ63HhbMXlxtSC2xZSL2q96qKzvi9O/nYWEC4Mna4QAH3+tS57/dB6D
 XYx+bDuWTbeBMINtuIJMQSqM2qf3/RG4pAfw6OGNW5ocebl+1Q7hVx1ZvpfnV3mwInVH
 XWYcS8fnnosDPmlai1vqqaETSq9eiol7jwKCHB915cWDtWvFnxfBwGm8HLFhrzwblW/x
 r2gA==
X-Gm-Message-State: AC+VfDwszpwoUHuJII5JxCYPJOcBVDwwlOoojobo0zVcAzY1vaRglXYN
 st1DwsFLUqAWKZjktQf4///icQ==
X-Google-Smtp-Source: ACHHUZ6V++YkpoCfFDOTbZLxT/P8GUYpQAOFfUhq6cY4Y77b+vAGjqaZ1w3dyXUQ4Xt7CXTNpEN8KA==
X-Received: by 2002:a7b:ca45:0:b0:3f6:7fb:b60e with SMTP id
 m5-20020a7bca45000000b003f607fbb60emr3071255wml.35.1685519504649; 
 Wed, 31 May 2023 00:51:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a1c4c12000000b003f423f5b659sm19686274wmf.10.2023.05.31.00.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 00:51:44 -0700 (PDT)
Message-ID: <5ac2e71e-7bc0-ee84-fce2-8d0b6e137a3e@linaro.org>
Date: Wed, 31 May 2023 09:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3] hw/cxl: Fix CFMW config memory leak
Content-Language: en-US
To: Li Zhijian <lizhijian@cn.fujitsu.com>, jonathan.cameron@huawei.com,
 fan.ni@samsung.com
Cc: qemu-devel@nongnu.org
References: <20230531060706.11840-1-lizhijian@cn.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531060706.11840-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 31/5/23 08:07, Li Zhijian wrote:
> Allocate targets and targets[n] resources when all sanity checks are
> passed to avoid memory leaks.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
> V3: allocte further resource when we can't fail # Philippe

Thanks for the v3!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> V2: Delete unnecesarry check
> ---
>   hw/cxl/cxl-host.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)


