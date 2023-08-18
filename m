Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C170781203
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX3LZ-0005EE-Dj; Fri, 18 Aug 2023 13:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3LW-0005Dt-PV
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:33:14 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3LU-0006Yj-Nl
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:33:14 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so9513005ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692379991; x=1692984791;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ubul+p4uZP8PiavwZt3QMXedP9v4ag8lYdOPV7ZdsbE=;
 b=ZaJJyaRTioylWBwK9zvJ4Fcr4I/vJ/aOHjsIbOr9dXj032pLFddsNAH8za43zD1hr2
 8nDrolk+h1dlSx/ZSHkujLp0QpeG/dBPgnHZi4jNz3Y6avihOafOFr7K5OSQCuTTQRKd
 14dCtKq/6gXOj2hGa6s5KolA3sZEsdFVj99yP3pqiCX/1L8nprcY4+gi3xeXCxkvRpZK
 VxIbAE5oSagqhaML/D36B2N4o5/8z6ep8bjiMbtAQaPAi8alU6MlZUwmWfJNrR/sZQzL
 iYgDHpJy8X/Kojzfwd4bHpFeczFDaA7IeEP+noPS2b8rqMk8xE4Koe5Smb3sw7Zwxdzf
 4JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379991; x=1692984791;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ubul+p4uZP8PiavwZt3QMXedP9v4ag8lYdOPV7ZdsbE=;
 b=lPdmTI93+Y6xw9UFuvNyVO02RJ3K4eOjdddIqkYn/Tqg0I9rcGac8oiVvLXh1xY+MM
 r0s7kopY2gbUdNjSOBev9niYKyxV1IRp4csa3lbyHrCM+//g2MHbNoUq2kzkwvb4u0Cz
 O2wP+F4RtYRP4jMokSnmiKfeHGHNtc8DiQCIbNGRmWmbDmSHU2L1Hu1FDIM2MS/uigC3
 FzNwj0nY72tW90/xyO6n8x4n8lqtp955f4TI0y+nHVdVUFrRjCWP0+RVwFmNs+UjnzoM
 0uiY3upsYBTtPkpXeYFQqLre12/Gt9Hfjj4c0o6uaGBgGQoB5QN4zoTxO8TKP9Hu3dTp
 cXHw==
X-Gm-Message-State: AOJu0YxeS9q8DouL7jmF/wpQC2VA4TsLPeIf8N9S8HRyxowJ2mYPgLd1
 FSWFnTSN/Zv9TsjTo/LRGtSQdA==
X-Google-Smtp-Source: AGHT+IEOk4/U3ZSxI5ZfcxAKVSICw5EHFPnPtjkU6a7ooQUcXXzTsTZygqo9DaOAyh8rswYuR7aX3w==
X-Received: by 2002:a17:902:e74b:b0:1b8:94f4:3e0 with SMTP id
 p11-20020a170902e74b00b001b894f403e0mr4088043plf.14.1692379991440; 
 Fri, 18 Aug 2023 10:33:11 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:cf24:6daf:2b9e:7972?
 ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a63b40d000000b0050f85ef50d1sm1666848pgf.26.2023.08.18.10.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 10:33:11 -0700 (PDT)
Message-ID: <b72e474b-528f-e8dd-62a7-4cc259f8943a@linaro.org>
Date: Fri, 18 Aug 2023 10:33:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/8] target/loongarch: Introduce abstract
 TYPE_LOONGARCH64_CPU
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Jiajie Chen
 <c@jia.je>, Song Gao <gaosong@loongson.cn>
References: <20230818172016.24504-1-philmd@linaro.org>
 <20230818172016.24504-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230818172016.24504-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 8/18/23 10:20, Philippe Mathieu-Daudé wrote:
> In preparation of introducing TYPE_LOONGARCH32_CPU, introduce
> an abstract TYPE_LOONGARCH64_CPU.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/loongarch/cpu.h |  1 +
>   target/loongarch/cpu.c | 12 +++++++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

