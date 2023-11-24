Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A33AE7F735F
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 13:05:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UuY-0006BA-1U; Fri, 24 Nov 2023 07:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UuV-0006Ap-V8
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:03:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UuU-0007ps-2B
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:03:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40b394f13b1so7040395e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 04:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700827428; x=1701432228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sFW62EhvoODGu3lSPlKzogEp/vyX8mP5DwDiM4p07qA=;
 b=eP5dHrNQkaumSnDQBOS1ZNd+dKJKHSgkLaKym43THp06L6k3QNDzs547+3yePqic0B
 myD7ou4KOgowc1Imd7RDDoTtgvyTVtHWUTIld+emjwdGWXhb6+IE4cAmDo1lMxU/xnKw
 kpk+QsWNymFx/GwAk9nEUj1VpHn16lVssRKwvkIH8cDVr/RQFu8rNKuZdYN7nT6qyskS
 8SqJWpc74B6kpGTo27oJOPRGZdl5cf79/2TpV4/9zAfaUbmu9b04oj3SFk0V/3FWlS5/
 jN5vFBjplNkyg+HK4rdQVbTeg4a8do5I8r9ve32d6Zae105JspFoknr4tcImv5MbInL5
 L2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700827428; x=1701432228;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sFW62EhvoODGu3lSPlKzogEp/vyX8mP5DwDiM4p07qA=;
 b=U10LskzPKy7PN+ycNzTbFdEQVrIB2STYidjuU+egFlyOKsG18WN/thntGQ6sm+ozLk
 eGPsMzGS7MKQMnP2ccuTiUDKfCuFlFhhQNyjRY5x6e06TjlA/nTHNIgI/fnWYTj1gN9P
 15K+hLVxlz0BoZQaRDx7Uli5qRGLsjeHxAey9f+hhefG+9CWqWEKVvSoMmo5M8geX9Fy
 Ky5ASToWKh5YxGj7tG3yV0nia1fFSbSk76wwxkxnFBLX9Ij+KoKg1ZFvs1T7juW2Pjl3
 O/nlzpxduKTxpO9L90i2rEU61T/nv8Th5BswrsfJ4rX+NKroLlr9Uc9DL9g8XbvOuMJ3
 H5GA==
X-Gm-Message-State: AOJu0YxM+L9lztmVvwMnyG9qpmTR2wqSEt84ph63ZtBkAjvrJxUSAMvY
 7OcL9Vy8Mour0yGzQZFiB3a97L6irR4pF0MgaVY=
X-Google-Smtp-Source: AGHT+IF3hmt294+b8GCEp6yAe2I3aKQ3S+uCuMqh062U3i94IW7y6Tm5N5DgRzmulRSco1chSrER/w==
X-Received: by 2002:a05:600c:3110:b0:404:7670:90b8 with SMTP id
 g16-20020a05600c311000b00404767090b8mr2199236wmo.27.1700827428198; 
 Fri, 24 Nov 2023 04:03:48 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a5d4d0b000000b00332cb23ccbdsm4093327wrt.81.2023.11.24.04.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 04:03:47 -0800 (PST)
Message-ID: <0201c36a-ff7d-42e8-a735-0fba547dcf2a@linaro.org>
Date: Fri, 24 Nov 2023 13:03:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] target/arm: kvm64: remove a redundant
 KVM_CAP_SET_GUEST_DEBUG probe
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Chao Du <duchao@eswincomputing.com>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 23/11/23 05:42, Richard Henderson wrote:
> From: Chao Du <duchao@eswincomputing.com>
> 
> The KVM_CAP_SET_GUEST_DEBUG is probed during kvm_init().
> gdbserver will fail to start if the CAP is not supported.
> So no need to make another probe here, like other targets.
> 
> Signed-off-by: Chao Du <duchao@eswincomputing.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20231025070726.22689-1-duchao@eswincomputing.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm64.c | 28 +++++++---------------------
>   1 file changed, 7 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


