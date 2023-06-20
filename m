Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B41D9736987
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:40:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYmA-0004JF-Gj; Tue, 20 Jun 2023 06:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYll-0004GS-7X
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:39:29 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYlj-0004Ls-N9
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:39:28 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b466073e19so45131681fa.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257566; x=1689849566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mUmoYq8PPbCPQh1Ss4hnb9BZHMKS1FS70+9nY8yhubQ=;
 b=BRAFGnDXMXYJp29fYb/UuY2ALe2d6YKSD8KKNynu7ZZJdMuGHeQsc/4I7BvWZZwgQg
 o3kr1EPQd2M8dYnCd7Pg5+2PODjC0XMkjINOGqLiIBZ7lwv4x+0LrzQfLlmoCXDcZslY
 iU56J+kM+P+YRy7GMumtWKVOdEFp7jIyRky47+qPdiQyyfT727X+RPOQoa5FeQMyzf5C
 WEBhiKwpSCemvPnHqb0IWIwpfP5bIhOZuj7WQlQlltrqER+v/fAcZqUh3WIEyhm5FJ1j
 +ul1ZRjLN5SQ9j7PEf5Z5ng2CuizupMOr1O+hHlEHcVAjCZIi9gjq/1ReK3eI37M+YZF
 uhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257566; x=1689849566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUmoYq8PPbCPQh1Ss4hnb9BZHMKS1FS70+9nY8yhubQ=;
 b=YGt/F2GWfqaLjUZxBzlG7e2fx/1X6alxYFM4UO0u7xxiopqnqJAq1nI8LrwfdTdbYN
 0EoLiBzpVdKwNXogx35iNKIRMbbO/IpffdR0my/MidWuOtajPclvAa6Y38afEXkfvZJc
 Kh3flt2KkLMQrQwrVd3oJ7NqE5v7RWtpHrjpmgjH3UMfKYrFn/seO6D4KSG81Iq4pV2Z
 ieDMukiAcwYHZUzizgIMS1sqEJHOBbcJzV+87fgUirUBp7t3kig+OzsWyyy0qYsgYS4w
 hYOg58StQ+L2FQw48RoeBhwolcnnDI42z8dj5G3QIqqpD8yh/fLv/hDB9gaeuSWI/NyQ
 VbFA==
X-Gm-Message-State: AC+VfDwk4nBFgSmb4x6gXq2z6zEEgq7tImfGm8Dm9FYPYvKMghZ2gBLs
 bJqVLZqpJhixumK2DqdSWIbQpg==
X-Google-Smtp-Source: ACHHUZ72Ic4tKPeqDR63h8zxWIeJukq5wIWoitKEITYqBrDT0wBjS7oL+EEwLOD7kfn1J7I+/ioQXA==
X-Received: by 2002:a2e:9ad6:0:b0:2b4:78f6:d32b with SMTP id
 p22-20020a2e9ad6000000b002b478f6d32bmr4302427ljj.39.1687257565877; 
 Tue, 20 Jun 2023 03:39:25 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a170906838400b0098696189722sm1118596ejx.192.2023.06.20.03.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:39:25 -0700 (PDT)
Message-ID: <e53998c9-676c-c9d1-0a0d-cde1b2ec6057@linaro.org>
Date: Tue, 20 Jun 2023 12:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 23/34] target/arm/tcg: Reduce 'helper-mve.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 17:54, Philippe Mathieu-Daudé wrote:
> Instead of including helper-mve.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h            | 2 --
>   target/arm/tcg/mve_helper.c    | 5 ++++-
>   target/arm/tcg/translate-mve.c | 6 ++++++
>   target/arm/tcg/translate.c     | 4 ++++
>   4 files changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

