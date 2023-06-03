Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D92720DBD
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 06:15:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5IfE-0004yL-MB; Sat, 03 Jun 2023 00:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IfB-0004y0-UR
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:14:49 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5If6-0003AK-3Q
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:14:49 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-25692ff86cdso2245507a91.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 21:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685765682; x=1688357682;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yipHdr153P9l+6Zc/r11i9428X5yefNijCQWcRnFEYw=;
 b=QSGM3lSEBCDbOS1eah/qTq3X5NAbrsDiIDl9FgFopUWWAH8orFuqwJGsmJcOhIZlO7
 /RHzW8cCKotGYcLknI5PoieeTDHfaH0KBEuCnIyGtVFW87x96qew6W3IYeSrwmY5EyJo
 CByObYOG4ts/4/0vXKZ+8QF7sIJiOoXpoe7x5rh/GmIuxpgkWQoMw9Rn52n12FV8SmwX
 F6SNuvgZbHEa8guz46EPzW04tz40fFcodxhKHf5VBOKmUs0B9viqpwrjDgxplSookmgX
 Pk8zt04UzrIv98MkNDpkFWSBX08c/doIc/v8U/nKV/+mFfGHysK6BUMJyoFH/ukP3Dqd
 GG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685765682; x=1688357682;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yipHdr153P9l+6Zc/r11i9428X5yefNijCQWcRnFEYw=;
 b=YjgAIeMuOxofTIV+xKcazUJuRY14C4SYLwQqCoBhk5O2zHErFhIXpoJshhp0J5pqKz
 tsBFoemtuwIaGj3U8d1bzHENnhrU/3LpgKbB1E1PYEKKMXxz+sKqAYu9HlEuDjaQs4Uy
 gTqrRG7hfiOziwuEwRImLT5gAnIxAMcqjHVX+sR9lN/0XACdDwfTGV46LCLyfhSV6n2X
 aRCdQrhWKkiAfJ2sP1jdMp380kUHqHSRUknSLnywdXSSfcs8pb98Uk5q/pamoN1UqKuR
 RUU/tkkPDEPMO/CzfPgZzolVmTfiKS5R3jh35b91Cz7pFG2Va1L/UfMNW2sOPHpGyZLf
 HBPg==
X-Gm-Message-State: AC+VfDzdijhlySYkrWtOBKk5Bg2ES83lzHkrko4/NwP5ryVTFGIJ8Clg
 UTsvkUOnW026CUp4K8gliizpUg==
X-Google-Smtp-Source: ACHHUZ4g1edftgPxavKHjryBS/ymZNzw6Hy/3wRMA/CxNbdDkvkO7upPS2bU+JrUDyQfeqhy8mjCHA==
X-Received: by 2002:a17:90a:728d:b0:255:58c4:fbae with SMTP id
 e13-20020a17090a728d00b0025558c4fbaemr1789550pjg.10.1685765682394; 
 Fri, 02 Jun 2023 21:14:42 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 y32-20020a17090a53a300b0024e05b7ba8bsm2077958pjh.25.2023.06.02.21.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 21:14:41 -0700 (PDT)
Message-ID: <0c6d5466-8d7e-4c7c-0255-1239932adfbc@linaro.org>
Date: Fri, 2 Jun 2023 21:14:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 30/48] exec-all: Widen tb_page_addr_t for user-only
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-31-richard.henderson@linaro.org>
 <01ba1219-49f4-4eef-ad1b-226a7f647ffe@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <01ba1219-49f4-4eef-ad1b-226a7f647ffe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/2/23 03:02, Philippe Mathieu-Daudé wrote:
> On 31/5/23 06:03, Richard Henderson wrote:
>> This is a step toward making TranslationBlock agnostic
>> to the address size of the guest.
> 
> My understanding is tb_page_addr_t is QEMU internal, not exposed
> to the guest, thus abi_ulong isn't required. It was a tiny memory
> optimization we could do when abi_ulong is 32-bit. Therefore we
> can widen the type, unifying/simplifying TB management on the host.
> Is that correct?

Yes, exactly.


r~

