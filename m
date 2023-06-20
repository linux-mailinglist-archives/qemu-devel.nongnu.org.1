Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7EC73710C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:58:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdjx-0004a6-W0; Tue, 20 Jun 2023 11:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBdjw-0004Zg-GV
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:57:56 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBdju-0005v2-T1
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:57:56 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-988e6fc41ccso231940566b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687276673; x=1689868673;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CAr4PizHu1tm9DoLOhRapjYtDmAXjiRGZ2pfkEZQxIc=;
 b=u/LlBNmdjOwNMXG8JIZw4r6IH8KL9VczegTJlQR4Mr1i4XUqx4cDZJWbfXUiFPRk3h
 q+DaMiI5Lgcnz5wt/HAlHOYjxIY3pph6ENZImTRuBiTFMFHvoDGCoMvxg96DgjgAn0lh
 aMNHx5pBk1rNd4nbFqs5bLU2qBV/a+6wjBq2F7xRNEtDwQ3P0f9CEE9cEpQJfkevtOq5
 NaGbrMDE6EyBpgwjZkumKsvhPzAbFBjUVZvwUBxTD9g0BZyE3IMI7zNVv7Mh2TnIlWL7
 pWh01fWmUF1kQ1NBgUuB4Vfc9oMRH9347D2ra+JLj7YLlVsn7RYiWG507WXbeBLXEyWk
 sOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687276673; x=1689868673;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CAr4PizHu1tm9DoLOhRapjYtDmAXjiRGZ2pfkEZQxIc=;
 b=J3yThRPjyF9XBoOKv1DHJqxEz9oPurCrMhVMgJ4nyC8ElnV7EjDiJ1Xcs3Tua82371
 MgyX7wenUzwP7MN98npuabASY+O7Zn1V9s25Fi9WcOdhViBcOu2KzQfJudHL3JbXK0PD
 tTFwERQc+MgvcjMEmgs9qgrOe9cXScX07FcRYSl3wZvhFlfwDNMJ7oOE8vvmuTjLEQaJ
 Tb1O8Tjc9Rk2OzuuuDxgTYRlpiQNqUrS/+7VsD5y66bbVhdD8XqvIWxczCCF+k79kh/a
 MFpt/TCgiTb/3YgQQOqfefzXoI3zyO0WYs5kBAfpgXqZ+KxNfq8ITvgwDJrvxFOIuB9G
 Wcjw==
X-Gm-Message-State: AC+VfDwTkS0AXksnzYtMKHvcxBT+BbNrgObua9OVJVmlT7T+6ZLvjsOA
 IKM8f4EYjk1KpPxV+/yGm63Waw==
X-Google-Smtp-Source: ACHHUZ6tyufwZqQ14YCDLqvaQJK2eizjV+pzhA26Xl/JQhMKtaS3fcrpHry22TmR4tpJ+Q95xZMD0A==
X-Received: by 2002:a17:907:9705:b0:966:61b3:f630 with SMTP id
 jg5-20020a170907970500b0096661b3f630mr8919311ejc.9.1687276672936; 
 Tue, 20 Jun 2023 08:57:52 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a170906154600b009888aa1da11sm1634817ejd.188.2023.06.20.08.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 08:57:52 -0700 (PDT)
Message-ID: <547c01ea-c284-905e-150a-baa625b8bb60@linaro.org>
Date: Tue, 20 Jun 2023 17:57:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/10] target/i386: Intel only supports SYSCALL in long
 mode
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230620151634.21053-1-pbonzini@redhat.com>
 <20230620151634.21053-7-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620151634.21053-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x633.google.com
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

On 6/20/23 17:16, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.c           | 4 ++++
>   target/i386/tcg/translate.c | 5 ++++-
>   2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

