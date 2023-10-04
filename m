Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4827B77CE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnvMS-0002qZ-90; Wed, 04 Oct 2023 02:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvMQ-0002qP-0A
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:27:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvMN-00073z-Na
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:27:53 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3248ac76acbso1627678f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696400870; x=1697005670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RuCjSWIgDYu7V95+A3V2sYkrRBP+eMZWKe+jQ8WoI7g=;
 b=shhqAxXu30rqsMY5vDDCyYaXrJvYr8yFOzBkBLyehZdLs0CrD6gFFj3RLPeAp2nCY9
 54+/tBpusuLg9z50KjxsnkzG8MQWXUx8re7thX/xjrHxp1fX/mhKbyXokkkv/EqFaAhu
 bBujp57KbUpPoz0UpSO97O+diUz1H+AP1J6lVKxawFewtvyLnHy+Dk1WP3xiiAVy4RXh
 ky+6mX1tTC4D+xA3+z1oOokfLhkJpa0V+zyATmMActEWpcfSOnBbiBBX320bQIdy8Z0L
 Mxf2tbWWZ8QqdKW4PG2HAEBp1hzpY117qkUEH/KVmJwJp512UTAzzOcv/0jtnxwNqpcT
 JRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696400870; x=1697005670;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RuCjSWIgDYu7V95+A3V2sYkrRBP+eMZWKe+jQ8WoI7g=;
 b=LrIvFLsPmdgEyMkmFefZkN+bBiemWSbo0mlE4cSh/ZxEqJh7xn1ZsinCNv3fcok5vI
 UULjK5NDKv5EekrwPIzyDdYasa3dtCnTKzlnp5plFuHI3paucvGq2zGlGH5fCDwdgnaR
 1Jler2miqy8/LDkNIEATfXUEFcjJSiVtSvp4G5nETKkIw51G+ND6mzIx94PJA39aA+Dy
 6Rcuerpdrk8XrZH7Epw/TBPo5mV8vKzEy5Wfx4rCSLe1d1uAVIvNGtXm43XjTCPAnNb+
 xYK5WKIV2tT8okizl8FBzxvVzPfpuNOKwMBmiXgnM9qc7Tui9329JP4FyD6K3ETdE1Y1
 hO7Q==
X-Gm-Message-State: AOJu0YzPmJQX8irgDB4Q825u+8WSogwhnXI20ZC4Z3WEsDuZTSGt3q/M
 eTQyWan4g4QXAXl4iXEOQHn798i+1zMsHw8KCoQ=
X-Google-Smtp-Source: AGHT+IH4VnbxQgS+np+oSfLxU7SNhHDO+dxOTbCiZvW9ChNBO25g3g9XN/MVKdy37u0hVpbaxW0tXw==
X-Received: by 2002:a5d:61ca:0:b0:319:735c:73e1 with SMTP id
 q10-20020a5d61ca000000b00319735c73e1mr1281789wrv.4.1696400870196; 
 Tue, 03 Oct 2023 23:27:50 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 q13-20020adff78d000000b00327db11731csm3190861wrp.22.2023.10.03.23.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:27:49 -0700 (PDT)
Message-ID: <15ee3a25-af72-72a9-a773-c1ba7a6d613c@linaro.org>
Date: Wed, 4 Oct 2023 08:27:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 01/10] tcg: Introduce tcg_use_softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003174356.1602279-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 3/10/23 19:43, Richard Henderson wrote:
> Begin disconnecting CONFIG_SOFTMMU from !CONFIG_USER_ONLY.
> Introduce a variable which can be set at startup to select
> one method or another for user-only.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h |  8 ++++++--
>   tcg/tcg-op-ldst.c | 14 +++++++-------
>   tcg/tcg.c         |  9 ++++++---
>   3 files changed, 19 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


