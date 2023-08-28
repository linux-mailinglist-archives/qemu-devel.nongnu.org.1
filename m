Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C062178B751
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:38:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qah7b-0002nS-P0; Mon, 28 Aug 2023 14:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qah79-0002Tn-UY
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:37:29 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qah77-0007En-NP
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:37:27 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so9687135ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693247844; x=1693852644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W7pZrvp9fbXrVNM1HtEc7pE/SbfGUo9CUnGlwN+3xqc=;
 b=hm0QGH4+0gMsfcT/HaYb4hW04S9fIVU4cMWHARJB3Q+fqPkXrv1cZ0MH4tXePdh16s
 Ssmsu/5ShTvRD+U88PFV/7FmB5P7KCZd5/Ap2WiG6n3EJI+1mX0h7s0sxsAwVM6fpyGV
 NuorElxl3OdZ2fQqWs5YdYcYPM10f4aeC7ZJCgKUlAa1AQH1zIrlZVoPOqFOj3fyUQrd
 gadlaSyxGRjqAY5BNMSY+istnoHdcjH/DpA0N+XmI/ZZmZjzx/vX79+Hpbm//G+CHyai
 ei5J16YBauXa2LAvzrlWe8vYsQ8pMd4Wj453YJV2+vTs7HG6PPQDZn0muLtoOLqyqOIL
 RvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693247844; x=1693852644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W7pZrvp9fbXrVNM1HtEc7pE/SbfGUo9CUnGlwN+3xqc=;
 b=dOq9FMdAUO5mU3zKl8VtLMbviFr6ACYNVW5wueLUcnX2g5k2RxfIwKhmogHCvlJh4m
 006XSvq1ZeCrtIIvJyJ2QErd8HFKwoXjDZ5H6lFq3+lEghFuT5Q8NnOFHftiKHIdtbUb
 0lnr0dVuipCt9buk+F0IUrSjztsV2xj+DJLvVHwL4n9CuuLo2kA/v/2P5k9Tq/2bHhgM
 Zk0VmTCa71Bhu1+c3hzAkFajAwkPm38gQs22PnxF+LVTRWR4sYEMuiwoVxMFgJD1PtFe
 rkzC6J4OrcGoIeNPhkX1nV8EaUT3XEUqX/cbZJx8eLR9KZ+waNWks8SFjPUzS9DWgIfF
 O7pg==
X-Gm-Message-State: AOJu0YzMCPmB3vegW6Cpmj7AEr6pD6Wkxr3WR4HB/KEEtkWKdpu9U6oJ
 jgAkPE0Dx1jKhd0okMD95FvHiw==
X-Google-Smtp-Source: AGHT+IGu1iPOG9NRmkDCToyO6yOHk7Q9tcUX1x3hY7ZusRyW6rLbTg76+hNeXrk8IWIcQrzKAuGy8g==
X-Received: by 2002:a17:903:244d:b0:1bc:10cf:50d8 with SMTP id
 l13-20020a170903244d00b001bc10cf50d8mr29434965pls.23.1693247844503; 
 Mon, 28 Aug 2023 11:37:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a1709027c8b00b001b80d399730sm7699024pll.242.2023.08.28.11.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 11:37:24 -0700 (PDT)
Message-ID: <ed021682-946f-29e4-e445-a096de453daf@linaro.org>
Date: Mon, 28 Aug 2023 11:37:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/8] target/translate: Restrict 'exec/cpu_ldst.h' to user
 emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org
References: <20230828145545.81165-1-philmd@linaro.org>
 <20230828145545.81165-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828145545.81165-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 07:55, Philippe Mathieu-Daudé wrote:
> Only handle_sigsegv_accerr_write(), declared with user
> emulation, requires "exec/cpu_ldst.h" (for the abi_ptr
> typedef).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/exec-all.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

