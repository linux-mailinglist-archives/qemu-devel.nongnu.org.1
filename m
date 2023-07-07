Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8B74AF85
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:11:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjN3-0006Tu-CG; Fri, 07 Jul 2023 07:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHjN1-0006SN-NT
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:11:27 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHjMb-0007Uc-Ji
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:11:06 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fb94b1423eso2627732e87.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 04:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688728259; x=1691320259;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=604yQHiva/yxODMhqVowQz5Nif93y+3NhOxII7jTO/g=;
 b=zXo0E0yA7dJPrSpbe/pr2Ll4gEeGF4ZKz9vrAnATmdpA7L34DHd8UJzZd9d+r3BHdX
 EasUq3UUWcbQEjUAtjvx/bxOV99xgR2jL1DPzCLosD3FYPBWEctRQ+7iJgEWdBttsMus
 DhbF5J1KvAeyjF7cmZpcaPRRNsWH0zJLVKo0TNSR4y7eohux+zJ4RngUaqK0rLakKKQl
 6GXChKsM5ii+kaWJVs+yWNQB+wzeGSSJJ5QG2IHjjGet6ZR2SCSKCNkGSONNwtrhNL21
 7Zv6z8jE+Y1nLVQ4f5Z7PNSXorL3kG9X95xJmCivLPy1UBqL0cLtPWUE9/CmhJ2n/0+K
 nksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688728259; x=1691320259;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=604yQHiva/yxODMhqVowQz5Nif93y+3NhOxII7jTO/g=;
 b=kWh1GxNDYImQSFChFM9sd97LWtGOZD3bjpHLfcL1LpRvWhmkcCQlxe8R+HsDvYEB9D
 6LTqgDYDOGTwnNv5XXhBitiGfwVXvWMxxSFnwB2H9YFz+Qh87sCWlUnE2ktzBPz7DJvj
 2NxLRqbCukqRNpOv+v5XXrLiZ8zXXlgA16E1vJ9f7iLX+gspTIYO+LDh4Lgpl49oXO9T
 q4D4n5zWeSEvECNL53MuggxkgJgHRg5zMAvTC3G4Fmw8WlraDq5SY6fb9jVB+1f7bPt9
 Zm3qwJhmLzX+d5otiYWdPreBF+uu3UOeuwGElgjbZFya6Q+XPC6D++Ll5MBEs8ZbVA6Z
 CENg==
X-Gm-Message-State: ABy/qLaQfJFG083pE9ZRMIJw3xvO5QuVGf4gcenS0XEapm4rZWXuVh6G
 BjXqJu6nmdvkHJiBEpQA9eHQmA==
X-Google-Smtp-Source: APBJJlGx/4pkSC4xFqOvUM0qvPvSlAT7Zjyptb5bNNbsygKrhIvq4lfP487UIHXSg4dChNonh9rk9Q==
X-Received: by 2002:a05:6512:3b27:b0:4f8:77db:1d9e with SMTP id
 f39-20020a0565123b2700b004f877db1d9emr4200146lfv.12.1688728259047; 
 Fri, 07 Jul 2023 04:10:59 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.9])
 by smtp.gmail.com with ESMTPSA id
 h28-20020ac2597c000000b004f873ca4139sm637058lfp.71.2023.07.07.04.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 04:10:58 -0700 (PDT)
Message-ID: <85febcdc-365a-48df-d7b9-b61bcfe8dd2b@linaro.org>
Date: Fri, 7 Jul 2023 12:10:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 18/46] target/loongarch: Implement xvsat
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-19-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-19-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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
> +    len = (simd_oprsz(v) == 16) ? LSX_LEN : LASX_LEN;           \
> +    for (i = 0; i < len / BIT; i++) {                           \

Similarly.

r~

