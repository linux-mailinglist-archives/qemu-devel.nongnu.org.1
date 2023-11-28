Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B57FBC1F
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:04:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ygq-0005XL-Lf; Tue, 28 Nov 2023 09:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7ygc-0005RE-PM
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:03:39 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7yga-0004ee-S6
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:03:38 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1fa22332ca1so1381224fac.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 06:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701180215; x=1701785015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RAKgJw6UMC42KF6dxleVMJZB/VCBDYG7XXv4s7ycYDI=;
 b=BeOXPkm8zKbGifwb+r46NYD+iSca/Z7Caw/XSk6YzHcQNsbybBPNnFBTutDAffRGVZ
 ylkPGeUgYlTaGnsG2IE/bhU3Ogl3iXziXjM8wJkZJxSiPke4i7Golj3aR1oaaFzdQl/q
 +icDp3PppyPrkeM/s3x0lb/+kD7nGdtt/S0hB0z+CwA7O3c4qReEmjJj7ek0zgSxPHTI
 tRQyey60QN+jNt5guYY+jmoop0jYqQ4yYNf880AIOIvIAIjPxRuP5KO2ctZsdPbavBJC
 +D62uK3R3THeHChXequOJe7Q2K4Qw7rtnJymRTjbqtUqNWe7Q44gbV7+idAGtwhqfZZR
 p6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701180215; x=1701785015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RAKgJw6UMC42KF6dxleVMJZB/VCBDYG7XXv4s7ycYDI=;
 b=EFjAn4kVpBJl5jJCEamhLpr1/YQkAFkkyHUN8oQZ+GGkfB65WfR8z15qmQ75pIrlfX
 CiSfBRneYYT9Cs62ogmiJZTRBD0bwmUsWtOHjoY6+B037GSW4N/AXsTxfLd1hu9sLk4B
 92YLdCaim/l/nSzpAO+8lSUotVt828vRif2ZdcVkayTzm/Mlxap1DSo+0a455/i9b6pW
 3y1/PuY+ZM8U65kkGMTkXzWMdw6MC13kauFWw8hC/LJtRjXSnNIFOiMP6Tvl3S7FksAJ
 eDdyedCC67iDM7JKEIGR9IGDgznF1oyoSSMrib9BTkV5dMpN7arzZUmzw9h0AWSSvPpF
 BXOg==
X-Gm-Message-State: AOJu0YwcjqEystyqU2b+6yb45Bog8bUaGm9kxtFBsqXKFHANCuSpl436
 L3g5Ri4ST8Xy46iA8K4Ur/j3Mg==
X-Google-Smtp-Source: AGHT+IEQoAKmEKLWKEvb7FD5meJQC4R5kWjcZM7Vrjvm03F2PyVt4uQqAw67wf2Z7rJIdGVwayut+g==
X-Received: by 2002:a05:6870:d3cd:b0:1e9:7912:3bd9 with SMTP id
 l13-20020a056870d3cd00b001e979123bd9mr8775761oag.9.1701180215233; 
 Tue, 28 Nov 2023 06:03:35 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 ny13-20020a056871750d00b001fa1350df8esm2068309oac.2.2023.11.28.06.03.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 06:03:34 -0800 (PST)
Message-ID: <6d956240-6072-4dbe-b537-a0415cbe952f@linaro.org>
Date: Tue, 28 Nov 2023 08:03:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 06/11] hw/arm/bcm2836: Simplify use of
 'reset-cbar' property
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
 <20231122183048.17150-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231122183048.17150-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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
> bcm2836_realize() is called by
> 
>   - bcm2836_class_init() which sets:
> 
>      bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a7")
> 
>   - bcm2837_class_init() which sets:
> 
>      bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a53")
> 
> Both Cortex-A7 / A53 have the ARM_FEATURE_CBAR set. If it isn't,
> then this is a programming error: use &error_abort.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

