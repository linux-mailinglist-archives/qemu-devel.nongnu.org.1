Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C7675DC7D
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 14:26:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNBfN-0007pE-SC; Sat, 22 Jul 2023 08:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNBfL-0007ow-Aa
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 08:24:55 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNBfJ-0006tw-NU
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 08:24:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so2427609f8f.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690028691; x=1690633491;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wBcOGahZGfdliLehbzWt2unvNLAElDDgYZkKFFMq6yg=;
 b=sd2RpIBwog1T0qNNMqmivBpAzqra7N9xGKO7stKEah+zfNANyNz1KkXkydeeTruajN
 kjcNmrl316koNk7A8A2G4WC+098PdFZJ5CGYMgBVKI42Kre8ZRqkUHAjs3BUHZJvb401
 c6EJNdU/dmlWlF7AZY2R3JG8PDl4zn90OZ7CIwQ+46VQR8fwPgeHE/OFx0SFqJ1Vb5As
 ylae4000hVIsrWKPCfntfurHpQboK8cEDNF92b6uQqMK9y26+a91msY6gXHTpZLfDs0X
 16LWYpfmn19VbDUK4SQ4NeeFqlLQIZujo3Fjeu6vo+YDgnKrpgYyB3ILWcSkA+IEctlj
 mOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690028691; x=1690633491;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wBcOGahZGfdliLehbzWt2unvNLAElDDgYZkKFFMq6yg=;
 b=ZKPsiyR5dkOGw8jCFdnrmk9jHrIQdB1AjXlScs7WEkbI6od+3tFPHWP8LwRCAZOv9X
 YNZDrMf9cmuJTxzYeGQrwHIOmo44JgHyerI3yfeIawbKAHaL2b7IU+H7vtcDT7YeNd38
 WQUuIXP19IscO831SdRerI/nlpYw791y6zEWTwJKI+rbj0DUbTVC6gLg2TCAIaC6bGu2
 tjNDnBpQ3n5GW3tzR8x5U5Wr0OHVhxrZ/j2dKEYJg+6moK0PvDfH3sYWveFUSROtHk/V
 qy0mhZXrDJW2ikm075GzTBs+4B3OED9AvLIF2YltcVCYMGMOTh9FZ/mysSnIOE7UOq8i
 oPYA==
X-Gm-Message-State: ABy/qLbXAt9UvxVQt8Myl6FDG1ZTySiI+88pKI3J/7AKA3OAcFeg6229
 dBA3ve1yPmLi5TP3XkpoBq8vmA==
X-Google-Smtp-Source: APBJJlE+kt63/ehTlQonKjamJwxodkG3LD4VlUheIlqwpQxEiH5hlSxX7RojJEefNcgqOyzr8I//Sg==
X-Received: by 2002:adf:d849:0:b0:313:eb29:4436 with SMTP id
 k9-20020adfd849000000b00313eb294436mr3889038wrl.67.1690028690700; 
 Sat, 22 Jul 2023 05:24:50 -0700 (PDT)
Received: from [172.20.4.173]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 v4-20020adff684000000b0031431fb40fasm6799115wrp.89.2023.07.22.05.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jul 2023 05:24:50 -0700 (PDT)
Message-ID: <5504bea2-92ea-a146-beb3-1a13e4499dda@linaro.org>
Date: Sat, 22 Jul 2023 13:24:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tests/decode: Suppress "error: " string for
 expected-failure tests
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230720131521.1325905-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230720131521.1325905-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

On 7/20/23 14:15, Peter Maydell wrote:
> The "expected failure" tests for decodetree result in the
> error messages from decodetree ending up in logs and in
> V=1 output:
> 
>>>> MALLOC_PERTURB_=226 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/decodetree.py --output-null --test-for-error /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/../../tests/decode/err_argset1.decode
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/../../tests/decode/err_argset1.decode:5: error: duplicate argument "a"
> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
>   1/44 qemu:decodetree / err_argset1                OK              0.05s
> 
> This then produces false positives when scanning the
> logfiles for strings like "error: ".
> 
> For the expected-failure tests, make decodetree print
> "detected:" instead of "error:".
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> My initial thought was "just get meson to suppress stderr for these
> tests", but AFAICT meson has no way to do that, and we already have a
> command line option to decodetree to request specific behaviour for
> the tests that expect failure, so this seemed simplest.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

