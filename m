Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7498B7DAD54
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 17:58:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx96I-0001Hh-AB; Sun, 29 Oct 2023 12:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qx96F-0001HV-G5
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 12:57:19 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qx96D-0007lI-RA
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 12:57:19 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1ea4a3d0a44so2619239fac.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698598636; x=1699203436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d7MOgHFhqxy5cOU5KIEYIc4grqJOUbQzDOzqWZ49hSI=;
 b=idw9FnvfqbT4CPvAZVmIkzjMzof+68+5CStif36NmflwX9NZVJkNGBWK8N9j4TjDEq
 Dn6h8B/guP69HvpMQjR9MYMGJ/wKbj8KaySskGBkWWtSeXAjpTWQQOu9F0VtMoFDYSoN
 1+vyGlbFV8nuMjEE3Bj7qFXE0zBp0kUmbY/d5thjq9C4j6CXYaltwXdEeU82or16eifi
 lQyTe6/D3gMxAswn4YfBcmjkpDdYD9hK8Qu9OkzSToiheGrW8CLTw1lGovUy87NUBbFy
 HzJhoqdBU8SHvuorZQC+5eJU+Dl8Ovk9ToibtArHNlT24kyP1jI3MOp/kbRcADFtr4XB
 fKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698598636; x=1699203436;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d7MOgHFhqxy5cOU5KIEYIc4grqJOUbQzDOzqWZ49hSI=;
 b=XNjG6eDz/Fs/Zc0xZkda01Y1zZE4PMMHb2D/NQ3FoQ2D4RTDR3HZnGaOrqFggKDI9F
 BPKQmuUkgCsMdYge8NRuyJEOP6bQpXomhI1l7H721zeXAqp2IYASdusOfvw8nGPpVNNI
 GEIcmeIEGTsHAinVjbVemKD/XXuLs3HUcmtnxeErM5c0lWvK/rxW729MH+p1Ye+by5yX
 NzRNaX+sg+1jayVveSlaq7ZBpcNUnRkWvk/aoa0ZJaI+pngv8alCPTmdV9OZb6CCSl2L
 xb8wHphPWRredvCa6+Ants2182EYsqqo79Wc8O559kCrbsYwGph2CZIlG0t9/iQ+d0rh
 CjJw==
X-Gm-Message-State: AOJu0Yz/ifhlutsy7aCHE8MTphw+bV5E8H0JMfCfLM0JW6yXmXHRc9VQ
 D7wKllAQw/XR/isa1yBAHnLgqQ==
X-Google-Smtp-Source: AGHT+IFpFxQnlV3NSHzHW+E/Uvm2N87ry9rFmROXpYJ00yC6av+1NU1C+uIeZYN5d+jaBaVXCV/zxA==
X-Received: by 2002:a05:6358:7252:b0:168:f55d:4ef9 with SMTP id
 i18-20020a056358725200b00168f55d4ef9mr10636864rwa.28.1698598636047; 
 Sun, 29 Oct 2023 09:57:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a17090a7f8200b0027d219d3ac6sm6143466pjl.47.2023.10.29.09.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 09:57:15 -0700 (PDT)
Message-ID: <5774a05c-337b-40e9-afaf-dadbab410da2@linaro.org>
Date: Sun, 29 Oct 2023 09:57:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/19] gitlab: add build-loongarch to matrix
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231029145033.592566-1-alex.bennee@linaro.org>
 <20231029145033.592566-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231029145033.592566-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 10/29/23 07:50, Alex Bennée wrote:
> We have the compiler and with a few updates a container that can build
> QEMU so we should at least run the check-tcg smoke tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml                    |  9 ++++++++
>   .gitlab-ci.d/container-cross.yml              |  6 +++++
>   tests/docker/Makefile.include                 |  1 -
>   .../dockerfiles/debian-loongarch-cross.docker | 22 ++++++++++++++++++-
>   4 files changed, 36 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

