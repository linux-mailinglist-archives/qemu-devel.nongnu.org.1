Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E447E5F85
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 21:56:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0pay-0005NB-AA; Wed, 08 Nov 2023 15:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pav-0005KH-Nw
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:56:13 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pao-0005lb-R8
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:56:08 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40806e40fccso421715e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 12:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699476965; x=1700081765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QVKGDCVLmJfCPDcvthPLoEurFev3Qo8WopnVYtrI0p0=;
 b=r5dk8f0vGLrv7VGO9fIX5bUWKz6SvnNccq2AGVsuL6XGyfs2yO+mM4lfhx1KlG4F9/
 ATfhJnrw1+s0tbPLN9DFYFTLsd7d+BYxxQjOSyS6icLlYk7cmnAt6UFEc8ABwPGZZCry
 kFJRSGXe3CRBGGjN2G0fvOFj1CLxWnz6vyNWYrNgDZMX5GXN9Qi3NFxKRA8SSfaOgJIy
 Z+395rCldn8Qu/2KyRZG+lDPDK0U2hfDimJvGt2k4jD5hKCgTPqdcQm4flMTp3iZMNkg
 D/j2E+p7Wm1IlgKRZxkvwcDbkkzm58Wy+hGnt7eqYO+YoD0HpVANihkze8loCS6YgiCd
 CMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699476965; x=1700081765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QVKGDCVLmJfCPDcvthPLoEurFev3Qo8WopnVYtrI0p0=;
 b=ew2d+opldthL83M2FHA4PDr0smKze6OhEeE5lpuIW5ziDG16vjbRf3yh+x0d1E1YEP
 k7do2ffrKbi/W5erpmVHw7it6LJnvAxT1p5H0GCGhvjOFSSPFy08kJUTkvmwfckLKkl9
 npZaeMRSz4XOSdR/1JRbZeYiRn+P4k8eL+Go1v5qBrkt/dNmo5WJJQm0gbG7qNmrXGjV
 oJ+R3DGinZHFrbkmC8A/POjxa6i84bVoIhsYyrxgil1hTcFNkV9Wb21IiNOTILWi6dgu
 cqEne2shpUuznh+3taSc27q7RquQzrJGvY5QgVkSzcj1SDMjFTZitmqdoUnx3x97LunT
 mbGw==
X-Gm-Message-State: AOJu0YxifUsd/e8BcgFItlBNVK20RkBfequIP8ZpIdR411aP//NhXRiL
 tVQj2CLa7W0qzRfUjWK4rq589g==
X-Google-Smtp-Source: AGHT+IEmwRY9SKp1xrkadYs/hPErelJd59LmTl4eq1WYhGZcEzaZatV24n4t4CAPMwdz951zFMRsOQ==
X-Received: by 2002:a05:600c:4ec8:b0:408:37d4:b5ba with SMTP id
 g8-20020a05600c4ec800b0040837d4b5bamr3025898wmq.12.1699476965170; 
 Wed, 08 Nov 2023 12:56:05 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c3b8500b004064e3b94afsm20771584wms.4.2023.11.08.12.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 12:56:04 -0800 (PST)
Message-ID: <ec975f16-6362-49fc-990a-d0a0048fe02b@linaro.org>
Date: Wed, 8 Nov 2023 21:56:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/35] target/alpha: Use TCG_COND_TST{EQ,NE} for
 BLB{C,S}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/translate.c | 39 ++++++++++++++++-----------------------
>   1 file changed, 16 insertions(+), 23 deletions(-)

Preferably split:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


