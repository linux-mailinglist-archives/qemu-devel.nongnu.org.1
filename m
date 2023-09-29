Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B50EC7B3BB3
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:02:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKcR-0005MP-C5; Fri, 29 Sep 2023 17:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKcM-0005Lr-FA
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:01:48 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKcK-0007yp-T1
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:01:46 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c736b00639so19729755ad.2
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696021301; x=1696626101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xlrStdyfD4ZqRHcv2Sslpei5niqc+Z5/NfxA0/sAzQI=;
 b=llp++FH26HyNY0jA3vvZiS2AfDASudqgxu068DVbJNodAK+hIyFaHYac/tGAt8qO7n
 bHclEX59WUJrQZai8PZYZowsnZXgSn6g1WOmvTD/1tiGnzNEsMeH/NZMwkSusSHJzSRS
 uvqpCbGe+PN0ztyr3OuzuCbm66H3BEyDrrIZJWOZtyBThO4mBJZA7EHD0s/W3iyXa7gX
 Po6BoXevg8rVSmBkLpXGYIjMmlO5mNbhOf/1hT7OZEORlBNdTU15t7+RvYfdzZ+VstjX
 frLGsNOjob+NsUZ6pjZdq3nSaHSqRg++WglcDhG0QNxxNim92HTx1PhDShucVgLEbdmv
 V8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696021301; x=1696626101;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xlrStdyfD4ZqRHcv2Sslpei5niqc+Z5/NfxA0/sAzQI=;
 b=LH7tLDiXIO5Rv7CC6E/WN96YQ+G+C5LZjYSi5nut7EdeQSMQfmT+3DtF8dCftTibh1
 4eixbjfPgaEy2VaflaumD/sdSysizfgTFqeyvkPuZawpdVkWG0r8Hx1ZMFjAmac+4cXO
 vHvYrDKizOEiv7SMTqdrfqKoPrVkcFnVRQFjhsxGHpQLZ7jKoq+3klJmw+sfuuKADF/x
 6AnZJR23x12M9dw4t8Fuqv2IwDfXJN9dEpfD7zCZzIFMCx93roZADZjc4wuBl6yhlUjy
 QIaYow3A+vH3AH8Z6uvqOnrEpREOCdeW6XYhv/bREuZH7Wk8JG0DSHY0toopkRvbh6CF
 SlMw==
X-Gm-Message-State: AOJu0YyN6fvP6ABCHvEStpMHW2NPzpZeMwXhV8IxXSn/LoIYPXrEKb2F
 lOBaR/r+fWkEbCQwgqXv3doMNg==
X-Google-Smtp-Source: AGHT+IH9Y6KKfwul1qVscOIgmZ2mI++H1A6s23xiSopyzwcFln3UEGF8dod9qWW0psst0mq97TdP1g==
X-Received: by 2002:a17:902:c112:b0:1c4:72c9:64ef with SMTP id
 18-20020a170902c11200b001c472c964efmr5329164pli.40.1696021301613; 
 Fri, 29 Sep 2023 14:01:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a170902d18100b001b8b1f6619asm17479968plb.75.2023.09.29.14.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:01:41 -0700 (PDT)
Message-ID: <9e6cffc5-7034-f2bc-ab4c-8120dce21c03@linaro.org>
Date: Fri, 29 Sep 2023 14:01:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/22] target/i386/kvm: Correct comment in
 kvm_cpu_realize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/kvm/kvm-cpu.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

