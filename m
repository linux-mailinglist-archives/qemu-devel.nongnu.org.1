Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E07DCF94
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:48:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpzr-00061A-Vm; Tue, 31 Oct 2023 10:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxpzi-0005dS-Jk
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:45:28 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxpze-0002Ts-Uq
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:45:26 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-540fb78363bso9878360a12.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763520; x=1699368320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=047RgtvcukIz4kNat8Lzm0vKAlPYTcxs4B7MYJWhp5k=;
 b=TOv1+0Zi8889niqs39eR8iDgcqd+aEcG2mGG6aC6nPqkdvjgRPvxglB8n2Wz6223rQ
 qkvkhylKrZlfLGl20tp37vSDHhLB/IwGm0WU7B1mWE6T4GqT1kTVVz+GxvPnjsZLd7qW
 vcfI9x90lifpCaoxEIKxMAeL8qEWIzA7sqVYHPSS23HidFI5NZSwvip3IdkIe/YQX2kX
 Q9J0Hgpbe8EAhWHVBh/aIRsmutxfISlD48gvPvSfMMxuQNfJsmQqBH5UAcYH0BPachFa
 XtpteTC69cl6c4jsq2E40FZIChZQQc3cqrzA9bzyh29mR3/TSzCJaSRo6U3PbAAAYtYj
 6OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763520; x=1699368320;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=047RgtvcukIz4kNat8Lzm0vKAlPYTcxs4B7MYJWhp5k=;
 b=CoGlsW3sHk3ATn62DNDYVJTTKx903oaPqtCXxN2S+E8mDY+BOC/c1Dlm1epkYlJk4x
 gS7VoKLRNLKrKJsjBS8t3JUBMb9qQE8HbAkTaONb73EuVPXx9K+00eDRFOaZJWqLINN3
 lWxAYc5CPWxmxNGssEx+AzNn4AMY/qWVuw4pe1Wof6sklYf9CVBlcuydxWSTXcTAJ+ow
 mO8KTOzPI8ZJG/hPRp//gcvIFYNmNXPOywOKLSTEJDtZ4QtxecwQ2m4qJ1hnlDleVuCW
 go9e5+WPNe4PaVhl5rtsS/wdlb/j+rOfvBl84CxbrIQmoM7UmzmiFUs41gBBTcuW0rGs
 VcuQ==
X-Gm-Message-State: AOJu0Yxk4eAgqCBwLOudU925jBSbhY6n5oFPhZXi5XWTdYVPJ9WcvpIa
 YFsqBAmcmWzTsGFQEUNCc3CyvQ==
X-Google-Smtp-Source: AGHT+IEtJ+DhzGk6ti/YuQ1f4Jmz9d5qT3on1Vy7x66/bp2N8T15oPHju5m9lHLz9maJwhF7aMjvBQ==
X-Received: by 2002:a17:907:984:b0:9c7:56ee:b6e5 with SMTP id
 bf4-20020a170907098400b009c756eeb6e5mr10989315ejc.40.1698763519808; 
 Tue, 31 Oct 2023 07:45:19 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 l11-20020a170906414b00b009b2ca104988sm1084560ejk.98.2023.10.31.07.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 07:45:19 -0700 (PDT)
Message-ID: <63c917c8-0a40-e922-45a8-105a9694f2c8@linaro.org>
Date: Tue, 31 Oct 2023 15:45:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] target/arm: Fix SVE STR increment
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20231031143215.29764-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231031143215.29764-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 31/10/23 15:32, Richard Henderson wrote:
> The previous change missed updating one of the increments and
> one of the MemOps.  Add a test case for all vector lengths.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-sve.c    |  5 ++--
>   tests/tcg/aarch64/sve-str.c       | 49 +++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/Makefile.target |  6 +++-
>   3 files changed, 57 insertions(+), 3 deletions(-)
>   create mode 100644 tests/tcg/aarch64/sve-str.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


