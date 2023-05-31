Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F27718BC6
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4TLk-0004q7-V4; Wed, 31 May 2023 17:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4TLf-0004ok-IJ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:27:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4TLa-0004In-8I
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:27:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f6042d605dso1207515e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685568428; x=1688160428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SW/+TbGhA4RHppAD6rt/axl6D2uKL/I7es7PvuXgBXA=;
 b=pzjsH71v0AgdKe9uRFG+cjavAtaXh9gUzeaXONwfQReqvcCVUcQfqMQX6cP+ChiRbt
 bTt4cfG76dbET5rvE5ZSUlnDnFrbF0aGT7SvmSIvXyRK8ftzSnCwHkyKuF75cEk1L/gg
 uvyXeqtoVpTsJMvyoxXU2yEOXigCjLA/QqhsXAIjF+ImohZ/l3Z5tZ1i0LMFVaDmvLsJ
 YoX2n/81Bl+6zTpQYN14wJ/rrHWZCnFnLUmD8i3CVPeKu6Vj/6SPjMk9SXPasKZmkmOL
 9UMuzjunSRuHMVleyTKpqCn3/1M5kK02I3jlGV5nmJb3N6qPCoJQ2LIGGcTRLzfR69iI
 nPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685568428; x=1688160428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SW/+TbGhA4RHppAD6rt/axl6D2uKL/I7es7PvuXgBXA=;
 b=cQsJ6re4NgDoWFZ/u8NUYj0ExC2bcoqVd5Nf1Zp60jzcnlGs1hLRhABm1DNpOGytvj
 yE0CNfgrRvORE65bGwgSs1QcKOruNAHMm8UnXgFy8ve8/fOVJj3rtDoV2a1SwnD77/PR
 248NOLzPknNGOe9Zteq/tpt8ll9UhwZRMwSNtJlAx0pqKbd3xIZUkP9cDpenrKZ5Y94k
 cNpdrUumQ6p8hzKEZ2mt3RUXd9zErhxptITOOSHh9BvShhbHfJbqNdfwrbwBpmelPU8F
 ZbWe9+82oaMs1S3aDE3OV9+IJAiuw0VfZnngvcDX4N5GUw0rn/ITVLKGVjKMsR5TrSMt
 cp8w==
X-Gm-Message-State: AC+VfDwYkhyPGlv9xp5mDKcx1QRUGbVHcpFrsf/PMv292ea4pcp51s1M
 mlES7DUbyEU96T8RayT4S/WWmw==
X-Google-Smtp-Source: ACHHUZ4H0efgp+Ka012y5lB6aAyiuHcu7A1+7GVYZWq0g8730yY5brw3gb6wEi+eLSI00h5q6EWLrw==
X-Received: by 2002:a5d:68cf:0:b0:30a:f0fd:dca4 with SMTP id
 p15-20020a5d68cf000000b0030af0fddca4mr287105wrw.3.1685568428510; 
 Wed, 31 May 2023 14:27:08 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 i2-20020adfdec2000000b002e61e002943sm7844853wrn.116.2023.05.31.14.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 14:27:08 -0700 (PDT)
Message-ID: <61ca40f3-f8e0-a0c1-ac85-8c0b52ba2c6b@linaro.org>
Date: Wed, 31 May 2023 23:27:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/7] hw/isa/vt82c686: Remove via_isa_set_irq()
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230531211043.41724-1-shentey@gmail.com>
 <20230531211043.41724-4-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531211043.41724-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 23:10, Bernhard Beschow wrote:
> Now that via_isa_set_irq() is unused it can be removed.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   include/hw/isa/vt82c686.h | 2 --
>   hw/isa/vt82c686.c         | 6 ------
>   2 files changed, 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


