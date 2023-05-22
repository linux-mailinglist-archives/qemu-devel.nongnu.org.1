Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC870BCF6
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:09:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14LO-0000o5-Av; Mon, 22 May 2023 08:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q14LG-0000lB-AG
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:08:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q14LD-0003Mh-LS
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:08:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f4271185daso59651325e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684757322; x=1687349322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sh4pBHBvg+BmCESADlKiWS6YEFw9DmsXIdZ9+r+yXZQ=;
 b=nqBAPZgRsCZ1J+/NpFZeJR1QDB1NpbxYq95Q79I1/W8f1Vln+fh4dAGmuGWKthb7gU
 HvXdMHiRF/zdmor9IaLrPnNylk+epCdwdNnPYS4hdpOTGo2vdQAWYbe1iJ+zyk/IqH5f
 qGOCsw496rmOxCRjb9hz+QUiXZgHC1dtMtHk3QdVeOmHBdLAB4jgTLnuip5hXG3velW4
 wfKov4rzar0I0wFFkisnPF6E/qlrPvRkSGB9zk7NL4UfILJ12mf9G3euhWuLRHR/A2UE
 fr0mL0ywgg2yns+T5Mp7OebBizVtejEkj27NVYBtgPw75YKvY5NwmuB86iKy/gQMU7y8
 IrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684757322; x=1687349322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sh4pBHBvg+BmCESADlKiWS6YEFw9DmsXIdZ9+r+yXZQ=;
 b=fvXB7B0WliuRiAmaOI0S56m1tGqB7wahVcSlr2pn0jsDbfSBl4hnGs9vqwcoYxUNle
 OmYq8iM0Ttg0h6W7uvUajt9jwED2qOcIpEECDpp5cDvAUgP5yeIp1szK7N1EfpQasl2z
 3MOh2awly0sjd7culAkJybTA3cN677eMSNEedlACV82rKktCixi8gGu3LFamz82O949z
 LiSCI4UJNg52q3uOmYvSLGwMXJ8S/azeaPgyeXTDnjA/RyQXY8iCP0oiPwrLdj5pK9q0
 q8G+rS9bp/GQI6zpz8cnIrD5O116F9MKyKsHf0+es58iPEFRcovxhx6A3EWQFI27VPff
 wOQA==
X-Gm-Message-State: AC+VfDxVocPfmbo3A/yIKkVLX8eEaaADfqcaInW9GqtEYd59I49/0eLt
 69JOEbb9RfhHkmVqS4gh3QzXnMveuG2u2RSyVRo=
X-Google-Smtp-Source: ACHHUZ4/+09EysC/kZAEwHHo2uHu2yRcPA3V07ttjBNOXcI1miG4UIOvXabiFawmtPQ3m5Mv1nFmeg==
X-Received: by 2002:a05:600c:cf:b0:3f4:2572:2259 with SMTP id
 u15-20020a05600c00cf00b003f425722259mr7241057wmm.28.1684757321764; 
 Mon, 22 May 2023 05:08:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 x26-20020a05600c21da00b003f42d2f4531sm11387026wmj.48.2023.05.22.05.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 05:08:41 -0700 (PDT)
Message-ID: <543abfb5-87b6-e4c8-a88e-72c9369a6b5e@linaro.org>
Date: Mon, 22 May 2023 14:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] hw/mips/loongson3_virt: Remove CPU restrictions for
 TCG
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, chenhuacai@kernel.org
References: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
 <20230521214832.20145-3-jiaxun.yang@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230521214832.20145-3-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 21/5/23 23:48, Jiaxun Yang wrote:
> After implemented CPUCFG and CSR, we are now able to boot Linux
> kernel with Loongson-3A4000 CPU, so there is no point to restrict
> CPU type for TCG.
> 

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1639
?

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/mips/loongson3_virt.c | 4 ----
>   1 file changed, 4 deletions(-)



