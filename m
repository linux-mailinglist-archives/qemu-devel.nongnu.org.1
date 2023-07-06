Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5474974E
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKCI-0004DH-Bd; Thu, 06 Jul 2023 04:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHKCF-00046T-2R
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:18:39 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHKCD-00009Z-HI
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:18:38 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b700e85950so5062311fa.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688631516; x=1691223516;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=99MkBIFkFUyMGq2bgh/Nj1CPSULcbhLk9oV3UwzCT4w=;
 b=l/78PSBHXz2cZMQNcH3ZhgGaKNo7bEaW2RpK8MpFSFJYHlulpOx4MT1KFat36atvVh
 ndBr0yzpzPL/oX/waRSz6oC9YLgul9CDcJjd5w4mCUOdUKYJQlrlPDfvFCdR8SOaO6hw
 AItHdusWRrkCZ1L12TAVWF1P9K1LBRGzRc8QHxdzicOAeHUH8QgcK74lkhLRD3/fNv8C
 oS+qcZwY15cEgffbFBhULfX6F/G2v1NNJ7bqli1HovEmhMq00Hh5imgwCR3are436c51
 tlVcbTBRnNXguiUjqHnb18yRj9gKQgwbHNZFxUiMcHP6+gxY722en4jGLdrYWBdRTbPa
 rI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688631516; x=1691223516;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=99MkBIFkFUyMGq2bgh/Nj1CPSULcbhLk9oV3UwzCT4w=;
 b=ewsqQI1Y30V7VFerHv2IL/C00tIQPHwzsaVknMWSsIaS8NuLZwTIU8gYx70A1q60if
 aRSUuuMj2COLYsFffCrOzXT7D6tbUj0un5Z6xzVMbxcaTommQXVVon45zPdk8/JXyxtK
 5egU/iMtBBz5s4++rQkhgd5wsxm3a3FDFn1KyCaTJkP7tk1X1/jTLS4w4evd6JkCG0Tu
 VbU3Wwosy7D7td+oqSedLHYu3rzkWaFQZCPuf5/j5xTVzBxbpfENA7mMuO/DAaEztnk2
 Td1jqFsU+U3rNaWY+K+syuIMagpvz5u4nukVDhNgsGBmuE/uPnkpZpgDDQeOTvsRss8I
 aOsg==
X-Gm-Message-State: ABy/qLaSqsd92BhF4zojexYQt75mPh8NRytNcHuBpsEhrX9mKdXkMvHA
 I3baRtbc+OO41/Ymoz09CqQIlcDz4ryGUT7GwTU=
X-Google-Smtp-Source: APBJJlGLBgmq7rHlW/LHsA29CCiFxYOO1MXSZLpUEPWBpBG9xfaZD3OsyoWBijWGCZ2FqdNSWBaJRg==
X-Received: by 2002:a2e:9497:0:b0:2b6:decf:5cbd with SMTP id
 c23-20020a2e9497000000b002b6decf5cbdmr729455ljh.36.1688631515630; 
 Thu, 06 Jul 2023 01:18:35 -0700 (PDT)
Received: from [192.168.82.227] ([91.209.212.17])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a7bcc87000000b003fbb8c7c799sm4380319wma.30.2023.07.06.01.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:18:35 -0700 (PDT)
Message-ID: <9c5e5180-2b58-b6a9-a971-064ff7b699f6@linaro.org>
Date: Thu, 6 Jul 2023 09:18:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/46] target/loongarch: Implement xvabsd
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-13-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-13-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22e.google.com
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

On 6/30/23 08:58, Song Gao wrote:
> This patch includes:
> - XVABSD.{B/H/W/D}[U].
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/disas.c                     | 9 +++++++++
>   target/loongarch/insn_trans/trans_lasx.c.inc | 9 +++++++++
>   target/loongarch/insns.decode                | 9 +++++++++
>   target/loongarch/vec.h                       | 2 ++
>   target/loongarch/vec_helper.c                | 2 --
>   5 files changed, 29 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

