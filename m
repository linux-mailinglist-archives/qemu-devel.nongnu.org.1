Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E287EB503
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:38:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wQF-0005aE-1k; Tue, 14 Nov 2023 11:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wQD-0005Zk-Fg
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:37:53 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wQB-00086t-Qk
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:37:53 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso8833520a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699979870; x=1700584670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o035EBQ2FObfS08KMINVHlrnQxLR1WgOihhXMrOT2Q0=;
 b=JeVMQ5FCn7+zMrnRZT0jat0LTAQEZQANlnoWJ/GyUfnj3jbHMSX8IZg1T+d1jYl6/t
 iy6Muvn/G5RC3iPwbu7RHLF2nqqFHpf0188CQUuBQ3euyR+rTckPkQO1CWe+OnKNEPQj
 eAhVTEIS3PFHjZ0k5zWjW2sfP6wamBNCNvCBPw9CNCnz1TZOAtcBgIYmbHs0UKshM1pe
 TaN0hkX7XsJKdRTVywCfum8Z+sP+M2ApRlDWJhbK46YJlYPGwM/OfWtQ4qwXVnRp9tRU
 UPeMmNCIMijgRXGPj6FXWcsTp+RjbvAfIaQDrpUYovwXWCc6pSVxZmVKmSrKWYqeAD/s
 P3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979870; x=1700584670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o035EBQ2FObfS08KMINVHlrnQxLR1WgOihhXMrOT2Q0=;
 b=vgPM/wbGOSddsUvwYIzXO2enLAzoYzP2ksfLcu424wL3iwVKnGaguNXedWZ4rR0bEY
 5jgWtf+jGjGMtBv0KJC5+8Ftho7Wzz9G7VrNiALOl6A4auUDijOsq+04moddYwRKT/QX
 vn/YAoWK7FEZQHq4HQsJPBh9e8/X5Wg/aTr8AbtqNyOJPoXyMBscWiMdhWz27CX1mEav
 +uiqfLWjFLqWY8vmIsH9ZA8ONkjBI/P1XPdJMbpWJziLdQyaULcTAtDBP1CBOAmkQitt
 mFu4yvg/k1gSBO3TeqXbqKP62kI+W5KYd05tKjE4nAZo5bM5pWIAQQ1B8ikkqeI++vuc
 mMCw==
X-Gm-Message-State: AOJu0YzEW1OBS6sbSfnvXFIwmCoTN7PSsTWmOneITFX+of7Pv7MxtgRE
 kgYKnRxw7leo8B+GH1jw8MefFQ==
X-Google-Smtp-Source: AGHT+IE7doEjC+WIJoMRXpa8iodyCePGrOn7FH2kOe0cQwH4oDkIQh9x7Fgoku+d6M6eVdtxTiY0Nw==
X-Received: by 2002:aa7:d314:0:b0:543:b9ae:a0d5 with SMTP id
 p20-20020aa7d314000000b00543b9aea0d5mr8030028edq.4.1699979870309; 
 Tue, 14 Nov 2023 08:37:50 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 x11-20020a50ba8b000000b0053d9cb67248sm5388374ede.18.2023.11.14.08.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 08:37:49 -0800 (PST)
Message-ID: <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
Date: Tue, 14 Nov 2023 17:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64 tests
 by default
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
References: <20231114163115.298041-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114163115.298041-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 14/11/23 17:31, Thomas Huth wrote:
> The tests seem currently to be broken. Disable them by default
> until someone fixes them.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/reverse_debugging.py | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Similarly, I suspect https://gitlab.com/qemu-project/qemu/-/issues/1961
which has a fix ready:
https://lore.kernel.org/qemu-devel/20231110170831.185001-1-richard.henderson@linaro.org/

Maybe wait the fix gets in first?

