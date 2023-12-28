Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D96881FB43
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 21:57:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIxQx-0005WP-NF; Thu, 28 Dec 2023 15:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxQt-0005WC-3y
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 15:56:47 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxQr-0006ww-G0
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 15:56:46 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5cd5cdba609so4821609a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 12:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703797004; x=1704401804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=joL10UB0VL2YFhMdTd6nJYypJxXI4gVA2O8QJ1xXX+E=;
 b=oLatimDeKCcbY1PCw1DJ1xf9X6qdnmiDpwjwGO8XenpLbR/dZhiwXoGm+II6BAwpFx
 dOoAaGn98gSMOzfoStoMPm/LPWtlIbwa0WdZYUdzGinEbipWzuFuKakloHA1L/IpFzzk
 kmYAh4bUgfFVAXAGWzT6oV4uSF3Ti6kFBm7p6IQniE9Dybz6X8VMAakCL8s4sk7H/8Ke
 XXWQI9sgc7dg5o/l+asyRHIMUS9GHTvq+lfMKaaDkRdOMDGlWdYfFMBz5XLsAIzESrhO
 5DjrUtT7SrXGzzz2WlptAF8uA7xXRuWY7p44s1Z+XZO0BLR3114iWc0dt/iNnzeYjqVS
 9Y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703797004; x=1704401804;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=joL10UB0VL2YFhMdTd6nJYypJxXI4gVA2O8QJ1xXX+E=;
 b=RqKJW5i3tqRzw8HAu/smMKfcuFTWuiyeYmlD2T+XFFIe6uiVAhba0dEWFNq/Evlf5D
 np17HwVIgf0RJfsxDdS1p0g9KniY5zA8EKOjN9tDntwZSP5XrNHTBzccSWPfwmPfzm20
 HCVXd9lWV/A59XlN1qApo92xvbXyUbzNMt9xLfaFxY7HsvQKlpQxhW1sOzutgSSUKCgk
 45bbGo8mPtTAtiEa4T19wqsi5BuICSYSLfqThPpqpF/njd1SN0Xm7H2v2/lIU7OHrVTX
 A/jp72NOmgQCRK5ZjKpAPcdnRqIHP6ZZlB0Rf9fCIep1ZGw+LpB+0yWswkpW7JP6a4WK
 YCzA==
X-Gm-Message-State: AOJu0YxxgszwN+FXO4l1jqALTHWu4yXdV2ek9kyDkOEKKM5dihhJjFwk
 WVwTIM2VTPUpC7lt+iiVRYB8c0aWKL1QY1Pee9TgYj15GF2Q//6X
X-Google-Smtp-Source: AGHT+IEQOGAtwUat0K/7b5D/6V8tVwPdCM5QH87UKE1D54jzDhOYHxu30UbQlz8mQHY1UW112yQb0w==
X-Received: by 2002:a05:6a20:2448:b0:196:5670:6e79 with SMTP id
 t8-20020a056a20244800b0019656706e79mr1449800pzc.6.1703797003902; 
 Thu, 28 Dec 2023 12:56:43 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 b16-20020aa78710000000b006d9b2694b0csm8614853pfo.200.2023.12.28.12.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 12:56:43 -0800 (PST)
Message-ID: <3b035a60-2d78-4919-8efa-146fdd5fe0ab@linaro.org>
Date: Fri, 29 Dec 2023 07:56:38 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] target/i386: speedup JO/SETO after MUL or IMUL
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 12/23/23 05:15, Paolo Bonzini wrote:
> OF is equal to the carry flag, so use the same CCPrepare.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

