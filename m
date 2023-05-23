Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E04870E1CB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:30:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UtE-0000mp-Ch; Tue, 23 May 2023 12:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1UtC-0000mC-4i
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:29:34 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1UtA-00083x-I1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:29:33 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30aa1eb95a0so773490f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859371; x=1687451371;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y+tvmMrSqCflG4Wf+uWz3a7OXzByiktobWGEehN7Lsw=;
 b=FjuDBCyEaBJT3XQeqv46fk45+xG46SFQ9jI1+GYUmPe3eTPCs3rldFX5lnLt6CemK4
 116Ju4opnaJPZRIhQG1nYAyUwdmIZ5NUA4Pq4b3uI2T2+Q9RqDU/jb9zQcMhgFKg3X8n
 0QoGf7npR7D+BKo4Wa9n2RaeHB5tP1PEwWBXwqPOLhaubg12O0YqxWlccH/JVW9Jhb88
 nNL0AzJdZquZ+s1QMJ8EGQRm+Fk3Ks0KBEdDofi2quEi3c55KSJGLHMOpXC4mLSx64NY
 IxZx3tTf1YNHVfIIFxUWwGFYS7o9kk47+5oD31DcCIE5EJ+lPWwgkFiTCH7y7HHxZEhN
 DQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859371; x=1687451371;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y+tvmMrSqCflG4Wf+uWz3a7OXzByiktobWGEehN7Lsw=;
 b=Go/c8Us0jDawVEhIVU3xF8I2Oa5qyhd414bdCppwJESnTBXgDOsZE3Nhp84u0Zyw4M
 yGBy3eyploZmA7BzRJ+H6fPo8hzVuI7dfojVnyhgAro0+yzE0FykiDZ/Pjmu76ZAsU17
 t+XWtKtufwraTgdZsPhg4RzTJVb1TUHjWYqw43AX9uDUl1xj1cGW5ZOi/wqvQKR9gP/P
 ILrQfym/bKeVhJhxfZrVWpwJdzel5EKWYWzFR42BNoT14F/4ZPxL4bz2lGC3LIlYaehP
 axwK6Slqa1x8lq0LEl5pOouhhIYrWCoC9Apt3nLyds5kEJ+0FG21FBXBIeSzV6BSvpYg
 k3nA==
X-Gm-Message-State: AC+VfDyZvGKqYfXHqElA2fAMMG0nDxqxqrIKhHCZhO5c19JEkJbdgdRL
 S8CIvsIRoAJH1By3DpPnJKHPLl3X3SnIifg4e5s=
X-Google-Smtp-Source: ACHHUZ4FjiCZ7t6IbanhoLPAfRqj2kI0RrSW99wzREOZJWV7TMJUREwWfRp5bjJfE84EUNsh6mijZg==
X-Received: by 2002:adf:dd89:0:b0:307:7e68:3a47 with SMTP id
 x9-20020adfdd89000000b003077e683a47mr10585147wrl.37.1684859370894; 
 Tue, 23 May 2023 09:29:30 -0700 (PDT)
Received: from [192.168.1.102] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 k1-20020a7bc301000000b003f50e88ffc1sm15713023wmj.0.2023.05.23.09.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 09:29:30 -0700 (PDT)
Message-ID: <5516d60c-ffcb-96fa-95cc-ce2864e6f08a@linaro.org>
Date: Tue, 23 May 2023 18:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 08/52] tcg: Remove TCG_TARGET_TLB_DISPLACEMENT_BITS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230523135322.678948-1-richard.henderson@linaro.org>
 <20230523135322.678948-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523135322.678948-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 23/5/23 15:52, Richard Henderson wrote:
> The last use was removed by e77c89fb086a.
> 
> Fixes: e77c89fb086a ("cputlb: Remove static tlb sizing")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.h | 1 -
>   tcg/arm/tcg-target.h     | 1 -
>   tcg/i386/tcg-target.h    | 1 -
>   tcg/mips/tcg-target.h    | 1 -
>   tcg/ppc/tcg-target.h     | 1 -
>   tcg/riscv/tcg-target.h   | 1 -
>   tcg/s390x/tcg-target.h   | 1 -
>   tcg/sparc64/tcg-target.h | 1 -
>   tcg/tci/tcg-target.h     | 1 -
>   9 files changed, 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


