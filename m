Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F7289CB99
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Apr 2024 20:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rttYx-00035E-S8; Mon, 08 Apr 2024 14:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rttYu-00033S-Us
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 14:17:44 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rttYt-0008Fo-5g
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 14:17:44 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a51abd0d7c2so449595566b.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712600261; x=1713205061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wJLGKwHsJY5k+a4vpcmjbRP8tPhkpdEOy+7JmFvmUuY=;
 b=PutdmyR00Y/HkkBVAKmJMHDgSvTASWgD12d6B8jX0RiSSoQQ/QI5SEyfypKCSOU8vu
 pAD5Mal9z3kAuv89AZtr5OeytFF8MgEq2aNs2PuMcsHZrwsKMdqZSX/TaXMZ8lBnWdal
 uTsM0gvMJ5EBZ0chk2tKBRVmjD6cIxcXFzelvpZfOP+TS/L5skBFSCIys08+jNW9xjpb
 1b44hu/Om8XB3AVHha/hmFE7jcAOhCTsFaDNhNmimDScerXNI5bE2zRvs11neLwh3s20
 3OuihxxjE5zRc28w4je3uqfaYkhGdZkVdcAHV8iErga7U6g9LqUZ6leHz03pBSwAtBGQ
 q+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712600261; x=1713205061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wJLGKwHsJY5k+a4vpcmjbRP8tPhkpdEOy+7JmFvmUuY=;
 b=XbMDdmckIFjrP4MzVF+Jln8cXqmHx02GhXFoN4islt4B0YfBHWEYWEIiMmCOqHRpWT
 UaUQNfO40ZwQwCgUhRGJj/hKbiR4EoB2xsJZa+MaN5uywjsOIPqYY3rFJCTs+KySr7qK
 isGtlYu4J7WWEvzoGss4MuDiJtrEz6tstJk3NfFalQ2LmzGuWLHslT1RRlrmVYfs9kKI
 Kd+diuqpt6AqY6EcDD2S/wzA2kjPWhRCq396jsd46Jh2u+wWLWOgJqPbbJGTAVR2y/aK
 Vfkia1uOJY+SkF8Jswfx7P9HOxuDHTqF1QqNDM3nxPlQa8dcH9bcjLkqdZSSZ83Y2yz9
 ODJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo/hOEpb7ftY4H3bnHeIjm6Kcj10/quC+uGDyKX/y0As4jErEaP4PLP4vZgXLGDWFzGwJruhbM4omlC5/eP1gbV1a3yrc=
X-Gm-Message-State: AOJu0YyHhaEalgTGYcrhvjGkCUw/Rcz/O+1M/Ga6aZv/V+8p5tvcus2g
 TSHi5eY27MlBbeOQ+nhsM2hZ0snfGXCGiwn4WUjK8dMz6W+qwEIBVRjmxxJmAD2WNROjU/6X1Ms
 G
X-Google-Smtp-Source: AGHT+IETt3c1TWhUSXv0A4VilYh2y23Yp0q2b4secqel22/PzBkKXLJL7osyQ7hHTxmLHab5lNbMIA==
X-Received: by 2002:a17:906:195a:b0:a4e:679b:8437 with SMTP id
 b26-20020a170906195a00b00a4e679b8437mr5931401eje.59.1712600260882; 
 Mon, 08 Apr 2024 11:17:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 sa2-20020a1709076d0200b00a474ef94fddsm4699360ejc.70.2024.04.08.11.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 11:17:40 -0700 (PDT)
Message-ID: <e2d97284-6dc7-4a38-82a7-4e7c76bfeaf9@linaro.org>
Date: Mon, 8 Apr 2024 20:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] memory-device: move stubs out of stubs/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-15-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408155330.522792-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/4/24 17:53, Paolo Bonzini wrote:
> Since the memory-device stubs are needed exactly when the Kconfig symbols are not
> needed, move them to hw/mem/.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   stubs/memory_device.c => hw/mem/memory-device-stubs.c | 0
>   hw/mem/meson.build                                    | 1 +
>   stubs/meson.build                                     | 1 -
>   3 files changed, 1 insertion(+), 1 deletion(-)
>   rename stubs/memory_device.c => hw/mem/memory-device-stubs.c (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


