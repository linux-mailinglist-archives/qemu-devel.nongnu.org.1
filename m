Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA477CFEF3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 18:01:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtVRg-0006sE-Eq; Thu, 19 Oct 2023 12:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtVRc-0006rE-Vu
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 12:00:21 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtVRa-0002Oy-Cw
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 12:00:20 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5a9bc2ec556so4636405a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697731216; x=1698336016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jpB2UUK3rXwMef8/0D7EGmoaiLKvaTfr8l4NhVfttds=;
 b=NxxX96HJka4sJPT8oIvTycTaUF7DlxPpPMVKnocI6fpxEQqmIgKL6JbjOWFqVTT/vV
 O3PRT86dPlGQ/DnO57NtsvjnXBJSrEPtnrtdjszZvxQ2gWdcMhofKvBS7cxRgbD6HUpw
 LDV5RT22wCsDCqJQjAEfwbuestJMRe9/2Nt5aVlFQizoEJb0SeZdSiF2dY2zFcQbDlH/
 2D/qhTU+WCiS7qDXI2BbCOz+C+GuzPllFgpDTjZMrmWUJpHvNgviMvJDRKqmPFmsVI4v
 JuGYZbyHFa0s5PJVMpN+4U1+r5Kptcu8hYpFyYEnh6Ga+UYFb3b4GoRtgzrFanF4dTsP
 CVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697731216; x=1698336016;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jpB2UUK3rXwMef8/0D7EGmoaiLKvaTfr8l4NhVfttds=;
 b=HFvKn793yUyElJWvLM3RKaOZHUJDG1BZWfSnn2F1KPdO7vl7WQe96fQeoY4z1ngHwU
 Fv5MV7F+g9tp1kxL0vq8mOWUi0lB8UoqFh8CLfg6iKyHGCgywxiU5jNAJmk6AIs/MoEL
 x71Ej2+v5dLoUYA3cJ6SbxpKJLawAjqSxr/RtqaYFKBEWQZl2T/NR6KdpsBPTwAGSnEH
 1M6f8rLFejDliidjS2gxbP46w3g2A2tBB7NlAyEhhNgDcMeQK+HHuw03FLFd0elDQETX
 gLzyuHyFylsqYxujX0+FcWBZz+zpD6S96EBgrtLxvf+bFyhmiTbN970lKAu3l8DDhASo
 nH+A==
X-Gm-Message-State: AOJu0YwEcfqeOTPr0UUwLUgXIzKu+Ymgwn2M6F/zBz3AnlqSMYgMvupH
 dDoFx6u45x/3eKQK1hFy7Tnv35QAXCukfkocDZU=
X-Google-Smtp-Source: AGHT+IF8NWIgy4WkjnG8GLDtYfLMzwTjksxaCzFVpua9aCC2WuMrtt3/0LlzLk4alHYNFv8JqJC5Ng==
X-Received: by 2002:a17:90a:fd17:b0:27d:24ec:4fcf with SMTP id
 cv23-20020a17090afd1700b0027d24ec4fcfmr2283328pjb.22.1697731216241; 
 Thu, 19 Oct 2023 09:00:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a17090ab88e00b002636dfcc6f5sm1729799pjr.3.2023.10.19.09.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 09:00:15 -0700 (PDT)
Message-ID: <7814eedc-930b-430f-ad36-09f95809ab37@linaro.org>
Date: Thu, 19 Oct 2023 09:00:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/19] tcg: add negsetcondi
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231019104648.389942-1-pbonzini@redhat.com>
 <20231019104648.389942-15-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231019104648.389942-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
> This can be useful to write a shift bit extraction that does not
> depend on TARGET_LONG_BITS.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/tcg/tcg-op-common.h |  4 ++++
>   include/tcg/tcg-op.h        |  2 ++
>   tcg/tcg-op.c                | 12 ++++++++++++
>   3 files changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'll cherry-pick this to tcg-next.


r~

