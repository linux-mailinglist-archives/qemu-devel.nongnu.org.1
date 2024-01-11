Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7A082AADA
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 10:27:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNrKs-0002cR-1W; Thu, 11 Jan 2024 04:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNrKq-0002b8-9v
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:26:48 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNrKn-0006Fx-51
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:26:48 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e67e37661so6581579e87.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 01:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704965199; x=1705569999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z2N8DI5XQKcVPtOGc+EkcPraYt92dNZ1WAGiWL89CJA=;
 b=H1PIAmz63IbgJZdUvAVLmJe78k0i9J2Ap30R8eHsW96dHEN2lFTTZh+QxqUiGH5l2M
 jZH7eayuZYRxl3Flp2B/ZFGMMFQy0+4Iyxo87T57QHyUDZc/gmIaCho38Q3IPBXuRi4V
 PckR6B/ddBWMIpcKasFhuXRT1BFMuQn7RPTnsvzLp+yMbVY+MaqzUBjWIy1DmGS8htMM
 629Lk/CT76LCeSTrGlQmYJa2k3h+k6bTx0ENfgfBZOiP83nouIka37egwtvAXmwQS8vx
 FXD97AiRiu3XkHFj2xHFTrTQQEq0ZvT8NLvm4/DlyUhO2JtxBJTGCRdmhNtIZ9hv6fI3
 iung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704965199; x=1705569999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2N8DI5XQKcVPtOGc+EkcPraYt92dNZ1WAGiWL89CJA=;
 b=c0rkNice+uzon6CPTeRwTj4/MMNgu4ZNchgunBkG/LtDrx5dwwW7S2oHJRLusAF+ap
 UhdilmHD9O9DZbAPCsSJisGwt3RJb758ZGiqMQJdJ26ZZAFzkQOmswHgN4UkkdqRenrf
 IyiR+7AlarwgnUKMVrEQQ5pwdSm20o9uC8qfNsChqVpzcLLIOsPDOw2XIp+FOQmS04jt
 Ceiu2c53xWW9g+a1X4qVBE6xj9u5PkUFuMizd/HCnf6msgpvguoJthcXPnKP1FGYEvcJ
 04oN6AsrTMyZi05jI6qdt5PLyuIh0zljbcSPGvIKEakWwyDjP1YcWHPGkLgcaPNqQKjb
 ThRA==
X-Gm-Message-State: AOJu0YwzpJBR6MSNb2hJ/gn8M7SqeLqzDt6gpVQj53hLQJiFoTaxtg5C
 lI36++tX66aili2XM9ZryJnckWBf3a1AIw==
X-Google-Smtp-Source: AGHT+IH//mFuouh2ZueHN8nnIKx5wpxDxOesjO0GPJDRKahhLb4mu+z3N+mQRoJPEgyA51AGtaydfg==
X-Received: by 2002:a05:6512:329c:b0:50e:4e5f:6700 with SMTP id
 p28-20020a056512329c00b0050e4e5f6700mr412918lfe.103.1704965198743; 
 Thu, 11 Jan 2024 01:26:38 -0800 (PST)
Received: from [192.168.207.175] (83.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.83]) by smtp.gmail.com with ESMTPSA id
 m22-20020a05600c4f5600b0040d5b849f38sm5146381wmq.0.2024.01.11.01.26.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 01:26:38 -0800 (PST)
Message-ID: <fabe07d9-dde1-47f9-8beb-3c5c7b97f88f@linaro.org>
Date: Thu, 11 Jan 2024 10:26:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [NOTFORMERGE PATCH 2/2] gitlab: Add Loongarch64 KVM-only build
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Beraldo Leal <bleal@redhat.com>,
 WANG Xuerui <git@xen0n.name>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Xianglai Li <lixianglai@loongson.cn>,
 Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-3-philmd@linaro.org>
 <dbc7f2c6-15c0-4d5a-abf7-8946ff2d03cb@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dbc7f2c6-15c0-4d5a-abf7-8946ff2d03cb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 11/1/24 08:10, Thomas Huth wrote:
> On 02/01/2024 18.22, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Used to test 
>> https://lore.kernel.org/qemu-devel/20231228084051.3235354-1-zhaotianrui@loongson.cn/
> 
> So why is it NOTFORMERGE ? Don't we want to test KVM-only builds for 
> loongarch in the long run?

We do. I was just waiting the loongarch64/KVM support was first.

