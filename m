Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF96E82B244
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:59:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxRM-0003us-HX; Thu, 11 Jan 2024 10:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNxRH-0003uZ-Hb
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:57:51 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNxRE-0005tB-Vp
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:57:51 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e624a8cbbso3836175e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704988667; x=1705593467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n0KwsztfPWCxHdZ2RSAomStdzb+IxXc221ZKdWIjKFg=;
 b=dcTj70IpXHrI7/vWgd2rRPDHBMNp+cLQlQ29AJwApZTfW98xdyJ9XViGhBDohIoFES
 ZRrOCeYv7m/IusP7aKdG/+GroFZsJ1GkXnSek+2Mq0JSEYmhUh8VqqKKY35MZ9LhsQnA
 sMOSb58eU5fyzpsBA1vl+mKBLfFpgXUF8pjYCJ9L7fRuRejUNwJA1jh95Uhhg6zcMSJ3
 +ECZt5qD/dkCruGYG+YmQy9JcwnXVmQEA4rCyhMFIIzzJuKRMRGBqh4yomxpgDEjTMnl
 sPGaIFCcuxgt2oEy9tS1GPx5QXfKwCMDAa7WA6ktBtr7kd0+OSTXG+u94PKItlY2/lZr
 v2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704988667; x=1705593467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n0KwsztfPWCxHdZ2RSAomStdzb+IxXc221ZKdWIjKFg=;
 b=xPpp+fz44t+mv49fqpNx6tHEelHlNye2EziheN+AtqiFnP4HYSuwCbjzcHiuMWx9M9
 W0HELalDctJxZ6nYxV0+MO+c+LuWkhtBTWm2L4J0LCvswnhelh/nr118X+nCKaNKntm4
 PfOKcCbuDaaKNhTTocp+R3IO78P1xpR0MjsUlKmySqpMZ5ItR/5csrqrr2EiR0obbvNA
 KI/m2F8r3Lr66hxFNyR0p/6pqFWWdBtOdC8vdAEEgKHZtrw1Uo6BoZMsDkpChK8HnO3Q
 24s6/AJ4QZzg05+zdwOHy9TzlsmP26dwPTQ3HTEy4XnYpQZsnCoz6nRlxX0P5IlBw7h9
 UdbQ==
X-Gm-Message-State: AOJu0YxSmBti2GVnYtp6o1NLZbxwJKtkuk/CjUnLAxbIAznl7xdwPnFo
 s/U2YgRPVGtklStUdmDqu8ZSHke1XZEgdQ==
X-Google-Smtp-Source: AGHT+IFYlN///2FIOs1S6m6da9TnBrSDtC26koqXd8BGqU3jYZ8T08UUoLkuKwhu8fXdd//b7EAIEA==
X-Received: by 2002:a05:600c:4f48:b0:40e:6195:239c with SMTP id
 m8-20020a05600c4f4800b0040e6195239cmr17543wmq.90.1704988667118; 
 Thu, 11 Jan 2024 07:57:47 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.145])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a05600c4ed000b0040d91912f2csm2447332wmq.1.2024.01.11.07.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 07:57:46 -0800 (PST)
Message-ID: <49bfa786-e549-43d4-ac03-9337b9342d16@linaro.org>
Date: Thu, 11 Jan 2024 16:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] tests/plugin: add test plugin for inline operations
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-4-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240111142326.1743444-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Hi Pierrick,

On 11/1/24 15:23, Pierrick Bouvier wrote:
> For now, it simply performs instruction, bb and mem count, and ensure
> that inline vs callback versions have the same result. Later, we'll
> extend it when new inline operations are added.
> 
> Use existing plugins to test everything works is a bit cumbersome, as
> different events are treated in different plugins. Thus, this new one.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/plugin/inline.c    | 183 +++++++++++++++++++++++++++++++++++++++
>   tests/plugin/meson.build |   2 +-
>   2 files changed, 184 insertions(+), 1 deletion(-)
>   create mode 100644 tests/plugin/inline.c

> +#define MAX_CPUS 8

Where does this value come from?

Should the pluggin API provide a helper to ask TCG how many
vCPUs are created?

