Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D3B7213BA
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Zzb-0003WS-ES; Sat, 03 Jun 2023 18:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZzY-0003VL-St
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:45:00 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZzX-0001K1-0Y
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:45:00 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-652dd220d67so2289941b3a.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685832297; x=1688424297;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G5spGaxIHtucAmezZziqf2v2RiSjPuUnmxs/qojTilo=;
 b=YoKi4o1NzDil4x8zSF17kFR/JTKehJkdG8DV5wLLmzjmSDY0FiGdRHQcUeJ1VErYSi
 mcwr7s9gagWTBLTt/cWnoCBuVHgu7j/3ZPbKI9tSAqT8dKxyc6e7mM7XKwrygtxkeIYV
 YCwlRDgsn6tFMSH9Fud4NMUzhGwCIMlXA+tfX62Adb67GWqvkRGAGafp9N+HLCIiZu6Y
 1InPDJ1bMkfdA3mSJPUnLqDFTNZif1YJi6VbxXbFAcjBLLcuB65c8GgryawMTaahwqF8
 zuSRvyEYCleCsi+39gi/DR8YIYYqFFXsMmee2P0y9fu5kJ0xJN0Jl0PF9SU4wBoa9qGD
 OTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685832297; x=1688424297;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G5spGaxIHtucAmezZziqf2v2RiSjPuUnmxs/qojTilo=;
 b=bKvpZPgJqHM2+mV/L1rk+QZgS+/1FXtZp5zizw3tUa0YVIfMwq8mFpLGq5s8+MHYap
 qUzs/s2mvpmVVUhcOWOAzm5PmM6zzYYDY0bLLMtu2x8tuGSAmQKDX0FVET/JF6904CHW
 hVh8uULpd2wvLrcFl4tdeoo5IvKzJAusYh+NenrxUPH9twut1mGki7xFhynxQNmIpVbN
 7sYwRxXQW7iBjPa/KqNF3AnT58EQKEUoFut1Kj5EVIule6WzxiGs58bBrZSxa533AU6v
 oMwYLI6QflQ5JIbYDRY0mqIZYWLX356D9Z5aQdhijH2i0pSWfLji+8XWWJZj/S0TXuqc
 QKfw==
X-Gm-Message-State: AC+VfDy9EkeBQ/wc+gBJWgmIWLvtTD2qwcvd0AZyqd9IQ6v35uXbudDW
 D5z6gondm3nxdg4W1YsaBYnkLA==
X-Google-Smtp-Source: ACHHUZ7mSl0Csq39vGWqPPFE/MVkpOAE2bxP/t8WFTwfkLvFm7lKmlroLUhzRL5XMVjNNJNbZoS8Fg==
X-Received: by 2002:a05:6a21:339e:b0:10b:c341:935 with SMTP id
 yy30-20020a056a21339e00b0010bc3410935mr3340355pzb.11.1685832297035; 
 Sat, 03 Jun 2023 15:44:57 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 n5-20020aa78a45000000b0063b867a1959sm2833735pfa.133.2023.06.03.15.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 15:44:56 -0700 (PDT)
Message-ID: <49207150-2ecd-b2e0-222d-e40998802216@linaro.org>
Date: Sat, 3 Jun 2023 15:44:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 09/20] target/arm: Convert LDXP, STXP, CASP, CAS to
 decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/2/23 08:52, Peter Maydell wrote:
> +# CASP, CASPA, CASPAL, CASPL
> +CASP            0 . 001000 0 a:1 1 rs:5 lasr:1 11111 rn:5 rt:5 sz=%imm1_30_p2
> +# CAS, CASA, CASAL, CASL
> +CAS             sz:2 001000 1 a:1 1 rs:5 lasr:1 11111 rn:5 rt:5

Drop decode of a + lasr?  Or rename lasr to l? Anyhow,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

