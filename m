Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E8D7A03D3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:27:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglQo-0007tZ-4s; Thu, 14 Sep 2023 08:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qglQf-0007rw-Ny
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:26:42 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qglQc-0006X3-MH
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:26:40 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so134006566b.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 05:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694694397; x=1695299197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WTp3yPb2PACwEQCpaz1Ap8Hl5eu3Tm4ocL5DYXQYnrM=;
 b=XF49jk97lzCgMw4XesWphnfS6QJvnqFYSep6JhI9+0w39pUI/mFyi6RrJaWejPPlKc
 /vHKc9vEtB/7RLL3pnjmJy9oiwz9l0NzbDfDTGsT9iZOU1Xvo/shO8oi5MNUXCUM5sYj
 l5DHQq7IbPI2LRFJ7neiLk4oF635F0iA1ry8ApEs+yV8Grs0J9hbZHPJluzVOV7+Xz35
 IMXdzARgo3ZrTKji0nuCmaT3whzbbFrFfbQr2Ig6GXPoSLOIFfsmqLC0UJSFs9K91Ffg
 bnM3RK4oKLemdJ491KEtFyQyky7G/ACNG3QtxpL6INcfYKjWZN7tvCCbN41ocSU+wQWw
 cWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694694397; x=1695299197;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WTp3yPb2PACwEQCpaz1Ap8Hl5eu3Tm4ocL5DYXQYnrM=;
 b=nyBoe0Jme5p/GjAoU8R0+BFM+u7CQnHX4thLsrhW8f1D3hYJgH5dtEUcAACfiOgIxH
 kFLMkWCVL+4J/TLZootzMDVkTWgXR8D2Dfs7cPkooxL+yhKxiq/GhP0E8dp7Tj5viBBz
 3+efSqDINm+5K2J2o0FcwG02yjjAqn1Wc8BOXytJQ849HjdhqDEMKAe4GDDdWoZ9nb+w
 EuuIDYKdh85rBnOL/dv3Aba2MwDMXoVjTLnRTJr1UKlK30kP07Oo+c2swJH9fmCI2sl0
 p4WnvSJBhsD4bRZaY1ZsQKI4O/I9zQ1UM9h4UQ2gFAd6y4Q3wcYAWpmz+c1j0d5V7psC
 vqJQ==
X-Gm-Message-State: AOJu0YwAo7aoiK96zfcBeXV7j7Kig2TmcCujIE7q8N+6bommJvBEyh0n
 mospLK2INQiVLyYKVw0KRO0wWQ==
X-Google-Smtp-Source: AGHT+IGLDALSB+ENvj9c+FUiisEYdE2XqXkBTOMkYkvYd7G7QelHORfhrmBXyMhBWOIaZi4msFYuIw==
X-Received: by 2002:a17:907:96a5:b0:9a9:fa4a:5a4e with SMTP id
 hd37-20020a17090796a500b009a9fa4a5a4emr2345914ejc.13.1694694397008; 
 Thu, 14 Sep 2023 05:26:37 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 x8-20020a170906298800b0099bcb44493fsm947897eje.147.2023.09.14.05.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 05:26:36 -0700 (PDT)
Message-ID: <09413ec3-965d-8588-e0df-e8c4a6fa55b8@linaro.org>
Date: Thu, 14 Sep 2023 14:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 2/3] {include/}hw/arm: refactor BSA/virt PPI logic
Content-Language: en-US
To: Leif Lindholm <quic_llindhol@quicinc.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20230914120124.55410-1-quic_llindhol@quicinc.com>
 <20230914120124.55410-3-quic_llindhol@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914120124.55410-3-quic_llindhol@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 14:01, Leif Lindholm wrote:
> GIC Private Peripheral Interrupts (PPI) are defined as GIC INTID 16-31.
> As in, PPI0 is INTID16 .. PPI15 is INTID31.
> Arm's Base System Architecture specification (BSA) lists the mandated and
> recommended private interrupt IDs by INTID, not by PPI index. But current
> definitions in qemu define them by PPI index, complicating cross
> referencing.
> 
> Meanwhile, the PPI(x) macro counterintuitively adds 16 to the input value,
> converting a PPI index to an INTID.
> 
> Resolve this by redefining the BSA-allocated PPIs by their INTIDs,
> inverting the logic of the PPI(x) macro and flipping where it is used.
> 
> Signed-off-by: Leif Lindholm <quic_llindhol@quicinc.com>
> ---
>   hw/arm/virt-acpi-build.c |  4 ++--
>   hw/arm/virt.c            |  9 +++++----
>   include/hw/arm/bsa.h     | 14 +++++++-------
>   3 files changed, 14 insertions(+), 13 deletions(-)

Isn't it simpler to reorder patches 1 <-> 2?
(First fix PPI macro use within virt.c, then expose header)


