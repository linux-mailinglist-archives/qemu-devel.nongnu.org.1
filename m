Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 052687874D1
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:03:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCn1-00010Z-L2; Thu, 24 Aug 2023 12:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZCmx-0000wt-Uv
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:02:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZCmv-0001CR-OL
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:02:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401b3ea0656so1038875e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692892944; x=1693497744;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vWe9eS8eVZXO8P90ktu6f5qpHSoD/+PIq6FXrZKBQ3g=;
 b=XMwRYmSFPjXhA1JCN1+IJCu0mFWB6sz7gQNJsVQMkcI8U3f6vdxP2VP79V6DhPqxle
 75f/yK+pfLXW9n88eLvLngdURcXMEEnb5Ty2+NiIyQgZf7IMYjZ4AokEMz5S1CzdzYc+
 zcQBtz/OBAl73uqUBJ8F7lSJKPYgbiA7ps9Tt4SeGPU/mTEMFEB3T+JljCboC9hwlKto
 LeZvo/WzaXwsY7HLTzqwIpCyt0L9t2TH4XY0WUXe7PCfHJW2ezGoDPuhjWBrprO0HtSd
 +NuBDsaLWpHuRZWx0DZC3IwQ5P6CX8gG9ss3YfKiTL3GuZS37rgjZGESgML9qXb4/a5k
 ScQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692892944; x=1693497744;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vWe9eS8eVZXO8P90ktu6f5qpHSoD/+PIq6FXrZKBQ3g=;
 b=jgpQUTxBIKycQTZWywz+L4DhcweyCtnG2KompQvKf4UgTkzPQv4GJIzL1B+Bf/DlXl
 LtMuBVkcdyJy6TcID2GUY14uZsKoo95wb6emFYPP6eLuXTl3fJz9XqcGeCyLe8halmoG
 mmwCOd3xJxrcLX29/PKwi0JIpZXrymzLRAN4l0eQyMjMcaou6rd93zxqSh/WkkYyrjlK
 pLcHKeKoWYwclq50ODzgDREtb5UnRtBV/6vld3abmbdIthrMUMnebjl1dKvpbYFCrJXH
 LStbXQY+f5IV6knFSaijKRaPO7RueePj/+Nro0On3wmnhPFuWsR4ctanjYgxJ4gHozMk
 Pyng==
X-Gm-Message-State: AOJu0YzHvrW+tUmb8H+K1djKHLYe1ulfaEGO9FZhYqOgx3Xql+QPGXD3
 iyU1QtnBxI+Hi29RNUa96Aep4g==
X-Google-Smtp-Source: AGHT+IGKMfpWHq4wkkvnwRzuVkoHdyR/X0xGgqdN1SJXn8hG6JzBm70Drw54HZfDD7U0DfTtmaPiOA==
X-Received: by 2002:a1c:7412:0:b0:401:519:c9 with SMTP id
 p18-20020a1c7412000000b00401051900c9mr2352531wmc.13.1692892944029; 
 Thu, 24 Aug 2023 09:02:24 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c21ca00b003fef3180e7asm2985549wmj.44.2023.08.24.09.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 09:02:23 -0700 (PDT)
Message-ID: <53f5a2e2-ed79-0dc1-9248-0ab5cd13f34f@linaro.org>
Date: Thu, 24 Aug 2023 18:02:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 01/11] target/arm: Reduce dcz_blocksize to uint8_t
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230811214031.171020-1-richard.henderson@linaro.org>
 <20230811214031.171020-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230811214031.171020-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 11/8/23 23:40, Richard Henderson wrote:
> This value is only 4 bits wide.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



