Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2815680AB87
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 19:01:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBfA5-0006js-Ue; Fri, 08 Dec 2023 13:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBfA4-0006j5-6i
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:01:16 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBfA2-0001AV-8F
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:01:15 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ce32821a53so1599216b3a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 10:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702058473; x=1702663273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/4Vv6Rze+fS3c7oqzK9hyFILJWWiOEfb1Br8IM+zSY8=;
 b=VhUvafjnB8srchah9X7BYYcvidIeSdqK/3pLGKDPkWw2yRtyiRu1uq+Dl+wVpMPHuj
 KCggWHucavNyh/CSdITVPSi0m/M8sQnES3+V2026YDnBMldVxIzUcf7vPC8XFALT6i9a
 cb4rCjji0005DulosbFWOdFNNXqdIfaU0gyryZ9TknzIlnUYB2qSycqc7JwPP4Dq8en7
 QTjFyYbrTC4asgp9RIySWd+j3Q2lwhTKo4wKmf2RpLHl3LaZ20H4ZYXn4gEqPrb8RW4V
 G5lLzE9KTf0XbErQESf5FFjSzDfpjhL6F0EhhWO+AQgwV5x6LnENjCDYqGRzpRb4Rfbm
 cLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702058473; x=1702663273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/4Vv6Rze+fS3c7oqzK9hyFILJWWiOEfb1Br8IM+zSY8=;
 b=tQl2blB8WR7plYg+gUoDxTfG6MgczPi0EJkKmW16RzY/d2Gp2tT2OOKuc+4JR6kIf4
 KJRWBtI59H1yjoFQM1ismK5tJ781tKNrUsqueaedSJwQ5QC9Ey9oCebrKrFbQJn77DDk
 l1hXIoEf88m0WgqW1S9QEAOM5ueH1bus6RTHgcvYEu4NWE2qL+3DVbrkOPFzBmrFp/p3
 3uVOxGZLzUMznCvTPC49HoMssYS2NvqshZxn3QTm3IGDx5YDVOh77q27X3CIcluITjwt
 t/OJH6FOelnqSzwhwxjZEpx6thJMnjodsCyCoBEtqArPe7MFBXxrvFbzmaHpOnEbRexS
 BKCw==
X-Gm-Message-State: AOJu0YznuPoSEP/l877wDPZAsEcxzPtunlY/4TvmJe0CzwkG0fvsJwk2
 5ikoyWR/Of/A6EdPpuo75HUysQ==
X-Google-Smtp-Source: AGHT+IGx+tQg8IAjgOVvNoFm6zuudmjM8Vu933z++5ffV0VDpzSpQzBtCINEuEWB7OWpKK81FCWSHA==
X-Received: by 2002:a05:6a00:1988:b0:6ce:7b6d:b33c with SMTP id
 d8-20020a056a00198800b006ce7b6db33cmr437631pfl.29.1702058472895; 
 Fri, 08 Dec 2023 10:01:12 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 h66-20020a636c45000000b005b9288d51f0sm1815151pgc.48.2023.12.08.10.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 10:01:12 -0800 (PST)
Message-ID: <97c5932d-86bb-47d1-a93f-2f61cc3c4e14@linaro.org>
Date: Fri, 8 Dec 2023 10:01:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] util/async: Only call icount_notify_exit() if
 icount is enabled
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231208113529.74067-1-philmd@linaro.org>
 <20231208113529.74067-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231208113529.74067-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/8/23 03:35, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/icount-common.c |  4 +++-
>   stubs/icount.c            |  2 +-
>   util/async.c              | 16 +++++++++-------
>   3 files changed, 13 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

