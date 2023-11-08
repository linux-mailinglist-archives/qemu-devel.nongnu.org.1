Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546167E5324
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fZB-0006nM-4r; Wed, 08 Nov 2023 05:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fZA-0006n4-19
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:13:44 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fZ8-0005EH-Il
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:13:43 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so11256266a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699438421; x=1700043221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LhqPmzScGJospJyectjauES9IUB80y2EIFAwMlLzkhQ=;
 b=F2AK+5YE77YQFr1t52sxwKdH7K21GB203tZ+5Qxd9PRuM1od9BEquTg046fIpI7Cnm
 F2ABOeSEPngDyxGBWxeCCGayjtFcnYbPQE013v+oUkaK++L2zfbIMyiwfp9Vv6MCj8CR
 RKduSCtVxxl6zpfHIYzn4A7xYpfY8iYOaQ/dZ5KMuqLF03T3yj3+ngoWVDAR7P3MQHjA
 qx1Bsx+nNk/H6fntF+eT+17UPXtlN9hs3/SIvG3aIuEZ4grEfhXCjhQELTzoQEdpul+O
 WmUcCgK06xkTWpQtv6EAAmstvJJ7nBh0sUHShYyt/H1EzTe9ALhWdaEjo7aY3DxpXfUx
 CVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699438421; x=1700043221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LhqPmzScGJospJyectjauES9IUB80y2EIFAwMlLzkhQ=;
 b=QehN5UtFYXOSnNMPnJsc7BgP3JMBHw01rpn7VQc+1K+wFr/s3nrVTvhDKxbDqPTVuo
 F+RjqhQYQTxppfg52BqzvXyEcx704FgNLOn3BaEwUUvhki1J+ysPkSs7+1JgmhhRDeEj
 nfdBW1YBYQrepHSJbzpyZqCQCBaeJyUEiJYLhSGEZ5e5rKyLpgK6tVc/NWJgBH0FhLUs
 CQR5aunZIanaQ+u7vmDy6H5Y9uJClm8+Q9lBFKC0ZsJaocNUGJ+5AGK9KvR7+XkczKC9
 Jvhx0InU4kkmBFoAXNft/RMQvxIAPtHylMrG492opbLiIPHdOjxhZX9owxDkvll61+4d
 072A==
X-Gm-Message-State: AOJu0YzydJ69m24zN8HD3l++iVHdvXSCTfLDXGU0Hx9ez+fejTPnwhoh
 /tKybfpbPNA+kTACc1wA6loRZw==
X-Google-Smtp-Source: AGHT+IFLXq7T3WjBahss4NcOcDkaz2RzgosYZUGSrWwi33vvrhRed9yesLtq7WhjUwxBX+fmkyqVlw==
X-Received: by 2002:a17:907:d1a:b0:9c4:4b20:44a9 with SMTP id
 gn26-20020a1709070d1a00b009c44b2044a9mr1267171ejc.65.1699438421170; 
 Wed, 08 Nov 2023 02:13:41 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a1709062e8e00b00997cce73cc7sm794992eji.29.2023.11.08.02.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:13:40 -0800 (PST)
Message-ID: <f37379f3-d744-4e80-a076-ee6be50ce508@linaro.org>
Date: Wed, 8 Nov 2023 11:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/71] hw/adc: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 6/11/23 07:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/adc/aspeed_adc.c    | 2 +-
>   hw/adc/max111x.c       | 2 +-
>   hw/adc/npcm7xx_adc.c   | 2 +-
>   hw/adc/stm32f2xx_adc.c | 2 +-
>   hw/adc/zynq-xadc.c     | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


