Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCA07839EA
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 08:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYKsU-00019l-Tb; Tue, 22 Aug 2023 02:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYKsC-00013V-2i
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:28:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYKs8-0000wE-AE
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:28:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fee5ddc334so15724145e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 23:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692685689; x=1693290489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DcOmhX0UxImlx6JRWL0lqNFcdjPz8w1x8hhLYwR9o/k=;
 b=iI0RU52hw3lmY9LDuvz5dGegFfFDZv1+DkCY3TYSgDTEThb75ikPjEiW/AxO8oakMg
 N2WNkMGubcf9o2d/vX4lHyih4RbJTxpZKHIXQGAHTwxFibMqibU1xQkZnxsuh3udRP/n
 NjuVb+paF2b4Pn4zfz0Z29frLUFfPnfyWMDAnvNh0Ge3Y+05C3ak555gfcaoii/Eb9+D
 626DGr/TGnaRTI1akOfmxIOQE2YDY42Yei7eig7guzYm/MqyoJr6bcGBar5exvJZ807s
 +d4N1a5guCLnAHNJRYWyPBWUAlrLYYDYfc9a35jVVjgtE4zWUQjXIzup2eObxHrURSlu
 LrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692685689; x=1693290489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DcOmhX0UxImlx6JRWL0lqNFcdjPz8w1x8hhLYwR9o/k=;
 b=VdP6yxx5EsSvXE+nQYM06z6p0mODgDDZdNBfF0OtWYznWUEUqFc5LxxlJgdFBOHiKt
 YxM6x97Q1xl8mw/zjNzp2DV1m/3jrJavM8rV+FmbFpj0UmeANh1ibadTyqye0d+YwatB
 qDEGwCSdYhQpxmBsk+Me8/9IZkRa+B4TbABDoeVZxyNjG2N27Q+JquFhmImmCs/EEhRr
 6dpL32w3uSVPxC9D5p+G7tzaTgaUt5KAu1iMwdi3AkTWCnyR4i0llVaZMcShXKJ+ZL/I
 /pnh4I3rwQSdoZgjPo1zbEJ/wfYwNiv0t4ajIN+PkZQ6czkyyzQl0ivlMorYuxURhVFi
 irtw==
X-Gm-Message-State: AOJu0Yy3k3lNtdGLaJMfqRTVr184SOvyCnMnquCcfQPjEV0Ef83C1Rlh
 CDnMCt/awxGuGtHzPp0xk5VJoA==
X-Google-Smtp-Source: AGHT+IGtc/IMDmDOAMSS6BbmVOK33brl60wvuU6lELg3bdE5TSIjLdLkh1IiDamBnBQijbbCzXgU8Q==
X-Received: by 2002:a7b:c459:0:b0:3fa:aeac:e978 with SMTP id
 l25-20020a7bc459000000b003faaeace978mr6499974wmi.0.1692685689268; 
 Mon, 21 Aug 2023 23:28:09 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 s5-20020adff805000000b003143cb109d5sm14699699wrp.14.2023.08.21.23.28.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 23:28:08 -0700 (PDT)
Message-ID: <543fa35c-e8ad-2648-edaf-420f8b4722e8@linaro.org>
Date: Tue, 22 Aug 2023 08:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 8/9] targer/arm: Inform helpers whether a PAC
 instruction is 'combined'
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Aaron Lindsay <aaron@os.amperecomputing.com>
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
 <20230822042530.1026751-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822042530.1026751-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/8/23 06:25, Richard Henderson wrote:
> From: Aaron Lindsay <aaron@os.amperecomputing.com>
> 
> An instruction is a 'combined' Pointer Authentication instruction
> if it does something in addition to PAC -- for instance, branching
> to or loading an address from the authenticated pointer.
> 
> Knowing whether a PAC operation is 'combined' is needed to
> implement FEAT_FPACCOMBINE.
> 
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20230609172324.982888-7-aaron@os.amperecomputing.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-a64.h    |  4 ++
>   target/arm/tcg/pauth_helper.c  | 71 +++++++++++++++++++++++++++-------
>   target/arm/tcg/translate-a64.c | 12 +++---
>   3 files changed, 68 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


