Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 889927DEC2B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 06:16:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyQ33-0006pH-UW; Thu, 02 Nov 2023 01:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyQ32-0006p2-JH
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:15:16 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyQ30-0000vv-Ed
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:15:16 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5b99bfca064so398182a12.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 22:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698902112; x=1699506912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KI+62AnJc8l091vSM7kOpTFNVV5je0+Hwx7VYeOSrFc=;
 b=Udc9QSxMIzGaJ79UA+PlrJHVAM3EXhh2EK3FlawySd1WGL/4DWqoXfu+on1RJ4Wg93
 Li8b9JJaMDeftP9CbO48WiBzFYDpC88u/Tk42VVSnP9Eksl35or0VAvnh0HvNp7HXgJ3
 /cTCjofo8OXuvdoG4X84/gwZaPiy8x6f2MNMO4gwNqu5X0n+V7thAUBEChD5YhK7Cyvx
 j/LERo44bL+16gz/2bqYUqADxAJBcLEypusg0rdKp1hDPJ1sySZBK4DETn8a3cyLQdCA
 PBQRekVtn24rQYYFtKxS/jGXR43SC5Oeu84H74wXenEb/FoZmDDKqp78XcKjNZPIrCWR
 0CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698902112; x=1699506912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KI+62AnJc8l091vSM7kOpTFNVV5je0+Hwx7VYeOSrFc=;
 b=CGscSSnXg/2KSpg9dQhyc/lbgT0vESxwrWBip0Ohi7Q4NRUOIevTzj8AO2lbfrQoxf
 7RE9SzMK2/VVkY7RFBrKJvYN38rEtdgO0Gx3LCD2Om+wcOvo3bB8oNoSTBCKQHurCXcj
 Sx4Ex++ie9sIvCi72I4AJdIqaA7nTbgjXTdtTkSi4SBeFr1xgS+QBmbU/K807z0Tx4or
 ubLXJpNYbdl0CWnOgN/BWii4TkMwihg3DPUoqme1MjzlalhF87zV7UdTyocF77JuytF1
 QUv3hCLto84W5P7KdyTv3TM4E+jeKBrDJNuLZpIzVmEFlIzoPo0FzqWds3PH56FDIOp6
 xvpw==
X-Gm-Message-State: AOJu0YxVa/yRl4MjigxGr8GDKlDGudDFDnNkyDzUbCENyjg1pJPpa7Cm
 PXeYZZr5HZEOFfg4HOH8x9X53Q==
X-Google-Smtp-Source: AGHT+IHyyU4JahTZgwrcZC370TewssJ1PCQ29DzLryJitONyJcumXyfIJeEXfnIXBTiYdPxc1sF92w==
X-Received: by 2002:a17:902:e54d:b0:1cc:4625:74ed with SMTP id
 n13-20020a170902e54d00b001cc462574edmr11840564plf.53.1698902112115; 
 Wed, 01 Nov 2023 22:15:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ja11-20020a170902efcb00b001b8a00d4f7asm2126740plb.9.2023.11.01.22.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 22:15:11 -0700 (PDT)
Message-ID: <3e900797-cb55-4911-b1b3-5915baedf238@linaro.org>
Date: Wed, 1 Nov 2023 22:10:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 30/33] hw/arm/virt: Hide host CPU model for tcg
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20231102002500.1750692-1-gshan@redhat.com>
 <20231102002500.1750692-31-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231102002500.1750692-31-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/1/23 17:24, Gavin Shan wrote:
> The 'host' CPU model isn't available until KVM or HVF is enabled.
> For example, the following error messages are seen when the guest
> is started with option '-cpu cortex-a8' on tcg.
> 
>    ERROR:../hw/core/machine.c:1423:is_cpu_type_supported: \
>    assertion failed: (model != NULL)
>    Bail out! ERROR:../hw/core/machine.c:1423:is_cpu_type_supported: \
>    assertion failed: (model != NULL)
>    Aborted (core dumped)
> 
> Hide 'host' CPU model until KVM or HVF is enabled. With this applied,
> the valid CPU models can be shown.
> 
>    qemu-system-aarch64: Invalid CPU type: cortex-a8
>    The valid types are: cortex-a7, cortex-a15, cortex-a35, \
>    cortex-a55, cortex-a72, cortex-a76, cortex-a710, a64fx, \
>    neoverse-n1, neoverse-v1, neoverse-n2, cortex-a53,      \
>    cortex-a57, max
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

This patch has to be sorted before the previous patch, for exactly this assert.
With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

