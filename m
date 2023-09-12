Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF8279D8B2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8CT-00077p-JL; Tue, 12 Sep 2023 14:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8CR-00077N-06
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:33:23 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8CO-000077-Tl
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:33:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68faf930054so2739788b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694543599; x=1695148399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Ky2GKD8spux3wrUapJ+SwfSjyjIBW4Rih0AMgz/QI8=;
 b=x7wFNjwIAOgT1RURa8LRjlI422ejrPjBxhzLdSML9zFGzRS9bzU4FCZZPlykGmQRj2
 gouLJmaRKjXbvkOnu/tP/U5RI3wxZREZp0aWuobm/sW9dKTWZxi03uPy6J1SCe7UBTsy
 lthnnzlnWeDfmNiCQ+wtzeK4VriNd8zEcDs1qDOon4f4vsFJqGQFVy0UbIKuYCTAp3Qr
 SXRZDyw6O/BBXmUTkBfRn+KAIq1v1kNybMm+tadgXrk74D2vuolMTFV0S97R7gYF1OcL
 L0ETq4iZ/q/tEG5I1J2AJI86149MjjdrlPZ1RI3afSmGhiuymm+YEGdB+HLA4pOpwy8k
 RTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694543599; x=1695148399;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ky2GKD8spux3wrUapJ+SwfSjyjIBW4Rih0AMgz/QI8=;
 b=OkV/CitniZ3NkHoh0pXZKfURjdrzzyhnewiuIGhlMJ3DH4v+Acqufmy/nLToQxIstE
 e4Qv34bDNeVZ9FWSPBcB1GoUAgoshnSza5p0yZGhtaR3xgxXQNeiBAS1lDBxgmswxoNq
 UI0RP7xuejwGm6OKLm0HURTqf2bM7l3n7iMO3eXQOXFwKcOOiqKi7ivX2zK6BIw8o2By
 uEVPNwhXe36aH1FjgjyYbEq3P3XtLPg7vKXBu5cnpSu1oKHdEI6mvO/Bl1BKSqSQChLe
 vffgtKkW+NMeBca6AYiKBaByic9m9q0SDxASBBCG0zjLkr/l2GxP/BIRTxAYUw9QEXs1
 1QyQ==
X-Gm-Message-State: AOJu0YwTdugxUcDsJB5sw7us9GdQIbk0NalhQlex+gcFUrzjqwHfev52
 1A4imu6imcingA4argV7JV4pxw==
X-Google-Smtp-Source: AGHT+IF7wvLVNqP12h66Gt/DaldDmOJ8Nkrtpowv2vM+saaCBDHfISo0GM5Vx1Sggl3qByJlVe2ETA==
X-Received: by 2002:a05:6a20:1388:b0:147:fd40:2485 with SMTP id
 hn8-20020a056a20138800b00147fd402485mr188222pzc.35.1694543599119; 
 Tue, 12 Sep 2023 11:33:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a637219000000b005703a63836esm7472869pgc.57.2023.09.12.11.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 11:33:18 -0700 (PDT)
Message-ID: <717bd871-51d3-e6ea-1b88-ac5e4066c139@linaro.org>
Date: Tue, 12 Sep 2023 11:33:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 12/12] target/arm: Enable FEAT_MOPS for CPU 'max'
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230912140434.1333369-1-peter.maydell@linaro.org>
 <20230912140434.1333369-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230912140434.1333369-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/12/23 07:04, Peter Maydell wrote:
> Enable FEAT_MOPS on the AArch64 'max' CPU, and add it to
> the list of features we implement.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> v2: Now sets the hwcap bit
> ---
>   docs/system/arm/emulation.rst | 1 +
>   linux-user/elfload.c          | 1 +
>   target/arm/tcg/cpu64.c        | 1 +
>   3 files changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

