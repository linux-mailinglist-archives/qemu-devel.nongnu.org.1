Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34F70E63B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:08:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1YHc-0004o8-Bv; Tue, 23 May 2023 16:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1YHP-0004nb-0O
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:06:49 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1YHI-0008EH-JV
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:06:46 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d30ab1ef2so160510b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684872384; x=1687464384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Vz/VLomKz4d3cmVjs0HndB7mQDYsROfmH6Qa3spUcI=;
 b=gkASZspuklju14t/33fx2E1dvXb0fzWVBjwTILcXgT12TP6zfW+/obyYv1TQQOWG8p
 fRfjnW3nqRekDPw6/61D1EYO48dJIQm5PbdrZBq0O5VJt39K61WUH5nq8CbWkX1NhZT5
 n9BxhSxBxXG3qEqONte9O2u3MI7GQ9cvvBio0rjduJVZU7ElUpkGYGB2GLaHDiqZCit8
 bayVQ7OUZqaptNqMiPTh4FKH5nloQaFFdhujzN8rgYO9GGXHlIzurTkAc8ZbJgo11llE
 veG6Ztg+Hz+wwLGL77z5msQe82O8NQrwaWL8wqAExayX2BUM0JE0WGn7tfUfmRjp73u7
 0+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684872384; x=1687464384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Vz/VLomKz4d3cmVjs0HndB7mQDYsROfmH6Qa3spUcI=;
 b=XHaSqWjHp2nyx0TXGZzWD9fJ7d9I8J8NpDO1FAp6YbT4SdUIm1/KYD1OIfxIMMPOD6
 4YyDk43a0AwAEIjsmlP/gxbtGJbS4sRVhmdw+Ub96Kkjn6Ik/M0I2ALFYa1lCSECP/eM
 JUjaWrizCBzejrYP/tiQ73OxuOBvSJiUo9kNaBHpUejGKBkfhQJd6vJyqSZMedGGaWYN
 kSybnXMa+jCMu3OrTnZyM5P766QLdopPLahahVIy9Nia/0ZsLpmALpeudUM2bVouYuY2
 Lo5mEjPFTMdvAn9DMDc7muFetK/eiTYSKOXP58A3GYeUm4IURHEfWv3CvXO/Be3aOxQC
 Kp3w==
X-Gm-Message-State: AC+VfDxdfd3x2qMLVGmrghaiDG19qX6ObV/oATcxoeYlU0ETF19c1fna
 HshLpOlkBBbRliqA4ILNt5kQSw==
X-Google-Smtp-Source: ACHHUZ5hF913PtmXpR+l3FUR5evX3IQgPrMcWIF2stqLxhFP3P1727BFuiTbRp1MRofPl+w7MV50HQ==
X-Received: by 2002:a17:902:f7cd:b0:1ac:8ff1:99f2 with SMTP id
 h13-20020a170902f7cd00b001ac8ff199f2mr14379678plw.5.1684872384469; 
 Tue, 23 May 2023 13:06:24 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a170902a50300b001a1d41d1b8asm7141454plq.194.2023.05.23.13.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 13:06:23 -0700 (PDT)
Message-ID: <576002bb-59bc-ab24-bcd8-5139867da8eb@linaro.org>
Date: Tue, 23 May 2023 13:06:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [GIT PULL 0/1] Host Memory Backends and Memory devices queue
 2023-05-23
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230523150240.365055-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523150240.365055-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 08:02, David Hildenbrand wrote:
> The following changes since commit 886c0453cbf10eebd42a9ccf89c3e46eb389c357:
> 
>    Merge tag 'pull-qapi-2023-05-17-v2' ofhttps://repo.or.cz/qemu/armbru  into staging (2023-05-22 15:54:21 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/davidhildenbrand/qemu.git  tags/mem-2023-05-23
> 
> for you to fetch changes up to 4b870dc4d0c0895859d34d14ce0272a4bcbccf78:
> 
>    hostmem-file: add offset option (2023-05-23 16:47:03 +0200)
> 
> ----------------------------------------------------------------
> Hi,
> 
> "Host Memory Backends" and "Memory devices" queue ("mem"):
> - New "offset" option for memory-backend-file

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


