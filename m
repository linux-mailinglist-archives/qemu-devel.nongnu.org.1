Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 913D980DE0F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 23:16:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCoYC-0007J0-Mn; Mon, 11 Dec 2023 17:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCoYB-0007Is-FM
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 17:14:55 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCoYA-0007HR-2x
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 17:14:55 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ceba6c4b8dso3884709b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 14:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702332892; x=1702937692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VZk9IkZs+BjuAZ1Gv4mVQSmgr3nLuAWALSfjmJ0ISSo=;
 b=oxDIwddM4YVUfiBv7BRhRUbcYCr293XaTt6DYUjrIeo4+wGxWA8UhyDVWvcvlxsqgy
 Os/DiNnM+WG9uP+SqOr6+ucbjFzBmEnkvMCvxB5Uefz389W5fm0PrxU9+Aby1g5pc0k7
 CT7zt+zgMRklIoDihmuGek5Hjl8BCgBUEBvYKG2Urk3atkq44mmwsBvHIk0aIHPKCsnd
 JIaRO2yfFWak6ErqsX/TKhPpedQKTobQibjzKs90wbhC6LJXt/F+JY0KYma3daEmF1yf
 E9jLIAwI7mai4lLs8IyLkNizLv5xqm3/78zyuyjbvLJWWzM5dxRxmbATQVUoz49QS5cu
 nIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702332892; x=1702937692;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VZk9IkZs+BjuAZ1Gv4mVQSmgr3nLuAWALSfjmJ0ISSo=;
 b=FK3zCiX/7zCBAtDtuB9qAEpEDcF1EfaFvGt7QIg8CPcdih7kCgGreEIoSf/98zt8r+
 qJag3hofEsoXE3ALOzdYw+mcymEjEru+fFpBHw5uhNg5IqT02DHX3yR/RpbCU9OoPRvY
 RaycBxag0ofzjy7IC1AS5ydkiK7g0AKrQf8OKraZ4I9nCsULaNff01mTpG6RS5gbVfVf
 66/fBaALrx/OAZKtwc4ZxofbKBq9SfW2Hxvf4Z93webC1a7SSgRATF/GsR+ZtPq39CGy
 2SK/ZGvqkcqGc23UoSQeTylmCyNTr+OISwUvZRCzCIcXF/h4vpS1U3wIaLszV5YTNekN
 50cg==
X-Gm-Message-State: AOJu0Yx3p91/VzPkDrRqTn4tExOZecj8IdTcAa5AQPNaFAXkqoVrcsZf
 /diZv7T6eUZ1/DahIUC9R9r83g==
X-Google-Smtp-Source: AGHT+IFiNnERPMbuysVQZ2ZV/P9MZLvkIM9pyb5J2pZ9fVFT7AyTRj/2po2H0NUuNCVENc2Hiv88Zg==
X-Received: by 2002:a05:6a00:194d:b0:6ce:4927:2811 with SMTP id
 s13-20020a056a00194d00b006ce49272811mr6106276pfk.22.1702332892341; 
 Mon, 11 Dec 2023 14:14:52 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a654102000000b005c65ed23b65sm5754021pgp.94.2023.12.11.14.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 14:14:51 -0800 (PST)
Message-ID: <853fac49-2587-4b29-b852-c85c60af9fb9@linaro.org>
Date: Mon, 11 Dec 2023 14:14:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] exec: Expose 'target_page.h' API to user emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
> User-only objects might benefit from the "exec/target_page.h"
> API, which allows to build some objects once for all targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   meson.build      |  2 +-
>   page-target.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
>   system/physmem.c | 35 -----------------------------------
>   3 files changed, 44 insertions(+), 36 deletions(-)
>   create mode 100644 page-target.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

