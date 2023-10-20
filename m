Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E24047D1836
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:34:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtx72-0005n6-AG; Fri, 20 Oct 2023 17:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtx6z-0005gL-3x
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:32:53 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtx6g-0002jY-GV
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:32:52 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so200674266b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697837548; x=1698442348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6O9l+8QIFIFVQR7c4jgr/V3Rbzhya0Ry9zMjw3lqR9c=;
 b=uKbO130olIbhJGA0C/P6FjH4+Fb8GQwZqntrwS/DfR/2mW1wyYYuSZkT57x7JwaSsi
 hV3dcHfTqteDikjAaTEsHDL3umrEmaKkSkKtka01Poc16ZHSxvS9fnOKZtJyQabwtkXC
 qtZx7LuH2HcEh7Xyr5WyMKihfibK1+ABOtu/OcKO/Kvv4wniFbkZz30xhrBfJv3VMUoC
 V0v98xp2InayDqkNxr6d8br56DSqZeCGGHfhju3ZqG8lh4ecQnpSBdoIT5wa/YneZIZI
 BN52NoLo2LbbR/mDAq8faRZ8NA7sT6bs1QCo9iMCQVgxDQHOLvBNTbACTAX8Bl9Mr1uO
 KcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697837548; x=1698442348;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6O9l+8QIFIFVQR7c4jgr/V3Rbzhya0Ry9zMjw3lqR9c=;
 b=AMIWh9k2EP8Z0YRxCiXhFW82A0K9HXl+k+ZzXcTRi/8OpMiF2jo+MulUPyDby3Qtp0
 Iei7jzdv9R42BxfR3konz6OtCdXfCREL4qJHIcWo1IJQp40UaI8/Hq4FIrDM1YNb+9pk
 PLCbpJjEqt4GFLSOa/N0RXEh2hJSfDOS6pyRQqBzxJBz4sFLcQREFc8nK0d3qoM2d3/M
 f/fNTjp1MpK+RBftY6xC++YGtpIZfHKEcM5Omx2atZQGYCz3R2RftDj6nTd5SAax3/bG
 R6wiRMlhyh5VDVMy9lCgcFakWIhyROqP1fPgm+prjDCY4bnDbfeLz7JmIKndnUFJP79i
 vRFA==
X-Gm-Message-State: AOJu0YyRS1Mr8xxU1wAex8SWnXo+ZOs/qmBD/3WbCz0gBcQMNRlBMK+X
 PJN4aICUNehTLAk7FTYD1zv5CQ==
X-Google-Smtp-Source: AGHT+IHGNECDJZypO6iayyPm3hq7d4L+d0HS0F7mYGE9lXvTEEFqBfKGiI4XqCKhPysmR7TBJ0ZYpw==
X-Received: by 2002:a17:907:7f02:b0:9bd:bca9:4d4c with SMTP id
 qf2-20020a1709077f0200b009bdbca94d4cmr2641057ejc.14.1697837548313; 
 Fri, 20 Oct 2023 14:32:28 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 mb8-20020a170906eb0800b009b947f81c4asm2213033ejb.155.2023.10.20.14.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 14:32:27 -0700 (PDT)
Message-ID: <07a0d4e3-9f93-a7b5-6d73-b7aeec89e92b@linaro.org>
Date: Fri, 20 Oct 2023 23:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 60/65] target/hppa: Precompute zero into DisasContext
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231020204331.139847-1-richard.henderson@linaro.org>
 <20231020204331.139847-61-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020204331.139847-61-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/10/23 22:43, Richard Henderson wrote:
> Reduce the number of times we look for the constant 0.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 34 ++++++++++++++++++----------------
>   1 file changed, 18 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


