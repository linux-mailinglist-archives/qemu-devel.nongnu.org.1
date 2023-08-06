Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF37A771598
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 16:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSeeZ-0001Au-EA; Sun, 06 Aug 2023 10:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSeeX-0001Ab-7R
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:22:41 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSeeV-0007iY-HS
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:22:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6874d1c8610so2534261b3a.0
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691331758; x=1691936558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y31H8ZTShTauipGXpESfZYi9ym+mDtvWVcIFT4pSAz8=;
 b=hRJ9L5PnEAaSxJWmUKigrCLJ3Idnn1jvtfEBlJcEruzpg31PdClYlVlDQCkHv/ndDE
 qhh2W5h5GUZePdLmykI4xTAT6CwcaVj3WkuJn9tnPb8QwnuJpJ2BfYiYOIs/38pJ7csD
 +0CThGGNp7LXcQmrpsu4WEFTaWGzp6MxUBpcxf/0rYa2nR/P05mGV4ixPKk+uUicrbPD
 EN7ZDt8BYEFcXXnRFMxWIbVbLIfDJ+8G1DKSwoYos4d7eZ+7ZjBAwAirJIzUNO5sY/45
 BhJSfAUi1xAn3EfjgCWkkIhPjPlSPTNqGFZrngKpBzLg1SOhtPIRiBBAdHqOXn9A5hrI
 sAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691331758; x=1691936558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y31H8ZTShTauipGXpESfZYi9ym+mDtvWVcIFT4pSAz8=;
 b=ldnJkZHKot9Z0P/NxEtyP6XOQTzQ3Oy3vZzkue2mQzihYH8AfI1wMneTHaBLrE3ShU
 G5FhXy/tSA3J6xwbgOgttx4sWS9uJpIFz4ajbwIxu1G1lXDYPqOB39DGFSJwzAdJTir2
 aYk7e0pS3EgMF+dlZCVfK/EAR9x0T9rkQoEgF5FR29N0YRiuuO8BQibehwW8scnFI3G7
 QoND59k5+aaMrbqakDFbivFlE+LoDafr/4ls9Pwx5VCRxT2BRtcFTvlb3j5aWip9jdb6
 OgFhaWAMnCPqaJGelaucGkiZWHIfyspGKLtrwP43LtMRI2Dxp8mVGbF4R6i9BD7lZIUK
 mtvQ==
X-Gm-Message-State: AOJu0Yyzo5jBt47vI8cJct3siNdiBvKpWP6m0Fi5GJWqy6uhRNeGyugU
 kCc9fdTQrrob80/TBL8mGl0Tjg==
X-Google-Smtp-Source: AGHT+IGxWr7QqiLc+5labK7hVZm0hOD5s7Urq4FxkAlyERoyJwAvKlFGxP8SZo+X0BOaG7mu05meiA==
X-Received: by 2002:a05:6a21:71c7:b0:138:1980:1e59 with SMTP id
 ay7-20020a056a2171c700b0013819801e59mr5764953pzc.28.1691331757847; 
 Sun, 06 Aug 2023 07:22:37 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e72:57bd:c5e4:990c?
 ([2602:47:d490:6901:e72:57bd:c5e4:990c])
 by smtp.gmail.com with ESMTPSA id
 q201-20020a632ad2000000b005572d796b9esm3747557pgq.88.2023.08.06.07.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 07:22:37 -0700 (PDT)
Message-ID: <cbfde403-9720-aa96-508c-34c855b7400c@linaro.org>
Date: Sun, 6 Aug 2023 07:22:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 0/7] tcg/ppc: Support power10 prefixed instructions
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: jniethe5@gmail.com, qemu-ppc@nongnu.org, bgray@linux.ibm.com
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <CULFY7505V8V.16ZJ1H7XXFRVT@wheely>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CULFY7505V8V.16ZJ1H7XXFRVT@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
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

On 8/6/23 04:55, Nicholas Piggin wrote:
> On Sat Aug 5, 2023 at 7:33 AM AEST, Richard Henderson wrote:
>> Emit one 64-bit instruction for large constants and pc-relatives.
>> With pc-relative addressing, we don't need REG_TB, which means we
>> can re-enable direct branching for goto_tb.
> 
> Very cool. I tested this on a POWER10 and it has been stable so
> far. Using mttcg with SMP 8 machine, with this patch, a parallel
> gcc compile job in a Linux distro is 11.5% faster. Is such a big
> improvment expected?

Possibly, given that we had to disable direct branch patching for USE_REG_TB.


r~

