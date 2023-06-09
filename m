Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D31472A1E0
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:13:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7gby-0008FY-9O; Fri, 09 Jun 2023 14:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7gbn-0008Em-Uu
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:13:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7gbm-0000qa-0g
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:13:11 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-652328c18d5so1660566b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686334388; x=1688926388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HX56R+b2BUJ4yqTWmIzO0Zy9fKdPv+qHkThSDlaNP4Y=;
 b=A2b2Y66uD1057ntc7Wbu2xoUZBIclrd1dIP0k1T8eWRd3NSStHHoSBqosOlOnLZEW/
 oI1J2aAdk/Uvej1fsERNA1Uf3rQTImqTxChGGf0JBZ0CFEReIjyzZig/sSPoU76+cReY
 bCPMpiAS7f9R4aLYmtPg7BGBFetYv8zh21KxCq1ldlOUjaxpTuyLFBwQuRmcmOk9Ah31
 tU3XZxtAm2deEK2ArAMMDMbd5W1JN0iA3cMG3E6+GpAlYwF74kL2qvDUjMdTLPYLVQ5a
 e9cDuFpMyhDwpxwS01H6yt8/axSQgSgxhCRAWONNHrUv28C1wv8zczEuldsxNmORtBni
 s31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686334388; x=1688926388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HX56R+b2BUJ4yqTWmIzO0Zy9fKdPv+qHkThSDlaNP4Y=;
 b=JuHxP+JudvMgA88u1TfNVMX1CaQpsx20VIkzClcy1Sx89eUL6aiIm5rxJiILQXfYLK
 M5vCkviXEOSzO8C2iKoz5nzG0qYc+NBC3Aroowcb46LaAByebofBK/G6n5gnrKKKI/ac
 /h7UYwU5J6Cu18fc/qUgMk+q8L8mVQmJsIUziPuvpYWqPs8wIKcy0trpZ41Uxr8EZy5q
 EzMPbM1X68dST4Y+fSNdroZRt0CfQm8tA+OIXejc+V6d/c49KsuS5j5dB+5LeEztC+13
 wvzpFa7DcQC2rq3fVnQ7wb+T6MD3hEIOfQnp06Qz5YZsNSkdLHcXfQCdHPrIoKPEtgJL
 7DKg==
X-Gm-Message-State: AC+VfDxa5HOyqbI0VWAKzbfBvefXQYFb3VjdJ09z4p2eamWkb3DxkuJN
 j6zb52tt3aqGvGZgROk95AwYBA==
X-Google-Smtp-Source: ACHHUZ4GsO5dW71kKX4QlIqvuSnrq4XBY4R195AYaygpQ4WvlqNE4catnTNJDTisSMFpIP7/0HlRzg==
X-Received: by 2002:a05:6a21:328d:b0:10b:2214:7ab0 with SMTP id
 yt13-20020a056a21328d00b0010b22147ab0mr1966717pzb.21.1686334388350; 
 Fri, 09 Jun 2023 11:13:08 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b006414b2c9efasm2951166pfn.123.2023.06.09.11.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 11:13:07 -0700 (PDT)
Message-ID: <c2b0eaf3-94f0-8b23-0eff-435b79060e97@linaro.org>
Date: Fri, 9 Jun 2023 11:13:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/22] accel/tcg/cpu-exec: Use generic
 'helper-proto-common.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/9/23 03:46, Philippe Mathieu-Daudé wrote:
> We only need lookup_tb_ptr() typedef.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

prototype, not typedef.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

