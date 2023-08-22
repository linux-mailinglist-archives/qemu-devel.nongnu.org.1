Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7314784CB4
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 00:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYZYL-0003JD-N9; Tue, 22 Aug 2023 18:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYZYA-0003J3-Qp
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 18:08:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYZY8-0000bU-Mn
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 18:08:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fed6c2a5cfso42792665e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 15:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692742111; x=1693346911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u2Hin/d4dVFQqCtx2+2ASRvHJxvhGO67Gzn9C9Rkzds=;
 b=jWqNFdlgrAr8Q/xwwRsDIs4I4e22D4DvL3nipXE7/BxohCBbZZAlopYPWScJIHwLk6
 hjmgDTsYylcIwzGALK3hQHSsuuCWOINT1bGKeaQGD5uJGjqB9h/sUStCCWtARApIg3yj
 xBklDSoicJMH7ec7eCGYR9HSummo8qDw8DqTJvI8DQtDOQWg02FgPLO26+y5cwRLhm7p
 lXKyZmjUgDVv5mJX+ZxNjPL85wlw6MTA04smyUkFiP2CYKqKucNxAz4LoGCSNTdI+Dsh
 i5a1C1Ht9lzTgA3FmSmqs26xWgmN+t85oWUEnIA3VGnJ4ZJD9kaaoj1wiarGqHLHWgTU
 5riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692742111; x=1693346911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u2Hin/d4dVFQqCtx2+2ASRvHJxvhGO67Gzn9C9Rkzds=;
 b=G5TVl8qU8+AC+kgGllzeuszteTnMscsVCLm8BjkB4Fu18ujx79At4VNrVbasbQAc/Q
 ljk2BzZgkHZ0sVfbc3ekRpwjLs6t4T+dmvKd1NshuXCi5KB4YKLaML8uQuNmlxcCuVCI
 QuHS4NwpeRQjtgRMEiA4MaqFa0hGSkXg9PIFbDF7VY2XYuT7bQdLDv8uLVC621/Sh1af
 DDrZ+y/Eu8x7OUXN15VjkRKoWQaVIrho6Q5DjxM/qPncfdvH2U640oOnyRq1DzFI97ZB
 z3VxBt98VOyYpTSnKAM70yKVavKarA77jvaVHHAHf8n5+I3t6vfATgaUNM2XmESZ1cTL
 8yAQ==
X-Gm-Message-State: AOJu0Yw9Alr87Liq3M9xbnznLMFN11NKZESPaLrIaFiTR4RqX7RI05GS
 cvoqNCc/z6n7gkbW+oc6v8ZWd/2DM5nC/aba4Zo=
X-Google-Smtp-Source: AGHT+IH7LU9aqTBaJZGY3gR7Y5jvFnJZA4pRhayW6bJ2RxjG69oddzUabdsmR5Iy8hCtSZbp0gn+Jw==
X-Received: by 2002:a7b:cb85:0:b0:3fe:20aa:ada0 with SMTP id
 m5-20020a7bcb85000000b003fe20aaada0mr8364126wmi.15.1692742111524; 
 Tue, 22 Aug 2023 15:08:31 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 a22-20020a05600c225600b003fed8e12d62sm14757077wmm.27.2023.08.22.15.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 15:08:31 -0700 (PDT)
Message-ID: <49ed41a1-3751-7a3a-0085-6c626bb65839@linaro.org>
Date: Wed, 23 Aug 2023 00:08:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/3] linux-user: Exit not abort in die_with_backtrace
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20230822203415.1184491-1-richard.henderson@linaro.org>
 <20230822203415.1184491-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822203415.1184491-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 22/8/23 22:34, Richard Henderson wrote:
> This line is supposed to be unreachable, but if we're going to
> have it at all, SIGABRT via abort() is subject to the same signal
> peril that created this function in the first place.

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> We can _exit immediately without peril.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/signal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

