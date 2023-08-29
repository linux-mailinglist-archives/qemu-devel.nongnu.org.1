Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C08E78D00C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7np-0001Yx-EP; Tue, 29 Aug 2023 19:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4sZ-0002C2-Sl
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:59:59 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4sX-0007T7-PZ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:59:59 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68c3b9f8333so127616b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693339196; x=1693943996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p73ACeTrIwzLGLShibTTM4vvj3GyB9o4FBZBN92GI6Y=;
 b=bsGCua+ll4Z3PV/hqPnybei2BZNSn/4I1BsCo0069GM67uYUJWh24e4qeQrITnNGa5
 uoGIbCU6CYo7vuPftbhozz+4B6Ocs1NoMSYYdPI9AOtaCTJjMXm4pesAburs1Eujz1+6
 fpilJPktR8OhgwGAhGkkZt+8/n6LN0e0N/89XBp9s6erD/t+inClX/fj9JNDO1k4AVCW
 HfBpJXto7tCnclyWn7IF7G5rpwVJRGawIIDAKvwUJ/HHbWHYi+iJtYuWj90xv+5fTfQm
 WN/kw/jKkWxhVMivp0X2RkEUK3J2LqL+3DKvnL8WaaLlmBiDGvhThuYNuIGtof79SUNV
 7m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693339196; x=1693943996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p73ACeTrIwzLGLShibTTM4vvj3GyB9o4FBZBN92GI6Y=;
 b=HYIqE7EBW2j+770U99dRVUEgr8sxZQW37q/z+4imHP8uk/VyYaOJgLF40FMqg7l6us
 qIjO2R5LD0ijHEDta8y02lnfYa0G2zVTDD9P+lsurfRbWmHB2wTm3hvxR4tHExE1qnDt
 rFxgoLuP2JhKQyAPyJRGY6lnNvoVY9kOZPcdSQMFYvzWkpqadXX4SvA7qD+THCmrqx8F
 K9RE+AuhvlbxVoM1+TJOYGcGaAfvGHgByXfTGAvx+M0uLBMWs+rQn1zU80o7pUSjub3c
 BQvc+fU2JcYaW0HG7dYlbF7zuyC7+7BnRtxv7W9v//lqQTYgRlDGd/KaII1e/ktRlyyb
 9yYg==
X-Gm-Message-State: AOJu0YwSuws0uH+81NFmaN0CggT+Bt2y3j+7+ACTaQjv6cEVMvrGSlM1
 /LHM8JxIKiuOp3w3nuwwIe5tWw==
X-Google-Smtp-Source: AGHT+IGB6mYLFvZbSCKsFyu/WEeYtkhiFL+XfDpwlGAtbI1ZPZ0dG4zeam+kuNH0zQIC6fDA9BfuIw==
X-Received: by 2002:a05:6a00:cd3:b0:666:eaaf:a2af with SMTP id
 b19-20020a056a000cd300b00666eaafa2afmr370103pfv.14.1693339196344; 
 Tue, 29 Aug 2023 12:59:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 t12-20020aa7938c000000b006874a6e74b4sm8857434pfe.151.2023.08.29.12.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:59:55 -0700 (PDT)
Message-ID: <cd2d9c17-7422-793d-d518-101dc8a4bf82@linaro.org>
Date: Tue, 29 Aug 2023 12:59:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/32] bsd-user: Implement get/set[resuid/resgid/sid] and
 issetugid.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-18-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-18-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.h           | 76 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c | 28 +++++++++++++
>   2 files changed, 104 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

