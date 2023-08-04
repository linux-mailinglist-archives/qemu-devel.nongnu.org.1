Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 413707705B0
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 18:16:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRxSS-00013u-6o; Fri, 04 Aug 2023 12:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRxSQ-00013m-SA
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:15:18 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRxSP-0000GL-ET
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:15:18 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-56401f1da3dso1278522a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691165716; x=1691770516;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DELwm8a07pC+VWdL3NKWj2rae6UVQDAw3M4Zzze5ml4=;
 b=eczvZKecyNRHFOnVz74Ife26VtBO66TJzSgMuOWx7o9y7MHFk63WjoL4DeG5wOorNH
 GAaxwkdWOeZr5VXm1ns5NMtLzcgUGCp3GDKKCg7PQuMh8y1Zbg0toVghO8MLsRZ7wD3B
 DJnF+wVCAd7XL+qcn16xxAUNe6nKZQ93W/nhpUcV2PlwM5PhUoB/tTvbhER68M8xtpmG
 1Cu8csnsCzE1AZKwdkwfParuu1B8CnvmbAd+zvOHc/2h98kEmKH9cGfaRhhuIpqs5j1S
 bLoSOJn0Yr1GgzkC7JOBsoNAMNsUDieHlRiGyO5VKDEEHkIUqX9fgRwlKAYn+RlAME6O
 za/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691165716; x=1691770516;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DELwm8a07pC+VWdL3NKWj2rae6UVQDAw3M4Zzze5ml4=;
 b=I+G6kxzoJR1xFrdUO0kNcOJyv+XxXTzqZEvgzZfsxRR1N2bfIJzKAQIHW7znmcQe+Q
 0msZAYVZUtzJLNwc1AlRqLUiKT3GnQItYLrgfFtpWkDkqRjBO9Sbz+W+7Bhn082Dq7ZI
 bGvZaR8r7k79nXI/CEhlcsthrp3dorPoB7WXCQFNXGBCMEJEpUInXkKO4L1Hw0bEoO58
 lGlsNhniMjhVXKNfRZC8qQHHwsTePPEpjmuqTcVmpP02Q3zzF9o0/F2P8wrECmnjDsP+
 5ioVIMNsOusMXnMWXwQ2CaCcEu+2Clg96YZVR59brf0qksSWhzM2i+Cnp+tCCsrsiLrd
 xbrA==
X-Gm-Message-State: AOJu0YzhvH/XBeDVMALl2ASo87zGM/ejcwT+4C8kL6IqTZIh7kjrAkDz
 HDue8E0G3WMKGFW0RIf8UvK7Nw==
X-Google-Smtp-Source: AGHT+IErRS+HDz10g82IYIzPkveNPLAy4ZgFjfuwNw3LLGpGfDp2i7gCi+dyZDjtfiiKDmSrr6WrFQ==
X-Received: by 2002:a17:90a:688e:b0:268:1d18:a19f with SMTP id
 a14-20020a17090a688e00b002681d18a19fmr1938990pjd.25.1691165715608; 
 Fri, 04 Aug 2023 09:15:15 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:1eed:f77f:f320:8b14?
 ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a17090aaa8b00b00263f446d432sm4345912pjq.43.2023.08.04.09.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 09:15:15 -0700 (PDT)
Message-ID: <7d785fc0-06d9-3e4e-b1d2-53ee77fd8ab4@linaro.org>
Date: Fri, 4 Aug 2023 09:15:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] Fix SEGFAULT on getting physical address of MMIO
 region.
Content-Language: en-US
To: Mikhail Tyutin <m.tyutin@yadro.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Dmitriy Solovev <d.solovev@yadro.com>
References: <20230804110903.19968-1-m.tyutin@yadro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230804110903.19968-1-m.tyutin@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 8/4/23 04:09, Mikhail Tyutin wrote:
> Apply save_iotlb_data() to io_readx() as well as to io_writex(). This fixes
> SEGFAULT on qemu_plugin_hwaddr_phys_addr() call plugins for addresses inside of
> MMIO region.
> 
> Signed-off-by: Dmitriy Solovev<d.solovev@yadro.com>
> Signed-off-by: Mikhail Tyutin<m.tyutin@yadro.com>
> Reviewed-by: Richard Henderson<richard.henderson@linaro.org>
> ---
> v3:
> - commit wording update
> 
> 
>   accel/tcg/cputlb.c | 36 +++++++++++++++++++++---------------
>   1 file changed, 21 insertions(+), 15 deletions(-)

Queued to tcg-next.


r~

