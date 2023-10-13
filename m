Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A027C870C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:41:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIOQ-0008G2-UO; Fri, 13 Oct 2023 09:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrIOP-0008Dv-27
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:39:53 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrION-0004ea-GN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:39:52 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6934202b8bdso1702641b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697204390; x=1697809190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y8C+Eydvl5+mFbXOUSQ7BnYufBkeZ0sMX0GeyxWEAx8=;
 b=o+G6Tz/ZqHsz8hGK6GLvZR46grpvAvg9L9uUIPE3twu2AX9fLmQWFz71tWktWdXUMy
 zLDiYiddCiH+/5vfwV2NnGgzurvB3hUsV7auyYb5rhdFVLAlDRU+qkBD7xdCasgzpOE8
 52nDEn/HASdFCHzsJWGG+RpKM6YJVeNBX+O2U/sC43mvvDfkJNaAZcAL01CJS90MKNrH
 L51BpKcTkhxzvZQU6pxxgw8JTJA1miCVtJX1kp+D703K/MUHIugO46P0wpVLodpuah5u
 UjtnOlLca4aczsT5Wff/eo50DWdiY+7dU+I5Z7S23vay5WTPzEy9UL/JK2SiwDWkBzxN
 0CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697204390; x=1697809190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y8C+Eydvl5+mFbXOUSQ7BnYufBkeZ0sMX0GeyxWEAx8=;
 b=El5h1rVhToG8Kmx+YWGFIfBagnrkIbAg42QQewiDcmoUCeD/1hQPWA3jD5JQa9iIzc
 zu1vS2VwDRNo9EJ9jsB1lQKoAUC6a+lj0ejmm2XVN4UYdJR2mMWrtG14hrGUI0nfzYaL
 PzK9Z9BjqsJLqoCXtk0ZvqUGdMarkWLFQHBUqyTHPUXir9zyeRJ6QGlFGS3WiG1Dq/xf
 VvcMceAL7SF6Gf6x4hY/FRDEk8FGETT4mMCd6TSJ+zJUCTjNi8FzhbanLmH1Ck+BApXu
 I1y4HeDsIsEp+ACJrCQGNEOr+msGN4o/hZ5dfnpKGDbpEkKMr8vhuMKgLxzqdCAE2NKH
 oBZA==
X-Gm-Message-State: AOJu0YzF6JL4d4jUHV1AdP2IqJkyJXU1Yw7GVied88sLqlLZJ7+/jy+v
 S9dVQbEQ9zAT2JzQO+CaH+TeCr0gaolYSFiCaQw=
X-Google-Smtp-Source: AGHT+IH+aULAlRkh3Z0TW3/XTupQn+IMuArtXUC6U9KOBnJbArNXaOCuh0hNvM4lyqNlS8LjU1fD0Q==
X-Received: by 2002:a05:6a00:b41:b0:68a:5cf8:dac5 with SMTP id
 p1-20020a056a000b4100b0068a5cf8dac5mr34388386pfo.22.1697204390008; 
 Fri, 13 Oct 2023 06:39:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 q1-20020aa79601000000b006b24b99afd4sm1401458pfg.176.2023.10.13.06.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 06:39:49 -0700 (PDT)
Message-ID: <0a931a9f-7363-428e-a41c-4d85f7fb9fe6@linaro.org>
Date: Fri, 13 Oct 2023 06:39:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] target/ppc: Move powerpc_excp_t definition to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013125630.95116-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/13/23 05:56, Philippe Mathieu-Daudé wrote:
> The powerpc_excp_t definition is only used by target/ppc/, no need
> to expose it. Restrict it by moving it to "target/ppc/cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu-qom.h | 29 -----------------------------
>   target/ppc/cpu.h     | 27 +++++++++++++++++++++++++++
>   2 files changed, 27 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

