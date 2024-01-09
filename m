Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B063828B53
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:32:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFwt-0007NK-6I; Tue, 09 Jan 2024 12:31:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNFwp-0007Jx-4y
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:31:31 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNFwm-0002g0-TF
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:31:30 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6ddee0aa208so92950a34.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 09:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704821487; x=1705426287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kyKbw37FuAFsn7tDVaoN+dlh49bbhEBG8iRh/3jLC3I=;
 b=wqauM7WA3uIc4EdDORvglBYkIaSTaE4r4PhCtuAYbv7uSnK487KIA0Pu9GoZ3C5jtM
 aTBNQ3hNMrhb0uFsk/FZPscDiGfj3BSN0pxKOgTlZkfdNgSgw6zikvbCOsDX7pqf32dr
 MWffefn72OtJtKRazsCkaJEXW/PovGOFPC5KTZwcZxgUtfwCoNPPVgPIb23PK4b8ICGj
 ra2+PXbTPOmv11fOyDYnQApyy64g+mfv/YC/dUnJYUZ+bBu3AQPaPTaYyjWCYh58jp1w
 TJRTxphiVn5PWJknTTjVDWEiXpHnuQpGL+CnPA10Cn8+EGlZWfEURlmnRAznAgBVuDZ6
 clKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704821487; x=1705426287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kyKbw37FuAFsn7tDVaoN+dlh49bbhEBG8iRh/3jLC3I=;
 b=GVcv6JAvx5+GhWU0t/fmz+MTjC+ncB7X7dQCbQVpuxG2x+ZkeJKHxY/Qcw7xKUjA2D
 JrQajRmW7G603QItJevND7LejkBc4MI47/8dBJ5AfZzA3LHq9Y1elBRJrRKCza4ffi6E
 lffVWSZtykib64MKgWhSj2HOF7Pbwp1jjN6vNy9ieEST3XfHLAkILvv7oD9gOmvoV4wO
 NEBVJzTwv8qIiAbPiYsIShyBeBfq0rbBfSmRMkeLJvcqGE5QOHQrEaGjHSDKCm1/Bazw
 oZkDZhoFNClhfaLfHydGDAcpvyFOACzdDYvOh0YYjgTdvrhU4R1PUfUsEJCvjolGTQAq
 qe+A==
X-Gm-Message-State: AOJu0YwRM3JczcoYaSksUBPSBDTQcZeJqGBEx8CjuAXHIVVz9Fekrv0z
 VlYwhteG/JZO4vspZe8OjslNDrcqJwi3RQ==
X-Google-Smtp-Source: AGHT+IH1E3ZO4GzsGtCJbMbirm7O/eIq8Y8M6I3HVfWmhSKjO5vVzRnX01LZVXdHVuYla0JBrHiIjw==
X-Received: by 2002:a9d:7a85:0:b0:6db:95ba:c422 with SMTP id
 l5-20020a9d7a85000000b006db95bac422mr4175993otn.41.1704821487132; 
 Tue, 09 Jan 2024 09:31:27 -0800 (PST)
Received: from [192.168.47.227] ([172.58.111.136])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a9d74c2000000b006dba1ec37ffsm430719otl.11.2024.01.09.09.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 09:31:26 -0800 (PST)
Message-ID: <a40a7bbf-e94c-450d-969e-60f6d1cad43f@linaro.org>
Date: Wed, 10 Jan 2024 04:31:19 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/sparc: implement asr17 feature for smp
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-6-chigot@adacore.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240105102421.163554-6-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/5/24 21:24, Clément Chigot wrote:
> This allows the guest program to know its cpu id.
> 
> Co-developed-by: Frederic Konrad<konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot<chigot@adacore.com>
> ---
>   target/sparc/helper.c    | 16 ++++++++++++++++
>   target/sparc/helper.h    |  1 +
>   target/sparc/translate.c | 13 +++----------
>   3 files changed, 20 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

