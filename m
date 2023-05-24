Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E0470F98D
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:01:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pxt-0006X6-RK; Wed, 24 May 2023 10:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1pxq-0006Rr-N3
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:46 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1pxp-0006Ux-0F
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:46 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d2b42a8f9so805571b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940382; x=1687532382;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VB5rrKpg2kwiSO5u9KvwpG1D/nfQhK/Z+OVFOvPmyYI=;
 b=r8C6DA2md+iGCGpYvaKCXwsK3EJdOrMm5XBRfcjz95CHgqGcdgUn7hloPNtwab8Dtt
 pXDKMrbOtU8izbMIiOjm01VEhmB6wS3mtiqRkQIOxIdvSVeGfksM3bHnpzeB777ko0wh
 UYxhOVkse1xhQMsttc+LrNrqwlkn7duWe8bK7hT5EaZhQNovvXrmpU6CIk7Vw1/OSAjx
 BWduAheLH4Ita6o9wcuMIbXT6encn11vLtdXwfjT02yhuk2iIGENGaiPWAv+khlSO46L
 94svh283s8Sl6c8GVhpymi/m1X9+aAyE9Lhn6bwOifO9WwaLI9n6ybsDvvcd/2jYYBpx
 Oc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940382; x=1687532382;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VB5rrKpg2kwiSO5u9KvwpG1D/nfQhK/Z+OVFOvPmyYI=;
 b=OYxQ5CuCFHQuS9WiuzN1YzWFpSolHwBn4N84a5l6E6cx++yQFFULQBwieJpN04fRAG
 UBPHVTUsJJPh4LXaULgJXlmEI5at2rDBMlMOezkXp6s6FVDbEgzqPLw38I8EDgAhvnTl
 7uB6GFezUcmtSUP9XwhNvpid2ELeKgehMdsR1HKU/2HsHy1S+6mokSCJSZqiYvLvmqux
 TY3QoVnHedaMrt3c2TPvX+GI71QwNrZww0/y7Z4X6E4Wo82bKTbId6ys8jZ4QOR0ReZV
 tYfOr9TaVxwZ8PD4OznZ7VYLiD+bsUu1xsassYPTan6dvAf8KBab9GYLDDnwEz5ImXJU
 vkqA==
X-Gm-Message-State: AC+VfDzWmd5Ww4LDEogfEk5uuKQMsTSLlt2jfBfzyT1NmWx3Ls4qZEy2
 URWawcCKjuAl1fPmPe3UWgFOIg==
X-Google-Smtp-Source: ACHHUZ5VVzJyJEBrMsKoAfo4BsNPCalkzt+33QSofYuK3mNOO37oBZlKSX6n8Di5wXc8NMI3KtiELQ==
X-Received: by 2002:a05:6a00:1a13:b0:646:3c2:4d30 with SMTP id
 g19-20020a056a001a1300b0064603c24d30mr3692689pfv.30.1684940382539; 
 Wed, 24 May 2023 07:59:42 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 j18-20020aa78d12000000b0063b7a0b9cc5sm7529916pfe.186.2023.05.24.07.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 07:59:42 -0700 (PDT)
Message-ID: <9d8da7ed-e9ce-4dc6-1f80-6ff1e093e12e@linaro.org>
Date: Wed, 24 May 2023 07:59:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/5] Add Bochs to list of vga_interfaces
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230524102729.810892-1-marcin.juszkiewicz@linaro.org>
 <20230524102729.810892-3-marcin.juszkiewicz@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524102729.810892-3-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 03:27, Marcin Juszkiewicz wrote:
> arm/sbsa-ref uses Bochs-display graphics card and without it being
> present in vga_interfaces "-vga none" argument handling cannot be added.
> 
> Signed-off-by: Marcin Juszkiewicz<marcin.juszkiewicz@linaro.org>
> ---
>   include/sysemu/sysemu.h | 2 +-
>   softmmu/vl.c            | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

