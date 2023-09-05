Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F858792C53
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 19:21:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdZiy-0008WF-Sn; Tue, 05 Sep 2023 13:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qdZiw-0008Rx-ED
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:20:22 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qdZit-0000tn-9h
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:20:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c0db66af1bso14044725ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693934417; x=1694539217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ebZrz4bGd3XrfRekrLWO/sRf0ku+PeLQyVw4fgFTXVQ=;
 b=id+CdfY7pLgKJz3i7bZdEuBYSVA8hnyKYtmx5Elh7QefolPVBiBMAzNb/e2Nr/1uaq
 1K7Eqojnps3IwPrze8TkRWdoJZtQwgka8Mq/szCKBDgxqy7Rm1+RpQd7uOUq8IkcKatD
 OJAfZ99AkEQ7K8p9zMkfe0fCYgGN6UdnCg69B1na0yDMdNizrnQt7w/P4CRTS0Ul8sly
 JaT9EgWbzQjYGjJKf23ErUI7QS41tUrkUJZOkUJE4NUcy1yjzb3PI5imY5+zfqs2apvF
 mBzLMoK1qTgv9YcHoPpTSeYL8ojYGgz0fZIquxoHiNuSkLgm45qTnoxjtTte2XYrvAxX
 fPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693934417; x=1694539217;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ebZrz4bGd3XrfRekrLWO/sRf0ku+PeLQyVw4fgFTXVQ=;
 b=D0axPEK0CjQfY9uRiqhXpW4Yy6O8z7RTA8PoOqxRNl//EnwV04cvY49Ukk1xsPin6K
 pm5/rvru+OHQ4jrT+uHKuBL1ZImFZ5mzLfSx4TsBzvZjf1BaQsVvMPp4coq4jjYqNu5W
 PF5Hoe1y1/tBdmchQJ8ZqMzeBgpT6H+aKLG732/UZAUvB17RGaG7Pc0DwqrYBHCss1h8
 l3co0A+vNWMhoZ02DPpGxdCpA7K2gm211ubvFkhpIhV7524Drby9dLiWcY1X9g9Trq2a
 j6sHddHI84KouTy0NHq+yQG4qJHSGjlCLwQlTAC1w2fZyiVRXiq4+L2CdV6Y8U/jBu78
 4S0Q==
X-Gm-Message-State: AOJu0YxzkL4UDy6QOw2q0rU1qmM4v4uu/l+sbdZEkoLm+/DfeYDhRHSL
 dw3UMtOouccRN4zL0VQ74XZr0Q==
X-Google-Smtp-Source: AGHT+IFTHkgZACXNarJ5u/usfYKoaTBSInKcDKfrOOq2qwvhPXCvcPogk7g4FHh2HhIBNV1t2y5rKA==
X-Received: by 2002:a17:902:c952:b0:1b8:a569:f980 with SMTP id
 i18-20020a170902c95200b001b8a569f980mr11022473pla.65.1693934417493; 
 Tue, 05 Sep 2023 10:20:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 17-20020a170902ee5100b001bba1475c92sm9562920plo.113.2023.09.05.10.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 10:20:17 -0700 (PDT)
Message-ID: <2b603970-f098-7758-2889-f21d965daffd@linaro.org>
Date: Tue, 5 Sep 2023 10:20:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/intc/arm_gicv3: Simplify gicv3_class_name() logic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230905145651.8199-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230905145651.8199-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/5/23 07:56, Philippe Mathieu-Daudé wrote:
> Simplify gicv3_class_name() logic. No functional change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/intc/arm_gicv3_common.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

