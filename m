Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5DA781E56
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 16:39:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjYr-0003z9-Ls; Sun, 20 Aug 2023 10:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjYp-0003yw-QH
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:37:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjYn-0000kP-I7
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:37:47 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bdf98a6086so20058465ad.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692542263; x=1693147063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2i3mavvQzUpFI0vqzpLFsu4pk/kO8JUN0kF2he8QA44=;
 b=i0E8eIN1jDVZbXxa1iFb9LWzDTPOq/XTBk1gtlUZ+OHxIj2un4USS4E1EcP+uvGX7O
 4TXj0BlE/ag+jwEvkwvJZ1YgUMlEXcHyzzxucI2khI5Y8MNqhrhMTMwT5CffJcVBe6zP
 y28yNc3Xp4Jt5J1bOBhj/t+/TdRST8+EJmyFh36bnYpABz9glF1HzK7xoATOe7zk3/43
 RhUaE8Ort0fMcdq1lSlW1FQwWnXDCLq1I9eqxCXurQdimfZDfXsb4eWFtZxCcYnY+9RM
 HSFdEEhqX3SBprEUoQX1XAeKG2fVJrPOIoPxyJ1zeZZRX4/JaJ39zFR3ShirhkzaPPIU
 gLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692542263; x=1693147063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2i3mavvQzUpFI0vqzpLFsu4pk/kO8JUN0kF2he8QA44=;
 b=L/l7j8mtcm7Y9E1pKj9/C0hjR/Vvb0dyEM86he4UQ92t7ZvCTfi0AE2ldJ1h3MrBOF
 a3iuD/2W9Sx3VjV8QNYRlpnDK0eI2q4lpChUdbLAOWaQWfw6R4DJOqMtKv07bQ1xa+CF
 CXLoAQEbrAxv1dMbvpGVxiL6kuC4DgO4hqBVkZyiNQJ/fimYCTpx8Y09AzivLszAoWvM
 SqSUbsf8UrXB2/l7rcuxJk4dQ5SaS9bNmV1oDm13eVWotoelTJDRb5xbcfvKreqfhhoD
 Bq2n1NgucEKHoizWVhcxUIiUKW7g6exIc5n7UaruSQ3R0rZ6KV1GRAp3vDrc2C4dEmEM
 ul/A==
X-Gm-Message-State: AOJu0YyYmz6BSIa7fA4lx8XGp6eEWgV3qLzhoen9lyd2AgnrepUgQasL
 EQQ6fnSA5nAeh63r+YXQL55erg==
X-Google-Smtp-Source: AGHT+IGpTp3HH/5mEgoJGsl8IW0zAEioNtx9oWHKOZnsBx0QP3grCJL2dFnTRksgxs0/4kGJLHsqEg==
X-Received: by 2002:a17:903:44c:b0:1b9:e81f:fb08 with SMTP id
 iw12-20020a170903044c00b001b9e81ffb08mr4435907plb.55.1692542263505; 
 Sun, 20 Aug 2023 07:37:43 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a170902bc4800b001bbfa86ca3bsm5174953plz.78.2023.08.20.07.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 07:37:43 -0700 (PDT)
Message-ID: <8e402848-3d4c-baae-aa0d-14bf33a0bde0@linaro.org>
Date: Sun, 20 Aug 2023 07:37:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/22] Implement msync(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-15-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-15-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:47, Karim Taha wrote:
> +static inline abi_long do_bsd_msync(abi_long addr, abi_long len, abi_long flags)
> +{
> +    if (!access_ok(VERIFY_WRITE, addr, len)) {

I think this check is wrong.  There's nothing in the kernel that requires writability, or 
even that the entire range be mapped.

I think you want guest_range_valid_untagged to simply check that the bounds are ok.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



r~

