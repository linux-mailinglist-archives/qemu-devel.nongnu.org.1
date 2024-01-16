Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E6D82FBC3
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:03:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrVt-0002p0-Rs; Tue, 16 Jan 2024 17:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrVs-0002ol-3s
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:02:28 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrVq-0001xd-I3
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:02:27 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-559d1169ac4so155576a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 14:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705442544; x=1706047344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KSTAGlP9XVFPRpucCgC/4azll3AxTcG03koJfrBp+ys=;
 b=udM6f8tbVXgb1wRbkEKpsS2Z6iESfo7R/j7LO5InifZXgksVsq3jRp8aIEjc2B4WJJ
 5uSffil96xHBVkDfx2tqtggNRqWDk8GK8kAMwtCuvNds0ev7A4BjGhuCHvRI9LgNve9F
 11eigHfRKOmPZbxprb1c+HS+V4/qAdMDP7mHK9C29u+wNpP0s4/ao67t5X03q2ozmUoi
 bFP728tWMLetaBJqY6LHcwJapi9hHNYWQ628EYqDYduRWSxwgVFjeOQRjTF4qAQ07IvL
 FnQJuKQOaDStUTXpPbMj46g+Z6S5hCW+HzIwcHww1Etxq1xtnCQse3e2rDEpoIVOyy32
 LsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705442544; x=1706047344;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSTAGlP9XVFPRpucCgC/4azll3AxTcG03koJfrBp+ys=;
 b=LMl7VdEEtgtA4Q0R8IXP5Y/a0Yy0Yv7P7kEbkgSv7E4DZqI+/yCmkIacV4KVb1JhC5
 ECM+1nhZ9k8KebUiLGrstayXFQKkPehQ7fPsrKaq8NLpZZ4HkuwE/1ttspA3bPh7T0Fw
 JVsgPHP5SmJLwXnSB530Ppg6xT5kg77aW+3v9f4tH+qLZis/0TbUrjCjHbCbhOftJTza
 spiea1W9aiYryTHJu/uC4ty80X/M1O0Ah6RWTzVCWB5gvh1VX83Isqaf4Q+HqDdOD/5u
 MIsajAlURYMAWM9ooMJQEIqJnWCAgqkvyuutH0J/axq/CAPCP8rJ9a7fC/eUcNQ9THhY
 A+9A==
X-Gm-Message-State: AOJu0YyR4gtF3ikJcKm6aHOyF4Gbw6yCjuh5rvKBWyvMQrDyR4JMX4r6
 HuWQI4KiwPi+mF6KUQHHz/qptgb7H9hve+7096UwxBR2xmc=
X-Google-Smtp-Source: AGHT+IG3KaeM2/82g+iF7DDjwahd9ohE28VYYACzzuCY0MMm7QVjTqJgeZC9n5qDpdpdBE3azUN/lA==
X-Received: by 2002:aa7:d499:0:b0:559:d23a:705d with SMTP id
 b25-20020aa7d499000000b00559d23a705dmr59875edr.55.1705442544561; 
 Tue, 16 Jan 2024 14:02:24 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 dj17-20020a05640231b100b00559bb146ecbsm849813edb.6.2024.01.16.14.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 14:02:24 -0800 (PST)
Message-ID: <734d2eb1-41b9-49a1-bf8b-5c9942d56a4a@linaro.org>
Date: Tue, 16 Jan 2024 23:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/38] tcg/optimize: Lower TCG_COND_TST{EQ,NE} if
 unsupported
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 10/1/24 23:43, Richard Henderson wrote:
> After having performed other simplifications, lower any
> remaining test comparisons with AND.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-internal.h |  2 ++
>   tcg/optimize.c     | 60 +++++++++++++++++++++++++++++++++++++++-------
>   tcg/tcg.c          |  2 +-
>   3 files changed, 55 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


