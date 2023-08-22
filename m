Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C996678467B
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTqe-0003nH-SX; Tue, 22 Aug 2023 12:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTqc-0003UK-HK
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:03:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTqW-0005qT-4y
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:03:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so30400025ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692720187; x=1693324987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nbc7dpVmsRe0mHKdlO5+Hp0AJ2tK6csvA7zud2+Ri0o=;
 b=ugIWYT7Es9oRHBr83U0dGSK7RE7U+1D553gkeyJVf5/zIUKyiVB9AthC+uZfGKj9ZV
 0Ijy3xXS9TOp7iRpwzBrSN44tn8JelviqJ49d7ig4qMQ2mxcGe3HuN5D68kO6BKCOb+d
 QV2RFreBl8KjwETu8/moZQWv7C+hHLRqjsmXFuHnj+XNBzX4POUGHOjqRWOZcCEk7Gsb
 1Y4ra0vgnbRp3MJbYVRjMXG1X9QvADMV588CdA07pPBEjJlpMcB5Kk58t17BVdAQKuRM
 ltPWPE/0ytI/MIm3FBKEFhfxfB6WgKzQZy6CSl1nm6sjA7FcH6Z5AL+eFy2ouOZyNxVx
 wRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720187; x=1693324987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nbc7dpVmsRe0mHKdlO5+Hp0AJ2tK6csvA7zud2+Ri0o=;
 b=Te3XvyOHHqZ5hWfeF1zS2XhBHMRXZ9lFyzr7AvxbFV0uAQgiuhYHuaOL3QYdzKk4/t
 GoIRtCqENeIhKO5h+SaqoYUHCNFP2NcKB/X9QdPnsRbBx+Ej4MnTM/K/xQKuznLJiRRu
 YDaQhsPjscfW3hffyFnPxlta2lCGFyeSimO/sHEhdR9U1WW/kFr1gFl9ORkmsXTIGtRK
 TcXgTEYwWJyw9d/dbkWrhaWWMLkSbabWTeT0UqFtlKo+OTYyvHFDIulYZ5riqH5b33Wt
 7mMY/Bnu3aA/uc7bPkbo7R1g+cHCMSyLIZOea2URqHEOB3O00zaPZAxc4kKkN0yz8Vw7
 ODGQ==
X-Gm-Message-State: AOJu0Yz8zeeh9arAGFma/HsPN4NYspRivG314s/dlL59lW2WUhvsXhM2
 aE1ecFOLjynJ445WSVmRBoQh2B/LBvAlBoA7FK8=
X-Google-Smtp-Source: AGHT+IEefeVr1GezJeUaxQtrvduO7rWFBvU7hPoDYcKV70uhKT39UXrjZhyVqOgfKqDYJbxSpCk/rA==
X-Received: by 2002:a17:902:dac1:b0:1a6:74f6:fa92 with SMTP id
 q1-20020a170902dac100b001a674f6fa92mr10224045plx.19.1692720186729; 
 Tue, 22 Aug 2023 09:03:06 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a170902ea9500b001bc39aa63ebsm9225862plb.121.2023.08.22.09.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:03:06 -0700 (PDT)
Message-ID: <9de8370f-be08-af68-a41c-229c9f61d0ec@linaro.org>
Date: Tue, 22 Aug 2023 09:03:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/7] tcg/tcg-op: Document wswap() byte pattern
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822093712.38922-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/22/23 02:37, Philippe Mathieu-Daudé wrote:
> Document wswap_i64(), added in commit 46be8425ff
> ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   docs/devel/tcg-ops.rst | 4 ++++
>   tcg/tcg-op.c           | 5 +++++
>   2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

