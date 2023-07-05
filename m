Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4CD7485B9
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 16:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH3CR-0000Ie-4O; Wed, 05 Jul 2023 10:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH3CP-0000IR-Gd
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:09:41 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH3CN-00033V-Hu
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:09:40 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fa16c6a85cso10491297e87.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 07:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688566172; x=1691158172;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IT7VOjXzhE0F6KzYnB2zDoIqc9zBbn9NN57jEFx6LwE=;
 b=m57GYkMtJwhExeYpuFCL01cZ+44Y0tt76hFPwVfnWA6AHnC78R5F6sVBi7jM+sahsz
 H2un/iiUuU9pgTnq893W1JKsGupNlFzqy4M8f7JFfveW92+FHLAVbQe85/0t4T6GsPeH
 D/rCT5gGvMX6ObaOso1qoaK/Ndkj0cMgbkynrRYnCS7FaZNcEY0uqdR0/jtt7x4qpiId
 gQZlT8N8pJrHbOvn5ERY76uZw4EpbyBUIovhPKse5vztXhD3jjrAXh4m1TG+6ZvKlGbG
 +NqqzqTVnJJlywCY21PncmTrO5yYTXTF2wga1AUR+UvTXvZjUHSpwTzoaR3lu4YWSfHU
 Q/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688566172; x=1691158172;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IT7VOjXzhE0F6KzYnB2zDoIqc9zBbn9NN57jEFx6LwE=;
 b=HTh9mYYiuqeN9AItt0DzlL8LTYcEamk3WypOMbJfKpElr/6XNSnGWpBnDAWUaDcfiO
 dzCv6a7UWvuz3GzwqCk+t1Fqg+FWTOUmMFgrzd4hJ0xud3D76S/M8PNg4oG2RQGMaKMx
 /WpgJHGn9+WzK0QvLM8ulqwMyUpTFIqvhdMPL4u7rWhfakjfrbjsF6wQ+vDhmGrBpL8s
 yPlgdeV4ldySe4uxwsLUb9vFytyAsAUiwERPbaQ7k3RHe+z8EPI/1I29JqxkjKDzLw+5
 dSC1TUXhHcisMZPBaUfF1PRTTJb2euMCbxKIGbs+hkUhWXFJw6JyhN4tMxQgnZDlnnEb
 4aUg==
X-Gm-Message-State: ABy/qLa0lNegHroSIi4QHQ9V9J9sKEolSA3sO/nWqTo5aZnvUXhRkpsu
 JtDr3LNDPZBCY7PC/9yKLmwrLA==
X-Google-Smtp-Source: APBJJlE3p7NUrY8GJBDpZ0eL2b50aF07E0h5wKC9BCQsoadGDVUWfv9fB2SieDQMViyWZ0De5wY1YA==
X-Received: by 2002:a05:6512:3606:b0:4fb:89f5:f6d2 with SMTP id
 f6-20020a056512360600b004fb89f5f6d2mr11441969lfs.47.1688566172296; 
 Wed, 05 Jul 2023 07:09:32 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a19c20f000000b004fb8c31c8desm3981807lfc.208.2023.07.05.07.09.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 07:09:31 -0700 (PDT)
Message-ID: <efed6e67-beb2-dc60-18c5-af0fe1431f0b@linaro.org>
Date: Wed, 5 Jul 2023 16:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] target/arm: Define neoverse-v1
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230704130647.2842917-1-peter.maydell@linaro.org>
 <20230704130647.2842917-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704130647.2842917-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x136.google.com
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

On 7/4/23 15:06, Peter Maydell wrote:
> If you're checking the values against the TRM, note that the
> summary tables differ from the register description in the TRM
> for ID_AA64DFR0_EL1, ID_AA64ZFR0_EL1 and ID_PFR0_EL1: we
> trust the versions in the register descriptions. Also the
> MIDR value in the r1p2 TRM isn't updated from r1p1.
> The CCSIDR_EL1 values in the TRM unfortunately seem to be wrong:
> the comment in the patch describes how I've calculated the
> values used here.
...
> +    cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;

I see 0x0220011102101011, not in your list of exceptions above.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

