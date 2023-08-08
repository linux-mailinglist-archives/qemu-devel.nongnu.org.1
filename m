Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB3774F95
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 01:53:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTWVC-0002jE-Hd; Tue, 08 Aug 2023 19:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWVA-0002j2-UY
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:52:36 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWV9-0000jC-Cm
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:52:36 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-686d8c8fc65so4405598b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691538753; x=1692143553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QE9WLZ2JYrU3WGYeOIKGJ2g9gf0nyJ2ces6bgHsZzTQ=;
 b=B8vN6545AS48spKOYa6m38jH40NS+FyXJhHgzPcwKkXSfRx8qrLIhYVzilFNso4Y6E
 z0FOFLqCL98XdKgYxtHyGbc9dtCjS6K9oai+a58efWy9zybDgTMpS+FaH/bW36xcO22Y
 m5MpgK5I+GSwzZb7p3HJMYjTEQrzLvpqODPzBr9kOwJBMed/h1BojY0avEQCkfvJCdfy
 1gjFSjWDfUXGX1DhkqjjPrxSdvVtNqJizmPpgtaOL+9YbRJV3eivtfuRL7OkG/q3cgwg
 rnI8oomO+EgKf1cccK6bOYNoEXMuzOno1ne29/Qi4p+qxBpybOiCP4Ifv0Upgki+foDQ
 I2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691538753; x=1692143553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QE9WLZ2JYrU3WGYeOIKGJ2g9gf0nyJ2ces6bgHsZzTQ=;
 b=gfu3Y3kzyrpKg5ZOKBLpGk0vG2fidnXRvBLFh9pvAgxr8tgfJyM9r4w0hoHngG6Qe3
 RQP3B8uHyazztJhGHSKgFoJMxUX0WVjyg0PHEv0XyCEAQksJ+KwT/IKtIsYmI7RAwwGn
 hP6ctqm0xkPnY9rLM2OWJY2H3tB7i+nX2QYLWm703Q50rUMWl9HDmCYgljeS3giF143U
 J49ssEjiXYme2/dLI4GOvLJmw5JouBFtdir609eBU3fyMlxoL23zrm5XxRiXDL/K7yEd
 /lPF+dpbP1HcxuuwR/By80zZqjwNWsq79oaJ7qaRLGV6ijdAj7eQzLh/w4e9DiGsbDyQ
 ehwA==
X-Gm-Message-State: AOJu0YyxSxmr7h2MynlSC4PcjhUk3u7BUZEnl9ANRS6hppX+h+xYlKrM
 XniyatacuT+PzrJqhKXs/SXB8w==
X-Google-Smtp-Source: AGHT+IGr9MYzqPi7tP88hYRB+6Uc3pXra7C/6k/+faENaSgBKjJ7+rrl09me4r10e2y58Gw1fwTH0A==
X-Received: by 2002:aa7:88ca:0:b0:66f:fa65:483 with SMTP id
 k10-20020aa788ca000000b0066ffa650483mr1087569pff.0.1691538753633; 
 Tue, 08 Aug 2023 16:52:33 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 i3-20020aa787c3000000b00682d79199e7sm8649171pfo.200.2023.08.08.16.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 16:52:33 -0700 (PDT)
Message-ID: <2d48d977-2194-7113-037c-2a0fb6c72866@linaro.org>
Date: Tue, 8 Aug 2023 16:52:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/9] target: Use vaddr for
 kvm_arch_[insert|remove]_hw_breakpoint
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de,
 dirty@apple.com, rbolshakov@ddn.com, anielhb413@gmail.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230807155706.9580-1-anjo@rev.ng>
 <20230807155706.9580-4-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807155706.9580-4-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 08:57, Anton Johansson wrote:
> Changes the signature of the target-defined functions for
> inserting/removing kvm hw breakpoints. The address and length arguments
> are now of vaddr type, which both matches the type used internally in
> accel/kvm/kvm-all.c and makes the api target-agnostic.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/sysemu/kvm.h   |  6 ++----
>   target/arm/kvm64.c     |  6 ++----
>   target/i386/kvm/kvm.c  |  8 +++-----
>   target/ppc/kvm.c       | 13 ++++++-------
>   target/s390x/kvm/kvm.c |  6 ++----
>   5 files changed, 15 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

