Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF957D7565
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 22:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvkOO-0003Tn-Nt; Wed, 25 Oct 2023 16:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvkOL-0003S8-HY
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:22:13 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvkOJ-0006uC-Uo
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:22:13 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-27d0acd0903so93680a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698265329; x=1698870129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZLDwlgbOZxuTbC0wDpEeMlK5mr3C1iXBnj0x5WsETQA=;
 b=qXbbj99WIE8A+BIEMakCqdozOlenMplYp5J6JqKBiz0ZttLw1aR40W9H7M/nXFo4uW
 wpY5w50ao7ionesSlA65JBzgl2x1v9/N3lNMLzQfMyUc3vTpbyuCJPfQF/RRTF0evaL7
 hR6APJ7NKxadJepXOd2W6ROBrC/YQBCC+03t/aS7xzq1FdSqtD6K9eNmutZth7TUCc5K
 L6Y1+rczsKguJq/4CzHlWKVuVvWg9Wlxb34oxwMx/a8E2hHTf8mahdz51m0tpyTgZgha
 /Hyh6s0dm4UXV7rmTQU8LRwSozIaDpHN/I/NwvgoqFdh3Usocd8Tetm6USr+pmDSULPU
 h5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698265329; x=1698870129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLDwlgbOZxuTbC0wDpEeMlK5mr3C1iXBnj0x5WsETQA=;
 b=CsfvIn3MjLhIOVJTTEaR1Jt/JZlSbt7PO+B0i/Cyujgmv5wA9EzLN1wuIZLjLr0n6/
 PKMLE8tYUO/j7qQkBqcKQXWkNJctuPFhkwl86pIK5kyXTH+Kd/kCGLMSXyO1P0s3uj9a
 DzljOx2c3R3nEPtBM/1riZYZAOX8mmXTPeSpGzJtIFOpqVueI8FA07Dy0WkP8QVOL85A
 Qobsf1rUUV0HyAfkLP50bURwjPcQH2tJ8pQAEjHRyy7zVAgQ3Qf07a2T40gqkdjrgUWV
 1IwO4uqEkV97BjijlzO83BmVm5GBR4NF0vZc9+ok39m+iMNl2pZNjNALBsvAcqqqhBEy
 dvOg==
X-Gm-Message-State: AOJu0Yw83uzM0xKviysIyny49Rq2ChWlvBGIcPQimonuUHOL4Q/V3wfv
 EAGQ/X13NF190c53vPTDy7Q2fA==
X-Google-Smtp-Source: AGHT+IEe3BcyEzup0C+2lh32Ddh17uGJqnXdTEG0VHvef7E2fld0TDsWNyfM29SeHKHQHWpEfQj5iQ==
X-Received: by 2002:a17:90a:1910:b0:27d:491d:2e40 with SMTP id
 16-20020a17090a191000b0027d491d2e40mr12673605pjg.22.1698265329244; 
 Wed, 25 Oct 2023 13:22:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 24-20020a17090a19d800b0026b46ad94c9sm320918pjj.24.2023.10.25.13.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 13:22:08 -0700 (PDT)
Message-ID: <5a54530a-7a5f-4107-be35-64ed52a1c017@linaro.org>
Date: Wed, 25 Oct 2023 13:22:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] target/mips: Use tcg_gen_ext16s_tl
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20231024165903.40861-1-philmd@linaro.org>
 <20231024165903.40861-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231024165903.40861-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/24/23 09:59, Philippe Mathieu-Daudé wrote:
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c | 54 ++++++++++++++++-----------------
>   1 file changed, 26 insertions(+), 28 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

