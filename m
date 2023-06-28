Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A08A7410A0
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:00:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETqO-0005dn-ND; Wed, 28 Jun 2023 08:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qETq5-0005bV-9U
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:00:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qETq3-0005kg-MU
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:00:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3112f256941so5158469f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687953598; x=1690545598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cgs/bOBaRWcfj9s65iw3KP8foJQTGAj5CEZ2u4EjCOg=;
 b=VpCjj8LPaoYGLgFYgGRfZkl3kwlw/728NM2kc3ncj0ZEeF2BblMcB8GhoIJx0YQwJz
 QiN4DAr6ogMjs9j5X4N8hAgNdsy7pa3cQAa72RmBRIV42tuklhb538TupXBycDqKN00X
 0NHTAtRjt6OP65JP5UhrVpWfx1U5eNSfPSkKkm/8zVaEbbUBFUeugCDhjEjfGM98T9Er
 /FKDc8DCsFPI5tJUZ17kFLA7O4/aVAbUEWY240UydCJjTjlUHsfKa2TffqgeK7HaP2Z3
 Bsc/oUhVyIg5zN4HMz/uzT0dksaDl5kG48xTB9FgwgBnVEBmmmhCCLxPNYXewFU6IO0n
 8M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687953598; x=1690545598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cgs/bOBaRWcfj9s65iw3KP8foJQTGAj5CEZ2u4EjCOg=;
 b=H9gCmSONBfZJMe2a2sMb+0RbG0dkxt/5HUCTtYuKzRL8MGeT9Uabvq+Dk97srn3Eut
 Kc4lHdBOEhloB4xvXi+L8QfbpJCudhQa2u2x8rsw9oMtwhQBaK2LqkNXn6iY9+v/+oIF
 GS0d2pBArJ/y6qVXeIimIb6U18fFd5SViDoFFxwMt3b4IHLkwlnC0Noy3ZIk3tM05Dpf
 37H5xl8/fDMG05sNqzQg1hbqvWOkMwv7HNbUEZXth0Hjg8cYpAM0QeLJemTyaW2HGe1+
 9avs9fz6y9qyJ9kjnECP7noVcTko1XeULozGeXGhgTzxbtHkNzkVY4urjNvQ8dsExgYR
 tWHw==
X-Gm-Message-State: AC+VfDyMvOj50TAxbO1MzlMqGqFIKxB3pydKwzkouDKdvC0r6h8XJl2P
 VtJVlT8tE//PiHlZz5O4OTHV5XR7JtEE6d+Zss0=
X-Google-Smtp-Source: ACHHUZ7IljUTP+ZUsoaQrnCCUUkyGQiW6iVcMWelOjCHIIcC96wlavKghBZdczKV9e2iX7frWHQv3w==
X-Received: by 2002:adf:dc91:0:b0:313:e897:67ec with SMTP id
 r17-20020adfdc91000000b00313e89767ecmr8991274wrj.5.1687953598055; 
 Wed, 28 Jun 2023 04:59:58 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a05600004cf00b0030e52d4c1bcsm13325554wri.71.2023.06.28.04.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 04:59:57 -0700 (PDT)
Message-ID: <1f4b504e-43f2-5adb-8d93-de20bd577e37@linaro.org>
Date: Wed, 28 Jun 2023 13:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] i386/WHPX: Fix error message when fail to set
 ProcessorCount
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20230529124331.412822-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230529124331.412822-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 29/5/23 14:43, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> 003f230e37d7 ("machine: Tweak the order of topology members in struct
> CpuTopology") changes the meaning of MachineState.smp.cores from "the
> number of cores in one package" to "the number of cores in one die"
> and doesn't fix other uses of MachineState.smp.cores. And because of
> the introduction of cluster, now smp.cores just means "the number of
> cores in one cluster". This clearly does not fit the semantics here.
> 
> And before this error message, WHvSetPartitionProperty() is called to
> set prop.ProcessorCount.
> 
> So the error message should show the prop.ProcessorCount other than
> "cores per cluster" or "cores per package".
> 
> Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/whpx/whpx-all.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Patch queued (fixing the unsigned format), thanks.


