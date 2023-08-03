Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B376ED2D
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 16:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZdx-00054j-7h; Thu, 03 Aug 2023 10:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRZdu-00054U-ST
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:49:34 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRZdt-0007ze-C2
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:49:34 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso8968235ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691074172; x=1691678972;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FfaiWdFj4xFAUNCP4y5+n7lnKLnlthNlV9R5fdEog/0=;
 b=NLWefpgcKcYBk7WJg+VSa1anCuD8Cb3tq6gYO5haLPKsR37VLx9VbOTqaZ6SNDEvmJ
 ryBzqfvJqCLtR12iHdUEopffauZ4/Ut4EB3CJj33UDwRp6EYYGqUWH6fa5WFHt2wXS6A
 Fso6cOPOxb8yJVdYwY5vpUxUuncPkEEQdWMT/jPvP3qzNxO2oSgBQe5y4/67rZKvSqbv
 NkUcjvhtOeuYsGWiL+mBWIV+/fCK5cE2FSWxRtZFSynsZaJX9PLzv1mpFcTDW9LJa8xX
 EpbcR/To740ZccDMQ5csi3XiPRGfMaClSOTFjjs2Wv8hMkLe1ZqjUMO8zSVmQ+mduCoO
 8dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691074172; x=1691678972;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FfaiWdFj4xFAUNCP4y5+n7lnKLnlthNlV9R5fdEog/0=;
 b=f6VR9CrCOLNF307gQI2PtwPKqHJWkI+8TOL84Hah7pH7L4q0UUQMb2cuMGrpXqZQ0H
 UmRkvZopoUailE4qW/nwrfeCKzJSEIMO1o03WkexGqIjS+QcpqITobBaQDzZbfFWVg2e
 NdKY+bQFxwSoNx5px3/Q+SeBq6822NCvsk9pjEZ6n6ZbwSagSkUQnBdE7no5VuvyPyzc
 oTYcHT1azYhG6qjsLwcllQKyvdHwnqUwTUiPOlK/e/QeTlPM/CoUuepd22OPcnm9RuDc
 jhfHNK6e3G4xkzPwsEvTge2XDf49WIO0bUaNxvm9hLfTHFwDALaOEVc1qBm8AoclPx8Y
 cXqw==
X-Gm-Message-State: ABy/qLZOK1AeoUw/m+P001YuZmU9EVUnEAb1lk2pffN3UphlVqHlyI/R
 SJHtIlXcVwY1VYp7vW/Db8xAu+1vs1PzaWfCaS0=
X-Google-Smtp-Source: APBJJlH9rEWf7QW6gJHfRZPqyfUKDQCuUkEqfYGURbfbCdT0aZ59FosKs7TS9Td2TFL/3YwHRSWmTg==
X-Received: by 2002:a17:903:2309:b0:1bb:98ef:4b2b with SMTP id
 d9-20020a170903230900b001bb98ef4b2bmr23304362plh.16.1691074171532; 
 Thu, 03 Aug 2023 07:49:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001b895336435sm14442169plh.21.2023.08.03.07.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 07:49:31 -0700 (PDT)
Message-ID: <10f8c952-86a4-f97c-aa13-8a50723c7642@linaro.org>
Date: Thu, 3 Aug 2023 07:49:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/m68k: Map FPU exceptions to FPSR register
Content-Language: en-US
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230803035231.429697-1-keithp@keithp.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230803035231.429697-1-keithp@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 8/2/23 20:52, Keith Packard via wrote:
> Add helpers for reading/writing the 68881 FPSR register so that
> changes in floating point exception state can be seen by the
> application.
> 
> Call these helpers in pre_load/post_load hooks to synchronize
> exception state.
> 
> Signed-off-by: Keith Packard<keithp@keithp.com>
> ---
>   target/m68k/cpu.c        | 12 +++++++
>   target/m68k/cpu.h        |  2 ++
>   target/m68k/fpu_helper.c | 72 ++++++++++++++++++++++++++++++++++++++++
>   target/m68k/helper.c     |  4 +--
>   target/m68k/helper.h     |  2 ++
>   target/m68k/translate.c  |  4 +--
>   6 files changed, 92 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

