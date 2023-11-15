Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC607EBAD0
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:09:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34ON-0004Jp-Vz; Tue, 14 Nov 2023 20:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34OK-0004Id-Uu
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:08:29 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34OJ-0006vC-Di
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:08:28 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6c4884521f6so5395373b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700010505; x=1700615305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M1D7/YT7Q5Umzl0SZdP/D+JpNa8dQogLNgrHUdnEcrA=;
 b=SF7Jyw1TeL/wkDnCTxT3+qDlmblNxEI4vRU35Fk8AogET4mGPSgXHbuKzqDJeA17Od
 PIXOVhr913dy60a6t1pWl9cX5gSQI4UuT3nACidO6n7iqtAHZAEGhAVLueB76WCMmQZy
 rHopSjB+zflZAIVjEDIMHA0NUcQvELPVcqu3lxnTWUjmTBtnn0L0NPljgFm8YRokbdOF
 LjJ0iv6tzH2KHEXgRzpTYyPDi0EldD9a0LPPYXACie1cfcriW2M25tKcnXIw+SV5LhVm
 sM4MOBXwZydk2kA52bZFqyfHxl/kAb7i7QUC7PXcqdORmCF61zKXclTPJtvvA7UUZnli
 3yTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700010505; x=1700615305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M1D7/YT7Q5Umzl0SZdP/D+JpNa8dQogLNgrHUdnEcrA=;
 b=dCL0WQwhVhhVzufpP6tws4GkrKBeWpE2nYKKQjMrx85Ba+3higZF4bqSzdIlYLs5jd
 z2ulGt6g40oEKJ82w7R5OGkMPxRKFaAjG8tuCGV5uuT2Y/FlojF7u/TBk8CYTBUiuiIc
 1+D70bi95bQ9ZcqBfH4p9uKzVp+p/Lc8rNcdZr4t4Qm8qfpXf90kJ0ZkptZKjHuOioMP
 tTwl//q4uX6Rv6n6SeM58hYD03BstN4qfg1weAEa5XTQt93667DwBif7CiOWitBbC3zc
 0uw0qfvItIW8mbPbok3JCTS5ZPkzAsQMA3t2xCqJJMUAdET7hEEr1Yl1mNDZh25AUkXc
 7Mtg==
X-Gm-Message-State: AOJu0Yyrc1aynBXWR/FBeb39N80Jk8jwXGSL7zVzvbZfcN5fWhPHvSRr
 +ibmHM3EZeSObr+MUuCi4BoJmA==
X-Google-Smtp-Source: AGHT+IHWxIftyvgVh4qu/K739wzJYsr5HIXeV7lhc/gZVY3T2c62tASp5quu1EvhW0RXGS3lbMVO1A==
X-Received: by 2002:a05:6a21:185:b0:186:97bb:318e with SMTP id
 le5-20020a056a21018500b0018697bb318emr8357748pzb.28.1700010505300; 
 Tue, 14 Nov 2023 17:08:25 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 26-20020a17090a001a00b0028105e3c7d8sm8707354pja.0.2023.11.14.17.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:08:24 -0800 (PST)
Message-ID: <6b9d3d54-42a7-4eb7-84ce-1993ccc954a0@linaro.org>
Date: Tue, 14 Nov 2023 17:08:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/31] target/sh4: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-20-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-20-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/14/23 15:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-sh4 -cpu ?
> sh7750r
> sh7751r
> sh7785
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-sh4 -cpu ?
> Available CPUs:
>    sh7750r
>    sh7751r
>    sh7785
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/sh4/cpu.c | 17 -----------------
>   target/sh4/cpu.h |  3 ---
>   2 files changed, 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

