Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D9F780DA4
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:12:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05u-00051Z-Co; Fri, 18 Aug 2023 10:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwvX-0007p4-Eo
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:42:00 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwvV-0004ke-6T
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:41:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31ade53706fso693594f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692355315; x=1692960115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n6IgZ0rfNCif1gHHt+tORJ13/81yw0609dvPe88zHtA=;
 b=ndBBFNSubyxARv19LLB4043J27CNV0OpUgXWasjtH2r8BeBU+ctHo5Xn9RExZuVYzx
 yflP3NEO1KI1pfiNMM9q130LS7uTCFPLoCdu6D2XTr4SWJDTSKaQ44HCEtznYQdeLV5F
 40PbXEK93oG6HVLGf1J3fPNhQ9VBSnJiWO96WyovnQfNdGhRI9zqb2Zv0hbMHuQSvD9k
 tWVYSHxVGXPKV8fn5FYuiB1eXW3PZSdFvsujwrcPnb/+vyyKhIz/77O8HvBBzw+aeNv7
 W+2hqZeM1mk6aIS0S2Hs97yOFCyeg7OUjK3tKAcH1V63u3G0MkEc6v09Zjyb8Hvw4/y+
 rjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692355315; x=1692960115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n6IgZ0rfNCif1gHHt+tORJ13/81yw0609dvPe88zHtA=;
 b=MPBS3G7l2cB4XA8GzvfsboonXWXVmcWlFW10ZQXl/wVgpbiRooOaxPJbyQoyQjn9/u
 grvUy7JjgmCqF6Vkyl0rrshSOu8fVK0x4PnR1fFsd1lKcQC3SKcQwSj5Ql22nE2dNHVN
 oua49mhOyPPW/+quFb/Ok6acWirc3V/ZBSX2qMQjfIb5glWb1WkU9/PV2uvxFPiODuIM
 mTiFn022P+HFrJEty6Smg6g308AHqIWhYSQoUmN7PIeJUi4akakx9EUWFuG1MquDv1vk
 wGLvXjTnJPFQKOykGYeV87d9f4sBREKhlGqhjxdX4ln0+uaJCVF7LnWW+dwNLDZ8Za2K
 p5XA==
X-Gm-Message-State: AOJu0YzGbvkEsnoHYnq437o10NYNPAWXi0pYjoHfaIT3+LoDZ/9Io9xX
 1HyT4rnt+7anfmCIn+EDdk2iDw==
X-Google-Smtp-Source: AGHT+IG3XTDDOlgz1uTG7VcELjpB9TR7bkAEolt4l5/Y30IBDkAIy7f0H7bPxo+OCQ18jdpgn/ywqg==
X-Received: by 2002:a5d:698b:0:b0:313:f61c:42ab with SMTP id
 g11-20020a5d698b000000b00313f61c42abmr1637790wru.56.1692355315679; 
 Fri, 18 Aug 2023 03:41:55 -0700 (PDT)
Received: from [192.168.24.175] ([92.88.170.62])
 by smtp.gmail.com with ESMTPSA id
 z1-20020adfd0c1000000b003143c9beeaesm2352678wrh.44.2023.08.18.03.41.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 03:41:55 -0700 (PDT)
Message-ID: <f7929fcf-f525-ebd6-98a6-910d8c184192@linaro.org>
Date: Fri, 18 Aug 2023 12:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 13/18] target/loongarch: Add loongarch32 cpu la132
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-14-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230817093121.1053890-14-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

On 17/8/23 11:31, Song Gao wrote:
> From: Jiajie Chen <c@jia.je>
> 
> Add la132 as a loongarch32 cpu type and allow virt machine to be used
> with la132 instead of la464.
> 
> Due to lack of public documentation of la132, it is currently a
> synthetic loongarch32 cpu model. Details need to be added in the future.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c    |  5 -----
>   target/loongarch/cpu.c | 29 +++++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+), 5 deletions(-)

There are 2 distincts changes in this patch:

- addition of la132 cores
- remove restriction of la464 cores in the virt machine.

Please split in 2 patches.

