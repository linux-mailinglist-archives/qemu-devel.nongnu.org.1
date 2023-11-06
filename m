Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2737D7E2080
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:55:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzyBk-0002al-2Q; Mon, 06 Nov 2023 06:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyBU-0002IO-A1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:54:24 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyBR-0006sQ-Lo
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:54:24 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso27555325e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271659; x=1699876459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MhWLNEHGuvGPCyKkmbpani8yCKnb2HfM0vztXpiapEw=;
 b=v0nzbJl7wi9cDMXJn2fkpCZGyP19onacQdxaP9xtnyazD+ato7zR3hyuuaMUAGGBcv
 PiR2UOpT7eUU0xTqYxvYITDjfi9GRMYTxL10436AMYPF/mNI5EOH7uiC+mCrdRxenjgg
 TSe/UcwvWFzeX3WvvgIVDyrsT/pJHfUMqWBKj3JLi7WlhXETa+cM16apYBjplOI2qUFT
 miSAKAekfEcxL7+kLlIAdZEyBuJe44rLO9TNZr7hIsrvTv7ZqAhICBzNYLvTg2mCPFUB
 EjeGz4gI8cwVDRFdCqq4AtItYrOCdGkBL0T6kVHH79KmsFcKXnmQ66KdTnpwz8qyO1HN
 I4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271659; x=1699876459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MhWLNEHGuvGPCyKkmbpani8yCKnb2HfM0vztXpiapEw=;
 b=JUju2Fe2snbMTy+B4ejXOS+74lm/QQDs5+CYaf3RpGbDxXeyM30/Um8AVOSIsWDzc3
 UcUoEBrWHUxRGrosRXhIg5Tlw6kegePUD6Dg+Ji5wL0iTgHWK44Jkmqu+GS8Scy6q1YN
 sJdMpc0ojktwhLSPCTweNo+XSHOgSIW+11ftfl7vuNGuh4mXbtZbZicPksx92FrM1Jey
 R7+TjS4Xky73Nxg4fH91Vj8rCjIDkdAABAPB9Nyqeouhpcy2io6k6X7X6NJ1urQD9jA7
 1zRixvd0iqXaMOE6BkaqlpSsEQ7yfjUDO2OzcsH4rQ050JEjZEw59itYwqAlhK8nuQPZ
 dLSA==
X-Gm-Message-State: AOJu0YxZZ61JbqwWunajyHDHXsFnmeZadYxhAJlgbXB3xl0vxf6g7SpW
 yZYPYV2aQGO1+t1dMp8Tty2MSg==
X-Google-Smtp-Source: AGHT+IHF62CqowPvsE4G0v/RH6+SwWATG6Z3faXskQvL6dpR9IVrJLWHVCgCO1RGvpQgjA9Sp/MeEg==
X-Received: by 2002:a05:600c:154a:b0:401:73b2:f043 with SMTP id
 f10-20020a05600c154a00b0040173b2f043mr25598066wmg.1.1699271658694; 
 Mon, 06 Nov 2023 03:54:18 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 q24-20020a7bce98000000b0040648217f4fsm11706127wmj.39.2023.11.06.03.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:54:18 -0800 (PST)
Message-ID: <003a731c-63d2-92cb-37f8-8f57c1e07ed3@linaro.org>
Date: Mon, 6 Nov 2023 12:54:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 03/71] targt/arm: Constify hvf/hvf.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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
>   target/arm/hvf/hvf.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


