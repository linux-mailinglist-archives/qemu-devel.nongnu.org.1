Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4DD78485B
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:22:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYV4t-0002Cm-57; Tue, 22 Aug 2023 13:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYV4r-0002CT-P2
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:22:01 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYV4p-0006TL-CH
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:22:01 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-564cd28d48dso2707263a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692724917; x=1693329717;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M8/qesKjNzAsc7M0glnoFZeSL+KY5dfBqio0TnQ/nis=;
 b=OS955Z4xdlBKykBIETvtuglfVqKnTwlNtCtVTcvSH6z4cQtECmLH9NJspFK9IMje1x
 O04hDiUVqcD+EMEYK8bBvVuvBB2VN1Yijom+iCgl9wG/P/ocGs1LvE+FT3WjpXbg7BK0
 aSvHob1Imrj9z3PUIhhwbc2I0yjYOxw/cZgxtWImZIR9fCAZk53tvhVqgDlHLKCwEXmp
 alPQT5hNE3n0RxpaAaGnwOWrDa1dbXtwRh9jDwUiXSsH1zyM1LPwubnLvSHTEql9yFEb
 jW3wiK9pvOdtdcQfHtaOZMkUSQibAhVUnYhxiZW+9oPcWTJDnXpPxXqTTi+GppsJ12yS
 BDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692724917; x=1693329717;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M8/qesKjNzAsc7M0glnoFZeSL+KY5dfBqio0TnQ/nis=;
 b=Wq7CavaLqKuOZ9oy/esARA3HOhRr6Qh1yRCrD+F4bjVbVKWA05jgpvk2mkOnlBU3eN
 LAAcvhO1wO4DM4pi8mGW3Xsc7VVHufdvXAiRgfoK7r79izSkkK89kg6o2LieDVcUedQT
 Q7a6zjHOzAbSUttyxxalRFlk/eq6ThXkAchGwTL6TyCkv4y5fCIYlrZYuCoWNXkupXV4
 4YI9Eo0RSoZUAVUMvH2gXw0cvFMjrrGkSrE64E4mVP9vKB25XlkAc/dhS4lEej7JpIDN
 SIKH1sb3+4IAQp64bGlkqS/LGXLkrKOH+ff/JXsptN0ky4hPWmkhFQLM69CWOZNdc8L7
 5Etw==
X-Gm-Message-State: AOJu0Yy0qFlZDOG4XqimKofObsm/Nqrx1xfRrKshg2y4r67uB8R6JnvQ
 lF1W0GjMOWGonB5LJCLx5q/YAILAsn4kIimASm4=
X-Google-Smtp-Source: AGHT+IHlJM1+RmO8ICUK1eI+qd27u/CtFMJIQo+4EOWOOcm/G11KC6njoxMKSGlBt5MRjfNeFhhk0w==
X-Received: by 2002:a17:90b:3753:b0:269:3dd5:b009 with SMTP id
 ne19-20020a17090b375300b002693dd5b009mr6779188pjb.44.1692724917017; 
 Tue, 22 Aug 2023 10:21:57 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 6-20020a17090a01c600b0026fa1931f66sm896563pjd.9.2023.08.22.10.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 10:21:56 -0700 (PDT)
Message-ID: <38aff2ad-7bf8-e5f4-2056-370274224ad5@linaro.org>
Date: Tue, 22 Aug 2023 10:21:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] docs/devel/tcg-ops: Bury mentions of trunc_shr_i64_i32()
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20230822162847.71206-1-philmd@linaro.org>
 <9e575c36-942d-d61d-ef15-d126888c0ea0@linaro.org>
In-Reply-To: <9e575c36-942d-d61d-ef15-d126888c0ea0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 8/22/23 10:08, Richard Henderson wrote:
> On 8/22/23 09:28, Philippe Mathieu-Daudé wrote:
>> Commit 609ad70562 ("tcg: Split trunc_shr_i32 opcode into
>> extr[lh]_i64_i32") remove trunc_shr_i64_i32(). Update the
>> backend documentation.
>>
>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>> ---
>>   docs/devel/tcg-ops.rst | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~

Queued to tcg-next.


r~

