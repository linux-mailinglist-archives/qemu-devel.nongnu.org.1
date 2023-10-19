Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 742D77CFE93
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtVDm-0004GY-N1; Thu, 19 Oct 2023 11:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtVDj-00044V-3a
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:45:59 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtVDf-0005tZ-Uo
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:45:57 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9e072472bso54965055ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697730354; x=1698335154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GuAc9kSj4YLsBsc1JVRwx0MdmnsqUv3ZryRcVdzPB/Y=;
 b=Jp2RNTXd12Vr+WzeteZhSIT2rS+ezX2yJNUIq4ig50jlvG9T1amjjem64tmlstpUsv
 XGE7lAL3Qpn9dn38cMIFepD2bV0ynu7xHlU2EwvlcERCizSpzDVJNzMzSyjXKrriKeqi
 3nG7N4ETfF8fLfWft4SzYlwZoP17lMzr9lgqwAjLOagUL/WdPc5JwqhPk6b6mqccWoML
 /j5t/voAR6bjaQ9FE5avMogzCB3k1/+Nul0DcSCQI7tXte6BhxL80bPvYpiZPJORnMG6
 QxIs1A5z84R4sBm6nVkrbagflkduR4BoweyN14eiGEx41O5zrrr7nz7d8NiaAZZEP6tk
 fJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697730354; x=1698335154;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GuAc9kSj4YLsBsc1JVRwx0MdmnsqUv3ZryRcVdzPB/Y=;
 b=Z9wzb/ej5Ap7YM8kUq4Yv3lh9JKCd+5wBu8cwccSyRiUQwzlhM/Byu4n+GbsCp7ZhF
 h6Fkmrhx5292zkdETUeEDlLkfh5xYXvpVFUIAHGZ1KkVVoO0UH+Updm9FwSrSLruok5s
 XjA3wUAplh2Z0yMr/zxPdVFO85fUtqoL08emD5T5B41qW75kvV5XWnDJZJ3Njqenb2RX
 KSZhVM0pQk5CqmVvIRHjVTnMET2H9xK2fAhLbAcnGZxufOIyNvoXdeaCihNP/4DHEg/m
 0aLF9X8oyxY8VNIln+E7l2vPDAGSVPeTl2bWZqX70Z4hGZZEOkytCpU4mbthLS2ChT+E
 bKTg==
X-Gm-Message-State: AOJu0Yz/7DBzp5JIeTzvL1J42K1HBT/7Gu/K5cTuMU2jwRStFQwQIpmo
 I5toOEtMQgzgwdD/8G5JQ4J6xZkiaqRSHf8mtlM=
X-Google-Smtp-Source: AGHT+IHNrurIUvWjdnosPI9bWKYZIcW3ep9ghpVj/b4QjZlHXiIsOuhuWxs9jurfTmIpJ3gOP6Rg/g==
X-Received: by 2002:a17:902:e5cb:b0:1c9:bfd3:1f4a with SMTP id
 u11-20020a170902e5cb00b001c9bfd31f4amr2821905plf.66.1697730354344; 
 Thu, 19 Oct 2023 08:45:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001c62b9a51c0sm2094758plx.103.2023.10.19.08.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 08:45:53 -0700 (PDT)
Message-ID: <da5752ef-9b9b-420f-9831-ac62358f9b7d@linaro.org>
Date: Thu, 19 Oct 2023 08:45:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] target/i386: validate VEX.W for AVX instructions
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231019104648.389942-1-pbonzini@redhat.com>
 <20231019104648.389942-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231019104648.389942-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/19/23 03:46, Paolo Bonzini wrote:
> Instructions in VEX exception class 6 generally look at the value of
> VEX.W.  Note that the manual places some instructions incorrectly in
> class 4, for example VPERMQ which has no non-VEX encoding and no legacy
> SSE analogue.  AMD does a mess of its own, as documented in the comment
> that this patch adds.
> 
> Most of them are checked for VEX.W=0, and are listed in the manual
> (though with an omission) in table 2-16; VPERMQ and VPERMPD check for
> VEX.W=1, which is only listed in the instruction description.  Others,
> such as VPSRLV, VPSLLV and the FMA3 instructions, use VEX.W to switch
> between a 32-bit and 64-bit operation.
> 
> Fix more of the class 4/class 6 mismatches, and implement the check for
> VEX.W in TCG.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 133 +++++++++++++++++++++----------
>   target/i386/tcg/decode-new.h     |   6 ++
>   2 files changed, 99 insertions(+), 40 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

