Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 229DD7FBC13
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:01:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ydh-0003lO-7f; Tue, 28 Nov 2023 09:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7ydf-0003k3-0N
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:00:35 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7ydd-00046j-9p
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:00:34 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6d8162ca490so1350741a34.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 06:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701180032; x=1701784832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NdAXHix7hNPYBXgjxbxBcDX5MGQGoqSrmEIfGMEy6Dk=;
 b=cB4WozVCxtlZRK/mOTudH3EQQqx4dK+VbGdfeUWMKDqldv1T6kc6c4xyn0FJtvamtR
 kqhKI2GRfm8A6n3Zirql1QhqNwIFPs/OBlhySnaTtG4SMh+oi66NG0JBUmHWFAz0YyeI
 IcvDSy0yUaeTIJUKfKs0T+FmfUD1+KKu3Vw8I0j2RZU04h+/W4QYYU2cYlpzBxh/0EXT
 n4Ts+5t2f1rILO1lNHYVdHKhB863ytNl161tFY6Xu+6UXg09R1Jfzbr7eZ0MK9wryPHB
 d388RWYuuux3AtIJ+cCJ/XG5sJuKMT4ud3mh6sHNmBy5Ugd3SxAmWcKmx4JY2JSg/oL/
 xNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701180032; x=1701784832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NdAXHix7hNPYBXgjxbxBcDX5MGQGoqSrmEIfGMEy6Dk=;
 b=OoB6OpRn/xBRzDXBYt4XF8XISSbnajlAiT/jeFF8F2y6/uGlhHZNIG4mfUi/F4CcRq
 C8nINT9AXxuceV+msrOMN9PEvyV332379bGwvv9J/jjkFnIHhoKiKHXikazz6tfL6dyE
 aGK8gErUdmUXlzOslryjPHVBjDYlAtWBef24uQenE//+65wqPZDZO617UH/IeKkD/rLM
 5fQlG01vZzhxr+4QPvevoMKD4VxgQfONLHVztZl71zWNjNOghzirBcHHIBZZvcT3om86
 HQKG9EP8v8DqkDw1cYPLqTXT/WH4A78TIEJFCd7MuIESJt8O2mjZzdK2BZwDbaCHACD3
 jGgw==
X-Gm-Message-State: AOJu0YxxXZPYqLp1SbRRG3a5SYGj89OiPV8GAnw7DF2tGYWNw0VVrb7P
 BazJ1Dxx2q1YCIGxv99Fkz86+g==
X-Google-Smtp-Source: AGHT+IG8SVpMS1/gpPC7RPWTPFYdxmAYmy7mWfZnX5dhoOw/XL8j4On3CMQVGnZLKCvNNhUN/uFv9g==
X-Received: by 2002:a9d:7e8d:0:b0:6d3:1f0b:3fc7 with SMTP id
 m13-20020a9d7e8d000000b006d31f0b3fc7mr7654231otp.7.1701180032126; 
 Tue, 28 Nov 2023 06:00:32 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a056830164e00b006ce2e1a6cb2sm1678579otr.44.2023.11.28.06.00.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 06:00:31 -0800 (PST)
Message-ID: <7a313871-8c1d-445e-92c6-5b20918afb89@linaro.org>
Date: Tue, 28 Nov 2023 08:00:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 04/11] target/arm: Move ARM_CPU_IRQ/FIQ
 definitions to 'cpu-qom.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
 <20231122183048.17150-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231122183048.17150-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/22/23 12:30, Philippe Mathieu-Daudé wrote:
> The ARM_CPU_IRQ/FIQ definitions are meant for the ARM CPU
> QOM model. Move them to "cpu-qom.h" so any QOM code can
> use them.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Or do these definitions belong to cpu-defs.h?

I think they belong with the qom bits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

