Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDE07E2C48
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:49:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04eH-00043Y-TX; Mon, 06 Nov 2023 13:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r04eD-00043G-T1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:48:31 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r04eC-0000T3-Dz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:48:29 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9d0b4dfd60dso713392466b.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296507; x=1699901307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XXkzRDwLByfNZQSXQsmnAeVhyfxN7kOG53Q8pCA+Z64=;
 b=wkclg3xCxqEqm2aP0Vkh8pfJfpJxLgHTU7bL9/MSe+9azykrjNRTCGwYBoWcvJe1ns
 90szj9ix70uFeV4YElIUBo04TIfGED2Zhl2NxjJwqeIUCjlVRSe30740Gm40QLoKtgzv
 IUeECi3YBeEFS9U0d8bEOy6P/Bp9wRN506A8jF8GXudbgbTEsxJDYVl6fVVQMnHWjOql
 1myz81tPjCcPgbfcB1NJgaUk2hGJTL8erpkjCVujVLbsRTz2nymM7t2AiHpbE29fhTyo
 UBTnoiiFxCXuyxni3mU+dEeMxm3Wwz+3m6JYlsarknfj7aEu44KpZu5RTL/FVwmaB11d
 6/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296507; x=1699901307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XXkzRDwLByfNZQSXQsmnAeVhyfxN7kOG53Q8pCA+Z64=;
 b=ohbalWF/PHVFjO8C7l5X/+f7YCzc/V8SIqfoGPng6drFl7lKE+uD0uOQi1NvHWF57H
 W7bdLbUOc0akCWPaUTEx3c1aYAeAKuYRiPXIfOuQ4rk+8pB0SKXAWj1/Gy9KcQ/7IYVH
 cAqxqJU5Z9sqeE+lJOfgNyuqrHrcObpQMvWYpzB3BWhq9UQnxtSrGnzfnsVXQX/nlzBD
 kl53P8X7lvzdrH+8gyifY03avZruH7xKOD+lHmqRnYyNzxbHFzK3XIVdpWIWLYWDCVZx
 JqN9YdFEcCKNSARpgnWrVLjkjFHsC+mrB/eJ6pDzQiW1J270u7mda7fyB+fq1wopVXBf
 iKPw==
X-Gm-Message-State: AOJu0YxjQ3LwYV5VbyfgEZaAebcqcw+kpmDWSHcFh9JXBsGyA81JzcJN
 I81ReCpD74Nv2Kl17eLrHuOdJkv2YLj8T1TMoq0=
X-Google-Smtp-Source: AGHT+IHHYs17wWkzkZdE3MgR/3jPfEAW595CKe+Los3rFR0hvp0NnTW5zAb8kl/BDY0BViSdLH52MQ==
X-Received: by 2002:a17:907:2da3:b0:9bd:c592:e0ce with SMTP id
 gt35-20020a1709072da300b009bdc592e0cemr15640952ejc.51.1699296506904; 
 Mon, 06 Nov 2023 10:48:26 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 gy10-20020a170906f24a00b00997d76981e0sm127514ejb.208.2023.11.06.10.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 10:48:26 -0800 (PST)
Message-ID: <7e98abe2-5d02-d31b-9874-dcb23ae2aaf3@linaro.org>
Date: Mon, 6 Nov 2023 19:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 31/35] tcg/tci: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-32-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


