Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1597EBAC9
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:06:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34L4-0006Ma-AV; Tue, 14 Nov 2023 20:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34L2-0006Ly-5s
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:05:04 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34Kz-0006MQ-Ld
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:05:03 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso5452753b3a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700010300; x=1700615100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iH5bvmq3j+fXdVx/6xD8MpW1JDu1gexYU52RTkUEGgg=;
 b=wjzE553w7s944CaTV1E8PIFisDmtpyxPGMYDIkkSelxl3BrCumJrSuOMHijBIyjmP7
 OO+FRT1lubMVknpJYfMfumtwrU4pSve+TPAGEAla/vq/SokADt/tZ+2cViXyz1svFD/U
 Z4V4WvqlS1w8ZTJHdMUP9J5ypp+3QxnU6stkdb1+dMu7nmyZnkUll/JtYhIjxci3mlR3
 LiUzhIRnoPu0CzCjm0Ne8sxM/+nnsg62u152c+eQc/CabtVPJoNVxQhj4dmnNmQVsm0P
 0mYO1MoHhjtq5zvJrhjJNe6DovPrkhuG+rPfnLvVHz5yFxLpJgv3Zrve4LxRMg72k3L1
 fVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700010300; x=1700615100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iH5bvmq3j+fXdVx/6xD8MpW1JDu1gexYU52RTkUEGgg=;
 b=jqevfYNUr7VCqp7m2Z2XVgAsNcCe8P83Q3cPOWaL7VWkAWJTSuEn/DNDsO8E8WSwRX
 4fLBLMDIs7iZfgHc/UowNl85NC3iJDevcncBEUt/Y0nafLCaJyZNTT79N9aoq+ejwM1u
 oz3vn1R/lQnPvtmqPG88yf5eGzw4KUI/uZvzixrsevAsmrfYS5NDxXnk3UjEXxNyQtK2
 As9J6SU0WEFbpc0CxQ38aoBvj44aK6rxXeMMfNhDhjxh3Kl7AmdC8nGa/Sa8WxwRKC7z
 o+Qj6a/oxRRyooNQ9Dw3wejitF/1cYoNujhI5GIz7LStOEUlgS3ZKGbtw9pm1fDU48Wl
 0pWQ==
X-Gm-Message-State: AOJu0YztOCZgGjile2GZreADTEX11PApf5iBAbUl4Ku+UrK4PTWQYAee
 oi/3vAGj3KYX5wNbK7VZbBZ6Ag==
X-Google-Smtp-Source: AGHT+IFymldeHV6n0DIfmAb7oTnE1hkKPLG5Ve71nb/kChE6zue86UHcBBhjtQYTNLJ1h6yNXl/ZhA==
X-Received: by 2002:a05:6a21:999a:b0:186:1332:a930 with SMTP id
 ve26-20020a056a21999a00b001861332a930mr10196075pzb.38.1700010300122; 
 Tue, 14 Nov 2023 17:05:00 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 26-20020a17090a001a00b0028105e3c7d8sm8707354pja.0.2023.11.14.17.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:04:59 -0800 (PST)
Message-ID: <f6ff55ac-851c-446f-aff5-4174e5259ea6@linaro.org>
Date: Tue, 14 Nov 2023 17:04:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/31] target/openrisc: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-17-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-17-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
> [gshan@gshan q]$ ./build/qemu-or1k -cpu ?
> Available CPUs:
>    or1200
>    any
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-or1k -cpu ?
> Available CPUs:
>    any
>    or1200
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/openrisc/cpu.c | 42 ------------------------------------------
>   target/openrisc/cpu.h |  3 ---
>   2 files changed, 45 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

