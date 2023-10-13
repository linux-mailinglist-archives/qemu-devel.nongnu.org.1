Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C48187C7C84
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:18:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9ce-0005QO-1t; Fri, 13 Oct 2023 00:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9ca-0005Pw-K9
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:17:56 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9cX-00078j-Sj
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:17:55 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-565334377d0so1286792a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697170672; x=1697775472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F9bcUZyzYt6hI6jFfj0fJ/tX49NatQeAFGWMh/dI/xQ=;
 b=Gw/PJ8SBfxqDpgUj2w8L/XlkQB0vWdxNdmutai7/UPo5tjuM5+ci/C1+ZzcYwfJDPq
 Da4qq/myTE1OMoHKDHwR50CMVdTMj9JaYLg0h4RBA4MWHQG31IktvFKASIUXp1TpY8Qv
 OvFpqFujjtsIDY1P0wUUj6C3s0f+T5cnB+UBz2LI6H2AaIIC9mg7UVjxV50rEcJzDkIz
 u8q0RotxoMDkjk0vo4IPI4bEv24LSBjKtttIjvDyq1g6xA372oxqSrNoFka4m3gRpSA7
 dpoYoW4qyDb/QZMZX+1s/oLpl8V0KZKOm6IoJQTrie5SemNrJS1Z3pKqmci9ie75zbmE
 4WLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697170672; x=1697775472;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F9bcUZyzYt6hI6jFfj0fJ/tX49NatQeAFGWMh/dI/xQ=;
 b=HvP+XnrTfR4ZevCcYpDhi1ZwFik/iLD6/ooi6hvYcME0r5BUCbGEOjkhQ2pW7Vm4IQ
 NdgbFK0AWmZmkDvk1kVJgoyizVCHMnxsOaCz2wmR5SwzKvw1jaaqSOOWpFvn7Tn6McvY
 GUGD7styBk6vx2+Co2oFoOATIPDQbTUU/WOJn4PwZBNqfkNR+/p6TADVc0P8X9UWR1tj
 86TmUy2S6zyk5Pkq1RX507MetTi8mZLU95US3CA95DM5odS84OUG4UX323RL49KPJIKn
 ioBB7B6DhVj1wOhL6QxWGJn1iddimfwLmqYN1RzK5Z1Nrtm4vo9qiEcMeEXt06EOL1Rr
 ho2A==
X-Gm-Message-State: AOJu0YyHZEb07AKTeQEV4AIHEiCq6jUxpR90AHfLxlggNdRVUgvjRnM6
 fOLA8pIejfw+dEgZNaH7PGNsng==
X-Google-Smtp-Source: AGHT+IG/KUdYlflwYvidrmEYKLgU1Z1ViZJda3ZfxKDSfyOGPO7hyKHc2Xcq75L6CSUnzNKC9auA5A==
X-Received: by 2002:a05:6a21:3290:b0:15d:ec88:356e with SMTP id
 yt16-20020a056a21329000b0015dec88356emr32619980pzb.41.1697170671831; 
 Thu, 12 Oct 2023 21:17:51 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a170902ea9300b001c0a414695bsm2810744plb.43.2023.10.12.21.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:17:51 -0700 (PDT)
Message-ID: <adfb6ace-fc87-4aed-b376-d82ba4562b78@linaro.org>
Date: Thu, 12 Oct 2023 21:17:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] target/i386: Declare CPU QOM types using
 DEFINE_TYPES() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. In
> particular because type array declared with such macro
> are easier to review.
> 
> In few commits we are going to add more types, so replace
> the type_register_static() to ease further reviews.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

