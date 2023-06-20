Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C744C736747
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:12:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXPF-0004NK-E4; Tue, 20 Jun 2023 05:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOz-00045S-Bc
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:53 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOx-0000au-PU
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:53 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5147e40bbbbso4597043a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687252309; x=1689844309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MJRO8tyVqDCIFkY8o7qpfxPCOnc8l3jQLyLm7DugAyQ=;
 b=KXcvM2C0kDRECbYGCH0zvInt4kY5hfVNNT51EG4fUPb3O2C+D0PyyM3lv5YTrljQyV
 E+nOT6/QzAjkusvgGauvy8o46JEvRb4HK3T0yPpITSUlaBH2whb8OwY6p4hxIeFuiShu
 XiLxgKacS4zJEJasOJ1PeYbscIp5h2LO/PZs60ouQUS5c/u6i10aJk+hj7w7YeeHDzm+
 1O++0WMRskguvk7SxHsGiy8ZfGwVCE9x9w+b1H3GBT2cYsF32NU1TDyncZy7TArUJowd
 zFDaLAJiFhFv2OoeUpuf8los8aiYu/R0R3YKLzXcBXadFSiRkvIBT+QM43DawR9t9ero
 YhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687252309; x=1689844309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MJRO8tyVqDCIFkY8o7qpfxPCOnc8l3jQLyLm7DugAyQ=;
 b=JB43iFBJMAH5WLpCFWuzXwIWhy6oLCDVhISO72KEDIBqmGSTndEt+S2IBMbi9QMXgK
 DqDyToq2sH7QBw1JBLMo4MndZnii7rGKG5nBSipxkQoz7R65PSwblQU5YG+Gd2Gjxex9
 CNoDBC+hgKBLaSZvIbm1Ann42g2JP9bTxJwxUPL4QNEvJWWjtvCNf6SpjWBxea02t3WQ
 MesYZ0R474pEJZOUSR7ELLKLQc96U6JMId+HfEAF7xxuiXOSbAb+6eaVs2xY3Tctuxeo
 UXVa6o3SNrCumMPS7AIPuwIy94XWjt/0X79jK+CxwGQstMW1Y3I9ouo6l57FPnU/rdrA
 0y+g==
X-Gm-Message-State: AC+VfDxZ1Nsa+MshASH86P1TsTqL9CzndD1cwKG1glDChHIX+czE5daJ
 EsUNmY83ediFj/HpnoOq7qvhBA==
X-Google-Smtp-Source: ACHHUZ5A6GgIN6q1+6n/ZVJR8/56GDaJcCfI7boBUCOFi4MHWOvxCfZgV8Ao71dkvI2uwtCn5mgbhA==
X-Received: by 2002:aa7:d0c8:0:b0:51a:4a25:bfbd with SMTP id
 u8-20020aa7d0c8000000b0051a4a25bfbdmr4772002edo.36.1687252309460; 
 Tue, 20 Jun 2023 02:11:49 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a50ed90000000b0051bc5adc942sm839520edr.47.2023.06.20.02.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:11:49 -0700 (PDT)
Message-ID: <1b1c4789-b14f-25da-4cd3-91a34abc1af3@linaro.org>
Date: Tue, 20 Jun 2023 11:11:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/9] ppc/sam460ex: Report an error when run with KVM
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-7-clg@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620055911.187065-7-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52f.google.com
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

On 6/20/23 07:59, Cédric Le Goater wrote:
> The 'sam460ex' machine never supported KVM. This piece of code was
> inherited from another model.
> 
> Cc: BALATON Zoltan<balaton@eik.bme.hu>
> Signed-off-by: Cédric Le Goater<clg@kaod.org>
> ---
>   hw/ppc/sam460ex.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

