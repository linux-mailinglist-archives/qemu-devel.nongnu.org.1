Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCAF7880DA
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:27:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRDm-0002dn-0K; Fri, 25 Aug 2023 03:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRD4-0002RX-AX
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:26:23 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRD2-0004Qm-4N
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:26:22 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52a0856b4fdso881400a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692948378; x=1693553178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1x5iaUuIxvpqvb6RKgT45/hd4/Cfy8Q+3vcDPbxCl3A=;
 b=w9VQuYLXXYL1hr7EANASsbxmZbWD0d/ESlSo0CTluvu0NOFzPpNp2Zkz3faNRW29ty
 MOVM2lZeRWqcMEmhuK0Fr+RKTj1HR/LX45FpFAszOz8POxp/qyT34wVFLtGBBHjW7sYc
 5AOZ8wBFMOirxpZ/dCqTfNprQBt9pXkmcBC71ElEBX32ZBJ6ZZghwNs/S7cdT8u8p1AG
 g+rPhvPL1vAyODi2RMP+LK2OjUQuR9pkp0ACNQX2wpbOUAKlpQYDvdSe5kPUbgxAT//5
 9zNvDcDnQT4L611G/CPFWPaYpEaZGgTcjztk8RERxZrehKJ9xU8SLoHmU0/MfDz4NHxf
 ispw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692948378; x=1693553178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1x5iaUuIxvpqvb6RKgT45/hd4/Cfy8Q+3vcDPbxCl3A=;
 b=YUL9MkI3rPVslcDdMt27bOkhQs9CAo10elcxhMxiepOW/aHVTbTDCNRwZUL/uT3OfR
 Lc8CsvUd+aIpQenEpOA2t821eOh2R1M1GEQO8KMFO5d3omXB4RddWyrgI0DX5dErg932
 ZiWSCMcClJnzb01RxYtlpgIa6j79P3Y6txCnf9gNZHQThse4WO7Kcg1uX4/ztRlYnshv
 tAw3VQpjO3lOnPo8//RQQZLahw85pmzag6E/QtBRizB8WS62p21iGNI+a15DjpjIdbf0
 WipWN1loNRhqgn9Kqia0/t0mnCU4cXBwi/6lJPKH6lacpx/yQgBIazruB8DHlveeFCdO
 1EyA==
X-Gm-Message-State: AOJu0YzmI0WAcTQooFdaxkfNuELZylAj6Gcb36porrFBc1LQsrKCEJHT
 Q/KjgCxWzpC3PKssa27uEmWJ+w==
X-Google-Smtp-Source: AGHT+IHLzz/vubpH5rEi1lbd9n83j1GAkiNO7EM2m6KPmqz1FopKRyp2q2AfNdnVs5UifpMLdrenzQ==
X-Received: by 2002:a05:6402:6d2:b0:52a:1c3c:2ecf with SMTP id
 n18-20020a05640206d200b0052a1c3c2ecfmr7749796edy.28.1692948378310; 
 Fri, 25 Aug 2023 00:26:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056402050c00b0051bed21a635sm697878edv.74.2023.08.25.00.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:26:17 -0700 (PDT)
Message-ID: <431888d7-5ce5-109e-7cb3-8885afd961d5@linaro.org>
Date: Fri, 25 Aug 2023 09:26:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] softmmu/dirtylimit: Convert free to g_free
Content-Language: en-US
To: alloc.young@outlook.com, yong.huang@smartx.com
Cc: mjt@tls.msk.ru, qemu-devel@nongnu.org
References: <SA1PR11MB67609A76D397056973B406B1F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
 <SA1PR11MB67604ECD85AFF34BEB3072F7F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <SA1PR11MB67604ECD85AFF34BEB3072F7F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 25/8/23 04:32, alloc.young@outlook.com wrote:
> From: alloc <alloc.young@outlook.com>
> 
> Convert free to g_free to match g_new and g_malloc functions.
> 
> Signed-off-by: alloc <alloc.young@outlook.com>

Fixes: cc2b33eab0 ("softmmu/dirtylimit: Implement vCPU dirtyrate 
calculation periodically")
Fixes: baa609832e ("softmmu/dirtylimit: Implement virtual CPU throttle")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   softmmu/dirtylimit.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)


