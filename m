Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFBE78CA3F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:08:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2CF-0001qC-B8; Tue, 29 Aug 2023 13:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2BC-0001W1-R8
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:07:02 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2B9-0006Qp-6A
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:07:02 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c09673b006so24143455ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328816; x=1693933616;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EJC4Q2Dzht6beo+iKRy2G8JGKTP6kbfY7xvxXxJ8pEQ=;
 b=melWkinxTKChj1PD0p3TEEAy6yR6thnnhXyd9u7hob/f0SvShyT2JawUXJgKcGHCLt
 Qj8nTNxWfRyOUKIT7z/3JSeDg6Ury/n1lp6FznLVtYng2NHEy0K9ng8M68K1NxIEEXci
 bV1n2jAbL56ehq0K1JGxhWSJNDHua6ckfGiNBvvjc013c6Yc9k/BKWlxzS7JkhaPw/nn
 DkTvr6QxxAY9Z/Md9d51tT797UYysYjJu0NRq0vafmnlJtJ7eg37fvBNsDAM07cvc9sH
 SxEkzcU5mtBhZZOZ1o6alVADwuVB0gnOSGek5esSug2ybSA3x1SrzcNbEmYpy3HZMxsX
 CCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328816; x=1693933616;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EJC4Q2Dzht6beo+iKRy2G8JGKTP6kbfY7xvxXxJ8pEQ=;
 b=POfQsyDgPryOjDg/t7rvgoon68ychLwggi7MoKKFO7+DaC3ncROyh3+OUPRtYbwkwh
 RKv+j2xBBptOTlp5Gy69YTRrq7tUaCR4sZCywJ4JEsphM9AGfHvPNMgIpxhv8GCTxNZN
 WCdaGyUCJBwIuZGVmHVAhmAvARVUS2mKoeG8dKJQdG4xbVleYoZfYCVJ59zUd6EeFA0j
 JFf+DNZEe8i6I9tasTd7O/dkpZjo61ocBXWSu8BBO3GWR1Q3HTokQ4IseL1gbDxmfSN+
 Gr6HViD7GDiaOlq5s9a91LIk8ZMBHxBsaNOvNOQANSR3iso8835NVL9zlzyB3DS5gMwk
 NnnA==
X-Gm-Message-State: AOJu0Yw+9si9ozYGBgPFfMihGsh5/8qVCJNApmungjFMOtwwnqQBGPGj
 hK8QP+UJ1HfQk+CtReU0K2T6aQ==
X-Google-Smtp-Source: AGHT+IFrJ5R2pA+5h+kS9QR6oxGw9+zwuT8bwE2crRQWHDR/ZhD58cPff4hfUsFu5tJbu/Bm3csYlQ==
X-Received: by 2002:a17:902:e550:b0:1c2:5db:7f16 with SMTP id
 n16-20020a170902e55000b001c205db7f16mr1730352plf.67.1693328816674; 
 Tue, 29 Aug 2023 10:06:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001c1f161949fsm3769980pld.96.2023.08.29.10.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 10:06:56 -0700 (PDT)
Message-ID: <b4879b28-d038-5123-87e8-52f75aa0e12b@linaro.org>
Date: Tue, 29 Aug 2023 10:06:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/11] target/xtensa: Include missing 'qemu/atomic.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230828221314.18435-1-philmd@linaro.org>
 <20230828221314.18435-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828221314.18435-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 8/28/23 15:13, Philippe Mathieu-Daudé wrote:
> Since commit fa92bd4af7 ("target/xtensa: fix access to
> the INTERRUPT SR") these files use QEMU atomic API.
> Explicit the header inclusion instead of relying on
> implicit and indirect inclusion.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/xtensa/pic_cpu.c        | 1 +
>   target/xtensa/exc_helper.c | 1 +
>   target/xtensa/op_helper.c  | 1 +
>   3 files changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

