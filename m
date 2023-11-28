Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CCA7FBC23
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:05:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yhg-0006UI-T1; Tue, 28 Nov 2023 09:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7yhc-0006Ix-U2
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:04:41 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7yha-0004xG-GK
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:04:40 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6d7e8da5e8dso3181523a34.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 06:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701180276; x=1701785076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lHMBvlKj1AZPfM3WQXCWVjL1Gdm2AyDWlCFVnKi0uEw=;
 b=r42Jf4IXLt0sti6ty1PGp9yY3m31/95sz51I8v/6O+kBFkdOqz1aEwE1vFYBD0nVnC
 RECEIkpeKEv0k3ca+NHVmPXF4ZKOhAjePi2bnumKVTdqLr+iCaFnbKdLs9e7b7lByQGA
 0nZPD96StMdRuc7Y71m7RUnCjXsAhAm5zRCf5n2HwVx2ZcZrFlGIQuWnpgo3o7E6wX/P
 fp0mKF3VVF0MaWrmu2GGeVfLf9sM3B7zDGJWLL8/NUUldEJRS2RgxiZnwABMq+FMcR95
 yOwDAn8bgeaxHLMABEMbZcbEsHqfxfqBywjTmxXYbl/AIJjmF8LVu71DKG+S59TUfbwa
 jqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701180276; x=1701785076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lHMBvlKj1AZPfM3WQXCWVjL1Gdm2AyDWlCFVnKi0uEw=;
 b=p3azYCd7KWBvga0P73v0J8o486RZpM9CZTubOQEan4E6Fbp0d/CAObAX9SRYRopYWt
 ZwcxD8G7bdhDJYnrB4YAJufkJiKVHtgnxr95rqeBaKS1KrEl7n08Q/eQJ7Fvo6ffaHFX
 XBYJN/L+aq9ljuCKZD2tzAgnpFs4lMzn3mPxVGUygIZTX7GphMOKkvCnON1wz8EYY3SH
 CxLVTz4TJaeDSjkAS2B7e/2DAmJ91R4fdew+5VTVNG8ZRXiylHVddbwTSgzDEeRp5feH
 HFrtXcYHYNt36Sq3mIP70dbk2YubKwOD1Y37gU77aeOvk4hAHjiH/LvkZzIUR5L8ZaC4
 4QaQ==
X-Gm-Message-State: AOJu0Yzxdr2o/fFNOdpMi6S3gDCbBWNgE0P6SyPM74BgDZkxS2KwOWRp
 NYxOFHs3fTNyPu+GJcwoVL49bg==
X-Google-Smtp-Source: AGHT+IFMiklwB5hWsMrQUYNk1ZbPPirycGyevA5FlDQF1WeL45cm6GAvtl0G0VZRH+k/syTixkdMtA==
X-Received: by 2002:a05:6870:f626:b0:1f5:cd12:260f with SMTP id
 ek38-20020a056870f62600b001f5cd12260fmr17921771oab.26.1701180276286; 
 Tue, 28 Nov 2023 06:04:36 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 ny13-20020a056871750d00b001fa1350df8esm2068309oac.2.2023.11.28.06.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 06:04:35 -0800 (PST)
Message-ID: <23cf8ae1-70be-4ffe-9409-60b8aecbb33b@linaro.org>
Date: Tue, 28 Nov 2023 08:04:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 08/11] hw/arm/bcm2836: Use ARM_CPU 'mp-affinity'
 property
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
 <20231122183048.17150-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231122183048.17150-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
> The 'mp-affinity' property is present since commit 15a21fe028
> ("target-arm: Add mp-affinity property for ARM CPU class").
> Use it and remove a /* TODO */ comment. Since all ARM CPUs
> have this property, use &error_abort, because this call can
> not fail.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

