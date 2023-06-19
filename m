Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 408C2734CBE
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:54:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9hb-0002sR-Js; Mon, 19 Jun 2023 03:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9hX-0002qj-Q1
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:53:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9hV-00077x-Kb
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:53:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f90b8ace97so18119325e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687161203; x=1689753203;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s6KDpk5z0tgHXtT4dr+ToqOvTOo9Ir8KSMBjByWWLoM=;
 b=JqB3Kfu+ZeqSooIPyPx578B1O17GC7VxBqKGFYtFrlAP3bHv4jMkEQi8023fxPX8U4
 moM4Y1yTPSMjbmsjBVjJmuxcQDBsOBp1ov/8LmVnnc4OyahBJJNXkGY300J3kdqV8yUo
 H564vhf5dm196OtSYlxomR66Yl94xVCqc4UHxXIT/AQtQW4wANcuNKGxZpqP0jZTp3li
 HotHSWq/q8bhcCa8kFIt+EaUosDotuAZVMdPHVJB9aF+ktBqsKZngvWOYxHIUCk/d1eJ
 K7pkCtIOsDykoRd/k13aPJRanBHf+QhMNSw2qmFPnBqqJ+RQI+Xofp1ZNJQdfvzQmFRD
 xHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687161203; x=1689753203;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6KDpk5z0tgHXtT4dr+ToqOvTOo9Ir8KSMBjByWWLoM=;
 b=H4NVwDAvolTrqPfrY6s7dkfnbwQU4+hy2WRgPnM1y31jyTfqeXDWt/623MH84yl4uV
 Y8vbOa0ANAWYpMeQWcDQU2oW2cvGu+j106fgzOkLwmG6C2ppjebKVd6uJC4ELAv5Ln1T
 FN6jIm2xAXK1EB8BMV4x4DTKVwenSSVgU2u5Z8OIsCn65YGYGlg2BQzMrUrbnR6GUyVS
 Kc2LAjhN0ghWQfoaxjWZtc5ed9zEeeiC0WoyufiiG35h6LfdFAwcnfM0Bu95u4EtBu3J
 oy3qON/cm2ZcAUfHbZ1dwPDsqVYoLdvYTbXkJOAvOhn2OB/EOjmCrMUl77JA3nuN39k+
 b7lA==
X-Gm-Message-State: AC+VfDxG9BPppqAixHR9oE6sSDxDlBa7gAdy1uh+9gGUCNaSJ0jQDK7M
 tGyJxMO/YV0/0ugPzhtS/2kfTQ==
X-Google-Smtp-Source: ACHHUZ7V7wR8Huf4AoiOcVWWGBqgjMA6GFjbq5LxOZl5LfFRTZXP4h3cm84FH8RxSQGzJ67C6S2sNg==
X-Received: by 2002:a05:600c:2302:b0:3f6:e42:8f85 with SMTP id
 2-20020a05600c230200b003f60e428f85mr8277473wmo.37.1687161203261; 
 Mon, 19 Jun 2023 00:53:23 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 q1-20020a7bce81000000b003f819faff24sm9784567wmj.40.2023.06.19.00.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:53:23 -0700 (PDT)
Message-ID: <9b1f4869-b46b-d535-75b5-a9d691d175c7@linaro.org>
Date: Mon, 19 Jun 2023 09:53:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/7] target/i386: TCG supports XSAVEERPTR
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230618215114.107337-1-pbonzini@redhat.com>
 <20230618215114.107337-6-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230618215114.107337-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/18/23 23:51, Paolo Bonzini wrote:
> XSAVEERPTR is actually a fix for an errata; TCG does not have the issue.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


