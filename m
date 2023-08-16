Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C931E77EBFA
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 23:38:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWODh-0006hQ-Vx; Wed, 16 Aug 2023 17:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWODf-0006au-0a
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:38:23 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWODc-0007Z1-LT
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:38:22 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4ff92e369dfso1707128e87.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692221899; x=1692826699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bs7G7wVDioo8WK0RWXvXlooHeTyzN4FOc0KWaD453Yk=;
 b=sN9FyQcnTXbjQudTcWYHQPJFoYX7W8sxP35ZzHCAeM5u8eUusPrmrXeRhGpBY9mEAY
 JVezNM9yXFTnvAKPAHsdrROPtsfuF5K40HkRohXAy01opIRcKNF0PhUhYGiwnNMQ4Hn+
 j5VoYQXnNWsbYFz3sRx9+xQBEaDhDCwcVrh2gOz+vbyeRM5T0TaSgP7bJZymYo6kp61B
 zcNJwUB55lw9YBpAnNy+xc81c+Vzjvp3fU545Ul3roFlr9a37ZNHYJyVyLAATnRpP8GP
 wmoBZjkrDG0DdyZbUYRP1la/1RSLVm2QVgMYVYkSDfiN7rgA8SmtKbZP3gmLH3HIElHd
 I2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692221899; x=1692826699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bs7G7wVDioo8WK0RWXvXlooHeTyzN4FOc0KWaD453Yk=;
 b=je+8+FQ+QXmJjBVvgHZZf/HMH/aVYS6y7bemivI32UL6YWFDw/GRdB/P4X/uegaRyj
 mu/GxzJmjaKoVzCqKD9QePU6DJ1TF90uCwl7h+OlT9fOg2aYIF6rsEyt4qrMygb/cr7L
 19mHt+xN1mJMp1x76lRUB+Q0GQsxUQpHX26MqeGFSXxUoWFN0g5oCvhXRDH01DGJGRmg
 Vb3QhAtqSa5wY0Dm/f01OhuZFJSEGRzQBUyVnPeSgozmRUZWkMKcJOK/60TPVn3x/x1g
 ITL1VtpsVITNQx9xMoYXgypAVEGEVJjehr+AFfG9jJ08UU+/2GaC5UH5k7uVZjVr05Pi
 HYDw==
X-Gm-Message-State: AOJu0YwcsQADv20+46NF0S29O8jAmp4GfgXaSd/aPQe8oWInRQbqPcuo
 RiMhmIaodlxdNRxxMTXsjD5aAA==
X-Google-Smtp-Source: AGHT+IFq+MtIBl5TkfSUa2y/JcQx3cGehCSOA1tPtj8WQlERPnBSPIUWTvnbTbFg91EZEyrvw8lqzQ==
X-Received: by 2002:a19:9148:0:b0:4ff:8d2c:751b with SMTP id
 y8-20020a199148000000b004ff8d2c751bmr2012536lfj.43.1692221898655; 
 Wed, 16 Aug 2023 14:38:18 -0700 (PDT)
Received: from [192.168.69.115] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 r13-20020aa7cb8d000000b005232ddd0151sm8779050edt.52.2023.08.16.14.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 14:38:18 -0700 (PDT)
Message-ID: <f04ee07b-4cd5-b895-67d5-2d91d303afad@linaro.org>
Date: Wed, 16 Aug 2023 23:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/4] tcg: Add tcg_out_tb_start backend hook
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Jordan Niethe <jniethe5@gmail.com>
References: <20230816142516.469743-1-richard.henderson@linaro.org>
 <20230816142516.469743-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816142516.469743-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 16/8/23 16:25, Richard Henderson wrote:
> This hook may emit code at the beginning of the TB.
> 
> Suggested-by: Jordan Niethe <jniethe5@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 3 +++
>   tcg/aarch64/tcg-target.c.inc     | 5 +++++
>   tcg/arm/tcg-target.c.inc         | 5 +++++
>   tcg/i386/tcg-target.c.inc        | 5 +++++
>   tcg/loongarch64/tcg-target.c.inc | 5 +++++
>   tcg/mips/tcg-target.c.inc        | 5 +++++
>   tcg/ppc/tcg-target.c.inc         | 5 +++++
>   tcg/riscv/tcg-target.c.inc       | 5 +++++
>   tcg/s390x/tcg-target.c.inc       | 5 +++++
>   tcg/sparc64/tcg-target.c.inc     | 5 +++++
>   tcg/tci/tcg-target.c.inc         | 5 +++++
>   11 files changed, 53 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


