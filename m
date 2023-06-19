Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A59AF734D10
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 10:06:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9uE-0006r1-0c; Mon, 19 Jun 2023 04:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9uB-0006k1-NB
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:06:31 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9uA-0001Ik-2F
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:06:31 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b45c289615so37588561fa.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687161988; x=1689753988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W2wJQibJMYx7IpRQW/5lysZzzgnwm9zZuo7OpJnNNPU=;
 b=hwd5W86NsK4CpRW4dqsg/zEoIigiZyhWFzzgaEO32Lwhqbhh8K7srQN5RtdpdMTqBP
 UzvsuIfvWQsx3usj4uV5AKBSsB7ABRtr+6XdvUG2rRXkhz/H0dh55RYvRNXB5CNVzVBK
 T+D5sGfPdVvLrIegwVL/TdbKksh3FP65KfMG3JYZAXcWrTAcYAzN+gmc9hbYQYfssuFn
 BkqH19Vs5mL2YQVt50cQ+LqtnOXUmpGTC4atqFSj6oZDL0a2et6VWjB5jYb8+ACS3LSu
 AkNYr5l9X2be80DxpOLV3lHTNLf/qCa2owg+MrdfYRMUQPU4sI5zH9vY/DiCYhVEc3AE
 Rc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687161988; x=1689753988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W2wJQibJMYx7IpRQW/5lysZzzgnwm9zZuo7OpJnNNPU=;
 b=TZY1Z7DViFZwJfuBAKP5CljlDiX1lVPFJ+DjUzEY8IF6nIY1I9rzeYTK8CKdKeKOV2
 mQjauEIAZ39S9C/44zHAY3NUlyOQ3Evwqzdw/ozhTFAJiyaerNZ9MDvUdSTMill4wDH0
 ps0fgFvOmwEYmbiC12oGVPg7RulpuPQ7h+ar9rriSZpO5vNuSarMXzE9JRMpge/UV0XF
 UjfiZstDz1eaXg0VJMpBxad3ynRPsSdh1Kk21QjaPsY6e9PEoTY4PgYk4hBwiWokMsHR
 Yz6lcJcwfEuP3l/IhKiabmdhWoVLFURoTRy6BZJ5Pisg4lXb6yKwsL7P+LT81OTpZzb7
 h3aQ==
X-Gm-Message-State: AC+VfDwgYcIX4I8Ksdqv3L1RzzmY2LjRRoerO7IO9ZD31UL4JfE+gTXA
 MF4f7E2WjeJi/b6OcALUBr8mVg==
X-Google-Smtp-Source: ACHHUZ71xlQKFkuaPhLU+XPgbCWRUxNJLkNIgPwtIN9LnnbGNp2KpMm+89TlVscS/Wcapgi3hmaagA==
X-Received: by 2002:a2e:800a:0:b0:2b4:6c47:6240 with SMTP id
 j10-20020a2e800a000000b002b46c476240mr2294130ljg.53.1687161988030; 
 Mon, 19 Jun 2023 01:06:28 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 p26-20020a056402075a00b00515c8024cb9sm1974990edy.55.2023.06.19.01.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 01:06:27 -0700 (PDT)
Message-ID: <9e0961bb-0625-41b0-39cb-a18749859ee7@linaro.org>
Date: Mon, 19 Jun 2023 10:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] exec/address-spaces.h: Remove unuseful
 'exec/memory.h' include
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20230619074153.44268-1-philmd@linaro.org>
 <20230619074153.44268-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619074153.44268-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 09:41, Philippe Mathieu-Daudé wrote:
> "exec/address-spaces.h" declares get_system_io() and
> get_system_memory(), both returning a MemoryRegion pointer.
> MemoryRegion is forward declared in "qemu/typedefs.h", so
> we don't need any declaration from "exec/memory.h" here.
> Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/address-spaces.h | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

