Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CB79FBA1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:09:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfWk-0005Hb-Nt; Thu, 14 Sep 2023 02:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfWi-0005HP-AG
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:08:32 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfWg-0006Mw-P7
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:08:32 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9ada6b0649fso79740866b.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694671708; x=1695276508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/vH/r92hPb9lkT/pHPbMrbLK6fHdXnwllQfXuAZnrk=;
 b=lOBfQ48FUpnADGlY2eBbWMU8fm7X9Q25gODrW+D7m7DqpRFkzfeMAAk8r2NpRjP+WN
 OaLvtQgW962zdJSwMsH8mi7Pwh8ROPb70rQwE2t2LYxNtefsrqm/nmC86qjJCBP/4n0F
 eOLIHxtzmG9yDzCQbRVX3qy+1Xl8k0G2/VeSVmiUGbcq5NZp00kMO93MvxW3a/apDalK
 U63Z12BD52BSpOQ1jx9J8aHAXcuGYvGiaH3dZ6NgYqYNcT9TG+cwa5ZarSKCOeeuC0w+
 oWug9ZpsCeo2FagsC2X3U/PqPrf2wOocEV/T9RbDMeMYly+OTLRZm40uWcpXKxM74iBz
 nqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694671708; x=1695276508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/vH/r92hPb9lkT/pHPbMrbLK6fHdXnwllQfXuAZnrk=;
 b=iE7nw/3znYQxBGTKLQThuc0CUBnHVDFCVXpkUXaABDSEYpA82S+30o5TBkLhc6H5GU
 hTRHM5801MfUQWsU7APuhgyiR1qwyGWNFyuFA8xmsci2TpysIW4Q/R3V26wmFkzD2BIN
 GAszSZ74EK8k8jlCK41yJB/lDnM1YQvQR8bXYWUjFycSys15zSkT5YTOC0ZMvUAkHgCm
 UZYYPMNn3FEYpDMYffQYLsWav4DrIAl2Jrmlr8zGYyasxo4ydKHJOOjt3FPtwFiqrer7
 yfiRddkqUiuXPNammECfN9faOZAqi1tf4uv7NspeipAQhw27ToeREjWNhnasWUxBxDKz
 Ldww==
X-Gm-Message-State: AOJu0YzbORVTjbGDLXmAYo0FYGnMJTF7pFTX1byo5+haa+7OY7QFl4ai
 QmCcWE+Zbkqcs6MksDOikbRdBKQTgoDqPL/OJas=
X-Google-Smtp-Source: AGHT+IGPpynd2NCV8SI92IbIQ04De9lVG5LeQAvBHECveN9YL10U8o77CBaJLGxLpMp4OFL+D8bjWQ==
X-Received: by 2002:a17:906:73c8:b0:9a1:d5de:5e3 with SMTP id
 n8-20020a17090673c800b009a1d5de05e3mr3794158ejl.54.1694671708285; 
 Wed, 13 Sep 2023 23:08:28 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 s22-20020a1709066c9600b00993a9a951fasm509349ejr.11.2023.09.13.23.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:08:27 -0700 (PDT)
Message-ID: <4de4625d-7727-18b8-0ca3-1c0fa6e481f2@linaro.org>
Date: Thu, 14 Sep 2023 08:08:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 10/24] accel/tcg: Move can_do_io to
 CPUNegativeOffsetState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 04:44, Richard Henderson wrote:
> Minimize the displacement to can_do_io, since it may
> be touched at the start of each TranslationBlock.
> It fits into other padding within the substructure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h            | 2 +-
>   accel/dummy-cpus.c               | 2 +-
>   accel/kvm/kvm-accel-ops.c        | 2 +-
>   accel/tcg/cpu-exec-common.c      | 2 +-
>   accel/tcg/cpu-exec.c             | 2 +-
>   accel/tcg/cputlb.c               | 4 ++--
>   accel/tcg/tcg-accel-ops-icount.c | 2 +-
>   accel/tcg/tcg-accel-ops-mttcg.c  | 2 +-
>   accel/tcg/tcg-accel-ops-rr.c     | 4 ++--
>   accel/tcg/translator.c           | 4 ++--
>   hw/core/cpu-common.c             | 2 +-
>   softmmu/icount.c                 | 2 +-
>   softmmu/watchpoint.c             | 2 +-
>   13 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


