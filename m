Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 136167150E1
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 23:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3k9y-0004HQ-Oq; Mon, 29 May 2023 17:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3k9x-0004HC-0R
 for qemu-devel@nongnu.org; Mon, 29 May 2023 17:12:09 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3k9v-0001yT-By
 for qemu-devel@nongnu.org; Mon, 29 May 2023 17:12:08 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d41d8bc63so2934152b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685394724; x=1687986724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KaPpQlDUtcWadnFHEIKgQbaxtSS7Q+URWUufrCMAkuE=;
 b=Hg5icDqLudjdfeHhoOF4tp20SzdQfndghbYoukpnPZpcq1A35eI/bdVwkgdrwd6JEY
 Mp7soA4Wzli4Wyr/sEbJecwTvVJnwoUrF29GyynpmYD8x+KIhaw3ve3/4cPfwOlK3C7r
 39/mcA7eO/YIVjYRg6bRraTGVCwi1VIWmY8G7ezcePhxrvwUEIRHiTX2SWHh4ofH6QCY
 Z/Dqu7Wmc1P4YXjlYtXwEWQnVvHMhhz6ZRkJJhvwyijLMaYGhjdmD3HeKboM2p4DQk9C
 Vqi/I3bHGRjCsdEto4za7DsONI+5lXvuJUslLc3GeVpnapIi3zGlE5o8wuwRCPAMcQDu
 cZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685394724; x=1687986724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KaPpQlDUtcWadnFHEIKgQbaxtSS7Q+URWUufrCMAkuE=;
 b=Ggyo5fpmfKHZWy+BrACNwJojNpmHBTbit0EB5A4o5UG3ptHRsaLa1EPbHbMogkhBP9
 RqTKelsAExgAGhah14Id5gY0FC1u111RvUBxReCEbxs93BtaHnlo0rX+Oz9jLTuibqYW
 KZMsgIpeQD32ST3RTRjGIIkg4xo+z6zWy8qbKrYbyQxBnq2IcfkxcjEC4aGAO7e/rAFU
 FCwssCpffClPUmjaRiU6Jj33o4WNr7xsjn5VSutV+/6R43lQJSMKJVn9O8dI/GdcA6qu
 EEl3VmKSTxc/ATOS6tHt5mFe5eXCDbhfNTHS2Ps/KU6HOfA7nsp8Noo5PN2c6B7sV+iL
 vjHA==
X-Gm-Message-State: AC+VfDwXTOgXGPlC+IZFXGONxvklJyMaqNPet0jrxgmfyH6qBwZxgdse
 9fGf5IbUV57SSXFuIs2b7tOq1Q==
X-Google-Smtp-Source: ACHHUZ5Y+tJsSGICplmuD7nmpXJvlbKSqLeduvf86cU7FewUdbk61bm3DfhkHxb/+W+dWo0S7NGSlA==
X-Received: by 2002:a05:6a20:1583:b0:10f:759d:c5b2 with SMTP id
 h3-20020a056a20158300b0010f759dc5b2mr169579pzj.45.1685394723980; 
 Mon, 29 May 2023 14:12:03 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9923:e5b8:e7d9:7a28?
 ([2602:ae:1598:4c01:9923:e5b8:e7d9:7a28])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a656786000000b0053f1d55676fsm6776698pgr.2.2023.05.29.14.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 14:12:03 -0700 (PDT)
Message-ID: <4faba8b7-fc75-1ff8-0e95-bf09eb93c9c7@linaro.org>
Date: Mon, 29 May 2023 14:12:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 01/10] accel/tcg: remove CONFIG_PROFILER
To: Fei Wu <fei2.wu@intel.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20230529114947.2123652-1-fei2.wu@intel.com>
 <20230529114947.2123652-2-fei2.wu@intel.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230529114947.2123652-2-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/29/23 04:49, Fei Wu wrote:
> TBStats will be introduced to replace CONFIG_PROFILER totally, here
> remove all CONFIG_PROFILER related stuffs first.
> 
> Signed-off-by: Vanderson M. do Rosario<vandersonmr2@gmail.com>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Fei Wu<fei2.wu@intel.com>
> ---
>   accel/tcg/monitor.c           |  25 ----
>   accel/tcg/tcg-accel-ops.c     |  10 --
>   accel/tcg/translate-all.c     |  33 ------
>   include/qemu/timer.h          |   9 --
>   include/tcg/tcg.h             |  25 ----
>   meson.build                   |   2 -
>   meson_options.txt             |   2 -
>   scripts/meson-buildoptions.sh |   3 -
>   softmmu/runstate.c            |   9 --
>   tcg/tcg.c                     | 208 ----------------------------------
>   tests/qtest/qmp-cmd-test.c    |   3 -
>   11 files changed, 329 deletions(-)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

