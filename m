Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B6F78BA3F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 23:27:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qajlg-0006K6-MH; Mon, 28 Aug 2023 17:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qajle-0006Jy-B6
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:27:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qajlb-0004SO-Ii
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:27:25 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31781e15a0cso3288690f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693258042; x=1693862842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9CbcvBS7jJO4ohUzTPG7fpfV8a2Wa/7fjkgRp4Yxgjk=;
 b=LoG2ucWch2bUjjYwbXveyttErGhmJ3NlD46iCTx+XUGiC9EyZAiyTi9HAiA68b3EgN
 QchZEtQ7NoR953lfgJTKRodDfSN5fdoXCf33xSi8QLgClSm5yJ818jg6IBT4MfDW1dwa
 wX+4WvstJM8fgXIt1EDN6LGDoqZdpe2Agjkj8LFgM8q0N7K4clRYM8wH8/bGG4IBRQ3C
 Fy5w1SLdU+TWI6TZ6xSAhW0SD5pwcX6w8UBNvX0T3Vf1NeJPzBmWE/NYWi9/XTeGXLRP
 ji1cDP1jidR2EtyhMyobErN89a60rEGTfJgQkAxVVcghzn50F6Ls9tP+lZ4yP3jt1+Gw
 JAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693258042; x=1693862842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9CbcvBS7jJO4ohUzTPG7fpfV8a2Wa/7fjkgRp4Yxgjk=;
 b=HCEbID99xt42Wno7K8YJIZsLnRkIP7dUk9kh83MXn0GGtZQ5oS/MJDGWV2GT8Qn0kn
 b3GQo/+7fRZDz1yaOj3Wz3J/LBHHspzwPbv+k0P8soV8ahqDJenlEpGQmyyfuPVfiQrO
 7brF+Ru0CGH34zFTpIDdfmnjZ8p2XavVqYFZ53WKyK+qe5SC+dp135oEUSKbeuxSxaHa
 Qd0/DUdxoO8REy/cFWr7IFeAvSzQ54Q/I2Oi4IvQJT2ATvAKZzWE68p2wFUsaNCNF3cp
 UW2oMidoh8RotB/JH/OG3VKB7EkbyoU0eSAaE5/SrY1TOwrk9UeqgEJokL5UxCCFOZ/z
 6aFQ==
X-Gm-Message-State: AOJu0YyPBVBMSasQyN2Pu1bLRi4BmtVfigPU7XVC6EtycQ1UwR8GO9XP
 VrlPMX5JRJsETwsQFAhEinjiDQ==
X-Google-Smtp-Source: AGHT+IGxTzyS24hsfdvsvSJ6rEH6F2UQGGhCe84fXU2yiXgfAVU3/Ev6PhEJoG1EcWs7+KPnJ0Kt8g==
X-Received: by 2002:a5d:61c8:0:b0:313:f783:262b with SMTP id
 q8-20020a5d61c8000000b00313f783262bmr18680091wrv.26.1693258041775; 
 Mon, 28 Aug 2023 14:27:21 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a5d4e12000000b00317731a6e07sm11536378wrt.62.2023.08.28.14.27.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 14:27:21 -0700 (PDT)
Message-ID: <4cc4b937-1fe3-8850-9c75-0c281ea8dc6f@linaro.org>
Date: Mon, 28 Aug 2023 23:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 05/10] accel/tcg: Merge cpu_transaction_failed into
 io_failed
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230828185550.573653-1-richard.henderson@linaro.org>
 <20230828185550.573653-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828185550.573653-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 28/8/23 20:55, Richard Henderson wrote:
> Push computation down into the if statements to the point
> the data is used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 33 +++++++++++++--------------------
>   1 file changed, 13 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


