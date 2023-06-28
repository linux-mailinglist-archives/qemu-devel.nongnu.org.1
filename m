Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B10A740996
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPFL-0008OX-5g; Wed, 28 Jun 2023 03:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPEy-0008O1-FD
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:05:25 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPEw-0002YI-DB
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:05:23 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f957a45b10so7455386e87.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687935919; x=1690527919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tnr60y7upnX/ZOGneBXEAExZ0Jwy6Y7jBELze38YF/A=;
 b=Kdle1NoxCrF1f+ysir4w+32P0efScxuhRwSePSPBP7Pqw6SKx7xTg4X3HwiU59n/6e
 nmE5fpzve8cVtUwm0OET5MgGSgwGr77EsYBdhwjR01TRYeCmjo0LQjPgsdA/q84dJLbD
 A+vkZcGVyT1Ddo5ox9XZOTLcEWfMRET6NjMvtLlglmLyfoE3AgduRb3MYPfQExFFmFTZ
 j/9nO39waOep4iRe1VNJrAg3M8RFoQycoEelXAakYYPVkdbUmRZzIDbqk3XJ5lvfGL1p
 KlA9e/ljNVlSkl0r1oOphrQaLzO9DUouFeD+ueveCZRNIhMfzcJwPQgak+NsPZvAPPd8
 Y3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687935919; x=1690527919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tnr60y7upnX/ZOGneBXEAExZ0Jwy6Y7jBELze38YF/A=;
 b=CDXXqmm/s1IXTbnni99ihiGAxY/HbDAYv/cxq/VfFUtzAFvH0jo1dL0TVVETgXniJ4
 9P+EoXP3k/hLloX0WbyobEtyq280gkBZwEI8UmF3sq4IFujB5BD/L3icGXr+3a4WzxOQ
 6q6oCDXR0KezD+ALaB5rnW4BdkEDfXWMl7WQHRZK12Xx+x4juOB84ZQTwPHeuR0rMw7J
 dZmXMyvgQTFsnA1y/smQ9aNXd5n/qfW5fDTJHmoJDFnfjC1lLpxO0RF+c9K2FWDfPAMu
 ixqdZlSzZ8Xr1lrcG4OsHz1hjY7N4Uu8zWtud5fnSLp6j35Tj3JHigwSNzjfzcYVe5RE
 9WAA==
X-Gm-Message-State: AC+VfDySaTS7uft27CwBCkeHySZnvUp/fvVjeKsnHid0TNNXWsUTF6oy
 JlaRUs1ppi/gzhqD+7VvyBDVbg==
X-Google-Smtp-Source: ACHHUZ6V7ITUYgr1XZKLvVJj11yyVqQBMF+xceLkHWFEdvi5mVA0aImHZ/3P75EMCOv2jWFPy3HndA==
X-Received: by 2002:a05:6512:3f1d:b0:4fa:ce08:a9d0 with SMTP id
 y29-20020a0565123f1d00b004face08a9d0mr6724538lfa.57.1687935918824; 
 Wed, 28 Jun 2023 00:05:18 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 er8-20020a05600c84c800b003f7f475c3bcsm4917949wmb.1.2023.06.28.00.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 00:05:18 -0700 (PDT)
Message-ID: <613cdd61-71af-0100-228b-0a59fa1af5ba@linaro.org>
Date: Wed, 28 Jun 2023 09:05:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/8] target/sparc: Drop inline markers from translate.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <20230621180607.1516336-4-richard.henderson@linaro.org>
 <1a3fefd1-fb3a-1e38-8938-ff3de9cc4dc8@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1a3fefd1-fb3a-1e38-8938-ff3de9cc4dc8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 10:58, Philippe Mathieu-Daudé wrote:
> On 21/6/23 20:06, Richard Henderson wrote:
>> Let the compiler decide about inlining.
> 
> Should we clean that automatically with scripts and forbid via
> checkpatch?

I'm sure there are some places that benefit from inline within C files.
And of course header files need them for unused function elimination.


r~


