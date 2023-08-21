Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91446782423
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:06:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXyzX-0000o4-DR; Mon, 21 Aug 2023 03:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyzC-0000mM-Mp
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:06:04 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyzA-00070g-G2
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:06:02 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2bb8a12e819so46614541fa.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692601558; x=1693206358;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A3gX2o1We0kAWckFMbelIkL/B0zJqGClmWnL01QziMM=;
 b=qS94kIYN2+4KrfBU7/enYinBZusu+koeYLM/7eNvfK4++IW3B/e2E/SGEBEHzokK7e
 nDDPHdS/kOPkUy6Syaj47rbCAKVnWNw9Kvd7MW14RfUdg0Fz4Vh+lPzxeyMobEOJ1VQz
 ue1SYAJ1pKFXYekXTm0n+LYqmQ7gYsugDOW4ZYJToJ55mS8DPC/CF6FXS4nmlQM983Bf
 xVF4b+9EUyfBTixCxEhW+DLfSFoY6hsddt2gdDBwAxn5vpYNHRMF0wTrswwyMUu1jGTb
 TpGyNo9C0lASobUbpe8xR/31lclgVMuQzJZNCRWXx7ash5a6bE/CQ2SS/ci6/4tjU1IU
 AfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692601558; x=1693206358;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A3gX2o1We0kAWckFMbelIkL/B0zJqGClmWnL01QziMM=;
 b=Mu1Ng9ZYCh5yNoLlgJ3KhGjLbNzDx186WzYHcC8MUAlrRj7SHuie9UEa1+MQOhNuwE
 8iK/kjgAYGZz7dGOGMb2bfUynvi46urj2p/y9+0ehqZIN30WSRM8JPn7y3dpXKIqFqu2
 QKkVADuC6FsJu6yMGw5MSOlZOh7dxgZU3YVEEgyPX5cqX24273DSgxlzdBiSuFF/bD2d
 3JXjGaRufcqy1Yb7M5a7SipEKiN4EnO+s9XkTrJKtAcjG1aaHqG9pFFGpj1tDDGRZjdW
 TMQwSlCHJ8ZJkDXfLYYNIe4+mypGo/V+HTVFItF+2WPPiYtDPzAxh4JTZ5TRbURRI965
 rWFg==
X-Gm-Message-State: AOJu0YyGqN+W52PGALjbdd3ahTJ/QG55kVAnoSrs147OiEFhFzM7NoLi
 gur14TKG0Y6iSwz6nuFwzcE5+g==
X-Google-Smtp-Source: AGHT+IFA3not3OHPDYR3TgeK56vn2cGVHUkIdwM2LnrPRFBjc348H0JT7S0CgyeaGHpOrLt2lgU77w==
X-Received: by 2002:a2e:7207:0:b0:2ba:6519:c50f with SMTP id
 n7-20020a2e7207000000b002ba6519c50fmr4337185ljc.52.1692601558540; 
 Mon, 21 Aug 2023 00:05:58 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c379100b003fe26244858sm10280273wmr.46.2023.08.21.00.05.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:05:58 -0700 (PDT)
Message-ID: <6b8e09cb-ae7d-18cc-d4cd-b41e627c410a@linaro.org>
Date: Mon, 21 Aug 2023 09:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 30/33] target/arm: Enable TARGET_PAGE_BITS_VARY for
 AArch64 user-only
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230818171227.141728-1-richard.henderson@linaro.org>
 <20230818171227.141728-31-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818171227.141728-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 18/8/23 19:12, Richard Henderson wrote:
> Since aarch64 binaries are generally built for multiple
> page sizes, it is trivial to allow the page size to vary.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu-param.h |  6 ++++-
>   target/arm/cpu.c       | 51 ++++++++++++++++++++++++------------------
>   2 files changed, 34 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


