Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E16A57FBC37
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:07:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yk6-0000bF-1F; Tue, 28 Nov 2023 09:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7yjy-0000ae-1x
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:07:07 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7yjw-0005oq-0L
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:07:05 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1fa22326ad0so1788303fac.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 06:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701180422; x=1701785222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IVBXxCL3b/HYlHx/ddymQrkvoQWPPSzCHh5nA+M6FXA=;
 b=NH+gOO4gLg4e7NkIPBnUuCbIhwVRpZzmehPkNmdyc4vQRvy1ZU7SgGGouQCXB/tuEW
 i4vYvbAYiA0tiZN4vDQWQoBPzQ/pnF71EKRMMdw3qBRym2C4jxyH3OjBD3MY0ES7iSkt
 7ZRCyJ7Z4HE2iePIwGSQcl4uHza3I/ffJmULeIq3ZlPRW7C3IHCQuzyuHTQzwgzx+erL
 cbNUaX2asjQljGHjJdfPUla4YsHgHE30wl1fRhCxXp3jvui7FwFCZ+oVFx2ep6xUDTpd
 KEPkm33eDwunjzD8zj3jd0poDE9UTxB3b9ArKonTKnG8ZU297/qKLqL74j7Hk2QBW3x0
 F6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701180422; x=1701785222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IVBXxCL3b/HYlHx/ddymQrkvoQWPPSzCHh5nA+M6FXA=;
 b=MiD7WsAe+CSuvHsSIQ4Ki/kRhYhb7ukBJcXWQZWV6TkjiT66h8/yuQgp0CEAPcCSSJ
 DZJEMpuDEk2X9h4g8RGw8SR/+w0ROBH4j1UEhSbayQcmb8tS09nf7XTewdKSi/tcMnLU
 IXz9rujqlV191tXKVHaKQumGKC9/zIbPfQJGnQPislAlHT+dKi2LNiJo+Zu/s0A0k7gw
 GfIdPWcAPlqbpMeCcWbITmv5GpSI6ekiOWt/u2d556HawLyDbUVtXKgBLmGpXNAXPk81
 vwr0gbcYKMcpVuLR+hkGkjVnb/qJwaA4FLVBRkw/JzgAD1e2P8+Y1Jox1Y5nsTCL7u8E
 n69w==
X-Gm-Message-State: AOJu0YxT6vdJP9wVIiUi4s0SGCHafwA1N7Wb71qf0Zh3MZWSNe6pmRhO
 CWE4Zq7Hgdty3VH8A6VXYruq3g==
X-Google-Smtp-Source: AGHT+IGPFcCdUHQObrVW3CgDplXB4diSgReBGYpq27a3lR5i+QRn6MLEA6pyj1N1ZXX+VusUQtMu6A==
X-Received: by 2002:a05:6870:55c9:b0:1fa:25de:2f6b with SMTP id
 qk9-20020a05687055c900b001fa25de2f6bmr11596564oac.23.1701180422236; 
 Tue, 28 Nov 2023 06:07:02 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 nx11-20020a056870be8b00b001e98b1544fesm2863972oab.9.2023.11.28.06.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 06:07:01 -0800 (PST)
Message-ID: <67bdc461-14e0-4db8-b41a-f664361ff4e3@linaro.org>
Date: Tue, 28 Nov 2023 08:06:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0 09/11] hw/arm/bcm2836: Allocate ARM CPU state
 with object_new()
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
 <20231122183048.17150-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231122183048.17150-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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
> The ARMCPU type is forward declared as a pointer to all hw/ files.
> Its declaration is restricted to target/arm/ files. By using a
> pointer in BCM283XState instead of embedding the whole CPU state,
> we don't need to include "cpu.h" which is target-specific.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/bcm2836.h |  4 ++--
>   hw/arm/bcm2836.c         | 19 ++++++++++---------
>   hw/arm/raspi.c           |  2 +-
>   3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
> index 6f90cabfa3..784bab0aad 100644
> --- a/include/hw/arm/bcm2836.h
> +++ b/include/hw/arm/bcm2836.h
> @@ -14,7 +14,7 @@
>   
>   #include "hw/arm/bcm2835_peripherals.h"
>   #include "hw/intc/bcm2836_control.h"
> -#include "target/arm/cpu.h"
> +#include "target/arm/cpu-qom.h"
>   #include "qom/object.h"
>   
>   #define TYPE_BCM283X "bcm283x"
> @@ -38,7 +38,7 @@ struct BCM283XState {
>       uint32_t enabled_cpus;
>   
>       struct {
> -        ARMCPU core;
> +        ARMCPU *core;
>       } cpu[BCM283X_NCPUS];

I'd be tempted to drop the unused struct:

     ARMCPU *cpu[BCM283X_NCPUS];

while you're at it.  Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

